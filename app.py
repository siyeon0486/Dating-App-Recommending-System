from flask import Flask, render_template, request, redirect, url_for, session
import pymysql
from datetime import datetime
from pymysql import cursors
from match_and_save import match_and_save, get_db_connection

app = Flask(__name__)
app.secret_key = 'dev'

def calculate_age(birth_str):
    birth_date = datetime.strptime(birth_str, "%Y-%m-%d")
    today = datetime.today()
    return today.year - birth_date.year - (
        (today.month, today.day) < (birth_date.month, birth_date.day)
    )

# ───────────────────────────────────────────
# 1) 메인 페이지 (함수명을 main 으로 변경)
# ───────────────────────────────────────────
@app.route('/', methods=['GET', 'POST'])
def main():
    if request.method == 'POST':
        session['user_email'] = request.form.get('email')
        return redirect(url_for('survey1'))
    return render_template('main.html')

# 로그인 페이지
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')  # 실전에서는 암호화 검증 필요

        conn = get_db_connection()
        cursor = conn.cursor()
        sql = "SELECT email FROM User WHERE email = %s"
        cursor.execute(sql, (email,))
        result = cursor.fetchone()
        cursor.close()
        conn.close()

        if result:  # 간단한 로그인 성공 처리
            session['user_email'] = email
            return redirect(url_for('survey1'))  # 로그인 성공 시 메인 페이지로
        else:
            return render_template('loginpage.html', error="❌ 로그인 실패: 존재하지 않는 이메일입니다.")

    return render_template('loginpage.html')

# ───────────────────────────────────────────
# 2) 회원가입
# ───────────────────────────────────────────
@app.route('/userinfo', methods=['GET', 'POST'])
def userinfo():
    if request.method == 'POST':
        gender_raw       = request.form['gender']
        gender           = 'M' if gender_raw == 'male' else 'F'
        birth            = request.form['birth']
        age              = calculate_age(birth)
        region           = request.form['region']
        major            = request.form['major']
        email            = request.form['email']
        membership_grade = 'Basic'
        is_active        = 1
        created_at       = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

        session['user_email'] = email

        conn = get_db_connection()
        try:
            with conn.cursor() as cursor:
                cursor.execute("""
                    INSERT INTO `User`
                      (email, gender, age, region, major,
                       membership_grade, is_active, created_at)
                    VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
                """, (
                    email, gender, age, region, major,
                    membership_grade, is_active, created_at
                ))
            conn.commit()
        finally:
            conn.close()

        return redirect(url_for('survey1'))

    return render_template('userinfo.html')

# ───────────────────────────────────────────
# 3) 설문1: 생활패턴 (1~6)
# ───────────────────────────────────────────
@app.route('/survey1', methods=['GET', 'POST'])
def survey1():
    if request.method == 'POST':
        email = session.get('user_email')
        if not email:
            return redirect(url_for('main'))
        now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        conn = get_db_connection()
        try:
            with conn.cursor() as cursor:
                cursor.execute("DELETE FROM userresponse WHERE user_email=%s", (email,))
                for i in range(1,7):
                    score = request.form.get(f'q{i}')
                    if score:
                        cursor.execute("""
                            INSERT INTO userresponse
                              (user_email, question_id, score, answered_at)
                            VALUES (%s,%s,%s,%s)
                        """, (email, i, score, now))
            conn.commit()
        finally:
            conn.close()
        return redirect(url_for('survey2'))
    return render_template('surveyp1.html')

# ───────────────────────────────────────────
# 4) 설문2: 가치관 (7~12)
# ───────────────────────────────────────────
@app.route('/survey2', methods=['GET', 'POST'])
def survey2():
    if request.method == 'POST':
        email = session.get('user_email')
        if not email:
            return redirect(url_for('main'))
        now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        conn = get_db_connection()
        try:
            with conn.cursor() as cursor:
                cursor.execute("""
                    DELETE FROM userresponse
                     WHERE user_email=%s
                       AND question_id BETWEEN 7 AND 12
                """, (email,))
                for i in range(1,7):
                    score = request.form.get(f'q{i}')
                    if score:
                        cursor.execute("""
                            INSERT INTO userresponse
                              (user_email, question_id, score, answered_at)
                            VALUES (%s,%s,%s,%s)
                        """, (email, i+6, score, now))
            conn.commit()
        finally:
            conn.close()
        return redirect(url_for('survey3'))
    return render_template('surveyp2.html')

# ───────────────────────────────────────────
# 5) 설문3: 취향 (13~17)
# ───────────────────────────────────────────
@app.route('/survey3', methods=['GET', 'POST'])
def survey3():
    if request.method == 'POST':
        email = session.get('user_email')
        if not email:
            return redirect(url_for('main'))
        now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        conn = get_db_connection()
        try:
            with conn.cursor() as cursor:
                cursor.execute("""
                    DELETE FROM userresponse
                     WHERE user_email=%s
                       AND question_id BETWEEN 13 AND 17
                """, (email,))
                for i in range(1,6):
                    score = request.form.get(f'q{i}')
                    if score:
                        cursor.execute("""
                            INSERT INTO userresponse
                              (user_email, question_id, score, answered_at)
                            VALUES (%s,%s,%s,%s)
                        """, (email, i+12, score, now))
            conn.commit()
        finally:
            conn.close()
        return redirect(url_for('survey4'))
    return render_template('surveyp3.html')

# ───────────────────────────────────────────
# 6) 설문4: 가치관2 (18~23)
# ───────────────────────────────────────────
@app.route('/survey4', methods=['GET','POST'])
def survey4():
    if request.method == 'POST':
        email = session.get('user_email')
        if not email:
            return redirect(url_for('main'))
        now  = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        conn = get_db_connection()
        try:
            with conn.cursor() as cursor:
                cursor.execute("""
                    DELETE FROM userresponse
                     WHERE user_email=%s
                       AND question_id BETWEEN 18 AND 23
                """, (email,))
                for i in range(1, 7):
                    score = request.form.get(f'q{i}')
                    if score:
                        cursor.execute("""
                            INSERT INTO userresponse
                              (user_email, question_id, score, answered_at)
                            VALUES (%s,%s,%s,%s)
                        """, (email, i+17, score, now))
            conn.commit()
        finally:
            conn.close()
        return redirect(url_for('matchingresult'))
    return render_template('surveyp4.html')

@app.route('/matchingresult')
def matchingresult():
    user_email = session.get('user_email')
    if not user_email:
        return redirect(url_for('main'))

    # 1) 매칭 로직 실행 & 저장
    match_id = match_and_save(user_email)
    if not match_id:
        return render_template('matchingresult.html',
                               error="⚠️ 매칭 가능한 후보자가 없습니다.")

    # 2) DB에서 결과와 원시(raw)점수 조회
    conn   = get_db_connection()
    cursor = conn.cursor(cursors.DictCursor)
    cursor.execute("""
        SELECT
          u.email            AS user_name,
          mr.match_email     AS match_name,
          mr.score_lifestyle AS raw_lifestyle,
          mr.score_values    AS raw_values,
          mr.score_romance   AS raw_romance,
          mr.score_preference AS raw_preference,
          mr.total_score     AS total_cosine
        FROM MatchResult mr
        JOIN MatchReport rpt
          ON rpt.match_id = mr.id
         AND rpt.recipient_email = %s
        JOIN `User` u
          ON u.email = mr.user_email
        WHERE mr.id = %s
    """, (user_email, match_id))
    row = cursor.fetchone()
    cursor.close()
    conn.close()

    if not row:
        return render_template('matchingresult.html',
                               error="⚠️ 저장된 매칭 정보를 찾을 수 없습니다.")

    # 3) 카테고리별 질문 개수 조회
    conn2 = get_db_connection()
    cur2  = conn2.cursor(cursors.DictCursor)
    cur2.execute("SELECT category, COUNT(*) AS cnt FROM Question GROUP BY category")
    cnts = {r['category']: r['cnt'] for r in cur2.fetchall()}
    cur2.execute("SELECT category, weight FROM CategoryPriority WHERE user_email=%s",
                 (user_email,))
    weights = {r['category']: r['weight'] for r in cur2.fetchall()}
    cur2.close()
    conn2.close()

    # 4) raw 점수 → 0~100%로 변환
    raw = {
        'lifestyle':  row['raw_lifestyle'],
        'values':     row['raw_values'],
        'romance':    row['raw_romance'],
        'preference': row['raw_preference']
    }
    pct = {}
    for cat, raw_score in raw.items():
        max_possible = cnts.get(cat,0) * 5 * weights.get(cat,1.0)
        pct[cat] = round(raw_score / max_possible * 100, 1) if max_possible else 0

    total_score_pct = round(
        ( pct['lifestyle']
        + pct['values']
        + pct['romance']
        + pct['preference'] )
      / 4,
      1
    )

    # 5) 템플릿 렌더
    return render_template('matchingresult.html',
        user_name       = row['user_name'],
        match_name      = row['match_name'],
        match_contact   = row['match_name'],
        lifestyle_pct   = pct['lifestyle'],
        values_pct      = pct['values'],
        romance_pct     = pct['romance'],
        preference_pct  = pct['preference'],
        total_score_pct = total_score_pct
    )

if __name__ == '__main__':
    app.run(debug=True)