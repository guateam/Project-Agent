/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : project-agent

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-12-03 19:17:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `answer-comments`
-- ----------------------------
DROP TABLE IF EXISTS `answer-comments`;
CREATE TABLE `answer-comments` (
  `idAnswer-Comments` int(11) NOT NULL AUTO_INCREMENT,
  `answerID` int(11) NOT NULL,
  `commentID` int(11) NOT NULL,
  PRIMARY KEY (`idAnswer-Comments`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='答案-评论映射';

-- ----------------------------
-- Records of answer-comments
-- ----------------------------

-- ----------------------------
-- Table structure for `answers`
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `answerID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '回答者',
  `edittime` datetime NOT NULL COMMENT '最后编辑时间',
  `content` text NOT NULL COMMENT '答案内容',
  `agree` int(11) NOT NULL COMMENT '赞同数',
  `disagree` int(11) NOT NULL COMMENT '反对数',
  `answertype` int(11) NOT NULL COMMENT '答案类型',
  PRIMARY KEY (`answerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='答案';

-- ----------------------------
-- Records of answers
-- ----------------------------

-- ----------------------------
-- Table structure for `collectanswer`
-- ----------------------------
DROP TABLE IF EXISTS `collectanswer`;
CREATE TABLE `collectanswer` (
  `idCollectAnswer` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `answerID` int(11) NOT NULL,
  PRIMARY KEY (`idCollectAnswer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏：用户-答案映射';

-- ----------------------------
-- Records of collectanswer
-- ----------------------------

-- ----------------------------
-- Table structure for `collectarticle`
-- ----------------------------
DROP TABLE IF EXISTS `collectarticle`;
CREATE TABLE `collectarticle` (
  `idCollectArticle` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `articleID` int(11) NOT NULL,
  PRIMARY KEY (`idCollectArticle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收藏：用户-文章映射';

-- ----------------------------
-- Records of collectarticle
-- ----------------------------

-- ----------------------------
-- Table structure for `comments`
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '评论人\n',
  `content` text NOT NULL COMMENT '内容',
  `agree` int(11) NOT NULL COMMENT '赞同数\n',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`commentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论';

-- ----------------------------
-- Records of comments
-- ----------------------------

-- ----------------------------
-- Table structure for `createanswer`
-- ----------------------------
DROP TABLE IF EXISTS `createanswer`;
CREATE TABLE `createanswer` (
  `idCreateAnswer` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `answerID` int(11) NOT NULL,
  PRIMARY KEY (`idCreateAnswer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-回答映射';

-- ----------------------------
-- Records of createanswer
-- ----------------------------

-- ----------------------------
-- Table structure for `createarticle`
-- ----------------------------
DROP TABLE IF EXISTS `createarticle`;
CREATE TABLE `createarticle` (
  `idCreateArticle` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `articleID` int(11) NOT NULL,
  PRIMARY KEY (`idCreateArticle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-文章映射';

-- ----------------------------
-- Records of createarticle
-- ----------------------------

-- ----------------------------
-- Table structure for `createcourse`
-- ----------------------------
DROP TABLE IF EXISTS `createcourse`;
CREATE TABLE `createcourse` (
  `idCreateCourse` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `courseID` int(11) NOT NULL,
  PRIMARY KEY (`idCreateCourse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-公开课映射';

-- ----------------------------
-- Records of createcourse
-- ----------------------------

-- ----------------------------
-- Table structure for `createlecture`
-- ----------------------------
DROP TABLE IF EXISTS `createlecture`;
CREATE TABLE `createlecture` (
  `idCreateLecture` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `lectureID` int(11) NOT NULL,
  PRIMARY KEY (`idCreateLecture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-讲座映射';

-- ----------------------------
-- Records of createlecture
-- ----------------------------

-- ----------------------------
-- Table structure for `createquestion`
-- ----------------------------
DROP TABLE IF EXISTS `createquestion`;
CREATE TABLE `createquestion` (
  `idCreateQuestion` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '提问用户',
  `questionID` int(11) NOT NULL COMMENT '问题',
  PRIMARY KEY (`idCreateQuestion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='创作：用户-问题映射';

-- ----------------------------
-- Records of createquestion
-- ----------------------------

-- ----------------------------
-- Table structure for `followcolumn`
-- ----------------------------
DROP TABLE IF EXISTS `followcolumn`;
CREATE TABLE `followcolumn` (
  `idFollowColumn` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '用户ID',
  `target` int(11) NOT NULL COMMENT '目标 专栏ID',
  PRIMARY KEY (`idFollowColumn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-专栏 关注关系映射表';

-- ----------------------------
-- Records of followcolumn
-- ----------------------------

-- ----------------------------
-- Table structure for `followtopic`
-- ----------------------------
DROP TABLE IF EXISTS `followtopic`;
CREATE TABLE `followtopic` (
  `idFollowTopic` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '用户ID',
  `target` int(11) NOT NULL COMMENT '目标 话题ID',
  PRIMARY KEY (`idFollowTopic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-话题 关注关系映射表';

-- ----------------------------
-- Records of followtopic
-- ----------------------------

-- ----------------------------
-- Table structure for `followuser`
-- ----------------------------
DROP TABLE IF EXISTS `followuser`;
CREATE TABLE `followuser` (
  `idFollowUser` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '用户ID',
  `target` int(11) NOT NULL COMMENT '目标 用户ID',
  PRIMARY KEY (`idFollowUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-用户 关注关系映射表';

-- ----------------------------
-- Records of followuser
-- ----------------------------

-- ----------------------------
-- Table structure for `question-comments`
-- ----------------------------
DROP TABLE IF EXISTS `question-comments`;
CREATE TABLE `question-comments` (
  `idQuestion-Comments` int(11) NOT NULL AUTO_INCREMENT,
  `questionID` int(11) NOT NULL,
  `commentID` int(11) NOT NULL,
  PRIMARY KEY (`idQuestion-Comments`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题-评论映射';

-- ----------------------------
-- Records of question-comments
-- ----------------------------

-- ----------------------------
-- Table structure for `questionlog`
-- ----------------------------
DROP TABLE IF EXISTS `questionlog`;
CREATE TABLE `questionlog` (
  `idQuestionLog` int(11) NOT NULL AUTO_INCREMENT,
  `questionID` int(11) NOT NULL COMMENT '问题id',
  `edittime` datetime NOT NULL COMMENT '编辑时间',
  `title` varchar(200) NOT NULL COMMENT '题目',
  `description` text NOT NULL COMMENT '描述',
  `userID` int(11) NOT NULL COMMENT '编辑者',
  `reason` varchar(200) NOT NULL COMMENT '编辑理由',
  PRIMARY KEY (`idQuestionLog`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题日志';

-- ----------------------------
-- Records of questionlog
-- ----------------------------

-- ----------------------------
-- Table structure for `questions`
-- ----------------------------
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `questionID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL COMMENT '题目',
  `description` text NOT NULL COMMENT '描述',
  `edittime` datetime NOT NULL COMMENT '最后编辑时间\n',
  PRIMARY KEY (`questionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题\n';

-- ----------------------------
-- Records of questions
-- ----------------------------

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL COMMENT '用户名/邮箱',
  `nickname` varchar(45) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(256) NOT NULL COMMENT '密码',
  `headportrait` text NOT NULL COMMENT '头像',
  `usergroup` int(11) NOT NULL DEFAULT '0' COMMENT '用户组',
  `exp` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分/等级',
  `token` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'zhangyu199946@126.com', '', 'ec847003d2eadc9baf60853e8391e167a292c21f01892fcb8bad0f4af6cd74a7', '', '0', '0', 'KOjV4Z0DdTSrqPIwvulbip9EU');
