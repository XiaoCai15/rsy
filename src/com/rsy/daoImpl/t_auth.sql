/*
 Navicat Premium Data Transfer

 Source Server         : 任书怡的
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : egov

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 09/08/2021 11:39:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_auth
-- ----------------------------
DROP TABLE IF EXISTS `t_auth`;
CREATE TABLE `t_auth`  (
  `orgcode` varchar(32) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `remark` varchar(128) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `contactman` varchar(32) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `contacttel` varchar(32) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `filename` varchar(32) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `fileremark` varchar(128) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NULL DEFAULT NULL,
  `authno` int(0) NOT NULL AUTO_INCREMENT,
  `usercode` varchar(32) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL,
  `feedback` char(1) CHARACTER SET utf8 COLLATE utf8_vietnamese_ci NOT NULL COMMENT '0-未反馈，1 - 已反馈',
  PRIMARY KEY (`authno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_vietnamese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_auth
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
