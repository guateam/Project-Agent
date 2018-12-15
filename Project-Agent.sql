/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : project-agent

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-12-15 16:32:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `answercomments`
-- ----------------------------
DROP TABLE IF EXISTS `answercomments`;
CREATE TABLE `answercomments` (
  `acommentID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '创建者ID',
  `content` text NOT NULL COMMENT '内容',
  `agree` int(11) NOT NULL COMMENT '赞同数',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `answerID` int(11) NOT NULL COMMENT '对应答案ID',
  PRIMARY KEY (`acommentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='回答评论表';

-- ----------------------------
-- Records of answercomments
-- ----------------------------

-- ----------------------------
-- Table structure for `answers`
-- ----------------------------
DROP TABLE IF EXISTS `answers`;
CREATE TABLE `answers` (
  `answerID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '回答者',
  `edittime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑时间',
  `content` text NOT NULL COMMENT '答案内容',
  `agree` int(11) NOT NULL COMMENT '赞同数',
  `disagree` int(11) NOT NULL COMMENT '反对数',
  `answertype` int(11) NOT NULL COMMENT '答案类型',
  `questionID` int(11) NOT NULL COMMENT '对应问题ID\n',
  PRIMARY KEY (`answerID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='答案';

-- ----------------------------
-- Records of answers
-- ----------------------------
INSERT INTO `answers` VALUES ('1', '1', '2018-12-15 16:31:12', '先回答大家最关心的两个问题：\n1、我们可以实现芯片彻底国产化了吗？\n答：暂时还不行。\n2、不吹不黑，这个装备真的这么厉害吗，还是只是吹牛？\n答：确实很厉害。\n很多人只盯着新闻里22nm这个指标，其实大家要关注的是“365nm的光源，单次曝光线宽可达22nm”。注意到我加黑的那几个关键词了吗？22nm指标虽然很棒但是业界早就做过了，到底哪里厉害呢？所以关键是用365nm的光源单次曝光做到22nm，懂点光学的就知道这意味着什么：打破了传统的衍射极限。\n所以在我看来，这台机器最大的价值是验证了表面等离子体（SP）光刻加工的可行性。\n这台SP光刻机与ASML光刻机对比怎么样呢？举个不恰当的例子吧，这就像是初期的枪械与最厉害的弓箭的对比。早期枪械，比如火铳，无论是射击精度还是射击距离都远远比不上厉害的弓箭，但是如今的狙击枪早已把弓箭甩开十万八千里了，这就是原理性的胜利。\n要理解刚才说的这个“原理性的胜利”到底是怎么回事，我们首先得回顾一下以ASML为代表的传统光刻机是怎么做的。\n上面是ASML光刻机简单的原理图，抛开复杂的监测设备不谈，最核心的原理就是通过物镜系统将掩膜版上的图案进行缩印成像。涉及到成像过程，就不得不考虑光的衍射极限。即便抛开所有的几何像差，由于衍射的作用，一个无限小的点成像后也会变成一个弥散斑，被称为“艾里斑”。因此实际光学系统成像的分辨率就是两个艾里斑恰好能够分开的距离。\n所以由于衍射效应，成像分辨率会受到限制，最终的分辨率取决于波长、数值孔径等参数，波长越小、数值孔径越大分辨率则越高。所以ASML这些年来主要的研究方向就是利用更短的波长（近紫外-深紫外-极紫外）、增大数值孔径（更复杂的物镜、液体浸没）。但是每进一步都变得更加艰难，对系统设计、加工装配、误差检测等等诸多方面都提出了更为苛刻的要求，成本也越来越高昂。\n那么表面等离子体光刻又是怎么一回事呢？表面等离子体指的是一种局域在物质表面的特殊的电磁波，随着离开物质表面距离的增大迅速衰减，一般认为波长量级以上的区域就不存在了。\n更为神奇的是，虽然表面等离子体波是由其他电磁波激发的，但是波长会被极大地压缩，而压缩的比例取决于材料的电磁性质等参数。\n这就意味着，利用表面等离子体波进行光刻时，从原理上就不在受到传统衍射极限的限制了。\n在光刻机研制方面，我们一直有两个选择：沿用ASML的老路走一遍，还是另辟蹊径通过新原理弯道超车？我们国家很有钱，两个选择都在做。而这台SP光刻机的研制成功，就是让我们看到了弯道超车的可能性。其实从原理上，这简直就不是弯道超车了，而是在别的人还在绕山路的时候，我们尝试着打了一条隧道……虽然还没有完全挖通，但曙光就在眼前了。\n这个装备是我在的课题组主导研发的（但我没做这个方向），从原理提出、项目立项到装备最终验收通过，前前后后有十几年的时间。十几年磨一剑，挥洒了许许多多的老师和师兄师姐的智慧、汗水与青春。向他们致敬~', '0', '0', '0', '1');

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
-- Table structure for `questioncomments`
-- ----------------------------
DROP TABLE IF EXISTS `questioncomments`;
CREATE TABLE `questioncomments` (
  `qcommentID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '评论人\n',
  `content` text NOT NULL COMMENT '内容',
  `agree` int(11) NOT NULL COMMENT '赞同数\n',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `questionID` int(11) DEFAULT NULL COMMENT '对应问题ID\n',
  PRIMARY KEY (`qcommentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='问题评论';

-- ----------------------------
-- Records of questioncomments
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
  `edittime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后编辑时间\n',
  `userID` int(11) NOT NULL COMMENT '创建者ID',
  `tags` varchar(45) DEFAULT NULL COMMENT '问题标签',
  PRIMARY KEY (`questionID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='问题\r\n';

-- ----------------------------
-- Records of questions
-- ----------------------------
INSERT INTO `questions` VALUES ('1', '刚刚研制成功的世界首台分辨力最高紫外超分辨光刻装备意味着什么？对国内芯片行业有何影响？', '这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述', '0000-00-00 00:00:00', '1', null);

-- ----------------------------
-- Table structure for `useraction`
-- ----------------------------
DROP TABLE IF EXISTS `useraction`;
CREATE TABLE `useraction` (
  `actionID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '用户ID',
  `targetID` int(11) NOT NULL COMMENT '行为对应ID\n',
  `targettype` int(11) NOT NULL COMMENT '行为类型',
  `actiontime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '行为发生时间',
  PRIMARY KEY (`actionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户行为表\n';

-- ----------------------------
-- Records of useraction
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
  `token` varchar(45) NOT NULL DEFAULT '',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `phonenumber` varchar(45) DEFAULT NULL COMMENT '电话号码',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'zhangyu199946@126.com', '拉拉人', 'ec847003d2eadc9baf60853e8391e167a292c21f01892fcb8bad0f4af6cd74a7', '', '0', '0', 'KOjV4Z0DdTSrqPIwvulbip9EU', null, null, null);

-- ----------------------------
-- View structure for `answersinfo`
-- ----------------------------
DROP VIEW IF EXISTS `answersinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `answersinfo` AS select `answers`.`answerID` AS `answerID`,`answers`.`userID` AS `userID`,`answers`.`edittime` AS `edittime`,`answers`.`content` AS `content`,`answers`.`agree` AS `agree`,`answers`.`disagree` AS `disagree`,`answers`.`answertype` AS `answertype`,`answers`.`questionID` AS `questionID`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait` from (`answers` join `users`) where (`answers`.`answerID` = `users`.`userID`) ;
