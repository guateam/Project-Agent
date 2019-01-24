/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : project-agent

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-01-24 13:16:34
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
  PRIMARY KEY (`acommentID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='回答评论表';

-- ----------------------------
-- Records of answercomments
-- ----------------------------
INSERT INTO `answercomments` VALUES ('1', '1', '这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论', '1', '2018-12-29 11:15:40', '1');
INSERT INTO `answercomments` VALUES ('2', '1', '这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论', '0', '2018-12-15 19:08:09', '1');
INSERT INTO `answercomments` VALUES ('3', '1', '这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论', '0', '2018-12-15 19:08:36', '1');
INSERT INTO `answercomments` VALUES ('4', '1', '@拉拉人 疯狂@拉拉人', '0', '2018-12-29 10:35:57', '1');

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
  `tags` text NOT NULL,
  `state` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`answerID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='答案';

-- ----------------------------
-- Records of answers
-- ----------------------------
INSERT INTO `answers` VALUES ('1', '1', '2018-12-15 16:31:12', '先回答大家最关心的两个问题：\n1、我们可以实现芯片彻底国产化了吗？\n答：暂时还不行。\n2、不吹不黑，这个装备真的这么厉害吗，还是只是吹牛？\n答：确实很厉害。\n很多人只盯着新闻里22nm这个指标，其实大家要关注的是“365nm的光源，单次曝光线宽可达22nm”。注意到我加黑的那几个关键词了吗？22nm指标虽然很棒但是业界早就做过了，到底哪里厉害呢？所以关键是用365nm的光源单次曝光做到22nm，懂点光学的就知道这意味着什么：打破了传统的衍射极限。\n所以在我看来，这台机器最大的价值是验证了表面等离子体（SP）光刻加工的可行性。\n这台SP光刻机与ASML光刻机对比怎么样呢？举个不恰当的例子吧，这就像是初期的枪械与最厉害的弓箭的对比。早期枪械，比如火铳，无论是射击精度还是射击距离都远远比不上厉害的弓箭，但是如今的狙击枪早已把弓箭甩开十万八千里了，这就是原理性的胜利。\n要理解刚才说的这个“原理性的胜利”到底是怎么回事，我们首先得回顾一下以ASML为代表的传统光刻机是怎么做的。\n上面是ASML光刻机简单的原理图，抛开复杂的监测设备不谈，最核心的原理就是通过物镜系统将掩膜版上的图案进行缩印成像。涉及到成像过程，就不得不考虑光的衍射极限。即便抛开所有的几何像差，由于衍射的作用，一个无限小的点成像后也会变成一个弥散斑，被称为“艾里斑”。因此实际光学系统成像的分辨率就是两个艾里斑恰好能够分开的距离。\n所以由于衍射效应，成像分辨率会受到限制，最终的分辨率取决于波长、数值孔径等参数，波长越小、数值孔径越大分辨率则越高。所以ASML这些年来主要的研究方向就是利用更短的波长（近紫外-深紫外-极紫外）、增大数值孔径（更复杂的物镜、液体浸没）。但是每进一步都变得更加艰难，对系统设计、加工装配、误差检测等等诸多方面都提出了更为苛刻的要求，成本也越来越高昂。\n那么表面等离子体光刻又是怎么一回事呢？表面等离子体指的是一种局域在物质表面的特殊的电磁波，随着离开物质表面距离的增大迅速衰减，一般认为波长量级以上的区域就不存在了。\n更为神奇的是，虽然表面等离子体波是由其他电磁波激发的，但是波长会被极大地压缩，而压缩的比例取决于材料的电磁性质等参数。\n这就意味着，利用表面等离子体波进行光刻时，从原理上就不在受到传统衍射极限的限制了。\n在光刻机研制方面，我们一直有两个选择：沿用ASML的老路走一遍，还是另辟蹊径通过新原理弯道超车？我们国家很有钱，两个选择都在做。而这台SP光刻机的研制成功，就是让我们看到了弯道超车的可能性。其实从原理上，这简直就不是弯道超车了，而是在别的人还在绕山路的时候，我们尝试着打了一条隧道……虽然还没有完全挖通，但曙光就在眼前了。\n这个装备是我在的课题组主导研发的（但我没做这个方向），从原理提出、项目立项到装备最终验收通过，前前后后有十几年的时间。十几年磨一剑，挥洒了许许多多的老师和师兄师姐的智慧、汗水与青春。向他们致敬~', '2', '2', '0', '1', '1,2', '0');
INSERT INTO `answers` VALUES ('2', '1', '2018-12-15 19:35:41', 'jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj', '0', '0', '0', '1', '', '0');
INSERT INTO `answers` VALUES ('3', '1', '2018-12-15 19:49:26', '<img src=\"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAtoAAAMsCAYAAABqUgWDAAAACXBIWXMAAAsTAAALEwEAmpwYAAAFEmlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS42LWMxNDIgNzkuMTYwOTI0LCAyMDE3LzA3LzEzLTAxOjA2OjM5ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6cGhvdG9zaG9wPSJodHRwOi8vbnMuYWRvYmUuY29tL3Bob3Rvc2hvcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RFdnQ9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZUV2ZW50IyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgKFdpbmRvd3MpIiB4bXA6Q3JlYXRlRGF0ZT0iMjAxOC0xMi0xNVQxNjoyNjo1OSswODowMCIgeG1wOk1vZGlmeURhdGU9IjIwMTgtMTItMTVUMTY6MzA6NTkrMDg6MDAiIHhtcDpNZXRhZGF0YURhdGU9IjIwMTgtMTItMTVUMTY6MzA6NTkrMDg6MDAiIGRjOmZvcm1hdD0iaW1hZ2UvcG5nIiBwaG90b3Nob3A6Q29sb3JNb2RlPSIzIiBwaG90b3Nob3A6SUNDUHJvZmlsZT0ic1JHQiBJRUM2MTk2Ni0yLjEiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6ODAzZWM4MzgtMWY0ZS00NzQx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\"/>', '0', '0', '0', '1', '', '0');
INSERT INTO `answers` VALUES ('4', '1', '2018-12-29 10:35:33', '@拉拉人 你来回答', '0', '0', '0', '1', '', '0');

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `articleID` int(10) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `title` varchar(50) NOT NULL,
  `edittime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `userID` int(10) NOT NULL,
  `tags` varchar(45) NOT NULL,
  `state` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`articleID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of article
-- ----------------------------

-- ----------------------------
-- Table structure for `collectanswer`
-- ----------------------------
DROP TABLE IF EXISTS `collectanswer`;
CREATE TABLE `collectanswer` (
  `idCollectAnswer` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `answerID` int(11) NOT NULL,
  PRIMARY KEY (`idCollectAnswer`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收藏：用户-答案映射';

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
  PRIMARY KEY (`idCollectArticle`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收藏：用户-文章映射';

-- ----------------------------
-- Records of collectarticle
-- ----------------------------

-- ----------------------------
-- Table structure for `demands`
-- ----------------------------
DROP TABLE IF EXISTS `demands`;
CREATE TABLE `demands` (
  `demandID` int(10) NOT NULL AUTO_INCREMENT,
  `userID` int(10) NOT NULL,
  `content` text NOT NULL,
  `allowedUserGroup` varchar(45) NOT NULL,
  `price` varchar(45) NOT NULL,
  `tags` varchar(45) NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `state` int(2) NOT NULL,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`demandID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of demands
-- ----------------------------

-- ----------------------------
-- Table structure for `exp_change`
-- ----------------------------
DROP TABLE IF EXISTS `exp_change`;
CREATE TABLE `exp_change` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `value` int(10) NOT NULL,
  `userID` int(10) NOT NULL,
  `description` varchar(45) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of exp_change
-- ----------------------------

-- ----------------------------
-- Table structure for `followcolumn`
-- ----------------------------
DROP TABLE IF EXISTS `followcolumn`;
CREATE TABLE `followcolumn` (
  `idFollowColumn` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '用户ID',
  `target` int(11) NOT NULL COMMENT '目标 专栏ID',
  PRIMARY KEY (`idFollowColumn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户-专栏 关注关系映射表';

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
  PRIMARY KEY (`idFollowTopic`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户-话题 关注关系映射表';

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
  PRIMARY KEY (`idFollowUser`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户-用户 关注关系映射表';

-- ----------------------------
-- Records of followuser
-- ----------------------------
INSERT INTO `followuser` VALUES ('1', '1', '2');

-- ----------------------------
-- Table structure for `messages`
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `messageID` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `poster` int(11) NOT NULL,
  `receiver` int(11) NOT NULL,
  `type` int(2) NOT NULL,
  `post_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`messageID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES ('1', 'first cry!!!!!', '1', '2', '0', '2018-12-15 20:26:31');
INSERT INTO `messages` VALUES ('2', 'cry again!', '1', '2', '0', '2018-12-15 20:26:31');
INSERT INTO `messages` VALUES ('3', 'still crying', '1', '2', '0', '2018-12-15 20:26:31');
INSERT INTO `messages` VALUES ('4', 'de order', '1', '2', '0', '2018-12-15 20:29:27');
INSERT INTO `messages` VALUES ('5', 'emojixe6xb5x8bxe8xafx95xf0x9fx98x80', '1', '2', '0', '2018-12-20 18:56:19');
INSERT INTO `messages` VALUES ('6', 'b\'emojixe6xb5x8bxe8xafx95xf0x9fx98x80\'', '1', '2', '0', '2018-12-20 18:48:52');
INSERT INTO `messages` VALUES ('7', 'emoji\\u6d4b\\u8bd5\\U0001f600', '1', '2', '0', '2018-12-20 18:56:26');
INSERT INTO `messages` VALUES ('8', 'emoji测试????略略略', '3', '2', '0', '2019-01-07 18:44:56');

-- ----------------------------
-- Table structure for `orders`
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `orderID` int(10) NOT NULL AUTO_INCREMENT,
  `userID` int(10) NOT NULL,
  `target` int(10) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `content` text NOT NULL,
  `state` int(2) NOT NULL DEFAULT '0',
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`orderID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of orders
-- ----------------------------

-- ----------------------------
-- Table structure for `pay_log`
-- ----------------------------
DROP TABLE IF EXISTS `pay_log`;
CREATE TABLE `pay_log` (
  `from` int(255) NOT NULL COMMENT '钱的来源，用户ID',
  `receive` int(255) DEFAULT NULL COMMENT '钱的接收ID ,问题ID或专家ID或告示板需求ID',
  `amount` int(255) DEFAULT NULL COMMENT '金额数量',
  `type` int(255) DEFAULT NULL COMMENT '交易形式  1-付费问答  2-专家咨询  3-告示板需求',
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易发起时间',
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '交易单号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED;

-- ----------------------------
-- Records of pay_log
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
  PRIMARY KEY (`qcommentID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='问题评论';

-- ----------------------------
-- Records of questioncomments
-- ----------------------------
INSERT INTO `questioncomments` VALUES ('1', '1', '这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论', '0', '2018-12-18 13:37:34', '1');
INSERT INTO `questioncomments` VALUES ('2', '1', '这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论这是评论', '0', '2018-12-18 13:38:55', '1');
INSERT INTO `questioncomments` VALUES ('3', '1', '@拉拉人 这是问题评论', '0', '2018-12-29 10:36:25', '1');

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
  PRIMARY KEY (`idQuestionLog`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='问题日志';

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
  `state` int(2) NOT NULL DEFAULT '0',
  `question_type` int(2) NOT NULL DEFAULT '0',
  `price` int(255) NOT NULL DEFAULT '0',
  `allowed_user` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`questionID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='问题\r\n';

-- ----------------------------
-- Records of questions
-- ----------------------------
INSERT INTO `questions` VALUES ('1', '刚刚研制成功的世界首台分辨力最高紫外超分辨光刻装备意味着什么？对国内芯片行业有何影响？', '这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述这里是描述', '2018-12-17 21:00:38', '1', null, '0', '0', '0', null);
INSERT INTO `questions` VALUES ('2', '程序员是如何看待「祖传代码」的？', '说明一下……此处「祖传代码」与百度搜索「祖传代码」词条出现的某直播平台后缀无关……\n\n几位答主提到祖传代码不仅游戏领域有，其他领域也存在，所以删除了游戏标签，问题修改为作为程序员对于「祖传代码」这种说法或其本身有什么看法吐槽。\n\n对码农一无所知，提问的初衷大概是为了爱与和平。\n\n感谢扫盲_(:з」∠)_', '2018-12-15 18:46:54', '1', null, '0', '0', '0', null);
INSERT INTO `questions` VALUES ('3', '为什么总是有人说 Java 啰嗦，却没人说 C++ 啰嗦？', '哈哈哈哈哈哈', '2018-12-15 18:47:38', '1', null, '0', '0', '0', null);
INSERT INTO `questions` VALUES ('4', '有哪些让你目瞪口呆的 bug？', '', '2018-12-15 18:49:52', '1', null, '0', '0', '0', null);
INSERT INTO `questions` VALUES ('5', '互联网行业的裁员潮是否已经开始了？', '【此为2018年的提问】\n\n看到媒体也开始说这件事了……普通员工如何扛过去呢？', '2018-12-15 18:51:16', '1', null, '0', '0', '0', null);
INSERT INTO `questions` VALUES ('6', '@测试提问', '【此为2018年的提问】\n@拉拉人 \n看到媒体也开始说这件事了……普通员工如何扛过去呢？', '2018-12-29 10:35:05', '1', null, '0', '0', '0', null);

-- ----------------------------
-- Table structure for `sign_demand`
-- ----------------------------
DROP TABLE IF EXISTS `sign_demand`;
CREATE TABLE `sign_demand` (
  `signID` int(10) NOT NULL AUTO_INCREMENT,
  `userID` int(10) NOT NULL,
  `target` int(10) NOT NULL,
  `state` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`signID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sign_demand
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_message`
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message` (
  `noticeID` int(10) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `userID` int(10) NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` int(2) NOT NULL,
  `target` int(10) NOT NULL,
  PRIMARY KEY (`noticeID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_message
-- ----------------------------
INSERT INTO `sys_message` VALUES ('1', '系统通知啊，今天要例会', '1', '2018-12-29 10:58:21', '1', '0');

-- ----------------------------
-- Table structure for `tags`
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `type` int(2) NOT NULL,
  `father` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES ('1', '非原创', '0', null);
INSERT INTO `tags` VALUES ('2', '随便抄', '0', null);
INSERT INTO `tags` VALUES ('3', '减振降噪', '1', null);
INSERT INTO `tags` VALUES ('4', '新材料应用', '1', null);
INSERT INTO `tags` VALUES ('5', '传感器', '1', null);
INSERT INTO `tags` VALUES ('6', '绿色能源', '1', null);
INSERT INTO `tags` VALUES ('7', '射频技术', '1', null);
INSERT INTO `tags` VALUES ('8', '人工智能', '1', null);
INSERT INTO `tags` VALUES ('9', '流体机械', '1', null);
INSERT INTO `tags` VALUES ('10', '水处理技术', '1', null);
INSERT INTO `tags` VALUES ('11', '食品技术', '1', null);
INSERT INTO `tags` VALUES ('12', '制冷系统设计', '1', null);
INSERT INTO `tags` VALUES ('13', '燃烧技术', '1', null);
INSERT INTO `tags` VALUES ('14', '空气净化技术', '1', null);
INSERT INTO `tags` VALUES ('15', '机械结构设计', '1', null);
INSERT INTO `tags` VALUES ('16', '加热技术', '1', null);

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
  PRIMARY KEY (`actionID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户行为表\n';

-- ----------------------------
-- Records of useraction
-- ----------------------------
INSERT INTO `useraction` VALUES ('1', '2', '1', '1', '2018-12-25 14:43:45');
INSERT INTO `useraction` VALUES ('2', '1', '1', '1', '2018-12-29 11:14:26');
INSERT INTO `useraction` VALUES ('3', '1', '1', '3', '2018-12-29 11:15:40');
INSERT INTO `useraction` VALUES ('4', '1', '1', '2', '2018-12-29 11:17:17');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL COMMENT '用户名/邮箱',
  `nickname` varchar(45) NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(256) NOT NULL COMMENT '密码',
  `headportrait` text COMMENT '头像',
  `usergroup` int(11) NOT NULL DEFAULT '0' COMMENT '用户组',
  `exp` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分/等级',
  `token` varchar(45) NOT NULL DEFAULT '',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `phonenumber` varchar(45) DEFAULT NULL COMMENT '电话号码',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  `description` text NOT NULL,
  `state` int(2) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `number` varchar(45) NOT NULL,
  `real_name` varchar(20) NOT NULL,
  `nationality` varchar(20) NOT NULL,
  `account_balance` int(255) NOT NULL DEFAULT '0' COMMENT '账户余额',
  `specialitst_license` varchar(255) NOT NULL,
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'zhangyu199946@126.com', '拉拉人', 'ec847003d2eadc9baf60853e8391e167a292c21f01892fcb8bad0f4af6cd74a7', '', '0', '998', 'VHjWIO5Kp7So6uGxY4Fcbs3Jt', null, null, null, '弗兰秀秀牛逼', '0', '', '', '', '', '0', '');
INSERT INTO `users` VALUES ('2', 'yyz@126.com', '袁宜照', '317f16f4833885da6766e81b35c7258fe4451798600a1ad980babb9e9f412fc2', '', '0', '0', 'TNp6hR7ElkJK4Z5Xfte0VyqG3', null, null, null, '', '0', '', '', '', '', '0', '');
INSERT INTO `users` VALUES ('3', 'zyxiaohao@126.com', '', 'cb8f260c5b29ec2a17d662133ebcf99cd4594e29b0ffeb54599ffe5f3801c3ed', null, '0', '0', 'U3WieM95EkGpfXTwdohKFgnjv', null, null, null, '', '0', '', '', '', '', '0', '');

-- ----------------------------
-- View structure for `ac_at_info`
-- ----------------------------
DROP VIEW IF EXISTS `ac_at_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ac_at_info` AS select `answercomments`.`acommentID` AS `acommentID`,`answercomments`.`userID` AS `userID`,`answercomments`.`content` AS `content`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`users`.`headportrait` AS `headportrait`,`users`.`nickname` AS `nickname`,`answercomments`.`createtime` AS `createtime` from (`answercomments` join `users`) where (`answercomments`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `agree_answer_comment_info`
-- ----------------------------
DROP VIEW IF EXISTS `agree_answer_comment_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `agree_answer_comment_info` AS select `useraction`.`actionID` AS `actionID`,`useraction`.`targetID` AS `targetID`,`useraction`.`targettype` AS `targettype`,`useraction`.`actiontime` AS `actiontime`,`answercomments`.`acommentID` AS `acommentID`,`answercomments`.`content` AS `content`,`answercomments`.`agree` AS `agree`,`answercomments`.`createtime` AS `createtime`,`answercomments`.`answerID` AS `answerID`,`answers`.`userID` AS `userID`,`answers`.`answertype` AS `answertype`,`answers`.`questionID` AS `questionID`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`questions`.`title` AS `title`,`questions`.`description` AS `description`,`questions`.`tags` AS `tags` from ((((`useraction` join `answers`) join `answercomments`) join `users`) join `questions`) where ((`useraction`.`targettype` = 3) and (`useraction`.`targetID` = `answercomments`.`acommentID`) and (`useraction`.`userID` = `users`.`userID`) and (`answers`.`answerID` = `answercomments`.`answerID`) and (`questions`.`questionID` = `answers`.`questionID`)) ;

-- ----------------------------
-- View structure for `agree_answer_info`
-- ----------------------------
DROP VIEW IF EXISTS `agree_answer_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `agree_answer_info` AS select `users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`useraction`.`actionID` AS `actionID`,`useraction`.`userID` AS `userID`,`useraction`.`targetID` AS `targetID`,`useraction`.`targettype` AS `targettype`,`useraction`.`actiontime` AS `actiontime`,`answers`.`edittime` AS `edittime`,`answers`.`content` AS `content`,`answers`.`agree` AS `agree`,`answers`.`disagree` AS `disagree`,`answers`.`answertype` AS `answertype`,`answers`.`questionID` AS `questionID`,`questions`.`title` AS `title` from (((`users` join `useraction`) join `answers`) join `questions`) where ((`users`.`userID` = `useraction`.`userID`) and ((`useraction`.`targettype` = 1) or (`useraction`.`targettype` = 2)) and (`useraction`.`targetID` = `answers`.`answerID`) and (`answers`.`questionID` = `questions`.`questionID`)) ;

-- ----------------------------
-- View structure for `agree_question_comment_info`
-- ----------------------------
DROP VIEW IF EXISTS `agree_question_comment_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `agree_question_comment_info` AS select `useraction`.`actionID` AS `actionID`,`useraction`.`userID` AS `userID`,`useraction`.`targetID` AS `targetID`,`useraction`.`targettype` AS `targettype`,`useraction`.`actiontime` AS `actiontime`,`users`.`email` AS `email`,`users`.`nickname` AS `nickname`,`users`.`password` AS `password`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`users`.`token` AS `token`,`users`.`birthday` AS `birthday`,`users`.`phonenumber` AS `phonenumber`,`users`.`address` AS `address`,`questioncomments`.`qcommentID` AS `qcommentID`,`questioncomments`.`content` AS `content`,`questioncomments`.`agree` AS `agree`,`questioncomments`.`createtime` AS `createtime`,`questioncomments`.`questionID` AS `questionID`,`questions`.`title` AS `title`,`questions`.`description` AS `description`,`questions`.`edittime` AS `edittime`,`questions`.`tags` AS `tags` from (((`questions` join `users`) join `useraction`) join `questioncomments`) where ((`useraction`.`targettype` = 5) and (`useraction`.`userID` = `users`.`userID`) and (`questioncomments`.`qcommentID` = `useraction`.`targetID`) and (`questions`.`questionID` = `questioncomments`.`questionID`)) ;

-- ----------------------------
-- View structure for `answersinfo`
-- ----------------------------
DROP VIEW IF EXISTS `answersinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `answersinfo` AS select `answers`.`answerID` AS `answerID`,`answers`.`userID` AS `userID`,`answers`.`edittime` AS `edittime`,`answers`.`content` AS `content`,`answers`.`agree` AS `agree`,`answers`.`disagree` AS `disagree`,`answers`.`answertype` AS `answertype`,`answers`.`questionID` AS `questionID`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`answers`.`tags` AS `tags`,`answers`.`state` AS `state` from (`answers` join `users`) where (`answers`.`userID` = `users`.`userID`) order by `answers`.`agree` desc ;

-- ----------------------------
-- View structure for `articleinfo`
-- ----------------------------
DROP VIEW IF EXISTS `articleinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `articleinfo` AS select `article`.`articleID` AS `articleID`,`article`.`content` AS `content`,`article`.`title` AS `title`,`article`.`edittime` AS `edittime`,`article`.`userID` AS `userID`,`article`.`tags` AS `tags`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`article`.`state` AS `state` from (`article` join `users`) where (`article`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `a_at_info`
-- ----------------------------
DROP VIEW IF EXISTS `a_at_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `a_at_info` AS select `users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`answers`.`answerID` AS `answerID`,`answers`.`edittime` AS `edittime`,`answers`.`content` AS `content`,`answers`.`userID` AS `userID` from (`users` join `answers`) where (`users`.`userID` = `answers`.`userID`) ;

-- ----------------------------
-- View structure for `chat_box`
-- ----------------------------
DROP VIEW IF EXISTS `chat_box`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `chat_box` AS select `messages`.`messageID` AS `messageID`,`messages`.`content` AS `content`,`messages`.`poster` AS `poster`,`messages`.`receiver` AS `receiver`,`messages`.`type` AS `type`,`poster`.`headportrait` AS `poster_headportrait`,`poster`.`usergroup` AS `poster_usergroup`,`poster`.`nickname` AS `poster_nickname`,`poster`.`exp` AS `poster_exp`,`receiver`.`nickname` AS `receiver_nickname`,`receiver`.`headportrait` AS `receiver_headportrait`,`receiver`.`usergroup` AS `receiver_usergroup`,`receiver`.`exp` AS `receiver_exp`,`messages`.`post_time` AS `post_time` from ((`messages` join `users` `poster`) join `users` `receiver`) where ((`messages`.`poster` = `poster`.`userID`) and (`messages`.`receiver` = `receiver`.`userID`)) order by `messages`.`post_time` desc ;

-- ----------------------------
-- View structure for `demands_info`
-- ----------------------------
DROP VIEW IF EXISTS `demands_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `demands_info` AS select `demands`.`demandID` AS `demandID`,`demands`.`userID` AS `userID`,`demands`.`content` AS `content`,`demands`.`allowedUserGroup` AS `allowedUserGroup`,`demands`.`price` AS `price`,`demands`.`tags` AS `tags`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`users`.`description` AS `description`,`demands`.`createtime` AS `createtime`,`demands`.`state` AS `state` from (`demands` join `users`) where (`demands`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `followinfo`
-- ----------------------------
DROP VIEW IF EXISTS `followinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `followinfo` AS select `followuser`.`idFollowUser` AS `idFollowUser`,`followuser`.`userID` AS `userID`,`followuser`.`target` AS `target`,`target`.`nickname` AS `target_nickname`,`target`.`headportrait` AS `target_headportrait`,`target`.`usergroup` AS `target_usergroup`,`target`.`exp` AS `target_exp`,`target`.`description` AS `target_description`,`follower`.`nickname` AS `follower_nickname`,`follower`.`headportrait` AS `follower_headportrait`,`follower`.`usergroup` AS `follower_usergroup`,`follower`.`exp` AS `follower_exp`,`follower`.`description` AS `follower_description` from ((`followuser` join `users` `follower`) join `users` `target`) where ((`followuser`.`userID` = `follower`.`userID`) and (`followuser`.`target` = `target`.`userID`)) ;

-- ----------------------------
-- View structure for `orderinfo`
-- ----------------------------
DROP VIEW IF EXISTS `orderinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `orderinfo` AS select `orders`.`orderID` AS `orderID`,`orders`.`userID` AS `userID`,`orders`.`target` AS `target`,`orders`.`start_time` AS `start_time`,`orders`.`content` AS `content`,`orders`.`end_time` AS `end_time`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`users`.`description` AS `description`,`orders`.`state` AS `state` from (`users` join `orders`) where (`users`.`userID` = `orders`.`userID`) ;

-- ----------------------------
-- View structure for `qc_at_info`
-- ----------------------------
DROP VIEW IF EXISTS `qc_at_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qc_at_info` AS select `questioncomments`.`userID` AS `userID`,`questioncomments`.`qcommentID` AS `qcommentID`,`questioncomments`.`content` AS `content`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`questioncomments`.`createtime` AS `createtime` from (`questioncomments` join `users`) where (`questioncomments`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `questionsinfo`
-- ----------------------------
DROP VIEW IF EXISTS `questionsinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `questionsinfo` AS select `questions`.`questionID` AS `questionID`,`questions`.`title` AS `title`,`questions`.`description` AS `description`,`questions`.`edittime` AS `edittime`,`questions`.`userID` AS `userID`,`questions`.`tags` AS `tags`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`questions`.`state` AS `state` from (`questions` join `users`) where (`questions`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `question_comments_info`
-- ----------------------------
DROP VIEW IF EXISTS `question_comments_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `question_comments_info` AS select `questioncomments`.`qcommentID` AS `qcommentID`,`questioncomments`.`userID` AS `userID`,`questioncomments`.`content` AS `content`,`questioncomments`.`agree` AS `agree`,`questioncomments`.`createtime` AS `createtime`,`questioncomments`.`questionID` AS `questionID`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp` from (`questioncomments` join `users`) where (`questioncomments`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `q_at_info`
-- ----------------------------
DROP VIEW IF EXISTS `q_at_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_at_info` AS select `questions`.`questionID` AS `questionID`,`questions`.`title` AS `title`,`questions`.`description` AS `description`,`questions`.`userID` AS `userID`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`questions`.`edittime` AS `edittime` from (`questions` join `users`) where (`questions`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `signed_demand_info`
-- ----------------------------
DROP VIEW IF EXISTS `signed_demand_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `signed_demand_info` AS select `sign_demand`.`signID` AS `signID`,`sign_demand`.`userID` AS `userID`,`sign_demand`.`target` AS `target`,`sign_demand`.`state` AS `state`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`users`.`description` AS `description` from (`sign_demand` join `users`) where (`sign_demand`.`userID` = `users`.`userID`) ;
