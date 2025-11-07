-- MySQL dump 10.13  Distrib 8.0.42, for macos15 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `CategoryPriority`
--

DROP TABLE IF EXISTS `CategoryPriority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CategoryPriority` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(255) DEFAULT NULL,
  `category` enum('lifestyle','values','romance','preference') NOT NULL,
  `weight` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email` (`user_email`,`category`),
  CONSTRAINT `categorypriority_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `User` (`email`),
  CONSTRAINT `categorypriority_chk_1` CHECK ((`weight` between 0.1 and 5.0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CategoryPriority`
--

LOCK TABLES `CategoryPriority` WRITE;
/*!40000 ALTER TABLE `CategoryPriority` DISABLE KEYS */;
INSERT INTO `CategoryPriority` VALUES (1,'eunji565@naver.com','lifestyle',4),(2,'eunji565@naver.com','romance',3),(3,'eunji565@naver.com','preference',2),(4,'eunji565@naver.com','values',1),(5,'jaewon784@daum.net','values',4),(6,'jaewon784@daum.net','lifestyle',3),(7,'jaewon784@daum.net','romance',2),(8,'jaewon784@daum.net','preference',1);
/*!40000 ALTER TABLE `CategoryPriority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MatchReport`
--

DROP TABLE IF EXISTS `MatchReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MatchReport` (
  `id` int NOT NULL AUTO_INCREMENT,
  `match_id` int DEFAULT NULL,
  `recipient_email` varchar(255) DEFAULT NULL,
  `summary_text` text,
  `sent_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `match_id` (`match_id`),
  KEY `recipient_email` (`recipient_email`),
  CONSTRAINT `matchreport_ibfk_1` FOREIGN KEY (`match_id`) REFERENCES `MatchResult` (`id`),
  CONSTRAINT `matchreport_ibfk_2` FOREIGN KEY (`recipient_email`) REFERENCES `User` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MatchReport`
--

LOCK TABLES `MatchReport` WRITE;
/*!40000 ALTER TABLE `MatchReport` DISABLE KEYS */;
/*!40000 ALTER TABLE `MatchReport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MatchResult`
--

DROP TABLE IF EXISTS `MatchResult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MatchResult` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(255) DEFAULT NULL,
  `match_email` varchar(255) DEFAULT NULL,
  `score_lifestyle` float DEFAULT NULL,
  `score_values` float DEFAULT NULL,
  `score_romance` float DEFAULT NULL,
  `score_preference` float DEFAULT NULL,
  `total_score` float DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_email` (`user_email`),
  KEY `match_email` (`match_email`),
  CONSTRAINT `matchresult_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `User` (`email`),
  CONSTRAINT `matchresult_ibfk_2` FOREIGN KEY (`match_email`) REFERENCES `User` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MatchResult`
--

LOCK TABLES `MatchResult` WRITE;
/*!40000 ALTER TABLE `MatchResult` DISABLE KEYS */;
/*!40000 ALTER TABLE `MatchResult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Question`
--

DROP TABLE IF EXISTS `Question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` enum('lifestyle','values','romance','preference') NOT NULL,
  `text` text NOT NULL,
  `direction` enum('S','O') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Question`
--

LOCK TABLES `Question` WRITE;
/*!40000 ALTER TABLE `Question` DISABLE KEYS */;
INSERT INTO `Question` VALUES (1,'lifestyle','나는 연인과 일상적인 일들을 자주 공유하는 편이다.','S'),(2,'lifestyle','나는 아침보다 밤에 더 활발하게 활동하는 편이다.','S'),(3,'lifestyle','나는 흡연을 자주 하는 편이다.','S'),(4,'lifestyle','나는 일주일에 2회 이상 꾸준히 운동한다.','S'),(5,'lifestyle','나는 술자리를 즐기는 편이다.','S'),(6,'lifestyle','나는 소비를 계획적으로 하는 편이다.','S'),(7,'lifestyle','나는 집이나 개인 공간의 청결을 중요하게 생각한다.','S'),(8,'values','나는 종교 활동에 적극적으로 참여하는 편이다.','S'),(9,'values','나는 연애 상대의 종교 유무를 중요한 기준으로 생각한다.','S'),(10,'values','나는 계획 없이 즉흥적으로 움직이는 것을 즐긴다.','S'),(11,'values','나는 계획이 틀어지면 스트레스를 크게 받는다.','S'),(12,'values','나는 사람들과 어울리는 것에서 에너지를 얻는다.','S'),(13,'values','나는 자신의 삶이 우선이다 0 | 일/커리어가 우선이다 5','S'),(14,'romance','연인의 질투나 간섭은 애정 표현의 일부라고 생각한다.','S'),(15,'romance','나는 연인과 자주 연락하는 것이 중요하다고 느낀다.','S'),(16,'romance','나는 갈등이 생기면 먼저 사과하려 노력하는 편이다.','O'),(17,'romance','나는 데이트할 때 꾸미는 편이다.','S'),(18,'romance','나는 식사할 때 예의나 매너를 중요하게 본다.','S'),(19,'romance','나는 SNS에 나의 일상이나 연애를 자주 공유하는 편이다.','S'),(20,'preference','나는 조용한 카페나 공원 같은 공간을 선호한다 0 | 사람이 많은 곳을 선호한다 5','S'),(21,'preference','나는 새로운 음식이나 문화를 경험하는 것을 즐긴다.','O'),(22,'preference','나는 활동적인 취미를 가지고 있다.','S'),(23,'preference','나는 여행을 자주 다니는 라이프스타일에 끌린다.','S'),(24,'preference','나는 깊은 대화를 나눌 수 있는 사람과 잘 맞는다.','S');
/*!40000 ALTER TABLE `Question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `email` varchar(255) NOT NULL,
  `gender` enum('M','F','O') NOT NULL,
  `age` int NOT NULL,
  `region` varchar(100) DEFAULT NULL,
  `major` varchar(100) DEFAULT NULL,
  `membership_grade` enum('Basic','Plus','Premium') DEFAULT 'Basic',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('donghyun328@gmail.com','M',27,'서울 마포구','미디어학과','Basic',1,'2025-06-06 07:50:23'),('eunji565@naver.com','F',22,'서울 송파구','수학과','Premium',1,'2025-06-06 07:50:23'),('hana954@daum.net','F',21,'서울 강남구','경영학과','Basic',1,'2025-06-06 07:50:23'),('hyejin674@gmail.com','F',25,'서울 강서구','미디어학과','Basic',1,'2025-06-06 07:50:23'),('hyunwoo502@gmail.com','M',24,'서울 송파구','심리학과','Basic',1,'2025-06-06 07:50:23'),('jaewon784@daum.net','M',21,'서울 종로구','경영학과','Premium',1,'2025-06-06 07:50:23'),('jieun732@naver.com','F',23,'서울 마포구','영문학과','Basic',1,'2025-06-06 07:50:23'),('jiho195@naver.com','M',25,'서울 종로구','심리학과','Plus',1,'2025-06-06 07:50:23'),('kyuhwan282@daum.net','M',20,'서울 마포구','경제학과','Basic',1,'2025-06-06 07:50:23'),('minji813@naver.com','F',24,'서울 종로구','경제학과','Basic',1,'2025-06-06 07:50:23'),('minjoon832@gmail.com','M',23,'서울 송파구','경제학과','Basic',1,'2025-06-06 07:50:23'),('nara205@daum.net','F',20,'서울 강남구','영문학과','Basic',1,'2025-06-06 07:50:23'),('sangho157@gmail.com','M',22,'서울 강서구','컴퓨터공학과','Plus',1,'2025-06-06 07:50:23'),('seoyeon721@daum.net','F',28,'서울 마포구','심리학과','Plus',1,'2025-06-06 07:50:23'),('seunghyun667@daum.net','M',22,'서울 강남구','컴퓨터공학과','Basic',1,'2025-06-06 07:50:23'),('seungwoo631@naver.com','M',28,'서울 강남구','영문학과','Basic',1,'2025-06-06 07:50:23'),('soomin411@gmail.com','F',27,'서울 송파구','컴퓨터공학과','Plus',1,'2025-06-06 07:50:23'),('subin399@gmail.com','F',26,'서울 종로구','경영학과','Basic',1,'2025-06-06 07:50:23'),('taehoon946@naver.com','M',26,'서울 강서구','수학과','Basic',1,'2025-06-06 07:50:23'),('yuna487@naver.com','F',24,'서울 강서구','컴퓨터공학과','Basic',1,'2025-06-06 07:50:23');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserResponse`
--

DROP TABLE IF EXISTS `UserResponse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserResponse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_email` varchar(255) DEFAULT NULL,
  `question_id` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  `answered_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email` (`user_email`,`question_id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `userresponse_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `User` (`email`),
  CONSTRAINT `userresponse_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `Question` (`id`),
  CONSTRAINT `userresponse_chk_1` CHECK ((`score` between 0 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserResponse`
--

LOCK TABLES `UserResponse` WRITE;
/*!40000 ALTER TABLE `UserResponse` DISABLE KEYS */;
INSERT INTO `UserResponse` VALUES (1,'jieun732@naver.com',1,5,'2025-06-06 07:51:20'),(2,'jieun732@naver.com',2,4,'2025-06-06 07:51:20'),(3,'jieun732@naver.com',3,2,'2025-06-06 07:51:20'),(4,'jieun732@naver.com',4,5,'2025-06-06 07:51:20'),(5,'jieun732@naver.com',5,3,'2025-06-06 07:51:20'),(6,'jieun732@naver.com',6,4,'2025-06-06 07:51:20'),(7,'jieun732@naver.com',7,5,'2025-06-06 07:51:20'),(8,'jieun732@naver.com',8,3,'2025-06-06 07:51:20'),(9,'jieun732@naver.com',9,4,'2025-06-06 07:51:20'),(10,'jieun732@naver.com',10,2,'2025-06-06 07:51:20'),(11,'jieun732@naver.com',11,4,'2025-06-06 07:51:20'),(12,'jieun732@naver.com',12,3,'2025-06-06 07:51:20'),(13,'jieun732@naver.com',13,4,'2025-06-06 07:51:20'),(14,'jieun732@naver.com',14,5,'2025-06-06 07:51:20'),(15,'jieun732@naver.com',15,3,'2025-06-06 07:51:20'),(16,'jieun732@naver.com',16,4,'2025-06-06 07:51:20'),(17,'jieun732@naver.com',17,5,'2025-06-06 07:51:20'),(18,'jieun732@naver.com',18,4,'2025-06-06 07:51:20'),(19,'jieun732@naver.com',19,2,'2025-06-06 07:51:20'),(20,'jieun732@naver.com',20,3,'2025-06-06 07:51:20'),(21,'jieun732@naver.com',21,4,'2025-06-06 07:51:20'),(22,'jieun732@naver.com',22,5,'2025-06-06 07:51:20'),(23,'jieun732@naver.com',23,3,'2025-06-06 07:51:20'),(24,'jieun732@naver.com',24,4,'2025-06-06 07:51:20'),(25,'soomin411@gmail.com',1,4,'2025-06-06 07:51:20'),(26,'soomin411@gmail.com',2,3,'2025-06-06 07:51:20'),(27,'soomin411@gmail.com',3,5,'2025-06-06 07:51:20'),(28,'soomin411@gmail.com',4,4,'2025-06-06 07:51:20'),(29,'soomin411@gmail.com',5,3,'2025-06-06 07:51:20'),(30,'soomin411@gmail.com',6,2,'2025-06-06 07:51:20'),(31,'soomin411@gmail.com',7,4,'2025-06-06 07:51:20'),(32,'soomin411@gmail.com',8,3,'2025-06-06 07:51:20'),(33,'soomin411@gmail.com',9,4,'2025-06-06 07:51:20'),(34,'soomin411@gmail.com',10,5,'2025-06-06 07:51:20'),(35,'soomin411@gmail.com',11,3,'2025-06-06 07:51:20'),(36,'soomin411@gmail.com',12,2,'2025-06-06 07:51:20'),(37,'soomin411@gmail.com',13,4,'2025-06-06 07:51:20'),(38,'soomin411@gmail.com',14,3,'2025-06-06 07:51:20'),(39,'soomin411@gmail.com',15,4,'2025-06-06 07:51:20'),(40,'soomin411@gmail.com',16,5,'2025-06-06 07:51:20'),(41,'soomin411@gmail.com',17,3,'2025-06-06 07:51:20'),(42,'soomin411@gmail.com',18,2,'2025-06-06 07:51:20'),(43,'soomin411@gmail.com',19,4,'2025-06-06 07:51:20'),(44,'soomin411@gmail.com',20,3,'2025-06-06 07:51:20'),(45,'soomin411@gmail.com',21,5,'2025-06-06 07:51:20'),(46,'soomin411@gmail.com',22,4,'2025-06-06 07:51:20'),(47,'soomin411@gmail.com',23,3,'2025-06-06 07:51:20'),(48,'soomin411@gmail.com',24,2,'2025-06-06 07:51:20'),(49,'hana954@daum.net',1,3,'2025-06-06 07:51:20'),(50,'hana954@daum.net',2,4,'2025-06-06 07:51:20'),(51,'hana954@daum.net',3,5,'2025-06-06 07:51:20'),(52,'hana954@daum.net',4,2,'2025-06-06 07:51:20'),(53,'hana954@daum.net',5,3,'2025-06-06 07:51:20'),(54,'hana954@daum.net',6,4,'2025-06-06 07:51:20'),(55,'hana954@daum.net',7,5,'2025-06-06 07:51:20'),(56,'hana954@daum.net',8,4,'2025-06-06 07:51:20'),(57,'hana954@daum.net',9,3,'2025-06-06 07:51:20'),(58,'hana954@daum.net',10,5,'2025-06-06 07:51:20'),(59,'hana954@daum.net',11,2,'2025-06-06 07:51:20'),(60,'hana954@daum.net',12,4,'2025-06-06 07:51:20'),(61,'hana954@daum.net',13,3,'2025-06-06 07:51:20'),(62,'hana954@daum.net',14,5,'2025-06-06 07:51:20'),(63,'hana954@daum.net',15,4,'2025-06-06 07:51:20'),(64,'hana954@daum.net',16,3,'2025-06-06 07:51:20'),(65,'hana954@daum.net',17,5,'2025-06-06 07:51:20'),(66,'hana954@daum.net',18,4,'2025-06-06 07:51:20'),(67,'hana954@daum.net',19,3,'2025-06-06 07:51:20'),(68,'hana954@daum.net',20,5,'2025-06-06 07:51:20'),(69,'hana954@daum.net',21,4,'2025-06-06 07:51:20'),(70,'hana954@daum.net',22,3,'2025-06-06 07:51:20'),(71,'hana954@daum.net',23,5,'2025-06-06 07:51:20'),(72,'hana954@daum.net',24,4,'2025-06-06 07:51:20'),(73,'minji813@naver.com',1,5,'2025-06-06 07:51:20'),(74,'minji813@naver.com',2,5,'2025-06-06 07:51:20'),(75,'minji813@naver.com',3,4,'2025-06-06 07:51:20'),(76,'minji813@naver.com',4,3,'2025-06-06 07:51:20'),(77,'minji813@naver.com',5,4,'2025-06-06 07:51:20'),(78,'minji813@naver.com',6,5,'2025-06-06 07:51:20'),(79,'minji813@naver.com',7,2,'2025-06-06 07:51:20'),(80,'minji813@naver.com',8,4,'2025-06-06 07:51:20'),(81,'minji813@naver.com',9,3,'2025-06-06 07:51:20'),(82,'minji813@naver.com',10,5,'2025-06-06 07:51:20'),(83,'minji813@naver.com',11,4,'2025-06-06 07:51:20'),(84,'minji813@naver.com',12,5,'2025-06-06 07:51:20'),(85,'minji813@naver.com',13,3,'2025-06-06 07:51:20'),(86,'minji813@naver.com',14,4,'2025-06-06 07:51:20'),(87,'minji813@naver.com',15,5,'2025-06-06 07:51:20'),(88,'minji813@naver.com',16,3,'2025-06-06 07:51:20'),(89,'minji813@naver.com',17,4,'2025-06-06 07:51:20'),(90,'minji813@naver.com',18,2,'2025-06-06 07:51:20'),(91,'minji813@naver.com',19,5,'2025-06-06 07:51:20'),(92,'minji813@naver.com',20,4,'2025-06-06 07:51:20'),(93,'minji813@naver.com',21,3,'2025-06-06 07:51:20'),(94,'minji813@naver.com',22,5,'2025-06-06 07:51:20'),(95,'minji813@naver.com',23,4,'2025-06-06 07:51:20'),(96,'minji813@naver.com',24,5,'2025-06-06 07:51:20'),(97,'hyejin674@gmail.com',1,2,'2025-06-06 07:51:20'),(98,'hyejin674@gmail.com',2,3,'2025-06-06 07:51:20'),(99,'hyejin674@gmail.com',3,4,'2025-06-06 07:51:20'),(100,'hyejin674@gmail.com',4,5,'2025-06-06 07:51:20'),(101,'hyejin674@gmail.com',5,4,'2025-06-06 07:51:20'),(102,'hyejin674@gmail.com',6,3,'2025-06-06 07:51:20'),(103,'hyejin674@gmail.com',7,5,'2025-06-06 07:51:20'),(104,'hyejin674@gmail.com',8,2,'2025-06-06 07:51:20'),(105,'hyejin674@gmail.com',9,4,'2025-06-06 07:51:20'),(106,'hyejin674@gmail.com',10,3,'2025-06-06 07:51:20'),(107,'hyejin674@gmail.com',11,5,'2025-06-06 07:51:20'),(108,'hyejin674@gmail.com',12,2,'2025-06-06 07:51:20'),(109,'hyejin674@gmail.com',13,4,'2025-06-06 07:51:20'),(110,'hyejin674@gmail.com',14,3,'2025-06-06 07:51:20'),(111,'hyejin674@gmail.com',15,5,'2025-06-06 07:51:20'),(112,'hyejin674@gmail.com',16,4,'2025-06-06 07:51:20'),(113,'hyejin674@gmail.com',17,3,'2025-06-06 07:51:20'),(114,'hyejin674@gmail.com',18,5,'2025-06-06 07:51:20'),(115,'hyejin674@gmail.com',19,4,'2025-06-06 07:51:20'),(116,'hyejin674@gmail.com',20,2,'2025-06-06 07:51:20'),(117,'hyejin674@gmail.com',21,5,'2025-06-06 07:51:20'),(118,'hyejin674@gmail.com',22,3,'2025-06-06 07:51:20'),(119,'hyejin674@gmail.com',23,4,'2025-06-06 07:51:20'),(120,'hyejin674@gmail.com',24,5,'2025-06-06 07:51:20'),(121,'seoyeon721@daum.net',1,4,'2025-06-06 07:51:20'),(122,'seoyeon721@daum.net',2,5,'2025-06-06 07:51:20'),(123,'seoyeon721@daum.net',3,3,'2025-06-06 07:51:20'),(124,'seoyeon721@daum.net',4,4,'2025-06-06 07:51:20'),(125,'seoyeon721@daum.net',5,5,'2025-06-06 07:51:20'),(126,'seoyeon721@daum.net',6,4,'2025-06-06 07:51:20'),(127,'seoyeon721@daum.net',7,3,'2025-06-06 07:51:20'),(128,'seoyeon721@daum.net',8,5,'2025-06-06 07:51:20'),(129,'seoyeon721@daum.net',9,4,'2025-06-06 07:51:20'),(130,'seoyeon721@daum.net',10,2,'2025-06-06 07:51:20'),(131,'seoyeon721@daum.net',11,4,'2025-06-06 07:51:20'),(132,'seoyeon721@daum.net',12,3,'2025-06-06 07:51:20'),(133,'seoyeon721@daum.net',13,5,'2025-06-06 07:51:20'),(134,'seoyeon721@daum.net',14,4,'2025-06-06 07:51:20'),(135,'seoyeon721@daum.net',15,3,'2025-06-06 07:51:20'),(136,'seoyeon721@daum.net',16,5,'2025-06-06 07:51:20'),(137,'seoyeon721@daum.net',17,4,'2025-06-06 07:51:20'),(138,'seoyeon721@daum.net',18,2,'2025-06-06 07:51:20'),(139,'seoyeon721@daum.net',19,5,'2025-06-06 07:51:20'),(140,'seoyeon721@daum.net',20,3,'2025-06-06 07:51:20'),(141,'seoyeon721@daum.net',21,4,'2025-06-06 07:51:20'),(142,'seoyeon721@daum.net',22,5,'2025-06-06 07:51:20'),(143,'seoyeon721@daum.net',23,3,'2025-06-06 07:51:20'),(144,'seoyeon721@daum.net',24,4,'2025-06-06 07:51:20'),(145,'eunji565@naver.com',1,5,'2025-06-06 07:51:20'),(146,'eunji565@naver.com',2,3,'2025-06-06 07:51:20'),(147,'eunji565@naver.com',3,4,'2025-06-06 07:51:20'),(148,'eunji565@naver.com',4,2,'2025-06-06 07:51:20'),(149,'eunji565@naver.com',5,3,'2025-06-06 07:51:20'),(150,'eunji565@naver.com',6,4,'2025-06-06 07:51:20'),(151,'eunji565@naver.com',7,5,'2025-06-06 07:51:20'),(152,'eunji565@naver.com',8,4,'2025-06-06 07:51:20'),(153,'eunji565@naver.com',9,5,'2025-06-06 07:51:20'),(154,'eunji565@naver.com',10,3,'2025-06-06 07:51:20'),(155,'eunji565@naver.com',11,4,'2025-06-06 07:51:20'),(156,'eunji565@naver.com',12,5,'2025-06-06 07:51:20'),(157,'eunji565@naver.com',13,2,'2025-06-06 07:51:20'),(158,'eunji565@naver.com',14,3,'2025-06-06 07:51:20'),(159,'eunji565@naver.com',15,5,'2025-06-06 07:51:20'),(160,'eunji565@naver.com',16,4,'2025-06-06 07:51:20'),(161,'eunji565@naver.com',17,3,'2025-06-06 07:51:20'),(162,'eunji565@naver.com',18,5,'2025-06-06 07:51:20'),(163,'eunji565@naver.com',19,4,'2025-06-06 07:51:20'),(164,'eunji565@naver.com',20,2,'2025-06-06 07:51:20'),(165,'eunji565@naver.com',21,5,'2025-06-06 07:51:20'),(166,'eunji565@naver.com',22,4,'2025-06-06 07:51:20'),(167,'eunji565@naver.com',23,3,'2025-06-06 07:51:20'),(168,'eunji565@naver.com',24,5,'2025-06-06 07:51:20'),(169,'subin399@gmail.com',1,2,'2025-06-06 07:51:20'),(170,'subin399@gmail.com',2,3,'2025-06-06 07:51:20'),(171,'subin399@gmail.com',3,4,'2025-06-06 07:51:20'),(172,'subin399@gmail.com',4,5,'2025-06-06 07:51:20'),(173,'subin399@gmail.com',5,4,'2025-06-06 07:51:20'),(174,'subin399@gmail.com',6,3,'2025-06-06 07:51:20'),(175,'subin399@gmail.com',7,2,'2025-06-06 07:51:20'),(176,'subin399@gmail.com',8,4,'2025-06-06 07:51:20'),(177,'subin399@gmail.com',9,3,'2025-06-06 07:51:20'),(178,'subin399@gmail.com',10,5,'2025-06-06 07:51:20'),(179,'subin399@gmail.com',11,4,'2025-06-06 07:51:20'),(180,'subin399@gmail.com',12,3,'2025-06-06 07:51:20'),(181,'subin399@gmail.com',13,5,'2025-06-06 07:51:20'),(182,'subin399@gmail.com',14,4,'2025-06-06 07:51:20'),(183,'subin399@gmail.com',15,2,'2025-06-06 07:51:20'),(184,'subin399@gmail.com',16,5,'2025-06-06 07:51:20'),(185,'subin399@gmail.com',17,4,'2025-06-06 07:51:20'),(186,'subin399@gmail.com',18,3,'2025-06-06 07:51:20'),(187,'subin399@gmail.com',19,5,'2025-06-06 07:51:20'),(188,'subin399@gmail.com',20,4,'2025-06-06 07:51:20'),(189,'subin399@gmail.com',21,3,'2025-06-06 07:51:20'),(190,'subin399@gmail.com',22,5,'2025-06-06 07:51:20'),(191,'subin399@gmail.com',23,4,'2025-06-06 07:51:20'),(192,'subin399@gmail.com',24,2,'2025-06-06 07:51:20'),(193,'nara205@daum.net',1,4,'2025-06-06 07:51:20'),(194,'nara205@daum.net',2,5,'2025-06-06 07:51:20'),(195,'nara205@daum.net',3,3,'2025-06-06 07:51:20'),(196,'nara205@daum.net',4,4,'2025-06-06 07:51:20'),(197,'nara205@daum.net',5,3,'2025-06-06 07:51:20'),(198,'nara205@daum.net',6,5,'2025-06-06 07:51:20'),(199,'nara205@daum.net',7,4,'2025-06-06 07:51:20'),(200,'nara205@daum.net',8,2,'2025-06-06 07:51:20'),(201,'nara205@daum.net',9,5,'2025-06-06 07:51:20'),(202,'nara205@daum.net',10,3,'2025-06-06 07:51:20'),(203,'nara205@daum.net',11,4,'2025-06-06 07:51:20'),(204,'nara205@daum.net',12,5,'2025-06-06 07:51:20'),(205,'nara205@daum.net',13,2,'2025-06-06 07:51:20'),(206,'nara205@daum.net',14,3,'2025-06-06 07:51:20'),(207,'nara205@daum.net',15,5,'2025-06-06 07:51:20'),(208,'nara205@daum.net',16,4,'2025-06-06 07:51:20'),(209,'nara205@daum.net',17,3,'2025-06-06 07:51:20'),(210,'nara205@daum.net',18,5,'2025-06-06 07:51:20'),(211,'nara205@daum.net',19,4,'2025-06-06 07:51:20'),(212,'nara205@daum.net',20,5,'2025-06-06 07:51:20'),(213,'nara205@daum.net',21,2,'2025-06-06 07:51:20'),(214,'nara205@daum.net',22,3,'2025-06-06 07:51:20'),(215,'nara205@daum.net',23,4,'2025-06-06 07:51:20'),(216,'nara205@daum.net',24,5,'2025-06-06 07:51:20'),(217,'yuna487@naver.com',1,2,'2025-06-06 07:51:20'),(218,'yuna487@naver.com',2,3,'2025-06-06 07:51:20'),(219,'yuna487@naver.com',3,4,'2025-06-06 07:51:20'),(220,'yuna487@naver.com',4,5,'2025-06-06 07:51:20'),(221,'yuna487@naver.com',5,4,'2025-06-06 07:51:20'),(222,'yuna487@naver.com',6,3,'2025-06-06 07:51:20'),(223,'yuna487@naver.com',7,2,'2025-06-06 07:51:20'),(224,'yuna487@naver.com',8,4,'2025-06-06 07:51:20'),(225,'yuna487@naver.com',9,3,'2025-06-06 07:51:20'),(226,'yuna487@naver.com',10,5,'2025-06-06 07:51:20'),(227,'yuna487@naver.com',11,4,'2025-06-06 07:51:20'),(228,'yuna487@naver.com',12,3,'2025-06-06 07:51:20'),(229,'yuna487@naver.com',13,5,'2025-06-06 07:51:20'),(230,'yuna487@naver.com',14,4,'2025-06-06 07:51:20'),(231,'yuna487@naver.com',15,3,'2025-06-06 07:51:20'),(232,'yuna487@naver.com',16,5,'2025-06-06 07:51:20'),(233,'yuna487@naver.com',17,4,'2025-06-06 07:51:20'),(234,'yuna487@naver.com',18,3,'2025-06-06 07:51:20'),(235,'yuna487@naver.com',19,5,'2025-06-06 07:51:20'),(236,'yuna487@naver.com',20,4,'2025-06-06 07:51:20'),(237,'yuna487@naver.com',21,5,'2025-06-06 07:51:20'),(238,'yuna487@naver.com',22,3,'2025-06-06 07:51:20'),(239,'yuna487@naver.com',23,4,'2025-06-06 07:51:20'),(240,'yuna487@naver.com',24,5,'2025-06-06 07:51:20'),(241,'minjoon832@gmail.com',1,3,'2025-06-06 07:51:20'),(242,'minjoon832@gmail.com',2,4,'2025-06-06 07:51:20'),(243,'minjoon832@gmail.com',3,5,'2025-06-06 07:51:20'),(244,'minjoon832@gmail.com',4,3,'2025-06-06 07:51:20'),(245,'minjoon832@gmail.com',5,4,'2025-06-06 07:51:20'),(246,'minjoon832@gmail.com',6,2,'2025-06-06 07:51:20'),(247,'minjoon832@gmail.com',7,4,'2025-06-06 07:51:20'),(248,'minjoon832@gmail.com',8,3,'2025-06-06 07:51:20'),(249,'minjoon832@gmail.com',9,4,'2025-06-06 07:51:20'),(250,'minjoon832@gmail.com',10,5,'2025-06-06 07:51:20'),(251,'minjoon832@gmail.com',11,3,'2025-06-06 07:51:20'),(252,'minjoon832@gmail.com',12,4,'2025-06-06 07:51:20'),(253,'minjoon832@gmail.com',13,5,'2025-06-06 07:51:20'),(254,'minjoon832@gmail.com',14,3,'2025-06-06 07:51:20'),(255,'minjoon832@gmail.com',15,4,'2025-06-06 07:51:20'),(256,'minjoon832@gmail.com',16,5,'2025-06-06 07:51:20'),(257,'minjoon832@gmail.com',17,3,'2025-06-06 07:51:20'),(258,'minjoon832@gmail.com',18,4,'2025-06-06 07:51:20'),(259,'minjoon832@gmail.com',19,5,'2025-06-06 07:51:20'),(260,'minjoon832@gmail.com',20,4,'2025-06-06 07:51:20'),(261,'minjoon832@gmail.com',21,3,'2025-06-06 07:51:20'),(262,'minjoon832@gmail.com',22,5,'2025-06-06 07:51:20'),(263,'minjoon832@gmail.com',23,4,'2025-06-06 07:51:20'),(264,'minjoon832@gmail.com',24,3,'2025-06-06 07:51:20'),(265,'jiho195@naver.com',1,2,'2025-06-06 07:51:20'),(266,'jiho195@naver.com',2,3,'2025-06-06 07:51:20'),(267,'jiho195@naver.com',3,4,'2025-06-06 07:51:20'),(268,'jiho195@naver.com',4,2,'2025-06-06 07:51:20'),(269,'jiho195@naver.com',5,3,'2025-06-06 07:51:20'),(270,'jiho195@naver.com',6,4,'2025-06-06 07:51:20'),(271,'jiho195@naver.com',7,5,'2025-06-06 07:51:20'),(272,'jiho195@naver.com',8,4,'2025-06-06 07:51:20'),(273,'jiho195@naver.com',9,2,'2025-06-06 07:51:20'),(274,'jiho195@naver.com',10,3,'2025-06-06 07:51:20'),(275,'jiho195@naver.com',11,5,'2025-06-06 07:51:20'),(276,'jiho195@naver.com',12,4,'2025-06-06 07:51:20'),(277,'jiho195@naver.com',13,3,'2025-06-06 07:51:20'),(278,'jiho195@naver.com',14,5,'2025-06-06 07:51:20'),(279,'jiho195@naver.com',15,4,'2025-06-06 07:51:20'),(280,'jiho195@naver.com',16,5,'2025-06-06 07:51:20'),(281,'jiho195@naver.com',17,2,'2025-06-06 07:51:20'),(282,'jiho195@naver.com',18,3,'2025-06-06 07:51:20'),(283,'jiho195@naver.com',19,5,'2025-06-06 07:51:20'),(284,'jiho195@naver.com',20,4,'2025-06-06 07:51:20'),(285,'jiho195@naver.com',21,3,'2025-06-06 07:51:20'),(286,'jiho195@naver.com',22,5,'2025-06-06 07:51:20'),(287,'jiho195@naver.com',23,4,'2025-06-06 07:51:20'),(288,'jiho195@naver.com',24,3,'2025-06-06 07:51:20'),(289,'seunghyun667@daum.net',1,5,'2025-06-06 07:51:20'),(290,'seunghyun667@daum.net',2,4,'2025-06-06 07:51:20'),(291,'seunghyun667@daum.net',3,3,'2025-06-06 07:51:20'),(292,'seunghyun667@daum.net',4,5,'2025-06-06 07:51:20'),(293,'seunghyun667@daum.net',5,4,'2025-06-06 07:51:20'),(294,'seunghyun667@daum.net',6,5,'2025-06-06 07:51:20'),(295,'seunghyun667@daum.net',7,3,'2025-06-06 07:51:20'),(296,'seunghyun667@daum.net',8,4,'2025-06-06 07:51:20'),(297,'seunghyun667@daum.net',9,5,'2025-06-06 07:51:20'),(298,'seunghyun667@daum.net',10,3,'2025-06-06 07:51:20'),(299,'seunghyun667@daum.net',11,4,'2025-06-06 07:51:20'),(300,'seunghyun667@daum.net',12,3,'2025-06-06 07:51:20'),(301,'seunghyun667@daum.net',13,5,'2025-06-06 07:51:20'),(302,'seunghyun667@daum.net',14,4,'2025-06-06 07:51:20'),(303,'seunghyun667@daum.net',15,5,'2025-06-06 07:51:20'),(304,'seunghyun667@daum.net',16,4,'2025-06-06 07:51:20'),(305,'seunghyun667@daum.net',17,3,'2025-06-06 07:51:20'),(306,'seunghyun667@daum.net',18,5,'2025-06-06 07:51:20'),(307,'seunghyun667@daum.net',19,4,'2025-06-06 07:51:20'),(308,'seunghyun667@daum.net',20,3,'2025-06-06 07:51:20'),(309,'seunghyun667@daum.net',21,5,'2025-06-06 07:51:20'),(310,'seunghyun667@daum.net',22,4,'2025-06-06 07:51:20'),(311,'seunghyun667@daum.net',23,5,'2025-06-06 07:51:20'),(312,'seunghyun667@daum.net',24,3,'2025-06-06 07:51:20'),(313,'donghyun328@gmail.com',1,4,'2025-06-06 07:51:20'),(314,'donghyun328@gmail.com',2,3,'2025-06-06 07:51:20'),(315,'donghyun328@gmail.com',3,5,'2025-06-06 07:51:20'),(316,'donghyun328@gmail.com',4,4,'2025-06-06 07:51:20'),(317,'donghyun328@gmail.com',5,3,'2025-06-06 07:51:20'),(318,'donghyun328@gmail.com',6,5,'2025-06-06 07:51:20'),(319,'donghyun328@gmail.com',7,3,'2025-06-06 07:51:20'),(320,'donghyun328@gmail.com',8,4,'2025-06-06 07:51:20'),(321,'donghyun328@gmail.com',9,2,'2025-06-06 07:51:20'),(322,'donghyun328@gmail.com',10,5,'2025-06-06 07:51:20'),(323,'donghyun328@gmail.com',11,4,'2025-06-06 07:51:20'),(324,'donghyun328@gmail.com',12,3,'2025-06-06 07:51:20'),(325,'donghyun328@gmail.com',13,5,'2025-06-06 07:51:20'),(326,'donghyun328@gmail.com',14,3,'2025-06-06 07:51:20'),(327,'donghyun328@gmail.com',15,4,'2025-06-06 07:51:20'),(328,'donghyun328@gmail.com',16,5,'2025-06-06 07:51:20'),(329,'donghyun328@gmail.com',17,3,'2025-06-06 07:51:20'),(330,'donghyun328@gmail.com',18,4,'2025-06-06 07:51:20'),(331,'donghyun328@gmail.com',19,5,'2025-06-06 07:51:20'),(332,'donghyun328@gmail.com',20,4,'2025-06-06 07:51:20'),(333,'donghyun328@gmail.com',21,3,'2025-06-06 07:51:20'),(334,'donghyun328@gmail.com',22,5,'2025-06-06 07:51:20'),(335,'donghyun328@gmail.com',23,4,'2025-06-06 07:51:20'),(336,'donghyun328@gmail.com',24,2,'2025-06-06 07:51:20'),(337,'taehoon946@naver.com',1,2,'2025-06-06 07:51:20'),(338,'taehoon946@naver.com',2,3,'2025-06-06 07:51:20'),(339,'taehoon946@naver.com',3,4,'2025-06-06 07:51:20'),(340,'taehoon946@naver.com',4,5,'2025-06-06 07:51:20'),(341,'taehoon946@naver.com',5,4,'2025-06-06 07:51:20'),(342,'taehoon946@naver.com',6,3,'2025-06-06 07:51:20'),(343,'taehoon946@naver.com',7,5,'2025-06-06 07:51:20'),(344,'taehoon946@naver.com',8,4,'2025-06-06 07:51:20'),(345,'taehoon946@naver.com',9,3,'2025-06-06 07:51:20'),(346,'taehoon946@naver.com',10,5,'2025-06-06 07:51:20'),(347,'taehoon946@naver.com',11,2,'2025-06-06 07:51:20'),(348,'taehoon946@naver.com',12,4,'2025-06-06 07:51:20'),(349,'taehoon946@naver.com',13,3,'2025-06-06 07:51:20'),(350,'taehoon946@naver.com',14,5,'2025-06-06 07:51:20'),(351,'taehoon946@naver.com',15,4,'2025-06-06 07:51:20'),(352,'taehoon946@naver.com',16,5,'2025-06-06 07:51:20'),(353,'taehoon946@naver.com',17,3,'2025-06-06 07:51:20'),(354,'taehoon946@naver.com',18,5,'2025-06-06 07:51:20'),(355,'taehoon946@naver.com',19,4,'2025-06-06 07:51:20'),(356,'taehoon946@naver.com',20,3,'2025-06-06 07:51:20'),(357,'taehoon946@naver.com',21,5,'2025-06-06 07:51:20'),(358,'taehoon946@naver.com',22,4,'2025-06-06 07:51:20'),(359,'taehoon946@naver.com',23,3,'2025-06-06 07:51:20'),(360,'taehoon946@naver.com',24,5,'2025-06-06 07:51:20'),(361,'jaewon784@daum.net',1,5,'2025-06-06 07:51:20'),(362,'jaewon784@daum.net',2,4,'2025-06-06 07:51:20'),(363,'jaewon784@daum.net',3,5,'2025-06-06 07:51:20'),(364,'jaewon784@daum.net',4,3,'2025-06-06 07:51:20'),(365,'jaewon784@daum.net',5,4,'2025-06-06 07:51:20'),(366,'jaewon784@daum.net',6,5,'2025-06-06 07:51:20'),(367,'jaewon784@daum.net',7,3,'2025-06-06 07:51:20'),(368,'jaewon784@daum.net',8,4,'2025-06-06 07:51:20'),(369,'jaewon784@daum.net',9,5,'2025-06-06 07:51:20'),(370,'jaewon784@daum.net',10,4,'2025-06-06 07:51:20'),(371,'jaewon784@daum.net',11,3,'2025-06-06 07:51:20'),(372,'jaewon784@daum.net',12,5,'2025-06-06 07:51:20'),(373,'jaewon784@daum.net',13,4,'2025-06-06 07:51:20'),(374,'jaewon784@daum.net',14,5,'2025-06-06 07:51:20'),(375,'jaewon784@daum.net',15,3,'2025-06-06 07:51:20'),(376,'jaewon784@daum.net',16,4,'2025-06-06 07:51:20'),(377,'jaewon784@daum.net',17,5,'2025-06-06 07:51:20'),(378,'jaewon784@daum.net',18,3,'2025-06-06 07:51:20'),(379,'jaewon784@daum.net',19,4,'2025-06-06 07:51:20'),(380,'jaewon784@daum.net',20,5,'2025-06-06 07:51:20'),(381,'jaewon784@daum.net',21,4,'2025-06-06 07:51:20'),(382,'jaewon784@daum.net',22,3,'2025-06-06 07:51:20'),(383,'jaewon784@daum.net',23,5,'2025-06-06 07:51:20'),(384,'jaewon784@daum.net',24,4,'2025-06-06 07:51:20'),(385,'hyunwoo502@gmail.com',1,3,'2025-06-06 07:51:20'),(386,'hyunwoo502@gmail.com',2,4,'2025-06-06 07:51:20'),(387,'hyunwoo502@gmail.com',3,5,'2025-06-06 07:51:20'),(388,'hyunwoo502@gmail.com',4,4,'2025-06-06 07:51:20'),(389,'hyunwoo502@gmail.com',5,3,'2025-06-06 07:51:20'),(390,'hyunwoo502@gmail.com',6,5,'2025-06-06 07:51:20'),(391,'hyunwoo502@gmail.com',7,4,'2025-06-06 07:51:20'),(392,'hyunwoo502@gmail.com',8,3,'2025-06-06 07:51:20'),(393,'hyunwoo502@gmail.com',9,5,'2025-06-06 07:51:20'),(394,'hyunwoo502@gmail.com',10,4,'2025-06-06 07:51:20'),(395,'hyunwoo502@gmail.com',11,3,'2025-06-06 07:51:20'),(396,'hyunwoo502@gmail.com',12,5,'2025-06-06 07:51:20'),(397,'hyunwoo502@gmail.com',13,4,'2025-06-06 07:51:20'),(398,'hyunwoo502@gmail.com',14,5,'2025-06-06 07:51:20'),(399,'hyunwoo502@gmail.com',15,3,'2025-06-06 07:51:20'),(400,'hyunwoo502@gmail.com',16,5,'2025-06-06 07:51:20'),(401,'hyunwoo502@gmail.com',17,4,'2025-06-06 07:51:20'),(402,'hyunwoo502@gmail.com',18,3,'2025-06-06 07:51:20'),(403,'hyunwoo502@gmail.com',19,5,'2025-06-06 07:51:20'),(404,'hyunwoo502@gmail.com',20,4,'2025-06-06 07:51:20'),(405,'hyunwoo502@gmail.com',21,3,'2025-06-06 07:51:20'),(406,'hyunwoo502@gmail.com',22,5,'2025-06-06 07:51:20'),(407,'hyunwoo502@gmail.com',23,4,'2025-06-06 07:51:20'),(408,'hyunwoo502@gmail.com',24,3,'2025-06-06 07:51:20'),(409,'seungwoo631@naver.com',1,2,'2025-06-06 07:51:20'),(410,'seungwoo631@naver.com',2,3,'2025-06-06 07:51:20'),(411,'seungwoo631@naver.com',3,4,'2025-06-06 07:51:20'),(412,'seungwoo631@naver.com',4,5,'2025-06-06 07:51:20'),(413,'seungwoo631@naver.com',5,3,'2025-06-06 07:51:20'),(414,'seungwoo631@naver.com',6,4,'2025-06-06 07:51:20'),(415,'seungwoo631@naver.com',7,2,'2025-06-06 07:51:20'),(416,'seungwoo631@naver.com',8,4,'2025-06-06 07:51:20'),(417,'seungwoo631@naver.com',9,3,'2025-06-06 07:51:20'),(418,'seungwoo631@naver.com',10,5,'2025-06-06 07:51:20'),(419,'seungwoo631@naver.com',11,4,'2025-06-06 07:51:20'),(420,'seungwoo631@naver.com',12,3,'2025-06-06 07:51:20'),(421,'seungwoo631@naver.com',13,5,'2025-06-06 07:51:20'),(422,'seungwoo631@naver.com',14,4,'2025-06-06 07:51:20'),(423,'seungwoo631@naver.com',15,3,'2025-06-06 07:51:20'),(424,'seungwoo631@naver.com',16,5,'2025-06-06 07:51:20'),(425,'seungwoo631@naver.com',17,4,'2025-06-06 07:51:20'),(426,'seungwoo631@naver.com',18,3,'2025-06-06 07:51:20'),(427,'seungwoo631@naver.com',19,5,'2025-06-06 07:51:20'),(428,'seungwoo631@naver.com',20,4,'2025-06-06 07:51:20'),(429,'seungwoo631@naver.com',21,3,'2025-06-06 07:51:20'),(430,'seungwoo631@naver.com',22,5,'2025-06-06 07:51:20'),(431,'seungwoo631@naver.com',23,4,'2025-06-06 07:51:20'),(432,'seungwoo631@naver.com',24,2,'2025-06-06 07:51:20'),(433,'kyuhwan282@daum.net',1,3,'2025-06-06 07:51:20'),(434,'kyuhwan282@daum.net',2,5,'2025-06-06 07:51:20'),(435,'kyuhwan282@daum.net',3,4,'2025-06-06 07:51:20'),(436,'kyuhwan282@daum.net',4,3,'2025-06-06 07:51:20'),(437,'kyuhwan282@daum.net',5,4,'2025-06-06 07:51:20'),(438,'kyuhwan282@daum.net',6,2,'2025-06-06 07:51:20'),(439,'kyuhwan282@daum.net',7,5,'2025-06-06 07:51:20'),(440,'kyuhwan282@daum.net',8,4,'2025-06-06 07:51:20'),(441,'kyuhwan282@daum.net',9,5,'2025-06-06 07:51:20'),(442,'kyuhwan282@daum.net',10,3,'2025-06-06 07:51:20'),(443,'kyuhwan282@daum.net',11,4,'2025-06-06 07:51:20'),(444,'kyuhwan282@daum.net',12,3,'2025-06-06 07:51:20'),(445,'kyuhwan282@daum.net',13,5,'2025-06-06 07:51:20'),(446,'kyuhwan282@daum.net',14,4,'2025-06-06 07:51:20'),(447,'kyuhwan282@daum.net',15,3,'2025-06-06 07:51:20'),(448,'kyuhwan282@daum.net',16,5,'2025-06-06 07:51:20'),(449,'kyuhwan282@daum.net',17,4,'2025-06-06 07:51:20'),(450,'kyuhwan282@daum.net',18,5,'2025-06-06 07:51:20'),(451,'kyuhwan282@daum.net',19,3,'2025-06-06 07:51:20'),(452,'kyuhwan282@daum.net',20,4,'2025-06-06 07:51:20'),(453,'kyuhwan282@daum.net',21,5,'2025-06-06 07:51:20'),(454,'kyuhwan282@daum.net',22,3,'2025-06-06 07:51:20'),(455,'kyuhwan282@daum.net',23,4,'2025-06-06 07:51:20'),(456,'kyuhwan282@daum.net',24,5,'2025-06-06 07:51:20'),(457,'sangho157@gmail.com',1,4,'2025-06-06 07:51:20'),(458,'sangho157@gmail.com',2,3,'2025-06-06 07:51:20'),(459,'sangho157@gmail.com',3,5,'2025-06-06 07:51:20'),(460,'sangho157@gmail.com',4,4,'2025-06-06 07:51:20'),(461,'sangho157@gmail.com',5,3,'2025-06-06 07:51:20'),(462,'sangho157@gmail.com',6,5,'2025-06-06 07:51:20'),(463,'sangho157@gmail.com',7,2,'2025-06-06 07:51:20'),(464,'sangho157@gmail.com',8,4,'2025-06-06 07:51:20'),(465,'sangho157@gmail.com',9,3,'2025-06-06 07:51:20'),(466,'sangho157@gmail.com',10,5,'2025-06-06 07:51:20'),(467,'sangho157@gmail.com',11,4,'2025-06-06 07:51:20'),(468,'sangho157@gmail.com',12,3,'2025-06-06 07:51:20'),(469,'sangho157@gmail.com',13,5,'2025-06-06 07:51:20'),(470,'sangho157@gmail.com',14,4,'2025-06-06 07:51:20'),(471,'sangho157@gmail.com',15,3,'2025-06-06 07:51:20'),(472,'sangho157@gmail.com',16,5,'2025-06-06 07:51:20'),(473,'sangho157@gmail.com',17,4,'2025-06-06 07:51:20'),(474,'sangho157@gmail.com',18,3,'2025-06-06 07:51:20'),(475,'sangho157@gmail.com',19,5,'2025-06-06 07:51:20'),(476,'sangho157@gmail.com',20,4,'2025-06-06 07:51:20'),(477,'sangho157@gmail.com',21,3,'2025-06-06 07:51:20'),(478,'sangho157@gmail.com',22,5,'2025-06-06 07:51:20'),(479,'sangho157@gmail.com',23,4,'2025-06-06 07:51:20'),(480,'sangho157@gmail.com',24,3,'2025-06-06 07:51:20');
/*!40000 ALTER TABLE `UserResponse` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-06 16:53:08
