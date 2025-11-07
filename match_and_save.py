import math
import pymysql
from pymysql import Error

DB_CONFIG = {
    'host'     : 'localhost',
    'port'     : 3306,
    'user'     : 'root',
    'password' : 'kathy0767!',
    'database' : 'mydb',
    'charset'  : 'utf8mb4'
}

def get_db_connection():
    try:
        return pymysql.connect(**DB_CONFIG)
    except Error as e:
        print(f"[DB 연결 오류] {e}")
        return None

def fetch_questions_and_categories(cursor):
    cursor.execute("SELECT id, category FROM Question ORDER BY id ASC")
    rows = cursor.fetchall()
    questions    = [(r['id'], r['category']) for r in rows]
    category_map = {r['id']: r['category'] for r in rows}
    return questions, category_map

def fetch_user_profile(cursor, user_email):
    cursor.execute("""
        SELECT email, age, gender, membership_grade
        FROM User
        WHERE email = %s
    """, (user_email,))
    return cursor.fetchone()

def fetch_user_answers_and_weights(cursor, user_email, questions, category_map):
    cursor.execute(
        "SELECT question_id, score FROM UserResponse WHERE user_email = %s",
        (user_email,)
    )
    answer_map = {r['question_id']: r['score'] for r in cursor.fetchall()}
    cursor.execute(
        "SELECT category, weight FROM CategoryPriority WHERE user_email = %s",
        (user_email,)
    )
    pref_map = {r['category']: r['weight'] for r in cursor.fetchall()}

    Q = len(questions)
    user_vec = [0]*Q
    weights  = [1.0]*Q
    for i, (qid, cat) in enumerate(questions):
        user_vec[i] = answer_map.get(qid, 0)
        weights[i]  = pref_map.get(cat, 1.0)
    return user_vec, weights

def fetch_candidate_emails(cursor, user_profile):
    min_age    = user_profile['age'] - 4
    max_age    = user_profile['age'] + 4
    opp_gender = 'F' if user_profile['gender']=='M' else 'M'
    cursor.execute("""
        SELECT email FROM User
         WHERE email <> %s
           AND age BETWEEN %s AND %s
           AND gender = %s
    """, (user_profile['email'], min_age, max_age, opp_gender))
    candidates = [r['email'] for r in cursor.fetchall()]
    if not candidates:
        cursor.execute("SELECT email FROM User WHERE email <> %s", (user_profile['email'],))
        candidates = [r['email'] for r in cursor.fetchall()]
    return candidates

def fetch_candidates_vectors(cursor, emails, questions):
    if not emails:
        return {}
    qid_to_idx = {qid: idx for idx, (qid, _) in enumerate(questions)}
    vectors = {email: [0]*len(questions) for email in emails}
    placeholders = ','.join(['%s']*len(emails))
    sql = f"""
        SELECT user_email, question_id, score
        FROM UserResponse
        WHERE user_email IN ({placeholders})
    """
    cursor.execute(sql, tuple(emails))
    for r in cursor.fetchall():
        idx = qid_to_idx.get(r['question_id'])
        if idx is not None:
            vectors[r['user_email']][idx] = r['score']
    return vectors

def l2_normalize(vec):
    norm = math.sqrt(sum(v*v for v in vec))
    if norm == 0:
        return [0.0]*len(vec)
    return [v/norm for v in vec]

def cosine_similarity(v1, v2):
    return sum(a*b for a, b in zip(v1, v2))

def generate_summary_text(match_info):
    partner = match_info['match_email']
    cat_scores = {
        '생활 패턴':   match_info['score_lifestyle'],
        '가치관':      match_info['score_values'],
        '연애 성향':   match_info['score_romance'],
        '선호도':      match_info['score_preference'],
    }
    sorted_cats = sorted(cat_scores.items(), key=lambda x: x[1], reverse=True)
    (c1, s1), (c2, s2) = sorted_cats[0], sorted_cats[1]
    return (f"당신과 잘 맞는 상대는 {partner}입니다. "
            f"특히 {c1}({s1:.1f})과 {c2}({s2:.1f})에서 높은 유사도를 보였습니다.")

def _do_matching_and_insert(cursor, user_email):
    questions, category_map = fetch_questions_and_categories(cursor)
    user_profile = fetch_user_profile(cursor, user_email)
    if not user_profile:
        return None

    user_vec, weights = fetch_user_answers_and_weights(cursor, user_email, questions, category_map)
    weighted = [s*w for s,w in zip(user_vec, weights)]
    user_norm = l2_normalize(weighted)
    if user_norm is None:
        return None

    candidates = fetch_candidate_emails(cursor, user_profile)
    cand_vectors = fetch_candidates_vectors(cursor, candidates, questions)
    if not candidates:
        return None

    cats = ['lifestyle','values','romance','preference']
    user_cat = {cat:0 for cat in cats}
    for i, raw in enumerate(user_vec):
        cat = category_map[questions[i][0]]
        user_cat[cat] += raw * weights[i]

    best_score = -1
    best_cand  = None
    best_cat_scores = None
    for email in candidates:
        raw_vec = cand_vectors[email]
        cand_cat = {cat:0 for cat in cats}
        for i, raw in enumerate(raw_vec):
            cat = category_map[questions[i][0]]
            cand_cat[cat] += raw * weights[i]

        sim = cosine_similarity(
            l2_normalize(list(user_cat.values())),
            l2_normalize(list(cand_cat.values()))
        )
        if sim > best_score:
            best_score     = sim
            best_cand      = email
            best_cat_scores= cand_cat

    if not best_cand:
        return None

    cursor.execute("""
        INSERT INTO MatchResult
          (user_email, match_email,
           score_lifestyle, score_values, score_romance, score_preference,
           total_score)
        VALUES (%s,%s,%s,%s,%s,%s,%s)
    """, (
        user_email, best_cand,
        best_cat_scores['lifestyle'],
        best_cat_scores['values'],
        best_cat_scores['romance'],
        best_cat_scores['preference'],
        best_score
    ))
    return cursor.lastrowid

def match_and_save(user_email):
    conn = get_db_connection()
    if not conn:
        return None
    try:
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        new_id = _do_matching_and_insert(cursor, user_email)
        if not new_id:
            conn.rollback()
            return None

        cursor.execute("SELECT * FROM MatchResult WHERE id = %s", (new_id,))
        mr = cursor.fetchone()
        summary = generate_summary_text(mr)

        cursor.execute("""
            INSERT INTO MatchReport(match_id, recipient_email, summary_text)
            VALUES(%s,%s,%s)
        """, (new_id, user_email, summary))
        conn.commit()
        return new_id
    except Error as e:
        print(f"[DB 오류] {e}")
        conn.rollback()
        return None
    finally:
        conn.close()
