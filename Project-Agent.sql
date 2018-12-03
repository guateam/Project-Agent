-- MySQL dump 10.13  Distrib 5.7.22, for osx10.13 (x86_64)
--
-- Host: 127.0.0.1    Database: Project-Agent
-- ------------------------------------------------------
-- Server version	5.7.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Answer-Comments`
--

DROP TABLE IF EXISTS `Answer-Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Answer-Comments` (
  `idAnswer-Comments` int(11) NOT NULL AUTO_INCREMENT,
  `answerID` int(11) NOT NULL,
  `commentID` int(11) NOT NULL,
  PRIMARY KEY (`idAnswer-Comments`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='答案-评论映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answer-Comments`
--

LOCK TABLES `Answer-Comments` WRITE;
/*!40000 ALTER TABLE `Answer-Comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Answer-Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Answers`
--

DROP TABLE IF EXISTS `Answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Answers` (
  `answerID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '回答者',
  `edittime` datetime NOT NULL COMMENT '最后编辑时间',
  `content` text NOT NULL COMMENT '答案内容',
  `agree` int(11) NOT NULL COMMENT '赞同数',
  `disagree` int(11) NOT NULL COMMENT '反对数',
  `answertype` int(11) NOT NULL COMMENT '答案类型',
  PRIMARY KEY (`answerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='答案';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Answers`
--

LOCK TABLES `Answers` WRITE;
/*!40000 ALTER TABLE `Answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CollectAnswer`
--

DROP TABLE IF EXISTS `CollectAnswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CollectAnswer` (
  `idCollectAnswer` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `answerID` int(11) NOT NULL,
  PRIMARY KEY (`idCollectAnswer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏：用户-答案映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CollectAnswer`
--

LOCK TABLES `CollectAnswer` WRITE;
/*!40000 ALTER TABLE `CollectAnswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `CollectAnswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CollectArticle`
--

DROP TABLE IF EXISTS `CollectArticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CollectArticle` (
  `idCollectArticle` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `articleID` int(11) NOT NULL,
  PRIMARY KEY (`idCollectArticle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏：用户-文章映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CollectArticle`
--

LOCK TABLES `CollectArticle` WRITE;
/*!40000 ALTER TABLE `CollectArticle` DISABLE KEYS */;
/*!40000 ALTER TABLE `CollectArticle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Comments`
--

DROP TABLE IF EXISTS `Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Comments` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '评论人\n',
  `content` text NOT NULL COMMENT '内容',
  `agree` int(11) NOT NULL COMMENT '赞同数\n',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`commentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Comments`
--

LOCK TABLES `Comments` WRITE;
/*!40000 ALTER TABLE `Comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CreateAnswer`
--

DROP TABLE IF EXISTS `CreateAnswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CreateAnswer` (
  `idCreateAnswer` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `answerID` int(11) NOT NULL,
  PRIMARY KEY (`idCreateAnswer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-回答映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CreateAnswer`
--

LOCK TABLES `CreateAnswer` WRITE;
/*!40000 ALTER TABLE `CreateAnswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `CreateAnswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CreateArticle`
--

DROP TABLE IF EXISTS `CreateArticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CreateArticle` (
  `idCreateArticle` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `articleID` int(11) NOT NULL,
  PRIMARY KEY (`idCreateArticle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-文章映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CreateArticle`
--

LOCK TABLES `CreateArticle` WRITE;
/*!40000 ALTER TABLE `CreateArticle` DISABLE KEYS */;
/*!40000 ALTER TABLE `CreateArticle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CreateCourse`
--

DROP TABLE IF EXISTS `CreateCourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CreateCourse` (
  `idCreateCourse` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `courseID` int(11) NOT NULL,
  PRIMARY KEY (`idCreateCourse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-公开课映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CreateCourse`
--

LOCK TABLES `CreateCourse` WRITE;
/*!40000 ALTER TABLE `CreateCourse` DISABLE KEYS */;
/*!40000 ALTER TABLE `CreateCourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CreateLecture`
--

DROP TABLE IF EXISTS `CreateLecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CreateLecture` (
  `idCreateLecture` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `lectureID` int(11) NOT NULL,
  PRIMARY KEY (`idCreateLecture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-讲座映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CreateLecture`
--

LOCK TABLES `CreateLecture` WRITE;
/*!40000 ALTER TABLE `CreateLecture` DISABLE KEYS */;
/*!40000 ALTER TABLE `CreateLecture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CreateQuestion`
--

DROP TABLE IF EXISTS `CreateQuestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CreateQuestion` (
  `idCreateQuestion` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '提问用户',
  `questionID` int(11) NOT NULL COMMENT '问题',
  PRIMARY KEY (`idCreateQuestion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-问题映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CreateQuestion`
--

LOCK TABLES `CreateQuestion` WRITE;
/*!40000 ALTER TABLE `CreateQuestion` DISABLE KEYS */;
/*!40000 ALTER TABLE `CreateQuestion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FollowColumn`
--

DROP TABLE IF EXISTS `FollowColumn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FollowColumn` (
  `idFollowColumn` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '用户ID',
  `target` int(11) NOT NULL COMMENT '目标 专栏ID',
  PRIMARY KEY (`idFollowColumn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-专栏 关注关系映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FollowColumn`
--

LOCK TABLES `FollowColumn` WRITE;
/*!40000 ALTER TABLE `FollowColumn` DISABLE KEYS */;
/*!40000 ALTER TABLE `FollowColumn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FollowTopic`
--

DROP TABLE IF EXISTS `FollowTopic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FollowTopic` (
  `idFollowTopic` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '用户ID',
  `target` int(11) NOT NULL COMMENT '目标 话题ID',
  PRIMARY KEY (`idFollowTopic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-话题 关注关系映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FollowTopic`
--

LOCK TABLES `FollowTopic` WRITE;
/*!40000 ALTER TABLE `FollowTopic` DISABLE KEYS */;
/*!40000 ALTER TABLE `FollowTopic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FollowUser`
--

DROP TABLE IF EXISTS `FollowUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FollowUser` (
  `idFollowUser` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '用户ID',
  `target` int(11) NOT NULL COMMENT '目标 用户ID',
  PRIMARY KEY (`idFollowUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-用户 关注关系映射表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FollowUser`
--

LOCK TABLES `FollowUser` WRITE;
/*!40000 ALTER TABLE `FollowUser` DISABLE KEYS */;
/*!40000 ALTER TABLE `FollowUser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Question-Comments`
--

DROP TABLE IF EXISTS `Question-Comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Question-Comments` (
  `idQuestion-Comments` int(11) NOT NULL AUTO_INCREMENT,
  `questionID` int(11) NOT NULL,
  `commentID` int(11) NOT NULL,
  PRIMARY KEY (`idQuestion-Comments`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题-评论映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Question-Comments`
--

LOCK TABLES `Question-Comments` WRITE;
/*!40000 ALTER TABLE `Question-Comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `Question-Comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QuestionLog`
--

DROP TABLE IF EXISTS `QuestionLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `QuestionLog` (
  `idQuestionLog` int(11) NOT NULL AUTO_INCREMENT,
  `questionID` int(11) NOT NULL COMMENT '问题id',
  `edittime` datetime NOT NULL COMMENT '编辑时间',
  `title` varchar(200) NOT NULL COMMENT '题目',
  `description` text NOT NULL COMMENT '描述',
  `userID` int(11) NOT NULL COMMENT '编辑者',
  `reason` varchar(200) NOT NULL COMMENT '编辑理由',
  PRIMARY KEY (`idQuestionLog`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QuestionLog`
--

LOCK TABLES `QuestionLog` WRITE;
/*!40000 ALTER TABLE `QuestionLog` DISABLE KEYS */;
/*!40000 ALTER TABLE `QuestionLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Questions`
--

DROP TABLE IF EXISTS `Questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Questions` (
  `questionID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL COMMENT '题目',
  `description` text NOT NULL COMMENT '描述',
  `edittime` datetime NOT NULL COMMENT '最后编辑时间\n',
  PRIMARY KEY (`questionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Questions`
--

LOCK TABLES `Questions` WRITE;
/*!40000 ALTER TABLE `Questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `Questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL COMMENT '用户名/邮箱',
  `nickname` varchar(45) NOT NULL COMMENT '昵称',
  `password` varchar(256) NOT NULL COMMENT '密码',
  `headportrait` text NOT NULL COMMENT '头像',
  `usergroup` int(11) NOT NULL COMMENT '用户组',
  `exp` bigint(20) NOT NULL COMMENT '积分/等级',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-24 15:02:44
