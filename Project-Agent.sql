/*
Navicat MySQL Data Transfer

Source Server         : 搬瓦工
Source Server Version : 50725
Source Host           : hanerx.tk:3306
Source Database       : project-agent

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2019-02-27 14:56:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `activities`
-- ----------------------------
DROP TABLE IF EXISTS `activities`;
CREATE TABLE `activities` (
  `activityID` int(12) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL DEFAULT '',
  `type` int(2) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cover` varchar(255) NOT NULL DEFAULT '',
  `userID` int(10) NOT NULL DEFAULT '0',
  `state` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`activityID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of activities
-- ----------------------------
INSERT INTO `activities` VALUES ('1', '开学季特价', '2', 'www.baidu.com', '2019-02-26 09:10:48', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551200316578&di=9c9312e3ae88f6f44da5cce0b8c034b0&imgtype=0&src=http%3A%2F%2Fbpic.ooopic.com%2F16%2F59%2F37%2F16593762-cd9328613cd92d108535fb95a8e7cb7b-0.jpg', '1', '0');
INSERT INTO `activities` VALUES ('2', '绝赞好书-怎样装逼', '2', 'www.zhihu.com', '2019-02-26 09:12:33', 'https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=a9d322ec6f2762d0803ea3b998d76fc7/a71ea8d3fd1f4134973598b1291f95cad0c85efa.jpg', '1', '0');

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
  `tags` varchar(45) NOT NULL DEFAULT '',
  `state` int(2) NOT NULL DEFAULT '0',
  `cover` text,
  `free` int(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否免费   0-不是  1-是',
  PRIMARY KEY (`articleID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1', '第一篇文章，文章文章文章文章，要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火要火', '文章要火', '2019-01-29 13:54:03', '1', '', '0', null, '1');
INSERT INTO `article` VALUES ('2', '第二篇文章，啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊', '再次发表', '2019-01-29 13:54:41', '1', '', '0', null, '1');
INSERT INTO `article` VALUES ('3', '我的研究报告内容为：如何熟练运用查克拉进行车床加工', '查克拉与车床', '2019-01-29 13:56:02', '2', '', '0', null, '1');
INSERT INTO `article` VALUES ('4', '猪脑内的电波经过放大后可以利用在大型发电机上，这可能是能源危机的新突破口，量产猪脑等同于量产电池', '猪脑与能源的关联', '2019-01-29 13:58:08', '3', '', '0', null, '1');
INSERT INTO `article` VALUES ('5', '高考带给学生的压力经过提取后可以用在高压水刀上，这将进一步提高水刀的切割效率和准度，大面积推广高压教育有利于国内加工业的飞速发展', '高压水刀改经建议', '2019-01-29 14:00:15', '2', '', '0', null, '1');
INSERT INTO `article` VALUES ('6', '丢，yyz好像没写好', '这个文章是什么回事', '2019-02-21 06:48:08', '1', '', '0', null, '1');
INSERT INTO `article` VALUES ('7', '奶奶曾经说过', '装逼学', '2019-02-26 08:27:43', '3', '1,2', '0', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1548771986088&di=761da3b54ab86da44d4c16cc8cd89225&imgtype=0&src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Frecom%2F2016%2F09%2F03%2F147288408009059060.PNG', '1');

-- ----------------------------
-- Table structure for `collectanswer`
-- ----------------------------
DROP TABLE IF EXISTS `collectanswer`;
CREATE TABLE `collectanswer` (
  `idCollectAnswer` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `answerID` int(11) NOT NULL,
  PRIMARY KEY (`idCollectAnswer`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收藏：用户-答案映射';

-- ----------------------------
-- Records of collectanswer
-- ----------------------------
INSERT INTO `collectanswer` VALUES ('46', '13', '4');
INSERT INTO `collectanswer` VALUES ('47', '30', '1');
INSERT INTO `collectanswer` VALUES ('48', '44', '4');
INSERT INTO `collectanswer` VALUES ('49', '1', '3');
INSERT INTO `collectanswer` VALUES ('50', '24', '3');
INSERT INTO `collectanswer` VALUES ('51', '10', '1');
INSERT INTO `collectanswer` VALUES ('52', '24', '3');
INSERT INTO `collectanswer` VALUES ('53', '47', '1');
INSERT INTO `collectanswer` VALUES ('54', '8', '2');
INSERT INTO `collectanswer` VALUES ('55', '50', '1');
INSERT INTO `collectanswer` VALUES ('56', '2', '4');
INSERT INTO `collectanswer` VALUES ('57', '33', '4');
INSERT INTO `collectanswer` VALUES ('58', '2', '2');
INSERT INTO `collectanswer` VALUES ('59', '39', '1');
INSERT INTO `collectanswer` VALUES ('60', '30', '4');
INSERT INTO `collectanswer` VALUES ('61', '13', '3');
INSERT INTO `collectanswer` VALUES ('62', '31', '2');
INSERT INTO `collectanswer` VALUES ('63', '1', '1');
INSERT INTO `collectanswer` VALUES ('64', '1', '3');
INSERT INTO `collectanswer` VALUES ('65', '1', '3');
INSERT INTO `collectanswer` VALUES ('66', '1', '1');
INSERT INTO `collectanswer` VALUES ('67', '1', '2');
INSERT INTO `collectanswer` VALUES ('68', '1', '1');
INSERT INTO `collectanswer` VALUES ('69', '1', '1');
INSERT INTO `collectanswer` VALUES ('70', '16', '2');
INSERT INTO `collectanswer` VALUES ('71', '29', '3');
INSERT INTO `collectanswer` VALUES ('72', '6', '4');
INSERT INTO `collectanswer` VALUES ('73', '45', '4');
INSERT INTO `collectanswer` VALUES ('74', '25', '4');
INSERT INTO `collectanswer` VALUES ('75', '46', '3');
INSERT INTO `collectanswer` VALUES ('76', '32', '3');
INSERT INTO `collectanswer` VALUES ('77', '1', '3');
INSERT INTO `collectanswer` VALUES ('78', '2', '4');
INSERT INTO `collectanswer` VALUES ('79', '7', '4');
INSERT INTO `collectanswer` VALUES ('80', '17', '1');
INSERT INTO `collectanswer` VALUES ('81', '46', '4');
INSERT INTO `collectanswer` VALUES ('82', '25', '4');
INSERT INTO `collectanswer` VALUES ('83', '19', '4');
INSERT INTO `collectanswer` VALUES ('84', '28', '1');
INSERT INTO `collectanswer` VALUES ('85', '17', '1');
INSERT INTO `collectanswer` VALUES ('86', '19', '3');
INSERT INTO `collectanswer` VALUES ('87', '44', '3');
INSERT INTO `collectanswer` VALUES ('88', '8', '4');
INSERT INTO `collectanswer` VALUES ('89', '21', '2');
INSERT INTO `collectanswer` VALUES ('90', '38', '3');
INSERT INTO `collectanswer` VALUES ('91', '37', '4');
INSERT INTO `collectanswer` VALUES ('92', '42', '4');
INSERT INTO `collectanswer` VALUES ('93', '21', '2');
INSERT INTO `collectanswer` VALUES ('94', '40', '3');
INSERT INTO `collectanswer` VALUES ('95', '19', '2');
INSERT INTO `collectanswer` VALUES ('96', '16', '1');
INSERT INTO `collectanswer` VALUES ('97', '27', '4');
INSERT INTO `collectanswer` VALUES ('98', '19', '4');
INSERT INTO `collectanswer` VALUES ('99', '17', '2');
INSERT INTO `collectanswer` VALUES ('100', '22', '1');
INSERT INTO `collectanswer` VALUES ('101', '27', '2');
INSERT INTO `collectanswer` VALUES ('102', '11', '2');
INSERT INTO `collectanswer` VALUES ('103', '2', '2');
INSERT INTO `collectanswer` VALUES ('104', '31', '2');
INSERT INTO `collectanswer` VALUES ('105', '39', '1');
INSERT INTO `collectanswer` VALUES ('106', '17', '3');
INSERT INTO `collectanswer` VALUES ('107', '11', '4');
INSERT INTO `collectanswer` VALUES ('108', '42', '1');
INSERT INTO `collectanswer` VALUES ('109', '43', '4');
INSERT INTO `collectanswer` VALUES ('110', '14', '2');
INSERT INTO `collectanswer` VALUES ('111', '12', '2');

-- ----------------------------
-- Table structure for `collectarticle`
-- ----------------------------
DROP TABLE IF EXISTS `collectarticle`;
CREATE TABLE `collectarticle` (
  `idCollectArticle` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `articleID` int(11) NOT NULL,
  PRIMARY KEY (`idCollectArticle`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='收藏：用户-文章映射';

-- ----------------------------
-- Records of collectarticle
-- ----------------------------
INSERT INTO `collectarticle` VALUES ('36', '21', '1');
INSERT INTO `collectarticle` VALUES ('37', '29', '6');
INSERT INTO `collectarticle` VALUES ('38', '32', '4');
INSERT INTO `collectarticle` VALUES ('39', '38', '5');
INSERT INTO `collectarticle` VALUES ('40', '7', '4');
INSERT INTO `collectarticle` VALUES ('41', '50', '5');
INSERT INTO `collectarticle` VALUES ('42', '8', '6');
INSERT INTO `collectarticle` VALUES ('43', '50', '6');
INSERT INTO `collectarticle` VALUES ('44', '27', '1');
INSERT INTO `collectarticle` VALUES ('45', '16', '1');
INSERT INTO `collectarticle` VALUES ('46', '34', '6');
INSERT INTO `collectarticle` VALUES ('47', '26', '6');
INSERT INTO `collectarticle` VALUES ('48', '26', '4');
INSERT INTO `collectarticle` VALUES ('49', '1', '1');
INSERT INTO `collectarticle` VALUES ('50', '30', '6');
INSERT INTO `collectarticle` VALUES ('51', '21', '2');
INSERT INTO `collectarticle` VALUES ('52', '39', '2');
INSERT INTO `collectarticle` VALUES ('53', '13', '4');
INSERT INTO `collectarticle` VALUES ('54', '30', '2');
INSERT INTO `collectarticle` VALUES ('55', '12', '4');
INSERT INTO `collectarticle` VALUES ('56', '32', '1');
INSERT INTO `collectarticle` VALUES ('57', '3', '5');
INSERT INTO `collectarticle` VALUES ('58', '22', '4');
INSERT INTO `collectarticle` VALUES ('59', '37', '4');
INSERT INTO `collectarticle` VALUES ('60', '26', '3');
INSERT INTO `collectarticle` VALUES ('61', '21', '6');
INSERT INTO `collectarticle` VALUES ('62', '6', '2');
INSERT INTO `collectarticle` VALUES ('63', '42', '3');
INSERT INTO `collectarticle` VALUES ('64', '32', '5');
INSERT INTO `collectarticle` VALUES ('65', '40', '5');
INSERT INTO `collectarticle` VALUES ('66', '9', '5');
INSERT INTO `collectarticle` VALUES ('67', '44', '4');
INSERT INTO `collectarticle` VALUES ('68', '7', '1');
INSERT INTO `collectarticle` VALUES ('69', '11', '3');
INSERT INTO `collectarticle` VALUES ('70', '34', '5');
INSERT INTO `collectarticle` VALUES ('71', '48', '2');
INSERT INTO `collectarticle` VALUES ('72', '47', '6');
INSERT INTO `collectarticle` VALUES ('73', '35', '6');
INSERT INTO `collectarticle` VALUES ('74', '28', '1');
INSERT INTO `collectarticle` VALUES ('75', '34', '5');
INSERT INTO `collectarticle` VALUES ('76', '33', '3');
INSERT INTO `collectarticle` VALUES ('77', '16', '3');
INSERT INTO `collectarticle` VALUES ('78', '29', '2');
INSERT INTO `collectarticle` VALUES ('79', '34', '4');
INSERT INTO `collectarticle` VALUES ('80', '3', '4');
INSERT INTO `collectarticle` VALUES ('81', '27', '1');
INSERT INTO `collectarticle` VALUES ('82', '1', '6');
INSERT INTO `collectarticle` VALUES ('83', '33', '3');
INSERT INTO `collectarticle` VALUES ('84', '14', '1');
INSERT INTO `collectarticle` VALUES ('85', '16', '5');
INSERT INTO `collectarticle` VALUES ('86', '30', '4');
INSERT INTO `collectarticle` VALUES ('87', '6', '5');
INSERT INTO `collectarticle` VALUES ('88', '30', '5');
INSERT INTO `collectarticle` VALUES ('89', '38', '6');
INSERT INTO `collectarticle` VALUES ('90', '18', '1');
INSERT INTO `collectarticle` VALUES ('91', '17', '1');
INSERT INTO `collectarticle` VALUES ('92', '30', '2');
INSERT INTO `collectarticle` VALUES ('93', '10', '6');
INSERT INTO `collectarticle` VALUES ('94', '1', '4');
INSERT INTO `collectarticle` VALUES ('95', '49', '4');
INSERT INTO `collectarticle` VALUES ('96', '5', '5');
INSERT INTO `collectarticle` VALUES ('97', '10', '3');
INSERT INTO `collectarticle` VALUES ('98', '40', '5');
INSERT INTO `collectarticle` VALUES ('99', '41', '6');
INSERT INTO `collectarticle` VALUES ('100', '42', '3');
INSERT INTO `collectarticle` VALUES ('101', '7', '2');
INSERT INTO `collectarticle` VALUES ('102', '33', '5');
INSERT INTO `collectarticle` VALUES ('103', '39', '1');
INSERT INTO `collectarticle` VALUES ('104', '34', '1');
INSERT INTO `collectarticle` VALUES ('105', '23', '4');

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
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户-话题 关注关系映射表';

-- ----------------------------
-- Records of followtopic
-- ----------------------------
INSERT INTO `followtopic` VALUES ('43', '49', '58');
INSERT INTO `followtopic` VALUES ('44', '20', '87');
INSERT INTO `followtopic` VALUES ('45', '49', '44');
INSERT INTO `followtopic` VALUES ('46', '42', '8');
INSERT INTO `followtopic` VALUES ('47', '41', '66');
INSERT INTO `followtopic` VALUES ('48', '10', '84');
INSERT INTO `followtopic` VALUES ('49', '46', '54');
INSERT INTO `followtopic` VALUES ('50', '45', '11');
INSERT INTO `followtopic` VALUES ('51', '25', '61');
INSERT INTO `followtopic` VALUES ('52', '46', '66');
INSERT INTO `followtopic` VALUES ('53', '38', '97');
INSERT INTO `followtopic` VALUES ('54', '7', '1');
INSERT INTO `followtopic` VALUES ('55', '1', '24');
INSERT INTO `followtopic` VALUES ('56', '1', '68');
INSERT INTO `followtopic` VALUES ('57', '1', '12');
INSERT INTO `followtopic` VALUES ('58', '1', '24');
INSERT INTO `followtopic` VALUES ('59', '1', '31');
INSERT INTO `followtopic` VALUES ('60', '1', '88');
INSERT INTO `followtopic` VALUES ('61', '1', '129');
INSERT INTO `followtopic` VALUES ('62', '37', '59');
INSERT INTO `followtopic` VALUES ('63', '28', '29');
INSERT INTO `followtopic` VALUES ('64', '12', '32');
INSERT INTO `followtopic` VALUES ('65', '48', '84');
INSERT INTO `followtopic` VALUES ('66', '39', '44');
INSERT INTO `followtopic` VALUES ('67', '46', '125');
INSERT INTO `followtopic` VALUES ('68', '29', '58');
INSERT INTO `followtopic` VALUES ('69', '28', '162');
INSERT INTO `followtopic` VALUES ('70', '43', '141');
INSERT INTO `followtopic` VALUES ('71', '26', '40');
INSERT INTO `followtopic` VALUES ('72', '49', '161');
INSERT INTO `followtopic` VALUES ('73', '42', '123');
INSERT INTO `followtopic` VALUES ('74', '22', '96');
INSERT INTO `followtopic` VALUES ('75', '44', '33');
INSERT INTO `followtopic` VALUES ('76', '25', '29');
INSERT INTO `followtopic` VALUES ('77', '28', '37');
INSERT INTO `followtopic` VALUES ('78', '46', '77');
INSERT INTO `followtopic` VALUES ('79', '6', '121');
INSERT INTO `followtopic` VALUES ('80', '29', '18');
INSERT INTO `followtopic` VALUES ('81', '42', '178');
INSERT INTO `followtopic` VALUES ('82', '18', '62');
INSERT INTO `followtopic` VALUES ('83', '20', '27');
INSERT INTO `followtopic` VALUES ('84', '20', '146');
INSERT INTO `followtopic` VALUES ('85', '12', '121');
INSERT INTO `followtopic` VALUES ('86', '48', '66');
INSERT INTO `followtopic` VALUES ('87', '26', '125');
INSERT INTO `followtopic` VALUES ('88', '49', '37');
INSERT INTO `followtopic` VALUES ('89', '45', '18');
INSERT INTO `followtopic` VALUES ('90', '22', '120');
INSERT INTO `followtopic` VALUES ('91', '37', '72');
INSERT INTO `followtopic` VALUES ('92', '19', '61');
INSERT INTO `followtopic` VALUES ('93', '45', '118');
INSERT INTO `followtopic` VALUES ('94', '19', '152');
INSERT INTO `followtopic` VALUES ('95', '48', '45');
INSERT INTO `followtopic` VALUES ('96', '4', '126');
INSERT INTO `followtopic` VALUES ('97', '35', '53');
INSERT INTO `followtopic` VALUES ('98', '39', '177');
INSERT INTO `followtopic` VALUES ('99', '24', '135');
INSERT INTO `followtopic` VALUES ('101', '3', '97');
INSERT INTO `followtopic` VALUES ('102', '3', '95');
INSERT INTO `followtopic` VALUES ('103', '1', '60');

-- ----------------------------
-- Table structure for `followuser`
-- ----------------------------
DROP TABLE IF EXISTS `followuser`;
CREATE TABLE `followuser` (
  `idFollowUser` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL COMMENT '用户ID',
  `target` int(11) NOT NULL COMMENT '目标 用户ID',
  PRIMARY KEY (`idFollowUser`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户-用户 关注关系映射表';

-- ----------------------------
-- Records of followuser
-- ----------------------------
INSERT INTO `followuser` VALUES ('1', '1', '2');
INSERT INTO `followuser` VALUES ('2', '2', '1');
INSERT INTO `followuser` VALUES ('3', '1', '3');
INSERT INTO `followuser` VALUES ('4', '3', '1');
INSERT INTO `followuser` VALUES ('5', '4', '1');
INSERT INTO `followuser` VALUES ('6', '5', '1');
INSERT INTO `followuser` VALUES ('7', '6', '1');
INSERT INTO `followuser` VALUES ('8', '7', '1');
INSERT INTO `followuser` VALUES ('9', '1', '4');

-- ----------------------------
-- Table structure for `group_members`
-- ----------------------------
DROP TABLE IF EXISTS `group_members`;
CREATE TABLE `group_members` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `groupID` int(20) NOT NULL,
  `userID` int(10) NOT NULL,
  `state` int(2) NOT NULL,
  `silent` int(2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of group_members
-- ----------------------------
INSERT INTO `group_members` VALUES ('2', '4', '1', '0', '0');
INSERT INTO `group_members` VALUES ('3', '4', '2', '1', '0');

-- ----------------------------
-- Table structure for `group_message`
-- ----------------------------
DROP TABLE IF EXISTS `group_message`;
CREATE TABLE `group_message` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `userID` int(10) NOT NULL,
  `groupID` int(10) NOT NULL,
  `type` int(2) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of group_message
-- ----------------------------
INSERT INTO `group_message` VALUES ('1', '这是一个测试群，用于测试线上会议的功能', '1', '4', '0', '2019-01-25 14:00:29');
INSERT INTO `group_message` VALUES ('2', '忘记写type=0了，哈哈哈', '1', '4', '0', '2019-01-25 14:07:52');
INSERT INTO `group_message` VALUES ('3', '忘记写type=0了，哈哈哈', '2', '4', '0', '2019-01-25 14:26:09');

-- ----------------------------
-- Table structure for `groups`
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `groupID` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text NOT NULL,
  `userID` int(10) NOT NULL,
  `head_portrait` text,
  `state` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of groups
-- ----------------------------
INSERT INTO `groups` VALUES ('4', 'project-agent讨论群', '这是测试群', '1', 'http://img3.imgtn.bdimg.com/it/u=3524594933,3944395980&fm=214&gp=0.jpg', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES ('1', 'first cry!!!!!', '1', '2', '0', '2018-12-15 20:26:31');
INSERT INTO `messages` VALUES ('2', 'cry again!', '1', '2', '0', '2018-12-15 20:26:31');
INSERT INTO `messages` VALUES ('3', 'still crying', '1', '2', '0', '2018-12-15 20:26:31');
INSERT INTO `messages` VALUES ('4', 'de order', '1', '2', '0', '2018-12-15 20:29:27');
INSERT INTO `messages` VALUES ('5', 'emojixe6xb5x8bxe8xafx95xf0x9fx98x80', '1', '2', '0', '2018-12-20 18:56:19');
INSERT INTO `messages` VALUES ('6', 'b\'emojixe6xb5x8bxe8xafx95xf0x9fx98x80\'', '1', '2', '0', '2018-12-20 18:48:52');
INSERT INTO `messages` VALUES ('7', 'emoji\\u6d4b\\u8bd5\\u0001f600', '1', '2', '0', '2019-02-02 11:38:02');
INSERT INTO `messages` VALUES ('8', 'emoji测试????略略略', '3', '2', '0', '2019-01-07 18:44:56');
INSERT INTO `messages` VALUES ('9', 'emoji测试????略略略', '3', '3', '0', '2019-02-02 11:24:07');
INSERT INTO `messages` VALUES ('10', 'emoji测试????略略略', '1', '3', '0', '2019-02-02 11:25:52');
INSERT INTO `messages` VALUES ('11', 'b\'emojixe6xb5x8bxe8xafx95xf0x9fx98x80xe7x95xa5xe7x95xa5xe7x95xa5\'', '1', '2', '0', '2019-02-02 11:40:13');
INSERT INTO `messages` VALUES ('12', 'b\'emoji\\u6d4b\\u8bd5\\U0001f600\\u7565\\u7565\\u7565\'', '1', '2', '0', '2019-02-02 11:44:53');
INSERT INTO `messages` VALUES ('13', 'emoji \\u6d4\\u8d5\\U0001f600\\u7565\\u7565\\u7565', '1', '2', '0', '2019-02-02 11:56:33');
INSERT INTO `messages` VALUES ('14', '\\uf602', '1', '3', '0', '2019-02-02 12:00:17');
INSERT INTO `messages` VALUES ('15', '\\u6d4\\u8d5\\u4e00\\u4e0\\u7f16\\u7801\\u529f\\u80fd', '1', '3', '0', '2019-02-02 11:57:00');
INSERT INTO `messages` VALUES ('16', 'Unicode编码失败', '1', '3', '0', '2019-02-02 12:01:33');

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
  `end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='问题\r\n';

-- ----------------------------
-- Records of questions
-- ----------------------------
INSERT INTO `questions` VALUES ('1', '这算眼袋吗？？', 'None', '2019-02-24 09:02:33', '18', '8,11,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('2', '遇不到喜欢的人…？', 'None', '2019-02-24 09:02:34', '40', '8,11,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('3', '如果研究生去美国读，大学还去英国读么？', '明年大三，可以大三大四前往英国读，但是我还是希望考美国研究生，那么还有必要后两年去英国么？', '2019-02-24 09:02:34', '11', '3,14,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('4', '做了一年多的软件测试了，现在想转开发，不知道如何选择，求点建议。？', 'None', '2019-02-24 09:02:35', '47', '10,15,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('5', '为什么说别人坐热的板凳不要立马坐？', 'None', '2019-02-24 09:02:35', '49', '7,7,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('6', '你们的字是怎么练得，什么灵飞经之类的?', '我买了一个灵飞经的帖，还有无印良品的一个小毛笔……到开始写我才想起来我连怎么握笔都不知道。。。求你们指导我一下 ', '2019-02-24 09:02:36', '49', '11,5,2', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('7', '【宇智波止水】的百度百科的图册里面的剧照，为什么我一个都没见过？', '【宇智波止水】的百度百科的图册里面的剧照，为什么我一个都没见过？ 这些剧情是哪一集里面的？', '2019-02-24 09:02:36', '19', '2,15,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('8', '异地恋女友想和别的男生出去逛街，我可以不同意吗？', '我跟女朋友是异地恋。 她昨天晚上告诉我说一个男生邀她吃饭，是老乡。她同意了。 我没敢说不。因为之前有另一个男生约她出去玩的时候，我很坚决的说不行。她也说尊重我的想法，然后半个小时后她俩在街上被我撞了个正着。所以与其逼她撒谎骗我，倒不如顺从她，这样我起码可以知道部分真相。 可是我真的很介意我的女朋友跟别的男生约会，是我占有欲太强了么？还是她太大大咧咧…… 我该怎么办才能让她明白我的心意，又不会妨碍到她…', '2019-02-24 09:02:37', '47', '4,13,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('9', '哈喇子之类的类似土话出处为何？', '如题，是否有出处，还是就这么沿袭的？', '2019-02-24 09:02:38', '44', '2,8,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('10', '一个人孤单的时候，该听什么歌？', 'None', '2019-02-24 09:02:38', '6', '9,13,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('11', '高中化学易错常考的小知识点有哪些？', '主要是高考理综选择题中易出现的，教材中比较容易被忽略的。谢谢', '2019-02-24 09:02:39', '15', '12,3,15', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('12', '喜欢高二同班的一个女生，现在大一，不在一个学校，隔得很远，怎么追？', '她现在没谈恋爱', '2019-02-24 09:02:39', '20', '4,10,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('13', '人被分手后的心理变化过程，多久能恢复正常?', 'None', '2019-02-24 09:02:39', '36', '9,4,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('14', '想在学校组建一个小型非专业医疗队，急救箱里买些什么好？', 'None', '2019-02-24 09:02:40', '33', '9,5,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('15', '一段好的援助交际关系，应该具有怎样的特征？', 'None', '2019-02-24 09:02:40', '28', '14,8,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('16', '没有什么人脉、朋友不多。该怎么改变这种现状？', '我是一个女孩，90后。朋友不多。没什么人脉。现在好想多交朋友。只是、我不爱和陌生人说话。在熟人面前很疯。我该怎么积累人脉？', '2019-02-24 09:02:41', '35', '8,8,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('17', '招财宝理财总是高利率买入低利率卖出，不是赚大了？', '招财宝理财总是高利率买入低利率卖出，不是赚大了？', '2019-02-24 09:02:42', '46', '4,14,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('18', '文理分科，选文科or理科？文理科的选择对以后职业生涯的影响？', 'None', '2019-02-24 09:02:42', '16', '2,10,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('19', '疯狂外星人里面的插曲是什么？', '01. Rihanna – Towards the Sun (04:34) 02. Coffee – Run To Me (04:15) 03. Kiesza – Cannonball (03:58) 04. Rihanna – As Real As You and Me (03:41) 05. Charli XCX – Red Balloon (03:27) 06. Rihanna – Dancing In the Dark (03:44) 07. Jacob Plant – Drop That (04:19) 08. Jennifer Lopez – Feel the Light (04:52) 除了这些还有的。。。求各位大神。。。找不到的话妹子不跟我玩了 ', '2019-02-24 09:02:43', '12', '5,15,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('20', '请问有没有人知道轻轨每公里的造价 就是路基和钢轨 如果不知道价格的话 型号什么的也行 或者举出别地价格？', 'None', '2019-02-24 09:02:43', '46', '16,3,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('21', 'angelbabay是不是小三?', 'None', '2019-02-24 09:02:43', '14', '4,12,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('22', '女朋友总是管我玩游戏怎么办？', '其实大学的时候我是不玩游戏的，是个爱学习的好孩子。可是毕业这两年以来，工作之余爱玩游戏。我觉得我工作辛苦，下班后和节假日里玩会儿游戏没啥，但女朋友觉得我因此忽略了她，三天两头因为这个跟我吵架。我女朋友是一生气就特别不好哄的那种女生，我特别害怕她发脾气。我现在玩游戏都心惊胆战的，仿佛在做什么亏心事。还有，每周五晚上公司都会订场打球，我也常去打球，但女朋友觉得周五下班这么好的时光我不应该跑去玩，为此…', '2019-02-24 09:02:44', '24', '2,15,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('23', '凉粉形成凝胶状的高分子物理机理是什么？为何木薯粉不如红薯粉和绿豆粉？', '夏天比较喜欢吃凉粉. 而网络上看到的教程都是非常简单的. 总的水和绿豆粉(红薯粉,豌豆粉之类)的比例为1:4~5, 然后取一部分稀释,一部分烧开,边搅拌边倒入淀粉糊到烧开的水中,半透明状在容器中冷却即可. (必要时加明矾等交联剂) 考虑到starch也算大分子了,本来以为任何淀粉都可以的. 我尝试了两种: 木薯粉和红薯粉(超市暂时只买到这两种), 结果发现,同样的配方和工艺,木薯粉打死也做不出类似果冻的效果,而红薯粉就容易得多(考虑到…', '2019-02-24 09:02:44', '10', '3,13,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('24', 'None', 'None', '2019-02-24 09:02:45', '43', '15,10,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('25', '如何入门《周易》？', '希望各位的回答通俗易懂又不失逻辑严谨性。另外，本人看过《周易》一书，却读了几页就读不下去了。希望各位能够介绍如何入门《周易》。谢谢。', '2019-02-24 09:02:45', '35', '14,11,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('26', '男，23，初中学历。做过土建施工放线，后来放弃做销售。如今的自己对于未来一片迷茫，怎么办？？', '如果做网站相关的工作可以吗？自学还是上培训班好？或者是先找个能做的工作可以闲时学习？？求前辈指条明路，感激不尽！！！！', '2019-02-24 09:02:46', '20', '10,3,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('27', '《我的青春恋爱物语果然有问题》中，海老名姬菜和大老师属于同一类人吗？', '在小说第七卷有这样的描写 大老师：「……虽然户部是个烂透的像垃圾一样的人，不过我觉得还是个不错的家伙来的。」 姬菜：「没戏没戏。比取谷君的话，像这种事应该能懂吧？因为，现在的我和谁往什么的是绝对不可能的嘛。」 「这样的事……」 「是存在的哦。」 海老名同学间不容发的回答道。 「因为，我腐烂了。」 我想，这里的腐烂是一语双关吧，一方面明指自己是腐女，另一方面其实暗指自己的处事方式，比起与朋友亲密相处，更…', '2019-02-24 09:02:46', '8', '12,6,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('28', '已经入门c++了，想更深入系统的学c++该怎样学？可以推荐相关的书籍吗？', 'None', '2019-02-24 09:02:47', '26', '16,1,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('29', '足球为什么是圆的？', '为什么最后定形是圆的，料子一样的话方的并不是不能踢啊，单纯为了发展团队合作设计成方便传球的圆形？', '2019-02-24 09:02:47', '29', '2,9,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('30', '如何看待吉利车模，顺便说说国产车的定位？', '如图，', '2019-02-24 09:02:48', '27', '4,8,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('31', '针对目前亚投行遇到的挑战，比如规范透明、控制贷款风险、协调成员国等，提出建议对策思考？', '针对目前亚投行遇到的挑战，比如规范透明、控制贷款风险、协调成员国等，提出建议对策思考', '2019-02-24 09:02:48', '50', '15,12,2', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('32', '明确知道两个人没有结果，不能结婚，为什么还要继续在一起？', '我的男朋友是阿拉伯人，是穆斯林，作为大汉民族的女生以后和他不能结婚，他也明确告诉我我们以后不能结婚，我们还是继续在一起，只是每次有未来幻想时，两个人都会陷入尴尬和无奈中，我不知道我是否应该和他继续下去，以后注定会分手。', '2019-02-24 09:02:48', '48', '2,4,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('33', '中国有卖superdry吗？', 'None', '2019-02-24 09:02:50', '7', '8,9,2', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('34', '如果要你推荐一首近百字的诗词你会选哪首？', '古诗词，或潇洒或回首往事嘘唏不已，或发人深省的都可以，如果是你，会推荐哪一首古诗词写下来送给20～30的年轻人呢？', '2019-02-24 09:02:50', '43', '10,3,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('35', '有争议的海外信用卡扣款可以先冻结再申请拒付。对已划帐的争议扣款还能追诉回来么？VISA在国际结算中的作用', '关于国际信用卡海外不明或有争议的扣款', '2019-02-24 09:02:50', '43', '10,3,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('36', '为什么大家不爱党？', '高中生文科，已被课本严重洗脑导致自己没脑子。', '2019-02-24 09:02:51', '41', '4,2,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('37', '为什么去游乐园玩那些刺激的娱乐设施被转晕后会恶心甚至会吐?', 'None', '2019-02-24 09:02:51', '9', '16,6,9', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('38', '企业管理软件的营销怎么做？', '互联网太火的，但那时To C的，有谁知道TO B的苦闷。杜蕾斯，可口可乐的营销做的确实好，但是传统的企业管理软件公司没有一家做的好的。这是为什么呢？有没有为这类企业做整合营销的代理公司？', '2019-02-24 09:02:51', '26', '15,8,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('39', '我国制造业自主研发和购买技术差距在哪里？', '比方说，中国的“中华之星”高速列车的研发被边缘化，国家购买西方先进的高铁技术。那么从产业链发展和技术发展潜力两个方面看，自主研发技术和购买技术相比会有什么差距？ 根据知友的提醒，定义一下”自主研发“和”购买技术“ 自主研发：进口零件自行研究原理和技术细节，而后进行整合 购买技术：直接购买整套成熟技术，根据国内情况进行调整和消化 也许商业级、军事级的技术在这个问题上会有不同？', '2019-02-24 09:02:52', '28', '11,1,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('40', '两人恋爱对方不愿用合照做头像代表什么？', 'None', '2019-02-24 09:02:52', '11', '1,8,7', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('41', 'μ\'s的9位与希腊神话中的9位女神如何一一对应？', '在sh的百科中有提到过，想知道各位的看法', '2019-02-24 09:02:53', '24', '12,5,2', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('42', '《阿凡达》中左右两边各有一个可调节的螺旋桨的直升机未来真的会出现吗？理论上符合动力科学吗？', 'None', '2019-02-24 09:02:53', '20', '14,6,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('43', 'MRI扫描单这个结果是什么含义？', '什么情况啊。。膝盖要废掉了吗？最近没干啥啊。。', '2019-02-24 09:02:53', '23', '10,16,9', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('44', '一般写科幻小说需要注意哪几个要素？', 'None', '2019-02-24 09:02:54', '18', '8,1,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('45', '《爵士时代的故事》哪一个版本翻译得最好？', '很想看', '2019-02-24 09:02:54', '30', '14,1,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('46', '如果你能身临其境地感受到魔兽世界中的场景，你最愿意生活在什么地方，每天都做些什么？', '别和我说天天守敌对阵营的尸体啊！太low惹！ 如果是我，我选择生活在暴风城，就和傻馒一样，喜欢这个名字，而且暴风城附近风景很美。每天逛逛街，看看暴风城外的瀑布，去湖畔镇钓鱼，打野猪做烧烤，品尝各种美食。暴露惹阵营和吃货本质。', '2019-02-24 09:02:55', '48', '13,8,15', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('47', '如何有朋友？', '我是女生，最好的惟一的朋友不和我玩了。和同学没有共同话题，也不知道说什么。现在一个朋友都没有。好孤独，本身就内向。如何才能有一个朋友?', '2019-02-24 09:02:55', '2', '1,5,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('48', '如何通过所有途径营销自己？', '如何通过所有的途径来营销自己？让自己能成为某个领域的专家？', '2019-02-24 09:02:55', '43', '13,3,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('49', '入门级单反佳能700D如何？5000价位单反有哪些推荐，小白求大神指点?', 'None', '2019-02-24 09:02:56', '8', '8,9,1', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('50', '建築模型需要怎麼選擇工具？', '最近學校開始做模型發現手工刀非常難得切，總是切歪，雖然可能是剛開始不熟練。。以及用來做窗戶的透明板居然0.5mm完全切不動。。。 切好形狀後把圖紙揭下來就變得相當粘，過一會就變髒了，掉到地上就慘不忍睹。 以及如果是木造模型也要手工刀切麼。。有沒有容易使用的工具。 素材和工具要怎麼選擇，哪種材料哪種型號，有經驗的可以告訴我的話就太感謝了 以上問題麻煩解答啦，感激不盡 ', '2019-02-24 09:02:56', '41', '3,5,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('51', 'None', 'None', '2019-02-24 09:02:56', '27', '11,15,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('52', '什么样的台式电脑比较适合玩游戏（便宜一点的）？', '我比较喜欢玩游戏，大概也就是刺客信条，黑暗之魂，gta这一类的，所以想买个台式，但是是学生党，所以预算不是很多，4k以内，想要一款散热好一点，运行比较流畅的台式机，组装机或者牌子都无所谓，什么样的主机比较好，显示器呢', '2019-02-24 09:02:57', '14', '15,16,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('53', '为什么每次睡完午觉脸都肿肿的?', 'None', '2019-02-24 09:02:57', '16', '9,1,1', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('54', '不相爱的父母为什么要在一起，为什么要生下小孩。为什么要让我讨厌“家”?', 'None', '2019-02-24 09:02:58', '8', '6,15,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('55', '本科生遭遇学术黑幕应该怎样处理？', '还是匿了。。。不敢找死。 今年省挑战杯赛，我们辛苦做了很久的一个项目经学院报到校团委，由', '2019-02-24 09:02:58', '46', '3,7,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('56', '一加的1步1步看清韩寒的文案是如何做到的？用打字机参与互动宣传的文案很有创意。？', 'None', '2019-02-24 09:02:58', '22', '6,5,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('57', '国内外搜索引擎得竞价排名系统大体上有哪些异同？', 'None', '2019-02-24 09:02:59', '4', '5,5,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('58', '中式建筑和欧式建筑有什么区别？怎么发展出区别的？有什么相同之处吗？', '这种建筑风格的差异是怎么产生的？材料和气候以外还有什么因素？', '2019-02-24 09:02:59', '41', '7,13,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('59', '知乎是否应该限制营销软文？', 'None', '2019-02-24 09:03:00', '9', '16,1,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('60', '如果分手该怎么走出失恋阴影？', 'None', '2019-02-24 09:03:01', '3', '8,4,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('61', '电机维护？', '电机日常维护与检查', '2019-02-24 09:03:01', '50', '5,14,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('62', '如何才能上微博热评？', '有很多时候，刚好赶上明星发微博，便都会去评论个几句，但总是上不了热评，也想过一些稀奇古怪的评论，但都不行，很想试试被赞得手机嘟嘟响的感觉。', '2019-02-24 09:03:01', '14', '7,6,2', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('63', '父母情商低是怎样的一种体验？', 'None', '2019-02-24 09:03:02', '2', '13,3,2', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('64', 'Nexus5 (型号D821，未经过root)在中国大陆能否收到谷歌的ota推送从而进行系统升级？', 'Nexus 5，型号D821，未经过root', '2019-02-24 09:03:03', '48', '3,9,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('65', '直男真的能灵活运用各种表情聊天？', 'None', '2019-02-24 09:03:03', '29', '2,11,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('66', '一个女生曾多次被不同的男性朋友差点侵犯，能分析一下为什么吗?', '女生性格很好，爱笑，微胖，不太会拒绝，一般是有求必应。 大概是从初二的时候开始，一个平时玩的还不错的男生，欲对我不轨，我反抗了之后，他住手了，因为当时什么都不太懂，就原谅了他。 然后是高中的时候，是有两个男生，我把他们当成朋友，他们却以这种方式伤害了我。 现在是大学，大一，认识了一个工作的男人，比我大几岁，他经常叫我出去吃饭，看电影，因为认识时间短，不太熟，所以能拒绝就拒绝了， 没课的时候出去过几次…', '2019-02-24 09:03:04', '22', '14,9,15', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('67', '为什么中国的动漫产业始终发展不起来？', '能出没和喜羊羊发展迅速，但魁拔系列无限延期，众多国产优秀青少年动漫也都因为各种原因停止或延期，原因是什么？', '2019-02-24 09:03:04', '29', '5,12,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('68', '为何读外国经典小说也不知道它哪里经典?', 'None', '2019-02-24 09:03:05', '23', '9,7,1', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('69', '有没有经营得好的家庭的栗子？', 'None', '2019-02-24 09:03:05', '22', '14,2,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('70', '军盲对《美国狙击手》的几个问题？', '1.影片中有一段是冲进饭店，结果见到一堆分尸和吊着的人，那些是什么来的？ 2.有一段他们开车去跟踪敌人，但一条街上车都不多一辆他们还穿着军装，不是明摆着让敌人知道被跟踪吗？ 3.他们被狙击手击中时总是一群人起来对着不同方向射击，这样的作用是什么？既不可能射中远处的狙击手，还会暴露自己。 4.像男主射杀这么多人的士兵薪酬会多点吗？', '2019-02-24 09:03:05', '38', '7,10,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('71', '公婆爱控制我们，控制我们的资金，什么都管，连敷面膜都要管，怎么破？', '立马切入正题，我们小两口刚结婚，平时上班后攒的钱被家公拿去炒股票。他是个炒股高手，也是个谨慎的人，交给他炒的确是个稳赚的事情。但是！！！我们是一个新家庭了，虽说他不会骗走我们的钱，我也从来没有怀疑过。 他们俩的控制欲不是一般人能承受的，什么都要管，连我敷面膜都要管，说：“现在的面膜都有毒，你又不是小姑娘还没嫁，嫁了哪里需要敷面膜，还浪费钱。”…………听到后我忍住了情绪…最鸡毛蒜皮的是连结婚那会改…', '2019-02-24 09:03:06', '14', '8,11,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('72', '为什么有些大学在省内招生是重本，而在省外招是二本？', '如题', '2019-02-24 09:03:07', '32', '12,4,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('73', '宿舍新装了个奇怪的东西，不知道是干什么用的？', '好奇的不行 ----------------------------------------------------------------------------萌萌哒的分割线----------------------------------------------------------- 以上是原题主的提问 我们宿舍也装了个奇怪的东东 0.0 同问是什么 =￣ω￣=', '2019-02-24 09:03:07', '22', '14,13,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('74', '餐桌什么牌子最好?', 'None', '2019-02-24 09:03:08', '11', '7,3,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('75', '当我见同学家长 我该谈些什么?', '跟同学去家里玩，比如吃饭的时候，跟他父母应该聊些什么 不显得没话找话，自然恰到好处的话题', '2019-02-24 09:03:08', '33', '9,12,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('76', '有没有类似于反斗神鹰一样的神剧喜剧。求各位大神推荐?', 'None', '2019-02-24 09:03:08', '48', '5,4,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('77', '我的栀子花病了，大神们谁能救救它。？', 'None', '2019-02-24 09:03:09', '31', '2,3,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('78', '一定要先改变自己才能改变他人乃至改变世界？', 'None', '2019-02-24 09:03:09', '46', '12,11,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('79', '学电子的人平时看什么网站或者论坛？', 'None', '2019-02-24 09:03:10', '32', '14,3,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('80', '在大学如何与一些陌生同学深交，特别是在某些方面有专长的人？', '我在大学交友的圈子太窄，感觉就只有一个宿舍内的，想找个高年级的学长或学姐做好朋友，平时挺喜欢去自习室的，但感到太孤独，一方面是想扩展人际关系，也想找个人教我不会的知识。', '2019-02-24 09:03:10', '20', '7,12,1', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('81', '教育骗了一些落后地区的人？', '我现在读高三去年认识一个学姐她当时高三，她家里特别的穷，衣服都是穿哥哥姐姐的校服。她中考考上了一流中学但是为了助学金她来了我们这个二流中学。高中她最后年看她特别特别的努力，很多时候都是看她一个人，放假为了省车费，为了学习也不会回家留在学校。高考她去年考了580，忘记那个大学了。只知道今年听老师说，她报的解剖专业，因为根本不了解这个专业，不喜欢，甚至讨厌，最后逃课太多被开除了。我知道后有种说不出的感…', '2019-02-24 09:03:10', '30', '11,7,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('82', '堵车时后车一直开着远光怎么办？', '很难受，有没有办法抗议或者应对？', '2019-02-24 09:03:11', '27', '6,4,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('83', '偶遇2次，很有感觉的女生。请问怎么搭讪？或者切入点', '这几天吃早饭，会碰到一个女生。第一次见面就感到是自己喜欢的类型，自己不敢搭讪，或者说不知道该怎么搭讪，今天第二次遇到了，依旧心动，求大师跟我指点指点。', '2019-02-24 09:03:11', '39', '15,15,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('84', '单身用什么样的厨具，小巧一点，一个人用的，可以煮煮面，热热东西的？', 'None', '2019-02-24 09:03:11', '8', '10,16,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('85', '最近跟现实生活与抉择亲密接触，发现成人的世界没有容易二字，想问为什么学生时代不容易产生绝望感？', '不是德智体美劳全面发展的好学生，最近感觉要克服无数次绝望感才能过好这一生，喜欢的人，喜欢的工作，喜欢的生活都那么来之不易，因为发现知识真的可以转变成金钱，至少做工程是这样，那些以后的筹码，学历，六级，二建这些，说实话，觉得得来没有需要那么艰难，为什么学生时代可以努力而没有那种绝望感呢？', '2019-02-24 09:03:12', '28', '13,9,9', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('86', '有哪些5K左右适合女生用的手机？', '适合女生即:外表美观，单手可操作。', '2019-02-24 09:03:12', '21', '14,15,15', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('87', '把大额资产(上十亿)从香港转回内地难在哪儿？有哪些方法可以操作？', 'None', '2019-02-24 09:03:13', '6', '2,16,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('88', '如何评价泰国电影《对不起，谢谢，我爱你》？', '电影情节', '2019-02-24 09:03:13', '36', '8,2,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('89', '高频交易获利安全吗？', 'None', '2019-02-24 09:03:13', '22', '1,11,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('90', '新买5s其他内存占了8g？', '3我今天才买的5s睡觉之前可用内存还有9g睡觉起来就只剩3g了 连接电脑上看其他占了8g 到底是什么情况啊 突然又变成可用6g 这是我刚才的', '2019-02-24 09:03:14', '44', '6,1,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('91', '在医院实习时，怎么做，才能尽量减少被主任批评的几率？', '医学生快进入实习阶段了，心理有点紧张，听学长说好像主任动不动就会骂人，那么应该怎么做，才能尽量减少被主任批评的几率？', '2019-02-24 09:03:15', '34', '16,11,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('92', '经过改装的59式是否有与三代坦一决高下的能力？', '指两方的的 数量X成本 相同的情况下，大改、魔改均可。允许有狼群等开挂行为', '2019-02-24 09:03:15', '33', '10,10,9', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('93', '狗狗一直抹自己的面部，一直不停的动是怎么回事？', 'None', '2019-02-24 09:03:15', '34', '2,9,2', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('94', '物业企业适合哪种绩效考评方法？', 'None', '2019-02-24 09:03:16', '41', '3,4,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('95', '屁话太多的人怎样让他闭嘴?', '总是喋喋不休的说很久，让人想把袜子塞到她嘴里让他闭嘴，说了很长时间后往外走时还在说，有时候走着走着又绕回来说，说什么可以让他闭嘴然后再也不说话', '2019-02-24 09:03:16', '16', '13,2,2', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('96', '道不同不相为谋吗？', 'None', '2019-02-24 09:03:17', '32', '6,2,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('97', '如何看待B站重开邀请码？', 'None', '2019-02-24 09:03:17', '19', '1,13,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('98', '如何挑到适合自己体型的白衬衫?版型？面料？', 'None', '2019-02-24 09:03:18', '35', '11,12,7', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('99', '在一起恋爱七年了，还没结婚，现在没话讲了怎么办？', '在一起恋爱七年了，还没结婚，现在两个人不在一个城市，他总觉得我孩子气，跟我说不来。我也只是跟他讲我的近况，讲我身边有趣的事情，因为不在一起，很少见面，如果我不说他就不会知道我的任何事情了啊。 我也想要变成他要的那种成熟，知性的女生。但是这不是还要个过程的嘛', '2019-02-24 09:03:18', '8', '4,12,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('100', '我该怎么挽回?', '你好，谢谢你帮我分析下我现在能挽回吗？ 我们还不是男女朋友，但是因为我太粘人而且爱发点小脾气，让她对我失望了，她说以后没有机会了，机会是零。改不改和她没关系了。我们之前有过两个月的一起吃晚餐，该走的时候，可是我总舍不得，结果让她先提出来，我很粘人。这是生气的第11天，第7天接我电话以后，她就开始说她现在对我很厌恶，让我不要联系她，做朋友偶尔联系下就行。我说那我不是没机会了，她说如果不联系机会是零，那…', '2019-02-24 09:03:18', '1', '4,16,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('101', '如何将小清新融入花艺之中（现在不是流行这一块么）？', 'None', '2019-02-24 09:05:02', '8', '11,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('102', '广州成人钢琴零基础学琴哪里好？不是速成哪种，需要专业一点的谢谢！！', '本人很喜欢钢琴，最近想抽时间去学习一下，不想学速成的，想从基础学起~~有没有人了解过？', '2019-02-24 09:05:03', '10', '9,7', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('103', '植物的某一部分离体后，细胞失去活性的时间是多久？是不是与植物本身有关？DNA失去活性的时间是多久？', 'None', '2019-02-24 09:05:03', '29', '9,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('104', '为什么在眼皮上贴个小红纸就能压制住眼皮跳呢？', 'None', '2019-02-24 09:05:04', '50', '3,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('105', '什么是「圣人」？', '各家各派都有圣人这个说法，那么谁说的对呢？怎样算是一个圣人？ 曾国藩有一句圣人必可学而致之，可是他应该不算是圣人吧？ 孔老夫子能算圣人吗？', '2019-02-24 09:05:05', '44', '5,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('106', '有哪些作恶一生依旧活得很好的人？', 'None', '2019-02-24 09:05:05', '36', '11,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('107', '保险方案的概念?', '官方概念', '2019-02-24 09:05:05', '40', '14,2', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('108', 'None', 'None', '2019-02-24 09:05:06', '25', '10,15', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('109', '知乎交流平台限制太多会怎样？', '保护环境固然很好，但是限制太多会不会使得太多人不敢发言或是不想发言。（对这一问题，本人保持中立）', '2019-02-24 09:05:06', '17', '5,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('110', '前任对于以后生活中应该扮演怎么样一份角色？', '谁没有个青春，谁没有过一场刻骨铭心的恋爱。但对于错过我们未来，那曾经在某一段时光中，曾对于我们来说最重要的那个人，在现在或将来结你又有怎样影响？', '2019-02-24 09:05:07', '45', '1,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('111', '不喜欢自己的人会有一天改变自己的想法喜欢上自己吗？', '喜欢一个男生，可是拒绝我了，狠狠的拒绝了，连朋友都不和我做，我原以为他把我当朋友，可是却不是我想的，可我还是过不去这个坎，会不会有一天他看到我的好了，就会和我在一起呢，我再努力努力是不是会改变呢', '2019-02-24 09:05:07', '16', '7,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('112', '豆瓣有哪些靠谱的同志兴趣小组？', '比较活跃质量高一些的因为发现二线城市的小组不活跃', '2019-02-24 09:05:07', '21', '7,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('113', '我姐申请参加盐club，但是没有被邀请。到现在心情还不好。我要怎么安慰她？', '她一直很阴郁，我都不敢和她说话了', '2019-02-24 09:05:08', '32', '14,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('114', '求鉴别到底是鸢尾还是紫罗兰？', '在校园里碰到如图花，黄色的是在水里种的，紫色的是在草坪里。截图是百度到的鸢尾和紫罗兰，但是小伙伴搜索紫罗兰的时候，竟然出现的是鸢尾！直接蒙B了，求大神解答。果壳上不去，发帖不成。。。 后面这两张是截图。。前两张是在学校拍到的。', '2019-02-24 09:05:09', '17', '11,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('115', '为什么很多人最终都变成了自己讨厌的模样？', '自私冷漠懒惰 可能是人的通病吧 内心深处不愿承认', '2019-02-24 09:05:09', '45', '2,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('116', '家里姐弟有精神病，我该怎么办。？', '求助', '2019-02-24 09:05:10', '29', '13,7', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('117', '作为入行数年的专业科研工作者，你每周看几篇 paper ？', '我挺想了解做科研的各位在看paper上是一个怎样的节奏。 一般每周看多少篇？ 粗读、精读的情况是怎样的？ 回答时请说明自己是在哪个领域，谢谢。', '2019-02-24 09:05:11', '13', '12,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('118', '怎样在大学保持高中时学习的那股劲儿？', 'None', '2019-02-24 09:05:12', '26', '2,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('119', '我国有没有颁布知识产权保护法？', '台湾地区的法律和我国的差别大不大？台湾知识产权保护法怎么样？', '2019-02-24 09:05:12', '32', '3,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('120', 'NTJ对个人自由要求高，但是同时INTJ也按照计划循规蹈矩，为什么？', '在一个回答里发现说intj要求个人自由，不适合当军人。 但是很多时候，intj是按计划做事。 ', '2019-02-24 09:05:12', '18', '13,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('121', '观音菩萨在西方极乐世界能排第几？除了如来佛祖，还有谁是最厉害的？', 'None', '2019-02-24 09:05:13', '41', '4,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('122', '为什么在一些客车上的字车一边顺着写（xy客运公司）在车的另一边反着写（司公运客yx）？', 'None', '2019-02-24 09:05:14', '26', '4,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('123', '和一个性格温润的男生在一起，性格变得越来越man了怎么办?', '如题，和一个性格温柔和善型，从不装逼老实型的男生在一起，一年了。想当年我也是淑女一个，文静内敛，可是最近发觉性格潜移默化的变化。快准狠，雷厉风行，说话做事像个男生一样，还觉得他说话做事不利索，像个女生。为什么他的性格没有对我产生积极影响反而让我变man了-_-我该怎么改变', '2019-02-24 09:05:15', '44', '3,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('124', '女生每天往脸上拍的水啊乳啊皮肤真的能吸收吗？', 'None', '2019-02-24 09:05:16', '21', '16,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('125', '如何看待雄鹿对公牛第六场惨绝人寰的惨败？', 'None', '2019-02-24 09:05:16', '41', '10,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('126', '如何安慰手机被偷的朋友？', 'None', '2019-02-24 09:05:17', '44', '11,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('127', '广场舞算不算非法集会？', '如题 如果算能不能报警 报了警要是警察不管怎么办', '2019-02-24 09:05:19', '19', '8,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('128', '我国传统戏剧有没有可能走歌剧到音乐剧这样的进化路线？', '首先我不否认我国传统戏剧很有魅力，但我实在是觉得现在它们挺难吸引除了发烧级粉丝以外的人的兴趣。去年在国家大剧院看了《西厢记》，那么大的场地，那么豪华的剧院，仍然是几个人，穿着现在看来已经有点朴素的戏服，在没有任何道具和场景的舞台上咿咿呀呀一唱好几小时，连标榜喜爱传统的我爸妈和我公公婆婆都睡着了，旁边的观众也是该睡的睡该找乐子的找乐子，又不敢吐槽生怕别人觉得他们“不懂传统文化”遭人耻笑。剧终了我们…', '2019-02-24 09:05:21', '20', '12,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('129', '为什么一般人在放松时会稍息姿势站立，重心偏离到单脚上？', '如题，经常观察到一些人在等待的时候会情不自禁做出“稍息”的姿势，自己也常常会这样，似乎全身重量偏离到其中一只脚会更轻松，但为什么不是两只脚平摊重量更轻松一点呢', '2019-02-24 09:05:22', '6', '12,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('130', '一般MRI诊断的所谓“前十字韧带损伤”，“前十字韧带损伤”和十字韧带撕裂之间有区别吗？', '这是我同学MRI的诊断结果。请问所谓的“部分损伤”，和一般我们听到的运动员的韧带撕裂，乃至韧带断裂是什么关系？还有半月板损伤就是指半月板撕裂吗？', '2019-02-24 09:05:23', '28', '5,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('131', '怎么改掉自己爱看手机的毛病？', '睡前看手机，睡醒看手机，上厕所看手机，没事总爱看一下手机。明明知道没有人找，还是要看一下微信啊知乎啊之类的各种app 不停刷新 明知道没有意义 几乎是没几分钟看一次 觉得自己这样真的很不好 有没有办法可以改掉？', '2019-02-24 09:05:23', '49', '10,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('132', '广州最好吃的面包在哪里？', '半夜梦见吃面包。。。然后饿醒了。。。跪求广州最好吃的面包，不然睡不着了', '2019-02-24 09:05:24', '48', '1,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('133', '有那些比较好的入门级建筑安全类书籍?', '我男朋友是计算机专业转安全员的,目前正在做码头工程,由于专业不对口,工作起来比较困难,请问有没有一些简单易懂的,入门必学知识的建筑或者市政或者水利的安全管理类书籍介绍?', '2019-02-24 09:05:24', '29', '14,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('134', '当男友在朋友圈留言叫自己肥肥的时候如何机智的回答？', '朋友圈机智回复', '2019-02-24 09:05:26', '9', '16,1', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('135', '如何把不要的东西丢掉？', '房子是多年前买的，住了好久，跟家里情况、爸妈观念有关，我们家都特别不舍得丢东西，小到一块连抹布都做不了的布、一根吸管、一个手表盒子、一条抽奖来的塑料手链，大到旧电脑、旧电视、很多很多的旧衣服。旧的不要了不舍得扔就在那里堆着，然后继续往家里买新的来，东西越来越多，就堆在那里，旧的东西不管，新的也不珍惜。然后东西也没个固定的地点，用到哪儿算哪儿，用完就堆在那儿，从来不会放回原来的位置，要用了找不到就…', '2019-02-24 09:05:26', '43', '4,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('136', '有一个分数序列 2/1,3/2,5/3,8/5,13/8,21/13,....... 求这个序列的前20项之和？', '要求用C语言编写且不带指针', '2019-02-24 09:05:27', '6', '8,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('137', '特别想听冬吴相对论评论uber，想听听两位的看法？', 'None', '2019-02-24 09:05:29', '10', '11,9', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('138', '从事肿瘤研究的PhD在肿瘤被人类彻底治愈后怎么办？', '假如，指的是假如，有一天出现一位千年一遇的牛人做出了堪比宇宙起源和大统一理论的研究成果，推动了医学发展，让所有的癌症在短短几个月内就被人类彻底攻破。这样的话，研究机构里从事癌症研究的研究员怎么寻找出路？如果是更改研究方向，研究肿瘤的技能、思维和知识储备如何迁移到其它研究方向？', '2019-02-24 09:05:29', '20', '6,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('139', '求高人指教，香灰为何中间呈现黑色?', '回家后给财神上了个香，不为什么，就是想看看他，但是香灰中间是黑色的，不知道是不是预示着什么，求教！', '2019-02-24 09:05:30', '1', '10,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('140', '眼睛周围的扁平疣怎么治啊？', 'None', '2019-02-24 09:05:31', '8', '12,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('141', '女友一点没有信用 怎么办？', '骗人和他说了 还骗', '2019-02-24 09:05:31', '36', '6,1', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('142', '为什么onenote中文搜索问题迟迟得不到解决？', 'onenote的中文搜索有很多问题，其中一个是同音字搜索问题。在onenote页面上搜索中文字，会搜索出所有包含同音字的结果。比如搜索“油”会匹配到“邮”。根据此贴： ', '2019-02-24 09:05:32', '48', '5,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('143', '港大和清华的Computer Science谁更强？ ？', 'None', '2019-02-24 09:05:33', '14', '11,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('144', '若离去，后会无期?', '我曾经喜欢你并且也得到了你的回应，不管怎么说我们有过一些很美好的回忆，相对于很多人我已经足够幸运。我拥有过一段感情，在这段感情中我认真地爱过，努力地经营过，我对得起自己的心。我不能控制我们的感情，但我可以控制我自己的感情，虽然这段感情有遗憾，但我却没有遗憾。', '2019-02-24 09:05:33', '19', '8,1', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('145', '想找一个期刊 不受版面费且是北核以下的？', '最近写了文章 考虑文章质量太差 想找一个期刊 不受版面费且是北核以下的 投过去 也比死在自己手上好 求推荐期刊 ', '2019-02-24 09:05:33', '26', '1,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('146', '对于益智类节目的看法?', '看了下节目选手答题，然后和老爸讨论了一下，意见不同。 记住一些知识标签然后答题时就显得很有学识的样子，（不是不爽，只是有些是可以当做常识记住的） 想起那些名著只看导言概序，然后侃侃而谈的人来显示优越感（个人偏见罢了）感觉太浮躁了，对知识没有敬畏感', '2019-02-24 09:05:34', '32', '8,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('147', '程序员加班到什么程度，才能获得全国五一劳动奖章？', 'None', '2019-02-24 09:05:35', '48', '10,1', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('148', '为什么李贽的《焚书》没有被焚?', 'None', '2019-02-24 09:05:36', '18', '3,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('149', '1~n^3中随机取出n个数，他们唯一的概率？', '算法导论', '2019-02-24 09:05:37', '22', '2,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('150', '男生不想谈恋爱是什么原因?', 'None', '2019-02-24 09:05:39', '46', '12,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('151', '已保研985非计算机类专业，想放弃保研从事编程类工作，考研还是工作？', '本人是男生，本科是环境工程，已经保上南方某985高校，在实验室搬砖后越来越感觉对本专业不感兴趣，再加上自己对编程有兴趣，想放弃保研，要成为程序员，是考研还是工作？', '2019-02-24 09:05:40', '43', '1,7', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('152', '如何评价佐藤健和黑木华主演的日剧《天皇の料理番（天皇的料理人、天皇的御厨）》呢？', 'ACFUN第一话：', '2019-02-24 09:05:40', '25', '4,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('153', 'None', 'None', '2019-02-24 09:05:41', '43', '8,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('154', '中西方恋爱观都有什么区别？ ？', '可详细描述和欧美女（男）孩谈恋爱是一种怎么样的体验。 可从恋爱心理，关系确定的顺序等方面描述', '2019-02-24 09:05:42', '28', '14,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('155', '我想知道 大学中兼职的平台 他们是如何联系到当前城市需要兼职的厂家的，又是如何合作的?', 'None', '2019-02-24 09:05:42', '12', '2,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('156', 'James Bay的Hold Back the River为什么前奏这么熟悉，觉得像是一首日文歌里的？', '哪位大神知道是哪首歌里的？困扰一整天了…强迫症睡不着啊…', '2019-02-24 09:05:43', '34', '2,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('157', '人为什么需要睡那么长时间？我指的是至少要6-8个小时。 人睡觉的时候各器官都在干嘛？', 'None', '2019-02-24 09:05:43', '8', '5,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('158', '适合一个人做的事。?', '大四单身男很闲，但不想和身边的人一起做什么，又感觉生活很无聊很孤独。除了看书看电影，还有什么事是很适合这样一个人做的。', '2019-02-24 09:05:44', '44', '14,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('159', '为什么最近一段时间到处都有人在学习炒股？', 'QQ，微博，空间，到处看到有人在学炒股，而且电视新闻里面也曾经报道过某大学某班超过半数同学都在炒股，这是怎么回事呢？', '2019-02-24 09:05:44', '16', '15,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('160', '在四川进行关于现代农业的暑期社会实践有什么建议或者推荐走访的企业?', '川农学子，想做一次社会实践，了解四川省内有机农业，绿色农业或是生态农业的发展现状，公司运营状况和规模等，给涉农类大学生就业方面一个社会大背景引导，和现状知己知彼，为之后的一些创业和就业提供指导~请教一下这个项目本身的意义程度和实施方法，注意事项等~谢谢~', '2019-02-24 09:05:46', '25', '7,7', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('161', '父母强迫我们去喜欢一个看了一眼就没有感觉的人，除了对方的经济条件还可以之外其他的都很一般！该怎么办?', 'None', '2019-02-24 09:05:46', '31', '5,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('162', '我是针灸推拿本科生，如果考研北上广天津，哪个中医院校针推专业比较好呢？', 'None', '2019-02-24 09:05:48', '6', '6,14', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('163', '职业发展?', '以前做资信评级，现在换工作，有两条路，一个是新成立的p2p平台做风控，一个是小券商公司承做机构业务，到底该怎么办呢？这两块都不怎么懂，不知道以后发展哪个更有前途？', '2019-02-24 09:05:49', '22', '5,6', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('164', '能做到忘我、投入地演奏一种乐器，是一种什么样的感觉？', '一个人演奏，不管有没有观众', '2019-02-24 09:05:49', '15', '14,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('165', '我在国外旅游，买了很多当地的纪念品，包括菩提子，宝石等等，希望能拿到国内来卖，但不知道怎么过海关检查?', '我在国外旅游，买了很多当地的纪念品，包括菩提子，宝石等等，希望能拿到国内来卖，但不知道怎么过海关检查', '2019-02-24 09:05:50', '31', '4,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('166', '高考三十天如何提高理综成绩？', '目前语数外都还不错 可理综一直上不了200 有没有可能三十天提高到220', '2019-02-24 09:05:50', '28', '5,15', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('167', '人们喜欢做的事应该不是单一的吧？那怎样找到自己喜欢做的事？', 'None', '2019-02-24 09:05:50', '32', '13,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('168', '怎么才能不懒惰？', 'None', '2019-02-24 09:05:51', '26', '10,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('169', '什么技能能在家自学并且能带来经济上的收益？', '比如ps，但是有点难度，觉得没老师带自学还挺费力的。以后做做美工什么的…其他的呢？', '2019-02-24 09:05:51', '31', '7,15', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('170', '古玩鉴定?', '不知道怎么得来 [图片未上传成功] [图片未上传成功]', '2019-02-24 09:05:52', '20', '8,7', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('171', '太老实，没有心机，没有手段，没有城府，被人欺负不会反抗怎么改变？', 'None', '2019-02-24 09:05:54', '46', '11,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('172', '俄语专业除了四八级还有哪些资格证比较值得考呢？国际商务俄语等级考试的资格证能被大多数企业认可吗', '今年大三了，想多考一些有帮助的资格证', '2019-02-24 09:05:55', '46', '1,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('173', '出门玩晚归被领导撞见，心塞怎么破？', 'None', '2019-02-24 09:05:55', '34', '14,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('174', '怎么吸引别人的注意力？并且和人相处融洽？', '面临即将踏上社会，EQ低就不好生存了啊。 感觉自己EQ低，很担心以后不能好好跟人处，很羡慕宝钗那样的八面玲珑，可是不知道怎么做到？ 平时在学校和同学我还是会打打闹闹，可是放假不会找我玩。咳咳，我是个半宅，不算很宅，感觉己有点社交困难。 有时候面对陌生人好像不太会相处，不知道要聊什么话题吸引别人！？一下子熟络起来？希望能得到大家的回答！', '2019-02-24 09:05:57', '23', '9,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('175', '早上起床漱口是在早饭前好一点还是早饭后呢 ？晚上又是什么时候漱口比较好？', '因为自己发现有些人只喜欢早上起床就漱口，然后就吃早饭。时间久了，给我的感觉就像他们早上只是漱了一口水一般。', '2019-02-24 09:05:57', '12', '13,9', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('176', '公交司机行驶时会自己拿出一张卡在刷卡器刷一下，请问他们是在做什么？', 'None', '2019-02-24 09:05:58', '41', '14,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('177', '分别在上学和工作的两个同龄人在一起会怎样?', 'None', '2019-02-24 09:05:58', '40', '2,13', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('178', '听京剧是否有利于提高相声水平？', '我这里不只指黄鹤楼全德报这些腿子活', '2019-02-24 09:05:58', '29', '1,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('179', '想带2岁半的女儿去英国体验生活1-2周，定airbnb靠谱吗？安全吗？', '最近有个大胆想法，想暑期带着两岁半女儿去英国短暂体验生活1-2周，就我一个人带！特别想住当地人家里，定个airbnb。但可能孩子会偶尔吵闹，饮食得我单独使用厨房做。这样的情况能订到吗？有可能实现吗？就想周边简单玩下，体验下生活。语言没有太大问题。 各位有经验的大侠们，能给点意见吗？', '2019-02-24 09:05:59', '22', '10,11', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('180', '求一些学习芳疗的课本，比较权威的书籍，可以是英文书籍。谢谢各位大大。？', '想了解芳疗，看了几本都觉得不够系统，各说各话。求专业或爱好认识推荐权威书籍。涉及理论知识或者一些芳疗课程所用的书籍书单都可以。', '2019-02-24 09:05:59', '1', '8,9', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('181', '在东风裕隆 做试制验证员是什么体验 ，个人发展空间 待遇如何？', '在东风裕隆 做试制验证员是什么体验 ，个人发展空间 待遇如何？', '2019-02-24 09:06:00', '22', '12,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('182', '你们有没有过见到第一眼的人却突然觉得打心眼里喜欢的经历？', '我还是实习幼儿老师的时候新来了一个两岁几个月的小男孩，只见了第一面我就忒喜欢他，刚开始以为只是他长得好看再加上新来比较调皮所以才会特别关注他。可是到后来实习结束之后几乎每晚都能梦见而且几乎都是长大以后的样子…所以我想问这种感觉你们有过吗？是真有前世今生还是只是痴女的表现？？？', '2019-02-24 09:06:00', '7', '4,9', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('183', '低级别地震时自己把自己吓出糗是一种怎样的体验？', '题主自身经历不忍回忆，来这里找找安慰', '2019-02-24 09:06:01', '26', '10,10', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('184', '请问红字是什么字体？', 'None', '2019-02-24 09:06:01', '34', '9,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('185', '如何看待知乎大v抱团现象严重？', '解答', '2019-02-24 09:06:01', '41', '8,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('186', '毕业设计要写区域性快递业务流程优化，可有大神可以对区域性快递有比较好的诠释？', 'None', '2019-02-24 09:06:02', '11', '1,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('187', '我做了一个仰卧起坐，能量去哪了呢？', 'None', '2019-02-24 09:06:03', '3', '2,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('188', '女生，170/48kg,小腿与腰腹部怎么减？', '哦对了，我平胸', '2019-02-24 09:06:04', '42', '16,8', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('189', '如何在手机Quora软件上安装字典？', '要是有字典插件，遇上生词，长按一下就能显示词意，该多好啊！有没有办法啊？', '2019-02-24 09:06:04', '17', '8,1', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('190', '从精灵梦叶罗丽上还能看出国产动漫有希望吗？', '国产动漫的未来', '2019-02-24 09:06:05', '39', '4,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('191', '国外（欧洲）有网吧吗？是什么样子的？', 'None', '2019-02-24 09:06:05', '3', '3,4', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('192', '三百五十平方米的一层，适合做什么？', '在二线城市，两个商圈交界处。车流人流量都不错。有三百五十平使用面积的一楼，二至六楼是我们的酒店和咖啡厅。适合做什么生意？静吧或者演艺吧可以么？', '2019-02-24 09:06:06', '46', '1,15', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('193', '请教一下这是什么石头？有价值么？', '结婚时候朋友送来的，也是别人送他的。我俩都不知道是什么石头，想请教一下，要是有价值我就做一托摆上，没价值就扔池塘里摆着了…', '2019-02-24 09:06:06', '42', '2,3', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('194', '该不该继续接受一个不喜欢的人？', '马上30了，身边的人都结婚了，谈了两次恋爱都因为失去自我而分手，让我认识到必须找一个爱自己的人结婚…通过相亲认识的一个男人，很喜欢我的样子，各种殷勤，但因为成长环境的不同，我觉得聊不到一起，但又对我很好，恨嫁却又不喜欢，该如何取舍？？', '2019-02-24 09:06:06', '41', '13,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('195', '含钪岩石中，钪的品位或者说其氧化物的品位要达到多少才算有经济价值？', '最近正在读有关稀土的知识，说钪的平均丰度是36ppm，而个别钪矿床品位最低的也有15ppm,虽然说品位低但储量大。那么假如一块岩石样本中钪的含量达到了40-50ppm的区间，那么能否说它可能有经济价值', '2019-02-24 09:06:07', '33', '14,12', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('196', '如何看待中国现在的直销产业？是否处于合法状态，其现状如何，请懂的人赐教，谢谢！?', 'None', '2019-02-24 09:06:09', '12', '4,5', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('197', '怎么判断一家贵金属公司投入资金是不是可靠？', '现在贵金属投资公司很多，怎么知道钱投进去以后是不是只能看到几个数字，老板拿了你钱就跑呢？', '2019-02-24 09:06:09', '21', '2,15', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('198', '如何评价微软 Build 2015 的 Android 子系统来对 apk 进行支持？', '这样做效果好吗？实现原理？大概又是如何对apk直接生成appx呢', '2019-02-24 09:06:09', '28', '11,16', '0', '0', '0', null);
INSERT INTO `questions` VALUES ('199', '大四找工作失败被打击会使一个人蜕变吗，完全变励志型？', 'None', '2019-02-24 09:06:10', '4', '14,2', '0', '0', '0', null);

-- ----------------------------
-- Table structure for `search_word`
-- ----------------------------
DROP TABLE IF EXISTS `search_word`;
CREATE TABLE `search_word` (
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '搜索的内容',
  `time` int(10) NOT NULL DEFAULT '0' COMMENT '总共被搜索了多少次'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of search_word
-- ----------------------------
INSERT INTO `search_word` VALUES ('王刚', '1');
INSERT INTO `search_word` VALUES ('美食作家王刚', '0');
INSERT INTO `search_word` VALUES ('厨师长', '0');
INSERT INTO `search_word` VALUES ('华农兄弟', '0');
INSERT INTO `search_word` VALUES ('竹鼠', '0');
INSERT INTO `search_word` VALUES ('王家刚刚来', '0');

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
  `name` text NOT NULL,
  `userID` int(10) NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` int(2) NOT NULL,
  `target` int(10) NOT NULL DEFAULT '0',
  `content` text NOT NULL,
  PRIMARY KEY (`noticeID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_message
-- ----------------------------
INSERT INTO `sys_message` VALUES ('1', '系统通知啊，今天要例会', '1', '2019-01-25 14:29:09', '0', '0', '');
INSERT INTO `sys_message` VALUES ('2', '您已被管理员邀请加入群聊 project-agent讨论群 ,请及时确认！', '1', '2019-01-25 13:52:22', '2', '2', '');
INSERT INTO `sys_message` VALUES ('3', '明天要例会！请各位做好准备！', '1', '2019-01-25 14:33:22', '1', '2', '');
INSERT INTO `sys_message` VALUES ('4', '明天要例会！请各位做好准备！', '1', '2019-01-25 14:33:31', '0', '0', '');
INSERT INTO `sys_message` VALUES ('5', '你的实名认证申请未通过！', '1', '2019-02-02 21:49:36', '1', '4', '');
INSERT INTO `sys_message` VALUES ('6', '你的实名认证申请未通过！', '1', '2019-02-02 21:50:38', '1', '5', '');
INSERT INTO `sys_message` VALUES ('7', '你的实名认证申请未通过！', '1', '2019-02-02 21:50:49', '1', '7', '');
INSERT INTO `sys_message` VALUES ('8', '你的实名认证申请未通过！', '1', '2019-02-02 21:54:56', '1', '6', '');
INSERT INTO `sys_message` VALUES ('9', '你的实名认证申请未通过！', '1', '2019-02-02 21:55:06', '1', '6', '');
INSERT INTO `sys_message` VALUES ('10', '你的实名认证申请未通过！', '1', '2019-02-02 21:55:29', '1', '6', '');
INSERT INTO `sys_message` VALUES ('11', '你的实名认证申请未通过！', '1', '2019-02-02 21:57:01', '1', '4', '');
INSERT INTO `sys_message` VALUES ('12', '你的实名认证申请未通过！', '1', '2019-02-02 21:57:49', '1', '4', '');
INSERT INTO `sys_message` VALUES ('13', '你的实名认证申请未通过！', '1', '2019-02-02 21:59:58', '1', '5', '');
INSERT INTO `sys_message` VALUES ('14', '你的实名认证申请未通过！', '1', '2019-02-02 22:11:18', '1', '6', '');
INSERT INTO `sys_message` VALUES ('15', '你的实名认证申请未通过！', '1', '2019-02-02 22:11:23', '1', '7', '');
INSERT INTO `sys_message` VALUES ('16', '你的实名认证申请未通过！', '1', '2019-02-02 22:17:41', '1', '4', '');
INSERT INTO `sys_message` VALUES ('17', '你的实名认证申请未通过！', '1', '2019-02-02 22:18:06', '1', '8', '');
INSERT INTO `sys_message` VALUES ('18', '你的实名认证申请未通过！', '1', '2019-02-03 10:58:11', '1', '4', '');
INSERT INTO `sys_message` VALUES ('19', '你的实名认证申请未通过！', '1', '2019-02-03 11:00:01', '1', '5', '');
INSERT INTO `sys_message` VALUES ('20', '你的实名认证申请未通过！', '1', '2019-02-03 11:04:06', '1', '6', '');
INSERT INTO `sys_message` VALUES ('21', '你的实名认证申请已通过！', '1', '2019-02-03 11:08:36', '1', '4', '');
INSERT INTO `sys_message` VALUES ('22', '你的实名认证申请已通过！', '1', '2019-02-03 11:10:20', '1', '5', '');
INSERT INTO `sys_message` VALUES ('23', '你的实名认证申请已通过！', '1', '2019-02-03 11:11:25', '1', '6', '');
INSERT INTO `sys_message` VALUES ('24', '您发布的问题 @测试提问 已被管理员清除！', '1', '2019-02-03 11:44:26', '1', '1', '');
INSERT INTO `sys_message` VALUES ('25', 'FirstCry！！！', '1', '2019-02-03 12:45:01', '0', '0', '');
INSERT INTO `sys_message` VALUES ('26', '测试！', '1', '2019-02-03 12:48:00', '0', '0', '啦啦啦');
INSERT INTO `sys_message` VALUES ('27', '测试！', '1', '2019-02-21 03:36:01', '0', '0', '点对点');
INSERT INTO `sys_message` VALUES ('28', '测试！', '1', '2019-02-21 06:44:32', '0', '0', '测试！');
INSERT INTO `sys_message` VALUES ('29', '测试！', '1', '2019-02-21 06:44:48', '0', '0', '测试！');
INSERT INTO `sys_message` VALUES ('30', '测试！', '1', '2019-02-21 06:45:09', '0', '0', '测试！');

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
) ENGINE=InnoDB AUTO_INCREMENT=4062 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户行为表\n';

-- ----------------------------
-- Records of useraction
-- ----------------------------
INSERT INTO `useraction` VALUES ('2267', '12', '1', '21', '2019-02-24 08:15:30');
INSERT INTO `useraction` VALUES ('2268', '27', '3', '21', '2019-02-24 08:15:31');
INSERT INTO `useraction` VALUES ('2269', '20', '24', '11', '2019-02-24 08:15:32');
INSERT INTO `useraction` VALUES ('2270', '7', '3', '21', '2019-02-24 08:15:33');
INSERT INTO `useraction` VALUES ('2271', '20', '3', '21', '2019-02-24 08:15:34');
INSERT INTO `useraction` VALUES ('2272', '35', '1', '1', '2019-02-24 08:15:36');
INSERT INTO `useraction` VALUES ('2273', '39', '56', '11', '2019-02-24 08:15:37');
INSERT INTO `useraction` VALUES ('2274', '38', '2', '21', '2019-02-24 08:15:39');
INSERT INTO `useraction` VALUES ('2275', '29', '5', '21', '2019-02-24 08:15:43');
INSERT INTO `useraction` VALUES ('2276', '26', '6', '21', '2019-02-24 08:15:45');
INSERT INTO `useraction` VALUES ('2277', '10', '1', '11', '2019-02-24 08:15:45');
INSERT INTO `useraction` VALUES ('2278', '10', '2', '21', '2019-02-24 08:15:47');
INSERT INTO `useraction` VALUES ('2279', '24', '43', '11', '2019-02-24 08:15:48');
INSERT INTO `useraction` VALUES ('2280', '4', '69', '11', '2019-02-24 08:15:48');
INSERT INTO `useraction` VALUES ('2281', '37', '2', '21', '2019-02-24 08:15:49');
INSERT INTO `useraction` VALUES ('2282', '37', '6', '21', '2019-02-24 08:15:50');
INSERT INTO `useraction` VALUES ('2283', '27', '83', '11', '2019-02-24 08:15:51');
INSERT INTO `useraction` VALUES ('2284', '42', '3', '21', '2019-02-24 08:15:52');
INSERT INTO `useraction` VALUES ('2285', '7', '2', '21', '2019-02-24 08:15:52');
INSERT INTO `useraction` VALUES ('2286', '46', '2', '21', '2019-02-24 08:15:53');
INSERT INTO `useraction` VALUES ('2287', '17', '1', '21', '2019-02-24 08:15:54');
INSERT INTO `useraction` VALUES ('2288', '31', '1', '21', '2019-02-24 08:15:57');
INSERT INTO `useraction` VALUES ('2289', '24', '98', '11', '2019-02-24 08:15:58');
INSERT INTO `useraction` VALUES ('2290', '2', '3', '21', '2019-02-24 08:15:59');
INSERT INTO `useraction` VALUES ('2291', '2', '1', '21', '2019-02-24 08:16:00');
INSERT INTO `useraction` VALUES ('2292', '40', '2', '21', '2019-02-24 08:16:00');
INSERT INTO `useraction` VALUES ('2293', '38', '6', '21', '2019-02-24 08:16:01');
INSERT INTO `useraction` VALUES ('2294', '2', '1', '2', '2019-02-24 08:16:03');
INSERT INTO `useraction` VALUES ('2295', '8', '3', '21', '2019-02-24 08:16:05');
INSERT INTO `useraction` VALUES ('2296', '1', '4', '3', '2019-02-24 08:16:05');
INSERT INTO `useraction` VALUES ('2297', '20', '3', '21', '2019-02-24 08:16:06');
INSERT INTO `useraction` VALUES ('2298', '20', '24', '11', '2019-02-24 08:16:07');
INSERT INTO `useraction` VALUES ('2299', '13', '14', '11', '2019-02-24 08:16:08');
INSERT INTO `useraction` VALUES ('2300', '23', '64', '11', '2019-02-24 08:16:10');
INSERT INTO `useraction` VALUES ('2301', '29', '2', '3', '2019-02-24 08:16:12');
INSERT INTO `useraction` VALUES ('2302', '30', '4', '21', '2019-02-24 08:16:13');
INSERT INTO `useraction` VALUES ('2303', '49', '6', '25', '2019-02-24 08:16:14');
INSERT INTO `useraction` VALUES ('2304', '2', '78', '11', '2019-02-24 08:16:14');
INSERT INTO `useraction` VALUES ('2305', '36', '6', '21', '2019-02-24 08:16:15');
INSERT INTO `useraction` VALUES ('2306', '37', '70', '11', '2019-02-24 08:16:16');
INSERT INTO `useraction` VALUES ('2307', '4', '6', '21', '2019-02-24 08:16:16');
INSERT INTO `useraction` VALUES ('2308', '8', '11', '11', '2019-02-24 08:16:17');
INSERT INTO `useraction` VALUES ('2309', '50', '49', '11', '2019-02-24 08:16:18');
INSERT INTO `useraction` VALUES ('2310', '15', '86', '11', '2019-02-24 08:16:19');
INSERT INTO `useraction` VALUES ('2311', '21', '5', '24', '2019-02-24 08:16:20');
INSERT INTO `useraction` VALUES ('2312', '15', '5', '21', '2019-02-24 08:16:21');
INSERT INTO `useraction` VALUES ('2313', '28', '4', '21', '2019-02-24 08:16:21');
INSERT INTO `useraction` VALUES ('2314', '49', '5', '21', '2019-02-24 08:16:22');
INSERT INTO `useraction` VALUES ('2315', '39', '6', '21', '2019-02-24 08:16:23');
INSERT INTO `useraction` VALUES ('2316', '24', '26', '11', '2019-02-24 08:16:25');
INSERT INTO `useraction` VALUES ('2317', '35', '33', '11', '2019-02-24 08:16:27');
INSERT INTO `useraction` VALUES ('2318', '11', '62', '11', '2019-02-24 08:16:29');
INSERT INTO `useraction` VALUES ('2319', '43', '88', '11', '2019-02-24 08:16:31');
INSERT INTO `useraction` VALUES ('2320', '24', '1', '21', '2019-02-24 08:16:32');
INSERT INTO `useraction` VALUES ('2321', '10', '6', '21', '2019-02-24 08:16:33');
INSERT INTO `useraction` VALUES ('2322', '19', '11', '11', '2019-02-24 08:16:33');
INSERT INTO `useraction` VALUES ('2323', '10', '79', '11', '2019-02-24 08:16:34');
INSERT INTO `useraction` VALUES ('2324', '21', '1', '22', '2019-02-24 08:16:34');
INSERT INTO `useraction` VALUES ('2325', '26', '4', '21', '2019-02-24 08:16:35');
INSERT INTO `useraction` VALUES ('2326', '3', '3', '21', '2019-02-24 08:16:39');
INSERT INTO `useraction` VALUES ('2327', '29', '6', '22', '2019-02-24 08:16:39');
INSERT INTO `useraction` VALUES ('2328', '32', '5', '21', '2019-02-24 08:16:41');
INSERT INTO `useraction` VALUES ('2329', '20', '88', '11', '2019-02-24 08:16:42');
INSERT INTO `useraction` VALUES ('2330', '35', '4', '21', '2019-02-24 08:16:42');
INSERT INTO `useraction` VALUES ('2331', '47', '5', '21', '2019-02-24 08:16:43');
INSERT INTO `useraction` VALUES ('2332', '3', '3', '21', '2019-02-24 08:16:44');
INSERT INTO `useraction` VALUES ('2333', '22', '49', '11', '2019-02-24 08:16:45');
INSERT INTO `useraction` VALUES ('2334', '5', '6', '21', '2019-02-24 08:16:46');
INSERT INTO `useraction` VALUES ('2335', '20', '3', '21', '2019-02-24 08:16:48');
INSERT INTO `useraction` VALUES ('2336', '12', '40', '11', '2019-02-24 08:16:50');
INSERT INTO `useraction` VALUES ('2337', '37', '4', '21', '2019-02-24 08:16:51');
INSERT INTO `useraction` VALUES ('2338', '10', '2', '13', '2019-02-24 08:16:51');
INSERT INTO `useraction` VALUES ('2339', '27', '2', '11', '2019-02-24 08:16:52');
INSERT INTO `useraction` VALUES ('2340', '17', '4', '21', '2019-02-24 08:16:53');
INSERT INTO `useraction` VALUES ('2341', '24', '2', '21', '2019-02-24 08:16:58');
INSERT INTO `useraction` VALUES ('2342', '33', '3', '21', '2019-02-24 08:17:05');
INSERT INTO `useraction` VALUES ('2343', '37', '3', '21', '2019-02-24 08:17:07');
INSERT INTO `useraction` VALUES ('2344', '47', '1', '21', '2019-02-24 08:17:08');
INSERT INTO `useraction` VALUES ('2345', '8', '1', '21', '2019-02-24 08:17:12');
INSERT INTO `useraction` VALUES ('2346', '49', '58', '12', '2019-02-24 08:17:13');
INSERT INTO `useraction` VALUES ('2347', '31', '3', '14', '2019-02-24 08:17:14');
INSERT INTO `useraction` VALUES ('2348', '32', '4', '22', '2019-02-24 08:17:16');
INSERT INTO `useraction` VALUES ('2349', '38', '5', '22', '2019-02-24 08:17:18');
INSERT INTO `useraction` VALUES ('2350', '16', '3', '21', '2019-02-24 08:17:19');
INSERT INTO `useraction` VALUES ('2351', '5', '6', '21', '2019-02-24 08:17:20');
INSERT INTO `useraction` VALUES ('2352', '12', '77', '11', '2019-02-24 08:17:23');
INSERT INTO `useraction` VALUES ('2353', '5', '54', '11', '2019-02-24 08:17:23');
INSERT INTO `useraction` VALUES ('2354', '3', '59', '11', '2019-02-24 08:17:26');
INSERT INTO `useraction` VALUES ('2355', '16', '1', '21', '2019-02-24 08:17:26');
INSERT INTO `useraction` VALUES ('2356', '34', '76', '11', '2019-02-24 08:17:27');
INSERT INTO `useraction` VALUES ('2357', '41', '2', '21', '2019-02-24 08:17:28');
INSERT INTO `useraction` VALUES ('2358', '23', '32', '11', '2019-02-24 08:17:29');
INSERT INTO `useraction` VALUES ('2359', '50', '6', '21', '2019-02-24 08:17:31');
INSERT INTO `useraction` VALUES ('2360', '25', '40', '11', '2019-02-24 08:17:32');
INSERT INTO `useraction` VALUES ('2361', '1', '4', '21', '2019-02-24 08:17:33');
INSERT INTO `useraction` VALUES ('2362', '43', '66', '11', '2019-02-24 08:17:34');
INSERT INTO `useraction` VALUES ('2363', '7', '52', '11', '2019-02-24 08:17:35');
INSERT INTO `useraction` VALUES ('2364', '3', '4', '21', '2019-02-24 08:17:39');
INSERT INTO `useraction` VALUES ('2365', '44', '4', '21', '2019-02-24 08:17:41');
INSERT INTO `useraction` VALUES ('2366', '29', '3', '2', '2019-02-24 08:17:43');
INSERT INTO `useraction` VALUES ('2367', '24', '3', '21', '2019-02-24 08:17:44');
INSERT INTO `useraction` VALUES ('2368', '19', '6', '21', '2019-02-24 08:17:45');
INSERT INTO `useraction` VALUES ('2369', '31', '6', '21', '2019-02-24 08:17:46');
INSERT INTO `useraction` VALUES ('2370', '11', '4', '21', '2019-02-24 08:17:46');
INSERT INTO `useraction` VALUES ('2371', '45', '6', '21', '2019-02-24 08:17:47');
INSERT INTO `useraction` VALUES ('2372', '32', '1', '21', '2019-02-24 08:17:48');
INSERT INTO `useraction` VALUES ('2373', '3', '6', '21', '2019-02-24 08:17:49');
INSERT INTO `useraction` VALUES ('2374', '28', '6', '21', '2019-02-24 08:17:49');
INSERT INTO `useraction` VALUES ('2375', '7', '23', '11', '2019-02-24 08:17:50');
INSERT INTO `useraction` VALUES ('2376', '3', '1', '21', '2019-02-24 08:17:51');
INSERT INTO `useraction` VALUES ('2377', '11', '38', '11', '2019-02-24 08:17:51');
INSERT INTO `useraction` VALUES ('2378', '40', '2', '21', '2019-02-24 08:17:52');
INSERT INTO `useraction` VALUES ('2379', '10', '3', '21', '2019-02-24 08:17:54');
INSERT INTO `useraction` VALUES ('2380', '20', '87', '12', '2019-02-24 08:17:54');
INSERT INTO `useraction` VALUES ('2381', '14', '2', '25', '2019-02-24 08:17:56');
INSERT INTO `useraction` VALUES ('2382', '17', '3', '21', '2019-02-24 08:17:57');
INSERT INTO `useraction` VALUES ('2383', '6', '3', '21', '2019-02-24 08:17:58');
INSERT INTO `useraction` VALUES ('2384', '28', '75', '11', '2019-02-24 08:17:58');
INSERT INTO `useraction` VALUES ('2385', '2', '3', '21', '2019-02-24 08:17:59');
INSERT INTO `useraction` VALUES ('2386', '12', '3', '14', '2019-02-24 08:18:00');
INSERT INTO `useraction` VALUES ('2387', '47', '10', '11', '2019-02-24 08:18:01');
INSERT INTO `useraction` VALUES ('2388', '25', '57', '11', '2019-02-24 08:18:04');
INSERT INTO `useraction` VALUES ('2389', '6', '4', '21', '2019-02-24 08:18:04');
INSERT INTO `useraction` VALUES ('2390', '39', '2', '21', '2019-02-24 08:18:05');
INSERT INTO `useraction` VALUES ('2391', '7', '54', '11', '2019-02-24 08:18:06');
INSERT INTO `useraction` VALUES ('2392', '45', '4', '21', '2019-02-24 08:18:07');
INSERT INTO `useraction` VALUES ('2393', '28', '4', '21', '2019-02-24 08:18:08');
INSERT INTO `useraction` VALUES ('2394', '15', '1', '21', '2019-02-24 08:18:08');
INSERT INTO `useraction` VALUES ('2395', '10', '5', '21', '2019-02-24 08:18:09');
INSERT INTO `useraction` VALUES ('2396', '6', '62', '11', '2019-02-24 08:18:09');
INSERT INTO `useraction` VALUES ('2397', '15', '1', '21', '2019-02-24 08:18:11');
INSERT INTO `useraction` VALUES ('2398', '23', '2', '21', '2019-02-24 08:18:11');
INSERT INTO `useraction` VALUES ('2399', '21', '6', '21', '2019-02-24 08:18:12');
INSERT INTO `useraction` VALUES ('2400', '36', '73', '11', '2019-02-24 08:18:12');
INSERT INTO `useraction` VALUES ('2401', '37', '49', '11', '2019-02-24 08:18:13');
INSERT INTO `useraction` VALUES ('2402', '31', '28', '11', '2019-02-24 08:18:14');
INSERT INTO `useraction` VALUES ('2403', '34', '4', '25', '2019-02-24 08:18:16');
INSERT INTO `useraction` VALUES ('2404', '18', '2', '3', '2019-02-24 08:18:18');
INSERT INTO `useraction` VALUES ('2405', '38', '2', '21', '2019-02-24 08:18:18');
INSERT INTO `useraction` VALUES ('2406', '15', '5', '21', '2019-02-24 08:18:19');
INSERT INTO `useraction` VALUES ('2407', '6', '6', '21', '2019-02-24 08:18:20');
INSERT INTO `useraction` VALUES ('2408', '13', '4', '50', '2019-02-24 08:18:21');
INSERT INTO `useraction` VALUES ('2409', '6', '4', '2', '2019-02-24 08:18:23');
INSERT INTO `useraction` VALUES ('2410', '30', '3', '21', '2019-02-24 08:18:24');
INSERT INTO `useraction` VALUES ('2411', '49', '44', '12', '2019-02-24 08:18:26');
INSERT INTO `useraction` VALUES ('2412', '24', '8', '11', '2019-02-24 08:18:28');
INSERT INTO `useraction` VALUES ('2413', '9', '63', '11', '2019-02-24 08:18:29');
INSERT INTO `useraction` VALUES ('2414', '22', '41', '11', '2019-02-24 08:18:29');
INSERT INTO `useraction` VALUES ('2415', '30', '2', '24', '2019-02-24 08:18:30');
INSERT INTO `useraction` VALUES ('2416', '35', '5', '21', '2019-02-24 08:18:31');
INSERT INTO `useraction` VALUES ('2417', '1', '4', '21', '2019-02-24 08:18:31');
INSERT INTO `useraction` VALUES ('2418', '11', '4', '21', '2019-02-24 08:18:32');
INSERT INTO `useraction` VALUES ('2419', '2', '81', '11', '2019-02-24 08:18:33');
INSERT INTO `useraction` VALUES ('2420', '49', '4', '21', '2019-02-24 08:18:33');
INSERT INTO `useraction` VALUES ('2421', '47', '3', '21', '2019-02-24 08:18:36');
INSERT INTO `useraction` VALUES ('2422', '10', '12', '11', '2019-02-24 08:18:36');
INSERT INTO `useraction` VALUES ('2423', '12', '5', '21', '2019-02-24 08:18:37');
INSERT INTO `useraction` VALUES ('2424', '41', '1', '21', '2019-02-24 08:18:38');
INSERT INTO `useraction` VALUES ('2425', '17', '5', '21', '2019-02-24 08:18:38');
INSERT INTO `useraction` VALUES ('2426', '49', '3', '21', '2019-02-24 08:18:40');
INSERT INTO `useraction` VALUES ('2427', '5', '6', '21', '2019-02-24 08:18:42');
INSERT INTO `useraction` VALUES ('2428', '44', '1', '2', '2019-02-24 08:18:43');
INSERT INTO `useraction` VALUES ('2429', '35', '56', '11', '2019-02-24 08:18:44');
INSERT INTO `useraction` VALUES ('2430', '30', '1', '50', '2019-02-24 08:18:45');
INSERT INTO `useraction` VALUES ('2431', '10', '5', '11', '2019-02-24 08:18:46');
INSERT INTO `useraction` VALUES ('2432', '21', '4', '21', '2019-02-24 08:18:46');
INSERT INTO `useraction` VALUES ('2433', '6', '2', '21', '2019-02-24 08:18:48');
INSERT INTO `useraction` VALUES ('2434', '35', '4', '21', '2019-02-24 08:18:48');
INSERT INTO `useraction` VALUES ('2435', '34', '1', '1', '2019-02-24 08:18:49');
INSERT INTO `useraction` VALUES ('2436', '40', '4', '4', '2019-02-24 08:18:51');
INSERT INTO `useraction` VALUES ('2437', '23', '4', '21', '2019-02-24 08:18:51');
INSERT INTO `useraction` VALUES ('2438', '35', '3', '21', '2019-02-24 08:18:52');
INSERT INTO `useraction` VALUES ('2439', '47', '83', '11', '2019-02-24 08:18:53');
INSERT INTO `useraction` VALUES ('2440', '44', '6', '21', '2019-02-24 08:18:54');
INSERT INTO `useraction` VALUES ('2441', '10', '67', '11', '2019-02-24 08:18:55');
INSERT INTO `useraction` VALUES ('2442', '4', '4', '21', '2019-02-24 08:18:58');
INSERT INTO `useraction` VALUES ('2443', '40', '2', '3', '2019-02-24 08:18:59');
INSERT INTO `useraction` VALUES ('2444', '1', '54', '11', '2019-02-24 08:19:00');
INSERT INTO `useraction` VALUES ('2445', '18', '3', '21', '2019-02-24 08:19:01');
INSERT INTO `useraction` VALUES ('2446', '35', '4', '2', '2019-02-24 08:19:03');
INSERT INTO `useraction` VALUES ('2447', '24', '4', '25', '2019-02-24 08:19:04');
INSERT INTO `useraction` VALUES ('2448', '25', '6', '21', '2019-02-24 08:19:05');
INSERT INTO `useraction` VALUES ('2449', '22', '2', '1', '2019-02-24 08:19:06');
INSERT INTO `useraction` VALUES ('2450', '12', '5', '11', '2019-02-24 08:19:06');
INSERT INTO `useraction` VALUES ('2451', '44', '5', '21', '2019-02-24 08:19:08');
INSERT INTO `useraction` VALUES ('2452', '29', '5', '21', '2019-02-24 08:19:10');
INSERT INTO `useraction` VALUES ('2453', '21', '6', '23', '2019-02-24 08:19:11');
INSERT INTO `useraction` VALUES ('2454', '19', '31', '11', '2019-02-24 08:19:12');
INSERT INTO `useraction` VALUES ('2455', '4', '1', '21', '2019-02-24 08:19:13');
INSERT INTO `useraction` VALUES ('2456', '36', '3', '2', '2019-02-24 08:19:14');
INSERT INTO `useraction` VALUES ('2457', '25', '35', '11', '2019-02-24 08:19:15');
INSERT INTO `useraction` VALUES ('2458', '3', '3', '21', '2019-02-24 08:19:16');
INSERT INTO `useraction` VALUES ('2459', '42', '6', '21', '2019-02-24 08:19:16');
INSERT INTO `useraction` VALUES ('2460', '16', '4', '21', '2019-02-24 08:19:18');
INSERT INTO `useraction` VALUES ('2461', '42', '6', '21', '2019-02-24 08:19:18');
INSERT INTO `useraction` VALUES ('2462', '39', '1', '21', '2019-02-24 08:19:20');
INSERT INTO `useraction` VALUES ('2463', '11', '94', '11', '2019-02-24 08:19:20');
INSERT INTO `useraction` VALUES ('2464', '15', '21', '11', '2019-02-24 08:19:21');
INSERT INTO `useraction` VALUES ('2465', '18', '32', '11', '2019-02-24 08:19:22');
INSERT INTO `useraction` VALUES ('2466', '24', '3', '21', '2019-02-24 08:19:22');
INSERT INTO `useraction` VALUES ('2467', '23', '6', '21', '2019-02-24 08:19:23');
INSERT INTO `useraction` VALUES ('2468', '16', '4', '21', '2019-02-24 08:19:23');
INSERT INTO `useraction` VALUES ('2469', '34', '6', '21', '2019-02-24 08:19:24');
INSERT INTO `useraction` VALUES ('2470', '18', '82', '11', '2019-02-24 08:19:25');
INSERT INTO `useraction` VALUES ('2471', '36', '1', '11', '2019-02-24 08:19:26');
INSERT INTO `useraction` VALUES ('2472', '39', '4', '21', '2019-02-24 08:19:27');
INSERT INTO `useraction` VALUES ('2473', '2', '73', '11', '2019-02-24 08:19:27');
INSERT INTO `useraction` VALUES ('2474', '40', '6', '21', '2019-02-24 08:19:28');
INSERT INTO `useraction` VALUES ('2475', '43', '46', '11', '2019-02-24 08:19:29');
INSERT INTO `useraction` VALUES ('2476', '25', '3', '21', '2019-02-24 08:19:29');
INSERT INTO `useraction` VALUES ('2477', '44', '3', '21', '2019-02-24 08:19:31');
INSERT INTO `useraction` VALUES ('2478', '37', '72', '11', '2019-02-24 08:19:32');
INSERT INTO `useraction` VALUES ('2479', '40', '4', '21', '2019-02-24 08:19:32');
INSERT INTO `useraction` VALUES ('2480', '32', '1', '21', '2019-02-24 08:19:33');
INSERT INTO `useraction` VALUES ('2481', '47', '1', '23', '2019-02-24 08:19:34');
INSERT INTO `useraction` VALUES ('2482', '38', '2', '4', '2019-02-24 08:19:35');
INSERT INTO `useraction` VALUES ('2483', '28', '2', '21', '2019-02-24 08:19:35');
INSERT INTO `useraction` VALUES ('2484', '33', '21', '11', '2019-02-24 08:19:36');
INSERT INTO `useraction` VALUES ('2485', '27', '5', '25', '2019-02-24 08:19:37');
INSERT INTO `useraction` VALUES ('2486', '1', '59', '11', '2019-02-24 08:19:38');
INSERT INTO `useraction` VALUES ('2487', '17', '6', '21', '2019-02-24 08:19:39');
INSERT INTO `useraction` VALUES ('2488', '22', '4', '21', '2019-02-24 08:19:40');
INSERT INTO `useraction` VALUES ('2489', '40', '6', '21', '2019-02-24 08:19:40');
INSERT INTO `useraction` VALUES ('2490', '23', '2', '3', '2019-02-24 08:19:41');
INSERT INTO `useraction` VALUES ('2491', '49', '87', '11', '2019-02-24 08:19:42');
INSERT INTO `useraction` VALUES ('2492', '8', '13', '11', '2019-02-24 08:19:43');
INSERT INTO `useraction` VALUES ('2493', '18', '5', '21', '2019-02-24 08:19:44');
INSERT INTO `useraction` VALUES ('2494', '49', '30', '11', '2019-02-24 08:19:45');
INSERT INTO `useraction` VALUES ('2495', '18', '6', '21', '2019-02-24 08:19:46');
INSERT INTO `useraction` VALUES ('2496', '36', '1', '21', '2019-02-24 08:19:47');
INSERT INTO `useraction` VALUES ('2497', '48', '56', '11', '2019-02-24 08:19:49');
INSERT INTO `useraction` VALUES ('2498', '25', '1', '21', '2019-02-24 08:19:49');
INSERT INTO `useraction` VALUES ('2499', '33', '5', '21', '2019-02-24 08:19:51');
INSERT INTO `useraction` VALUES ('2500', '8', '5', '21', '2019-02-24 08:19:51');
INSERT INTO `useraction` VALUES ('2501', '19', '18', '11', '2019-02-24 08:19:52');
INSERT INTO `useraction` VALUES ('2502', '6', '5', '21', '2019-02-24 08:19:53');
INSERT INTO `useraction` VALUES ('2503', '14', '61', '11', '2019-02-24 08:19:54');
INSERT INTO `useraction` VALUES ('2504', '26', '4', '21', '2019-02-24 08:19:55');
INSERT INTO `useraction` VALUES ('2505', '6', '1', '21', '2019-02-24 08:19:57');
INSERT INTO `useraction` VALUES ('2506', '42', '50', '11', '2019-02-24 08:19:59');
INSERT INTO `useraction` VALUES ('2507', '34', '5', '25', '2019-02-24 08:19:59');
INSERT INTO `useraction` VALUES ('2508', '29', '1', '21', '2019-02-24 08:20:00');
INSERT INTO `useraction` VALUES ('2509', '5', '1', '3', '2019-02-24 08:20:01');
INSERT INTO `useraction` VALUES ('2510', '35', '13', '11', '2019-02-24 08:20:02');
INSERT INTO `useraction` VALUES ('2511', '44', '4', '50', '2019-02-24 08:20:04');
INSERT INTO `useraction` VALUES ('2512', '49', '3', '21', '2019-02-24 08:20:07');
INSERT INTO `useraction` VALUES ('2513', '34', '4', '21', '2019-02-24 08:20:09');
INSERT INTO `useraction` VALUES ('2514', '21', '77', '11', '2019-02-24 08:20:09');
INSERT INTO `useraction` VALUES ('2515', '46', '26', '11', '2019-02-24 08:20:11');
INSERT INTO `useraction` VALUES ('2516', '34', '2', '21', '2019-02-24 08:20:11');
INSERT INTO `useraction` VALUES ('2517', '37', '14', '11', '2019-02-24 08:20:12');
INSERT INTO `useraction` VALUES ('2518', '21', '4', '21', '2019-02-24 08:20:13');
INSERT INTO `useraction` VALUES ('2519', '2', '3', '21', '2019-02-24 08:20:13');
INSERT INTO `useraction` VALUES ('2520', '46', '1', '21', '2019-02-24 08:20:16');
INSERT INTO `useraction` VALUES ('2521', '36', '42', '11', '2019-02-24 08:20:17');
INSERT INTO `useraction` VALUES ('2522', '28', '5', '21', '2019-02-24 08:20:18');
INSERT INTO `useraction` VALUES ('2523', '29', '1', '21', '2019-02-24 08:20:20');
INSERT INTO `useraction` VALUES ('2524', '8', '3', '21', '2019-02-24 08:20:21');
INSERT INTO `useraction` VALUES ('2525', '43', '63', '11', '2019-02-24 08:20:23');
INSERT INTO `useraction` VALUES ('2526', '17', '2', '21', '2019-02-24 08:20:23');
INSERT INTO `useraction` VALUES ('2527', '42', '5', '21', '2019-02-24 08:20:24');
INSERT INTO `useraction` VALUES ('2528', '25', '93', '11', '2019-02-24 08:20:26');
INSERT INTO `useraction` VALUES ('2529', '37', '2', '3', '2019-02-24 08:20:27');
INSERT INTO `useraction` VALUES ('2530', '35', '1', '21', '2019-02-24 08:20:29');
INSERT INTO `useraction` VALUES ('2531', '14', '71', '11', '2019-02-24 08:20:30');
INSERT INTO `useraction` VALUES ('2532', '11', '4', '21', '2019-02-24 08:20:33');
INSERT INTO `useraction` VALUES ('2533', '14', '3', '21', '2019-02-24 08:20:36');
INSERT INTO `useraction` VALUES ('2534', '24', '6', '11', '2019-02-24 08:20:38');
INSERT INTO `useraction` VALUES ('2535', '27', '72', '11', '2019-02-24 08:20:38');
INSERT INTO `useraction` VALUES ('2536', '7', '74', '11', '2019-02-24 08:20:40');
INSERT INTO `useraction` VALUES ('2537', '40', '81', '11', '2019-02-24 08:20:41');
INSERT INTO `useraction` VALUES ('2538', '49', '25', '11', '2019-02-24 08:20:43');
INSERT INTO `useraction` VALUES ('2539', '24', '3', '21', '2019-02-24 08:20:44');
INSERT INTO `useraction` VALUES ('2540', '13', '18', '11', '2019-02-24 08:20:45');
INSERT INTO `useraction` VALUES ('2541', '35', '1', '25', '2019-02-24 08:20:49');
INSERT INTO `useraction` VALUES ('2542', '14', '2', '23', '2019-02-24 08:20:50');
INSERT INTO `useraction` VALUES ('2543', '37', '3', '21', '2019-02-24 08:20:51');
INSERT INTO `useraction` VALUES ('2544', '17', '58', '11', '2019-02-24 08:20:53');
INSERT INTO `useraction` VALUES ('2545', '42', '66', '11', '2019-02-24 08:20:55');
INSERT INTO `useraction` VALUES ('2546', '38', '3', '21', '2019-02-24 08:20:57');
INSERT INTO `useraction` VALUES ('2547', '49', '4', '21', '2019-02-24 08:20:57');
INSERT INTO `useraction` VALUES ('2548', '46', '3', '21', '2019-02-24 08:20:58');
INSERT INTO `useraction` VALUES ('2549', '33', '3', '21', '2019-02-24 08:20:58');
INSERT INTO `useraction` VALUES ('2550', '26', '3', '21', '2019-02-24 08:21:00');
INSERT INTO `useraction` VALUES ('2551', '1', '5', '21', '2019-02-24 08:21:05');
INSERT INTO `useraction` VALUES ('2552', '1', '19', '11', '2019-02-24 08:21:09');
INSERT INTO `useraction` VALUES ('2553', '27', '1', '21', '2019-02-24 08:21:10');
INSERT INTO `useraction` VALUES ('2554', '34', '96', '11', '2019-02-24 08:21:12');
INSERT INTO `useraction` VALUES ('2555', '31', '1', '21', '2019-02-24 08:21:14');
INSERT INTO `useraction` VALUES ('2556', '49', '2', '21', '2019-02-24 08:21:17');
INSERT INTO `useraction` VALUES ('2557', '10', '80', '11', '2019-02-24 08:21:18');
INSERT INTO `useraction` VALUES ('2558', '20', '5', '21', '2019-02-24 08:21:19');
INSERT INTO `useraction` VALUES ('2559', '37', '5', '21', '2019-02-24 08:21:21');
INSERT INTO `useraction` VALUES ('2560', '24', '6', '21', '2019-02-24 08:21:21');
INSERT INTO `useraction` VALUES ('2561', '47', '3', '2', '2019-02-24 08:21:22');
INSERT INTO `useraction` VALUES ('2562', '46', '2', '21', '2019-02-24 08:21:23');
INSERT INTO `useraction` VALUES ('2563', '1', '73', '11', '2019-02-24 08:21:24');
INSERT INTO `useraction` VALUES ('2564', '45', '89', '11', '2019-02-24 08:21:25');
INSERT INTO `useraction` VALUES ('2565', '1', '3', '50', '2019-02-24 08:21:26');
INSERT INTO `useraction` VALUES ('2566', '19', '5', '21', '2019-02-24 08:21:28');
INSERT INTO `useraction` VALUES ('2567', '44', '56', '11', '2019-02-24 08:21:30');
INSERT INTO `useraction` VALUES ('2568', '32', '1', '21', '2019-02-24 08:21:31');
INSERT INTO `useraction` VALUES ('2569', '19', '80', '11', '2019-02-24 08:21:32');
INSERT INTO `useraction` VALUES ('2570', '44', '55', '11', '2019-02-24 08:21:34');
INSERT INTO `useraction` VALUES ('2571', '2', '5', '24', '2019-02-24 08:21:35');
INSERT INTO `useraction` VALUES ('2572', '21', '53', '11', '2019-02-24 08:21:35');
INSERT INTO `useraction` VALUES ('2573', '32', '5', '24', '2019-02-24 08:21:37');
INSERT INTO `useraction` VALUES ('2574', '43', '3', '21', '2019-02-24 08:21:39');
INSERT INTO `useraction` VALUES ('2575', '46', '3', '4', '2019-02-24 08:21:40');
INSERT INTO `useraction` VALUES ('2576', '25', '3', '21', '2019-02-24 08:21:42');
INSERT INTO `useraction` VALUES ('2577', '8', '3', '21', '2019-02-24 08:21:42');
INSERT INTO `useraction` VALUES ('2578', '9', '1', '21', '2019-02-24 08:21:43');
INSERT INTO `useraction` VALUES ('2579', '47', '13', '11', '2019-02-24 08:21:44');
INSERT INTO `useraction` VALUES ('2580', '43', '4', '21', '2019-02-24 08:21:45');
INSERT INTO `useraction` VALUES ('2581', '1', '70', '11', '2019-02-24 08:21:46');
INSERT INTO `useraction` VALUES ('2582', '29', '13', '11', '2019-02-24 08:21:48');
INSERT INTO `useraction` VALUES ('2583', '22', '55', '11', '2019-02-24 08:21:49');
INSERT INTO `useraction` VALUES ('2584', '16', '44', '11', '2019-02-24 08:21:50');
INSERT INTO `useraction` VALUES ('2585', '11', '2', '21', '2019-02-24 08:21:50');
INSERT INTO `useraction` VALUES ('2586', '19', '6', '21', '2019-02-24 08:21:53');
INSERT INTO `useraction` VALUES ('2587', '46', '1', '21', '2019-02-24 08:21:54');
INSERT INTO `useraction` VALUES ('2588', '5', '1', '21', '2019-02-24 08:21:54');
INSERT INTO `useraction` VALUES ('2589', '44', '34', '11', '2019-02-24 08:21:55');
INSERT INTO `useraction` VALUES ('2590', '15', '6', '21', '2019-02-24 08:21:56');
INSERT INTO `useraction` VALUES ('2591', '44', '3', '24', '2019-02-24 08:21:57');
INSERT INTO `useraction` VALUES ('2592', '13', '44', '11', '2019-02-24 08:21:58');
INSERT INTO `useraction` VALUES ('2593', '14', '79', '11', '2019-02-24 08:21:59');
INSERT INTO `useraction` VALUES ('2594', '5', '1', '21', '2019-02-24 08:22:00');
INSERT INTO `useraction` VALUES ('2595', '35', '6', '21', '2019-02-24 08:22:00');
INSERT INTO `useraction` VALUES ('2596', '26', '70', '11', '2019-02-24 08:22:02');
INSERT INTO `useraction` VALUES ('2597', '20', '5', '21', '2019-02-24 08:22:03');
INSERT INTO `useraction` VALUES ('2598', '46', '6', '21', '2019-02-24 08:22:05');
INSERT INTO `useraction` VALUES ('2599', '34', '1', '21', '2019-02-24 08:22:07');
INSERT INTO `useraction` VALUES ('2600', '31', '1', '21', '2019-02-24 08:22:09');
INSERT INTO `useraction` VALUES ('2601', '42', '4', '21', '2019-02-24 08:22:10');
INSERT INTO `useraction` VALUES ('2602', '2', '3', '21', '2019-02-24 08:22:11');
INSERT INTO `useraction` VALUES ('2603', '49', '6', '21', '2019-02-24 08:22:12');
INSERT INTO `useraction` VALUES ('2604', '5', '78', '11', '2019-02-24 08:22:12');
INSERT INTO `useraction` VALUES ('2605', '20', '50', '11', '2019-02-24 08:22:14');
INSERT INTO `useraction` VALUES ('2606', '24', '6', '21', '2019-02-24 08:22:14');
INSERT INTO `useraction` VALUES ('2607', '3', '85', '11', '2019-02-24 08:22:15');
INSERT INTO `useraction` VALUES ('2608', '7', '3', '2', '2019-02-24 08:22:16');
INSERT INTO `useraction` VALUES ('2609', '6', '93', '11', '2019-02-24 08:22:16');
INSERT INTO `useraction` VALUES ('2610', '11', '85', '11', '2019-02-24 08:22:18');
INSERT INTO `useraction` VALUES ('2611', '7', '3', '21', '2019-02-24 08:22:19');
INSERT INTO `useraction` VALUES ('2612', '8', '2', '21', '2019-02-24 08:22:19');
INSERT INTO `useraction` VALUES ('2613', '32', '3', '2', '2019-02-24 08:22:20');
INSERT INTO `useraction` VALUES ('2614', '5', '51', '11', '2019-02-24 08:22:23');
INSERT INTO `useraction` VALUES ('2615', '39', '4', '21', '2019-02-24 08:22:23');
INSERT INTO `useraction` VALUES ('2616', '1', '11', '11', '2019-02-24 08:22:24');
INSERT INTO `useraction` VALUES ('2617', '24', '4', '21', '2019-02-24 08:22:25');
INSERT INTO `useraction` VALUES ('2618', '41', '16', '11', '2019-02-24 08:22:25');
INSERT INTO `useraction` VALUES ('2619', '43', '6', '21', '2019-02-24 08:22:26');
INSERT INTO `useraction` VALUES ('2620', '14', '4', '21', '2019-02-24 08:22:28');
INSERT INTO `useraction` VALUES ('2621', '15', '3', '21', '2019-02-24 08:22:28');
INSERT INTO `useraction` VALUES ('2622', '43', '11', '11', '2019-02-24 08:22:30');
INSERT INTO `useraction` VALUES ('2623', '38', '13', '11', '2019-02-24 08:22:32');
INSERT INTO `useraction` VALUES ('2624', '13', '41', '11', '2019-02-24 08:22:32');
INSERT INTO `useraction` VALUES ('2625', '5', '1', '21', '2019-02-24 08:22:34');
INSERT INTO `useraction` VALUES ('2626', '16', '1', '21', '2019-02-24 08:22:34');
INSERT INTO `useraction` VALUES ('2627', '35', '51', '11', '2019-02-24 08:22:35');
INSERT INTO `useraction` VALUES ('2628', '37', '5', '21', '2019-02-24 08:22:36');
INSERT INTO `useraction` VALUES ('2629', '2', '2', '21', '2019-02-24 08:22:37');
INSERT INTO `useraction` VALUES ('2630', '12', '1', '23', '2019-02-24 08:22:37');
INSERT INTO `useraction` VALUES ('2631', '31', '55', '11', '2019-02-24 08:22:38');
INSERT INTO `useraction` VALUES ('2632', '36', '20', '11', '2019-02-24 08:22:39');
INSERT INTO `useraction` VALUES ('2633', '21', '3', '21', '2019-02-24 08:22:41');
INSERT INTO `useraction` VALUES ('2634', '7', '13', '11', '2019-02-24 08:22:42');
INSERT INTO `useraction` VALUES ('2635', '17', '48', '11', '2019-02-24 08:22:43');
INSERT INTO `useraction` VALUES ('2636', '20', '74', '11', '2019-02-24 08:22:43');
INSERT INTO `useraction` VALUES ('2637', '8', '5', '21', '2019-02-24 08:22:45');
INSERT INTO `useraction` VALUES ('2638', '25', '3', '21', '2019-02-24 08:22:51');
INSERT INTO `useraction` VALUES ('2639', '36', '5', '13', '2019-02-24 08:22:52');
INSERT INTO `useraction` VALUES ('2640', '19', '6', '11', '2019-02-24 08:22:53');
INSERT INTO `useraction` VALUES ('2641', '31', '3', '21', '2019-02-24 08:22:54');
INSERT INTO `useraction` VALUES ('2642', '8', '42', '11', '2019-02-24 08:22:55');
INSERT INTO `useraction` VALUES ('2643', '43', '1', '21', '2019-02-24 08:22:58');
INSERT INTO `useraction` VALUES ('2644', '30', '2', '25', '2019-02-24 08:22:58');
INSERT INTO `useraction` VALUES ('2645', '23', '29', '11', '2019-02-24 08:23:01');
INSERT INTO `useraction` VALUES ('2646', '34', '3', '25', '2019-02-24 08:23:05');
INSERT INTO `useraction` VALUES ('2647', '7', '94', '11', '2019-02-24 08:23:08');
INSERT INTO `useraction` VALUES ('2648', '34', '58', '11', '2019-02-24 08:23:08');
INSERT INTO `useraction` VALUES ('2649', '11', '1', '21', '2019-02-24 08:23:09');
INSERT INTO `useraction` VALUES ('2650', '32', '6', '21', '2019-02-24 08:23:10');
INSERT INTO `useraction` VALUES ('2651', '1', '60', '11', '2019-02-24 08:23:10');
INSERT INTO `useraction` VALUES ('2652', '31', '3', '24', '2019-02-24 08:23:11');
INSERT INTO `useraction` VALUES ('2653', '29', '1', '21', '2019-02-24 08:23:12');
INSERT INTO `useraction` VALUES ('2654', '45', '88', '11', '2019-02-24 08:23:13');
INSERT INTO `useraction` VALUES ('2655', '5', '3', '21', '2019-02-24 08:23:14');
INSERT INTO `useraction` VALUES ('2656', '48', '4', '21', '2019-02-24 08:23:14');
INSERT INTO `useraction` VALUES ('2657', '31', '71', '11', '2019-02-24 08:23:16');
INSERT INTO `useraction` VALUES ('2658', '5', '3', '1', '2019-02-24 08:23:16');
INSERT INTO `useraction` VALUES ('2659', '45', '2', '2', '2019-02-24 08:23:17');
INSERT INTO `useraction` VALUES ('2660', '42', '12', '11', '2019-02-24 08:23:18');
INSERT INTO `useraction` VALUES ('2661', '42', '8', '12', '2019-02-24 08:23:19');
INSERT INTO `useraction` VALUES ('2662', '1', '5', '21', '2019-02-24 08:23:20');
INSERT INTO `useraction` VALUES ('2663', '44', '2', '25', '2019-02-24 08:23:21');
INSERT INTO `useraction` VALUES ('2664', '45', '4', '21', '2019-02-24 08:23:22');
INSERT INTO `useraction` VALUES ('2665', '47', '4', '23', '2019-02-24 08:23:23');
INSERT INTO `useraction` VALUES ('2666', '29', '2', '14', '2019-02-24 08:23:24');
INSERT INTO `useraction` VALUES ('2667', '39', '1', '21', '2019-02-24 08:23:24');
INSERT INTO `useraction` VALUES ('2668', '40', '27', '11', '2019-02-24 08:23:25');
INSERT INTO `useraction` VALUES ('2669', '44', '6', '21', '2019-02-24 08:23:26');
INSERT INTO `useraction` VALUES ('2670', '2', '4', '21', '2019-02-24 08:23:26');
INSERT INTO `useraction` VALUES ('2671', '17', '48', '11', '2019-02-24 08:23:27');
INSERT INTO `useraction` VALUES ('2672', '7', '4', '22', '2019-02-24 08:23:28');
INSERT INTO `useraction` VALUES ('2673', '44', '69', '11', '2019-02-24 08:23:29');
INSERT INTO `useraction` VALUES ('2674', '49', '7', '11', '2019-02-24 08:23:30');
INSERT INTO `useraction` VALUES ('2675', '50', '5', '22', '2019-02-24 08:23:31');
INSERT INTO `useraction` VALUES ('2676', '32', '5', '21', '2019-02-24 08:23:33');
INSERT INTO `useraction` VALUES ('2677', '3', '1', '21', '2019-02-24 08:23:34');
INSERT INTO `useraction` VALUES ('2678', '24', '3', '50', '2019-02-24 08:23:34');
INSERT INTO `useraction` VALUES ('2679', '22', '3', '21', '2019-02-24 08:23:36');
INSERT INTO `useraction` VALUES ('2680', '27', '1', '21', '2019-02-24 08:23:36');
INSERT INTO `useraction` VALUES ('2681', '43', '5', '21', '2019-02-24 08:23:37');
INSERT INTO `useraction` VALUES ('2682', '40', '3', '21', '2019-02-24 08:23:38');
INSERT INTO `useraction` VALUES ('2683', '41', '52', '11', '2019-02-24 08:23:38');
INSERT INTO `useraction` VALUES ('2684', '6', '4', '21', '2019-02-24 08:23:39');
INSERT INTO `useraction` VALUES ('2685', '7', '1', '3', '2019-02-24 08:23:40');
INSERT INTO `useraction` VALUES ('2686', '1', '1', '3', '2019-02-24 08:23:41');
INSERT INTO `useraction` VALUES ('2687', '41', '66', '12', '2019-02-24 08:23:41');
INSERT INTO `useraction` VALUES ('2688', '48', '77', '11', '2019-02-24 08:23:42');
INSERT INTO `useraction` VALUES ('2689', '10', '89', '11', '2019-02-24 08:23:43');
INSERT INTO `useraction` VALUES ('2690', '44', '6', '21', '2019-02-24 08:23:45');
INSERT INTO `useraction` VALUES ('2691', '31', '1', '11', '2019-02-24 08:23:46');
INSERT INTO `useraction` VALUES ('2692', '34', '6', '21', '2019-02-24 08:23:46');
INSERT INTO `useraction` VALUES ('2693', '21', '2', '21', '2019-02-24 08:23:48');
INSERT INTO `useraction` VALUES ('2694', '18', '1', '21', '2019-02-24 08:23:49');
INSERT INTO `useraction` VALUES ('2695', '27', '1', '1', '2019-02-24 08:23:51');
INSERT INTO `useraction` VALUES ('2696', '45', '6', '21', '2019-02-24 08:23:51');
INSERT INTO `useraction` VALUES ('2697', '37', '82', '11', '2019-02-24 08:23:52');
INSERT INTO `useraction` VALUES ('2698', '10', '1', '50', '2019-02-24 08:23:52');
INSERT INTO `useraction` VALUES ('2699', '37', '4', '21', '2019-02-24 08:23:54');
INSERT INTO `useraction` VALUES ('2700', '20', '3', '21', '2019-02-24 08:23:55');
INSERT INTO `useraction` VALUES ('2701', '2', '64', '11', '2019-02-24 08:23:56');
INSERT INTO `useraction` VALUES ('2702', '5', '5', '21', '2019-02-24 08:23:56');
INSERT INTO `useraction` VALUES ('2703', '22', '6', '21', '2019-02-24 08:23:57');
INSERT INTO `useraction` VALUES ('2704', '36', '4', '21', '2019-02-24 08:23:58');
INSERT INTO `useraction` VALUES ('2705', '36', '98', '11', '2019-02-24 08:23:59');
INSERT INTO `useraction` VALUES ('2706', '1', '12', '11', '2019-02-24 08:24:01');
INSERT INTO `useraction` VALUES ('2707', '33', '4', '21', '2019-02-24 08:24:01');
INSERT INTO `useraction` VALUES ('2708', '29', '92', '11', '2019-02-24 08:24:02');
INSERT INTO `useraction` VALUES ('2709', '42', '6', '21', '2019-02-24 08:24:03');
INSERT INTO `useraction` VALUES ('2710', '20', '1', '14', '2019-02-24 08:24:05');
INSERT INTO `useraction` VALUES ('2711', '39', '41', '11', '2019-02-24 08:24:05');
INSERT INTO `useraction` VALUES ('2712', '25', '79', '11', '2019-02-24 08:24:06');
INSERT INTO `useraction` VALUES ('2713', '13', '1', '21', '2019-02-24 08:24:07');
INSERT INTO `useraction` VALUES ('2714', '21', '39', '11', '2019-02-24 08:24:07');
INSERT INTO `useraction` VALUES ('2715', '44', '39', '11', '2019-02-24 08:24:08');
INSERT INTO `useraction` VALUES ('2716', '48', '1', '21', '2019-02-24 08:24:09');
INSERT INTO `useraction` VALUES ('2717', '25', '6', '21', '2019-02-24 08:24:11');
INSERT INTO `useraction` VALUES ('2718', '44', '63', '11', '2019-02-24 08:24:12');
INSERT INTO `useraction` VALUES ('2719', '39', '80', '11', '2019-02-24 08:24:12');
INSERT INTO `useraction` VALUES ('2720', '42', '3', '23', '2019-02-24 08:24:13');
INSERT INTO `useraction` VALUES ('2721', '12', '3', '14', '2019-02-24 08:24:14');
INSERT INTO `useraction` VALUES ('2722', '28', '90', '11', '2019-02-24 08:24:15');
INSERT INTO `useraction` VALUES ('2723', '28', '22', '11', '2019-02-24 08:24:15');
INSERT INTO `useraction` VALUES ('2724', '1', '2', '21', '2019-02-24 08:24:16');
INSERT INTO `useraction` VALUES ('2725', '43', '3', '21', '2019-02-24 08:24:17');
INSERT INTO `useraction` VALUES ('2726', '24', '5', '21', '2019-02-24 08:24:18');
INSERT INTO `useraction` VALUES ('2727', '50', '51', '11', '2019-02-24 08:24:19');
INSERT INTO `useraction` VALUES ('2728', '26', '4', '11', '2019-02-24 08:24:20');
INSERT INTO `useraction` VALUES ('2729', '13', '5', '21', '2019-02-24 08:24:22');
INSERT INTO `useraction` VALUES ('2730', '20', '68', '11', '2019-02-24 08:24:25');
INSERT INTO `useraction` VALUES ('2731', '11', '2', '4', '2019-02-24 08:24:27');
INSERT INTO `useraction` VALUES ('2732', '20', '3', '21', '2019-02-24 08:24:29');
INSERT INTO `useraction` VALUES ('2733', '4', '57', '11', '2019-02-24 08:24:30');
INSERT INTO `useraction` VALUES ('2734', '18', '3', '14', '2019-02-24 08:24:31');
INSERT INTO `useraction` VALUES ('2735', '1', '6', '21', '2019-02-24 08:24:32');
INSERT INTO `useraction` VALUES ('2736', '50', '20', '13', '2019-02-24 08:24:34');
INSERT INTO `useraction` VALUES ('2737', '5', '3', '21', '2019-02-24 08:24:35');
INSERT INTO `useraction` VALUES ('2738', '16', '6', '21', '2019-02-24 08:24:36');
INSERT INTO `useraction` VALUES ('2739', '35', '14', '11', '2019-02-24 08:24:37');
INSERT INTO `useraction` VALUES ('2740', '45', '2', '21', '2019-02-24 08:24:37');
INSERT INTO `useraction` VALUES ('2741', '20', '4', '21', '2019-02-24 08:24:40');
INSERT INTO `useraction` VALUES ('2742', '36', '85', '11', '2019-02-24 08:24:41');
INSERT INTO `useraction` VALUES ('2743', '27', '88', '11', '2019-02-24 08:24:42');
INSERT INTO `useraction` VALUES ('2744', '14', '3', '21', '2019-02-24 08:24:43');
INSERT INTO `useraction` VALUES ('2745', '18', '54', '11', '2019-02-24 08:24:44');
INSERT INTO `useraction` VALUES ('2746', '26', '3', '21', '2019-02-24 08:24:45');
INSERT INTO `useraction` VALUES ('2747', '40', '4', '21', '2019-02-24 08:24:45');
INSERT INTO `useraction` VALUES ('2748', '21', '25', '11', '2019-02-24 08:24:47');
INSERT INTO `useraction` VALUES ('2749', '35', '1', '21', '2019-02-24 08:24:47');
INSERT INTO `useraction` VALUES ('2750', '10', '84', '12', '2019-02-24 08:24:50');
INSERT INTO `useraction` VALUES ('2751', '2', '2', '21', '2019-02-24 08:24:55');
INSERT INTO `useraction` VALUES ('2752', '49', '5', '11', '2019-02-24 08:24:55');
INSERT INTO `useraction` VALUES ('2753', '35', '82', '11', '2019-02-24 08:24:56');
INSERT INTO `useraction` VALUES ('2754', '16', '6', '21', '2019-02-24 08:24:57');
INSERT INTO `useraction` VALUES ('2755', '24', '3', '50', '2019-02-24 08:24:58');
INSERT INTO `useraction` VALUES ('2756', '13', '38', '11', '2019-02-24 08:25:03');
INSERT INTO `useraction` VALUES ('2757', '23', '5', '23', '2019-02-24 08:25:05');
INSERT INTO `useraction` VALUES ('2758', '22', '3', '21', '2019-02-24 08:25:08');
INSERT INTO `useraction` VALUES ('2759', '32', '84', '11', '2019-02-24 08:25:10');
INSERT INTO `useraction` VALUES ('2760', '42', '57', '11', '2019-02-24 08:25:11');
INSERT INTO `useraction` VALUES ('2761', '3', '64', '11', '2019-02-24 08:25:12');
INSERT INTO `useraction` VALUES ('2762', '32', '84', '11', '2019-02-24 08:25:14');
INSERT INTO `useraction` VALUES ('2763', '48', '4', '25', '2019-02-24 08:25:15');
INSERT INTO `useraction` VALUES ('2764', '37', '6', '24', '2019-02-24 08:25:15');
INSERT INTO `useraction` VALUES ('2765', '13', '3', '21', '2019-02-24 08:25:16');
INSERT INTO `useraction` VALUES ('2766', '17', '19', '11', '2019-02-24 08:25:18');
INSERT INTO `useraction` VALUES ('2767', '32', '1', '21', '2019-02-24 08:25:19');
INSERT INTO `useraction` VALUES ('2768', '46', '3', '21', '2019-02-24 08:25:21');
INSERT INTO `useraction` VALUES ('2769', '35', '4', '21', '2019-02-24 08:25:22');
INSERT INTO `useraction` VALUES ('2770', '23', '92', '11', '2019-02-24 08:25:24');
INSERT INTO `useraction` VALUES ('2771', '38', '5', '21', '2019-02-24 08:25:25');
INSERT INTO `useraction` VALUES ('2772', '49', '4', '21', '2019-02-24 08:25:26');
INSERT INTO `useraction` VALUES ('2773', '34', '44', '11', '2019-02-24 08:25:27');
INSERT INTO `useraction` VALUES ('2774', '28', '3', '21', '2019-02-24 08:25:28');
INSERT INTO `useraction` VALUES ('2775', '1', '11', '11', '2019-02-24 08:25:31');
INSERT INTO `useraction` VALUES ('2776', '36', '23', '11', '2019-02-24 08:25:32');
INSERT INTO `useraction` VALUES ('2777', '44', '81', '11', '2019-02-24 08:25:33');
INSERT INTO `useraction` VALUES ('2778', '50', '5', '21', '2019-02-24 08:25:34');
INSERT INTO `useraction` VALUES ('2779', '31', '4', '3', '2019-02-24 08:25:36');
INSERT INTO `useraction` VALUES ('2780', '48', '5', '21', '2019-02-24 08:25:37');
INSERT INTO `useraction` VALUES ('2781', '4', '4', '11', '2019-02-24 08:25:38');
INSERT INTO `useraction` VALUES ('2782', '17', '3', '3', '2019-02-24 08:25:39');
INSERT INTO `useraction` VALUES ('2783', '32', '1', '21', '2019-02-24 08:25:42');
INSERT INTO `useraction` VALUES ('2784', '39', '73', '11', '2019-02-24 08:25:43');
INSERT INTO `useraction` VALUES ('2785', '48', '2', '21', '2019-02-24 08:25:44');
INSERT INTO `useraction` VALUES ('2786', '38', '6', '21', '2019-02-24 08:25:45');
INSERT INTO `useraction` VALUES ('2787', '10', '49', '11', '2019-02-24 08:25:45');
INSERT INTO `useraction` VALUES ('2788', '40', '67', '11', '2019-02-24 08:25:46');
INSERT INTO `useraction` VALUES ('2789', '45', '2', '21', '2019-02-24 08:25:47');
INSERT INTO `useraction` VALUES ('2790', '40', '6', '21', '2019-02-24 08:25:49');
INSERT INTO `useraction` VALUES ('2791', '46', '2', '21', '2019-02-24 08:25:51');
INSERT INTO `useraction` VALUES ('2792', '9', '55', '11', '2019-02-24 08:25:52');
INSERT INTO `useraction` VALUES ('2793', '43', '1', '21', '2019-02-24 08:25:53');
INSERT INTO `useraction` VALUES ('2794', '40', '2', '21', '2019-02-24 08:25:55');
INSERT INTO `useraction` VALUES ('2795', '17', '6', '21', '2019-02-24 08:25:55');
INSERT INTO `useraction` VALUES ('2796', '26', '6', '21', '2019-02-24 08:25:56');
INSERT INTO `useraction` VALUES ('2797', '24', '37', '11', '2019-02-24 08:25:57');
INSERT INTO `useraction` VALUES ('2798', '40', '53', '11', '2019-02-24 08:25:58');
INSERT INTO `useraction` VALUES ('2799', '17', '1', '21', '2019-02-24 08:26:00');
INSERT INTO `useraction` VALUES ('2800', '47', '5', '21', '2019-02-24 08:26:01');
INSERT INTO `useraction` VALUES ('2801', '23', '3', '21', '2019-02-24 08:26:05');
INSERT INTO `useraction` VALUES ('2802', '4', '5', '21', '2019-02-24 08:26:07');
INSERT INTO `useraction` VALUES ('2803', '16', '4', '21', '2019-02-24 08:26:07');
INSERT INTO `useraction` VALUES ('2804', '25', '4', '21', '2019-02-24 08:26:09');
INSERT INTO `useraction` VALUES ('2805', '4', '22', '11', '2019-02-24 08:26:10');
INSERT INTO `useraction` VALUES ('2806', '50', '77', '11', '2019-02-24 08:26:10');
INSERT INTO `useraction` VALUES ('2807', '11', '5', '24', '2019-02-24 08:26:11');
INSERT INTO `useraction` VALUES ('2808', '8', '6', '22', '2019-02-24 08:26:12');
INSERT INTO `useraction` VALUES ('2809', '31', '3', '21', '2019-02-24 08:26:14');
INSERT INTO `useraction` VALUES ('2810', '50', '6', '22', '2019-02-24 08:26:15');
INSERT INTO `useraction` VALUES ('2811', '36', '70', '11', '2019-02-24 08:26:16');
INSERT INTO `useraction` VALUES ('2812', '22', '1', '21', '2019-02-24 08:26:18');
INSERT INTO `useraction` VALUES ('2813', '6', '90', '13', '2019-02-24 08:26:19');
INSERT INTO `useraction` VALUES ('2814', '33', '3', '21', '2019-02-24 08:26:19');
INSERT INTO `useraction` VALUES ('2815', '6', '2', '21', '2019-02-24 08:26:23');
INSERT INTO `useraction` VALUES ('2816', '48', '1', '21', '2019-02-24 08:26:24');
INSERT INTO `useraction` VALUES ('2817', '10', '65', '11', '2019-02-24 08:26:27');
INSERT INTO `useraction` VALUES ('2818', '45', '1', '21', '2019-02-24 08:26:27');
INSERT INTO `useraction` VALUES ('2819', '26', '2', '21', '2019-02-24 08:26:29');
INSERT INTO `useraction` VALUES ('2820', '44', '64', '11', '2019-02-24 08:26:29');
INSERT INTO `useraction` VALUES ('2821', '11', '1', '21', '2019-02-24 08:26:30');
INSERT INTO `useraction` VALUES ('2822', '9', '2', '14', '2019-02-24 08:26:32');
INSERT INTO `useraction` VALUES ('2823', '50', '1', '21', '2019-02-24 08:26:35');
INSERT INTO `useraction` VALUES ('2824', '28', '5', '21', '2019-02-24 08:26:35');
INSERT INTO `useraction` VALUES ('2825', '29', '56', '11', '2019-02-24 08:26:36');
INSERT INTO `useraction` VALUES ('2826', '33', '5', '21', '2019-02-24 08:26:38');
INSERT INTO `useraction` VALUES ('2827', '27', '1', '21', '2019-02-24 08:26:40');
INSERT INTO `useraction` VALUES ('2828', '20', '9', '11', '2019-02-24 08:26:41');
INSERT INTO `useraction` VALUES ('2829', '12', '5', '21', '2019-02-24 08:26:47');
INSERT INTO `useraction` VALUES ('2830', '25', '23', '11', '2019-02-24 08:26:47');
INSERT INTO `useraction` VALUES ('2831', '47', '2', '21', '2019-02-24 08:26:49');
INSERT INTO `useraction` VALUES ('2832', '48', '6', '21', '2019-02-24 08:26:49');
INSERT INTO `useraction` VALUES ('2833', '47', '85', '11', '2019-02-24 08:26:50');
INSERT INTO `useraction` VALUES ('2834', '29', '3', '21', '2019-02-24 08:26:51');
INSERT INTO `useraction` VALUES ('2835', '11', '85', '11', '2019-02-24 08:26:53');
INSERT INTO `useraction` VALUES ('2836', '33', '1', '21', '2019-02-24 08:26:54');
INSERT INTO `useraction` VALUES ('2837', '44', '32', '11', '2019-02-24 08:26:56');
INSERT INTO `useraction` VALUES ('2838', '47', '1', '50', '2019-02-24 08:26:57');
INSERT INTO `useraction` VALUES ('2839', '37', '3', '21', '2019-02-24 08:26:58');
INSERT INTO `useraction` VALUES ('2840', '49', '32', '11', '2019-02-24 08:26:59');
INSERT INTO `useraction` VALUES ('2841', '24', '38', '11', '2019-02-24 08:27:00');
INSERT INTO `useraction` VALUES ('2842', '35', '6', '21', '2019-02-24 08:27:01');
INSERT INTO `useraction` VALUES ('2843', '37', '91', '11', '2019-02-24 08:27:02');
INSERT INTO `useraction` VALUES ('2844', '34', '1', '3', '2019-02-24 08:27:03');
INSERT INTO `useraction` VALUES ('2845', '8', '2', '50', '2019-02-24 08:27:03');
INSERT INTO `useraction` VALUES ('2846', '14', '14', '11', '2019-02-24 08:27:07');
INSERT INTO `useraction` VALUES ('2847', '38', '39', '11', '2019-02-24 08:27:09');
INSERT INTO `useraction` VALUES ('2848', '22', '92', '11', '2019-02-24 08:27:09');
INSERT INTO `useraction` VALUES ('2849', '35', '70', '11', '2019-02-24 08:27:10');
INSERT INTO `useraction` VALUES ('2850', '43', '1', '21', '2019-02-24 08:27:12');
INSERT INTO `useraction` VALUES ('2851', '50', '1', '50', '2019-02-24 08:27:12');
INSERT INTO `useraction` VALUES ('2852', '45', '3', '21', '2019-02-24 08:27:15');
INSERT INTO `useraction` VALUES ('2853', '43', '5', '21', '2019-02-24 08:27:17');
INSERT INTO `useraction` VALUES ('2854', '21', '8', '11', '2019-02-24 08:27:17');
INSERT INTO `useraction` VALUES ('2855', '16', '4', '21', '2019-02-24 08:27:19');
INSERT INTO `useraction` VALUES ('2856', '33', '6', '21', '2019-02-24 08:27:21');
INSERT INTO `useraction` VALUES ('2857', '9', '78', '11', '2019-02-24 08:27:22');
INSERT INTO `useraction` VALUES ('2858', '47', '6', '13', '2019-02-24 08:27:23');
INSERT INTO `useraction` VALUES ('2859', '29', '6', '21', '2019-02-24 08:27:24');
INSERT INTO `useraction` VALUES ('2860', '32', '2', '23', '2019-02-24 08:27:25');
INSERT INTO `useraction` VALUES ('2861', '11', '6', '21', '2019-02-24 08:27:25');
INSERT INTO `useraction` VALUES ('2862', '22', '84', '11', '2019-02-24 08:27:26');
INSERT INTO `useraction` VALUES ('2863', '7', '5', '21', '2019-02-24 08:27:27');
INSERT INTO `useraction` VALUES ('2864', '15', '3', '21', '2019-02-24 08:27:27');
INSERT INTO `useraction` VALUES ('2865', '40', '4', '21', '2019-02-24 08:27:28');
INSERT INTO `useraction` VALUES ('2866', '7', '5', '21', '2019-02-24 08:27:29');
INSERT INTO `useraction` VALUES ('2867', '37', '4', '21', '2019-02-24 08:27:30');
INSERT INTO `useraction` VALUES ('2868', '24', '2', '11', '2019-02-24 08:27:32');
INSERT INTO `useraction` VALUES ('2869', '5', '4', '21', '2019-02-24 08:27:33');
INSERT INTO `useraction` VALUES ('2870', '6', '2', '4', '2019-02-24 08:27:33');
INSERT INTO `useraction` VALUES ('2871', '27', '2', '21', '2019-02-24 08:27:34');
INSERT INTO `useraction` VALUES ('2872', '17', '2', '3', '2019-02-24 08:27:37');
INSERT INTO `useraction` VALUES ('2873', '29', '77', '11', '2019-02-24 08:27:39');
INSERT INTO `useraction` VALUES ('2874', '12', '1', '21', '2019-02-24 08:27:41');
INSERT INTO `useraction` VALUES ('2875', '42', '3', '2', '2019-02-24 08:27:42');
INSERT INTO `useraction` VALUES ('2876', '38', '2', '21', '2019-02-24 08:27:43');
INSERT INTO `useraction` VALUES ('2877', '38', '6', '21', '2019-02-24 08:27:45');
INSERT INTO `useraction` VALUES ('2878', '49', '4', '1', '2019-02-24 08:27:46');
INSERT INTO `useraction` VALUES ('2879', '42', '2', '21', '2019-02-24 08:27:46');
INSERT INTO `useraction` VALUES ('2880', '7', '91', '11', '2019-02-24 08:27:48');
INSERT INTO `useraction` VALUES ('2881', '10', '6', '21', '2019-02-24 08:27:48');
INSERT INTO `useraction` VALUES ('2882', '48', '1', '21', '2019-02-24 08:27:49');
INSERT INTO `useraction` VALUES ('2883', '40', '4', '21', '2019-02-24 08:27:49');
INSERT INTO `useraction` VALUES ('2884', '27', '5', '21', '2019-02-24 08:27:51');
INSERT INTO `useraction` VALUES ('2885', '20', '48', '11', '2019-02-24 08:27:52');
INSERT INTO `useraction` VALUES ('2886', '38', '4', '21', '2019-02-24 08:28:03');
INSERT INTO `useraction` VALUES ('2887', '4', '3', '3', '2019-02-24 08:28:03');
INSERT INTO `useraction` VALUES ('2888', '42', '67', '11', '2019-02-24 08:28:04');
INSERT INTO `useraction` VALUES ('2889', '45', '1', '11', '2019-02-24 08:28:05');
INSERT INTO `useraction` VALUES ('2890', '26', '31', '11', '2019-02-24 08:28:06');
INSERT INTO `useraction` VALUES ('2891', '41', '1', '21', '2019-02-24 08:28:06');
INSERT INTO `useraction` VALUES ('2892', '4', '3', '14', '2019-02-24 08:28:08');
INSERT INTO `useraction` VALUES ('2893', '49', '78', '11', '2019-02-24 08:28:09');
INSERT INTO `useraction` VALUES ('2894', '30', '9', '11', '2019-02-24 08:28:10');
INSERT INTO `useraction` VALUES ('2895', '22', '69', '11', '2019-02-24 08:28:10');
INSERT INTO `useraction` VALUES ('2896', '18', '63', '11', '2019-02-24 08:28:12');
INSERT INTO `useraction` VALUES ('2897', '8', '4', '21', '2019-02-24 08:28:14');
INSERT INTO `useraction` VALUES ('2898', '46', '54', '12', '2019-02-24 08:28:15');
INSERT INTO `useraction` VALUES ('2899', '8', '6', '21', '2019-02-24 08:28:33');
INSERT INTO `useraction` VALUES ('2900', '8', '6', '21', '2019-02-24 08:28:33');
INSERT INTO `useraction` VALUES ('2901', '12', '44', '11', '2019-02-24 08:28:34');
INSERT INTO `useraction` VALUES ('2902', '40', '62', '11', '2019-02-24 08:28:34');
INSERT INTO `useraction` VALUES ('2903', '32', '6', '21', '2019-02-24 08:28:35');
INSERT INTO `useraction` VALUES ('2904', '36', '3', '21', '2019-02-24 08:28:36');
INSERT INTO `useraction` VALUES ('2905', '7', '71', '11', '2019-02-24 08:28:37');
INSERT INTO `useraction` VALUES ('2906', '45', '1', '21', '2019-02-24 08:28:38');
INSERT INTO `useraction` VALUES ('2907', '46', '61', '11', '2019-02-24 08:28:38');
INSERT INTO `useraction` VALUES ('2908', '12', '4', '21', '2019-02-24 08:28:40');
INSERT INTO `useraction` VALUES ('2909', '39', '5', '21', '2019-02-24 08:28:41');
INSERT INTO `useraction` VALUES ('2910', '47', '78', '11', '2019-02-24 08:28:42');
INSERT INTO `useraction` VALUES ('2911', '25', '5', '21', '2019-02-24 08:28:43');
INSERT INTO `useraction` VALUES ('2912', '49', '95', '11', '2019-02-24 08:28:45');
INSERT INTO `useraction` VALUES ('2913', '37', '2', '2', '2019-02-24 08:28:46');
INSERT INTO `useraction` VALUES ('2914', '48', '6', '21', '2019-02-24 08:28:48');
INSERT INTO `useraction` VALUES ('2915', '2', '4', '50', '2019-02-24 08:28:51');
INSERT INTO `useraction` VALUES ('2916', '49', '4', '21', '2019-02-24 08:28:54');
INSERT INTO `useraction` VALUES ('2917', '6', '6', '21', '2019-02-24 08:28:55');
INSERT INTO `useraction` VALUES ('2918', '19', '2', '25', '2019-02-24 08:28:57');
INSERT INTO `useraction` VALUES ('2919', '17', '4', '21', '2019-02-24 08:28:58');
INSERT INTO `useraction` VALUES ('2920', '7', '3', '21', '2019-02-24 08:28:58');
INSERT INTO `useraction` VALUES ('2921', '45', '43', '11', '2019-02-24 08:29:00');
INSERT INTO `useraction` VALUES ('2922', '31', '1', '21', '2019-02-24 08:29:01');
INSERT INTO `useraction` VALUES ('2923', '48', '2', '21', '2019-02-24 08:29:03');
INSERT INTO `useraction` VALUES ('2924', '16', '4', '21', '2019-02-24 08:29:04');
INSERT INTO `useraction` VALUES ('2925', '20', '2', '21', '2019-02-24 08:29:05');
INSERT INTO `useraction` VALUES ('2926', '49', '5', '21', '2019-02-24 08:29:06');
INSERT INTO `useraction` VALUES ('2927', '41', '1', '21', '2019-02-24 08:29:06');
INSERT INTO `useraction` VALUES ('2928', '45', '84', '11', '2019-02-24 08:29:08');
INSERT INTO `useraction` VALUES ('2929', '46', '4', '21', '2019-02-24 08:29:09');
INSERT INTO `useraction` VALUES ('2930', '1', '4', '21', '2019-02-24 08:29:10');
INSERT INTO `useraction` VALUES ('2931', '16', '5', '21', '2019-02-24 08:29:10');
INSERT INTO `useraction` VALUES ('2932', '45', '72', '11', '2019-02-24 08:29:11');
INSERT INTO `useraction` VALUES ('2933', '26', '23', '11', '2019-02-24 08:29:12');
INSERT INTO `useraction` VALUES ('2934', '9', '4', '21', '2019-02-24 08:29:13');
INSERT INTO `useraction` VALUES ('2935', '9', '64', '11', '2019-02-24 08:29:16');
INSERT INTO `useraction` VALUES ('2936', '44', '24', '11', '2019-02-24 08:29:17');
INSERT INTO `useraction` VALUES ('2937', '32', '10', '11', '2019-02-24 08:29:18');
INSERT INTO `useraction` VALUES ('2938', '25', '6', '23', '2019-02-24 08:29:19');
INSERT INTO `useraction` VALUES ('2939', '29', '37', '11', '2019-02-24 08:29:20');
INSERT INTO `useraction` VALUES ('2940', '48', '2', '21', '2019-02-24 08:29:20');
INSERT INTO `useraction` VALUES ('2941', '36', '2', '21', '2019-02-24 08:29:22');
INSERT INTO `useraction` VALUES ('2942', '32', '1', '21', '2019-02-24 08:29:24');
INSERT INTO `useraction` VALUES ('2943', '33', '6', '24', '2019-02-24 08:29:24');
INSERT INTO `useraction` VALUES ('2944', '26', '4', '21', '2019-02-24 08:29:25');
INSERT INTO `useraction` VALUES ('2945', '34', '80', '11', '2019-02-24 08:29:27');
INSERT INTO `useraction` VALUES ('2946', '41', '23', '13', '2019-02-24 08:29:27');
INSERT INTO `useraction` VALUES ('2947', '47', '15', '11', '2019-02-24 08:29:28');
INSERT INTO `useraction` VALUES ('2948', '11', '67', '11', '2019-02-24 08:29:29');
INSERT INTO `useraction` VALUES ('2949', '43', '6', '21', '2019-02-24 08:29:29');
INSERT INTO `useraction` VALUES ('2950', '13', '1', '21', '2019-02-24 08:29:30');
INSERT INTO `useraction` VALUES ('2951', '41', '2', '21', '2019-02-24 08:29:31');
INSERT INTO `useraction` VALUES ('2952', '37', '5', '21', '2019-02-24 08:29:31');
INSERT INTO `useraction` VALUES ('2953', '41', '3', '21', '2019-02-24 08:29:32');
INSERT INTO `useraction` VALUES ('2954', '32', '46', '11', '2019-02-24 08:29:33');
INSERT INTO `useraction` VALUES ('2955', '26', '94', '11', '2019-02-24 08:29:35');
INSERT INTO `useraction` VALUES ('2956', '47', '78', '11', '2019-02-24 08:29:35');
INSERT INTO `useraction` VALUES ('2957', '50', '5', '21', '2019-02-24 08:29:42');
INSERT INTO `useraction` VALUES ('2958', '10', '6', '21', '2019-02-24 08:29:46');
INSERT INTO `useraction` VALUES ('2959', '5', '4', '21', '2019-02-24 08:29:49');
INSERT INTO `useraction` VALUES ('2960', '50', '85', '11', '2019-02-24 08:29:51');
INSERT INTO `useraction` VALUES ('2961', '35', '5', '21', '2019-02-24 08:29:55');
INSERT INTO `useraction` VALUES ('2962', '18', '6', '11', '2019-02-24 08:29:56');
INSERT INTO `useraction` VALUES ('2963', '32', '78', '11', '2019-02-24 08:29:58');
INSERT INTO `useraction` VALUES ('2964', '19', '4', '21', '2019-02-24 08:30:00');
INSERT INTO `useraction` VALUES ('2965', '28', '5', '21', '2019-02-24 08:30:03');
INSERT INTO `useraction` VALUES ('2966', '43', '3', '21', '2019-02-24 08:30:04');
INSERT INTO `useraction` VALUES ('2967', '27', '1', '22', '2019-02-24 08:30:05');
INSERT INTO `useraction` VALUES ('2968', '9', '3', '21', '2019-02-24 08:30:07');
INSERT INTO `useraction` VALUES ('2969', '41', '3', '23', '2019-02-24 08:30:08');
INSERT INTO `useraction` VALUES ('2970', '26', '71', '11', '2019-02-24 08:30:09');
INSERT INTO `useraction` VALUES ('2971', '40', '6', '21', '2019-02-24 08:30:09');
INSERT INTO `useraction` VALUES ('2972', '3', '3', '21', '2019-02-24 08:30:10');
INSERT INTO `useraction` VALUES ('2973', '10', '6', '21', '2019-02-24 08:30:13');
INSERT INTO `useraction` VALUES ('2974', '26', '26', '11', '2019-02-24 08:30:14');
INSERT INTO `useraction` VALUES ('2975', '22', '57', '11', '2019-02-24 08:30:15');
INSERT INTO `useraction` VALUES ('2976', '29', '6', '21', '2019-02-24 08:30:16');
INSERT INTO `useraction` VALUES ('2977', '41', '23', '11', '2019-02-24 08:30:17');
INSERT INTO `useraction` VALUES ('2978', '23', '6', '21', '2019-02-24 08:30:18');
INSERT INTO `useraction` VALUES ('2979', '41', '47', '11', '2019-02-24 08:30:22');
INSERT INTO `useraction` VALUES ('2980', '33', '80', '11', '2019-02-24 08:30:23');
INSERT INTO `useraction` VALUES ('2981', '31', '42', '11', '2019-02-24 08:30:23');
INSERT INTO `useraction` VALUES ('2982', '5', '6', '24', '2019-02-24 08:30:24');
INSERT INTO `useraction` VALUES ('2983', '39', '5', '21', '2019-02-24 08:30:30');
INSERT INTO `useraction` VALUES ('2984', '33', '4', '50', '2019-02-24 08:30:31');
INSERT INTO `useraction` VALUES ('2985', '32', '59', '11', '2019-02-24 08:30:33');
INSERT INTO `useraction` VALUES ('2986', '10', '4', '21', '2019-02-24 08:30:34');
INSERT INTO `useraction` VALUES ('2987', '13', '4', '21', '2019-02-24 08:30:36');
INSERT INTO `useraction` VALUES ('2988', '32', '4', '21', '2019-02-24 08:30:36');
INSERT INTO `useraction` VALUES ('2989', '17', '4', '21', '2019-02-24 08:30:37');
INSERT INTO `useraction` VALUES ('2990', '22', '25', '11', '2019-02-24 08:30:39');
INSERT INTO `useraction` VALUES ('2991', '33', '3', '21', '2019-02-24 08:30:41');
INSERT INTO `useraction` VALUES ('2992', '29', '2', '21', '2019-02-24 08:30:42');
INSERT INTO `useraction` VALUES ('2993', '50', '3', '21', '2019-02-24 08:30:43');
INSERT INTO `useraction` VALUES ('2994', '5', '4', '13', '2019-02-24 08:30:44');
INSERT INTO `useraction` VALUES ('2995', '3', '93', '11', '2019-02-24 08:30:45');
INSERT INTO `useraction` VALUES ('2996', '5', '3', '21', '2019-02-24 08:30:45');
INSERT INTO `useraction` VALUES ('2997', '34', '85', '11', '2019-02-24 08:30:47');
INSERT INTO `useraction` VALUES ('2998', '24', '75', '11', '2019-02-24 08:30:47');
INSERT INTO `useraction` VALUES ('2999', '16', '5', '21', '2019-02-24 08:30:48');
INSERT INTO `useraction` VALUES ('3000', '13', '2', '21', '2019-02-24 08:30:50');
INSERT INTO `useraction` VALUES ('3001', '31', '3', '21', '2019-02-24 08:30:52');
INSERT INTO `useraction` VALUES ('3002', '32', '6', '21', '2019-02-24 08:30:56');
INSERT INTO `useraction` VALUES ('3003', '16', '2', '21', '2019-02-24 08:30:57');
INSERT INTO `useraction` VALUES ('3004', '26', '3', '21', '2019-02-24 08:30:57');
INSERT INTO `useraction` VALUES ('3005', '11', '41', '11', '2019-02-24 08:30:58');
INSERT INTO `useraction` VALUES ('3006', '30', '1', '21', '2019-02-24 08:30:58');
INSERT INTO `useraction` VALUES ('3007', '7', '6', '21', '2019-02-24 08:30:59');
INSERT INTO `useraction` VALUES ('3008', '19', '27', '11', '2019-02-24 08:31:01');
INSERT INTO `useraction` VALUES ('3009', '26', '47', '11', '2019-02-24 08:31:02');
INSERT INTO `useraction` VALUES ('3010', '40', '2', '11', '2019-02-24 08:31:02');
INSERT INTO `useraction` VALUES ('3011', '41', '13', '11', '2019-02-24 08:31:04');
INSERT INTO `useraction` VALUES ('3012', '22', '3', '21', '2019-02-24 08:31:05');
INSERT INTO `useraction` VALUES ('3013', '32', '13', '11', '2019-02-24 08:31:06');
INSERT INTO `useraction` VALUES ('3014', '22', '4', '21', '2019-02-24 08:31:07');
INSERT INTO `useraction` VALUES ('3015', '9', '48', '13', '2019-02-24 08:31:09');
INSERT INTO `useraction` VALUES ('3016', '14', '3', '21', '2019-02-24 08:31:11');
INSERT INTO `useraction` VALUES ('3017', '43', '4', '21', '2019-02-24 08:31:11');
INSERT INTO `useraction` VALUES ('3018', '2', '2', '50', '2019-02-24 08:31:12');
INSERT INTO `useraction` VALUES ('3019', '5', '36', '11', '2019-02-24 08:31:15');
INSERT INTO `useraction` VALUES ('3020', '7', '3', '21', '2019-02-24 08:31:17');
INSERT INTO `useraction` VALUES ('3021', '44', '3', '21', '2019-02-24 08:31:18');
INSERT INTO `useraction` VALUES ('3022', '5', '1', '21', '2019-02-24 08:31:19');
INSERT INTO `useraction` VALUES ('3023', '27', '1', '3', '2019-02-24 08:31:20');
INSERT INTO `useraction` VALUES ('3024', '45', '4', '21', '2019-02-24 08:31:21');
INSERT INTO `useraction` VALUES ('3025', '31', '3', '21', '2019-02-24 08:31:21');
INSERT INTO `useraction` VALUES ('3026', '28', '3', '21', '2019-02-24 08:31:23');
INSERT INTO `useraction` VALUES ('3027', '39', '1', '50', '2019-02-24 08:31:23');
INSERT INTO `useraction` VALUES ('3028', '26', '1', '21', '2019-02-24 08:31:25');
INSERT INTO `useraction` VALUES ('3029', '7', '59', '11', '2019-02-24 08:31:26');
INSERT INTO `useraction` VALUES ('3030', '6', '19', '11', '2019-02-24 08:31:28');
INSERT INTO `useraction` VALUES ('3031', '39', '39', '11', '2019-02-24 08:31:28');
INSERT INTO `useraction` VALUES ('3032', '40', '3', '21', '2019-02-24 08:31:29');
INSERT INTO `useraction` VALUES ('3033', '2', '6', '21', '2019-02-24 08:31:29');
INSERT INTO `useraction` VALUES ('3034', '34', '1', '21', '2019-02-24 08:31:30');
INSERT INTO `useraction` VALUES ('3035', '41', '3', '21', '2019-02-24 08:31:31');
INSERT INTO `useraction` VALUES ('3036', '36', '3', '21', '2019-02-24 08:31:32');
INSERT INTO `useraction` VALUES ('3037', '46', '19', '11', '2019-02-24 08:31:32');
INSERT INTO `useraction` VALUES ('3038', '24', '15', '11', '2019-02-24 08:31:33');
INSERT INTO `useraction` VALUES ('3039', '31', '81', '11', '2019-02-24 08:31:34');
INSERT INTO `useraction` VALUES ('3040', '50', '3', '21', '2019-02-24 08:31:34');
INSERT INTO `useraction` VALUES ('3041', '23', '1', '21', '2019-02-24 08:31:36');
INSERT INTO `useraction` VALUES ('3042', '37', '1', '21', '2019-02-24 08:31:37');
INSERT INTO `useraction` VALUES ('3043', '32', '22', '11', '2019-02-24 08:31:38');
INSERT INTO `useraction` VALUES ('3044', '25', '71', '11', '2019-02-24 08:31:39');
INSERT INTO `useraction` VALUES ('3045', '20', '3', '2', '2019-02-24 08:31:41');
INSERT INTO `useraction` VALUES ('3046', '42', '2', '21', '2019-02-24 08:31:42');
INSERT INTO `useraction` VALUES ('3047', '33', '1', '21', '2019-02-24 08:31:43');
INSERT INTO `useraction` VALUES ('3048', '7', '77', '11', '2019-02-24 08:31:46');
INSERT INTO `useraction` VALUES ('3049', '12', '5', '21', '2019-02-24 08:31:46');
INSERT INTO `useraction` VALUES ('3050', '45', '11', '12', '2019-02-24 08:31:47');
INSERT INTO `useraction` VALUES ('3051', '21', '6', '21', '2019-02-24 08:31:48');
INSERT INTO `useraction` VALUES ('3052', '21', '3', '21', '2019-02-24 08:31:49');
INSERT INTO `useraction` VALUES ('3053', '36', '6', '21', '2019-02-24 08:31:50');
INSERT INTO `useraction` VALUES ('3054', '13', '83', '11', '2019-02-24 08:31:51');
INSERT INTO `useraction` VALUES ('3055', '19', '2', '21', '2019-02-24 08:31:51');
INSERT INTO `useraction` VALUES ('3056', '41', '6', '21', '2019-02-24 08:31:54');
INSERT INTO `useraction` VALUES ('3057', '25', '4', '21', '2019-02-24 08:31:54');
INSERT INTO `useraction` VALUES ('3058', '39', '76', '11', '2019-02-24 08:31:55');
INSERT INTO `useraction` VALUES ('3059', '7', '2', '21', '2019-02-24 08:31:57');
INSERT INTO `useraction` VALUES ('3060', '7', '1', '14', '2019-02-24 08:31:58');
INSERT INTO `useraction` VALUES ('3061', '1', '1', '21', '2019-02-24 08:31:58');
INSERT INTO `useraction` VALUES ('3062', '1', '10', '11', '2019-02-24 08:31:59');
INSERT INTO `useraction` VALUES ('3063', '13', '28', '11', '2019-02-24 08:32:00');
INSERT INTO `useraction` VALUES ('3064', '20', '11', '11', '2019-02-24 08:32:01');
INSERT INTO `useraction` VALUES ('3065', '12', '2', '21', '2019-02-24 08:32:02');
INSERT INTO `useraction` VALUES ('3066', '9', '4', '21', '2019-02-24 08:32:02');
INSERT INTO `useraction` VALUES ('3067', '24', '1', '21', '2019-02-24 08:32:03');
INSERT INTO `useraction` VALUES ('3068', '25', '61', '12', '2019-02-24 08:32:04');
INSERT INTO `useraction` VALUES ('3069', '34', '2', '21', '2019-02-24 08:32:05');
INSERT INTO `useraction` VALUES ('3070', '21', '5', '21', '2019-02-24 08:32:06');
INSERT INTO `useraction` VALUES ('3071', '16', '1', '22', '2019-02-24 08:32:06');
INSERT INTO `useraction` VALUES ('3072', '9', '3', '21', '2019-02-24 08:32:07');
INSERT INTO `useraction` VALUES ('3073', '24', '19', '11', '2019-02-24 08:32:08');
INSERT INTO `useraction` VALUES ('3074', '2', '41', '11', '2019-02-24 08:32:09');
INSERT INTO `useraction` VALUES ('3075', '20', '3', '11', '2019-02-24 08:32:09');
INSERT INTO `useraction` VALUES ('3076', '26', '21', '11', '2019-02-24 08:32:10');
INSERT INTO `useraction` VALUES ('3077', '2', '1', '21', '2019-02-24 08:32:10');
INSERT INTO `useraction` VALUES ('3078', '2', '5', '21', '2019-02-24 08:32:11');
INSERT INTO `useraction` VALUES ('3079', '22', '2', '21', '2019-02-24 08:32:12');
INSERT INTO `useraction` VALUES ('3080', '24', '2', '11', '2019-02-24 08:32:12');
INSERT INTO `useraction` VALUES ('3081', '18', '33', '11', '2019-02-24 08:32:13');
INSERT INTO `useraction` VALUES ('3082', '6', '3', '21', '2019-02-24 08:32:14');
INSERT INTO `useraction` VALUES ('3083', '2', '2', '21', '2019-02-24 08:32:15');
INSERT INTO `useraction` VALUES ('3084', '46', '4', '21', '2019-02-24 08:32:16');
INSERT INTO `useraction` VALUES ('3085', '24', '33', '11', '2019-02-24 08:32:16');
INSERT INTO `useraction` VALUES ('3086', '35', '48', '11', '2019-02-24 08:32:17');
INSERT INTO `useraction` VALUES ('3087', '39', '17', '11', '2019-02-24 08:32:17');
INSERT INTO `useraction` VALUES ('3088', '35', '1', '21', '2019-02-24 08:32:18');
INSERT INTO `useraction` VALUES ('3089', '30', '4', '50', '2019-02-24 08:32:19');
INSERT INTO `useraction` VALUES ('3090', '41', '3', '21', '2019-02-24 08:32:20');
INSERT INTO `useraction` VALUES ('3091', '47', '82', '11', '2019-02-24 08:32:21');
INSERT INTO `useraction` VALUES ('3092', '48', '5', '21', '2019-02-24 08:32:21');
INSERT INTO `useraction` VALUES ('3093', '10', '74', '11', '2019-02-24 08:32:23');
INSERT INTO `useraction` VALUES ('3094', '44', '74', '11', '2019-02-24 08:32:24');
INSERT INTO `useraction` VALUES ('3095', '35', '2', '21', '2019-02-24 08:32:25');
INSERT INTO `useraction` VALUES ('3096', '17', '11', '11', '2019-02-24 08:32:26');
INSERT INTO `useraction` VALUES ('3097', '47', '6', '21', '2019-02-24 08:32:26');
INSERT INTO `useraction` VALUES ('3098', '21', '54', '11', '2019-02-24 08:32:27');
INSERT INTO `useraction` VALUES ('3099', '21', '5', '21', '2019-02-24 08:32:28');
INSERT INTO `useraction` VALUES ('3100', '13', '3', '50', '2019-02-24 08:32:29');
INSERT INTO `useraction` VALUES ('3101', '2', '4', '3', '2019-02-24 08:32:30');
INSERT INTO `useraction` VALUES ('3102', '46', '66', '12', '2019-02-24 08:32:31');
INSERT INTO `useraction` VALUES ('3103', '2', '96', '11', '2019-02-24 08:32:32');
INSERT INTO `useraction` VALUES ('3104', '48', '3', '21', '2019-02-24 08:32:33');
INSERT INTO `useraction` VALUES ('3105', '39', '1', '21', '2019-02-24 08:32:34');
INSERT INTO `useraction` VALUES ('3106', '41', '85', '11', '2019-02-24 08:32:36');
INSERT INTO `useraction` VALUES ('3107', '11', '2', '21', '2019-02-24 08:32:36');
INSERT INTO `useraction` VALUES ('3108', '26', '35', '11', '2019-02-24 08:32:37');
INSERT INTO `useraction` VALUES ('3109', '2', '6', '21', '2019-02-24 08:32:38');
INSERT INTO `useraction` VALUES ('3110', '12', '1', '23', '2019-02-24 08:32:38');
INSERT INTO `useraction` VALUES ('3111', '30', '41', '11', '2019-02-24 08:32:40');
INSERT INTO `useraction` VALUES ('3112', '27', '5', '21', '2019-02-24 08:32:40');
INSERT INTO `useraction` VALUES ('3113', '28', '25', '11', '2019-02-24 08:32:41');
INSERT INTO `useraction` VALUES ('3114', '39', '83', '11', '2019-02-24 08:32:41');
INSERT INTO `useraction` VALUES ('3115', '47', '5', '21', '2019-02-24 08:32:42');
INSERT INTO `useraction` VALUES ('3116', '32', '3', '21', '2019-02-24 08:32:44');
INSERT INTO `useraction` VALUES ('3117', '48', '4', '21', '2019-02-24 08:32:46');
INSERT INTO `useraction` VALUES ('3118', '43', '38', '11', '2019-02-24 08:32:47');
INSERT INTO `useraction` VALUES ('3119', '5', '1', '21', '2019-02-24 08:32:48');
INSERT INTO `useraction` VALUES ('3120', '50', '1', '21', '2019-02-24 08:32:48');
INSERT INTO `useraction` VALUES ('3121', '40', '1', '21', '2019-02-24 08:32:49');
INSERT INTO `useraction` VALUES ('3122', '25', '3', '11', '2019-02-24 08:32:50');
INSERT INTO `useraction` VALUES ('3123', '12', '1', '21', '2019-02-24 08:32:51');
INSERT INTO `useraction` VALUES ('3124', '3', '7', '11', '2019-02-24 08:32:52');
INSERT INTO `useraction` VALUES ('3125', '46', '2', '2', '2019-02-24 08:32:52');
INSERT INTO `useraction` VALUES ('3126', '31', '2', '50', '2019-02-24 08:32:53');
INSERT INTO `useraction` VALUES ('3127', '47', '74', '11', '2019-02-24 08:32:54');
INSERT INTO `useraction` VALUES ('3128', '16', '97', '11', '2019-02-24 08:32:55');
INSERT INTO `useraction` VALUES ('3129', '13', '4', '21', '2019-02-24 08:32:56');
INSERT INTO `useraction` VALUES ('3130', '19', '4', '21', '2019-02-24 08:32:57');
INSERT INTO `useraction` VALUES ('3131', '33', '15', '11', '2019-02-24 08:32:58');
INSERT INTO `useraction` VALUES ('3132', '47', '6', '21', '2019-02-24 08:32:59');
INSERT INTO `useraction` VALUES ('3133', '15', '4', '11', '2019-02-24 08:32:59');
INSERT INTO `useraction` VALUES ('3134', '10', '15', '11', '2019-02-24 08:33:01');
INSERT INTO `useraction` VALUES ('3135', '18', '3', '21', '2019-02-24 08:33:02');
INSERT INTO `useraction` VALUES ('3136', '1', '4', '21', '2019-02-24 08:33:04');
INSERT INTO `useraction` VALUES ('3137', '34', '1', '11', '2019-02-24 08:33:05');
INSERT INTO `useraction` VALUES ('3138', '10', '3', '21', '2019-02-24 08:33:06');
INSERT INTO `useraction` VALUES ('3139', '13', '29', '11', '2019-02-24 08:33:07');
INSERT INTO `useraction` VALUES ('3140', '33', '4', '21', '2019-02-24 08:33:08');
INSERT INTO `useraction` VALUES ('3141', '34', '6', '22', '2019-02-24 08:33:10');
INSERT INTO `useraction` VALUES ('3142', '26', '3', '21', '2019-02-24 08:33:11');
INSERT INTO `useraction` VALUES ('3143', '37', '2', '21', '2019-02-24 08:33:12');
INSERT INTO `useraction` VALUES ('3144', '4', '2', '21', '2019-02-24 08:33:13');
INSERT INTO `useraction` VALUES ('3145', '9', '5', '21', '2019-02-24 08:33:14');
INSERT INTO `useraction` VALUES ('3146', '15', '28', '11', '2019-02-24 08:33:15');
INSERT INTO `useraction` VALUES ('3147', '35', '5', '21', '2019-02-24 08:33:17');
INSERT INTO `useraction` VALUES ('3148', '26', '6', '22', '2019-02-24 08:33:17');
INSERT INTO `useraction` VALUES ('3149', '15', '29', '11', '2019-02-24 08:33:18');
INSERT INTO `useraction` VALUES ('3150', '48', '3', '21', '2019-02-24 08:33:20');
INSERT INTO `useraction` VALUES ('3151', '44', '37', '11', '2019-02-24 08:33:20');
INSERT INTO `useraction` VALUES ('3152', '32', '3', '21', '2019-02-24 08:33:21');
INSERT INTO `useraction` VALUES ('3153', '48', '6', '21', '2019-02-24 08:33:22');
INSERT INTO `useraction` VALUES ('3154', '36', '69', '11', '2019-02-24 08:33:23');
INSERT INTO `useraction` VALUES ('3155', '8', '2', '21', '2019-02-24 08:33:24');
INSERT INTO `useraction` VALUES ('3156', '20', '66', '11', '2019-02-24 08:33:24');
INSERT INTO `useraction` VALUES ('3157', '34', '3', '21', '2019-02-24 08:33:25');
INSERT INTO `useraction` VALUES ('3158', '35', '5', '21', '2019-02-24 08:33:26');
INSERT INTO `useraction` VALUES ('3159', '45', '65', '11', '2019-02-24 08:33:29');
INSERT INTO `useraction` VALUES ('3160', '5', '55', '11', '2019-02-24 08:33:29');
INSERT INTO `useraction` VALUES ('3161', '32', '71', '11', '2019-02-24 08:33:30');
INSERT INTO `useraction` VALUES ('3162', '27', '91', '11', '2019-02-24 08:33:31');
INSERT INTO `useraction` VALUES ('3163', '31', '94', '13', '2019-02-24 08:33:34');
INSERT INTO `useraction` VALUES ('3164', '36', '1', '21', '2019-02-24 08:33:35');
INSERT INTO `useraction` VALUES ('3165', '11', '49', '11', '2019-02-24 08:33:36');
INSERT INTO `useraction` VALUES ('3166', '11', '2', '21', '2019-02-24 08:33:37');
INSERT INTO `useraction` VALUES ('3167', '49', '74', '11', '2019-02-24 08:33:39');
INSERT INTO `useraction` VALUES ('3168', '5', '45', '11', '2019-02-24 08:33:41');
INSERT INTO `useraction` VALUES ('3169', '1', '8', '11', '2019-02-24 08:33:42');
INSERT INTO `useraction` VALUES ('3170', '30', '2', '21', '2019-02-24 08:33:44');
INSERT INTO `useraction` VALUES ('3171', '47', '53', '11', '2019-02-24 08:33:46');
INSERT INTO `useraction` VALUES ('3172', '10', '6', '21', '2019-02-24 08:33:49');
INSERT INTO `useraction` VALUES ('3173', '16', '3', '21', '2019-02-24 08:33:50');
INSERT INTO `useraction` VALUES ('3174', '40', '5', '11', '2019-02-24 08:33:53');
INSERT INTO `useraction` VALUES ('3175', '23', '5', '21', '2019-02-24 08:33:53');
INSERT INTO `useraction` VALUES ('3176', '29', '2', '14', '2019-02-24 08:33:55');
INSERT INTO `useraction` VALUES ('3177', '41', '3', '21', '2019-02-24 08:33:57');
INSERT INTO `useraction` VALUES ('3178', '44', '67', '11', '2019-02-24 08:34:00');
INSERT INTO `useraction` VALUES ('3179', '34', '4', '21', '2019-02-24 08:34:01');
INSERT INTO `useraction` VALUES ('3180', '30', '4', '21', '2019-02-24 08:34:01');
INSERT INTO `useraction` VALUES ('3181', '38', '87', '11', '2019-02-24 08:34:02');
INSERT INTO `useraction` VALUES ('3182', '34', '3', '21', '2019-02-24 08:34:03');
INSERT INTO `useraction` VALUES ('3183', '34', '1', '21', '2019-02-24 08:34:04');
INSERT INTO `useraction` VALUES ('3184', '36', '66', '11', '2019-02-24 08:34:04');
INSERT INTO `useraction` VALUES ('3185', '24', '2', '21', '2019-02-24 08:34:05');
INSERT INTO `useraction` VALUES ('3186', '39', '4', '21', '2019-02-24 08:34:06');
INSERT INTO `useraction` VALUES ('3187', '36', '1', '21', '2019-02-24 08:34:07');
INSERT INTO `useraction` VALUES ('3188', '17', '53', '11', '2019-02-24 08:34:07');
INSERT INTO `useraction` VALUES ('3189', '37', '4', '21', '2019-02-24 08:34:08');
INSERT INTO `useraction` VALUES ('3190', '22', '3', '21', '2019-02-24 08:34:10');
INSERT INTO `useraction` VALUES ('3191', '23', '2', '21', '2019-02-24 08:34:10');
INSERT INTO `useraction` VALUES ('3192', '26', '76', '11', '2019-02-24 08:34:12');
INSERT INTO `useraction` VALUES ('3193', '17', '2', '21', '2019-02-24 08:34:13');
INSERT INTO `useraction` VALUES ('3194', '26', '4', '24', '2019-02-24 08:34:13');
INSERT INTO `useraction` VALUES ('3195', '39', '92', '11', '2019-02-24 08:34:14');
INSERT INTO `useraction` VALUES ('3196', '34', '1', '21', '2019-02-24 08:34:15');
INSERT INTO `useraction` VALUES ('3197', '35', '1', '21', '2019-02-24 08:34:15');
INSERT INTO `useraction` VALUES ('3198', '3', '2', '3', '2019-02-24 08:34:17');
INSERT INTO `useraction` VALUES ('3199', '27', '4', '21', '2019-02-24 08:34:17');
INSERT INTO `useraction` VALUES ('3200', '5', '2', '21', '2019-02-24 08:34:19');
INSERT INTO `useraction` VALUES ('3201', '40', '4', '21', '2019-02-24 08:34:20');
INSERT INTO `useraction` VALUES ('3202', '35', '4', '21', '2019-02-24 08:34:20');
INSERT INTO `useraction` VALUES ('3203', '46', '54', '11', '2019-02-24 08:34:21');
INSERT INTO `useraction` VALUES ('3204', '15', '31', '11', '2019-02-24 08:34:22');
INSERT INTO `useraction` VALUES ('3205', '13', '31', '11', '2019-02-24 08:34:24');
INSERT INTO `useraction` VALUES ('3206', '21', '1', '25', '2019-02-24 08:34:24');
INSERT INTO `useraction` VALUES ('3207', '44', '3', '21', '2019-02-24 08:34:26');
INSERT INTO `useraction` VALUES ('3208', '23', '2', '21', '2019-02-24 08:34:27');
INSERT INTO `useraction` VALUES ('3209', '15', '29', '11', '2019-02-24 08:34:28');
INSERT INTO `useraction` VALUES ('3210', '38', '6', '21', '2019-02-24 08:34:28');
INSERT INTO `useraction` VALUES ('3211', '30', '6', '21', '2019-02-24 08:34:29');
INSERT INTO `useraction` VALUES ('3212', '26', '5', '21', '2019-02-24 08:34:30');
INSERT INTO `useraction` VALUES ('3213', '20', '1', '2', '2019-02-24 08:34:31');
INSERT INTO `useraction` VALUES ('3214', '15', '5', '21', '2019-02-24 08:34:32');
INSERT INTO `useraction` VALUES ('3215', '21', '6', '21', '2019-02-24 08:34:33');
INSERT INTO `useraction` VALUES ('3216', '30', '5', '21', '2019-02-24 08:34:33');
INSERT INTO `useraction` VALUES ('3217', '42', '1', '21', '2019-02-24 08:34:34');
INSERT INTO `useraction` VALUES ('3218', '39', '71', '11', '2019-02-24 08:34:34');
INSERT INTO `useraction` VALUES ('3219', '42', '88', '11', '2019-02-24 08:34:35');
INSERT INTO `useraction` VALUES ('3220', '19', '67', '11', '2019-02-24 08:34:38');
INSERT INTO `useraction` VALUES ('3221', '22', '5', '21', '2019-02-24 08:34:38');
INSERT INTO `useraction` VALUES ('3222', '12', '5', '21', '2019-02-24 08:34:39');
INSERT INTO `useraction` VALUES ('3223', '13', '1', '21', '2019-02-24 08:34:40');
INSERT INTO `useraction` VALUES ('3224', '6', '93', '11', '2019-02-24 08:34:40');
INSERT INTO `useraction` VALUES ('3225', '32', '35', '11', '2019-02-24 08:34:42');
INSERT INTO `useraction` VALUES ('3226', '33', '44', '11', '2019-02-24 08:34:43');
INSERT INTO `useraction` VALUES ('3227', '2', '6', '21', '2019-02-24 08:34:43');
INSERT INTO `useraction` VALUES ('3228', '42', '26', '11', '2019-02-24 08:34:44');
INSERT INTO `useraction` VALUES ('3229', '12', '95', '11', '2019-02-24 08:34:45');
INSERT INTO `useraction` VALUES ('3230', '26', '1', '21', '2019-02-24 08:34:45');
INSERT INTO `useraction` VALUES ('3231', '44', '4', '21', '2019-02-24 08:34:49');
INSERT INTO `useraction` VALUES ('3232', '43', '3', '14', '2019-02-24 08:34:50');
INSERT INTO `useraction` VALUES ('3233', '27', '9', '11', '2019-02-24 08:34:50');
INSERT INTO `useraction` VALUES ('3234', '39', '3', '21', '2019-02-24 08:34:51');
INSERT INTO `useraction` VALUES ('3235', '3', '3', '21', '2019-02-24 08:34:52');
INSERT INTO `useraction` VALUES ('3236', '36', '5', '21', '2019-02-24 08:34:53');
INSERT INTO `useraction` VALUES ('3237', '38', '1', '21', '2019-02-24 08:34:53');
INSERT INTO `useraction` VALUES ('3238', '45', '1', '1', '2019-02-24 08:34:54');
INSERT INTO `useraction` VALUES ('3239', '40', '2', '21', '2019-02-24 08:34:56');
INSERT INTO `useraction` VALUES ('3240', '2', '5', '21', '2019-02-24 08:34:58');
INSERT INTO `useraction` VALUES ('3241', '35', '1', '21', '2019-02-24 08:35:00');
INSERT INTO `useraction` VALUES ('3242', '12', '4', '21', '2019-02-24 08:35:00');
INSERT INTO `useraction` VALUES ('3243', '1', '2', '1', '2019-02-24 08:35:01');
INSERT INTO `useraction` VALUES ('3244', '47', '4', '21', '2019-02-24 08:35:02');
INSERT INTO `useraction` VALUES ('3245', '2', '67', '11', '2019-02-24 08:35:03');
INSERT INTO `useraction` VALUES ('3246', '35', '2', '24', '2019-02-24 08:35:05');
INSERT INTO `useraction` VALUES ('3247', '49', '4', '21', '2019-02-24 08:35:06');
INSERT INTO `useraction` VALUES ('3248', '38', '97', '12', '2019-02-24 08:35:08');
INSERT INTO `useraction` VALUES ('3249', '46', '80', '11', '2019-02-24 08:35:12');
INSERT INTO `useraction` VALUES ('3250', '7', '1', '12', '2019-02-24 08:35:13');
INSERT INTO `useraction` VALUES ('3251', '27', '3', '21', '2019-02-24 08:35:15');
INSERT INTO `useraction` VALUES ('3252', '24', '2', '21', '2019-02-24 08:35:16');
INSERT INTO `useraction` VALUES ('3253', '39', '79', '11', '2019-02-24 08:35:17');
INSERT INTO `useraction` VALUES ('3254', '26', '4', '22', '2019-02-24 08:35:19');
INSERT INTO `useraction` VALUES ('3255', '25', '71', '11', '2019-02-24 08:35:20');
INSERT INTO `useraction` VALUES ('3256', '5', '3', '21', '2019-02-24 08:35:21');
INSERT INTO `useraction` VALUES ('3257', '41', '29', '11', '2019-02-24 08:35:22');
INSERT INTO `useraction` VALUES ('3258', '38', '2', '21', '2019-02-24 08:35:22');
INSERT INTO `useraction` VALUES ('3259', '25', '3', '21', '2019-02-24 08:35:23');
INSERT INTO `useraction` VALUES ('3260', '35', '87', '11', '2019-02-24 08:35:24');
INSERT INTO `useraction` VALUES ('3261', '20', '71', '11', '2019-02-24 08:35:25');
INSERT INTO `useraction` VALUES ('3262', '29', '3', '4', '2019-02-24 08:35:25');
INSERT INTO `useraction` VALUES ('3263', '25', '6', '21', '2019-02-24 08:35:26');
INSERT INTO `useraction` VALUES ('3264', '15', '6', '21', '2019-02-24 08:35:26');
INSERT INTO `useraction` VALUES ('3265', '28', '71', '11', '2019-02-24 08:35:27');
INSERT INTO `useraction` VALUES ('3266', '40', '97', '11', '2019-02-24 08:35:28');
INSERT INTO `useraction` VALUES ('3267', '1', '83', '11', '2019-02-24 08:45:47');
INSERT INTO `useraction` VALUES ('3268', '1', '4', '25', '2019-02-24 08:45:50');
INSERT INTO `useraction` VALUES ('3269', '1', '4', '21', '2019-02-24 08:45:51');
INSERT INTO `useraction` VALUES ('3270', '1', '3', '14', '2019-02-24 08:45:53');
INSERT INTO `useraction` VALUES ('3271', '1', '6', '25', '2019-02-24 08:45:53');
INSERT INTO `useraction` VALUES ('3272', '1', '1', '3', '2019-02-24 08:45:54');
INSERT INTO `useraction` VALUES ('3273', '1', '1', '50', '2019-02-24 08:45:54');
INSERT INTO `useraction` VALUES ('3274', '1', '2', '25', '2019-02-24 08:45:56');
INSERT INTO `useraction` VALUES ('3275', '1', '3', '50', '2019-02-24 08:45:59');
INSERT INTO `useraction` VALUES ('3276', '1', '2', '2', '2019-02-24 08:45:59');
INSERT INTO `useraction` VALUES ('3277', '1', '3', '50', '2019-02-24 08:46:01');
INSERT INTO `useraction` VALUES ('3278', '1', '2', '24', '2019-02-24 08:46:02');
INSERT INTO `useraction` VALUES ('3279', '1', '2', '24', '2019-02-24 08:46:02');
INSERT INTO `useraction` VALUES ('3280', '1', '25', '11', '2019-02-24 08:46:03');
INSERT INTO `useraction` VALUES ('3281', '1', '33', '11', '2019-02-24 08:46:04');
INSERT INTO `useraction` VALUES ('3282', '1', '2', '2', '2019-02-24 08:46:05');
INSERT INTO `useraction` VALUES ('3283', '1', '1', '21', '2019-02-24 08:46:05');
INSERT INTO `useraction` VALUES ('3284', '1', '68', '11', '2019-02-24 08:46:07');
INSERT INTO `useraction` VALUES ('3285', '1', '4', '21', '2019-02-24 08:46:07');
INSERT INTO `useraction` VALUES ('3286', '1', '1', '24', '2019-02-24 08:46:08');
INSERT INTO `useraction` VALUES ('3287', '1', '6', '24', '2019-02-24 08:46:08');
INSERT INTO `useraction` VALUES ('3288', '1', '1', '14', '2019-02-24 08:46:11');
INSERT INTO `useraction` VALUES ('3289', '1', '24', '12', '2019-02-24 08:46:12');
INSERT INTO `useraction` VALUES ('3290', '1', '1', '21', '2019-02-24 08:46:15');
INSERT INTO `useraction` VALUES ('3291', '1', '97', '11', '2019-02-24 08:46:16');
INSERT INTO `useraction` VALUES ('3292', '1', '1', '21', '2019-02-24 08:46:17');
INSERT INTO `useraction` VALUES ('3293', '1', '5', '21', '2019-02-24 08:46:18');
INSERT INTO `useraction` VALUES ('3294', '1', '4', '2', '2019-02-24 08:46:18');
INSERT INTO `useraction` VALUES ('3295', '1', '1', '50', '2019-02-24 08:46:19');
INSERT INTO `useraction` VALUES ('3296', '1', '31', '11', '2019-02-24 08:46:21');
INSERT INTO `useraction` VALUES ('3297', '1', '2', '21', '2019-02-24 08:46:21');
INSERT INTO `useraction` VALUES ('3298', '1', '3', '23', '2019-02-24 08:46:22');
INSERT INTO `useraction` VALUES ('3299', '1', '3', '2', '2019-02-24 08:46:24');
INSERT INTO `useraction` VALUES ('3300', '1', '88', '11', '2019-02-24 08:46:25');
INSERT INTO `useraction` VALUES ('3301', '1', '3', '21', '2019-02-24 08:46:25');
INSERT INTO `useraction` VALUES ('3302', '1', '3', '1', '2019-02-24 08:46:25');
INSERT INTO `useraction` VALUES ('3303', '1', '3', '1', '2019-02-24 08:46:26');
INSERT INTO `useraction` VALUES ('3304', '1', '68', '12', '2019-02-24 08:46:27');
INSERT INTO `useraction` VALUES ('3305', '1', '2', '21', '2019-02-24 08:46:28');
INSERT INTO `useraction` VALUES ('3306', '1', '3', '4', '2019-02-24 08:46:29');
INSERT INTO `useraction` VALUES ('3307', '1', '90', '11', '2019-02-24 08:46:29');
INSERT INTO `useraction` VALUES ('3308', '1', '33', '11', '2019-02-24 08:46:31');
INSERT INTO `useraction` VALUES ('3309', '1', '1', '21', '2019-02-24 08:46:32');
INSERT INTO `useraction` VALUES ('3310', '1', '1', '4', '2019-02-24 08:46:33');
INSERT INTO `useraction` VALUES ('3311', '1', '6', '23', '2019-02-24 08:46:34');
INSERT INTO `useraction` VALUES ('3312', '1', '95', '13', '2019-02-24 08:46:34');
INSERT INTO `useraction` VALUES ('3313', '1', '3', '14', '2019-02-24 08:46:35');
INSERT INTO `useraction` VALUES ('3314', '1', '3', '25', '2019-02-24 08:46:35');
INSERT INTO `useraction` VALUES ('3315', '1', '12', '11', '2019-02-24 08:46:35');
INSERT INTO `useraction` VALUES ('3316', '1', '3', '23', '2019-02-24 08:46:36');
INSERT INTO `useraction` VALUES ('3317', '1', '36', '11', '2019-02-24 08:46:36');
INSERT INTO `useraction` VALUES ('3318', '1', '12', '12', '2019-02-24 08:46:37');
INSERT INTO `useraction` VALUES ('3319', '1', '3', '25', '2019-02-24 08:46:37');
INSERT INTO `useraction` VALUES ('3320', '1', '35', '11', '2019-02-24 08:46:39');
INSERT INTO `useraction` VALUES ('3321', '1', '1', '3', '2019-02-24 08:46:39');
INSERT INTO `useraction` VALUES ('3322', '1', '2', '23', '2019-02-24 08:46:40');
INSERT INTO `useraction` VALUES ('3323', '1', '3', '4', '2019-02-24 08:46:40');
INSERT INTO `useraction` VALUES ('3324', '1', '3', '21', '2019-02-24 08:46:41');
INSERT INTO `useraction` VALUES ('3325', '1', '1', '1', '2019-02-24 08:46:43');
INSERT INTO `useraction` VALUES ('3326', '1', '1', '2', '2019-02-24 08:46:46');
INSERT INTO `useraction` VALUES ('3327', '1', '2', '21', '2019-02-24 08:46:48');
INSERT INTO `useraction` VALUES ('3328', '1', '77', '11', '2019-02-24 08:46:50');
INSERT INTO `useraction` VALUES ('3329', '1', '2', '50', '2019-02-24 08:46:50');
INSERT INTO `useraction` VALUES ('3330', '1', '43', '11', '2019-02-24 08:46:51');
INSERT INTO `useraction` VALUES ('3331', '1', '13', '11', '2019-02-24 08:46:52');
INSERT INTO `useraction` VALUES ('3332', '1', '2', '1', '2019-02-24 08:46:53');
INSERT INTO `useraction` VALUES ('3333', '1', '6', '23', '2019-02-24 08:46:53');
INSERT INTO `useraction` VALUES ('3334', '1', '1', '50', '2019-02-24 08:46:54');
INSERT INTO `useraction` VALUES ('3335', '1', '37', '13', '2019-02-24 08:46:55');
INSERT INTO `useraction` VALUES ('3336', '1', '17', '11', '2019-02-24 08:46:56');
INSERT INTO `useraction` VALUES ('3337', '1', '4', '2', '2019-02-24 08:46:57');
INSERT INTO `useraction` VALUES ('3338', '1', '1', '50', '2019-02-24 08:46:58');
INSERT INTO `useraction` VALUES ('3339', '1', '24', '12', '2019-02-24 08:47:00');
INSERT INTO `useraction` VALUES ('3340', '1', '89', '13', '2019-02-24 08:47:01');
INSERT INTO `useraction` VALUES ('3341', '1', '6', '25', '2019-02-24 08:47:01');
INSERT INTO `useraction` VALUES ('3342', '1', '6', '24', '2019-02-24 08:47:01');
INSERT INTO `useraction` VALUES ('3343', '1', '2', '14', '2019-02-24 08:47:02');
INSERT INTO `useraction` VALUES ('3344', '1', '1', '21', '2019-02-24 08:47:03');
INSERT INTO `useraction` VALUES ('3345', '1', '3', '21', '2019-02-24 08:47:03');
INSERT INTO `useraction` VALUES ('3346', '1', '2', '25', '2019-02-24 08:47:04');
INSERT INTO `useraction` VALUES ('3347', '1', '6', '23', '2019-02-24 08:47:04');
INSERT INTO `useraction` VALUES ('3348', '1', '3', '21', '2019-02-24 08:47:05');
INSERT INTO `useraction` VALUES ('3349', '1', '6', '24', '2019-02-24 08:47:05');
INSERT INTO `useraction` VALUES ('3350', '1', '4', '3', '2019-02-24 08:47:06');
INSERT INTO `useraction` VALUES ('3351', '1', '5', '21', '2019-02-24 08:47:06');
INSERT INTO `useraction` VALUES ('3352', '1', '31', '12', '2019-02-24 08:47:07');
INSERT INTO `useraction` VALUES ('3353', '1', '67', '13', '2019-02-24 08:47:10');
INSERT INTO `useraction` VALUES ('3354', '1', '4', '21', '2019-02-24 08:47:10');
INSERT INTO `useraction` VALUES ('3355', '1', '3', '21', '2019-02-24 08:47:12');
INSERT INTO `useraction` VALUES ('3356', '1', '1', '22', '2019-02-24 08:47:14');
INSERT INTO `useraction` VALUES ('3357', '1', '4', '21', '2019-02-24 08:47:15');
INSERT INTO `useraction` VALUES ('3358', '1', '6', '21', '2019-02-24 08:47:15');
INSERT INTO `useraction` VALUES ('3359', '1', '97', '11', '2019-02-24 08:47:16');
INSERT INTO `useraction` VALUES ('3360', '1', '3', '25', '2019-02-24 08:47:17');
INSERT INTO `useraction` VALUES ('3361', '1', '4', '21', '2019-02-24 08:47:17');
INSERT INTO `useraction` VALUES ('3362', '1', '1', '4', '2019-02-24 08:47:18');
INSERT INTO `useraction` VALUES ('3363', '1', '3', '21', '2019-02-24 08:47:18');
INSERT INTO `useraction` VALUES ('3364', '1', '6', '21', '2019-02-24 08:47:19');
INSERT INTO `useraction` VALUES ('3365', '1', '4', '21', '2019-02-24 08:47:20');
INSERT INTO `useraction` VALUES ('3366', '1', '2', '3', '2019-02-24 08:47:21');
INSERT INTO `useraction` VALUES ('3367', '28', '4', '3', '2019-02-24 09:06:47');
INSERT INTO `useraction` VALUES ('3368', '49', '3', '4', '2019-02-24 09:06:48');
INSERT INTO `useraction` VALUES ('3369', '19', '2', '14', '2019-02-24 09:06:49');
INSERT INTO `useraction` VALUES ('3370', '46', '1', '24', '2019-02-24 09:06:50');
INSERT INTO `useraction` VALUES ('3371', '17', '1', '2', '2019-02-24 09:06:52');
INSERT INTO `useraction` VALUES ('3372', '9', '2', '14', '2019-02-24 09:06:53');
INSERT INTO `useraction` VALUES ('3373', '16', '171', '11', '2019-02-24 09:06:54');
INSERT INTO `useraction` VALUES ('3374', '37', '83', '11', '2019-02-24 09:06:57');
INSERT INTO `useraction` VALUES ('3375', '36', '2', '21', '2019-02-24 09:06:59');
INSERT INTO `useraction` VALUES ('3376', '49', '159', '11', '2019-02-24 09:07:01');
INSERT INTO `useraction` VALUES ('3377', '15', '3', '4', '2019-02-24 09:07:02');
INSERT INTO `useraction` VALUES ('3378', '1', '88', '12', '2019-02-24 09:07:03');
INSERT INTO `useraction` VALUES ('3379', '37', '1', '14', '2019-02-24 09:07:05');
INSERT INTO `useraction` VALUES ('3380', '30', '6', '22', '2019-02-24 09:07:06');
INSERT INTO `useraction` VALUES ('3381', '24', '3', '1', '2019-02-24 09:07:07');
INSERT INTO `useraction` VALUES ('3382', '13', '1', '3', '2019-02-24 09:07:08');
INSERT INTO `useraction` VALUES ('3383', '12', '2', '24', '2019-02-24 09:07:10');
INSERT INTO `useraction` VALUES ('3384', '19', '3', '24', '2019-02-24 09:07:12');
INSERT INTO `useraction` VALUES ('3385', '48', '2', '4', '2019-02-24 09:07:13');
INSERT INTO `useraction` VALUES ('3386', '24', '6', '21', '2019-02-24 09:07:14');
INSERT INTO `useraction` VALUES ('3387', '15', '2', '1', '2019-02-24 09:07:15');
INSERT INTO `useraction` VALUES ('3388', '5', '3', '4', '2019-02-24 09:07:18');
INSERT INTO `useraction` VALUES ('3389', '8', '127', '13', '2019-02-24 09:07:22');
INSERT INTO `useraction` VALUES ('3390', '9', '2', '14', '2019-02-24 09:07:24');
INSERT INTO `useraction` VALUES ('3391', '21', '2', '22', '2019-02-24 09:07:24');
INSERT INTO `useraction` VALUES ('3392', '14', '2', '2', '2019-02-24 09:07:27');
INSERT INTO `useraction` VALUES ('3393', '33', '2', '21', '2019-02-24 09:07:28');
INSERT INTO `useraction` VALUES ('3394', '26', '4', '4', '2019-02-24 09:07:28');
INSERT INTO `useraction` VALUES ('3395', '14', '181', '11', '2019-02-24 09:07:29');
INSERT INTO `useraction` VALUES ('3396', '46', '6', '23', '2019-02-24 09:07:30');
INSERT INTO `useraction` VALUES ('3397', '16', '2', '50', '2019-02-24 09:07:31');
INSERT INTO `useraction` VALUES ('3398', '32', '3', '1', '2019-02-24 09:07:34');
INSERT INTO `useraction` VALUES ('3399', '1', '35', '13', '2019-02-24 09:07:35');
INSERT INTO `useraction` VALUES ('3400', '41', '12', '13', '2019-02-24 09:07:36');
INSERT INTO `useraction` VALUES ('3401', '39', '2', '22', '2019-02-24 09:07:37');
INSERT INTO `useraction` VALUES ('3402', '16', '2', '3', '2019-02-24 09:07:39');
INSERT INTO `useraction` VALUES ('3403', '11', '2', '25', '2019-02-24 09:07:41');
INSERT INTO `useraction` VALUES ('3404', '6', '4', '3', '2019-02-24 09:07:42');
INSERT INTO `useraction` VALUES ('3405', '1', '1', '14', '2019-02-24 09:07:43');
INSERT INTO `useraction` VALUES ('3406', '46', '3', '25', '2019-02-24 09:07:44');
INSERT INTO `useraction` VALUES ('3407', '39', '1', '4', '2019-02-24 09:07:45');
INSERT INTO `useraction` VALUES ('3408', '10', '2', '1', '2019-02-24 09:07:46');
INSERT INTO `useraction` VALUES ('3409', '24', '4', '3', '2019-02-24 09:07:47');
INSERT INTO `useraction` VALUES ('3410', '14', '152', '11', '2019-02-24 09:07:48');
INSERT INTO `useraction` VALUES ('3411', '34', '1', '1', '2019-02-24 09:07:49');
INSERT INTO `useraction` VALUES ('3412', '1', '129', '12', '2019-02-24 09:07:50');
INSERT INTO `useraction` VALUES ('3413', '16', '3', '23', '2019-02-24 09:07:51');
INSERT INTO `useraction` VALUES ('3414', '47', '1', '3', '2019-02-24 09:07:52');
INSERT INTO `useraction` VALUES ('3415', '22', '95', '11', '2019-02-24 09:07:52');
INSERT INTO `useraction` VALUES ('3416', '13', '4', '22', '2019-02-24 09:07:54');
INSERT INTO `useraction` VALUES ('3417', '47', '4', '23', '2019-02-24 09:07:56');
INSERT INTO `useraction` VALUES ('3418', '29', '3', '50', '2019-02-24 09:07:57');
INSERT INTO `useraction` VALUES ('3419', '40', '4', '2', '2019-02-24 09:07:58');
INSERT INTO `useraction` VALUES ('3420', '30', '2', '14', '2019-02-24 09:07:59');
INSERT INTO `useraction` VALUES ('3421', '27', '5', '21', '2019-02-24 09:08:00');
INSERT INTO `useraction` VALUES ('3422', '37', '59', '12', '2019-02-24 09:08:01');
INSERT INTO `useraction` VALUES ('3423', '18', '28', '13', '2019-02-24 09:08:04');
INSERT INTO `useraction` VALUES ('3424', '17', '4', '25', '2019-02-24 09:08:05');
INSERT INTO `useraction` VALUES ('3425', '30', '2', '22', '2019-02-24 09:08:07');
INSERT INTO `useraction` VALUES ('3426', '35', '3', '2', '2019-02-24 09:08:08');
INSERT INTO `useraction` VALUES ('3427', '24', '59', '11', '2019-02-24 09:08:09');
INSERT INTO `useraction` VALUES ('3428', '37', '58', '11', '2019-02-24 09:08:10');
INSERT INTO `useraction` VALUES ('3429', '12', '4', '22', '2019-02-24 09:08:11');
INSERT INTO `useraction` VALUES ('3430', '43', '2', '3', '2019-02-24 09:08:13');
INSERT INTO `useraction` VALUES ('3431', '6', '4', '50', '2019-02-24 09:08:14');
INSERT INTO `useraction` VALUES ('3432', '22', '2', '14', '2019-02-24 09:08:15');
INSERT INTO `useraction` VALUES ('3433', '14', '1', '2', '2019-02-24 09:08:17');
INSERT INTO `useraction` VALUES ('3434', '32', '1', '22', '2019-02-24 09:08:19');
INSERT INTO `useraction` VALUES ('3435', '7', '2', '1', '2019-02-24 09:08:21');
INSERT INTO `useraction` VALUES ('3436', '16', '4', '2', '2019-02-24 09:08:22');
INSERT INTO `useraction` VALUES ('3437', '28', '29', '12', '2019-02-24 09:08:23');
INSERT INTO `useraction` VALUES ('3438', '10', '137', '11', '2019-02-24 09:08:24');
INSERT INTO `useraction` VALUES ('3439', '11', '1', '2', '2019-02-24 09:08:25');
INSERT INTO `useraction` VALUES ('3440', '20', '4', '4', '2019-02-24 09:08:27');
INSERT INTO `useraction` VALUES ('3441', '46', '1', '21', '2019-02-24 09:08:29');
INSERT INTO `useraction` VALUES ('3442', '3', '1', '14', '2019-02-24 09:08:30');
INSERT INTO `useraction` VALUES ('3443', '26', '1', '23', '2019-02-24 09:08:30');
INSERT INTO `useraction` VALUES ('3444', '45', '4', '50', '2019-02-24 09:08:31');
INSERT INTO `useraction` VALUES ('3445', '18', '1', '2', '2019-02-24 09:08:34');
INSERT INTO `useraction` VALUES ('3446', '3', '5', '22', '2019-02-24 09:08:35');
INSERT INTO `useraction` VALUES ('3447', '5', '3', '23', '2019-02-24 09:08:36');
INSERT INTO `useraction` VALUES ('3448', '34', '44', '11', '2019-02-24 09:08:37');
INSERT INTO `useraction` VALUES ('3449', '36', '4', '1', '2019-02-24 09:08:38');
INSERT INTO `useraction` VALUES ('3450', '28', '1', '2', '2019-02-24 09:08:40');
INSERT INTO `useraction` VALUES ('3451', '20', '5', '24', '2019-02-24 09:08:40');
INSERT INTO `useraction` VALUES ('3452', '24', '4', '2', '2019-02-24 09:08:41');
INSERT INTO `useraction` VALUES ('3453', '27', '113', '11', '2019-02-24 09:08:42');
INSERT INTO `useraction` VALUES ('3454', '10', '1', '23', '2019-02-24 09:08:43');
INSERT INTO `useraction` VALUES ('3455', '41', '1', '23', '2019-02-24 09:08:44');
INSERT INTO `useraction` VALUES ('3456', '6', '5', '25', '2019-02-24 09:08:45');
INSERT INTO `useraction` VALUES ('3457', '28', '3', '24', '2019-02-24 09:08:46');
INSERT INTO `useraction` VALUES ('3458', '7', '3', '4', '2019-02-24 09:08:47');
INSERT INTO `useraction` VALUES ('3459', '29', '5', '24', '2019-02-24 09:08:48');
INSERT INTO `useraction` VALUES ('3460', '25', '4', '50', '2019-02-24 09:08:49');
INSERT INTO `useraction` VALUES ('3461', '6', '3', '2', '2019-02-24 09:08:51');
INSERT INTO `useraction` VALUES ('3462', '24', '1', '2', '2019-02-24 09:08:52');
INSERT INTO `useraction` VALUES ('3463', '9', '4', '21', '2019-02-24 09:08:53');
INSERT INTO `useraction` VALUES ('3464', '33', '1', '2', '2019-02-24 09:08:54');
INSERT INTO `useraction` VALUES ('3465', '12', '32', '12', '2019-02-24 09:08:55');
INSERT INTO `useraction` VALUES ('3466', '8', '5', '21', '2019-02-24 09:08:57');
INSERT INTO `useraction` VALUES ('3467', '29', '6', '23', '2019-02-24 09:08:58');
INSERT INTO `useraction` VALUES ('3468', '22', '4', '22', '2019-02-24 09:08:59');
INSERT INTO `useraction` VALUES ('3469', '3', '3', '24', '2019-02-24 09:09:00');
INSERT INTO `useraction` VALUES ('3470', '21', '1', '4', '2019-02-24 09:09:02');
INSERT INTO `useraction` VALUES ('3471', '32', '5', '24', '2019-02-24 09:09:03');
INSERT INTO `useraction` VALUES ('3472', '37', '4', '22', '2019-02-24 09:09:04');
INSERT INTO `useraction` VALUES ('3473', '24', '1', '25', '2019-02-24 09:09:08');
INSERT INTO `useraction` VALUES ('3474', '7', '2', '14', '2019-02-24 09:09:09');
INSERT INTO `useraction` VALUES ('3475', '7', '3', '2', '2019-02-24 09:09:10');
INSERT INTO `useraction` VALUES ('3476', '49', '1', '14', '2019-02-24 09:09:11');
INSERT INTO `useraction` VALUES ('3477', '46', '3', '21', '2019-02-24 09:09:12');
INSERT INTO `useraction` VALUES ('3478', '10', '4', '24', '2019-02-24 09:09:13');
INSERT INTO `useraction` VALUES ('3479', '18', '1', '1', '2019-02-24 09:09:17');
INSERT INTO `useraction` VALUES ('3480', '10', '2', '1', '2019-02-24 09:09:18');
INSERT INTO `useraction` VALUES ('3481', '50', '9', '11', '2019-02-24 09:09:19');
INSERT INTO `useraction` VALUES ('3482', '43', '3', '3', '2019-02-24 09:09:20');
INSERT INTO `useraction` VALUES ('3483', '19', '3', '23', '2019-02-24 09:09:20');
INSERT INTO `useraction` VALUES ('3484', '23', '1', '1', '2019-02-24 09:09:21');
INSERT INTO `useraction` VALUES ('3485', '11', '1', '1', '2019-02-24 09:09:22');
INSERT INTO `useraction` VALUES ('3486', '45', '2', '25', '2019-02-24 09:09:23');
INSERT INTO `useraction` VALUES ('3487', '26', '1', '24', '2019-02-24 09:09:24');
INSERT INTO `useraction` VALUES ('3488', '33', '1', '3', '2019-02-24 09:09:25');
INSERT INTO `useraction` VALUES ('3489', '26', '3', '22', '2019-02-24 09:09:26');
INSERT INTO `useraction` VALUES ('3490', '9', '2', '14', '2019-02-24 09:09:30');
INSERT INTO `useraction` VALUES ('3491', '21', '62', '11', '2019-02-24 09:09:31');
INSERT INTO `useraction` VALUES ('3492', '26', '3', '3', '2019-02-24 09:09:33');
INSERT INTO `useraction` VALUES ('3493', '31', '24', '13', '2019-02-24 09:09:34');
INSERT INTO `useraction` VALUES ('3494', '21', '6', '22', '2019-02-24 09:09:37');
INSERT INTO `useraction` VALUES ('3495', '2', '1', '24', '2019-02-24 09:09:38');
INSERT INTO `useraction` VALUES ('3496', '48', '84', '12', '2019-02-24 09:09:40');
INSERT INTO `useraction` VALUES ('3497', '14', '6', '21', '2019-02-24 09:09:44');
INSERT INTO `useraction` VALUES ('3498', '17', '57', '13', '2019-02-24 09:09:45');
INSERT INTO `useraction` VALUES ('3499', '30', '3', '14', '2019-02-24 09:09:46');
INSERT INTO `useraction` VALUES ('3500', '30', '2', '14', '2019-02-24 09:09:50');
INSERT INTO `useraction` VALUES ('3501', '43', '74', '13', '2019-02-24 09:09:53');
INSERT INTO `useraction` VALUES ('3502', '40', '108', '11', '2019-02-24 09:09:54');
INSERT INTO `useraction` VALUES ('3503', '17', '2', '23', '2019-02-24 09:09:55');
INSERT INTO `useraction` VALUES ('3504', '46', '3', '50', '2019-02-24 09:09:56');
INSERT INTO `useraction` VALUES ('3505', '47', '4', '23', '2019-02-24 09:09:57');
INSERT INTO `useraction` VALUES ('3506', '39', '44', '12', '2019-02-24 09:09:58');
INSERT INTO `useraction` VALUES ('3507', '46', '4', '3', '2019-02-24 09:10:00');
INSERT INTO `useraction` VALUES ('3508', '38', '1', '24', '2019-02-24 09:10:01');
INSERT INTO `useraction` VALUES ('3509', '16', '6', '23', '2019-02-24 09:10:02');
INSERT INTO `useraction` VALUES ('3510', '34', '1', '4', '2019-02-24 09:10:03');
INSERT INTO `useraction` VALUES ('3511', '1', '5', '25', '2019-02-24 09:10:04');
INSERT INTO `useraction` VALUES ('3512', '28', '2', '2', '2019-02-24 09:10:05');
INSERT INTO `useraction` VALUES ('3513', '15', '65', '13', '2019-02-24 09:10:06');
INSERT INTO `useraction` VALUES ('3514', '46', '125', '12', '2019-02-24 09:10:07');
INSERT INTO `useraction` VALUES ('3515', '22', '1', '2', '2019-02-24 09:10:09');
INSERT INTO `useraction` VALUES ('3516', '32', '3', '50', '2019-02-24 09:10:10');
INSERT INTO `useraction` VALUES ('3517', '1', '3', '50', '2019-02-24 09:10:12');
INSERT INTO `useraction` VALUES ('3518', '17', '1', '2', '2019-02-24 09:10:15');
INSERT INTO `useraction` VALUES ('3519', '29', '58', '12', '2019-02-24 09:10:16');
INSERT INTO `useraction` VALUES ('3520', '28', '162', '12', '2019-02-24 09:10:19');
INSERT INTO `useraction` VALUES ('3521', '20', '1', '1', '2019-02-24 09:10:20');
INSERT INTO `useraction` VALUES ('3522', '48', '2', '1', '2019-02-24 09:10:21');
INSERT INTO `useraction` VALUES ('3523', '34', '1', '14', '2019-02-24 09:10:24');
INSERT INTO `useraction` VALUES ('3524', '6', '2', '22', '2019-02-24 09:10:25');
INSERT INTO `useraction` VALUES ('3525', '7', '25', '11', '2019-02-24 09:10:30');
INSERT INTO `useraction` VALUES ('3526', '42', '69', '11', '2019-02-24 09:10:31');
INSERT INTO `useraction` VALUES ('3527', '42', '3', '22', '2019-02-24 09:10:33');
INSERT INTO `useraction` VALUES ('3528', '49', '6', '21', '2019-02-24 09:10:36');
INSERT INTO `useraction` VALUES ('3529', '27', '4', '1', '2019-02-24 09:10:37');
INSERT INTO `useraction` VALUES ('3530', '24', '5', '23', '2019-02-24 09:10:37');
INSERT INTO `useraction` VALUES ('3531', '2', '2', '2', '2019-02-24 09:10:38');
INSERT INTO `useraction` VALUES ('3532', '5', '1', '3', '2019-02-24 09:10:39');
INSERT INTO `useraction` VALUES ('3533', '27', '1', '14', '2019-02-24 09:10:40');
INSERT INTO `useraction` VALUES ('3534', '33', '1', '25', '2019-02-24 09:10:41');
INSERT INTO `useraction` VALUES ('3535', '8', '2', '14', '2019-02-24 09:10:42');
INSERT INTO `useraction` VALUES ('3536', '13', '4', '2', '2019-02-24 09:10:43');
INSERT INTO `useraction` VALUES ('3537', '28', '1', '4', '2019-02-24 09:10:46');
INSERT INTO `useraction` VALUES ('3538', '2', '108', '11', '2019-02-24 09:10:46');
INSERT INTO `useraction` VALUES ('3539', '2', '3', '2', '2019-02-24 09:10:47');
INSERT INTO `useraction` VALUES ('3540', '43', '141', '12', '2019-02-24 09:10:48');
INSERT INTO `useraction` VALUES ('3541', '18', '2', '1', '2019-02-24 09:10:49');
INSERT INTO `useraction` VALUES ('3542', '7', '4', '21', '2019-02-24 09:10:51');
INSERT INTO `useraction` VALUES ('3543', '24', '3', '25', '2019-02-24 09:10:51');
INSERT INTO `useraction` VALUES ('3544', '30', '1', '14', '2019-02-24 09:10:52');
INSERT INTO `useraction` VALUES ('3545', '35', '2', '25', '2019-02-24 09:10:53');
INSERT INTO `useraction` VALUES ('3546', '2', '4', '2', '2019-02-24 09:10:55');
INSERT INTO `useraction` VALUES ('3547', '38', '4', '23', '2019-02-24 09:10:56');
INSERT INTO `useraction` VALUES ('3548', '23', '6', '25', '2019-02-24 09:10:57');
INSERT INTO `useraction` VALUES ('3549', '10', '2', '2', '2019-02-24 09:10:58');
INSERT INTO `useraction` VALUES ('3550', '8', '30', '11', '2019-02-24 09:10:59');
INSERT INTO `useraction` VALUES ('3551', '2', '4', '50', '2019-02-24 09:11:00');
INSERT INTO `useraction` VALUES ('3552', '14', '1', '14', '2019-02-24 09:11:01');
INSERT INTO `useraction` VALUES ('3553', '22', '1', '24', '2019-02-24 09:11:01');
INSERT INTO `useraction` VALUES ('3554', '12', '1', '2', '2019-02-24 09:11:03');
INSERT INTO `useraction` VALUES ('3555', '32', '3', '3', '2019-02-24 09:11:03');
INSERT INTO `useraction` VALUES ('3556', '7', '4', '50', '2019-02-24 09:11:04');
INSERT INTO `useraction` VALUES ('3557', '30', '2', '24', '2019-02-24 09:11:10');
INSERT INTO `useraction` VALUES ('3558', '20', '139', '13', '2019-02-24 09:11:11');
INSERT INTO `useraction` VALUES ('3559', '36', '1', '14', '2019-02-24 09:11:12');
INSERT INTO `useraction` VALUES ('3560', '42', '4', '1', '2019-02-24 09:11:13');
INSERT INTO `useraction` VALUES ('3561', '6', '3', '3', '2019-02-24 09:11:14');
INSERT INTO `useraction` VALUES ('3562', '23', '4', '21', '2019-02-24 09:11:14');
INSERT INTO `useraction` VALUES ('3563', '19', '132', '13', '2019-02-24 09:11:15');
INSERT INTO `useraction` VALUES ('3564', '50', '4', '21', '2019-02-24 09:11:17');
INSERT INTO `useraction` VALUES ('3565', '32', '5', '22', '2019-02-24 09:11:17');
INSERT INTO `useraction` VALUES ('3566', '35', '3', '23', '2019-02-24 09:11:19');
INSERT INTO `useraction` VALUES ('3567', '17', '1', '50', '2019-02-24 09:11:19');
INSERT INTO `useraction` VALUES ('3568', '32', '1', '23', '2019-02-24 09:11:22');
INSERT INTO `useraction` VALUES ('3569', '15', '3', '24', '2019-02-24 09:11:23');
INSERT INTO `useraction` VALUES ('3570', '1', '3', '24', '2019-02-24 09:11:24');
INSERT INTO `useraction` VALUES ('3571', '31', '1', '21', '2019-02-24 09:11:24');
INSERT INTO `useraction` VALUES ('3572', '4', '4', '3', '2019-02-24 09:11:26');
INSERT INTO `useraction` VALUES ('3573', '8', '3', '24', '2019-02-24 09:11:27');
INSERT INTO `useraction` VALUES ('3574', '30', '3', '2', '2019-02-24 09:11:28');
INSERT INTO `useraction` VALUES ('3575', '39', '1', '4', '2019-02-24 09:11:29');
INSERT INTO `useraction` VALUES ('3576', '46', '4', '50', '2019-02-24 09:11:30');
INSERT INTO `useraction` VALUES ('3577', '35', '1', '3', '2019-02-24 09:11:32');
INSERT INTO `useraction` VALUES ('3578', '28', '3', '21', '2019-02-24 09:11:33');
INSERT INTO `useraction` VALUES ('3579', '40', '1', '14', '2019-02-24 09:11:35');
INSERT INTO `useraction` VALUES ('3580', '28', '3', '3', '2019-02-24 09:11:36');
INSERT INTO `useraction` VALUES ('3581', '14', '3', '2', '2019-02-24 09:11:37');
INSERT INTO `useraction` VALUES ('3582', '1', '22', '13', '2019-02-24 09:11:37');
INSERT INTO `useraction` VALUES ('3583', '10', '6', '24', '2019-02-24 09:11:39');
INSERT INTO `useraction` VALUES ('3584', '4', '28', '11', '2019-02-24 09:11:40');
INSERT INTO `useraction` VALUES ('3585', '2', '3', '3', '2019-02-24 09:11:40');
INSERT INTO `useraction` VALUES ('3586', '27', '151', '13', '2019-02-24 09:11:41');
INSERT INTO `useraction` VALUES ('3587', '45', '3', '23', '2019-02-24 09:11:42');
INSERT INTO `useraction` VALUES ('3588', '40', '5', '22', '2019-02-24 09:11:43');
INSERT INTO `useraction` VALUES ('3589', '25', '4', '50', '2019-02-24 09:11:44');
INSERT INTO `useraction` VALUES ('3590', '3', '1', '14', '2019-02-24 09:11:46');
INSERT INTO `useraction` VALUES ('3591', '26', '40', '12', '2019-02-24 09:11:47');
INSERT INTO `useraction` VALUES ('3592', '4', '4', '2', '2019-02-24 09:11:48');
INSERT INTO `useraction` VALUES ('3593', '9', '70', '11', '2019-02-24 09:11:49');
INSERT INTO `useraction` VALUES ('3594', '30', '1', '24', '2019-02-24 09:11:51');
INSERT INTO `useraction` VALUES ('3595', '40', '1', '14', '2019-02-24 09:11:52');
INSERT INTO `useraction` VALUES ('3596', '22', '3', '2', '2019-02-24 09:11:54');
INSERT INTO `useraction` VALUES ('3597', '1', '3', '1', '2019-02-24 09:11:54');
INSERT INTO `useraction` VALUES ('3598', '8', '3', '4', '2019-02-24 09:11:56');
INSERT INTO `useraction` VALUES ('3599', '3', '12', '13', '2019-02-24 09:11:57');
INSERT INTO `useraction` VALUES ('3600', '14', '4', '4', '2019-02-24 09:11:58');
INSERT INTO `useraction` VALUES ('3601', '19', '4', '50', '2019-02-24 09:11:59');
INSERT INTO `useraction` VALUES ('3602', '43', '5', '24', '2019-02-24 09:12:03');
INSERT INTO `useraction` VALUES ('3603', '10', '2', '4', '2019-02-24 09:12:04');
INSERT INTO `useraction` VALUES ('3604', '20', '5', '24', '2019-02-24 09:12:05');
INSERT INTO `useraction` VALUES ('3605', '9', '5', '22', '2019-02-24 09:12:06');
INSERT INTO `useraction` VALUES ('3606', '47', '6', '25', '2019-02-24 09:12:07');
INSERT INTO `useraction` VALUES ('3607', '12', '4', '4', '2019-02-24 09:12:09');
INSERT INTO `useraction` VALUES ('3608', '49', '161', '12', '2019-02-24 09:12:10');
INSERT INTO `useraction` VALUES ('3609', '5', '1', '23', '2019-02-24 09:12:12');
INSERT INTO `useraction` VALUES ('3610', '28', '6', '23', '2019-02-24 09:12:13');
INSERT INTO `useraction` VALUES ('3611', '6', '6', '25', '2019-02-24 09:12:14');
INSERT INTO `useraction` VALUES ('3612', '42', '123', '12', '2019-02-24 09:12:15');
INSERT INTO `useraction` VALUES ('3613', '6', '2', '4', '2019-02-24 09:12:18');
INSERT INTO `useraction` VALUES ('3614', '38', '4', '4', '2019-02-24 09:12:19');
INSERT INTO `useraction` VALUES ('3615', '39', '3', '14', '2019-02-24 09:12:21');
INSERT INTO `useraction` VALUES ('3616', '22', '96', '12', '2019-02-24 09:12:22');
INSERT INTO `useraction` VALUES ('3617', '28', '2', '1', '2019-02-24 09:12:24');
INSERT INTO `useraction` VALUES ('3618', '47', '6', '23', '2019-02-24 09:12:25');
INSERT INTO `useraction` VALUES ('3619', '44', '4', '22', '2019-02-24 09:12:25');
INSERT INTO `useraction` VALUES ('3620', '42', '196', '11', '2019-02-24 09:12:27');
INSERT INTO `useraction` VALUES ('3621', '35', '125', '11', '2019-02-24 09:12:28');
INSERT INTO `useraction` VALUES ('3622', '29', '157', '11', '2019-02-24 09:12:29');
INSERT INTO `useraction` VALUES ('3623', '22', '129', '11', '2019-02-24 09:12:31');
INSERT INTO `useraction` VALUES ('3624', '44', '33', '12', '2019-02-24 09:12:32');
INSERT INTO `useraction` VALUES ('3625', '1', '164', '11', '2019-02-24 09:12:34');
INSERT INTO `useraction` VALUES ('3626', '49', '5', '25', '2019-02-24 09:12:35');
INSERT INTO `useraction` VALUES ('3627', '7', '1', '22', '2019-02-24 09:12:39');
INSERT INTO `useraction` VALUES ('3628', '26', '6', '25', '2019-02-24 09:12:42');
INSERT INTO `useraction` VALUES ('3629', '30', '170', '13', '2019-02-24 09:12:45');
INSERT INTO `useraction` VALUES ('3630', '11', '3', '22', '2019-02-24 09:12:47');
INSERT INTO `useraction` VALUES ('3631', '20', '6', '23', '2019-02-24 09:12:50');
INSERT INTO `useraction` VALUES ('3632', '3', '6', '25', '2019-02-24 09:12:51');
INSERT INTO `useraction` VALUES ('3633', '33', '1', '23', '2019-02-24 09:12:51');
INSERT INTO `useraction` VALUES ('3634', '31', '1', '24', '2019-02-24 09:12:52');
INSERT INTO `useraction` VALUES ('3635', '18', '2', '4', '2019-02-24 09:12:53');
INSERT INTO `useraction` VALUES ('3636', '28', '1', '50', '2019-02-24 09:12:54');
INSERT INTO `useraction` VALUES ('3637', '44', '2', '21', '2019-02-24 09:12:56');
INSERT INTO `useraction` VALUES ('3638', '47', '6', '24', '2019-02-24 09:12:57');
INSERT INTO `useraction` VALUES ('3639', '34', '5', '22', '2019-02-24 09:12:58');
INSERT INTO `useraction` VALUES ('3640', '30', '4', '23', '2019-02-24 09:13:00');
INSERT INTO `useraction` VALUES ('3641', '26', '1', '2', '2019-02-24 09:13:00');
INSERT INTO `useraction` VALUES ('3642', '4', '3', '3', '2019-02-24 09:13:02');
INSERT INTO `useraction` VALUES ('3643', '48', '2', '22', '2019-02-24 09:13:03');
INSERT INTO `useraction` VALUES ('3644', '7', '111', '13', '2019-02-24 09:13:04');
INSERT INTO `useraction` VALUES ('3645', '7', '4', '21', '2019-02-24 09:13:12');
INSERT INTO `useraction` VALUES ('3646', '47', '6', '22', '2019-02-24 09:13:13');
INSERT INTO `useraction` VALUES ('3647', '46', '57', '11', '2019-02-24 09:13:15');
INSERT INTO `useraction` VALUES ('3648', '7', '151', '11', '2019-02-24 09:13:15');
INSERT INTO `useraction` VALUES ('3649', '49', '6', '21', '2019-02-24 09:13:18');
INSERT INTO `useraction` VALUES ('3650', '35', '6', '22', '2019-02-24 09:13:18');
INSERT INTO `useraction` VALUES ('3651', '31', '2', '11', '2019-02-24 09:13:22');
INSERT INTO `useraction` VALUES ('3652', '7', '2', '24', '2019-02-24 09:13:23');
INSERT INTO `useraction` VALUES ('3653', '2', '49', '11', '2019-02-24 09:13:25');
INSERT INTO `useraction` VALUES ('3654', '4', '5', '21', '2019-02-24 09:13:25');
INSERT INTO `useraction` VALUES ('3655', '28', '1', '22', '2019-02-24 09:13:26');
INSERT INTO `useraction` VALUES ('3656', '15', '3', '2', '2019-02-24 09:13:28');
INSERT INTO `useraction` VALUES ('3657', '28', '1', '4', '2019-02-24 09:13:29');
INSERT INTO `useraction` VALUES ('3658', '2', '3', '23', '2019-02-24 09:13:31');
INSERT INTO `useraction` VALUES ('3659', '43', '142', '13', '2019-02-24 09:13:32');
INSERT INTO `useraction` VALUES ('3660', '3', '4', '21', '2019-02-24 09:13:33');
INSERT INTO `useraction` VALUES ('3661', '2', '1', '25', '2019-02-24 09:13:36');
INSERT INTO `useraction` VALUES ('3662', '2', '3', '14', '2019-02-24 09:13:37');
INSERT INTO `useraction` VALUES ('3663', '30', '3', '2', '2019-02-24 09:13:38');
INSERT INTO `useraction` VALUES ('3664', '20', '1', '21', '2019-02-24 09:13:39');
INSERT INTO `useraction` VALUES ('3665', '7', '186', '11', '2019-02-24 09:13:40');
INSERT INTO `useraction` VALUES ('3666', '11', '108', '13', '2019-02-24 09:13:41');
INSERT INTO `useraction` VALUES ('3667', '18', '135', '11', '2019-02-24 09:13:42');
INSERT INTO `useraction` VALUES ('3668', '24', '3', '23', '2019-02-24 09:13:43');
INSERT INTO `useraction` VALUES ('3669', '16', '3', '24', '2019-02-24 09:13:45');
INSERT INTO `useraction` VALUES ('3670', '44', '2', '23', '2019-02-24 09:13:46');
INSERT INTO `useraction` VALUES ('3671', '40', '2', '3', '2019-02-24 09:13:47');
INSERT INTO `useraction` VALUES ('3672', '40', '2', '25', '2019-02-24 09:13:48');
INSERT INTO `useraction` VALUES ('3673', '7', '2', '1', '2019-02-24 09:13:49');
INSERT INTO `useraction` VALUES ('3674', '17', '1', '50', '2019-02-24 09:13:50');
INSERT INTO `useraction` VALUES ('3675', '19', '4', '4', '2019-02-24 09:13:52');
INSERT INTO `useraction` VALUES ('3676', '34', '5', '22', '2019-02-24 09:13:55');
INSERT INTO `useraction` VALUES ('3677', '26', '4', '2', '2019-02-24 09:13:56');
INSERT INTO `useraction` VALUES ('3678', '14', '1', '1', '2019-02-24 09:13:57');
INSERT INTO `useraction` VALUES ('3679', '33', '3', '22', '2019-02-24 09:13:59');
INSERT INTO `useraction` VALUES ('3680', '37', '3', '14', '2019-02-24 09:14:00');
INSERT INTO `useraction` VALUES ('3681', '33', '6', '21', '2019-02-24 09:14:02');
INSERT INTO `useraction` VALUES ('3682', '34', '4', '2', '2019-02-24 09:14:03');
INSERT INTO `useraction` VALUES ('3683', '16', '3', '22', '2019-02-24 09:14:04');
INSERT INTO `useraction` VALUES ('3684', '3', '4', '1', '2019-02-24 09:14:06');
INSERT INTO `useraction` VALUES ('3685', '19', '3', '14', '2019-02-24 09:14:07');
INSERT INTO `useraction` VALUES ('3686', '22', '1', '1', '2019-02-24 09:14:09');
INSERT INTO `useraction` VALUES ('3687', '29', '2', '22', '2019-02-24 09:14:11');
INSERT INTO `useraction` VALUES ('3688', '25', '29', '12', '2019-02-24 09:14:13');
INSERT INTO `useraction` VALUES ('3689', '28', '4', '4', '2019-02-24 09:14:17');
INSERT INTO `useraction` VALUES ('3690', '9', '4', '23', '2019-02-24 09:14:18');
INSERT INTO `useraction` VALUES ('3691', '19', '3', '50', '2019-02-24 09:14:19');
INSERT INTO `useraction` VALUES ('3692', '48', '3', '24', '2019-02-24 09:14:20');
INSERT INTO `useraction` VALUES ('3693', '12', '3', '23', '2019-02-24 09:14:21');
INSERT INTO `useraction` VALUES ('3694', '23', '3', '1', '2019-02-24 09:14:22');
INSERT INTO `useraction` VALUES ('3695', '38', '1', '14', '2019-02-24 09:14:23');
INSERT INTO `useraction` VALUES ('3696', '45', '94', '11', '2019-02-24 09:14:25');
INSERT INTO `useraction` VALUES ('3697', '28', '37', '12', '2019-02-24 09:14:26');
INSERT INTO `useraction` VALUES ('3698', '34', '4', '25', '2019-02-24 09:14:28');
INSERT INTO `useraction` VALUES ('3699', '31', '4', '2', '2019-02-24 09:14:28');
INSERT INTO `useraction` VALUES ('3700', '44', '3', '50', '2019-02-24 09:14:30');
INSERT INTO `useraction` VALUES ('3701', '15', '2', '23', '2019-02-24 09:14:33');
INSERT INTO `useraction` VALUES ('3702', '34', '2', '4', '2019-02-24 09:14:36');
INSERT INTO `useraction` VALUES ('3703', '35', '6', '25', '2019-02-24 09:14:38');
INSERT INTO `useraction` VALUES ('3704', '46', '77', '12', '2019-02-24 09:14:41');
INSERT INTO `useraction` VALUES ('3705', '27', '4', '24', '2019-02-24 09:14:43');
INSERT INTO `useraction` VALUES ('3706', '46', '108', '11', '2019-02-24 09:14:45');
INSERT INTO `useraction` VALUES ('3707', '14', '1', '14', '2019-02-24 09:14:46');
INSERT INTO `useraction` VALUES ('3708', '46', '3', '2', '2019-02-24 09:14:47');
INSERT INTO `useraction` VALUES ('3709', '39', '5', '21', '2019-02-24 09:14:48');
INSERT INTO `useraction` VALUES ('3710', '17', '1', '25', '2019-02-24 09:14:49');
INSERT INTO `useraction` VALUES ('3711', '13', '5', '23', '2019-02-24 09:14:49');
INSERT INTO `useraction` VALUES ('3712', '5', '4', '2', '2019-02-24 09:14:50');
INSERT INTO `useraction` VALUES ('3713', '45', '4', '1', '2019-02-24 09:14:51');
INSERT INTO `useraction` VALUES ('3714', '37', '196', '11', '2019-02-24 09:14:52');
INSERT INTO `useraction` VALUES ('3715', '41', '3', '21', '2019-02-24 09:14:55');
INSERT INTO `useraction` VALUES ('3716', '41', '3', '25', '2019-02-24 09:14:56');
INSERT INTO `useraction` VALUES ('3717', '19', '3', '24', '2019-02-24 09:14:57');
INSERT INTO `useraction` VALUES ('3718', '16', '25', '11', '2019-02-24 09:14:58');
INSERT INTO `useraction` VALUES ('3719', '42', '4', '3', '2019-02-24 09:14:59');
INSERT INTO `useraction` VALUES ('3720', '8', '4', '50', '2019-02-24 09:15:00');
INSERT INTO `useraction` VALUES ('3721', '16', '1', '2', '2019-02-24 09:15:02');
INSERT INTO `useraction` VALUES ('3722', '34', '1', '2', '2019-02-24 09:15:03');
INSERT INTO `useraction` VALUES ('3723', '34', '4', '22', '2019-02-24 09:15:04');
INSERT INTO `useraction` VALUES ('3724', '6', '121', '12', '2019-02-24 09:15:06');
INSERT INTO `useraction` VALUES ('3725', '2', '4', '4', '2019-02-24 09:15:08');
INSERT INTO `useraction` VALUES ('3726', '26', '2', '25', '2019-02-24 09:15:11');
INSERT INTO `useraction` VALUES ('3727', '18', '4', '3', '2019-02-24 09:15:12');
INSERT INTO `useraction` VALUES ('3728', '43', '5', '23', '2019-02-24 09:15:13');
INSERT INTO `useraction` VALUES ('3729', '10', '70', '11', '2019-02-24 09:15:14');
INSERT INTO `useraction` VALUES ('3730', '45', '1', '21', '2019-02-24 09:15:15');
INSERT INTO `useraction` VALUES ('3731', '21', '2', '50', '2019-02-24 09:15:16');
INSERT INTO `useraction` VALUES ('3732', '14', '5', '21', '2019-02-24 09:15:17');
INSERT INTO `useraction` VALUES ('3733', '31', '17', '13', '2019-02-24 09:15:18');
INSERT INTO `useraction` VALUES ('3734', '32', '2', '2', '2019-02-24 09:15:19');
INSERT INTO `useraction` VALUES ('3735', '1', '2', '23', '2019-02-24 09:15:22');
INSERT INTO `useraction` VALUES ('3736', '25', '1', '4', '2019-02-24 09:15:23');
INSERT INTO `useraction` VALUES ('3737', '25', '3', '24', '2019-02-24 09:15:23');
INSERT INTO `useraction` VALUES ('3738', '21', '2', '3', '2019-02-24 09:15:24');
INSERT INTO `useraction` VALUES ('3739', '18', '5', '24', '2019-02-24 09:15:25');
INSERT INTO `useraction` VALUES ('3740', '27', '3', '14', '2019-02-24 09:15:26');
INSERT INTO `useraction` VALUES ('3741', '30', '4', '24', '2019-02-24 09:15:27');
INSERT INTO `useraction` VALUES ('3742', '17', '5', '23', '2019-02-24 09:15:28');
INSERT INTO `useraction` VALUES ('3743', '8', '3', '14', '2019-02-24 09:15:29');
INSERT INTO `useraction` VALUES ('3744', '38', '3', '50', '2019-02-24 09:15:31');
INSERT INTO `useraction` VALUES ('3745', '2', '2', '4', '2019-02-24 09:15:36');
INSERT INTO `useraction` VALUES ('3746', '3', '4', '22', '2019-02-24 09:15:38');
INSERT INTO `useraction` VALUES ('3747', '10', '66', '11', '2019-02-24 09:15:39');
INSERT INTO `useraction` VALUES ('3748', '21', '5', '23', '2019-02-24 09:15:42');
INSERT INTO `useraction` VALUES ('3749', '32', '4', '1', '2019-02-24 09:15:45');
INSERT INTO `useraction` VALUES ('3750', '2', '1', '21', '2019-02-24 09:15:46');
INSERT INTO `useraction` VALUES ('3751', '32', '76', '13', '2019-02-24 09:15:47');
INSERT INTO `useraction` VALUES ('3752', '39', '1', '24', '2019-02-24 09:15:50');
INSERT INTO `useraction` VALUES ('3753', '25', '1', '21', '2019-02-24 09:15:51');
INSERT INTO `useraction` VALUES ('3754', '27', '1', '22', '2019-02-24 09:15:52');
INSERT INTO `useraction` VALUES ('3755', '17', '3', '3', '2019-02-24 09:15:54');
INSERT INTO `useraction` VALUES ('3756', '3', '5', '25', '2019-02-24 09:15:55');
INSERT INTO `useraction` VALUES ('3757', '1', '6', '22', '2019-02-24 09:15:56');
INSERT INTO `useraction` VALUES ('3758', '45', '2', '3', '2019-02-24 09:15:58');
INSERT INTO `useraction` VALUES ('3759', '44', '2', '3', '2019-02-24 09:16:00');
INSERT INTO `useraction` VALUES ('3760', '37', '4', '50', '2019-02-24 09:16:01');
INSERT INTO `useraction` VALUES ('3761', '29', '18', '12', '2019-02-24 09:16:03');
INSERT INTO `useraction` VALUES ('3762', '4', '2', '3', '2019-02-24 09:16:06');
INSERT INTO `useraction` VALUES ('3763', '25', '3', '25', '2019-02-24 09:16:07');
INSERT INTO `useraction` VALUES ('3764', '21', '4', '1', '2019-02-24 09:16:08');
INSERT INTO `useraction` VALUES ('3765', '30', '2', '2', '2019-02-24 09:16:10');
INSERT INTO `useraction` VALUES ('3766', '36', '2', '4', '2019-02-24 09:16:12');
INSERT INTO `useraction` VALUES ('3767', '46', '2', '1', '2019-02-24 09:16:14');
INSERT INTO `useraction` VALUES ('3768', '42', '178', '12', '2019-02-24 09:16:15');
INSERT INTO `useraction` VALUES ('3769', '33', '3', '22', '2019-02-24 09:16:17');
INSERT INTO `useraction` VALUES ('3770', '36', '4', '2', '2019-02-24 09:16:19');
INSERT INTO `useraction` VALUES ('3771', '7', '1', '4', '2019-02-24 09:16:20');
INSERT INTO `useraction` VALUES ('3772', '42', '4', '50', '2019-02-24 09:16:21');
INSERT INTO `useraction` VALUES ('3773', '3', '4', '3', '2019-02-24 09:16:25');
INSERT INTO `useraction` VALUES ('3774', '16', '48', '13', '2019-02-24 09:16:26');
INSERT INTO `useraction` VALUES ('3775', '18', '62', '12', '2019-02-24 09:16:27');
INSERT INTO `useraction` VALUES ('3776', '14', '1', '22', '2019-02-24 09:16:29');
INSERT INTO `useraction` VALUES ('3777', '13', '2', '14', '2019-02-24 09:16:32');
INSERT INTO `useraction` VALUES ('3778', '36', '2', '2', '2019-02-24 09:16:33');
INSERT INTO `useraction` VALUES ('3779', '1', '2', '21', '2019-02-24 09:16:34');
INSERT INTO `useraction` VALUES ('3780', '20', '27', '12', '2019-02-24 09:16:35');
INSERT INTO `useraction` VALUES ('3781', '13', '2', '14', '2019-02-24 09:16:36');
INSERT INTO `useraction` VALUES ('3782', '21', '2', '50', '2019-02-24 09:16:38');
INSERT INTO `useraction` VALUES ('3783', '22', '2', '23', '2019-02-24 09:16:51');
INSERT INTO `useraction` VALUES ('3784', '18', '4', '21', '2019-02-24 09:16:53');
INSERT INTO `useraction` VALUES ('3785', '16', '5', '22', '2019-02-24 09:16:56');
INSERT INTO `useraction` VALUES ('3786', '6', '3', '1', '2019-02-24 09:16:57');
INSERT INTO `useraction` VALUES ('3787', '20', '146', '12', '2019-02-24 09:16:58');
INSERT INTO `useraction` VALUES ('3788', '4', '2', '4', '2019-02-24 09:17:01');
INSERT INTO `useraction` VALUES ('3789', '10', '6', '25', '2019-02-24 09:17:03');
INSERT INTO `useraction` VALUES ('3790', '26', '4', '24', '2019-02-24 09:17:05');
INSERT INTO `useraction` VALUES ('3791', '50', '3', '21', '2019-02-24 09:17:06');
INSERT INTO `useraction` VALUES ('3792', '12', '2', '3', '2019-02-24 09:17:07');
INSERT INTO `useraction` VALUES ('3793', '7', '2', '24', '2019-02-24 09:17:08');
INSERT INTO `useraction` VALUES ('3794', '7', '3', '21', '2019-02-24 09:17:09');
INSERT INTO `useraction` VALUES ('3795', '35', '1', '14', '2019-02-24 09:17:11');
INSERT INTO `useraction` VALUES ('3796', '48', '4', '25', '2019-02-24 09:17:12');
INSERT INTO `useraction` VALUES ('3797', '37', '3', '24', '2019-02-24 09:17:13');
INSERT INTO `useraction` VALUES ('3798', '12', '4', '4', '2019-02-24 09:17:14');
INSERT INTO `useraction` VALUES ('3799', '18', '4', '23', '2019-02-24 09:17:15');
INSERT INTO `useraction` VALUES ('3800', '36', '2', '4', '2019-02-24 09:17:15');
INSERT INTO `useraction` VALUES ('3801', '13', '1', '14', '2019-02-24 09:17:17');
INSERT INTO `useraction` VALUES ('3802', '31', '3', '25', '2019-02-24 09:17:17');
INSERT INTO `useraction` VALUES ('3803', '3', '2', '2', '2019-02-24 09:17:18');
INSERT INTO `useraction` VALUES ('3804', '27', '3', '14', '2019-02-24 09:17:19');
INSERT INTO `useraction` VALUES ('3805', '47', '39', '13', '2019-02-24 09:17:20');
INSERT INTO `useraction` VALUES ('3806', '44', '4', '4', '2019-02-24 09:17:21');
INSERT INTO `useraction` VALUES ('3807', '44', '2', '21', '2019-02-24 09:17:22');
INSERT INTO `useraction` VALUES ('3808', '30', '4', '22', '2019-02-24 09:17:23');
INSERT INTO `useraction` VALUES ('3809', '4', '5', '21', '2019-02-24 09:17:25');
INSERT INTO `useraction` VALUES ('3810', '6', '5', '22', '2019-02-24 09:17:26');
INSERT INTO `useraction` VALUES ('3811', '34', '3', '1', '2019-02-24 09:17:27');
INSERT INTO `useraction` VALUES ('3812', '46', '5', '24', '2019-02-24 09:17:28');
INSERT INTO `useraction` VALUES ('3813', '18', '3', '4', '2019-02-24 09:17:29');
INSERT INTO `useraction` VALUES ('3814', '20', '5', '25', '2019-02-24 09:17:30');
INSERT INTO `useraction` VALUES ('3815', '30', '5', '22', '2019-02-24 09:17:31');
INSERT INTO `useraction` VALUES ('3816', '20', '1', '14', '2019-02-24 09:17:33');
INSERT INTO `useraction` VALUES ('3817', '43', '2', '4', '2019-02-24 09:17:34');
INSERT INTO `useraction` VALUES ('3818', '43', '5', '24', '2019-02-24 09:17:37');
INSERT INTO `useraction` VALUES ('3819', '40', '3', '50', '2019-02-24 09:17:38');
INSERT INTO `useraction` VALUES ('3820', '35', '1', '14', '2019-02-24 09:17:40');
INSERT INTO `useraction` VALUES ('3821', '38', '6', '22', '2019-02-24 09:17:41');
INSERT INTO `useraction` VALUES ('3822', '19', '2', '50', '2019-02-24 09:17:43');
INSERT INTO `useraction` VALUES ('3823', '34', '4', '1', '2019-02-24 09:17:46');
INSERT INTO `useraction` VALUES ('3824', '9', '5', '24', '2019-02-24 09:17:47');
INSERT INTO `useraction` VALUES ('3825', '28', '4', '24', '2019-02-24 09:17:49');
INSERT INTO `useraction` VALUES ('3826', '9', '67', '11', '2019-02-24 09:17:50');
INSERT INTO `useraction` VALUES ('3827', '27', '72', '11', '2019-02-24 09:17:51');
INSERT INTO `useraction` VALUES ('3828', '12', '121', '12', '2019-02-24 09:17:54');
INSERT INTO `useraction` VALUES ('3829', '12', '4', '24', '2019-02-24 09:17:58');
INSERT INTO `useraction` VALUES ('3830', '48', '66', '12', '2019-02-24 09:17:59');
INSERT INTO `useraction` VALUES ('3831', '11', '5', '25', '2019-02-24 09:18:01');
INSERT INTO `useraction` VALUES ('3832', '35', '4', '23', '2019-02-24 09:18:04');
INSERT INTO `useraction` VALUES ('3833', '22', '2', '4', '2019-02-24 09:18:05');
INSERT INTO `useraction` VALUES ('3834', '35', '4', '4', '2019-02-24 09:18:06');
INSERT INTO `useraction` VALUES ('3835', '18', '1', '22', '2019-02-24 09:18:07');
INSERT INTO `useraction` VALUES ('3836', '16', '1', '50', '2019-02-24 09:18:12');
INSERT INTO `useraction` VALUES ('3837', '36', '2', '25', '2019-02-24 09:18:13');
INSERT INTO `useraction` VALUES ('3838', '30', '3', '14', '2019-02-24 09:18:15');
INSERT INTO `useraction` VALUES ('3839', '27', '4', '50', '2019-02-24 09:18:16');
INSERT INTO `useraction` VALUES ('3840', '35', '4', '1', '2019-02-24 09:18:19');
INSERT INTO `useraction` VALUES ('3841', '17', '1', '22', '2019-02-24 09:18:20');
INSERT INTO `useraction` VALUES ('3842', '26', '125', '12', '2019-02-24 09:18:22');
INSERT INTO `useraction` VALUES ('3843', '2', '154', '11', '2019-02-24 09:18:25');
INSERT INTO `useraction` VALUES ('3844', '4', '3', '24', '2019-02-24 09:18:25');
INSERT INTO `useraction` VALUES ('3845', '11', '4', '1', '2019-02-24 09:18:27');
INSERT INTO `useraction` VALUES ('3846', '45', '1', '2', '2019-02-24 09:18:28');
INSERT INTO `useraction` VALUES ('3847', '49', '37', '12', '2019-02-24 09:18:30');
INSERT INTO `useraction` VALUES ('3848', '30', '4', '25', '2019-02-24 09:18:34');
INSERT INTO `useraction` VALUES ('3849', '41', '2', '14', '2019-02-24 09:18:35');
INSERT INTO `useraction` VALUES ('3850', '31', '6', '24', '2019-02-24 09:18:36');
INSERT INTO `useraction` VALUES ('3851', '34', '1', '14', '2019-02-24 09:18:37');
INSERT INTO `useraction` VALUES ('3852', '12', '2', '3', '2019-02-24 09:18:38');
INSERT INTO `useraction` VALUES ('3853', '41', '47', '13', '2019-02-24 09:18:39');
INSERT INTO `useraction` VALUES ('3854', '19', '4', '50', '2019-02-24 09:18:40');
INSERT INTO `useraction` VALUES ('3855', '30', '2', '22', '2019-02-24 09:18:42');
INSERT INTO `useraction` VALUES ('3856', '11', '3', '14', '2019-02-24 09:18:44');
INSERT INTO `useraction` VALUES ('3857', '4', '6', '21', '2019-02-24 09:18:45');
INSERT INTO `useraction` VALUES ('3858', '45', '4', '1', '2019-02-24 09:18:46');
INSERT INTO `useraction` VALUES ('3859', '21', '3', '25', '2019-02-24 09:18:48');
INSERT INTO `useraction` VALUES ('3860', '32', '4', '25', '2019-02-24 09:18:49');
INSERT INTO `useraction` VALUES ('3861', '38', '2', '25', '2019-02-24 09:18:52');
INSERT INTO `useraction` VALUES ('3862', '39', '169', '13', '2019-02-24 09:18:52');
INSERT INTO `useraction` VALUES ('3863', '4', '2', '14', '2019-02-24 09:18:53');
INSERT INTO `useraction` VALUES ('3864', '48', '2', '3', '2019-02-24 09:18:54');
INSERT INTO `useraction` VALUES ('3865', '38', '1', '3', '2019-02-24 09:18:55');
INSERT INTO `useraction` VALUES ('3866', '47', '145', '13', '2019-02-24 09:18:56');
INSERT INTO `useraction` VALUES ('3867', '44', '3', '1', '2019-02-24 09:18:57');
INSERT INTO `useraction` VALUES ('3868', '14', '1', '21', '2019-02-24 09:18:59');
INSERT INTO `useraction` VALUES ('3869', '20', '2', '2', '2019-02-24 09:19:00');
INSERT INTO `useraction` VALUES ('3870', '12', '4', '2', '2019-02-24 09:19:01');
INSERT INTO `useraction` VALUES ('3871', '6', '3', '14', '2019-02-24 09:19:02');
INSERT INTO `useraction` VALUES ('3872', '17', '2', '50', '2019-02-24 09:19:06');
INSERT INTO `useraction` VALUES ('3873', '2', '1', '23', '2019-02-24 09:19:07');
INSERT INTO `useraction` VALUES ('3874', '11', '1', '3', '2019-02-24 09:19:09');
INSERT INTO `useraction` VALUES ('3875', '44', '3', '24', '2019-02-24 09:19:10');
INSERT INTO `useraction` VALUES ('3876', '45', '6', '25', '2019-02-24 09:19:11');
INSERT INTO `useraction` VALUES ('3877', '35', '6', '21', '2019-02-24 09:19:12');
INSERT INTO `useraction` VALUES ('3878', '22', '1', '50', '2019-02-24 09:19:14');
INSERT INTO `useraction` VALUES ('3879', '30', '4', '3', '2019-02-24 09:19:17');
INSERT INTO `useraction` VALUES ('3880', '46', '3', '21', '2019-02-24 09:19:18');
INSERT INTO `useraction` VALUES ('3881', '17', '4', '2', '2019-02-24 09:19:19');
INSERT INTO `useraction` VALUES ('3882', '25', '2', '4', '2019-02-24 09:19:20');
INSERT INTO `useraction` VALUES ('3883', '18', '5', '23', '2019-02-24 09:19:22');
INSERT INTO `useraction` VALUES ('3884', '45', '18', '12', '2019-02-24 09:19:24');
INSERT INTO `useraction` VALUES ('3885', '27', '2', '50', '2019-02-24 09:19:29');
INSERT INTO `useraction` VALUES ('3886', '49', '2', '3', '2019-02-24 09:19:30');
INSERT INTO `useraction` VALUES ('3887', '13', '1', '23', '2019-02-24 09:19:31');
INSERT INTO `useraction` VALUES ('3888', '14', '80', '13', '2019-02-24 09:19:32');
INSERT INTO `useraction` VALUES ('3889', '11', '2', '50', '2019-02-24 09:19:34');
INSERT INTO `useraction` VALUES ('3890', '24', '2', '21', '2019-02-24 09:19:35');
INSERT INTO `useraction` VALUES ('3891', '34', '4', '24', '2019-02-24 09:19:37');
INSERT INTO `useraction` VALUES ('3892', '34', '92', '13', '2019-02-24 09:19:38');
INSERT INTO `useraction` VALUES ('3893', '22', '120', '12', '2019-02-24 09:19:39');
INSERT INTO `useraction` VALUES ('3894', '16', '1', '14', '2019-02-24 09:19:41');
INSERT INTO `useraction` VALUES ('3895', '5', '2', '2', '2019-02-24 09:19:45');
INSERT INTO `useraction` VALUES ('3896', '48', '67', '13', '2019-02-24 09:19:46');
INSERT INTO `useraction` VALUES ('3897', '48', '1', '4', '2019-02-24 09:19:47');
INSERT INTO `useraction` VALUES ('3898', '38', '6', '23', '2019-02-24 09:19:48');
INSERT INTO `useraction` VALUES ('3899', '35', '1', '25', '2019-02-24 09:19:50');
INSERT INTO `useraction` VALUES ('3900', '37', '72', '12', '2019-02-24 09:19:51');
INSERT INTO `useraction` VALUES ('3901', '45', '125', '13', '2019-02-24 09:19:53');
INSERT INTO `useraction` VALUES ('3902', '9', '2', '24', '2019-02-24 09:19:55');
INSERT INTO `useraction` VALUES ('3903', '20', '1', '14', '2019-02-24 09:19:56');
INSERT INTO `useraction` VALUES ('3904', '42', '94', '13', '2019-02-24 09:19:56');
INSERT INTO `useraction` VALUES ('3905', '50', '1', '3', '2019-02-24 09:19:58');
INSERT INTO `useraction` VALUES ('3906', '37', '1', '2', '2019-02-24 09:19:59');
INSERT INTO `useraction` VALUES ('3907', '19', '61', '12', '2019-02-24 09:20:04');
INSERT INTO `useraction` VALUES ('3908', '10', '6', '22', '2019-02-24 09:20:05');
INSERT INTO `useraction` VALUES ('3909', '9', '1', '3', '2019-02-24 09:20:07');
INSERT INTO `useraction` VALUES ('3910', '40', '3', '2', '2019-02-24 09:20:08');
INSERT INTO `useraction` VALUES ('3911', '25', '2', '2', '2019-02-24 09:20:09');
INSERT INTO `useraction` VALUES ('3912', '45', '118', '12', '2019-02-24 09:20:12');
INSERT INTO `useraction` VALUES ('3913', '1', '4', '22', '2019-02-24 09:20:14');
INSERT INTO `useraction` VALUES ('3914', '12', '5', '25', '2019-02-24 09:20:16');
INSERT INTO `useraction` VALUES ('3915', '2', '2', '50', '2019-02-24 09:20:17');
INSERT INTO `useraction` VALUES ('3916', '10', '2', '14', '2019-02-24 09:20:19');
INSERT INTO `useraction` VALUES ('3917', '7', '3', '14', '2019-02-24 09:20:20');
INSERT INTO `useraction` VALUES ('3918', '42', '162', '11', '2019-02-24 09:20:21');
INSERT INTO `useraction` VALUES ('3919', '43', '1', '24', '2019-02-24 09:20:22');
INSERT INTO `useraction` VALUES ('3920', '45', '125', '11', '2019-02-24 09:20:23');
INSERT INTO `useraction` VALUES ('3921', '40', '2', '4', '2019-02-24 09:20:24');
INSERT INTO `useraction` VALUES ('3922', '15', '5', '25', '2019-02-24 09:20:25');
INSERT INTO `useraction` VALUES ('3923', '47', '3', '25', '2019-02-24 09:20:27');
INSERT INTO `useraction` VALUES ('3924', '22', '3', '14', '2019-02-24 09:20:28');
INSERT INTO `useraction` VALUES ('3925', '50', '48', '11', '2019-02-24 09:20:29');
INSERT INTO `useraction` VALUES ('3926', '15', '3', '24', '2019-02-24 09:20:30');
INSERT INTO `useraction` VALUES ('3927', '19', '152', '12', '2019-02-24 09:20:31');
INSERT INTO `useraction` VALUES ('3928', '40', '79', '13', '2019-02-24 09:20:33');
INSERT INTO `useraction` VALUES ('3929', '38', '4', '25', '2019-02-24 09:20:35');
INSERT INTO `useraction` VALUES ('3930', '45', '4', '23', '2019-02-24 09:20:39');
INSERT INTO `useraction` VALUES ('3931', '10', '2', '1', '2019-02-24 09:20:42');
INSERT INTO `useraction` VALUES ('3932', '6', '3', '14', '2019-02-24 09:20:43');
INSERT INTO `useraction` VALUES ('3933', '31', '2', '50', '2019-02-24 09:20:44');
INSERT INTO `useraction` VALUES ('3934', '9', '6', '24', '2019-02-24 09:20:46');
INSERT INTO `useraction` VALUES ('3935', '7', '61', '11', '2019-02-24 09:20:49');
INSERT INTO `useraction` VALUES ('3936', '23', '1', '14', '2019-02-24 09:20:50');
INSERT INTO `useraction` VALUES ('3937', '39', '1', '50', '2019-02-24 09:20:50');
INSERT INTO `useraction` VALUES ('3938', '17', '3', '50', '2019-02-24 09:20:52');
INSERT INTO `useraction` VALUES ('3939', '27', '5', '21', '2019-02-24 09:20:55');
INSERT INTO `useraction` VALUES ('3940', '37', '6', '24', '2019-02-24 09:20:56');
INSERT INTO `useraction` VALUES ('3941', '6', '6', '23', '2019-02-24 09:20:58');
INSERT INTO `useraction` VALUES ('3942', '49', '4', '22', '2019-02-24 09:20:59');
INSERT INTO `useraction` VALUES ('3943', '46', '1', '3', '2019-02-24 09:21:00');
INSERT INTO `useraction` VALUES ('3944', '42', '4', '21', '2019-02-24 09:21:02');
INSERT INTO `useraction` VALUES ('3945', '5', '5', '23', '2019-02-24 09:21:03');
INSERT INTO `useraction` VALUES ('3946', '44', '4', '4', '2019-02-24 09:21:06');
INSERT INTO `useraction` VALUES ('3947', '33', '4', '21', '2019-02-24 09:21:07');
INSERT INTO `useraction` VALUES ('3948', '8', '5', '25', '2019-02-24 09:21:08');
INSERT INTO `useraction` VALUES ('3949', '48', '45', '12', '2019-02-24 09:21:10');
INSERT INTO `useraction` VALUES ('3950', '45', '1', '2', '2019-02-24 09:21:12');
INSERT INTO `useraction` VALUES ('3951', '26', '3', '4', '2019-02-24 09:21:13');
INSERT INTO `useraction` VALUES ('3952', '6', '4', '23', '2019-02-24 09:21:15');
INSERT INTO `useraction` VALUES ('3953', '38', '3', '1', '2019-02-24 09:21:17');
INSERT INTO `useraction` VALUES ('3954', '13', '3', '3', '2019-02-24 09:21:17');
INSERT INTO `useraction` VALUES ('3955', '1', '3', '3', '2019-02-24 09:21:18');
INSERT INTO `useraction` VALUES ('3956', '1', '175', '11', '2019-02-24 09:21:21');
INSERT INTO `useraction` VALUES ('3957', '32', '1', '14', '2019-02-24 09:21:23');
INSERT INTO `useraction` VALUES ('3958', '19', '5', '21', '2019-02-24 09:21:26');
INSERT INTO `useraction` VALUES ('3959', '36', '5', '21', '2019-02-24 09:21:27');
INSERT INTO `useraction` VALUES ('3960', '20', '4', '23', '2019-02-24 09:21:28');
INSERT INTO `useraction` VALUES ('3961', '40', '1', '21', '2019-02-24 09:21:29');
INSERT INTO `useraction` VALUES ('3962', '42', '6', '24', '2019-02-24 09:21:30');
INSERT INTO `useraction` VALUES ('3963', '29', '2', '14', '2019-02-24 09:21:31');
INSERT INTO `useraction` VALUES ('3964', '3', '2', '1', '2019-02-24 09:21:32');
INSERT INTO `useraction` VALUES ('3965', '35', '3', '1', '2019-02-24 09:21:33');
INSERT INTO `useraction` VALUES ('3966', '24', '1', '2', '2019-02-24 09:21:34');
INSERT INTO `useraction` VALUES ('3967', '5', '5', '22', '2019-02-24 09:21:35');
INSERT INTO `useraction` VALUES ('3968', '38', '2', '24', '2019-02-24 09:21:38');
INSERT INTO `useraction` VALUES ('3969', '4', '126', '12', '2019-02-24 09:21:40');
INSERT INTO `useraction` VALUES ('3970', '15', '185', '11', '2019-02-24 09:21:42');
INSERT INTO `useraction` VALUES ('3971', '32', '4', '23', '2019-02-24 09:21:44');
INSERT INTO `useraction` VALUES ('3972', '49', '4', '1', '2019-02-24 09:21:45');
INSERT INTO `useraction` VALUES ('3973', '35', '53', '12', '2019-02-24 09:21:46');
INSERT INTO `useraction` VALUES ('3974', '25', '4', '21', '2019-02-24 09:21:49');
INSERT INTO `useraction` VALUES ('3975', '39', '55', '13', '2019-02-24 09:21:51');
INSERT INTO `useraction` VALUES ('3976', '28', '4', '23', '2019-02-24 09:21:52');
INSERT INTO `useraction` VALUES ('3977', '30', '5', '25', '2019-02-24 09:21:53');
INSERT INTO `useraction` VALUES ('3978', '27', '4', '21', '2019-02-24 09:21:55');
INSERT INTO `useraction` VALUES ('3979', '2', '4', '1', '2019-02-24 09:21:55');
INSERT INTO `useraction` VALUES ('3980', '3', '4', '1', '2019-02-24 09:21:57');
INSERT INTO `useraction` VALUES ('3981', '11', '4', '2', '2019-02-24 09:21:58');
INSERT INTO `useraction` VALUES ('3982', '43', '4', '2', '2019-02-24 09:21:59');
INSERT INTO `useraction` VALUES ('3983', '50', '95', '11', '2019-02-24 09:22:00');
INSERT INTO `useraction` VALUES ('3984', '6', '4', '24', '2019-02-24 09:22:01');
INSERT INTO `useraction` VALUES ('3985', '30', '2', '25', '2019-02-24 09:22:02');
INSERT INTO `useraction` VALUES ('3986', '26', '20', '13', '2019-02-24 09:22:04');
INSERT INTO `useraction` VALUES ('3987', '1', '4', '3', '2019-02-24 09:22:05');
INSERT INTO `useraction` VALUES ('3988', '30', '2', '4', '2019-02-24 09:22:06');
INSERT INTO `useraction` VALUES ('3989', '26', '4', '23', '2019-02-24 09:22:07');
INSERT INTO `useraction` VALUES ('3990', '37', '3', '14', '2019-02-24 09:22:09');
INSERT INTO `useraction` VALUES ('3991', '34', '3', '1', '2019-02-24 09:22:10');
INSERT INTO `useraction` VALUES ('3992', '5', '2', '14', '2019-02-24 09:22:11');
INSERT INTO `useraction` VALUES ('3993', '10', '3', '22', '2019-02-24 09:22:12');
INSERT INTO `useraction` VALUES ('3994', '31', '1', '25', '2019-02-24 09:22:13');
INSERT INTO `useraction` VALUES ('3995', '11', '4', '50', '2019-02-24 09:22:15');
INSERT INTO `useraction` VALUES ('3996', '40', '5', '22', '2019-02-24 09:22:16');
INSERT INTO `useraction` VALUES ('3997', '13', '93', '11', '2019-02-24 09:22:20');
INSERT INTO `useraction` VALUES ('3998', '41', '2', '14', '2019-02-24 09:22:22');
INSERT INTO `useraction` VALUES ('3999', '46', '3', '23', '2019-02-24 09:22:23');
INSERT INTO `useraction` VALUES ('4000', '40', '4', '3', '2019-02-24 09:22:24');
INSERT INTO `useraction` VALUES ('4001', '41', '6', '22', '2019-02-24 09:22:25');
INSERT INTO `useraction` VALUES ('4002', '34', '4', '24', '2019-02-24 09:22:26');
INSERT INTO `useraction` VALUES ('4003', '34', '1', '21', '2019-02-24 09:22:27');
INSERT INTO `useraction` VALUES ('4004', '42', '1', '50', '2019-02-24 09:22:28');
INSERT INTO `useraction` VALUES ('4005', '15', '2', '2', '2019-02-24 09:22:31');
INSERT INTO `useraction` VALUES ('4006', '10', '4', '1', '2019-02-24 09:22:34');
INSERT INTO `useraction` VALUES ('4007', '39', '177', '12', '2019-02-24 09:22:36');
INSERT INTO `useraction` VALUES ('4008', '43', '4', '50', '2019-02-24 09:22:39');
INSERT INTO `useraction` VALUES ('4009', '42', '3', '22', '2019-02-24 09:22:41');
INSERT INTO `useraction` VALUES ('4010', '7', '2', '22', '2019-02-24 09:22:43');
INSERT INTO `useraction` VALUES ('4011', '33', '5', '22', '2019-02-24 09:22:45');
INSERT INTO `useraction` VALUES ('4012', '40', '3', '3', '2019-02-24 09:22:46');
INSERT INTO `useraction` VALUES ('4013', '43', '5', '24', '2019-02-24 09:22:47');
INSERT INTO `useraction` VALUES ('4014', '28', '1', '4', '2019-02-24 09:22:48');
INSERT INTO `useraction` VALUES ('4015', '48', '6', '21', '2019-02-24 09:22:49');
INSERT INTO `useraction` VALUES ('4016', '17', '3', '3', '2019-02-24 09:22:50');
INSERT INTO `useraction` VALUES ('4017', '34', '1', '3', '2019-02-24 09:22:50');
INSERT INTO `useraction` VALUES ('4018', '14', '2', '50', '2019-02-24 09:22:52');
INSERT INTO `useraction` VALUES ('4019', '9', '4', '23', '2019-02-24 09:22:53');
INSERT INTO `useraction` VALUES ('4020', '49', '137', '13', '2019-02-24 09:22:54');
INSERT INTO `useraction` VALUES ('4021', '39', '1', '22', '2019-02-24 09:22:55');
INSERT INTO `useraction` VALUES ('4022', '12', '2', '50', '2019-02-24 09:22:57');
INSERT INTO `useraction` VALUES ('4023', '24', '135', '12', '2019-02-24 09:22:58');
INSERT INTO `useraction` VALUES ('4024', '13', '3', '24', '2019-02-24 09:23:00');
INSERT INTO `useraction` VALUES ('4025', '8', '4', '21', '2019-02-24 09:23:01');
INSERT INTO `useraction` VALUES ('4026', '32', '1', '21', '2019-02-24 09:23:02');
INSERT INTO `useraction` VALUES ('4027', '24', '3', '21', '2019-02-24 09:23:03');
INSERT INTO `useraction` VALUES ('4028', '35', '189', '11', '2019-02-24 09:23:05');
INSERT INTO `useraction` VALUES ('4029', '18', '102', '11', '2019-02-24 09:23:07');
INSERT INTO `useraction` VALUES ('4030', '46', '76', '13', '2019-02-24 09:23:09');
INSERT INTO `useraction` VALUES ('4031', '41', '1', '14', '2019-02-24 09:23:10');
INSERT INTO `useraction` VALUES ('4032', '5', '1', '25', '2019-02-24 09:23:11');
INSERT INTO `useraction` VALUES ('4033', '26', '2', '21', '2019-02-24 09:23:15');
INSERT INTO `useraction` VALUES ('4034', '34', '1', '22', '2019-02-24 09:23:17');
INSERT INTO `useraction` VALUES ('4035', '16', '1', '14', '2019-02-24 09:23:19');
INSERT INTO `useraction` VALUES ('4036', '6', '4', '3', '2019-02-24 09:23:21');
INSERT INTO `useraction` VALUES ('4037', '23', '4', '22', '2019-02-24 09:23:22');
INSERT INTO `useraction` VALUES ('4038', '6', '1', '4', '2019-02-24 09:23:24');
INSERT INTO `useraction` VALUES ('4039', '6', '4', '25', '2019-02-24 09:23:25');
INSERT INTO `useraction` VALUES ('4040', '42', '1', '2', '2019-02-24 09:23:26');
INSERT INTO `useraction` VALUES ('4041', '40', '1', '1', '2019-02-24 09:23:27');
INSERT INTO `useraction` VALUES ('4042', '4', '3', '1', '2019-02-24 09:23:28');
INSERT INTO `useraction` VALUES ('4043', '38', '2', '21', '2019-02-24 09:23:29');
INSERT INTO `useraction` VALUES ('4044', '28', '1', '14', '2019-02-24 09:23:29');
INSERT INTO `useraction` VALUES ('4045', '18', '1', '2', '2019-02-24 09:23:31');
INSERT INTO `useraction` VALUES ('4046', '24', '2', '4', '2019-02-24 09:23:32');
INSERT INTO `useraction` VALUES ('4047', '25', '2', '1', '2019-02-24 09:23:33');
INSERT INTO `useraction` VALUES ('4048', '31', '1', '25', '2019-02-24 09:23:34');
INSERT INTO `useraction` VALUES ('4049', '3', '2', '24', '2019-02-24 09:23:36');
INSERT INTO `useraction` VALUES ('4050', '28', '4', '25', '2019-02-24 09:23:36');
INSERT INTO `useraction` VALUES ('4051', '7', '3', '1', '2019-02-24 09:23:37');
INSERT INTO `useraction` VALUES ('4052', '3', '2', '2', '2019-02-24 09:23:38');
INSERT INTO `useraction` VALUES ('4053', '37', '147', '12', '2019-02-24 09:23:39');
INSERT INTO `useraction` VALUES ('4054', '3', '97', '11', '2019-02-24 23:24:30');
INSERT INTO `useraction` VALUES ('4055', '3', '97', '12', '2019-02-24 23:24:34');
INSERT INTO `useraction` VALUES ('4056', '3', '129', '11', '2019-02-24 23:30:18');
INSERT INTO `useraction` VALUES ('4057', '3', '95', '11', '2019-02-24 23:30:43');
INSERT INTO `useraction` VALUES ('4058', '3', '95', '12', '2019-02-24 23:30:45');
INSERT INTO `useraction` VALUES ('4059', '1', '60', '12', '2019-02-25 01:53:05');
INSERT INTO `useraction` VALUES ('4060', '1', '60', '11', '2019-02-25 05:24:55');
INSERT INTO `useraction` VALUES ('4061', '1', '60', '11', '2019-02-26 05:10:24');

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
  `usergroup` int(11) NOT NULL DEFAULT '1' COMMENT '用户组',
  `exp` bigint(20) NOT NULL DEFAULT '0' COMMENT '积分/等级',
  `token` varchar(45) NOT NULL DEFAULT '',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `phonenumber` varchar(45) DEFAULT NULL COMMENT '电话号码',
  `address` varchar(256) DEFAULT NULL COMMENT '地址',
  `description` text,
  `state` int(2) NOT NULL DEFAULT '1',
  `gender` varchar(1) NOT NULL DEFAULT '',
  `number` varchar(45) NOT NULL DEFAULT '',
  `real_name` varchar(20) NOT NULL DEFAULT '',
  `nationality` varchar(20) NOT NULL DEFAULT '',
  `account_balance` int(255) NOT NULL DEFAULT '0' COMMENT '账户余额',
  `specialitst_license` varchar(255) NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `front_pic` text,
  `back_pic` text,
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户表';

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'zhangyu199946@126.com', '拉拉人', 'ec847003d2eadc9baf60853e8391e167a292c21f01892fcb8bad0f4af6cd74a7', 'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1549078352&di=0e4e5ee31b005f20859bdb1a0f4ebf58&src=http://s2.sinaimg.cn/mw690/005LKisygy722sIQw2B41&690', '0', '199998', 'jKayeSGDf4gx5QphIcl1zv3V2', null, null, null, '弗兰秀秀牛逼', '2', '', '', '德玛西亚', '', '999', '', '2019-02-27 01:14:31', '2019-02-27 01:14:31', null, null);
INSERT INTO `users` VALUES ('2', 'yyz@126.com', '袁宜照', '317f16f4833885da6766e81b35c7258fe4451798600a1ad980babb9e9f412fc2', 'https://cdn.vuetifyjs.com/images/lists/1.jpg', '0', '0', 'TNp6hR7ElkJK4Z5Xfte0VyqG3', null, null, null, '任豚', '0', '', '', '啦啦啦', '', '0', '', '2019-02-26 05:48:59', '2019-02-26 05:48:59', null, null);
INSERT INTO `users` VALUES ('3', 'zyxiaohao@126.com', '张煜', 'cb8f260c5b29ec2a17d662133ebcf99cd4594e29b0ffeb54599ffe5f3801c3ed', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551080425826&di=0e3f4387e6a7cfc397faa585b70ff696&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F428c9a3fd327d1bcea115ac8a2a701b2564d47bb19a16-vaw5K8_fw658', '0', '199999', 'cnYNsfILdwPAzjtFT1gQhiHuX', null, null, null, '软狗', '2', '', '', '光头', '', '0', '', '2019-02-26 06:33:58', '2019-02-26 06:33:58', null, null);
INSERT INTO `users` VALUES ('4', 'user1@user1.com', 'API', '599e60bc4121595f91c6a775e0154e75244f755e51bebbfa8cf66a9f25746f24', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551783191&di=c1413003edea3720657bacf28678bf4a&imgtype=jpg&er=1&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Fface%2F81a4c5b742e8142175f8f71a4fcf95d08b307976.jpg', '2', '0', '2223', null, null, '德莉莎', '索尼天下第一', '2', '二', '没有', '傻缺', '和', '0', '', '2019-02-26 06:34:00', '2019-02-26 06:34:00', '/static/identity_card/4_front.jpg', '/static/identity_card/4_back.jpg');
INSERT INTO `users` VALUES ('5', 'user2@user1.com', '海王星', '1deb094bf4c7f0553293603f3a0efb369b087ec9983c1b459517011c90e52305', 'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1356556468,3620436078&fm=26&gp=0.jpg', '2', '0', '1', null, null, '', '太阳系行星', '2', '', '', '', '', '0', '', '2019-02-26 06:34:02', '2019-02-26 06:34:02', '/static/identity_card/5_front.jpg', '/static/identity_card/5_back.jpg');
INSERT INTO `users` VALUES ('6', 'user3@user1.com', '天王星', 'b98ebb15f80a708f355c1112d670c2392b26c2a6be69b0c5197eceaea09b0b2d', 'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1083497808,3244706846&fm=26&gp=0.jpg', '1', '0', '', null, null, '日内二', '太阳系行星', '2', '女', '002022020', '呼啦啦啦', '和', '0', '', '2019-02-26 06:11:38', '2019-02-26 06:11:38', null, null);
INSERT INTO `users` VALUES ('7', 'user4@user1.com', '冥王星', 'a6c5766422cff52dd8dd3998d36dea4ebd881c9778383a0cdd4ee3c3aeda9dba', 'http://p4.music.126.net/7rVK4tnPsCz2xtGot7bLhA==/7729566743982785.jpg?param=180y180', '3', '0', '', null, null, '', '太阳系小行星', '1', '', '', '', '', '0', '', '2019-02-26 06:34:07', '2019-02-26 06:34:07', null, null);
INSERT INTO `users` VALUES ('8', 'user5@user1.com', 'wh', 'ba64da7a2dcf7fb416e94fbe6baa90a1c30b8d920750eba2f86b6545fe63df69', 'https://www.asgardusk.com/images/none.png', '1', '0', '', null, null, '', '', '1', '', '', '', '', '0', '', '2019-02-26 07:12:15', '2019-02-26 07:12:15', null, null);
INSERT INTO `users` VALUES ('9', 'user6@user1.com', '用户6', '5aa5290b481b19e12888d7ac0e5a30dbd8146b87f5162c1455b2a7d8e6710d03', null, '1', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 18:39:27', '2019-02-02 18:39:27', null, null);
INSERT INTO `users` VALUES ('10', 'user7@user1.com', '用户7', 'aa44de99891cb179b3f46785aff02751d28d333f85b04b278858c6834819487d', null, '1', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 18:39:28', '2019-02-02 18:39:28', null, null);
INSERT INTO `users` VALUES ('11', 'user8@user1.com', '用户8', '0b5288355eebc89ca2bfc46c90339dda6a0f3ce4128b4c9e15090c25a9c2f5fe', null, '1', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 18:39:29', '2019-02-02 18:39:29', null, null);
INSERT INTO `users` VALUES ('12', 'user9@user1.com', '用户9', '41eea4cac48e52661ed0328a2e6f47f877146dc12597dd72133ce4c6afb1ba5e', null, '1', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 18:39:30', '2019-02-02 18:39:30', null, null);
INSERT INTO `users` VALUES ('13', 'user10@user1.com', '用户10', '382e1656c9c69a7adf041f52f16f1b43256a070ab24bece0e5455ef76935b216', null, '1', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 18:39:31', '2019-02-02 18:39:31', null, null);
INSERT INTO `users` VALUES ('14', 'ban1@ban1.com', '封禁账户1', 'dea695d9c9da21db93bf86d05774b3866807df5ac187142d71ba5e2da48e3b98', null, '4', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 18:44:39', '2019-02-02 18:44:39', null, null);
INSERT INTO `users` VALUES ('15', 'ban2@ban1.com', '封禁账户2', 'b2a4d7a43e26c71e62a6dc6d585cf19029896ca35b2de2f212bd1572f28b1603', null, '4', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 18:44:45', '2019-02-02 18:44:45', null, null);
INSERT INTO `users` VALUES ('16', 'ban3@ban1.com', '封禁账户3', '7c0aa756166b96ee6eafb773fc85a1f86b75ce3ee203386888a5bf747de1c07e', null, '4', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 18:44:50', '2019-02-02 18:44:50', null, null);
INSERT INTO `users` VALUES ('17', 'exp1@exp1.com', '专家1', '60c12cd0e12d466232d362730bc1cdc19962a796e6c2a699956707706082c380', null, '2', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:11:39', '2019-02-02 19:11:39', null, null);
INSERT INTO `users` VALUES ('18', 'exp2@exp1.com', '专家2', 'bccb210bbefdafdf3ee67959db70a7ae3f93e7dcc666289000917d432dffdaac', null, '2', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:11:42', '2019-02-02 19:11:42', null, null);
INSERT INTO `users` VALUES ('19', 'exp3@exp1.com', '专家3', '36bf74d7c2fa7ff3c6293f49130c6c8b9a1f9afc764f82d185fda271f478cfc1', null, '2', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:11:47', '2019-02-02 19:11:47', null, null);
INSERT INTO `users` VALUES ('20', 'exp4@exp1.com', '专家4', '4a25e59f2c9682d39089fcfc3ad94ff54a92b0c6e71a8e2ba9ec87f45fe68274', null, '2', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:11:53', '2019-02-02 19:11:53', null, null);
INSERT INTO `users` VALUES ('21', 'exp5@exp1.com', '专家5', '72fdde7c00b5a1125aa3530635a477a12e3cbf162a45d536755162672743e6de', null, '5', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:11:58', '2019-02-02 19:11:58', null, null);
INSERT INTO `users` VALUES ('22', 'exp6@exp1.com', '专家6', '22a222e334d73ecb10cf87920fe18fd2c6f084069f0b38828e3cdf097e335b84', null, '5', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:12:05', '2019-02-02 19:12:05', null, null);
INSERT INTO `users` VALUES ('23', 'exp7@exp1.com', '专家7', 'd2771ab82602cf02c2b6ce82375a55328a2535400bc280cf9e0fa3657b58781e', null, '5', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:12:09', '2019-02-02 19:12:09', null, null);
INSERT INTO `users` VALUES ('24', 'com1@com1.com', '用户 \'s\' \'e\' \'t\' \'o\' \'x\' \'f\' \'k\' \'b\' \'w\' \'j\'', '26aa9d860feebfa628cbd59b0e30d0d6562542b0c26414549ba555340c73ab7a', null, '3', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:26:10', '2019-02-02 19:26:10', null, null);
INSERT INTO `users` VALUES ('25', 'com2@com1.com', '用户 0qz947vpau', '1f8112d3e2f439f746176dea19db4ad616122829316183fc29d25722654400ae', null, '3', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:26:12', '2019-02-02 19:26:12', null, null);
INSERT INTO `users` VALUES ('26', 'com3@com1.com', '用户 gusjt78zfn', 'ff26e0b1616d84dc64eebd048b12a76e92498a41c19323695611dec2fa55a7cd', null, '3', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:26:14', '2019-02-02 19:26:14', null, null);
INSERT INTO `users` VALUES ('27', 'com4@com1.com', '用户 cjeu5tq427', '1a7c6535bcdbe5820194b39c0eeae738e3aa7c549dd62b6c15e33d592abee55d', null, '3', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:26:16', '2019-02-02 19:26:16', null, null);
INSERT INTO `users` VALUES ('28', 'com5@com1.com', '用户 yg7m8rhwz1', '3aad5c958caa869dcaa2402edf2fe71b7f286d79903bb77eb6d14b40e16d6a0d', null, '6', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:26:17', '2019-02-02 19:26:17', null, null);
INSERT INTO `users` VALUES ('29', 'com6@com1.com', '用户 8wei1lspy9', '9e0e546f766d888da7c46848989f56c62e60aa45dd81019c1bbaed114252754d', null, '6', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:26:18', '2019-02-02 19:26:18', null, null);
INSERT INTO `users` VALUES ('30', 'com7@com1.com', '用户 io69u3s5lc', 'e95aba424cce4a1fe53902c62ca0fa0ecf09b8c7112cde86a94f089790a68502', null, '6', '0', '', null, null, null, '', '0', '', '', '', '', '0', '', '2019-02-02 19:26:20', '2019-02-02 19:26:20', null, null);
INSERT INTO `users` VALUES ('51', 'user0@fake.com', '用户 u35dxag4c9', '60c89bafbb2b191b9d6b390c45d8018d48556b70782be106b7e41a01cf80be22', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:23', '2019-02-24 08:13:23', null, null);
INSERT INTO `users` VALUES ('52', 'user1@fake.com', '用户 qwabye1m9f', '599e60bc4121595f91c6a775e0154e75244f755e51bebbfa8cf66a9f25746f24', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:29', '2019-02-24 08:13:29', null, null);
INSERT INTO `users` VALUES ('53', 'user2@fake.com', '用户 a1tkupc02i', '1deb094bf4c7f0553293603f3a0efb369b087ec9983c1b459517011c90e52305', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:33', '2019-02-24 08:13:33', null, null);
INSERT INTO `users` VALUES ('54', 'user3@fake.com', '用户 jtq013nrai', 'b98ebb15f80a708f355c1112d670c2392b26c2a6be69b0c5197eceaea09b0b2d', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:34', '2019-02-24 08:13:34', null, null);
INSERT INTO `users` VALUES ('55', 'user4@fake.com', '用户 tdn3q4orfl', 'a6c5766422cff52dd8dd3998d36dea4ebd881c9778383a0cdd4ee3c3aeda9dba', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:35', '2019-02-24 08:13:35', null, null);
INSERT INTO `users` VALUES ('56', 'user5@fake.com', '用户 3hka96pi2c', 'ba64da7a2dcf7fb416e94fbe6baa90a1c30b8d920750eba2f86b6545fe63df69', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:36', '2019-02-24 08:13:36', null, null);
INSERT INTO `users` VALUES ('57', 'user6@fake.com', '用户 foptv35dri', '5aa5290b481b19e12888d7ac0e5a30dbd8146b87f5162c1455b2a7d8e6710d03', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:37', '2019-02-24 08:13:37', null, null);
INSERT INTO `users` VALUES ('58', 'user7@fake.com', '用户 kjpr5eaubi', 'aa44de99891cb179b3f46785aff02751d28d333f85b04b278858c6834819487d', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:38', '2019-02-24 08:13:38', null, null);
INSERT INTO `users` VALUES ('59', 'user8@fake.com', '用户 f1aj97uglw', '0b5288355eebc89ca2bfc46c90339dda6a0f3ce4128b4c9e15090c25a9c2f5fe', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:40', '2019-02-24 08:13:40', null, null);
INSERT INTO `users` VALUES ('60', 'user9@fake.com', '用户 h9nmba5plg', '41eea4cac48e52661ed0328a2e6f47f877146dc12597dd72133ce4c6afb1ba5e', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:45', '2019-02-24 08:13:45', null, null);
INSERT INTO `users` VALUES ('61', 'user10@fake.com', '用户 2hc8qbx3fl', '382e1656c9c69a7adf041f52f16f1b43256a070ab24bece0e5455ef76935b216', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:47', '2019-02-24 08:13:47', null, null);
INSERT INTO `users` VALUES ('62', 'user11@fake.com', '用户 mon62ai5wx', '0dad63ba055b199190e070161c557c6493e8e82bdbd948d60867427fe969a007', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:48', '2019-02-24 08:13:48', null, null);
INSERT INTO `users` VALUES ('63', 'user12@fake.com', '用户 qdhrzt19c6', '42748d78dc6f8dffe2bb0d6084bf479e945efbf215d65910edb0a6811b5741ed', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:49', '2019-02-24 08:13:49', null, null);
INSERT INTO `users` VALUES ('64', 'user13@fake.com', '用户 tgf8y10ohr', 'b4c6e127e4a03bf402f82c941174a559789b5a5dbbf98e077ada10182bd328c0', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:50', '2019-02-24 08:13:50', null, null);
INSERT INTO `users` VALUES ('65', 'user14@fake.com', '用户 k4rx5lcevp', '6b2ff66b44d2c37db0e105606c37215a7d19f0460d400536d7ba7667be9b99f0', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:13:52', '2019-02-24 08:13:52', null, null);
INSERT INTO `users` VALUES ('66', 'user15@fake.com', '用户 tjcd2npaws', 'b9b79888a89bcdaf0cad336cb008e240edfb30452bbbea945737b690e6d9c8d0', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:14:03', '2019-02-24 08:14:03', null, null);
INSERT INTO `users` VALUES ('67', 'user16@fake.com', '用户 bpygwtldk9', 'a68ae4397b6dad3cc59a15f5508b601ad3377dc4c046b15e7e79088946abbe56', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:14:05', '2019-02-24 08:14:05', null, null);
INSERT INTO `users` VALUES ('68', 'user17@fake.com', '用户 yd64v2wer5', '0365e6d9d5ebb0e2750ff191d23ac87e22d006038bc7fd90ff0abec2b38d2fd1', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:14:06', '2019-02-24 08:14:06', null, null);
INSERT INTO `users` VALUES ('69', 'user18@fake.com', '用户 sfe71j8gna', '6bfba93deb3c9e9c09bae61e9742f3a3833bfb3bf3764923e0e6a18981a2a293', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:14:09', '2019-02-24 08:14:09', null, null);
INSERT INTO `users` VALUES ('70', 'user19@fake.com', '用户 5n2c79rqgt', '64878d87733c073d117e641a685249d5d842c35cc03862064aac9eb44435e232', null, '1', '0', '', null, null, null, null, '1', '', '', '', '', '0', '', '2019-02-24 08:14:10', '2019-02-24 08:14:10', null, null);

-- ----------------------------
-- View structure for `a_at_info`
-- ----------------------------
DROP VIEW IF EXISTS `a_at_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `a_at_info` AS select `users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`answers`.`answerID` AS `answerID`,`answers`.`edittime` AS `edittime`,`answers`.`content` AS `content`,`answers`.`userID` AS `userID` from (`users` join `answers`) where (`users`.`userID` = `answers`.`userID`) ;

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
-- View structure for `chat_box`
-- ----------------------------
DROP VIEW IF EXISTS `chat_box`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `chat_box` AS select `messages`.`messageID` AS `messageID`,`messages`.`content` AS `content`,`messages`.`poster` AS `poster`,`messages`.`receiver` AS `receiver`,`messages`.`type` AS `type`,`poster`.`headportrait` AS `poster_headportrait`,`poster`.`usergroup` AS `poster_usergroup`,`poster`.`nickname` AS `poster_nickname`,`poster`.`exp` AS `poster_exp`,`receiver`.`nickname` AS `receiver_nickname`,`receiver`.`headportrait` AS `receiver_headportrait`,`receiver`.`usergroup` AS `receiver_usergroup`,`receiver`.`exp` AS `receiver_exp`,`messages`.`post_time` AS `post_time` from ((`messages` join `users` `poster`) join `users` `receiver`) where ((`messages`.`poster` = `poster`.`userID`) and (`messages`.`receiver` = `receiver`.`userID`)) order by `messages`.`post_time` desc ;

-- ----------------------------
-- View structure for `collect_answer_info`
-- ----------------------------
DROP VIEW IF EXISTS `collect_answer_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `collect_answer_info` AS select `collectanswer`.`idCollectAnswer` AS `idCollectAnswer`,`collectanswer`.`userID` AS `userID`,`collectanswer`.`answerID` AS `answerID`,`answers`.`edittime` AS `edittime`,`answers`.`content` AS `content`,`answers`.`agree` AS `agree`,`answers`.`disagree` AS `disagree`,`answers`.`answertype` AS `answertype`,`answers`.`questionID` AS `questionID`,`answers`.`tags` AS `tags`,`answers`.`state` AS `state`,`questions`.`title` AS `title` from ((`collectanswer` join `answers`) join `questions`) where ((`collectanswer`.`answerID` = `answers`.`answerID`) and (`answers`.`questionID` = `questions`.`questionID`)) ;

-- ----------------------------
-- View structure for `collect_article_info`
-- ----------------------------
DROP VIEW IF EXISTS `collect_article_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `collect_article_info` AS select `collectarticle`.`idCollectArticle` AS `idCollectArticle`,`collectarticle`.`userID` AS `userID`,`collectarticle`.`articleID` AS `articleID`,`article`.`content` AS `content`,`article`.`title` AS `title`,`article`.`edittime` AS `edittime`,`article`.`tags` AS `tags`,`article`.`state` AS `state`,`article`.`free` AS `free` from (`collectarticle` join `article`) where (`collectarticle`.`articleID` = `article`.`articleID`) ;

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
-- View structure for `followquestion_info`
-- ----------------------------
DROP VIEW IF EXISTS `followquestion_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `followquestion_info` AS select `followtopic`.`idFollowTopic` AS `idFollowTopic`,`followtopic`.`userID` AS `userID`,`followtopic`.`target` AS `target`,`questions`.`title` AS `title`,`questions`.`description` AS `description`,`questions`.`edittime` AS `edittime`,`questions`.`tags` AS `tags`,`questions`.`state` AS `state`,`questions`.`question_type` AS `question_type`,`questions`.`price` AS `price`,`questions`.`allowed_user` AS `allowed_user` from (`followtopic` join `questions`) where (`followtopic`.`target` = `questions`.`questionID`) ;

-- ----------------------------
-- View structure for `group_members_info`
-- ----------------------------
DROP VIEW IF EXISTS `group_members_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `group_members_info` AS select `group_members`.`id` AS `id`,`group_members`.`groupID` AS `groupID`,`group_members`.`userID` AS `userID`,`group_members`.`state` AS `state`,`group_members`.`silent` AS `silent`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`groups`.`name` AS `name`,`groups`.`description` AS `description`,`groups`.`head_portrait` AS `head_portrait`,`groups`.`state` AS `group_state` from ((`group_members` join `users`) join `groups`) where ((`group_members`.`groupID` = `groups`.`groupID`) and (`users`.`userID` = `group_members`.`userID`)) ;

-- ----------------------------
-- View structure for `group_message_info`
-- ----------------------------
DROP VIEW IF EXISTS `group_message_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `group_message_info` AS select `group_message`.`id` AS `id`,`group_message`.`content` AS `content`,`group_message`.`userID` AS `userID`,`group_message`.`groupID` AS `groupID`,`group_message`.`type` AS `type`,`group_message`.`time` AS `time`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp` from (`group_message` join `users`) where (`group_message`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `orderinfo`
-- ----------------------------
DROP VIEW IF EXISTS `orderinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `orderinfo` AS select `orders`.`orderID` AS `orderID`,`orders`.`userID` AS `userID`,`orders`.`target` AS `target`,`orders`.`start_time` AS `start_time`,`orders`.`content` AS `content`,`orders`.`end_time` AS `end_time`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`users`.`description` AS `description`,`orders`.`state` AS `state` from (`users` join `orders`) where (`users`.`userID` = `orders`.`userID`) ;

-- ----------------------------
-- View structure for `q_at_info`
-- ----------------------------
DROP VIEW IF EXISTS `q_at_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `q_at_info` AS select `questions`.`questionID` AS `questionID`,`questions`.`title` AS `title`,`questions`.`description` AS `description`,`questions`.`userID` AS `userID`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`questions`.`edittime` AS `edittime` from (`questions` join `users`) where (`questions`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `qc_at_info`
-- ----------------------------
DROP VIEW IF EXISTS `qc_at_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `qc_at_info` AS select `questioncomments`.`userID` AS `userID`,`questioncomments`.`qcommentID` AS `qcommentID`,`questioncomments`.`content` AS `content`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`questioncomments`.`createtime` AS `createtime` from (`questioncomments` join `users`) where (`questioncomments`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `question_comments_info`
-- ----------------------------
DROP VIEW IF EXISTS `question_comments_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `question_comments_info` AS select `questioncomments`.`qcommentID` AS `qcommentID`,`questioncomments`.`userID` AS `userID`,`questioncomments`.`content` AS `content`,`questioncomments`.`agree` AS `agree`,`questioncomments`.`createtime` AS `createtime`,`questioncomments`.`questionID` AS `questionID`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp` from (`questioncomments` join `users`) where (`questioncomments`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `questionsinfo`
-- ----------------------------
DROP VIEW IF EXISTS `questionsinfo`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `questionsinfo` AS select `questions`.`questionID` AS `questionID`,`questions`.`title` AS `title`,`questions`.`description` AS `description`,`questions`.`edittime` AS `edittime`,`questions`.`userID` AS `userID`,`questions`.`tags` AS `tags`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`questions`.`state` AS `state` from (`questions` join `users`) where (`questions`.`userID` = `users`.`userID`) ;

-- ----------------------------
-- View structure for `signed_demand_info`
-- ----------------------------
DROP VIEW IF EXISTS `signed_demand_info`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `signed_demand_info` AS select `sign_demand`.`signID` AS `signID`,`sign_demand`.`userID` AS `userID`,`sign_demand`.`target` AS `target`,`sign_demand`.`state` AS `state`,`users`.`nickname` AS `nickname`,`users`.`headportrait` AS `headportrait`,`users`.`usergroup` AS `usergroup`,`users`.`exp` AS `exp`,`users`.`description` AS `description` from (`sign_demand` join `users`) where (`sign_demand`.`userID` = `users`.`userID`) ;
