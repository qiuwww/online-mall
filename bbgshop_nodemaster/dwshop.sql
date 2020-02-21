/*
 Navicat MySQL Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : localhost:3306
 Source Schema         : dwshop

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 21/02/2020 17:06:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bbgshop_ad
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_ad`;
CREATE TABLE `bbgshop_ad` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `ad_position_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `media_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `link` varchar(255) NOT NULL DEFAULT '',
  `image_url` text NOT NULL,
  `content` varchar(255) NOT NULL DEFAULT '',
  `end_time` int(11) NOT NULL DEFAULT '0',
  `enabled` tinyint(3) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `position_id` (`ad_position_id`),
  KEY `enabled` (`enabled`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_ad
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_ad` VALUES (174, 1, 1, '售后指南 (指定页面) ', '/pages/ucenter/AftersaleGuide/AftersaleGuide', 'http://resource.bbgshop.com/Fp2YGSTKuVR-Rq5hgXZ2Z86dQ1aT', '哈哈哈', 0, 1);
INSERT INTO `bbgshop_ad` VALUES (175, 1, 1, '轻奢首饰 (一级分类) ', '/pages/category/category?id=1036030', 'http://resource.bbgshop.com/FmeLmWLzWZsMV3LaabncbSVFR5ls', 'zanwu', 0, 1);
INSERT INTO `bbgshop_ad` VALUES (176, 1, 1, '砍价页面 (指定页面) ', '/pages/Resagin_bargain/Resagin_bargain', 'http://resource.bbgshop.com/FgP6H7EOwKfKx3scwIQG0DomJmL4', '哈哈哈', 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_ad_position
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_ad_position`;
CREATE TABLE `bbgshop_ad_position` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `width` smallint(5) unsigned NOT NULL DEFAULT '0',
  `height` smallint(5) unsigned NOT NULL DEFAULT '0',
  `desc` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_address
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_address`;
CREATE TABLE `bbgshop_address` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `country_id` smallint(5) NOT NULL DEFAULT '0',
  `province_id` smallint(5) NOT NULL DEFAULT '0',
  `city_id` smallint(5) NOT NULL DEFAULT '0',
  `district_id` smallint(5) NOT NULL DEFAULT '0',
  `address` varchar(120) NOT NULL DEFAULT '',
  `mobile` varchar(60) NOT NULL DEFAULT '',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_address
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_address` VALUES (146, '123123', 42, 0, 3, 38, 422, '123123', '15358975705', 0);
INSERT INTO `bbgshop_address` VALUES (145, '123123', 42, 0, 3, 38, 423, '123123', '15358975705', 0);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_admin
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_admin`;
CREATE TABLE `bbgshop_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(10) NOT NULL DEFAULT '''''',
  `password` varchar(255) NOT NULL DEFAULT '''''',
  `password_salt` varchar(255) NOT NULL DEFAULT '''''',
  `last_login_ip` varchar(60) NOT NULL DEFAULT '''''',
  `last_login_time` int(11) NOT NULL DEFAULT '0',
  `add_time` int(11) NOT NULL DEFAULT '0',
  `update_time` int(11) NOT NULL DEFAULT '0',
  `avatar` varchar(255) NOT NULL DEFAULT '''''',
  `admin_role_id` int(11) NOT NULL DEFAULT '0',
  `change_pwd_time` varchar(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_admin
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_admin` VALUES (1, 'admin', 'a23a5a25ae4b97495d83f035eda7b412', 'BEIBAO', '::ffff:127.0.0.1', 1534317441, 0, 0, '\'\'', 0, '5');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_attribute
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_attribute`;
CREATE TABLE `bbgshop_attribute` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(60) NOT NULL DEFAULT '',
  `input_type` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `values` text NOT NULL,
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`attribute_category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_attribute_category
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_attribute_category`;
CREATE TABLE `bbgshop_attribute_category` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(60) NOT NULL DEFAULT '',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_attribute_category
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_attribute_category` VALUES (1008002, '布艺软装', 1);
INSERT INTO `bbgshop_attribute_category` VALUES (1008008, '被枕', 1);
INSERT INTO `bbgshop_attribute_category` VALUES (1008009, '床品件套', 1);
INSERT INTO `bbgshop_attribute_category` VALUES (1008016, '灯具', 1);
INSERT INTO `bbgshop_attribute_category` VALUES (1011004, '家饰', 1);
INSERT INTO `bbgshop_attribute_category` VALUES (1015000, '家具', 1);
INSERT INTO `bbgshop_attribute_category` VALUES (1017000, '宠物', 1);
INSERT INTO `bbgshop_attribute_category` VALUES (1036000, '夏凉', 1);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_bank_card
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_bank_card`;
CREATE TABLE `bbgshop_bank_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_code` varchar(64) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_nickname` varchar(256) NOT NULL DEFAULT '0',
  `card_bank_name` varchar(32) NOT NULL DEFAULT '0',
  `card_bank_code` varchar(32) NOT NULL DEFAULT '0',
  `user_true_name` varchar(64) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_bargain
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_bargain`;
CREATE TABLE `bbgshop_bargain` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '砍价id、',
  `goodsid` bigint(32) NOT NULL COMMENT '商品id',
  `goods_name` varchar(256) NOT NULL DEFAULT '' COMMENT '商品名称',
  `lowest_price` varchar(11) NOT NULL DEFAULT '0' COMMENT '底价',
  `retail_price` varchar(11) NOT NULL DEFAULT '0' COMMENT '商品原价',
  `most_init_num` int(8) NOT NULL DEFAULT '0' COMMENT '最多发起次数',
  `least_cut_num` int(8) NOT NULL DEFAULT '0' COMMENT '至少砍价人数',
  `only_cut_num` int(3) NOT NULL DEFAULT '0' COMMENT '单用户可砍价次数',
  `activity_rule` varchar(512) NOT NULL COMMENT '活动规则',
  `activity_detail` text NOT NULL COMMENT '活动详情页',
  `participate_num` int(8) NOT NULL DEFAULT '0' COMMENT '已参与人数',
  `launched_num` int(8) NOT NULL DEFAULT '0' COMMENT '已发起人数',
  `purchased_num` int(8) NOT NULL DEFAULT '0' COMMENT '已购买的人数',
  `is_abled` int(1) NOT NULL DEFAULT '0' COMMENT '是否启用',
  `create_time` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `start_time` varchar(32) DEFAULT NULL COMMENT '允许开始时间',
  `end_time` varchar(32) DEFAULT NULL COMMENT '允许结束时间',
  `user_duration_time` varchar(32) DEFAULT NULL COMMENT '允许用户砍价持续时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_bargain
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_bargain` VALUES (42, 1530752944419263, '测试添测试添测试添测试添测\n试添测试添', '0', '9.99', 200, 2, 1, '', '<p><strong><em><s><u>测试添加商品测试添加商品测试添加商品</u></s></em></strong></p>', 1, 1, 0, 0, '1533956411832', '1533916800000', '1534003200000', '7200000');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_bargain_user
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_bargain_user`;
CREATE TABLE `bbgshop_bargain_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id',
  `bargain_id` int(11) NOT NULL DEFAULT '0' COMMENT '砍价id',
  `iscut` int(2) NOT NULL DEFAULT '0' COMMENT '0为未砍到底价，1为已砍到底价但未领取，2为订单已生成，3为已付款,4为已超时',
  `goods_id` bigint(32) NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_sn` varchar(32) NOT NULL DEFAULT '0',
  `product_id` varchar(11) NOT NULL DEFAULT '0',
  `goods_spec_ids` varchar(11) NOT NULL DEFAULT '0',
  `goods_name` varchar(256) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_rel_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品原价',
  `goods_lowest_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品底价',
  `created_time` varchar(32) NOT NULL DEFAULT '0' COMMENT '用户创建时间',
  `duration_time` varchar(32) NOT NULL DEFAULT '0' COMMENT '限制时间',
  `end_time` varchar(32) NOT NULL DEFAULT '0' COMMENT '结束时间',
  `most_init_num` int(8) NOT NULL DEFAULT '0' COMMENT '最多发起次数',
  `least_cut_num` int(8) NOT NULL DEFAULT '0' COMMENT '至少砍价人数',
  `only_cut_num` int(8) NOT NULL DEFAULT '0' COMMENT '单用户允许砍价次数',
  `goods_sku_id` varchar(16) NOT NULL DEFAULT '0' COMMENT '选择的skuid',
  `goods_sku_value` varchar(32) NOT NULL DEFAULT '0' COMMENT '选择的sku名称',
  `goods_pic` varchar(128) NOT NULL DEFAULT '0' COMMENT '商品图片',
  `have_cut_num` int(11) NOT NULL DEFAULT '0',
  `have_cut_price` varchar(11) NOT NULL DEFAULT '0',
  `have_cut_lest` varchar(11) NOT NULL DEFAULT '0',
  `order_sn` varchar(32) NOT NULL DEFAULT '0',
  `is_outtime` int(2) NOT NULL DEFAULT '0' COMMENT '超时',
  `is_success` int(2) NOT NULL DEFAULT '0',
  `success_time` varchar(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_bargain_user
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_bargain_user` VALUES (273, 42, 42, 0, 1530752944419263, 'T15307529444192634', '728', '563_564_566', '测试添测试添测试添测试添测\n试添测试添', 576.00, 0.00, '1533957219431', '7200000', '1533964419431', 200, 2, 1, '728', '1.1KG/1.1M/绿色', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 1, '94.46', '481.54', '0', 1, 0, '0');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_bargain_user_friend
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_bargain_user_friend`;
CREATE TABLE `bbgshop_bargain_user_friend` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bargain_user_table_id` int(11) NOT NULL DEFAULT '0',
  `bargain_main_table_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `goods_sku_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品的skuid',
  `friend_nick_name` varchar(32) NOT NULL DEFAULT '0' COMMENT '帮助用户的昵称',
  `friend_avatar` varchar(256) NOT NULL DEFAULT '0' COMMENT '帮助用户的头像',
  `goods_id` bigint(32) NOT NULL DEFAULT '0' COMMENT '商品id',
  `goods_name` varchar(256) NOT NULL DEFAULT '' COMMENT '商品名称',
  `goods_rel_price` varchar(11) NOT NULL DEFAULT '0' COMMENT '商品原价',
  `cut_price` varchar(11) NOT NULL DEFAULT '0' COMMENT '用户砍掉的价格',
  `surplus_price` varchar(11) NOT NULL DEFAULT '0' COMMENT '剩余的价格',
  `goods_lowest_price` varchar(11) NOT NULL DEFAULT '0' COMMENT '商品底价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1263 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_bargain_user_friend
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_bargain_user_friend` VALUES (1262, 273, 42, 42, 0, '余生与诗 ', 'https://wx.qlogo.cn/mmopen/vi_32/h9YpuwGibvfD8dBC1UbicjPRxNYObn1oa2sdzbUqdOIf0ggibibvO5OjWtah73gTKlOZiaMe3ZuM5lib1AVS3gy5XibPQ/132', 1530752944419263, '测试添测试添测试添测试添测\n试添测试添', '576', '94.46', '481.54', '0');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_brand
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_brand`;
CREATE TABLE `bbgshop_brand` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `list_pic_url` varchar(255) NOT NULL DEFAULT '',
  `simple_desc` varchar(255) NOT NULL DEFAULT '',
  `pic_url` varchar(255) NOT NULL DEFAULT '',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '50',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `floor_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `app_list_pic_url` varchar(255) NOT NULL DEFAULT '',
  `is_new` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `new_pic_url` varchar(255) NOT NULL DEFAULT '',
  `new_sort_order` tinyint(2) unsigned NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `is_show` (`is_show`)
) ENGINE=MyISAM AUTO_INCREMENT=1046012 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_brand
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_brand` VALUES (1001000, 'MUJI制造商', 'http://yanxuan.nosdn.127.net/1541445967645114dd75f6b0edc4762d.png', '严选精选了MUJI制造商和生产原料，\n用几乎零利润的价格，剔除品牌溢价，\n让用户享受原品牌的品质生活。', 'http://yanxuan.nosdn.127.net/4ea3f1e60dd77c45c218e503d721a1ed.jpg', 2, 1, 12.90, 'http://yanxuan.nosdn.127.net/1541445967645114dd75f6b0edc4762d.png', 1, 'http://yanxuan.nosdn.127.net/4ea3f1e60dd77c45c218e503d721a1ed.jpg', 2);
INSERT INTO `bbgshop_brand` VALUES (1001002, '内野制造商', 'http://yanxuan.nosdn.127.net/8ca3ce091504f8aa1fba3fdbb7a6e351.png', '严选从世界各地挑选毛巾，最终选择了为日本内野代工的工厂，追求毛巾的柔软度与功能性。品质比肩商场几百元的毛巾。', 'http://yanxuan.nosdn.127.net/e50654982984206b54e9226e5ab7f90c.jpg', 10, 1, 29.00, 'http://yanxuan.nosdn.127.net/8ca3ce091504f8aa1fba3fdbb7a6e351.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001003, 'Adidas制造商', 'http://yanxuan.nosdn.127.net/335334d0deaff6dc3376334822ab3a2f.png', '严选找到为Adidas等品牌制造商，\n选取优质原材料，与厂方一起设计，\n为你提供好的理想的运动装备。', 'http://yanxuan.nosdn.127.net/6f954ea8cee30e161dda048ffbfd950f.png', 30, 1, 49.00, 'http://yanxuan.nosdn.127.net/335334d0deaff6dc3376334822ab3a2f.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001007, '优衣库制造商', 'http://yanxuan.nosdn.127.net/0d72832e37e7e3ea391b519abbbc95a3.png', '严选找到日本知名服装UNIQLO的制造商，\n选取优质长绒棉和精梳工艺，\n与厂方一起设计，为你提供理想的棉袜。', 'http://yanxuan.nosdn.127.net/f3d196c03f8aac5625faba00d670ee03.jpg', 12, 1, 29.00, 'http://yanxuan.nosdn.127.net/0d72832e37e7e3ea391b519abbbc95a3.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001008, '膳魔师制造商', 'http://yanxuan.nosdn.127.net/5fd51e29b9459dae7df8040c8219f241.png', '严选深入保温行业内部，\n找到德国膳魔师制造商的代工厂。\n同样的品质，却有更优的价格。', 'http://yanxuan.nosdn.127.net/c4ab88f475e375c5748fa13d8bf2858d.png', 40, 1, 45.00, 'http://yanxuan.nosdn.127.net/5fd51e29b9459dae7df8040c8219f241.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001010, '星巴克制造商', 'http://yanxuan.nosdn.127.net/5668bc50f2f2e551891044525710dc84.png', '严选寻访全国保温杯制造企业，\n最终找到高端咖啡品牌星巴克的制造商，\n专注保温杯生产20年，品质与颜值兼备。', 'http://yanxuan.nosdn.127.net/2433b04ea9d7adda1d2e834786872237.jpg', 34, 1, 39.00, 'http://yanxuan.nosdn.127.net/5668bc50f2f2e551891044525710dc84.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001012, 'Wedgwood制造商', 'http://yanxuan.nosdn.127.net/68940e8e23f96dbeb3548d943d83d5e4.png', '严选寻访英国皇室御用陶瓷Wedgwood制造商，\n制模到成品，历经25道工序、7次检验、3次烧制，\n你看不见的地方，我们也在坚持。', 'http://yanxuan.nosdn.127.net/6d6124123311f85903a8bc864d37464c.jpg', 21, 1, 39.00, 'http://yanxuan.nosdn.127.net/68940e8e23f96dbeb3548d943d83d5e4.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001013, 'Royal Doulton制造商', 'http://yanxuan.nosdn.127.net/0de643a02043fd9680b11e21c452adaa.png', '严选深入英国最大骨瓷品牌Royal Doulton制造商， \n顶级英国瓷器的代名词，广受世界皇室喜爱。\n每件瓷器，都有自己的故事。', 'http://yanxuan.nosdn.127.net/0e8311d2246e5643c622743d9684f235.jpg', 47, 1, 24.90, 'http://yanxuan.nosdn.127.net/0de643a02043fd9680b11e21c452adaa.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001015, '日本KEYUCA制造商', 'http://yanxuan.nosdn.127.net/9b85b45f23da558be101dbcc273b1d6d.png', 'KEYUCA是日本餐具及料理用具品牌，\n遵循极简原木风，高端餐具体验。\n严选的餐具正是来自这一品牌制造商。', 'http://yanxuan.nosdn.127.net/d91db0c68c50cd109c16f0ad1427ed0b.jpg', 49, 1, 14.90, 'http://yanxuan.nosdn.127.net/9b85b45f23da558be101dbcc273b1d6d.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001016, '爱慕制造商', 'http://yanxuan.nosdn.127.net/5104f84110eac111968c63c18ebd62c0.png', '150家样品比对筛选，20家工厂深入走访，\n严选最终选定高端内衣爱慕制造商，\n20年品质保证，为你打造天然舒适的衣物。', 'http://yanxuan.nosdn.127.net/833104a2ac047faccd90cc6b98ccf4be.jpg', 9, 1, 35.00, 'http://yanxuan.nosdn.127.net/5104f84110eac111968c63c18ebd62c0.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001020, 'Ralph Lauren制造商', 'http://yanxuan.nosdn.127.net/9df78eb751eae2546bd3ee7e61c9b854.png', '我们与Ralph Lauren Home的制造商成功接洽，掌握先进的生产设备，传承品牌工艺和工序。追求生活品质的你，值得拥有。', 'http://yanxuan.nosdn.127.net/089e4066f0c2bc6b062d17c6292735dc.png', 20, 1, 29.00, 'http://yanxuan.nosdn.127.net/9df78eb751eae2546bd3ee7e61c9b854.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001037, '新秀丽制造商', 'http://yanxuan.nosdn.127.net/80dce660938931956ee9a3a2b111bd37.jpg', '严选为制作品质与颜值兼具的箱包，\n选定新秀丽、CK、Ricardo等品牌合作的制造商，\n拥有国内先进流水线20余条，实力保障品质。', 'http://yanxuan.nosdn.127.net/af5719e20bdbd214a9ce7d961e9031c5.png', 5, 1, 59.00, 'http://yanxuan.nosdn.127.net/80dce660938931956ee9a3a2b111bd37.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001038, 'Coach制造商', 'http://yanxuan.nosdn.127.net/1b1cc16135fd8467d40983f75f644127.png', '严选为制作高品质高颜值皮具配件，\n由Coach、MK等品牌制造商生产，\n由严选360度全程监制，给你带来优质皮具。', 'http://yanxuan.nosdn.127.net/c933a662bb79b2a47280363e35ab994b.png', 3, 1, 49.00, 'http://yanxuan.nosdn.127.net/1b1cc16135fd8467d40983f75f644127.png', 1, 'http://yanxuan.nosdn.127.net/b5cd73d3b310bad02539412f064d4ea1.jpg', 10);
INSERT INTO `bbgshop_brand` VALUES (1001039, 'MK制造商', 'http://yanxuan.nosdn.127.net/fc9cd1309374f7707855de80522fb310.jpg', '严选为制造高品质的皮具，\n选择Michael Kors品牌合作的制造工厂，\n18年专业皮具生产经验，手工至美，品质保证。', 'http://yanxuan.nosdn.127.net/c302c82dafcb53ba233aa1e277063a1c.png', 17, 1, 79.00, 'http://yanxuan.nosdn.127.net/fc9cd1309374f7707855de80522fb310.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1001045, '罗莱制造商', 'http://yanxuan.nosdn.127.net/14122a41a4985d23e1a172302ee818e9.png', '严选团队为打造吸湿透气柔软的蚕丝被，\n从蚕茧原材到温感性能，多次甄选测试\n选择罗莱制造商工厂，手工处理，优质舒适。', 'http://yanxuan.nosdn.127.net/a88d8eae6d492492da07eca7616dce42.jpg', 45, 1, 699.00, 'http://yanxuan.nosdn.127.net/14122a41a4985d23e1a172302ee818e9.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1003000, 'Carters制造商', 'http://yanxuan.nosdn.127.net/efe9131599ced0297213e6ec67eb2174.png', '来自Carters大牌代工厂生产，\n严选纯天然材料，无荧光不添加，\nITS安心标志权威检测，安全护航。', 'http://yanxuan.nosdn.127.net/a3fd78f8cf429a34e1e2ea761466d428.jpg', 41, 1, 19.90, 'http://yanxuan.nosdn.127.net/efe9131599ced0297213e6ec67eb2174.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1005001, 'Goody制造商', 'http://yanxuan.nosdn.127.net/7c918f37de108f3687d69b39daab34eb.png', '严选深入美国百年发饰品牌Goody制造商，\n确保每把梳子做工精湛，养护头皮。\n戴安娜王妃的最爱，你也能拥有。', 'http://yanxuan.nosdn.127.net/431cd1e6bfca9964f96f1964a8b08ebb.jpg', 48, 1, 39.00, 'http://yanxuan.nosdn.127.net/7c918f37de108f3687d69b39daab34eb.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1006000, '范思哲制造商', 'http://yanxuan.nosdn.127.net/c80ae035387495a61a4515906205efff.png', '严选找寻意大利奢侈品牌范思哲Versace的制造商，\n致力于为用户带来精致、优雅、时尚的皮包，\n传承独特美感，体验品质生活。', 'http://yanxuan.nosdn.127.net/4e5e9e8cf9ce08f256494321ba4d3c2a.jpg', 18, 1, 99.00, 'http://yanxuan.nosdn.127.net/c80ae035387495a61a4515906205efff.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1008000, 'WPC制造商', 'http://yanxuan.nosdn.127.net/c4e97cc87186ce17f9316f3ba39e220c.png', '严选寻找日本雨伞品牌W.P.C制造商，\n采用严谨工艺以及环保材料，\n沉淀15年行业经验，打造精致雨具。', 'http://yanxuan.nosdn.127.net/83889aa01e7cf8e0ff605c317a01e55d.jpg', 22, 1, 59.00, 'http://yanxuan.nosdn.127.net/c4e97cc87186ce17f9316f3ba39e220c.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1010001, '竹宝堂制造商', 'http://yanxuan.nosdn.127.net/61b0b7ae4f0163422009defbceaa41ad.jpg', '严选走访河北、安徽等制刷基地，\n选定竹宝堂、丝芙兰等品牌的制造商，\n严格把关生产与质检，与您一同追求美的生活。', 'http://yanxuan.nosdn.127.net/279cf74ac294e67f7f99cf2d47a1365c.jpg', 39, 1, 29.00, 'http://yanxuan.nosdn.127.net/61b0b7ae4f0163422009defbceaa41ad.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1010002, '资生堂制造商', 'http://yanxuan.nosdn.127.net/5449236b80d1e678dedee2f626cd67c4.png', '发现美，成为美，是女性一生的追求。\n严选找寻资生堂代工厂，打造天然美妆产品，\n致力于带来更多美的体验和享受。', 'http://yanxuan.nosdn.127.net/af464d5281dfbd286dab569a03264a33.jpg', 19, 1, 29.00, 'http://yanxuan.nosdn.127.net/5449236b80d1e678dedee2f626cd67c4.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1015000, 'NITORI制造商', 'http://yanxuan.nosdn.127.net/6f3d310601b18610553c675e0e14d107.png', '宠物是人类最温情的陪伴，\n严选找寻日本最大家居品牌NITORI制造商，\n每一个脚印，都是为了更好地关怀你的TA', 'http://yanxuan.nosdn.127.net/0657854429c6717e8ace7dcff6a2468b.jpg', 43, 1, 69.00, 'http://yanxuan.nosdn.127.net/6f3d310601b18610553c675e0e14d107.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1016002, 'HUGO BOSS制造商', 'http://yanxuan.nosdn.127.net/70ada9877b2efa82227437af3231fe50.png', '严选深入德国知名奢侈品HUGO BOSS的制造商，\n开发睡衣、睡袍、休闲裤等轻奢品质家居服，\n希望你在家的每一天都优雅精致。', 'http://yanxuan.nosdn.127.net/888289da7fe200949806eefa069af019.jpg', 11, 1, 45.00, 'http://yanxuan.nosdn.127.net/70ada9877b2efa82227437af3231fe50.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1018000, 'Sperry制造商', 'http://yanxuan.nosdn.127.net/2eb12d84037346441088267432da31c4.png', '严选团队对比多家硫化鞋制造商产品质量，\n走访多个制鞋工厂，最终选定Sperry品牌制造商，\n为你提供一双舒适有型的高品质帆布鞋。', 'http://yanxuan.nosdn.127.net/952b9f38a729533a058ee88572a370fa.jpg', 32, 1, 199.00, 'http://yanxuan.nosdn.127.net/2eb12d84037346441088267432da31c4.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1021000, 'Marc Jacobs制造商', 'http://yanxuan.nosdn.127.net/c8dac4eb1a458d778420ba520edab3d0.png', '严选寻访独立设计品牌Marc Jacobs的制造商，\n严格选材，细究纺织与生产的细节，多次打磨，\n初心不忘，为你带来优雅高档的服饰配件。', 'http://yanxuan.nosdn.127.net/ce5762f1fd4bde61b57864e765c605e3.jpg', 24, 1, 69.00, 'http://yanxuan.nosdn.127.net/c8dac4eb1a458d778420ba520edab3d0.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1022000, 'UGG制造商', 'http://yanxuan.nosdn.127.net/4d2a3dea7e0172ae48e8161f04cfa045.jpg', '为寻找优质的皮毛一体雪地靴，\n严选走访多家雪地靴制造商，对比工艺，\n甄选UGG认可的代工厂，只为足下的优雅舒适。', 'http://yanxuan.nosdn.127.net/efbc6a6044dd07697d2f26bf5033c335.jpg', 29, 1, 59.00, 'http://yanxuan.nosdn.127.net/4d2a3dea7e0172ae48e8161f04cfa045.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1022001, 'Palladium制造商', 'http://yanxuan.nosdn.127.net/3480f2a4026c60eb4921f0aa3facbde8.png', '严选探访多个制鞋大厂，选定Palladium制造商，\n对比工艺选材，找到传承多年的制鞋配方，\n只为制作一款高品质休闲鞋。', 'http://yanxuan.nosdn.127.net/119717ea4459a8fb3185cec4eb80a284.jpg', 31, 1, 249.00, 'http://yanxuan.nosdn.127.net/3480f2a4026c60eb4921f0aa3facbde8.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1023000, 'PetitBateau小帆船制造商', 'http://yanxuan.nosdn.127.net/1a11438598f1bb52b1741e123b523cb5.jpg', '为打造适合宝宝的婴童服装，\n严选团队寻找PetitBateau小帆船的品牌制造商，\n无荧光剂，国家A类标准，让宝宝穿的放心。', 'http://yanxuan.nosdn.127.net/faad5a05a119b789956e4ce2e26e94ef.jpg', 25, 1, 36.00, 'http://yanxuan.nosdn.127.net/1a11438598f1bb52b1741e123b523cb5.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1024000, 'WMF制造商', 'http://yanxuan.nosdn.127.net/2018e9ac91ec37d9aaf437a1fd5d7070.png', '严选找寻德国百年高端厨具WMF的制造商，\n选择拥有14年经验的不锈钢生产工厂，\n为你甄选事半功倍的优质厨具。', 'http://yanxuan.nosdn.127.net/2a2ae0d49043e525db8d0d8d84460ac8.png', 8, 1, 9.90, 'http://yanxuan.nosdn.127.net/2018e9ac91ec37d9aaf437a1fd5d7070.png', 1, 'http://yanxuan.nosdn.127.net/abcfa79205679db51198adc19c184dd1.jpg', 3);
INSERT INTO `bbgshop_brand` VALUES (1024001, 'OBH制造商', 'http://yanxuan.nosdn.127.net/bf3499ac17a11ffb9bb7caa47ebef2dd.png', '严选寻找OBH品牌的制造商，打造精致厨具，\n韩国独资工厂制造，严格质检，品质雕琢\n力求为消费者带来全新的烹饪体验。', 'http://yanxuan.nosdn.127.net/44e14d6ec4db2e6c66b0fde521603f85.jpg', 42, 1, 39.00, 'http://yanxuan.nosdn.127.net/bf3499ac17a11ffb9bb7caa47ebef2dd.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1024003, 'Stoneline制造商', 'http://yanxuan.nosdn.127.net/3a44ae7db86f3f9b6e542720c54cc349.png', '严选找寻德国经典品牌Stoneline的制造商，\n追踪工艺，考量细节，亲自试用，\n为你甄选出最合心意的锅具和陶瓷刀，下厨如神。', 'http://yanxuan.nosdn.127.net/6dc7eecce99cb8f5ab6d86c76415cbec.png', 28, 1, 9.90, 'http://yanxuan.nosdn.127.net/3a44ae7db86f3f9b6e542720c54cc349.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1024006, 'KitchenAid制造商', 'http://yanxuan.nosdn.127.net/e11385bf29d1b3949435b80fcd000948.png', '严选寻访KitchenAid品牌的制造商，\n采用德国LFGB认证食品级专用不锈钢，\n欧式简约设计，可靠安心，尽享下厨乐趣。', 'http://yanxuan.nosdn.127.net/2f79a254cd4020966ea1272e2d27b510.jpg', 46, 1, 98.00, 'http://yanxuan.nosdn.127.net/e11385bf29d1b3949435b80fcd000948.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1025000, 'Timberland制造商', 'http://yanxuan.nosdn.127.net/6dcadb0791b33aa9fd00380b44fa6645.png', '为制作优质时尚的工装鞋靴，\n严选团队深入探访国内外制靴大厂，选择Timberland制造商，\n工厂拥有15年制鞋历史，专业品质有保证。', 'http://yanxuan.nosdn.127.net/5b35f510110d0c031eb6bf63854597b8.png', 37, 1, 359.00, 'http://yanxuan.nosdn.127.net/6dcadb0791b33aa9fd00380b44fa6645.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1025001, 'Kenneth Cole制造商', 'http://yanxuan.nosdn.127.net/236322546c6860e1662ab147d6b0ba2f.jpg', '为出品优质格调的商务鞋靴，\n严选团队选择Kenneth Cole品牌合作的制造商，\n一切努力，只为打造高品质鞋靴。', 'http://yanxuan.nosdn.127.net/63a1df6f5d26faadffa33bac2d51ddc4.jpg', 7, 1, 349.00, 'http://yanxuan.nosdn.127.net/236322546c6860e1662ab147d6b0ba2f.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1026000, 'CK制造商', 'http://yanxuan.nosdn.127.net/658f09b7ec522d31742b47b914d64338.png', '严选寻访Calvin Klein品牌的制造商，\n深入世界领带第一生产地，设计与品质并重，\n致力于给消费者带来优质典雅的服饰用品。', 'http://yanxuan.nosdn.127.net/fb139c9f11a10deb41beeb42aaad488e.png', 1, 1, 39.00, 'http://yanxuan.nosdn.127.net/658f09b7ec522d31742b47b914d64338.png', 1, 'http://yanxuan.nosdn.127.net/76638fb8e6990aadf837ce761c3b7399.jpg', 1);
INSERT INTO `bbgshop_brand` VALUES (1026001, 'Under Armour制造商', 'http://yanxuan.nosdn.127.net/4e93ea29b1d06fabfd24ba68a9b20a34.jpg', '严选为甄选优质好袜，走访东北、新疆等产袜基地，\n最终选定Under Armour品牌的合作制造商，\n从原料、工艺、品质多维度筛选监制，保证好品质。', 'http://yanxuan.nosdn.127.net/b00570a5edc8da2f4a629fbdddb0b03c.jpg', 35, 1, 39.00, 'http://yanxuan.nosdn.127.net/4e93ea29b1d06fabfd24ba68a9b20a34.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1028000, 'Gucci制造商', 'http://yanxuan.nosdn.127.net/278869cad9bf5411ffc18982686b88fb.jpg', '严选为设计一款优雅时尚的品质礼帽，\n找寻拥有10来年经验的大型毛毡帽厂商合作，\n坚持打造好设计、好工艺、好材质的潮流礼帽。', 'http://yanxuan.nosdn.127.net/7749ff4939c0a62689c5d1de7fba2860.png', 23, 1, 59.00, 'http://yanxuan.nosdn.127.net/278869cad9bf5411ffc18982686b88fb.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1028003, 'Burberry制造商', 'http://yanxuan.nosdn.127.net/07af01e281c7e0b912d162d611e22c32.jpg', '为打造时尚舒适的童装系列，\n严选选择Burberry制造商，优化版型配色\n英伦风情融入经典格纹，百搭优雅气质款。', 'http://yanxuan.nosdn.127.net/1a874a6b8cf8c17ef7420b2449179eae.jpg', 4, 1, 99.00, 'http://yanxuan.nosdn.127.net/07af01e281c7e0b912d162d611e22c32.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1033003, 'Armani制造商', 'http://yanxuan.nosdn.127.net/981e06f0f46f5f1f041d7de3dd3202e6.jpg', '严选团队携手国际标准化专业生产厂家，\n厂家长期为Armani、Alexander wang等知名品牌代工，\n专业进口设备，精密质量把控，精于品质居家体验。', 'http://yanxuan.nosdn.127.net/cc2513963d45c8a0787bc9650e95b3bc.jpg', 26, 1, 199.00, 'http://yanxuan.nosdn.127.net/981e06f0f46f5f1f041d7de3dd3202e6.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1033004, '爱马仕集团制造商', 'http://yanxuan.nosdn.127.net/d98470dd728fb5a91f7aceade07572b5.png', '严选采用欧洲一线品牌爱马仕的御用香料供应商，\n经过反复配比改良、试香调香、选品定样，\n为你带来独特馥郁的散香体验。', 'http://yanxuan.nosdn.127.net/dd4b9a6cb73e3e1c61c79cbd4bb0bca0.jpg', 33, 1, 19.00, 'http://yanxuan.nosdn.127.net/d98470dd728fb5a91f7aceade07572b5.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1034001, 'Alexander McQueen制造商', 'http://yanxuan.nosdn.127.net/db7ee9667d84cbce573688297586699c.jpg', '为制造精致实用的高品质包包，\n严选团队选择Alexander McQueen制造商，\n严格筛选，带来轻奢优雅体验。', 'http://yanxuan.nosdn.127.net/48d8b0a9cd41cd7028b055d6d2b4b57e.jpg', 16, 1, 69.00, 'http://yanxuan.nosdn.127.net/db7ee9667d84cbce573688297586699c.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1037000, '厚木ATSUGI制造商', 'http://yanxuan.nosdn.127.net/7df55c408dbac6085ed6c30836c828ac.jpg', '严选考究袜子品质，层层把关原料生产，\n携手12年行业生产资质的厚木品牌制造商，\n带来轻盈优雅，舒适显瘦的袜子系列。', 'http://yanxuan.nosdn.127.net/51f1a2b3e663989e8880066af929ce50.jpg', 27, 1, 29.00, 'http://yanxuan.nosdn.127.net/7df55c408dbac6085ed6c30836c828ac.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1038000, 'Birkenstock集团制造商', 'http://yanxuan.nosdn.127.net/05a2ecffb60b77e4c165bd8492e5c22a.jpg', '为打造一双舒适的软木拖鞋，\n严选团队寻找BIRKENSTOCK集团旗下产品制造商，\n360度全程监制，舒适随脚，百搭文艺。', 'http://yanxuan.nosdn.127.net/0996a492f86f01cb83cd3737ad325e23.jpg', 14, 1, 59.90, 'http://yanxuan.nosdn.127.net/05a2ecffb60b77e4c165bd8492e5c22a.jpg', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1038001, 'Nine West制造商', 'http://yanxuan.nosdn.127.net/ad4df7848ce450f00483c2d5e9f2bfa7.png', '为打造一双优雅舒适的高跟鞋，\n严选选择美国Nine West玖熙品牌的制造商，\n让美丽绽放在足尖。', 'http://yanxuan.nosdn.127.net/38d494067453afa08d2b26d8227558fc.jpg', 13, 1, 219.00, 'http://yanxuan.nosdn.127.net/ad4df7848ce450f00483c2d5e9f2bfa7.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1039000, 'TEFAL制造商', 'http://yanxuan.nosdn.127.net/2b7a07e25a3f3be886a7fb90ba975bb7.png', '严选对标国际品质，致力于高品质生活好物，\n执着寻求优质厨房电器供应商，\n携手WMF、Tefal制造商，打造高品质厨具。', 'http://yanxuan.nosdn.127.net/713daad73395a4f3d06f5dd07ed927d4.jpg', 44, 1, 259.00, 'http://yanxuan.nosdn.127.net/2b7a07e25a3f3be886a7fb90ba975bb7.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1039001, '京瓷制造商', 'http://yanxuan.nosdn.127.net/3dda530605e3ab1c82d5ed30f2489473.png', '严选想为你的厨房生活，带来新鲜感和活力，\n深入全国各地，选择日本京瓷等品牌代工厂，\n打造钻石系列厨具，颜值与品质兼具。', 'http://yanxuan.nosdn.127.net/de8c967f47c47e48aaaf461a5e24bc4c.jpg', 38, 1, 89.00, 'http://yanxuan.nosdn.127.net/3dda530605e3ab1c82d5ed30f2489473.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1040000, 'Tescom制造商', 'http://yanxuan.nosdn.127.net/c17cd65971189fdc28f5bd6b78f657a7.png', '严选为打造时尚健康的个护电器，\n选择Tescom品牌制造商，全球最大个护电器工厂之一，\n拥有20年经验，出口180多个国家，品质有保障。', 'http://yanxuan.nosdn.127.net/21ff3c560b263cf45dd2b8c92091768b.jpg', 15, 1, 59.00, 'http://yanxuan.nosdn.127.net/c17cd65971189fdc28f5bd6b78f657a7.png', 0, '', 10);
INSERT INTO `bbgshop_brand` VALUES (1041000, 'BCBG制造商', 'http://yanxuan.nosdn.127.net/b9072023afd3621714fd5c49f140fca8.png', '严选从产品源头开始，每道工序质量把关，\n选择美国知名品牌BCBG的制造商合作，\n严谨匠心，致力于优质柔滑的睡衣穿搭产品。', 'http://yanxuan.nosdn.127.net/3f2a66543f4c6e2abd5de2d280ff7960.png', 36, 1, 99.00, 'http://yanxuan.nosdn.127.net/b9072023afd3621714fd5c49f140fca8.png', 0, '', 10);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_cart
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_cart`;
CREATE TABLE `bbgshop_cart` (
  `id` mediumint(12) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(12) unsigned NOT NULL DEFAULT '0',
  `session_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `goods_id` bigint(32) unsigned NOT NULL DEFAULT '0',
  `goods_sn` varchar(60) NOT NULL DEFAULT '',
  `product_id` mediumint(12) unsigned NOT NULL DEFAULT '0',
  `goods_name` varchar(120) NOT NULL DEFAULT '',
  `market_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `retail_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `number` smallint(5) unsigned NOT NULL DEFAULT '0',
  `goods_specifition_name_value` text NOT NULL COMMENT '规格属性组成的字符串，用来显示用',
  `goods_specifition_ids` varchar(60) NOT NULL DEFAULT '' COMMENT 'product表对应的goods_specifition_ids',
  `checked` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `list_pic_url` varchar(255) DEFAULT '',
  `freight_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `freight_template` int(5) NOT NULL DEFAULT '0',
  `freight_type` int(5) NOT NULL DEFAULT '0',
  `supplier_id` int(5) DEFAULT NULL,
  `Identity` int(2) NOT NULL DEFAULT '0' COMMENT '是否需要身份信息',
  PRIMARY KEY (`id`),
  KEY `session_id` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=977 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_cart
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_cart` VALUES (975, 42, '1', 1530752944419263, 'T15307529444192634', 728, '测试添测试添测试添测试添测\n试添测试添', 576.00, 576.00, 1, '绿色;1.1M;1.1KG', '563_564_566', 1, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 0.00, 0, 0, 4, 1);
INSERT INTO `bbgshop_cart` VALUES (971, 42, '1', 1528855134649776, 'F15288551346497762', 710, '零食零食零食零食零食零食零食零食零食零食零食', 345.00, 345.00, 1, '测试规格1.3', '547', 1, 'http://resource.bbgshop.com/FsfVl-KXPGa1RtHOJvo99QRxar18', 0.00, 12, 1, 2, 0);
INSERT INTO `bbgshop_cart` VALUES (972, 42, '1', 1530752944419263, 'T15307529444192635', 729, '测试添测试添测试添测试添测\n试添测试添', 8667.00, 8667.00, 1, '绿色;1.5M;1.1KG', '563_565_566', 1, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 0.00, 0, 0, 4, 1);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_cart_rules
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_cart_rules`;
CREATE TABLE `bbgshop_cart_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rules_name` varchar(256) NOT NULL,
  `is_abled` int(2) NOT NULL DEFAULT '0',
  `rules_limit_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '限制金额',
  `rules_type` int(2) NOT NULL DEFAULT '0' COMMENT '类型 减运费 满减 折扣',
  `rules_discount_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '折扣比例',
  `rules_minus_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '满减金额',
  `rules_limit` int(2) NOT NULL DEFAULT '0' COMMENT '是否限制',
  `rules_suit` int(2) NOT NULL DEFAULT '0' COMMENT '适用对象',
  `rules_suit_catelog` varchar(512) DEFAULT NULL COMMENT '适用的分类',
  `create_time` varchar(32) NOT NULL DEFAULT '0',
  `handel_time` varchar(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_cart_rules
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_cart_rules` VALUES (10, '满100,0.01', 0, 100.00, 2, 0.01, 0.00, 1, 0, '', '1533373232825', '0');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_category
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_category`;
CREATE TABLE `bbgshop_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(90) NOT NULL DEFAULT '',
  `keywords` varchar(255) NOT NULL DEFAULT '',
  `front_desc` varchar(255) NOT NULL DEFAULT '',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0',
  `sort_order` tinyint(1) unsigned NOT NULL DEFAULT '50',
  `show_index` tinyint(1) NOT NULL DEFAULT '0',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `banner_url` varchar(255) NOT NULL DEFAULT '',
  `icon_url` varchar(255) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `wap_banner_url` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT '0',
  `front_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1036079 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_category
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_category` VALUES (1036046, 'Daniel Wellington', '', '遇见它之后，时间和浪漫从此有了新的定义。', 1036030, 2, 0, 1, 'http://resource.bbgshop.com/FjkXKMc1okA09Ds5dZmRO7OX6ScU', 'http://resource.bbgshop.com/FjkXKMc1okA09Ds5dZmRO7OX6ScU', NULL, 'http://resource.bbgshop.com/FjkXKMc1okA09Ds5dZmRO7OX6ScU', 'L2', 0, '遇见它之后，时间和浪漫从此有了新的定义。');
INSERT INTO `bbgshop_category` VALUES (1036045, '美味零食子分类1', '', '美味零食子分类1美味零食子分类1美味零食子分类1', 1036044, 1, 0, 1, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', NULL, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L2', 0, '美味零食子分类1美味零食子分类1美味零食子分类1');
INSERT INTO `bbgshop_category` VALUES (1036044, '美味零食', '', '美味零食美味零食美味零食美味零食', 0, 10, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', NULL, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L1', 0, '美味零食美味零食美味零食美味零食');
INSERT INTO `bbgshop_category` VALUES (1036043, '精品厨具子分类1', '', '精品厨具子分类1精品厨具子分类1精品厨具子分类1', 1036042, 1, 0, 1, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', NULL, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L2', 0, '精品厨具子分类1精品厨具子分类1精品厨具子分类1');
INSERT INTO `bbgshop_category` VALUES (1036042, '精品厨具', '', '精品厨具精品厨具精品厨具精品厨具', 0, 9, 1, 1, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'null', NULL, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L1', 0, '精品厨具精品厨具精品厨具精品厨具');
INSERT INTO `bbgshop_category` VALUES (1036041, '智能家居', '', '智能家居子分类智能家居子分类智能家居子分类', 1036040, 1, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', NULL, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L2', 0, '智能家居子分类智能家居子分类智能家居子分类');
INSERT INTO `bbgshop_category` VALUES (1036040, '智能家居', '', '智能家居智能家居智能家居智能家居', 0, 8, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', NULL, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L1', 0, '智能家居智能家居智能家居智能家居');
INSERT INTO `bbgshop_category` VALUES (1036039, '营养保健子分类1', '', '营养保健子分类1营养保健子分类1营养保健子分类1', 1036038, 1, 0, 1, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', NULL, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L2', 0, '营养保健子分类1营养保健子分类1营养保健子分类1');
INSERT INTO `bbgshop_category` VALUES (1036038, '营养保健', '', '营养保健营养保健营养保健营养保健营养保健', 0, 7, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', NULL, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L1', 0, '营养保健营养保健营养保健营养保健营养保健');
INSERT INTO `bbgshop_category` VALUES (1036037, '名品箱包子分类1', '', '名品箱包子分类1名品箱包子分类1名品箱包子分类1', 1036036, 1, 0, 1, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', NULL, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L2', 0, '名品箱包子分类1名品箱包子分类1名品箱包子分类1');
INSERT INTO `bbgshop_category` VALUES (1036036, '名品箱包', '', '名品箱包名品箱包名品箱包名品箱包', 0, 6, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', NULL, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L1', 0, '名品箱包名品箱包名品箱包名品箱包');
INSERT INTO `bbgshop_category` VALUES (1036035, '生活日用子分类1', '', '生活日用子分类1生活日用子分类1生活日用子分类1', 1036034, 1, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', NULL, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L2', 0, '生活日用子分类1生活日用子分类1生活日用子分类1');
INSERT INTO `bbgshop_category` VALUES (1036034, '生活日用', '', '生活日用生活日用生活日用', 0, 5, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', NULL, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L1', 0, '生活日用生活日用生活日用');
INSERT INTO `bbgshop_category` VALUES (1036047, '施华洛世奇', '', '施华洛世奇以其独特的水晶碎石镶工闻名于世。', 1036030, 3, 0, 0, 'http://resource.bbgshop.com/FjLSuBJigqD6JHQEWtZxL2x9XE5_', 'null', NULL, 'http://resource.bbgshop.com/FjLSuBJigqD6JHQEWtZxL2x9XE5_', 'L2', 0, '施华洛世奇以其独特的水晶碎石镶工闻名于世。');
INSERT INTO `bbgshop_category` VALUES (1036032, '母婴呵护', '', '母婴呵护母婴呵护介绍', 0, 4, 0, 1, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', NULL, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L1', 0, '母婴呵护母婴呵护介绍');
INSERT INTO `bbgshop_category` VALUES (1036033, '母婴呵护子分类1', '', '母婴呵护子分类1母婴呵护子分类1', 1036032, 1, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', NULL, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L2', 0, '母婴呵护子分类1母婴呵护子分类1');
INSERT INTO `bbgshop_category` VALUES (1036031, 'APM Monaco', '', '轻奢首饰子分类1轻奢首饰子分类1轻奢首饰子分类1', 1036030, 1, 0, 1, 'http://resource.bbgshop.com/FoZrZsK9cB2K9t0iDt6_I52r-1uC', 'http://resource.bbgshop.com/FoZrZsK9cB2K9t0iDt6_I52r-1uC', NULL, 'http://resource.bbgshop.com/FoZrZsK9cB2K9t0iDt6_I52r-1uC', 'L2', 0, 'APM MONACO珠宝设计是流行精品时尚的佼佼者。');
INSERT INTO `bbgshop_category` VALUES (1036030, '轻奢首饰', '', '轻奢首饰轻奢首饰分类', 0, 3, 1, 1, 'http://resource.bbgshop.com/FjBPZ9NtK7IysnBonw21DPWyVSIT', 'null', NULL, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L1', 0, '轻奢首饰轻奢首饰分类');
INSERT INTO `bbgshop_category` VALUES (1036029, '美妆热卖子分类1', '', '美妆热卖子分类1美妆热卖子分类1美妆热卖子分类1', 1036028, 1, 0, 1, 'http://p6dsy7wb1.bkt.clouddn.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'null', NULL, 'http://p6dsy7wb1.bkt.clouddn.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'L2', 0, '美妆热卖子分类1美妆热卖子分类1美妆热卖子分类1');
INSERT INTO `bbgshop_category` VALUES (1036077, '24563456', '', '34563456', 1036076, 0, 0, 1, '', 'null', NULL, 'http://resource.bbgshop.com/FoGL4vWKPrTzvQ-7UFtc8ZNiC3f5', 'L2', 0, '34563456');
INSERT INTO `bbgshop_category` VALUES (1036028, '美妆热卖', '', '美妆热卖美妆热卖美妆热卖', 0, 1, 1, 1, 'http://resource.bbgshop.com/FgNy4ZPIytPwyJw8PnsQiqa-xtN2', 'null', NULL, 'http://p6dsy7wb1.bkt.clouddn.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L1', 0, '美妆热卖美妆热卖美妆热卖');
INSERT INTO `bbgshop_category` VALUES (1036026, '彩妆护理', '', '彩妆护理彩妆护理', 0, 2, 0, 1, 'http://resource.bbgshop.com/FiEINipytlEjwybQythJ_4LD_Uum', 'null', NULL, 'http://p6dsy7wb1.bkt.clouddn.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L1', 0, '彩妆护理彩妆护理');
INSERT INTO `bbgshop_category` VALUES (1036027, '彩妆护理子分类1', '', '彩妆护理子分类1彩妆护理子分类1', 1036026, 1, 0, 1, 'http://p6dsy7wb1.bkt.clouddn.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'http://p6dsy7wb1.bkt.clouddn.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', NULL, 'http://p6dsy7wb1.bkt.clouddn.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L2', 0, '彩妆护理子分类1彩妆护理子分类1');
INSERT INTO `bbgshop_category` VALUES (1036062, '测试二级', '', '测试二级测试二级', 1036060, 0, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'null', NULL, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L2', 0, '测试二级测试二级');
INSERT INTO `bbgshop_category` VALUES (1036063, '是的非常撒旦法阿斯蒂芬', '', '阿斯蒂芬安抚阿斯蒂芬阿斯蒂芬', 1036026, 2, 0, 1, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 'null', NULL, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'L2', 0, '阿斯蒂芬安抚阿斯蒂芬阿斯蒂芬');
INSERT INTO `bbgshop_category` VALUES (1036071, '65567', '', '567567', 1036070, 1, 0, 1, '', 'null', NULL, 'http://resource.bbgshop.com/FoGL4vWKPrTzvQ-7UFtc8ZNiC3f5', 'L2', 0, '567567');
INSERT INTO `bbgshop_category` VALUES (1036065, '123412', '', '12341234', 1036064, 0, 0, 1, '', 'null', NULL, 'http://resource.bbgshop.com/Fn1oDXOhlqEro7Y2WHPx4u5jI7St', 'L2', 0, '12341234');
INSERT INTO `bbgshop_category` VALUES (1036078, '132456', '', '12465', 1036026, 0, 0, 1, '', 'null', NULL, 'http://resource.bbgshop.com/Fh8sSRR5f5N2tx28CMJe0yWa3fkz', 'L2', 0, '12465');
INSERT INTO `bbgshop_category` VALUES (1036067, '阿斯蒂芬撒旦法阿斯蒂芬', '', '阿萨德发斯蒂芬阿斯蒂芬', 1036066, 0, 0, 1, '', 'null', NULL, 'http://resource.bbgshop.com/FoGL4vWKPrTzvQ-7UFtc8ZNiC3f5', 'L2', 0, '阿萨德发斯蒂芬阿斯蒂芬');
INSERT INTO `bbgshop_category` VALUES (1036069, '测发顺丰', '', '阿斯蒂芬阿斯蒂芬', 1036068, 0, 0, 1, '', 'null', NULL, 'http://resource.bbgshop.com/FjjK3T45tSh0yRFQAvFoBzL5HOZ9', 'L2', 0, '阿斯蒂芬阿斯蒂芬');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_channel
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_channel`;
CREATE TABLE `bbgshop_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(16) NOT NULL DEFAULT '0',
  `name` varchar(45) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `icon_url` varchar(255) NOT NULL DEFAULT '',
  `sort_order` int(4) unsigned NOT NULL DEFAULT '10',
  `parent_id` int(16) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_channel
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_channel` VALUES (98, 1036030, '1036030', '/pages/category/category?id=1036030', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 3, 1036059);
INSERT INTO `bbgshop_channel` VALUES (101, 1036026, '1036026', '/pages/category/category?id=1036026', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 2, 1036028);
INSERT INTO `bbgshop_channel` VALUES (102, 1036030, '1036030', '/pages/category/category?id=1036030', 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', 0, 1036030);
INSERT INTO `bbgshop_channel` VALUES (103, 1036042, '1036042', '/pages/category/category?id=1036042', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 10, 1036042);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_collage
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_collage`;
CREATE TABLE `bbgshop_collage` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '砍价id、',
  `goodsid` bigint(32) NOT NULL COMMENT '商品id',
  `goods_name` varchar(256) NOT NULL DEFAULT '' COMMENT '商品名称',
  `collage_price` varchar(8) NOT NULL DEFAULT '0' COMMENT '底价',
  `retail_price` varchar(8) NOT NULL DEFAULT '0' COMMENT '商品原价',
  `most_init_num` int(8) NOT NULL DEFAULT '0' COMMENT '最多发起次数',
  `least_coll_num` int(8) NOT NULL DEFAULT '0' COMMENT '至少砍价人数',
  `activity_detail` text NOT NULL COMMENT '活动详情页',
  `purchased_num` int(8) NOT NULL DEFAULT '0' COMMENT '已购买的人数',
  `launched_num` int(8) NOT NULL DEFAULT '0' COMMENT '已发起人数',
  `collage_success_num` int(8) NOT NULL COMMENT '拼团成功人数',
  `is_abled` int(1) NOT NULL DEFAULT '0' COMMENT '是否启用',
  `create_time` varchar(32) DEFAULT NULL COMMENT '创建时间',
  `user_duration_time` varchar(32) DEFAULT NULL COMMENT '允许用户砍价持续时间',
  `virtual` int(2) NOT NULL DEFAULT '1' COMMENT '虚拟成团',
  `mate_code` varchar(32) NOT NULL COMMENT '特征码',
  `is_delete` int(2) NOT NULL DEFAULT '0',
  `main_img` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_collage
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_collage` VALUES (18, 1530752944419263, '测试添测试添测试添测试添测\n试添测试添', '0.01', '9.99', 223, 2, '<p><strong><em><s><u>测试添加商品测试添加商品测试添加商品</u></s></em></strong></p>', 0, 2, 0, 1, '1533956075672', '3600000', 1, 'X0EGF0DGHHHQ2WXP30BAK', 0, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_collage_user
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_collage_user`;
CREATE TABLE `bbgshop_collage_user` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `collage_main` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `is_pay` int(8) DEFAULT '0' COMMENT '是否支付',
  `goodsid` bigint(32) NOT NULL COMMENT '商品id',
  `goods_name` varchar(256) NOT NULL DEFAULT '' COMMENT '商品名称',
  `collage_price` varchar(8) NOT NULL DEFAULT '0' COMMENT '底价',
  `retail_price` varchar(8) NOT NULL DEFAULT '0' COMMENT '商品原价',
  `most_init_num` int(8) NOT NULL DEFAULT '0' COMMENT '最多发起次数',
  `least_coll_num` int(8) NOT NULL DEFAULT '0' COMMENT '至少砍价人数',
  `is_abled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `create_time` varchar(32) DEFAULT '0' COMMENT '创建时间',
  `user_duration_time` varchar(32) DEFAULT NULL COMMENT '允许用户砍价持续时间',
  `virtual` int(2) NOT NULL DEFAULT '1' COMMENT '虚拟成团',
  `order_id` varchar(8) NOT NULL DEFAULT '' COMMENT '订单id',
  `goods_sku_id` int(5) NOT NULL,
  `goods_sku_value` varchar(64) NOT NULL,
  `is_success` int(2) NOT NULL DEFAULT '0',
  `end_time` varchar(32) NOT NULL DEFAULT '0',
  `pay_time` varchar(32) NOT NULL DEFAULT '0',
  `is_outtime` int(2) NOT NULL DEFAULT '0' COMMENT '超时',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_collage_user
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_collage_user` VALUES (66, 18, 42, 1, 1530752944419263, '测试添测试添测试添测试添测\n试添测试添', '0.01', '0.01', 223, 2, 1, '1534141730914', '3600000', 1, '718', 724, '1.1KG　1.1M　黄色', 0, '1534145346890', '1534141746890', 1);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_collage_user_friend
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_collage_user_friend`;
CREATE TABLE `bbgshop_collage_user_friend` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `collage_main` int(11) NOT NULL,
  `collage_user_tab_id` int(11) NOT NULL,
  `collage_user_id` int(11) NOT NULL,
  `user_in_id` int(11) NOT NULL COMMENT '用户id',
  `is_pay` int(8) DEFAULT '0' COMMENT '是否支付',
  `user_in_nickname` varchar(64) NOT NULL,
  `user_in_avatar` varchar(512) NOT NULL,
  `goodsid` bigint(32) NOT NULL COMMENT '商品id',
  `goods_name` varchar(256) NOT NULL DEFAULT '' COMMENT '商品名称',
  `collage_price` varchar(8) NOT NULL DEFAULT '0' COMMENT '底价',
  `retail_price` varchar(8) NOT NULL DEFAULT '0' COMMENT '商品原价',
  `most_init_num` int(8) NOT NULL DEFAULT '0' COMMENT '最多发起次数',
  `least_coll_num` int(8) NOT NULL DEFAULT '0' COMMENT '至少砍价人数',
  `is_abled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `virtual` int(2) NOT NULL DEFAULT '1' COMMENT '虚拟成团',
  `goods_sku_id` int(5) NOT NULL,
  `goods_sku_value` varchar(64) NOT NULL,
  `is_success` int(2) NOT NULL DEFAULT '0',
  `order_id` int(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_collect
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_collect`;
CREATE TABLE `bbgshop_collect` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `value_id` bigint(32) unsigned NOT NULL DEFAULT '0',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0',
  `is_attention` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否是关注',
  `type_id` int(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `goods_id` (`value_id`),
  KEY `is_attention` (`is_attention`)
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_comment
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_comment`;
CREATE TABLE `bbgshop_comment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `goods_id` bigint(28) unsigned NOT NULL DEFAULT '0',
  `product_id` int(16) unsigned NOT NULL DEFAULT '0',
  `content` varchar(6550) COLLATE utf8mb4_unicode_ci NOT NULL,
  `add_time` bigint(16) unsigned NOT NULL DEFAULT '0',
  `score` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '评分',
  `new_content` varchar(6550) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `product_value` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `order_id` int(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_value` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1070 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for bbgshop_comment_picture
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_comment_picture`;
CREATE TABLE `bbgshop_comment_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) unsigned NOT NULL DEFAULT '0',
  `pic_url` varchar(512) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_country_code_ali
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_country_code_ali`;
CREATE TABLE `bbgshop_country_code_ali` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `country_name_english` varchar(64) NOT NULL,
  `country_name_chinese` varchar(64) NOT NULL,
  `country_code` varchar(12) NOT NULL,
  `phone_code` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_country_code_ali
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_country_code_ali` VALUES (1, 'Afghanistan', '阿富汗', 'AF', '93');
INSERT INTO `bbgshop_country_code_ali` VALUES (2, 'Albania', '阿尔巴尼亚', 'AL', '355');
INSERT INTO `bbgshop_country_code_ali` VALUES (3, 'Algeria', '阿尔及利亚', 'DZ', '213');
INSERT INTO `bbgshop_country_code_ali` VALUES (4, 'American Samoa', '美属萨摩亚', 'AS', '1684');
INSERT INTO `bbgshop_country_code_ali` VALUES (5, 'Andorra', '安道尔', 'AD', '376');
INSERT INTO `bbgshop_country_code_ali` VALUES (6, 'Angola', '安哥拉', 'AO', '	244');
INSERT INTO `bbgshop_country_code_ali` VALUES (7, 'Anguilla', '安圭拉', 'AI', '1264');
INSERT INTO `bbgshop_country_code_ali` VALUES (8, 'Antigua and Barbuda', '安提瓜和巴布达', 'AG', '1268');
INSERT INTO `bbgshop_country_code_ali` VALUES (9, 'Argentina', '阿根廷', 'AR', '54');
INSERT INTO `bbgshop_country_code_ali` VALUES (10, 'Armenia', '亚美尼亚', 'AM', '374');
INSERT INTO `bbgshop_country_code_ali` VALUES (11, 'Aruba', '阿鲁巴', 'AW', '297');
INSERT INTO `bbgshop_country_code_ali` VALUES (12, 'Australia', '澳大利亚', 'AU', '61');
INSERT INTO `bbgshop_country_code_ali` VALUES (13, 'Austria', '奥地利', 'AT', '43');
INSERT INTO `bbgshop_country_code_ali` VALUES (14, 'Azerbaijan', '阿塞拜疆', 'AZ', '994');
INSERT INTO `bbgshop_country_code_ali` VALUES (15, 'Bahamas', '巴哈马', 'BS', '1242');
INSERT INTO `bbgshop_country_code_ali` VALUES (16, 'Bahrain', '巴林', 'BH', '973');
INSERT INTO `bbgshop_country_code_ali` VALUES (17, 'Bangladesh', '孟加拉国', 'BD', '880');
INSERT INTO `bbgshop_country_code_ali` VALUES (18, 'Barbados', '巴巴多斯', 'BB', '1246');
INSERT INTO `bbgshop_country_code_ali` VALUES (19, 'Belarus', '白俄罗斯', 'BY', '375');
INSERT INTO `bbgshop_country_code_ali` VALUES (20, 'Belgium', '比利时', 'BE', '32');
INSERT INTO `bbgshop_country_code_ali` VALUES (21, 'Belize', '伯利兹', 'BZ', '501');
INSERT INTO `bbgshop_country_code_ali` VALUES (22, 'Benin', '贝宁', 'BJ', '229');
INSERT INTO `bbgshop_country_code_ali` VALUES (23, 'Bermuda', '百慕大群岛', 'BM', '1441');
INSERT INTO `bbgshop_country_code_ali` VALUES (24, 'Bhutan', '不丹', 'BT', '975');
INSERT INTO `bbgshop_country_code_ali` VALUES (25, 'Bolivia', '玻利维亚', 'BO', '591');
INSERT INTO `bbgshop_country_code_ali` VALUES (26, 'Bosnia and Herzegovina', '波斯尼亚和黑塞哥维那', 'BA', '387');
INSERT INTO `bbgshop_country_code_ali` VALUES (27, 'Botswana', '博茨瓦纳', 'BW', '267');
INSERT INTO `bbgshop_country_code_ali` VALUES (28, 'Brazil', '巴西', 'BR', '55');
INSERT INTO `bbgshop_country_code_ali` VALUES (29, 'Brunei', '文莱', 'BN', '673');
INSERT INTO `bbgshop_country_code_ali` VALUES (30, 'Bulgaria', '保加利亚', 'BG', '359');
INSERT INTO `bbgshop_country_code_ali` VALUES (31, 'Burkina Faso', '布基纳法索', 'BF', '226');
INSERT INTO `bbgshop_country_code_ali` VALUES (32, 'Burundi', '布隆迪', 'BI', '257');
INSERT INTO `bbgshop_country_code_ali` VALUES (33, 'Cameroon', '喀麦隆', 'CM', '237');
INSERT INTO `bbgshop_country_code_ali` VALUES (34, 'Canada', '加拿大', 'CA', '1');
INSERT INTO `bbgshop_country_code_ali` VALUES (35, 'Cape Verde', '开普', 'CV', '238');
INSERT INTO `bbgshop_country_code_ali` VALUES (36, 'Cayman Islands', '开曼群岛', 'KY', '1345');
INSERT INTO `bbgshop_country_code_ali` VALUES (37, 'Central African Republic', '中非共和国', 'CF', '236');
INSERT INTO `bbgshop_country_code_ali` VALUES (38, 'Chad', '乍得', 'TD', '235');
INSERT INTO `bbgshop_country_code_ali` VALUES (39, 'Chile', '智利', 'CL', '56');
INSERT INTO `bbgshop_country_code_ali` VALUES (40, 'Colombia', '哥伦比亚', 'CO', '57');
INSERT INTO `bbgshop_country_code_ali` VALUES (41, 'Comoros', '科摩罗', 'KM', '269');
INSERT INTO `bbgshop_country_code_ali` VALUES (42, 'Cook Islands', '库克群岛', 'CK', '682');
INSERT INTO `bbgshop_country_code_ali` VALUES (43, 'Costa Rica', '哥斯达黎加', 'CR', '506');
INSERT INTO `bbgshop_country_code_ali` VALUES (44, 'Croatia', '克罗地亚', 'HR', '385');
INSERT INTO `bbgshop_country_code_ali` VALUES (45, 'Cuba', '古巴', 'CU', '53');
INSERT INTO `bbgshop_country_code_ali` VALUES (46, 'Curacao', '库拉索', 'CW', '599');
INSERT INTO `bbgshop_country_code_ali` VALUES (47, 'Cyprus', '塞浦路斯', 'CY', '357');
INSERT INTO `bbgshop_country_code_ali` VALUES (48, 'Czech', '捷克', 'CZ', '420');
INSERT INTO `bbgshop_country_code_ali` VALUES (49, 'Democratic Republic of the Congo', '刚果民主共和国', 'CD', '243');
INSERT INTO `bbgshop_country_code_ali` VALUES (50, 'Denmark', '丹麦', 'DK', '45');
INSERT INTO `bbgshop_country_code_ali` VALUES (51, 'Djibouti', '吉布提', 'DJ', '253');
INSERT INTO `bbgshop_country_code_ali` VALUES (52, 'Dominica', '多米尼加', 'DM', '1767');
INSERT INTO `bbgshop_country_code_ali` VALUES (53, 'Dominican Republic', '多米尼加共和国', 'DO', '1809');
INSERT INTO `bbgshop_country_code_ali` VALUES (54, 'East Timor', '东帝汶', 'TL', '670');
INSERT INTO `bbgshop_country_code_ali` VALUES (55, 'Ecuador', '厄瓜多尔', 'EC', '593');
INSERT INTO `bbgshop_country_code_ali` VALUES (56, 'Egypt', '埃及', 'EG', '20');
INSERT INTO `bbgshop_country_code_ali` VALUES (57, 'El Salvador', '萨尔瓦多', 'SV', '503');
INSERT INTO `bbgshop_country_code_ali` VALUES (58, 'Equatorial Guinea', '赤道几内亚', 'GQ', '240');
INSERT INTO `bbgshop_country_code_ali` VALUES (59, 'Eritrea', '厄立特里亚', 'ER', '291');
INSERT INTO `bbgshop_country_code_ali` VALUES (60, 'Estonia', '爱沙尼亚', 'EE', '372');
INSERT INTO `bbgshop_country_code_ali` VALUES (61, 'Ethiopia', '埃塞俄比亚', 'ET', '251');
INSERT INTO `bbgshop_country_code_ali` VALUES (62, 'Faroe Islands', '法罗群岛', 'FO', '298');
INSERT INTO `bbgshop_country_code_ali` VALUES (63, 'Fiji', '斐济', 'FJ', '679');
INSERT INTO `bbgshop_country_code_ali` VALUES (64, 'Finland', '芬兰', 'FI', '358');
INSERT INTO `bbgshop_country_code_ali` VALUES (65, 'France', '法国', 'FR', '33');
INSERT INTO `bbgshop_country_code_ali` VALUES (66, 'French Guiana', '法属圭亚那', 'GF', '594');
INSERT INTO `bbgshop_country_code_ali` VALUES (67, 'French Polynesia', '法属波利尼西亚', 'PF', '689');
INSERT INTO `bbgshop_country_code_ali` VALUES (68, 'Gabon', '加蓬', 'GA', '241');
INSERT INTO `bbgshop_country_code_ali` VALUES (69, 'Gambia', '冈比亚', 'GM', '220');
INSERT INTO `bbgshop_country_code_ali` VALUES (70, 'Georgia', '格鲁吉亚', 'GE', '995');
INSERT INTO `bbgshop_country_code_ali` VALUES (71, 'Germany', '德国', 'DE', '49');
INSERT INTO `bbgshop_country_code_ali` VALUES (72, 'Ghana', '加纳', 'GH', '233');
INSERT INTO `bbgshop_country_code_ali` VALUES (73, 'Gibraltar', '直布罗陀', 'GI', '350');
INSERT INTO `bbgshop_country_code_ali` VALUES (74, 'Greece', '希腊', 'GR', '30');
INSERT INTO `bbgshop_country_code_ali` VALUES (75, 'Greenland', '格陵兰岛', 'GL', '299');
INSERT INTO `bbgshop_country_code_ali` VALUES (76, 'Grenada', '格林纳达', 'GD', '1473');
INSERT INTO `bbgshop_country_code_ali` VALUES (77, 'Guadeloupe', '瓜德罗普岛', 'GP', '590');
INSERT INTO `bbgshop_country_code_ali` VALUES (78, 'Guam', '关岛', 'GU', '1671');
INSERT INTO `bbgshop_country_code_ali` VALUES (79, 'Guatemala', '瓜地马拉', 'GT', '502');
INSERT INTO `bbgshop_country_code_ali` VALUES (80, 'Guinea', '几内亚', 'GN', '224');
INSERT INTO `bbgshop_country_code_ali` VALUES (81, 'Guinea-Bissau', '几内亚比绍共和国', 'GW', '245');
INSERT INTO `bbgshop_country_code_ali` VALUES (82, 'Guyana', '圭亚那', 'GY', '592');
INSERT INTO `bbgshop_country_code_ali` VALUES (83, 'Haiti', '海地', 'HT', '509');
INSERT INTO `bbgshop_country_code_ali` VALUES (84, 'Honduras', '洪都拉斯', 'HN', '504');
INSERT INTO `bbgshop_country_code_ali` VALUES (85, 'Hong Kong', '中国香港', 'HK', '852');
INSERT INTO `bbgshop_country_code_ali` VALUES (86, 'Hungary', '匈牙利', 'HU', '36');
INSERT INTO `bbgshop_country_code_ali` VALUES (87, 'Iceland', '冰岛', 'IS', '354');
INSERT INTO `bbgshop_country_code_ali` VALUES (88, 'India', '印度', 'IN', '91');
INSERT INTO `bbgshop_country_code_ali` VALUES (89, 'Indonesia', '印度尼西亚', 'ID', '62');
INSERT INTO `bbgshop_country_code_ali` VALUES (90, 'Iran', '伊朗', 'IR', '98');
INSERT INTO `bbgshop_country_code_ali` VALUES (91, 'Iraq', '伊拉克', 'IQ', '964');
INSERT INTO `bbgshop_country_code_ali` VALUES (92, 'Ireland', '爱尔兰', 'IE', '353');
INSERT INTO `bbgshop_country_code_ali` VALUES (93, 'Israel', '以色列', 'IL', '972');
INSERT INTO `bbgshop_country_code_ali` VALUES (94, 'Italy', '意大利', 'IT', '39');
INSERT INTO `bbgshop_country_code_ali` VALUES (95, 'Ivory Coast', '象牙海岸', 'CI', '225');
INSERT INTO `bbgshop_country_code_ali` VALUES (96, 'Jamaica', '牙买加', 'JM', '1876');
INSERT INTO `bbgshop_country_code_ali` VALUES (97, 'Japan', '日本', 'JP', '81');
INSERT INTO `bbgshop_country_code_ali` VALUES (98, 'Jordan', '约旦', 'JO', '962');
INSERT INTO `bbgshop_country_code_ali` VALUES (99, 'Kazakhstan', '哈萨克斯坦', 'KZ', '7');
INSERT INTO `bbgshop_country_code_ali` VALUES (100, 'Kenya', '肯尼亚', 'KE', '254');
INSERT INTO `bbgshop_country_code_ali` VALUES (101, 'Kiribati', '基里巴斯', 'KI', '686');
INSERT INTO `bbgshop_country_code_ali` VALUES (102, 'Kuwait', '科威特', 'KW', '965');
INSERT INTO `bbgshop_country_code_ali` VALUES (103, 'Kyrgyzstan', '吉尔吉斯斯坦', 'KG', '996');
INSERT INTO `bbgshop_country_code_ali` VALUES (104, 'Laos', '老挝', 'LA', '856');
INSERT INTO `bbgshop_country_code_ali` VALUES (105, 'Latvia', '拉脱维亚', 'LV', '371');
INSERT INTO `bbgshop_country_code_ali` VALUES (106, 'Lebanon', '黎巴嫩', 'LB', '961');
INSERT INTO `bbgshop_country_code_ali` VALUES (107, 'Lesotho', '莱索托', 'LS', '266');
INSERT INTO `bbgshop_country_code_ali` VALUES (108, 'Liberia', '利比里亚', 'LR', '231');
INSERT INTO `bbgshop_country_code_ali` VALUES (109, 'Libya', '利比亚', 'LY', '218');
INSERT INTO `bbgshop_country_code_ali` VALUES (110, 'Liechtenstein', '列支敦士登', 'LI', '423');
INSERT INTO `bbgshop_country_code_ali` VALUES (111, 'Lithuania', '立陶宛', 'LT', '370');
INSERT INTO `bbgshop_country_code_ali` VALUES (112, 'Luxembourg', '卢森堡', 'LU', '352');
INSERT INTO `bbgshop_country_code_ali` VALUES (113, 'Macau', '中国澳门', 'MO', '853');
INSERT INTO `bbgshop_country_code_ali` VALUES (114, 'Macedonia', '马其顿', 'MK', '389');
INSERT INTO `bbgshop_country_code_ali` VALUES (115, 'Madagascar', '马达加斯加', 'MG', '261');
INSERT INTO `bbgshop_country_code_ali` VALUES (116, 'Malawi', '马拉维', 'MW', '265');
INSERT INTO `bbgshop_country_code_ali` VALUES (117, 'Malaysia', '马来西亚', 'MY', '60');
INSERT INTO `bbgshop_country_code_ali` VALUES (118, 'Maldives', '马尔代夫', 'MV', '960');
INSERT INTO `bbgshop_country_code_ali` VALUES (119, 'Mali', '马里', 'ML', '223');
INSERT INTO `bbgshop_country_code_ali` VALUES (120, 'Malta', '马耳他', 'MT', '356');
INSERT INTO `bbgshop_country_code_ali` VALUES (121, 'Martinique', '马提尼克', 'MQ', '596');
INSERT INTO `bbgshop_country_code_ali` VALUES (122, 'Mauritania', '毛里塔尼亚', 'MR', '222');
INSERT INTO `bbgshop_country_code_ali` VALUES (123, 'Mauritius', '毛里求斯', 'MU', '230');
INSERT INTO `bbgshop_country_code_ali` VALUES (124, 'Mayotte', '马约特', 'YT', '269');
INSERT INTO `bbgshop_country_code_ali` VALUES (125, 'Mexico', '墨西哥', 'MX', '52');
INSERT INTO `bbgshop_country_code_ali` VALUES (126, 'Moldova', '摩尔多瓦', 'MD', '373');
INSERT INTO `bbgshop_country_code_ali` VALUES (127, 'Monaco', '摩纳哥', 'MC', '377');
INSERT INTO `bbgshop_country_code_ali` VALUES (128, 'Mongolia', '蒙古', 'MN', '976');
INSERT INTO `bbgshop_country_code_ali` VALUES (129, 'Montenegro', '黑山', 'ME', '382');
INSERT INTO `bbgshop_country_code_ali` VALUES (130, 'Montserrat', '蒙特塞拉特岛', 'MS', '1664');
INSERT INTO `bbgshop_country_code_ali` VALUES (131, 'Morocco', '摩洛哥', 'MA', '212');
INSERT INTO `bbgshop_country_code_ali` VALUES (132, 'Mozambique', '莫桑比克', 'MZ', '258');
INSERT INTO `bbgshop_country_code_ali` VALUES (133, 'Myanmar', '缅甸', 'MM', '95');
INSERT INTO `bbgshop_country_code_ali` VALUES (134, 'Namibia', '纳米比亚', 'NA', '264');
INSERT INTO `bbgshop_country_code_ali` VALUES (135, 'Nepal', '尼泊尔', 'NP', '977');
INSERT INTO `bbgshop_country_code_ali` VALUES (136, 'Netherlands', '荷兰', 'NL', '31');
INSERT INTO `bbgshop_country_code_ali` VALUES (137, 'New Caledonia', '新喀里多尼亚', 'NC', '687');
INSERT INTO `bbgshop_country_code_ali` VALUES (138, 'New Zealand', '新西兰', 'NZ', '64');
INSERT INTO `bbgshop_country_code_ali` VALUES (139, 'Nicaragua', '尼加拉瓜', 'NI', '505');
INSERT INTO `bbgshop_country_code_ali` VALUES (140, 'Niger', '尼日尔', 'NE', '227');
INSERT INTO `bbgshop_country_code_ali` VALUES (141, 'Nigeria', '尼日利亚', 'NG', '234');
INSERT INTO `bbgshop_country_code_ali` VALUES (142, 'Norway', '挪威', 'NO', '47');
INSERT INTO `bbgshop_country_code_ali` VALUES (143, 'Oman', '阿曼', 'OM', '968');
INSERT INTO `bbgshop_country_code_ali` VALUES (144, 'Pakistan', '巴基斯坦', 'PK', '92');
INSERT INTO `bbgshop_country_code_ali` VALUES (145, 'Palau', '帕劳', 'PW', '680');
INSERT INTO `bbgshop_country_code_ali` VALUES (146, 'Palestine', '巴勒斯坦', 'BL', '970');
INSERT INTO `bbgshop_country_code_ali` VALUES (147, 'Panama', '巴拿马', 'PA', '507');
INSERT INTO `bbgshop_country_code_ali` VALUES (148, 'Papua New Guinea', '巴布亚新几内亚', 'PG', '675');
INSERT INTO `bbgshop_country_code_ali` VALUES (149, 'Paraguay', '巴拉圭', 'PY', '595');
INSERT INTO `bbgshop_country_code_ali` VALUES (150, 'Peru', '秘鲁', 'PE', '51');
INSERT INTO `bbgshop_country_code_ali` VALUES (151, 'Philippines', '菲律宾', 'PH', '63');
INSERT INTO `bbgshop_country_code_ali` VALUES (152, 'Poland', '波兰', 'PL', '48');
INSERT INTO `bbgshop_country_code_ali` VALUES (153, 'Portugal', '葡萄牙', 'PT', '351');
INSERT INTO `bbgshop_country_code_ali` VALUES (154, 'Puerto Rico', '波多黎各', 'PR', '1787');
INSERT INTO `bbgshop_country_code_ali` VALUES (155, 'Qatar', '卡塔尔', 'QA', '974');
INSERT INTO `bbgshop_country_code_ali` VALUES (156, 'Republic Of The Congo', '刚果共和国', 'CG', '242');
INSERT INTO `bbgshop_country_code_ali` VALUES (157, 'Réunion Island', '留尼汪', 'RE', '262');
INSERT INTO `bbgshop_country_code_ali` VALUES (158, 'Romania', '罗马尼亚', 'RO', '40');
INSERT INTO `bbgshop_country_code_ali` VALUES (159, 'Russia', '俄罗斯', 'RU', '7');
INSERT INTO `bbgshop_country_code_ali` VALUES (160, 'Rwanda', '卢旺达', 'RW', '250');
INSERT INTO `bbgshop_country_code_ali` VALUES (161, 'Saint Kitts and Nevis', '圣基茨和尼维斯', 'KN', '1869');
INSERT INTO `bbgshop_country_code_ali` VALUES (162, 'Saint Lucia', '圣露西亚', 'LC', '1758');
INSERT INTO `bbgshop_country_code_ali` VALUES (163, 'Saint Pierre and Miquelon', '圣彼埃尔和密克隆岛', 'PM', '508');
INSERT INTO `bbgshop_country_code_ali` VALUES (164, 'Saint Vincent and The Grenadines', '圣文森特和格林纳丁斯', 'VC', '1784');
INSERT INTO `bbgshop_country_code_ali` VALUES (165, 'Samoa', '萨摩亚', 'WS', '685');
INSERT INTO `bbgshop_country_code_ali` VALUES (166, 'San Marino', '圣马力诺', 'SM', '378');
INSERT INTO `bbgshop_country_code_ali` VALUES (167, 'Sao Tome and Principe', '圣多美和普林西比', 'ST', '239');
INSERT INTO `bbgshop_country_code_ali` VALUES (168, 'Saudi Arabia', '沙特阿拉伯', 'SA', '966');
INSERT INTO `bbgshop_country_code_ali` VALUES (169, 'Senegal', '塞内加尔', 'SN', '221');
INSERT INTO `bbgshop_country_code_ali` VALUES (170, 'Serbia', '塞尔维亚', 'RS', '381');
INSERT INTO `bbgshop_country_code_ali` VALUES (171, 'Seychelles', '塞舌尔', 'SC', '248');
INSERT INTO `bbgshop_country_code_ali` VALUES (172, 'Sierra Leone', '塞拉利昂', 'SL', '232');
INSERT INTO `bbgshop_country_code_ali` VALUES (173, 'Singapore', '新加坡', 'SG', '65');
INSERT INTO `bbgshop_country_code_ali` VALUES (174, 'Sint Maarten (Dutch Part)', '圣马丁岛（荷兰部分）', 'SX', '1721');
INSERT INTO `bbgshop_country_code_ali` VALUES (175, 'Slovakia', '斯洛伐克', 'SK', '421');
INSERT INTO `bbgshop_country_code_ali` VALUES (176, 'Slovenia', '斯洛文尼亚', 'SI', '386');
INSERT INTO `bbgshop_country_code_ali` VALUES (177, 'Solomon Islands', '所罗门群岛', 'SB', '677');
INSERT INTO `bbgshop_country_code_ali` VALUES (178, 'Somalia', '索马里', 'SO', '252');
INSERT INTO `bbgshop_country_code_ali` VALUES (179, 'South Africa', '南非', 'ZA', '27');
INSERT INTO `bbgshop_country_code_ali` VALUES (180, 'South Korea', '韩国', 'KR', '82');
INSERT INTO `bbgshop_country_code_ali` VALUES (181, 'Spain', '西班牙', 'ES', '34');
INSERT INTO `bbgshop_country_code_ali` VALUES (182, 'Sri Lanka', '斯里兰卡', 'LK', '94');
INSERT INTO `bbgshop_country_code_ali` VALUES (183, 'Sudan', '苏丹', 'SD', '249');
INSERT INTO `bbgshop_country_code_ali` VALUES (184, 'Suriname', '苏里南', 'SR', '597');
INSERT INTO `bbgshop_country_code_ali` VALUES (185, 'Swaziland', '斯威士兰', 'SZ', '268');
INSERT INTO `bbgshop_country_code_ali` VALUES (186, 'Sweden', '瑞典', 'SE', '46');
INSERT INTO `bbgshop_country_code_ali` VALUES (187, 'Switzerland', '瑞士', 'CH', '41');
INSERT INTO `bbgshop_country_code_ali` VALUES (188, 'Syria', '叙利亚', 'SY', '963');
INSERT INTO `bbgshop_country_code_ali` VALUES (189, 'Taiwan', '中国台湾', 'TW', '886');
INSERT INTO `bbgshop_country_code_ali` VALUES (190, 'Tajikistan', '塔吉克斯坦', 'TJ', '992');
INSERT INTO `bbgshop_country_code_ali` VALUES (191, 'Tanzania', '坦桑尼亚', 'TZ', '255');
INSERT INTO `bbgshop_country_code_ali` VALUES (192, 'Thailand', '泰国', 'TH', '66');
INSERT INTO `bbgshop_country_code_ali` VALUES (193, 'Timor-Leste', '东帝汶', 'TL', '670');
INSERT INTO `bbgshop_country_code_ali` VALUES (194, 'Togo', '多哥', 'TG', '228');
INSERT INTO `bbgshop_country_code_ali` VALUES (195, 'Tonga', '汤加', 'TO', '676');
INSERT INTO `bbgshop_country_code_ali` VALUES (196, 'Trinidad and Tobago', '特立尼达和多巴哥', 'TT', '1868');
INSERT INTO `bbgshop_country_code_ali` VALUES (197, 'Tunisia', '突尼斯', 'TN', '216');
INSERT INTO `bbgshop_country_code_ali` VALUES (198, 'Turkey', '土耳其', 'TR', '90');
INSERT INTO `bbgshop_country_code_ali` VALUES (199, 'Turkmenistan', '土库曼斯坦', 'TM', '993');
INSERT INTO `bbgshop_country_code_ali` VALUES (200, 'Turks and Caicos Islands', '特克斯和凯科斯群岛	', 'TC', '1649');
INSERT INTO `bbgshop_country_code_ali` VALUES (201, 'Uganda', '乌干达', 'UG', '256');
INSERT INTO `bbgshop_country_code_ali` VALUES (202, 'Ukraine', '乌克兰', 'UA', '380');
INSERT INTO `bbgshop_country_code_ali` VALUES (203, 'United Arab Emirates', '阿拉伯联合酋长国', 'AE', '971');
INSERT INTO `bbgshop_country_code_ali` VALUES (204, 'United Kingdom', '英国', 'GB', '44');
INSERT INTO `bbgshop_country_code_ali` VALUES (205, 'United States', '美国', 'US', '1');
INSERT INTO `bbgshop_country_code_ali` VALUES (206, 'Uruguay', '乌拉圭', 'UY', '598');
INSERT INTO `bbgshop_country_code_ali` VALUES (207, 'Uzbekistan', '乌兹别克斯坦', 'UZ', '998');
INSERT INTO `bbgshop_country_code_ali` VALUES (208, 'Vanuatu', '瓦努阿图', 'VU', '678');
INSERT INTO `bbgshop_country_code_ali` VALUES (209, 'Venezuela', '委内瑞拉', 'VE', '58');
INSERT INTO `bbgshop_country_code_ali` VALUES (210, 'Vietnam', '越南', 'VN', '84');
INSERT INTO `bbgshop_country_code_ali` VALUES (211, 'Virgin Islands, British', '英属处女群岛', 'VG', '1340');
INSERT INTO `bbgshop_country_code_ali` VALUES (212, 'Virgin Islands, US', '美属维尔京群岛', 'VI', '1284');
INSERT INTO `bbgshop_country_code_ali` VALUES (213, 'Yemen', '也门', 'YE', '967');
INSERT INTO `bbgshop_country_code_ali` VALUES (214, 'Zambia', '赞比亚', 'ZM', '260');
INSERT INTO `bbgshop_country_code_ali` VALUES (215, 'Zimbabwe', '津巴布韦', 'ZW', '263');
INSERT INTO `bbgshop_country_code_ali` VALUES (216, 'china', '中国', 'CH', '86');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_coupon_main
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_coupon_main`;
CREATE TABLE `bbgshop_coupon_main` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '优惠券的id',
  `coupon_isabled` int(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `coupon_id` varchar(16) NOT NULL COMMENT '优惠券id',
  `obtained_num` int(11) NOT NULL DEFAULT '0' COMMENT '已被获取的数量',
  `coupon_name` varchar(64) NOT NULL COMMENT '优惠券名字',
  `coupon_number` int(8) NOT NULL COMMENT '优惠券数量',
  `coupon_type` int(1) NOT NULL DEFAULT '0' COMMENT '优惠券类型（0为指定金额，1为折扣）',
  `coupon_value` decimal(10,2) NOT NULL COMMENT '优惠券减免金额或折扣量',
  `coupon_limit` int(1) NOT NULL DEFAULT '0' COMMENT '优惠券使用门槛（0为无限制，1为限制）',
  `coupon_limit_value` decimal(10,2) NOT NULL COMMENT '优惠券使用门槛金额',
  `coupon_user_getnumber` int(2) NOT NULL COMMENT '每人限领',
  `validity_type` int(1) NOT NULL DEFAULT '0' COMMENT '有效期类型（0为固定，1为当日，2为次日）',
  `validity_create` varchar(32) NOT NULL COMMENT '优惠券添加时间',
  `validity_start` varchar(32) DEFAULT NULL COMMENT '有效期开始时间',
  `validity_end` varchar(32) DEFAULT NULL COMMENT '有效期结束时间',
  `point_goods` varchar(99) NOT NULL COMMENT '指定商品',
  `point_user` varchar(99) NOT NULL COMMENT '指定用户',
  `Instructions` tinytext NOT NULL COMMENT '使用说明',
  `validity_limit_day` varchar(32) NOT NULL DEFAULT '0' COMMENT '限制天数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_coupon_main
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_coupon_main` VALUES (64, 1, '7N5EW8EKAJH', 1, '123', 123, 0, 123.00, 1, 23.00, 1, 1, '1533955937232', '', '', '', '', '123', '172800000');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_coupon_user
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_coupon_user`;
CREATE TABLE `bbgshop_coupon_user` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '优惠券的id',
  `user_id` int(8) NOT NULL COMMENT '能使用的用户id',
  `coupon_id` varchar(16) NOT NULL,
  `coupon_name` varchar(256) NOT NULL COMMENT '优惠券名字',
  `coupon_number` int(5) NOT NULL COMMENT '优惠券数量',
  `coupon_type` int(1) NOT NULL DEFAULT '0' COMMENT '优惠券类型（0为指定金额，1为折扣）',
  `coupon_value` decimal(10,2) NOT NULL COMMENT '优惠券减免金额或折扣量',
  `coupon_limit` int(1) NOT NULL DEFAULT '0' COMMENT '优惠券使用门槛（0为无限制，1为限制）',
  `coupon_limit_value` decimal(10,2) NOT NULL COMMENT '优惠券使用门槛金额',
  `coupon_user_getnumber` int(2) NOT NULL COMMENT '每人限领',
  `validity_type` int(1) NOT NULL DEFAULT '0' COMMENT '有效期类型（0为固定，1为当日，2为次日）',
  `validity_create` varchar(32) NOT NULL COMMENT '优惠券添加时间',
  `validity_start` varchar(32) NOT NULL COMMENT '有效期开始时间',
  `validity_end` varchar(32) NOT NULL COMMENT '有效期结束时间',
  `point_goods` varchar(256) NOT NULL COMMENT '指定商品',
  `point_user` varchar(256) NOT NULL COMMENT '指定用户',
  `Instructions` tinytext NOT NULL COMMENT '使用说明',
  `used_time` varchar(16) NOT NULL DEFAULT '0',
  `used_type` int(1) NOT NULL DEFAULT '0' COMMENT '0未使用 1已使用 2已过期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_coupon_user
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_coupon_user` VALUES (64, 42, '7N5EW8EKAJH', '123', 123, 0, 123.00, 1, 23.00, 1, 1, '1533955937232', '1533956050700', '1534128850700', '', '', '123', '1533957850703', 2);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_distribution_apply
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_distribution_apply`;
CREATE TABLE `bbgshop_distribution_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_mobile` varchar(20) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_name` varchar(512) NOT NULL DEFAULT '0',
  `apply_time` varchar(64) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '0',
  `handel_time` varchar(32) NOT NULL DEFAULT '0',
  `mobile_country` varchar(64) DEFAULT NULL,
  `mobile_country_code` varchar(64) DEFAULT NULL,
  `mobile_code` varchar(64) DEFAULT NULL,
  `mobile_country_e` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_distribution_apply
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_distribution_apply` VALUES (16, '18020525538', 42, '余生与诗 ', '1534210435672', 1, '1534210441326', '特克斯和凯科斯群岛	', 'TC', '1649', 'Turks and Caicos Islands');
INSERT INTO `bbgshop_distribution_apply` VALUES (17, '', 43, 'ceshi', '0', 0, '0', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_distribution_cash
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_distribution_cash`;
CREATE TABLE `bbgshop_distribution_cash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(256) NOT NULL,
  `befor_catch` decimal(10,2) NOT NULL DEFAULT '0.00',
  `catch_money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `after_catch` decimal(10,2) NOT NULL DEFAULT '0.00',
  `is_success` int(1) NOT NULL DEFAULT '0',
  `add_time` varchar(32) NOT NULL DEFAULT '0',
  `handel_time` varchar(32) NOT NULL DEFAULT '0',
  `pay_success_time` varchar(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_distribution_cash_order
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_distribution_cash_order`;
CREATE TABLE `bbgshop_distribution_cash_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` varchar(32) NOT NULL DEFAULT '0',
  `mch_appid` varchar(32) NOT NULL DEFAULT '0',
  `mchid` int(32) NOT NULL DEFAULT '0',
  `nonce_str` varchar(512) DEFAULT '0',
  `sign` varchar(512) DEFAULT '0',
  `partner_trade_no` varchar(32) NOT NULL DEFAULT '0',
  `openid` varchar(32) NOT NULL DEFAULT '0',
  `amount` int(32) NOT NULL DEFAULT '0',
  `desc` varchar(512) NOT NULL,
  `spbill_create_ip` varchar(32) NOT NULL DEFAULT '127.0.0.1',
  `check_name` varchar(28) NOT NULL DEFAULT '0',
  `cash_id` int(12) NOT NULL DEFAULT '0',
  `cash_type` int(11) NOT NULL DEFAULT '0',
  `card_code` varchar(64) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_nickname` varchar(128) DEFAULT NULL,
  `card_bank_name` varchar(128) DEFAULT NULL,
  `card_bank_code` varchar(128) DEFAULT NULL,
  `true_name` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_distribution_goods
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_distribution_goods`;
CREATE TABLE `bbgshop_distribution_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(8) NOT NULL DEFAULT '0',
  `order_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `children_id` int(11) NOT NULL DEFAULT '0',
  `children_name` varchar(256) NOT NULL DEFAULT '0',
  `add_time` varchar(64) NOT NULL DEFAULT '0',
  `farther_user_id` int(11) NOT NULL DEFAULT '0',
  `farther_user_name` varchar(256) NOT NULL DEFAULT ' - -',
  `withdraw_cash` decimal(10,2) NOT NULL DEFAULT '0.00',
  `dis_type` varchar(32) NOT NULL COMMENT '一次分销或二次分销',
  `dis_rate` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '分销率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_distribution_goods
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_distribution_goods` VALUES (62, 709, 351.00, 42, '余生与诗 ', '1534406221953', 42, '余生与诗 ', 7.83, '自身提成', 2.23);
INSERT INTO `bbgshop_distribution_goods` VALUES (63, 709, 351.00, 42, '余生与诗 ', '1534406222007', 43, 'ceshi', 42.12, '二次分销', 12.00);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_distribution_main
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_distribution_main`;
CREATE TABLE `bbgshop_distribution_main` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_mobile` varchar(20) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_name` varchar(512) NOT NULL DEFAULT '0',
  `children_have_deal_money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `add_time` varchar(64) NOT NULL DEFAULT '0',
  `can_withdraw_cash` decimal(10,2) NOT NULL DEFAULT '0.00',
  `have_deal_order_num` int(11) NOT NULL DEFAULT '0',
  `secret_code` varchar(32) NOT NULL DEFAULT '0',
  `have_deal_order_id` varchar(15280) NOT NULL DEFAULT '0',
  `have_withdraw_cash` decimal(10,2) NOT NULL DEFAULT '0.00',
  `have_catch_num` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_distribution_main
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_distribution_main` VALUES (21, '18020525538', 42, '余生与诗 ', 351.00, '1534210441336', 7.83, 1, 'vzkh6bcenki', '0,709', 0.00, 0);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_distribution_rate
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_distribution_rate`;
CREATE TABLE `bbgshop_distribution_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate` varchar(32) NOT NULL DEFAULT '0.1' COMMENT '利率',
  `ownrate` varchar(32) NOT NULL DEFAULT '0.00',
  `secondrate` varchar(32) NOT NULL DEFAULT '0.0',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `rules_text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_distribution_rate
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_distribution_rate` VALUES (1, '10.00', '2.23', '12.00', 0.00, '<p>小伙伴，欢迎加入我们</p><p>我们是贝堡全球购的运营团队，竭诚为你的销售工作提供完善的支持。</p><p>我们诚挚邀请你加入我们的销售员推广计划，无任何成本即可成为贝堡全球购的销售 员，一起分享收获的喜悦。你只需将高品质商品分享推荐给他人，收获他人的感谢的同时，挣得属于自己的利润。</p><h2>1. 业绩说明</h2><p>1）买家通过销售员分享链接成交，即算作销售员的业绩；</p><p>2）订单交易完成前发生退款的订单，相应的销售员业绩将扣除相应的退款金额；</p><p>3）仅在线支付的订单算作业绩，不包括货到付款订单。</p><h2>2. 结算说明</h2><p>1）推广商品，获得8%的业绩提成；</p><p>2）另外，邀请他人成为分销员，您可以终身获得额外的2%邀请佣金分成；</p><h2>3. 其他说明</h2><p>1）分享前，请确定商品页面有 分享 按钮 （只有在商品详情页分享才有效）；</p><p>2）销售过程中有任何疑问，请直接在微信公众号内询问或直接致电；</p><p>3）已售出商品的任何售后问题，由本商城处理；</p><p>4）不传播或者扩散有关于政治、色情等任何违法的信息，一经发现，直接踢你出局，如果触犯任何法律相关问题，商城不负任何责任；</p><p>5）以上内容解释权归本商城所有。</p><p><br></p><h2>4. 联系方式</h2><p>1）联络人：缪经理</p><p>2）手机：0519-89888898</p><p><br></p><p>无论是销售、对账，还是结算问题，请通过以上方式咨询。</p>');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_distribution_user
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_distribution_user`;
CREATE TABLE `bbgshop_distribution_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `children_id` int(11) NOT NULL DEFAULT '0',
  `children_name` varchar(256) NOT NULL DEFAULT '0',
  `add_time` varchar(64) NOT NULL DEFAULT '0',
  `farther_user_id` int(11) NOT NULL DEFAULT '0',
  `farther_user_name` varchar(256) NOT NULL DEFAULT ' - -',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_distribution_user
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_distribution_user` VALUES (11, 42, '余生与诗 ', '1534406221971', 43, 'ceshi');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_feedback
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_feedback`;
CREATE TABLE `bbgshop_feedback` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `msg_type` varchar(10) NOT NULL DEFAULT '',
  `msg_content` text NOT NULL,
  `user_mobile` varchar(60) NOT NULL DEFAULT '',
  `msg_time` varchar(32) NOT NULL DEFAULT '0',
  `user_name` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_feedback
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_feedback` VALUES (21, 14, '功能异常', '功能不是很完善', '18020525538', '2018-3-29 12:37:52', '余生与诗 ');
INSERT INTO `bbgshop_feedback` VALUES (26, 0, '商品相关', '请问 请问人情味r', '18020525538', '2018-6-5 10:15:33', '匿名用户');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_footprint
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_footprint`;
CREATE TABLE `bbgshop_footprint` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `goods_id` bigint(32) NOT NULL DEFAULT '0',
  `add_time` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4473 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_footprint
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_footprint` VALUES (1815, 32, 113262, 1524879211);
INSERT INTO `bbgshop_footprint` VALUES (1816, 32, 42827, 1524879504);
INSERT INTO `bbgshop_footprint` VALUES (1817, 32, 113262, 1524880083);
INSERT INTO `bbgshop_footprint` VALUES (1818, 32, 42827, 1524880197);
INSERT INTO `bbgshop_footprint` VALUES (1819, 32, 42827, 1524880267);
INSERT INTO `bbgshop_footprint` VALUES (1820, 32, 42827, 1524880346);
INSERT INTO `bbgshop_footprint` VALUES (1821, 32, 113262, 1524899743);
INSERT INTO `bbgshop_footprint` VALUES (1822, 32, 42827, 1524899763);
INSERT INTO `bbgshop_footprint` VALUES (1823, 32, 113262, 1524899776);
INSERT INTO `bbgshop_footprint` VALUES (1824, 32, 841662, 1524899777);
INSERT INTO `bbgshop_footprint` VALUES (1825, 32, 19647, 1524899813);
INSERT INTO `bbgshop_footprint` VALUES (1826, 32, 86982, 1524899831);
INSERT INTO `bbgshop_footprint` VALUES (1827, 32, 19647, 1524899839);
INSERT INTO `bbgshop_footprint` VALUES (1828, 32, 113262, 1524899846);
INSERT INTO `bbgshop_footprint` VALUES (1829, 32, 42827, 1524899853);
INSERT INTO `bbgshop_footprint` VALUES (1830, 32, 841662, 1524899861);
INSERT INTO `bbgshop_footprint` VALUES (1831, 32, 841662, 1524900284);
INSERT INTO `bbgshop_footprint` VALUES (1832, 32, 113262, 1524900301);
INSERT INTO `bbgshop_footprint` VALUES (1833, 32, 42827, 1524900307);
INSERT INTO `bbgshop_footprint` VALUES (1834, 32, 42827, 1524900321);
INSERT INTO `bbgshop_footprint` VALUES (1835, 32, 841662, 1524900359);
INSERT INTO `bbgshop_footprint` VALUES (1836, 32, 284518, 1524900370);
INSERT INTO `bbgshop_footprint` VALUES (1837, 32, 11154, 1524900375);
INSERT INTO `bbgshop_footprint` VALUES (1838, 32, 113262, 1524900383);
INSERT INTO `bbgshop_footprint` VALUES (1839, 32, 42827, 1524900394);
INSERT INTO `bbgshop_footprint` VALUES (1840, 32, 86982, 1524901809);
INSERT INTO `bbgshop_footprint` VALUES (1841, 32, 1258, 1524901817);
INSERT INTO `bbgshop_footprint` VALUES (1842, 32, 841662, 1524901835);
INSERT INTO `bbgshop_footprint` VALUES (1843, 32, 841662, 1524902050);
INSERT INTO `bbgshop_footprint` VALUES (1844, 32, 113262, 1524902060);
INSERT INTO `bbgshop_footprint` VALUES (1845, 32, 1258, 1524902603);
INSERT INTO `bbgshop_footprint` VALUES (1846, 32, 1258, 1524902623);
INSERT INTO `bbgshop_footprint` VALUES (1847, 32, 42827, 1524905664);
INSERT INTO `bbgshop_footprint` VALUES (1848, 34, 813924, 1525316187);
INSERT INTO `bbgshop_footprint` VALUES (1849, 34, 841662, 1525316193);
INSERT INTO `bbgshop_footprint` VALUES (1850, 34, 841662, 1525316264);
INSERT INTO `bbgshop_footprint` VALUES (1851, 34, 636004, 1525316271);
INSERT INTO `bbgshop_footprint` VALUES (1852, 32, 841662, 1525330626);
INSERT INTO `bbgshop_footprint` VALUES (1853, 32, 622336, 1525330631);
INSERT INTO `bbgshop_footprint` VALUES (1854, 34, 841662, 1525331011);
INSERT INTO `bbgshop_footprint` VALUES (1855, 34, 841662, 1525331038);
INSERT INTO `bbgshop_footprint` VALUES (1856, 34, 1258, 1525331057);
INSERT INTO `bbgshop_footprint` VALUES (1857, 34, 841662, 1525331417);
INSERT INTO `bbgshop_footprint` VALUES (1858, 34, 240350, 1525331592);
INSERT INTO `bbgshop_footprint` VALUES (1859, 34, 86982, 1525331607);
INSERT INTO `bbgshop_footprint` VALUES (1860, 34, 240350, 1525333214);
INSERT INTO `bbgshop_footprint` VALUES (1861, 34, 19647, 1525333222);
INSERT INTO `bbgshop_footprint` VALUES (1862, 34, 86982, 1525333224);
INSERT INTO `bbgshop_footprint` VALUES (1863, 34, 369000, 1525333233);
INSERT INTO `bbgshop_footprint` VALUES (1864, 34, 19647, 1525338584);
INSERT INTO `bbgshop_footprint` VALUES (1865, 34, 240350, 1525395827);
INSERT INTO `bbgshop_footprint` VALUES (1866, 34, 86982, 1525395872);
INSERT INTO `bbgshop_footprint` VALUES (1867, 34, 240350, 1525395897);
INSERT INTO `bbgshop_footprint` VALUES (1868, 34, 19647, 1525395968);
INSERT INTO `bbgshop_footprint` VALUES (1869, 34, 1258, 1525396236);
INSERT INTO `bbgshop_footprint` VALUES (1870, 34, 86982, 1525396720);
INSERT INTO `bbgshop_footprint` VALUES (1871, 34, 1258, 1525397031);
INSERT INTO `bbgshop_footprint` VALUES (1872, 34, 1258, 1525397494);
INSERT INTO `bbgshop_footprint` VALUES (1873, 34, 1258, 1525397623);
INSERT INTO `bbgshop_footprint` VALUES (1874, 34, 1258, 1525397656);
INSERT INTO `bbgshop_footprint` VALUES (1875, 34, 813924, 1525397748);
INSERT INTO `bbgshop_footprint` VALUES (1876, 34, 369000, 1525397859);
INSERT INTO `bbgshop_footprint` VALUES (1877, 34, 19647, 1525398668);
INSERT INTO `bbgshop_footprint` VALUES (1878, 34, 369000, 1525398764);
INSERT INTO `bbgshop_footprint` VALUES (1879, 34, 86982, 1525399141);
INSERT INTO `bbgshop_footprint` VALUES (1880, 34, 240350, 1525399199);
INSERT INTO `bbgshop_footprint` VALUES (1881, 34, 240350, 1525399355);
INSERT INTO `bbgshop_footprint` VALUES (1882, 34, 86982, 1525399405);
INSERT INTO `bbgshop_footprint` VALUES (1883, 34, 369000, 1525399427);
INSERT INTO `bbgshop_footprint` VALUES (1884, 34, 622336, 1525399494);
INSERT INTO `bbgshop_footprint` VALUES (1885, 34, 622336, 1525399580);
INSERT INTO `bbgshop_footprint` VALUES (1886, 34, 622336, 1525399715);
INSERT INTO `bbgshop_footprint` VALUES (1887, 34, 19647, 1525404053);
INSERT INTO `bbgshop_footprint` VALUES (1888, 34, 369904, 1525404227);
INSERT INTO `bbgshop_footprint` VALUES (1889, 34, 67743, 1525404298);
INSERT INTO `bbgshop_footprint` VALUES (1890, 34, 369000, 1525404396);
INSERT INTO `bbgshop_footprint` VALUES (1891, 34, 813924, 1525404532);
INSERT INTO `bbgshop_footprint` VALUES (1892, 34, 86982, 1525407711);
INSERT INTO `bbgshop_footprint` VALUES (1893, 34, 240350, 1525407916);
INSERT INTO `bbgshop_footprint` VALUES (1894, 34, 19647, 1525407975);
INSERT INTO `bbgshop_footprint` VALUES (1895, 34, 841662, 1525408135);
INSERT INTO `bbgshop_footprint` VALUES (1896, 34, 113262, 1525408142);
INSERT INTO `bbgshop_footprint` VALUES (1897, 34, 42827, 1525408167);
INSERT INTO `bbgshop_footprint` VALUES (1898, 34, 841662, 1525408449);
INSERT INTO `bbgshop_footprint` VALUES (1899, 34, 841662, 1525409510);
INSERT INTO `bbgshop_footprint` VALUES (1900, 34, 42827, 1525409541);
INSERT INTO `bbgshop_footprint` VALUES (1901, 34, 113262, 1525409615);
INSERT INTO `bbgshop_footprint` VALUES (1902, 34, 42827, 1525409631);
INSERT INTO `bbgshop_footprint` VALUES (1903, 34, 42827, 1525409647);
INSERT INTO `bbgshop_footprint` VALUES (1904, 34, 42827, 1525409667);
INSERT INTO `bbgshop_footprint` VALUES (1905, 34, 113262, 1525409963);
INSERT INTO `bbgshop_footprint` VALUES (1906, 34, 841662, 1525409969);
INSERT INTO `bbgshop_footprint` VALUES (1907, 34, 113262, 1525411812);
INSERT INTO `bbgshop_footprint` VALUES (1908, 34, 113262, 1525411826);
INSERT INTO `bbgshop_footprint` VALUES (1909, 34, 841662, 1525411836);
INSERT INTO `bbgshop_footprint` VALUES (1910, 34, 19647, 1525411846);
INSERT INTO `bbgshop_footprint` VALUES (1911, 34, 19647, 1525411883);
INSERT INTO `bbgshop_footprint` VALUES (1912, 34, 1258, 1525412042);
INSERT INTO `bbgshop_footprint` VALUES (1913, 32, 240350, 1525412883);
INSERT INTO `bbgshop_footprint` VALUES (1914, 32, 240350, 1525413006);
INSERT INTO `bbgshop_footprint` VALUES (1915, 34, 19647, 1525413076);
INSERT INTO `bbgshop_footprint` VALUES (1916, 34, 369904, 1525413746);
INSERT INTO `bbgshop_footprint` VALUES (1917, 34, 369000, 1525413781);
INSERT INTO `bbgshop_footprint` VALUES (1918, 34, 15254143629539, 1525414377);
INSERT INTO `bbgshop_footprint` VALUES (1919, 34, 113262, 1525414512);
INSERT INTO `bbgshop_footprint` VALUES (1920, 32, 93860, 1525415791);
INSERT INTO `bbgshop_footprint` VALUES (1921, 34, 93860, 1525415838);
INSERT INTO `bbgshop_footprint` VALUES (1922, 34, 90706, 1525420957);
INSERT INTO `bbgshop_footprint` VALUES (1923, 34, 104223, 1525420987);
INSERT INTO `bbgshop_footprint` VALUES (1924, 34, 15254143629539, 1525421056);
INSERT INTO `bbgshop_footprint` VALUES (1925, 34, 113262, 1525421954);
INSERT INTO `bbgshop_footprint` VALUES (1926, 34, 841662, 1525423412);
INSERT INTO `bbgshop_footprint` VALUES (1927, 34, 813924, 1525423668);
INSERT INTO `bbgshop_footprint` VALUES (1928, 34, 83888, 1525423681);
INSERT INTO `bbgshop_footprint` VALUES (1929, 34, 15254143629539, 1525423780);
INSERT INTO `bbgshop_footprint` VALUES (1930, 34, 134478, 1525423818);
INSERT INTO `bbgshop_footprint` VALUES (1931, 34, 240350, 1525423832);
INSERT INTO `bbgshop_footprint` VALUES (1932, 34, 841662, 1525424036);
INSERT INTO `bbgshop_footprint` VALUES (1933, 34, 42827, 1525424064);
INSERT INTO `bbgshop_footprint` VALUES (1934, 34, 813924, 1525488953);
INSERT INTO `bbgshop_footprint` VALUES (1935, 34, 19647, 1525490910);
INSERT INTO `bbgshop_footprint` VALUES (1936, 34, 15254143629539, 1525491009);
INSERT INTO `bbgshop_footprint` VALUES (1937, 32, 15254143629539, 1525505934);
INSERT INTO `bbgshop_footprint` VALUES (1938, 34, 1525506079804257, 1525506165);
INSERT INTO `bbgshop_footprint` VALUES (1939, 34, 813924, 1525656832);
INSERT INTO `bbgshop_footprint` VALUES (1940, 34, 813924, 1525658029);
INSERT INTO `bbgshop_footprint` VALUES (1941, 34, 813924, 1525658110);
INSERT INTO `bbgshop_footprint` VALUES (1942, 34, 813924, 1525658156);
INSERT INTO `bbgshop_footprint` VALUES (1943, 34, 813924, 1525658187);
INSERT INTO `bbgshop_footprint` VALUES (1944, 34, 813924, 1525658324);
INSERT INTO `bbgshop_footprint` VALUES (1945, 34, 813924, 1525658402);
INSERT INTO `bbgshop_footprint` VALUES (1946, 34, 813924, 1525658476);
INSERT INTO `bbgshop_footprint` VALUES (1947, 34, 813924, 1525658590);
INSERT INTO `bbgshop_footprint` VALUES (1948, 34, 813924, 1525658933);
INSERT INTO `bbgshop_footprint` VALUES (1949, 34, 813924, 1525659080);
INSERT INTO `bbgshop_footprint` VALUES (1950, 34, 813924, 1525659226);
INSERT INTO `bbgshop_footprint` VALUES (1951, 34, 813924, 1525659227);
INSERT INTO `bbgshop_footprint` VALUES (1952, 34, 813924, 1525659601);
INSERT INTO `bbgshop_footprint` VALUES (1953, 34, 15254143629539, 1525659730);
INSERT INTO `bbgshop_footprint` VALUES (1954, 34, 15254143629539, 1525659778);
INSERT INTO `bbgshop_footprint` VALUES (1955, 34, 813924, 1525659906);
INSERT INTO `bbgshop_footprint` VALUES (1956, 34, 813924, 1525660021);
INSERT INTO `bbgshop_footprint` VALUES (1957, 34, 284518, 1525661614);
INSERT INTO `bbgshop_footprint` VALUES (1958, 34, 19647, 1525661655);
INSERT INTO `bbgshop_footprint` VALUES (1959, 34, 19647, 1525661698);
INSERT INTO `bbgshop_footprint` VALUES (1960, 34, 19647, 1525661710);
INSERT INTO `bbgshop_footprint` VALUES (1961, 34, 19647, 1525661818);
INSERT INTO `bbgshop_footprint` VALUES (1962, 34, 19647, 1525662147);
INSERT INTO `bbgshop_footprint` VALUES (1963, 34, 240350, 1525662152);
INSERT INTO `bbgshop_footprint` VALUES (1964, 34, 19647, 1525662257);
INSERT INTO `bbgshop_footprint` VALUES (1965, 34, 19647, 1525662295);
INSERT INTO `bbgshop_footprint` VALUES (1966, 34, 19647, 1525662311);
INSERT INTO `bbgshop_footprint` VALUES (1967, 34, 19647, 1525662329);
INSERT INTO `bbgshop_footprint` VALUES (1968, 34, 19647, 1525662340);
INSERT INTO `bbgshop_footprint` VALUES (1969, 34, 19647, 1525662357);
INSERT INTO `bbgshop_footprint` VALUES (1970, 34, 19647, 1525662369);
INSERT INTO `bbgshop_footprint` VALUES (1971, 34, 19647, 1525662377);
INSERT INTO `bbgshop_footprint` VALUES (1972, 34, 19647, 1525662403);
INSERT INTO `bbgshop_footprint` VALUES (1973, 34, 19647, 1525662498);
INSERT INTO `bbgshop_footprint` VALUES (1974, 34, 19647, 1525662561);
INSERT INTO `bbgshop_footprint` VALUES (1975, 34, 19647, 1525662604);
INSERT INTO `bbgshop_footprint` VALUES (1976, 34, 19647, 1525662630);
INSERT INTO `bbgshop_footprint` VALUES (1977, 34, 19647, 1525662659);
INSERT INTO `bbgshop_footprint` VALUES (1978, 34, 19647, 1525662686);
INSERT INTO `bbgshop_footprint` VALUES (1979, 34, 19647, 1525662715);
INSERT INTO `bbgshop_footprint` VALUES (1980, 34, 19647, 1525662737);
INSERT INTO `bbgshop_footprint` VALUES (1981, 34, 19647, 1525662763);
INSERT INTO `bbgshop_footprint` VALUES (1982, 34, 19647, 1525662780);
INSERT INTO `bbgshop_footprint` VALUES (1983, 34, 19647, 1525662863);
INSERT INTO `bbgshop_footprint` VALUES (1984, 34, 19647, 1525662873);
INSERT INTO `bbgshop_footprint` VALUES (1985, 34, 19647, 1525662958);
INSERT INTO `bbgshop_footprint` VALUES (1986, 34, 19647, 1525662969);
INSERT INTO `bbgshop_footprint` VALUES (1987, 34, 19647, 1525662981);
INSERT INTO `bbgshop_footprint` VALUES (1988, 34, 19647, 1525662991);
INSERT INTO `bbgshop_footprint` VALUES (1989, 34, 19647, 1525663007);
INSERT INTO `bbgshop_footprint` VALUES (1990, 34, 19647, 1525663010);
INSERT INTO `bbgshop_footprint` VALUES (1991, 34, 19647, 1525663031);
INSERT INTO `bbgshop_footprint` VALUES (1992, 34, 19647, 1525663044);
INSERT INTO `bbgshop_footprint` VALUES (1993, 34, 19647, 1525663052);
INSERT INTO `bbgshop_footprint` VALUES (1994, 34, 19647, 1525663063);
INSERT INTO `bbgshop_footprint` VALUES (1995, 34, 19647, 1525663100);
INSERT INTO `bbgshop_footprint` VALUES (1996, 34, 19647, 1525663108);
INSERT INTO `bbgshop_footprint` VALUES (1997, 34, 19647, 1525663119);
INSERT INTO `bbgshop_footprint` VALUES (1998, 34, 19647, 1525663670);
INSERT INTO `bbgshop_footprint` VALUES (1999, 34, 19647, 1525663722);
INSERT INTO `bbgshop_footprint` VALUES (2000, 34, 19647, 1525663884);
INSERT INTO `bbgshop_footprint` VALUES (2001, 34, 19647, 1525663957);
INSERT INTO `bbgshop_footprint` VALUES (2002, 34, 19647, 1525663994);
INSERT INTO `bbgshop_footprint` VALUES (2003, 34, 19647, 1525664010);
INSERT INTO `bbgshop_footprint` VALUES (2004, 34, 19647, 1525667615);
INSERT INTO `bbgshop_footprint` VALUES (2005, 34, 19647, 1525667632);
INSERT INTO `bbgshop_footprint` VALUES (2006, 34, 19647, 1525667652);
INSERT INTO `bbgshop_footprint` VALUES (2007, 34, 19647, 1525667664);
INSERT INTO `bbgshop_footprint` VALUES (2008, 34, 19647, 1525667685);
INSERT INTO `bbgshop_footprint` VALUES (2009, 34, 19647, 1525667796);
INSERT INTO `bbgshop_footprint` VALUES (2010, 34, 19647, 1525667828);
INSERT INTO `bbgshop_footprint` VALUES (2011, 34, 1525506079804257, 1525667838);
INSERT INTO `bbgshop_footprint` VALUES (2012, 34, 19647, 1525667868);
INSERT INTO `bbgshop_footprint` VALUES (2013, 34, 19647, 1525667919);
INSERT INTO `bbgshop_footprint` VALUES (2014, 34, 19647, 1525668048);
INSERT INTO `bbgshop_footprint` VALUES (2015, 32, 841662, 1525671048);
INSERT INTO `bbgshop_footprint` VALUES (2016, 34, 1525506079804257, 1525671138);
INSERT INTO `bbgshop_footprint` VALUES (2017, 34, 19647, 1525671176);
INSERT INTO `bbgshop_footprint` VALUES (2018, 34, 1525506079804257, 1525671205);
INSERT INTO `bbgshop_footprint` VALUES (2019, 34, 1525506079804257, 1525671242);
INSERT INTO `bbgshop_footprint` VALUES (2020, 34, 1525506079804257, 1525671336);
INSERT INTO `bbgshop_footprint` VALUES (2021, 34, 1525506079804257, 1525671338);
INSERT INTO `bbgshop_footprint` VALUES (2022, 34, 1525506079804257, 1525671638);
INSERT INTO `bbgshop_footprint` VALUES (2023, 34, 1525506079804257, 1525676249);
INSERT INTO `bbgshop_footprint` VALUES (2024, 34, 1525506079804257, 1525676266);
INSERT INTO `bbgshop_footprint` VALUES (2025, 34, 15254143629539, 1525677090);
INSERT INTO `bbgshop_footprint` VALUES (2026, 34, 813924, 1525677448);
INSERT INTO `bbgshop_footprint` VALUES (2027, 34, 813924, 1525677615);
INSERT INTO `bbgshop_footprint` VALUES (2028, 34, 813924, 1525677748);
INSERT INTO `bbgshop_footprint` VALUES (2029, 34, 813924, 1525677888);
INSERT INTO `bbgshop_footprint` VALUES (2030, 34, 15254143629539, 1525677925);
INSERT INTO `bbgshop_footprint` VALUES (2031, 34, 841662, 1525678179);
INSERT INTO `bbgshop_footprint` VALUES (2032, 34, 1525506079804257, 1525678205);
INSERT INTO `bbgshop_footprint` VALUES (2033, 34, 841662, 1525678690);
INSERT INTO `bbgshop_footprint` VALUES (2034, 34, 841662, 1525679180);
INSERT INTO `bbgshop_footprint` VALUES (2035, 34, 841662, 1525679236);
INSERT INTO `bbgshop_footprint` VALUES (2036, 34, 841662, 1525679255);
INSERT INTO `bbgshop_footprint` VALUES (2037, 34, 841662, 1525679306);
INSERT INTO `bbgshop_footprint` VALUES (2038, 34, 1525506079804257, 1525679314);
INSERT INTO `bbgshop_footprint` VALUES (2039, 34, 1525506079804257, 1525679326);
INSERT INTO `bbgshop_footprint` VALUES (2040, 34, 841662, 1525679345);
INSERT INTO `bbgshop_footprint` VALUES (2041, 34, 1525506079804257, 1525679351);
INSERT INTO `bbgshop_footprint` VALUES (2042, 34, 841662, 1525679916);
INSERT INTO `bbgshop_footprint` VALUES (2043, 34, 841662, 1525679946);
INSERT INTO `bbgshop_footprint` VALUES (2044, 34, 1525506079804257, 1525679953);
INSERT INTO `bbgshop_footprint` VALUES (2045, 34, 1525506079804257, 1525680055);
INSERT INTO `bbgshop_footprint` VALUES (2046, 34, 1525506079804257, 1525680205);
INSERT INTO `bbgshop_footprint` VALUES (2047, 34, 841662, 1525680221);
INSERT INTO `bbgshop_footprint` VALUES (2048, 34, 1525506079804257, 1525680223);
INSERT INTO `bbgshop_footprint` VALUES (2049, 34, 15254143629539, 1525680259);
INSERT INTO `bbgshop_footprint` VALUES (2050, 32, 1525506079804257, 1525684203);
INSERT INTO `bbgshop_footprint` VALUES (2051, 32, 841662, 1525684205);
INSERT INTO `bbgshop_footprint` VALUES (2052, 34, 841662, 1525684214);
INSERT INTO `bbgshop_footprint` VALUES (2053, 34, 841662, 1525770683);
INSERT INTO `bbgshop_footprint` VALUES (2054, 34, 1525506079804257, 1525770696);
INSERT INTO `bbgshop_footprint` VALUES (2055, 34, 369000, 1525848816);
INSERT INTO `bbgshop_footprint` VALUES (2056, 34, 841662, 1525848857);
INSERT INTO `bbgshop_footprint` VALUES (2057, 34, 841662, 1525848896);
INSERT INTO `bbgshop_footprint` VALUES (2058, 34, 841662, 1525848942);
INSERT INTO `bbgshop_footprint` VALUES (2059, 34, 841662, 1525849009);
INSERT INTO `bbgshop_footprint` VALUES (2060, 34, 841662, 1525849103);
INSERT INTO `bbgshop_footprint` VALUES (2061, 34, 1525506079804257, 1525849256);
INSERT INTO `bbgshop_footprint` VALUES (2062, 34, 1525506079804257, 1525849396);
INSERT INTO `bbgshop_footprint` VALUES (2063, 34, 1525506079804257, 1525849823);
INSERT INTO `bbgshop_footprint` VALUES (2064, 34, 1525506079804257, 1525849922);
INSERT INTO `bbgshop_footprint` VALUES (2065, 34, 1525506079804257, 1525849971);
INSERT INTO `bbgshop_footprint` VALUES (2066, 34, 1525506079804257, 1525850030);
INSERT INTO `bbgshop_footprint` VALUES (2067, 34, 1525506079804257, 1525850121);
INSERT INTO `bbgshop_footprint` VALUES (2068, 34, 1525506079804257, 1525850551);
INSERT INTO `bbgshop_footprint` VALUES (2069, 34, 841662, 1525850645);
INSERT INTO `bbgshop_footprint` VALUES (2070, 34, 1525506079804257, 1525850656);
INSERT INTO `bbgshop_footprint` VALUES (2071, 34, 1525506079804257, 1525850819);
INSERT INTO `bbgshop_footprint` VALUES (2072, 34, 1525506079804257, 1525850849);
INSERT INTO `bbgshop_footprint` VALUES (2073, 34, 1525506079804257, 1525851047);
INSERT INTO `bbgshop_footprint` VALUES (2074, 34, 1525506079804257, 1525851089);
INSERT INTO `bbgshop_footprint` VALUES (2075, 34, 1525506079804257, 1525851158);
INSERT INTO `bbgshop_footprint` VALUES (2076, 34, 1525506079804257, 1525851171);
INSERT INTO `bbgshop_footprint` VALUES (2077, 34, 1525506079804257, 1525852063);
INSERT INTO `bbgshop_footprint` VALUES (2078, 34, 1525506079804257, 1525852948);
INSERT INTO `bbgshop_footprint` VALUES (2079, 34, 1525506079804257, 1525852982);
INSERT INTO `bbgshop_footprint` VALUES (2080, 34, 1525506079804257, 1525853036);
INSERT INTO `bbgshop_footprint` VALUES (2081, 34, 1525506079804257, 1525853071);
INSERT INTO `bbgshop_footprint` VALUES (2082, 34, 1525506079804257, 1525853118);
INSERT INTO `bbgshop_footprint` VALUES (2083, 34, 1525506079804257, 1525853198);
INSERT INTO `bbgshop_footprint` VALUES (2084, 34, 1525506079804257, 1525853660);
INSERT INTO `bbgshop_footprint` VALUES (2085, 34, 1525506079804257, 1525853821);
INSERT INTO `bbgshop_footprint` VALUES (2086, 34, 1525506079804257, 1525853878);
INSERT INTO `bbgshop_footprint` VALUES (2087, 34, 1525506079804257, 1525853905);
INSERT INTO `bbgshop_footprint` VALUES (2088, 34, 1525506079804257, 1525854069);
INSERT INTO `bbgshop_footprint` VALUES (2089, 34, 1525506079804257, 1525854089);
INSERT INTO `bbgshop_footprint` VALUES (2090, 34, 1525506079804257, 1525854114);
INSERT INTO `bbgshop_footprint` VALUES (2091, 34, 1525506079804257, 1525854205);
INSERT INTO `bbgshop_footprint` VALUES (2092, 34, 1525506079804257, 1525854284);
INSERT INTO `bbgshop_footprint` VALUES (2093, 34, 1525506079804257, 1525854298);
INSERT INTO `bbgshop_footprint` VALUES (2094, 34, 1525506079804257, 1525854362);
INSERT INTO `bbgshop_footprint` VALUES (2095, 34, 1525506079804257, 1525854565);
INSERT INTO `bbgshop_footprint` VALUES (2096, 34, 1525506079804257, 1525854773);
INSERT INTO `bbgshop_footprint` VALUES (2097, 34, 1525506079804257, 1525854834);
INSERT INTO `bbgshop_footprint` VALUES (2098, 34, 1525506079804257, 1525854873);
INSERT INTO `bbgshop_footprint` VALUES (2099, 34, 1525506079804257, 1525854913);
INSERT INTO `bbgshop_footprint` VALUES (2100, 34, 1525506079804257, 1525854952);
INSERT INTO `bbgshop_footprint` VALUES (2101, 34, 1525506079804257, 1525854979);
INSERT INTO `bbgshop_footprint` VALUES (2102, 34, 1525506079804257, 1525855005);
INSERT INTO `bbgshop_footprint` VALUES (2103, 34, 1525506079804257, 1525855031);
INSERT INTO `bbgshop_footprint` VALUES (2104, 34, 1525506079804257, 1525855051);
INSERT INTO `bbgshop_footprint` VALUES (2105, 34, 1525506079804257, 1525855069);
INSERT INTO `bbgshop_footprint` VALUES (2106, 34, 1525506079804257, 1525855081);
INSERT INTO `bbgshop_footprint` VALUES (2107, 34, 1525506079804257, 1525855124);
INSERT INTO `bbgshop_footprint` VALUES (2108, 34, 1525506079804257, 1525855192);
INSERT INTO `bbgshop_footprint` VALUES (2109, 34, 1525506079804257, 1525855258);
INSERT INTO `bbgshop_footprint` VALUES (2110, 34, 1525506079804257, 1525855281);
INSERT INTO `bbgshop_footprint` VALUES (2111, 34, 1525506079804257, 1525855304);
INSERT INTO `bbgshop_footprint` VALUES (2112, 34, 1525506079804257, 1525855344);
INSERT INTO `bbgshop_footprint` VALUES (2113, 34, 1525506079804257, 1525855378);
INSERT INTO `bbgshop_footprint` VALUES (2114, 34, 1525506079804257, 1525855390);
INSERT INTO `bbgshop_footprint` VALUES (2115, 34, 1525506079804257, 1525855409);
INSERT INTO `bbgshop_footprint` VALUES (2116, 34, 1525506079804257, 1525855487);
INSERT INTO `bbgshop_footprint` VALUES (2117, 34, 1525506079804257, 1525855520);
INSERT INTO `bbgshop_footprint` VALUES (2118, 34, 1525506079804257, 1525855558);
INSERT INTO `bbgshop_footprint` VALUES (2119, 34, 1525506079804257, 1525855642);
INSERT INTO `bbgshop_footprint` VALUES (2120, 34, 1525506079804257, 1525855688);
INSERT INTO `bbgshop_footprint` VALUES (2121, 34, 1525506079804257, 1525855726);
INSERT INTO `bbgshop_footprint` VALUES (2122, 34, 1525506079804257, 1525855739);
INSERT INTO `bbgshop_footprint` VALUES (2123, 34, 1525506079804257, 1525855790);
INSERT INTO `bbgshop_footprint` VALUES (2124, 34, 1525506079804257, 1525855832);
INSERT INTO `bbgshop_footprint` VALUES (2125, 34, 1525506079804257, 1525855918);
INSERT INTO `bbgshop_footprint` VALUES (2126, 34, 1525506079804257, 1525855957);
INSERT INTO `bbgshop_footprint` VALUES (2127, 34, 1525506079804257, 1525855994);
INSERT INTO `bbgshop_footprint` VALUES (2128, 34, 1525506079804257, 1525856004);
INSERT INTO `bbgshop_footprint` VALUES (2129, 34, 1525506079804257, 1525856026);
INSERT INTO `bbgshop_footprint` VALUES (2130, 34, 1525506079804257, 1525856035);
INSERT INTO `bbgshop_footprint` VALUES (2131, 34, 1525506079804257, 1525856049);
INSERT INTO `bbgshop_footprint` VALUES (2132, 34, 1525506079804257, 1525856061);
INSERT INTO `bbgshop_footprint` VALUES (2133, 34, 1525506079804257, 1525856076);
INSERT INTO `bbgshop_footprint` VALUES (2134, 34, 1525506079804257, 1525856091);
INSERT INTO `bbgshop_footprint` VALUES (2135, 34, 1525506079804257, 1525856108);
INSERT INTO `bbgshop_footprint` VALUES (2136, 34, 1525506079804257, 1525856119);
INSERT INTO `bbgshop_footprint` VALUES (2137, 34, 1525506079804257, 1525856219);
INSERT INTO `bbgshop_footprint` VALUES (2138, 34, 841662, 1525856287);
INSERT INTO `bbgshop_footprint` VALUES (2139, 34, 1525506079804257, 1525856304);
INSERT INTO `bbgshop_footprint` VALUES (2140, 34, 1525506079804257, 1525856340);
INSERT INTO `bbgshop_footprint` VALUES (2141, 34, 1525506079804257, 1525856354);
INSERT INTO `bbgshop_footprint` VALUES (2142, 34, 841662, 1525856393);
INSERT INTO `bbgshop_footprint` VALUES (2143, 34, 1525506079804257, 1525856503);
INSERT INTO `bbgshop_footprint` VALUES (2144, 34, 1525506079804257, 1525856540);
INSERT INTO `bbgshop_footprint` VALUES (2145, 34, 1525506079804257, 1525856593);
INSERT INTO `bbgshop_footprint` VALUES (2146, 34, 1525506079804257, 1525856658);
INSERT INTO `bbgshop_footprint` VALUES (2147, 34, 1525506079804257, 1525856678);
INSERT INTO `bbgshop_footprint` VALUES (2148, 34, 1525506079804257, 1525856698);
INSERT INTO `bbgshop_footprint` VALUES (2149, 34, 1525506079804257, 1525856793);
INSERT INTO `bbgshop_footprint` VALUES (2150, 34, 841662, 1525856811);
INSERT INTO `bbgshop_footprint` VALUES (2151, 34, 1525506079804257, 1525856835);
INSERT INTO `bbgshop_footprint` VALUES (2152, 34, 1525506079804257, 1525856858);
INSERT INTO `bbgshop_footprint` VALUES (2153, 34, 1525506079804257, 1525912501);
INSERT INTO `bbgshop_footprint` VALUES (2154, 34, 622336, 1525935394);
INSERT INTO `bbgshop_footprint` VALUES (2155, 34, 1525506079804257, 1526016210);
INSERT INTO `bbgshop_footprint` VALUES (2156, 34, 841662, 1526016214);
INSERT INTO `bbgshop_footprint` VALUES (2157, 34, 841662, 1526016372);
INSERT INTO `bbgshop_footprint` VALUES (2158, 34, 841662, 1526016424);
INSERT INTO `bbgshop_footprint` VALUES (2159, 34, 841662, 1526017196);
INSERT INTO `bbgshop_footprint` VALUES (2160, 34, 1525506079804257, 1526017203);
INSERT INTO `bbgshop_footprint` VALUES (2161, 34, 841662, 1526017484);
INSERT INTO `bbgshop_footprint` VALUES (2162, 34, 1525506079804257, 1526017572);
INSERT INTO `bbgshop_footprint` VALUES (2163, 34, 841662, 1526017584);
INSERT INTO `bbgshop_footprint` VALUES (2164, 34, 15254143629539, 1526019163);
INSERT INTO `bbgshop_footprint` VALUES (2165, 34, 15254143629539, 1526019383);
INSERT INTO `bbgshop_footprint` VALUES (2166, 34, 813924, 1526019392);
INSERT INTO `bbgshop_footprint` VALUES (2167, 34, 369904, 1526019496);
INSERT INTO `bbgshop_footprint` VALUES (2168, 34, 369904, 1526019520);
INSERT INTO `bbgshop_footprint` VALUES (2169, 34, 67743, 1526019527);
INSERT INTO `bbgshop_footprint` VALUES (2170, 34, 622336, 1526025613);
INSERT INTO `bbgshop_footprint` VALUES (2171, 34, 841662, 1526029889);
INSERT INTO `bbgshop_footprint` VALUES (2172, 34, 369904, 1526029899);
INSERT INTO `bbgshop_footprint` VALUES (2173, 34, 81405, 1526029906);
INSERT INTO `bbgshop_footprint` VALUES (2174, 34, 622336, 1526029913);
INSERT INTO `bbgshop_footprint` VALUES (2175, 34, 369000, 1526030029);
INSERT INTO `bbgshop_footprint` VALUES (2176, 34, 841662, 1526088905);
INSERT INTO `bbgshop_footprint` VALUES (2177, 34, 88319, 1526088910);
INSERT INTO `bbgshop_footprint` VALUES (2178, 34, 841662, 1526266136);
INSERT INTO `bbgshop_footprint` VALUES (2179, 34, 841662, 1526286220);
INSERT INTO `bbgshop_footprint` VALUES (2180, 34, 1525506079804257, 1526344814);
INSERT INTO `bbgshop_footprint` VALUES (2181, 34, 813924, 1526344867);
INSERT INTO `bbgshop_footprint` VALUES (2182, 34, 813924, 1526344947);
INSERT INTO `bbgshop_footprint` VALUES (2183, 34, 369000, 1526353256);
INSERT INTO `bbgshop_footprint` VALUES (2184, 34, 622336, 1526353292);
INSERT INTO `bbgshop_footprint` VALUES (2185, 34, 841662, 1526355374);
INSERT INTO `bbgshop_footprint` VALUES (2186, 34, 15254143629539, 1526358691);
INSERT INTO `bbgshop_footprint` VALUES (2187, 34, 15254143629539, 1526358697);
INSERT INTO `bbgshop_footprint` VALUES (2188, 34, 15254143629539, 1526358719);
INSERT INTO `bbgshop_footprint` VALUES (2189, 34, 841662, 1526358803);
INSERT INTO `bbgshop_footprint` VALUES (2190, 34, 1525506079804257, 1526358823);
INSERT INTO `bbgshop_footprint` VALUES (2191, 34, 1525506079804257, 1526358893);
INSERT INTO `bbgshop_footprint` VALUES (2192, 34, 15254143629539, 1526359045);
INSERT INTO `bbgshop_footprint` VALUES (2193, 34, 1525506079804257, 1526359052);
INSERT INTO `bbgshop_footprint` VALUES (2194, 34, 15254143629539, 1526359132);
INSERT INTO `bbgshop_footprint` VALUES (2195, 34, 15254143629539, 1526359163);
INSERT INTO `bbgshop_footprint` VALUES (2196, 34, 15254143629539, 1526359195);
INSERT INTO `bbgshop_footprint` VALUES (2197, 34, 15254143629539, 1526359325);
INSERT INTO `bbgshop_footprint` VALUES (2198, 34, 15254143629539, 1526359357);
INSERT INTO `bbgshop_footprint` VALUES (2199, 34, 15254143629539, 1526359400);
INSERT INTO `bbgshop_footprint` VALUES (2200, 34, 15254143629539, 1526359410);
INSERT INTO `bbgshop_footprint` VALUES (2201, 34, 15254143629539, 1526359434);
INSERT INTO `bbgshop_footprint` VALUES (2202, 34, 15254143629539, 1526359451);
INSERT INTO `bbgshop_footprint` VALUES (2203, 34, 15254143629539, 1526359487);
INSERT INTO `bbgshop_footprint` VALUES (2204, 34, 15254143629539, 1526359501);
INSERT INTO `bbgshop_footprint` VALUES (2205, 34, 15254143629539, 1526359553);
INSERT INTO `bbgshop_footprint` VALUES (2206, 34, 15254143629539, 1526359580);
INSERT INTO `bbgshop_footprint` VALUES (2207, 34, 15254143629539, 1526359584);
INSERT INTO `bbgshop_footprint` VALUES (2208, 34, 15254143629539, 1526359604);
INSERT INTO `bbgshop_footprint` VALUES (2209, 34, 15254143629539, 1526359612);
INSERT INTO `bbgshop_footprint` VALUES (2210, 34, 15254143629539, 1526359631);
INSERT INTO `bbgshop_footprint` VALUES (2211, 34, 15254143629539, 1526359649);
INSERT INTO `bbgshop_footprint` VALUES (2212, 34, 15254143629539, 1526359654);
INSERT INTO `bbgshop_footprint` VALUES (2213, 34, 15254143629539, 1526359664);
INSERT INTO `bbgshop_footprint` VALUES (2214, 34, 15254143629539, 1526359683);
INSERT INTO `bbgshop_footprint` VALUES (2215, 34, 15254143629539, 1526359692);
INSERT INTO `bbgshop_footprint` VALUES (2216, 34, 15254143629539, 1526359707);
INSERT INTO `bbgshop_footprint` VALUES (2217, 34, 15254143629539, 1526359712);
INSERT INTO `bbgshop_footprint` VALUES (2218, 34, 15254143629539, 1526359748);
INSERT INTO `bbgshop_footprint` VALUES (2219, 34, 15254143629539, 1526359789);
INSERT INTO `bbgshop_footprint` VALUES (2220, 34, 15254143629539, 1526359833);
INSERT INTO `bbgshop_footprint` VALUES (2221, 34, 15254143629539, 1526359894);
INSERT INTO `bbgshop_footprint` VALUES (2222, 34, 15254143629539, 1526359949);
INSERT INTO `bbgshop_footprint` VALUES (2223, 34, 15254143629539, 1526359967);
INSERT INTO `bbgshop_footprint` VALUES (2224, 34, 15254143629539, 1526359977);
INSERT INTO `bbgshop_footprint` VALUES (2225, 34, 15254143629539, 1526360056);
INSERT INTO `bbgshop_footprint` VALUES (2226, 34, 15254143629539, 1526360075);
INSERT INTO `bbgshop_footprint` VALUES (2227, 34, 15254143629539, 1526360121);
INSERT INTO `bbgshop_footprint` VALUES (2228, 34, 15254143629539, 1526360144);
INSERT INTO `bbgshop_footprint` VALUES (2229, 34, 15254143629539, 1526360160);
INSERT INTO `bbgshop_footprint` VALUES (2230, 34, 15254143629539, 1526360212);
INSERT INTO `bbgshop_footprint` VALUES (2231, 34, 15254143629539, 1526360222);
INSERT INTO `bbgshop_footprint` VALUES (2232, 34, 15254143629539, 1526360228);
INSERT INTO `bbgshop_footprint` VALUES (2233, 34, 15254143629539, 1526360237);
INSERT INTO `bbgshop_footprint` VALUES (2234, 34, 15254143629539, 1526360248);
INSERT INTO `bbgshop_footprint` VALUES (2235, 34, 15254143629539, 1526360256);
INSERT INTO `bbgshop_footprint` VALUES (2236, 34, 15254143629539, 1526360261);
INSERT INTO `bbgshop_footprint` VALUES (2237, 34, 15254143629539, 1526360325);
INSERT INTO `bbgshop_footprint` VALUES (2238, 34, 15254143629539, 1526360333);
INSERT INTO `bbgshop_footprint` VALUES (2239, 34, 15254143629539, 1526360341);
INSERT INTO `bbgshop_footprint` VALUES (2240, 34, 15254143629539, 1526360349);
INSERT INTO `bbgshop_footprint` VALUES (2241, 34, 15254143629539, 1526360361);
INSERT INTO `bbgshop_footprint` VALUES (2242, 34, 841662, 1526360364);
INSERT INTO `bbgshop_footprint` VALUES (2243, 34, 15254143629539, 1526360369);
INSERT INTO `bbgshop_footprint` VALUES (2244, 34, 15254143629539, 1526360388);
INSERT INTO `bbgshop_footprint` VALUES (2245, 34, 1525506079804257, 1526360399);
INSERT INTO `bbgshop_footprint` VALUES (2246, 34, 15254143629539, 1526360405);
INSERT INTO `bbgshop_footprint` VALUES (2247, 34, 15254143629539, 1526360466);
INSERT INTO `bbgshop_footprint` VALUES (2248, 34, 15254143629539, 1526360485);
INSERT INTO `bbgshop_footprint` VALUES (2249, 34, 15254143629539, 1526360515);
INSERT INTO `bbgshop_footprint` VALUES (2250, 34, 15254143629539, 1526360535);
INSERT INTO `bbgshop_footprint` VALUES (2251, 34, 15254143629539, 1526360554);
INSERT INTO `bbgshop_footprint` VALUES (2252, 34, 15254143629539, 1526360558);
INSERT INTO `bbgshop_footprint` VALUES (2253, 34, 841662, 1526360565);
INSERT INTO `bbgshop_footprint` VALUES (2254, 34, 15254143629539, 1526360576);
INSERT INTO `bbgshop_footprint` VALUES (2255, 34, 15254143629539, 1526360582);
INSERT INTO `bbgshop_footprint` VALUES (2256, 34, 15254143629539, 1526360627);
INSERT INTO `bbgshop_footprint` VALUES (2257, 34, 15254143629539, 1526360634);
INSERT INTO `bbgshop_footprint` VALUES (2258, 34, 15254143629539, 1526360642);
INSERT INTO `bbgshop_footprint` VALUES (2259, 34, 15254143629539, 1526360669);
INSERT INTO `bbgshop_footprint` VALUES (2260, 34, 15254143629539, 1526360678);
INSERT INTO `bbgshop_footprint` VALUES (2261, 34, 15254143629539, 1526360683);
INSERT INTO `bbgshop_footprint` VALUES (2262, 34, 15254143629539, 1526360688);
INSERT INTO `bbgshop_footprint` VALUES (2263, 34, 15254143629539, 1526360696);
INSERT INTO `bbgshop_footprint` VALUES (2264, 34, 15254143629539, 1526360707);
INSERT INTO `bbgshop_footprint` VALUES (2265, 34, 15254143629539, 1526360725);
INSERT INTO `bbgshop_footprint` VALUES (2266, 34, 15254143629539, 1526360733);
INSERT INTO `bbgshop_footprint` VALUES (2267, 34, 15254143629539, 1526360756);
INSERT INTO `bbgshop_footprint` VALUES (2268, 34, 15254143629539, 1526360762);
INSERT INTO `bbgshop_footprint` VALUES (2269, 34, 15254143629539, 1526360772);
INSERT INTO `bbgshop_footprint` VALUES (2270, 34, 15254143629539, 1526360779);
INSERT INTO `bbgshop_footprint` VALUES (2271, 34, 15254143629539, 1526360801);
INSERT INTO `bbgshop_footprint` VALUES (2272, 34, 15254143629539, 1526360851);
INSERT INTO `bbgshop_footprint` VALUES (2273, 34, 15254143629539, 1526360860);
INSERT INTO `bbgshop_footprint` VALUES (2274, 34, 15254143629539, 1526360866);
INSERT INTO `bbgshop_footprint` VALUES (2275, 34, 15254143629539, 1526360872);
INSERT INTO `bbgshop_footprint` VALUES (2276, 34, 15254143629539, 1526360949);
INSERT INTO `bbgshop_footprint` VALUES (2277, 34, 15254143629539, 1526360958);
INSERT INTO `bbgshop_footprint` VALUES (2278, 34, 15254143629539, 1526360973);
INSERT INTO `bbgshop_footprint` VALUES (2279, 34, 15254143629539, 1526360981);
INSERT INTO `bbgshop_footprint` VALUES (2280, 34, 15254143629539, 1526360997);
INSERT INTO `bbgshop_footprint` VALUES (2281, 34, 15254143629539, 1526361042);
INSERT INTO `bbgshop_footprint` VALUES (2282, 34, 15254143629539, 1526361085);
INSERT INTO `bbgshop_footprint` VALUES (2283, 34, 15254143629539, 1526361104);
INSERT INTO `bbgshop_footprint` VALUES (2284, 34, 15254143629539, 1526361110);
INSERT INTO `bbgshop_footprint` VALUES (2285, 34, 15254143629539, 1526361118);
INSERT INTO `bbgshop_footprint` VALUES (2286, 34, 15254143629539, 1526361125);
INSERT INTO `bbgshop_footprint` VALUES (2287, 34, 15254143629539, 1526361141);
INSERT INTO `bbgshop_footprint` VALUES (2288, 34, 15254143629539, 1526361158);
INSERT INTO `bbgshop_footprint` VALUES (2289, 34, 15254143629539, 1526361166);
INSERT INTO `bbgshop_footprint` VALUES (2290, 34, 15254143629539, 1526361181);
INSERT INTO `bbgshop_footprint` VALUES (2291, 34, 15254143629539, 1526361194);
INSERT INTO `bbgshop_footprint` VALUES (2292, 34, 15254143629539, 1526361204);
INSERT INTO `bbgshop_footprint` VALUES (2293, 34, 15254143629539, 1526361221);
INSERT INTO `bbgshop_footprint` VALUES (2294, 34, 15254143629539, 1526361286);
INSERT INTO `bbgshop_footprint` VALUES (2295, 34, 15254143629539, 1526361293);
INSERT INTO `bbgshop_footprint` VALUES (2296, 34, 15254143629539, 1526361306);
INSERT INTO `bbgshop_footprint` VALUES (2297, 34, 15254143629539, 1526361315);
INSERT INTO `bbgshop_footprint` VALUES (2298, 34, 15254143629539, 1526361350);
INSERT INTO `bbgshop_footprint` VALUES (2299, 34, 15254143629539, 1526361360);
INSERT INTO `bbgshop_footprint` VALUES (2300, 34, 15254143629539, 1526361368);
INSERT INTO `bbgshop_footprint` VALUES (2301, 34, 15254143629539, 1526361376);
INSERT INTO `bbgshop_footprint` VALUES (2302, 34, 15254143629539, 1526361390);
INSERT INTO `bbgshop_footprint` VALUES (2303, 34, 15254143629539, 1526361399);
INSERT INTO `bbgshop_footprint` VALUES (2304, 34, 15254143629539, 1526361406);
INSERT INTO `bbgshop_footprint` VALUES (2305, 34, 15254143629539, 1526361415);
INSERT INTO `bbgshop_footprint` VALUES (2306, 34, 15254143629539, 1526361424);
INSERT INTO `bbgshop_footprint` VALUES (2307, 34, 15254143629539, 1526361528);
INSERT INTO `bbgshop_footprint` VALUES (2308, 34, 15254143629539, 1526361585);
INSERT INTO `bbgshop_footprint` VALUES (2309, 34, 15254143629539, 1526361592);
INSERT INTO `bbgshop_footprint` VALUES (2310, 34, 15254143629539, 1526361604);
INSERT INTO `bbgshop_footprint` VALUES (2311, 34, 15254143629539, 1526361609);
INSERT INTO `bbgshop_footprint` VALUES (2312, 34, 15254143629539, 1526361648);
INSERT INTO `bbgshop_footprint` VALUES (2313, 34, 15254143629539, 1526361748);
INSERT INTO `bbgshop_footprint` VALUES (2314, 34, 15254143629539, 1526361766);
INSERT INTO `bbgshop_footprint` VALUES (2315, 34, 15254143629539, 1526361776);
INSERT INTO `bbgshop_footprint` VALUES (2316, 34, 15254143629539, 1526361787);
INSERT INTO `bbgshop_footprint` VALUES (2317, 34, 15254143629539, 1526361864);
INSERT INTO `bbgshop_footprint` VALUES (2318, 34, 15254143629539, 1526361873);
INSERT INTO `bbgshop_footprint` VALUES (2319, 34, 15254143629539, 1526361899);
INSERT INTO `bbgshop_footprint` VALUES (2320, 34, 15254143629539, 1526361912);
INSERT INTO `bbgshop_footprint` VALUES (2321, 34, 15254143629539, 1526361984);
INSERT INTO `bbgshop_footprint` VALUES (2322, 34, 15254143629539, 1526362025);
INSERT INTO `bbgshop_footprint` VALUES (2323, 34, 15254143629539, 1526362040);
INSERT INTO `bbgshop_footprint` VALUES (2324, 34, 15254143629539, 1526362046);
INSERT INTO `bbgshop_footprint` VALUES (2325, 34, 15254143629539, 1526362056);
INSERT INTO `bbgshop_footprint` VALUES (2326, 34, 15254143629539, 1526362064);
INSERT INTO `bbgshop_footprint` VALUES (2327, 34, 15254143629539, 1526362071);
INSERT INTO `bbgshop_footprint` VALUES (2328, 34, 15254143629539, 1526362138);
INSERT INTO `bbgshop_footprint` VALUES (2329, 34, 15254143629539, 1526362147);
INSERT INTO `bbgshop_footprint` VALUES (2330, 34, 15254143629539, 1526362158);
INSERT INTO `bbgshop_footprint` VALUES (2331, 34, 15254143629539, 1526362294);
INSERT INTO `bbgshop_footprint` VALUES (2332, 34, 15254143629539, 1526362309);
INSERT INTO `bbgshop_footprint` VALUES (2333, 34, 15254143629539, 1526362317);
INSERT INTO `bbgshop_footprint` VALUES (2334, 34, 1525506079804257, 1526362334);
INSERT INTO `bbgshop_footprint` VALUES (2335, 34, 15254143629539, 1526362379);
INSERT INTO `bbgshop_footprint` VALUES (2336, 34, 1525506079804257, 1526362396);
INSERT INTO `bbgshop_footprint` VALUES (2337, 34, 15254143629539, 1526362425);
INSERT INTO `bbgshop_footprint` VALUES (2338, 34, 15254143629539, 1526362444);
INSERT INTO `bbgshop_footprint` VALUES (2339, 34, 15254143629539, 1526362485);
INSERT INTO `bbgshop_footprint` VALUES (2340, 34, 15254143629539, 1526362514);
INSERT INTO `bbgshop_footprint` VALUES (2341, 34, 15254143629539, 1526362544);
INSERT INTO `bbgshop_footprint` VALUES (2342, 34, 15254143629539, 1526362594);
INSERT INTO `bbgshop_footprint` VALUES (2343, 34, 15254143629539, 1526362621);
INSERT INTO `bbgshop_footprint` VALUES (2344, 34, 15254143629539, 1526362641);
INSERT INTO `bbgshop_footprint` VALUES (2345, 34, 15254143629539, 1526362681);
INSERT INTO `bbgshop_footprint` VALUES (2346, 34, 15254143629539, 1526362696);
INSERT INTO `bbgshop_footprint` VALUES (2347, 34, 15254143629539, 1526362704);
INSERT INTO `bbgshop_footprint` VALUES (2348, 34, 15254143629539, 1526362711);
INSERT INTO `bbgshop_footprint` VALUES (2349, 34, 15254143629539, 1526362723);
INSERT INTO `bbgshop_footprint` VALUES (2350, 34, 15254143629539, 1526362730);
INSERT INTO `bbgshop_footprint` VALUES (2351, 34, 15254143629539, 1526362739);
INSERT INTO `bbgshop_footprint` VALUES (2352, 34, 15254143629539, 1526362752);
INSERT INTO `bbgshop_footprint` VALUES (2353, 34, 15254143629539, 1526362760);
INSERT INTO `bbgshop_footprint` VALUES (2354, 34, 15254143629539, 1526362770);
INSERT INTO `bbgshop_footprint` VALUES (2355, 34, 15254143629539, 1526362783);
INSERT INTO `bbgshop_footprint` VALUES (2356, 34, 15254143629539, 1526362886);
INSERT INTO `bbgshop_footprint` VALUES (2357, 34, 15254143629539, 1526362906);
INSERT INTO `bbgshop_footprint` VALUES (2358, 34, 15254143629539, 1526362911);
INSERT INTO `bbgshop_footprint` VALUES (2359, 34, 15254143629539, 1526362981);
INSERT INTO `bbgshop_footprint` VALUES (2360, 34, 15254143629539, 1526363013);
INSERT INTO `bbgshop_footprint` VALUES (2361, 34, 15254143629539, 1526363182);
INSERT INTO `bbgshop_footprint` VALUES (2362, 34, 15254143629539, 1526363206);
INSERT INTO `bbgshop_footprint` VALUES (2363, 34, 15254143629539, 1526363240);
INSERT INTO `bbgshop_footprint` VALUES (2364, 34, 15254143629539, 1526363288);
INSERT INTO `bbgshop_footprint` VALUES (2365, 34, 15254143629539, 1526363310);
INSERT INTO `bbgshop_footprint` VALUES (2366, 34, 15254143629539, 1526363339);
INSERT INTO `bbgshop_footprint` VALUES (2367, 34, 15254143629539, 1526363410);
INSERT INTO `bbgshop_footprint` VALUES (2368, 34, 15254143629539, 1526363421);
INSERT INTO `bbgshop_footprint` VALUES (2369, 34, 15254143629539, 1526363429);
INSERT INTO `bbgshop_footprint` VALUES (2370, 34, 15254143629539, 1526363472);
INSERT INTO `bbgshop_footprint` VALUES (2371, 34, 15254143629539, 1526363511);
INSERT INTO `bbgshop_footprint` VALUES (2372, 34, 15254143629539, 1526363534);
INSERT INTO `bbgshop_footprint` VALUES (2373, 34, 15254143629539, 1526363690);
INSERT INTO `bbgshop_footprint` VALUES (2374, 34, 15254143629539, 1526363727);
INSERT INTO `bbgshop_footprint` VALUES (2375, 34, 15254143629539, 1526363749);
INSERT INTO `bbgshop_footprint` VALUES (2376, 34, 15254143629539, 1526363844);
INSERT INTO `bbgshop_footprint` VALUES (2377, 34, 15254143629539, 1526363864);
INSERT INTO `bbgshop_footprint` VALUES (2378, 34, 15254143629539, 1526363958);
INSERT INTO `bbgshop_footprint` VALUES (2379, 34, 15254143629539, 1526363989);
INSERT INTO `bbgshop_footprint` VALUES (2380, 34, 15254143629539, 1526364104);
INSERT INTO `bbgshop_footprint` VALUES (2381, 34, 67743, 1526364134);
INSERT INTO `bbgshop_footprint` VALUES (2382, 34, 15254143629539, 1526364237);
INSERT INTO `bbgshop_footprint` VALUES (2383, 34, 15254143629539, 1526364253);
INSERT INTO `bbgshop_footprint` VALUES (2384, 34, 841662, 1526364262);
INSERT INTO `bbgshop_footprint` VALUES (2385, 34, 15254143629539, 1526364287);
INSERT INTO `bbgshop_footprint` VALUES (2386, 34, 15254143629539, 1526364296);
INSERT INTO `bbgshop_footprint` VALUES (2387, 34, 841662, 1526364306);
INSERT INTO `bbgshop_footprint` VALUES (2388, 34, 15254143629539, 1526364322);
INSERT INTO `bbgshop_footprint` VALUES (2389, 34, 841662, 1526364326);
INSERT INTO `bbgshop_footprint` VALUES (2390, 34, 15254143629539, 1526364356);
INSERT INTO `bbgshop_footprint` VALUES (2391, 34, 841662, 1526364365);
INSERT INTO `bbgshop_footprint` VALUES (2392, 34, 15254143629539, 1526364378);
INSERT INTO `bbgshop_footprint` VALUES (2393, 34, 15254143629539, 1526364464);
INSERT INTO `bbgshop_footprint` VALUES (2394, 34, 15254143629539, 1526364495);
INSERT INTO `bbgshop_footprint` VALUES (2395, 34, 15254143629539, 1526364508);
INSERT INTO `bbgshop_footprint` VALUES (2396, 34, 15254143629539, 1526364585);
INSERT INTO `bbgshop_footprint` VALUES (2397, 34, 15254143629539, 1526364624);
INSERT INTO `bbgshop_footprint` VALUES (2398, 34, 15254143629539, 1526364646);
INSERT INTO `bbgshop_footprint` VALUES (2399, 34, 15254143629539, 1526365248);
INSERT INTO `bbgshop_footprint` VALUES (2400, 34, 15254143629539, 1526365282);
INSERT INTO `bbgshop_footprint` VALUES (2401, 34, 15254143629539, 1526365373);
INSERT INTO `bbgshop_footprint` VALUES (2402, 34, 15254143629539, 1526365443);
INSERT INTO `bbgshop_footprint` VALUES (2403, 34, 15254143629539, 1526365453);
INSERT INTO `bbgshop_footprint` VALUES (2404, 34, 15254143629539, 1526365470);
INSERT INTO `bbgshop_footprint` VALUES (2405, 34, 15254143629539, 1526365481);
INSERT INTO `bbgshop_footprint` VALUES (2406, 34, 15254143629539, 1526365491);
INSERT INTO `bbgshop_footprint` VALUES (2407, 34, 15254143629539, 1526365911);
INSERT INTO `bbgshop_footprint` VALUES (2408, 34, 15254143629539, 1526366083);
INSERT INTO `bbgshop_footprint` VALUES (2409, 34, 15254143629539, 1526366140);
INSERT INTO `bbgshop_footprint` VALUES (2410, 34, 15254143629539, 1526366156);
INSERT INTO `bbgshop_footprint` VALUES (2411, 34, 15254143629539, 1526369923);
INSERT INTO `bbgshop_footprint` VALUES (2412, 34, 15254143629539, 1526370013);
INSERT INTO `bbgshop_footprint` VALUES (2413, 34, 15254143629539, 1526370144);
INSERT INTO `bbgshop_footprint` VALUES (2414, 34, 15254143629539, 1526372017);
INSERT INTO `bbgshop_footprint` VALUES (2415, 34, 15254143629539, 1526372044);
INSERT INTO `bbgshop_footprint` VALUES (2416, 34, 15254143629539, 1526431212);
INSERT INTO `bbgshop_footprint` VALUES (2417, 34, 15254143629539, 1526431487);
INSERT INTO `bbgshop_footprint` VALUES (2418, 34, 15254143629539, 1526431849);
INSERT INTO `bbgshop_footprint` VALUES (2419, 34, 15254143629539, 1526434242);
INSERT INTO `bbgshop_footprint` VALUES (2420, 34, 841662, 1526434387);
INSERT INTO `bbgshop_footprint` VALUES (2421, 34, 369904, 1526434404);
INSERT INTO `bbgshop_footprint` VALUES (2422, 34, 15254143629539, 1526434579);
INSERT INTO `bbgshop_footprint` VALUES (2423, 34, 15254143629539, 1526434611);
INSERT INTO `bbgshop_footprint` VALUES (2424, 34, 15254143629539, 1526438429);
INSERT INTO `bbgshop_footprint` VALUES (2425, 34, 15254143629539, 1526439021);
INSERT INTO `bbgshop_footprint` VALUES (2426, 34, 1525506079804257, 1526439051);
INSERT INTO `bbgshop_footprint` VALUES (2427, 34, 1525506079804257, 1526443133);
INSERT INTO `bbgshop_footprint` VALUES (2428, 34, 1525506079804257, 1526443284);
INSERT INTO `bbgshop_footprint` VALUES (2429, 34, 15254143629539, 1526445719);
INSERT INTO `bbgshop_footprint` VALUES (2430, 34, 1525506079804257, 1526445722);
INSERT INTO `bbgshop_footprint` VALUES (2431, 34, 1525506079804257, 1526446182);
INSERT INTO `bbgshop_footprint` VALUES (2432, 34, 1525506079804257, 1526446258);
INSERT INTO `bbgshop_footprint` VALUES (2433, 34, 1525506079804257, 1526447516);
INSERT INTO `bbgshop_footprint` VALUES (2434, 34, 1525506079804257, 1526447724);
INSERT INTO `bbgshop_footprint` VALUES (2435, 34, 1525506079804257, 1526447760);
INSERT INTO `bbgshop_footprint` VALUES (2436, 34, 1525506079804257, 1526447862);
INSERT INTO `bbgshop_footprint` VALUES (2437, 34, 1525506079804257, 1526449220);
INSERT INTO `bbgshop_footprint` VALUES (2438, 34, 1525506079804257, 1526449457);
INSERT INTO `bbgshop_footprint` VALUES (2439, 34, 1525506079804257, 1526449460);
INSERT INTO `bbgshop_footprint` VALUES (2440, 34, 1525506079804257, 1526449465);
INSERT INTO `bbgshop_footprint` VALUES (2441, 34, 1525506079804257, 1526449509);
INSERT INTO `bbgshop_footprint` VALUES (2442, 34, 1525506079804257, 1526449955);
INSERT INTO `bbgshop_footprint` VALUES (2443, 34, 1525506079804257, 1526450050);
INSERT INTO `bbgshop_footprint` VALUES (2444, 34, 1525506079804257, 1526450058);
INSERT INTO `bbgshop_footprint` VALUES (2445, 34, 1525506079804257, 1526452126);
INSERT INTO `bbgshop_footprint` VALUES (2446, 34, 15254143629539, 1526452177);
INSERT INTO `bbgshop_footprint` VALUES (2447, 34, 1525506079804257, 1526452543);
INSERT INTO `bbgshop_footprint` VALUES (2448, 34, 15254143629539, 1526453584);
INSERT INTO `bbgshop_footprint` VALUES (2449, 34, 15254143629539, 1526453648);
INSERT INTO `bbgshop_footprint` VALUES (2450, 34, 1525506079804257, 1526454911);
INSERT INTO `bbgshop_footprint` VALUES (2451, 34, 1525506079804257, 1526455131);
INSERT INTO `bbgshop_footprint` VALUES (2452, 34, 1525506079804257, 1526455208);
INSERT INTO `bbgshop_footprint` VALUES (2453, 34, 1525506079804257, 1526455298);
INSERT INTO `bbgshop_footprint` VALUES (2454, 34, 1525506079804257, 1526455378);
INSERT INTO `bbgshop_footprint` VALUES (2455, 34, 1525506079804257, 1526455484);
INSERT INTO `bbgshop_footprint` VALUES (2456, 34, 1525506079804257, 1526455812);
INSERT INTO `bbgshop_footprint` VALUES (2457, 34, 1525506079804257, 1526461576);
INSERT INTO `bbgshop_footprint` VALUES (2458, 34, 813924, 1526461905);
INSERT INTO `bbgshop_footprint` VALUES (2459, 34, 1525506079804257, 1526519897);
INSERT INTO `bbgshop_footprint` VALUES (2460, 34, 1525506079804257, 1526520156);
INSERT INTO `bbgshop_footprint` VALUES (2461, 34, 1525506079804257, 1526520253);
INSERT INTO `bbgshop_footprint` VALUES (2462, 34, 1525506079804257, 1526520278);
INSERT INTO `bbgshop_footprint` VALUES (2463, 34, 1525506079804257, 1526520419);
INSERT INTO `bbgshop_footprint` VALUES (2464, 34, 1525506079804257, 1526521215);
INSERT INTO `bbgshop_footprint` VALUES (2465, 34, 1525506079804257, 1526521735);
INSERT INTO `bbgshop_footprint` VALUES (2466, 34, 1525506079804257, 1526521854);
INSERT INTO `bbgshop_footprint` VALUES (2467, 34, 1525506079804257, 1526521930);
INSERT INTO `bbgshop_footprint` VALUES (2468, 34, 1525506079804257, 1526522023);
INSERT INTO `bbgshop_footprint` VALUES (2469, 34, 1525506079804257, 1526522052);
INSERT INTO `bbgshop_footprint` VALUES (2470, 34, 1525506079804257, 1526522098);
INSERT INTO `bbgshop_footprint` VALUES (2471, 34, 1525506079804257, 1526522140);
INSERT INTO `bbgshop_footprint` VALUES (2472, 34, 1525506079804257, 1526522172);
INSERT INTO `bbgshop_footprint` VALUES (2473, 34, 841662, 1526525780);
INSERT INTO `bbgshop_footprint` VALUES (2474, 34, 1525506079804257, 1526534297);
INSERT INTO `bbgshop_footprint` VALUES (2475, 34, 841662, 1526534299);
INSERT INTO `bbgshop_footprint` VALUES (2476, 34, 1525506079804257, 1526534378);
INSERT INTO `bbgshop_footprint` VALUES (2477, 34, 841662, 1526534380);
INSERT INTO `bbgshop_footprint` VALUES (2478, 34, 1525506079804257, 1526534727);
INSERT INTO `bbgshop_footprint` VALUES (2479, 34, 841662, 1526534729);
INSERT INTO `bbgshop_footprint` VALUES (2480, 34, 841662, 1526535731);
INSERT INTO `bbgshop_footprint` VALUES (2481, 34, 841662, 1526549147);
INSERT INTO `bbgshop_footprint` VALUES (2482, 34, 841662, 1526550822);
INSERT INTO `bbgshop_footprint` VALUES (2483, 34, 841662, 1526550910);
INSERT INTO `bbgshop_footprint` VALUES (2484, 34, 841662, 1526604534);
INSERT INTO `bbgshop_footprint` VALUES (2485, 34, 813924, 1526606942);
INSERT INTO `bbgshop_footprint` VALUES (2486, 34, 15254143629539, 1526606962);
INSERT INTO `bbgshop_footprint` VALUES (2487, 34, 841662, 1526607361);
INSERT INTO `bbgshop_footprint` VALUES (2488, 34, 841662, 1526608377);
INSERT INTO `bbgshop_footprint` VALUES (2489, 34, 841662, 1526612388);
INSERT INTO `bbgshop_footprint` VALUES (2490, 34, 841662, 1526612554);
INSERT INTO `bbgshop_footprint` VALUES (2491, 34, 841662, 1526612765);
INSERT INTO `bbgshop_footprint` VALUES (2492, 34, 841662, 1526612996);
INSERT INTO `bbgshop_footprint` VALUES (2493, 34, 1526709239314870, 1526709251);
INSERT INTO `bbgshop_footprint` VALUES (2494, 34, 1526709239314870, 1526710557);
INSERT INTO `bbgshop_footprint` VALUES (2495, 34, 636004, 1526714861);
INSERT INTO `bbgshop_footprint` VALUES (2496, 34, 841662, 1526714864);
INSERT INTO `bbgshop_footprint` VALUES (2497, 34, 1526709239314870, 1526714930);
INSERT INTO `bbgshop_footprint` VALUES (2498, 34, 841662, 1526714938);
INSERT INTO `bbgshop_footprint` VALUES (2499, 34, 1526709239314870, 1526715699);
INSERT INTO `bbgshop_footprint` VALUES (2500, 34, 636004, 1526715701);
INSERT INTO `bbgshop_footprint` VALUES (2501, 34, 1525506079804257, 1526715704);
INSERT INTO `bbgshop_footprint` VALUES (2502, 34, 841662, 1526715706);
INSERT INTO `bbgshop_footprint` VALUES (2503, 34, 841662, 1526715824);
INSERT INTO `bbgshop_footprint` VALUES (2504, 34, 636004, 1526716263);
INSERT INTO `bbgshop_footprint` VALUES (2505, 34, 841662, 1526716266);
INSERT INTO `bbgshop_footprint` VALUES (2506, 34, 841662, 1526716378);
INSERT INTO `bbgshop_footprint` VALUES (2507, 34, 813924, 1526717162);
INSERT INTO `bbgshop_footprint` VALUES (2508, 34, 15254143629539, 1526717164);
INSERT INTO `bbgshop_footprint` VALUES (2509, 34, 1526709239314870, 1526862560);
INSERT INTO `bbgshop_footprint` VALUES (2510, 34, 1526709239314870, 1526862700);
INSERT INTO `bbgshop_footprint` VALUES (2511, 34, 1526709239314870, 1526862792);
INSERT INTO `bbgshop_footprint` VALUES (2512, 34, 1526709239314870, 1526862823);
INSERT INTO `bbgshop_footprint` VALUES (2513, 34, 1526709239314870, 1526862886);
INSERT INTO `bbgshop_footprint` VALUES (2514, 34, 1526709239314870, 1526863045);
INSERT INTO `bbgshop_footprint` VALUES (2515, 34, 1526709239314870, 1526863130);
INSERT INTO `bbgshop_footprint` VALUES (2516, 34, 636004, 1526863133);
INSERT INTO `bbgshop_footprint` VALUES (2517, 34, 841662, 1526863147);
INSERT INTO `bbgshop_footprint` VALUES (2518, 34, 636004, 1526863166);
INSERT INTO `bbgshop_footprint` VALUES (2519, 34, 841662, 1526863194);
INSERT INTO `bbgshop_footprint` VALUES (2520, 34, 1526709239314870, 1526863430);
INSERT INTO `bbgshop_footprint` VALUES (2521, 34, 841662, 1526863621);
INSERT INTO `bbgshop_footprint` VALUES (2522, 34, 841662, 1526863622);
INSERT INTO `bbgshop_footprint` VALUES (2523, 34, 1526709239314870, 1526863625);
INSERT INTO `bbgshop_footprint` VALUES (2524, 34, 1526709239314870, 1526863667);
INSERT INTO `bbgshop_footprint` VALUES (2525, 34, 1526709239314870, 1526863869);
INSERT INTO `bbgshop_footprint` VALUES (2526, 34, 636004, 1526863885);
INSERT INTO `bbgshop_footprint` VALUES (2527, 34, 841662, 1526863888);
INSERT INTO `bbgshop_footprint` VALUES (2528, 34, 1526709239314870, 1526863930);
INSERT INTO `bbgshop_footprint` VALUES (2529, 34, 636004, 1526866263);
INSERT INTO `bbgshop_footprint` VALUES (2530, 34, 1526709239314870, 1526866291);
INSERT INTO `bbgshop_footprint` VALUES (2531, 34, 841662, 1526867210);
INSERT INTO `bbgshop_footprint` VALUES (2532, 34, 369000, 1526867224);
INSERT INTO `bbgshop_footprint` VALUES (2533, 34, 622336, 1526867292);
INSERT INTO `bbgshop_footprint` VALUES (2534, 34, 369000, 1526867365);
INSERT INTO `bbgshop_footprint` VALUES (2535, 34, 841662, 1526867444);
INSERT INTO `bbgshop_footprint` VALUES (2536, 34, 369904, 1526867452);
INSERT INTO `bbgshop_footprint` VALUES (2537, 34, 622336, 1526867710);
INSERT INTO `bbgshop_footprint` VALUES (2538, 34, 1525506079804257, 1526868214);
INSERT INTO `bbgshop_footprint` VALUES (2539, 34, 841662, 1526868549);
INSERT INTO `bbgshop_footprint` VALUES (2540, 34, 1525506079804257, 1526868653);
INSERT INTO `bbgshop_footprint` VALUES (2541, 34, 1526709239314870, 1526870215);
INSERT INTO `bbgshop_footprint` VALUES (2542, 34, 841662, 1526870570);
INSERT INTO `bbgshop_footprint` VALUES (2543, 34, 1526709239314870, 1526870572);
INSERT INTO `bbgshop_footprint` VALUES (2544, 34, 1526709239314870, 1526870581);
INSERT INTO `bbgshop_footprint` VALUES (2545, 34, 15254143629539, 1526870617);
INSERT INTO `bbgshop_footprint` VALUES (2546, 34, 813924, 1526870626);
INSERT INTO `bbgshop_footprint` VALUES (2547, 34, 1526709239314870, 1526870660);
INSERT INTO `bbgshop_footprint` VALUES (2548, 34, 636004, 1526872928);
INSERT INTO `bbgshop_footprint` VALUES (2549, 34, 1526709239314870, 1526879842);
INSERT INTO `bbgshop_footprint` VALUES (2550, 34, 1526709239314870, 1526879859);
INSERT INTO `bbgshop_footprint` VALUES (2551, 34, 369000, 1526881338);
INSERT INTO `bbgshop_footprint` VALUES (2552, 34, 1526709239314870, 1526884714);
INSERT INTO `bbgshop_footprint` VALUES (2553, 34, 1526709239314870, 1526884978);
INSERT INTO `bbgshop_footprint` VALUES (2554, 34, 1526709239314870, 1526885206);
INSERT INTO `bbgshop_footprint` VALUES (2555, 34, 1526709239314870, 1526885298);
INSERT INTO `bbgshop_footprint` VALUES (2556, 34, 1526709239314870, 1526885485);
INSERT INTO `bbgshop_footprint` VALUES (2557, 34, 841662, 1526886733);
INSERT INTO `bbgshop_footprint` VALUES (2558, 34, 1526709239314870, 1526886737);
INSERT INTO `bbgshop_footprint` VALUES (2559, 34, 1526709239314870, 1526886945);
INSERT INTO `bbgshop_footprint` VALUES (2560, 34, 841662, 1526888110);
INSERT INTO `bbgshop_footprint` VALUES (2561, 34, 1526709239314870, 1526888878);
INSERT INTO `bbgshop_footprint` VALUES (2562, 34, 841662, 1526888882);
INSERT INTO `bbgshop_footprint` VALUES (2563, 34, 841662, 1526889063);
INSERT INTO `bbgshop_footprint` VALUES (2564, 34, 15254143629539, 1526889709);
INSERT INTO `bbgshop_footprint` VALUES (2565, 34, 15254143629539, 1526889724);
INSERT INTO `bbgshop_footprint` VALUES (2566, 34, 1525506079804257, 1526889768);
INSERT INTO `bbgshop_footprint` VALUES (2567, 34, 841662, 1526891790);
INSERT INTO `bbgshop_footprint` VALUES (2568, 34, 1525506079804257, 1526891834);
INSERT INTO `bbgshop_footprint` VALUES (2569, 34, 636004, 1526892191);
INSERT INTO `bbgshop_footprint` VALUES (2570, 34, 841662, 1526892193);
INSERT INTO `bbgshop_footprint` VALUES (2571, 34, 841662, 1526892214);
INSERT INTO `bbgshop_footprint` VALUES (2572, 34, 1525506079804257, 1526892255);
INSERT INTO `bbgshop_footprint` VALUES (2573, 34, 1525506079804257, 1526892388);
INSERT INTO `bbgshop_footprint` VALUES (2574, 34, 841662, 1526892666);
INSERT INTO `bbgshop_footprint` VALUES (2575, 34, 841662, 1526892862);
INSERT INTO `bbgshop_footprint` VALUES (2576, 34, 1526709239314870, 1526892917);
INSERT INTO `bbgshop_footprint` VALUES (2577, 34, 1525506079804257, 1526893017);
INSERT INTO `bbgshop_footprint` VALUES (2578, 34, 1526709239314870, 1526893163);
INSERT INTO `bbgshop_footprint` VALUES (2579, 34, 1526709239314870, 1526893523);
INSERT INTO `bbgshop_footprint` VALUES (2580, 34, 622336, 1526893540);
INSERT INTO `bbgshop_footprint` VALUES (2581, 34, 813924, 1526893645);
INSERT INTO `bbgshop_footprint` VALUES (2582, 34, 841662, 1526893943);
INSERT INTO `bbgshop_footprint` VALUES (2583, 34, 1525506079804257, 1526893996);
INSERT INTO `bbgshop_footprint` VALUES (2584, 34, 841662, 1526894228);
INSERT INTO `bbgshop_footprint` VALUES (2585, 34, 841662, 1526894256);
INSERT INTO `bbgshop_footprint` VALUES (2586, 34, 1526709239314870, 1526894279);
INSERT INTO `bbgshop_footprint` VALUES (2587, 34, 1526709239314870, 1526894676);
INSERT INTO `bbgshop_footprint` VALUES (2588, 34, 841662, 1526894721);
INSERT INTO `bbgshop_footprint` VALUES (2589, 34, 841662, 1526894746);
INSERT INTO `bbgshop_footprint` VALUES (2590, 34, 841662, 1526895230);
INSERT INTO `bbgshop_footprint` VALUES (2591, 34, 1526709239314870, 1526949334);
INSERT INTO `bbgshop_footprint` VALUES (2592, 34, 841662, 1526949345);
INSERT INTO `bbgshop_footprint` VALUES (2593, 34, 1526709239314870, 1526951978);
INSERT INTO `bbgshop_footprint` VALUES (2594, 34, 1526709239314870, 1526952862);
INSERT INTO `bbgshop_footprint` VALUES (2595, 34, 1526709239314870, 1526954173);
INSERT INTO `bbgshop_footprint` VALUES (2596, 34, 841662, 1526954185);
INSERT INTO `bbgshop_footprint` VALUES (2597, 34, 1526709239314870, 1526954249);
INSERT INTO `bbgshop_footprint` VALUES (2598, 34, 1526709239314870, 1526954487);
INSERT INTO `bbgshop_footprint` VALUES (2599, 34, 1526709239314870, 1526954581);
INSERT INTO `bbgshop_footprint` VALUES (2600, 34, 369000, 1526954777);
INSERT INTO `bbgshop_footprint` VALUES (2601, 34, 88319, 1526955289);
INSERT INTO `bbgshop_footprint` VALUES (2602, 34, 1526709239314870, 1526955335);
INSERT INTO `bbgshop_footprint` VALUES (2603, 34, 1526709239314870, 1526959706);
INSERT INTO `bbgshop_footprint` VALUES (2604, 34, 1526709239314870, 1526964361);
INSERT INTO `bbgshop_footprint` VALUES (2605, 34, 841662, 1526964364);
INSERT INTO `bbgshop_footprint` VALUES (2606, 34, 841662, 1526964847);
INSERT INTO `bbgshop_footprint` VALUES (2607, 34, 841662, 1526964894);
INSERT INTO `bbgshop_footprint` VALUES (2608, 34, 841662, 1526967694);
INSERT INTO `bbgshop_footprint` VALUES (2609, 34, 1526709239314870, 1526975003);
INSERT INTO `bbgshop_footprint` VALUES (2610, 34, 841662, 1526975007);
INSERT INTO `bbgshop_footprint` VALUES (2611, 34, 841662, 1526975049);
INSERT INTO `bbgshop_footprint` VALUES (2612, 34, 813924, 1526975145);
INSERT INTO `bbgshop_footprint` VALUES (2613, 34, 813924, 1526975156);
INSERT INTO `bbgshop_footprint` VALUES (2614, 34, 813924, 1526975271);
INSERT INTO `bbgshop_footprint` VALUES (2615, 34, 813924, 1526975301);
INSERT INTO `bbgshop_footprint` VALUES (2616, 34, 813924, 1526975338);
INSERT INTO `bbgshop_footprint` VALUES (2617, 34, 813924, 1526975466);
INSERT INTO `bbgshop_footprint` VALUES (2618, 34, 813924, 1526975696);
INSERT INTO `bbgshop_footprint` VALUES (2619, 34, 841662, 1526975762);
INSERT INTO `bbgshop_footprint` VALUES (2620, 34, 15254143629539, 1526975779);
INSERT INTO `bbgshop_footprint` VALUES (2621, 34, 813924, 1526975860);
INSERT INTO `bbgshop_footprint` VALUES (2622, 34, 1526709239314870, 1526975896);
INSERT INTO `bbgshop_footprint` VALUES (2623, 34, 841662, 1526975900);
INSERT INTO `bbgshop_footprint` VALUES (2624, 34, 841662, 1526976389);
INSERT INTO `bbgshop_footprint` VALUES (2625, 34, 1526709239314870, 1526976394);
INSERT INTO `bbgshop_footprint` VALUES (2626, 34, 1526709239314870, 1526976454);
INSERT INTO `bbgshop_footprint` VALUES (2627, 34, 1526709239314870, 1526976474);
INSERT INTO `bbgshop_footprint` VALUES (2628, 34, 1526709239314870, 1526976488);
INSERT INTO `bbgshop_footprint` VALUES (2629, 34, 1526709239314870, 1526976502);
INSERT INTO `bbgshop_footprint` VALUES (2630, 34, 1526709239314870, 1526976567);
INSERT INTO `bbgshop_footprint` VALUES (2631, 34, 841662, 1526976618);
INSERT INTO `bbgshop_footprint` VALUES (2632, 34, 1525506079804257, 1526976645);
INSERT INTO `bbgshop_footprint` VALUES (2633, 34, 841662, 1526976670);
INSERT INTO `bbgshop_footprint` VALUES (2634, 34, 1526709239314870, 1526976741);
INSERT INTO `bbgshop_footprint` VALUES (2635, 34, 841662, 1526976746);
INSERT INTO `bbgshop_footprint` VALUES (2636, 34, 83888, 1526976753);
INSERT INTO `bbgshop_footprint` VALUES (2637, 34, 1526709239314870, 1526976823);
INSERT INTO `bbgshop_footprint` VALUES (2638, 34, 1526709239314870, 1526976830);
INSERT INTO `bbgshop_footprint` VALUES (2639, 34, 841662, 1526976839);
INSERT INTO `bbgshop_footprint` VALUES (2640, 34, 841662, 1526976939);
INSERT INTO `bbgshop_footprint` VALUES (2641, 34, 841662, 1526976943);
INSERT INTO `bbgshop_footprint` VALUES (2642, 34, 841662, 1526977001);
INSERT INTO `bbgshop_footprint` VALUES (2643, 34, 1526709239314870, 1527037320);
INSERT INTO `bbgshop_footprint` VALUES (2644, 34, 636004, 1527046399);
INSERT INTO `bbgshop_footprint` VALUES (2645, 34, 1526709239314870, 1527050357);
INSERT INTO `bbgshop_footprint` VALUES (2646, 34, 636004, 1527050939);
INSERT INTO `bbgshop_footprint` VALUES (2647, 34, 1526709239314870, 1527050948);
INSERT INTO `bbgshop_footprint` VALUES (2648, 34, 1525506079804257, 1527050954);
INSERT INTO `bbgshop_footprint` VALUES (2649, 34, 841662, 1527050962);
INSERT INTO `bbgshop_footprint` VALUES (2650, 34, 1526709239314870, 1527054134);
INSERT INTO `bbgshop_footprint` VALUES (2651, 34, 1526709239314870, 1527055008);
INSERT INTO `bbgshop_footprint` VALUES (2652, 34, 1526709239314870, 1527055134);
INSERT INTO `bbgshop_footprint` VALUES (2653, 34, 636004, 1527055153);
INSERT INTO `bbgshop_footprint` VALUES (2654, 34, 1526709239314870, 1527055259);
INSERT INTO `bbgshop_footprint` VALUES (2655, 34, 636004, 1527055341);
INSERT INTO `bbgshop_footprint` VALUES (2656, 34, 1526709239314870, 1527055346);
INSERT INTO `bbgshop_footprint` VALUES (2657, 34, 1526709239314870, 1527055385);
INSERT INTO `bbgshop_footprint` VALUES (2658, 34, 636004, 1527055395);
INSERT INTO `bbgshop_footprint` VALUES (2659, 34, 1526709239314870, 1527055424);
INSERT INTO `bbgshop_footprint` VALUES (2660, 34, 636004, 1527055472);
INSERT INTO `bbgshop_footprint` VALUES (2661, 34, 636004, 1527055498);
INSERT INTO `bbgshop_footprint` VALUES (2662, 34, 1526709239314870, 1527055509);
INSERT INTO `bbgshop_footprint` VALUES (2663, 34, 636004, 1527055528);
INSERT INTO `bbgshop_footprint` VALUES (2664, 34, 636004, 1527055535);
INSERT INTO `bbgshop_footprint` VALUES (2665, 34, 1526709239314870, 1527055555);
INSERT INTO `bbgshop_footprint` VALUES (2666, 34, 1526709239314870, 1527055611);
INSERT INTO `bbgshop_footprint` VALUES (2667, 34, 636004, 1527055618);
INSERT INTO `bbgshop_footprint` VALUES (2668, 34, 1525506079804257, 1527055629);
INSERT INTO `bbgshop_footprint` VALUES (2669, 34, 841662, 1527055632);
INSERT INTO `bbgshop_footprint` VALUES (2670, 34, 1526709239314870, 1527055644);
INSERT INTO `bbgshop_footprint` VALUES (2671, 34, 841662, 1527056677);
INSERT INTO `bbgshop_footprint` VALUES (2672, 34, 636004, 1527122425);
INSERT INTO `bbgshop_footprint` VALUES (2673, 32, 1526709239314870, 1527136911);
INSERT INTO `bbgshop_footprint` VALUES (2674, 32, 841662, 1527137324);
INSERT INTO `bbgshop_footprint` VALUES (2675, 34, 841662, 1527137361);
INSERT INTO `bbgshop_footprint` VALUES (2676, 34, 1526709239314870, 1527139326);
INSERT INTO `bbgshop_footprint` VALUES (2677, 34, 841662, 1527139463);
INSERT INTO `bbgshop_footprint` VALUES (2678, 34, 841662, 1527140147);
INSERT INTO `bbgshop_footprint` VALUES (2679, 34, 1526709239314870, 1527141416);
INSERT INTO `bbgshop_footprint` VALUES (2680, 34, 1526709239314870, 1527141446);
INSERT INTO `bbgshop_footprint` VALUES (2681, 34, 841662, 1527144452);
INSERT INTO `bbgshop_footprint` VALUES (2682, 34, 83888, 1527144459);
INSERT INTO `bbgshop_footprint` VALUES (2683, 34, 369904, 1527144494);
INSERT INTO `bbgshop_footprint` VALUES (2684, 34, 369904, 1527144565);
INSERT INTO `bbgshop_footprint` VALUES (2685, 34, 841662, 1527144660);
INSERT INTO `bbgshop_footprint` VALUES (2686, 34, 15254143629539, 1527145344);
INSERT INTO `bbgshop_footprint` VALUES (2687, 34, 841662, 1527146142);
INSERT INTO `bbgshop_footprint` VALUES (2688, 34, 813924, 1527146299);
INSERT INTO `bbgshop_footprint` VALUES (2689, 34, 1526709239314870, 1527146429);
INSERT INTO `bbgshop_footprint` VALUES (2690, 34, 841662, 1527146621);
INSERT INTO `bbgshop_footprint` VALUES (2691, 34, 636004, 1527146625);
INSERT INTO `bbgshop_footprint` VALUES (2692, 34, 1526709239314870, 1527146628);
INSERT INTO `bbgshop_footprint` VALUES (2693, 34, 813924, 1527153743);
INSERT INTO `bbgshop_footprint` VALUES (2694, 34, 813924, 1527154059);
INSERT INTO `bbgshop_footprint` VALUES (2695, 34, 813924, 1527155705);
INSERT INTO `bbgshop_footprint` VALUES (2696, 34, 813924, 1527155748);
INSERT INTO `bbgshop_footprint` VALUES (2697, 34, 813924, 1527155768);
INSERT INTO `bbgshop_footprint` VALUES (2698, 34, 813924, 1527155836);
INSERT INTO `bbgshop_footprint` VALUES (2699, 34, 813924, 1527155873);
INSERT INTO `bbgshop_footprint` VALUES (2700, 34, 813924, 1527155935);
INSERT INTO `bbgshop_footprint` VALUES (2701, 34, 813924, 1527155979);
INSERT INTO `bbgshop_footprint` VALUES (2702, 34, 813924, 1527156015);
INSERT INTO `bbgshop_footprint` VALUES (2703, 34, 813924, 1527156037);
INSERT INTO `bbgshop_footprint` VALUES (2704, 34, 813924, 1527156049);
INSERT INTO `bbgshop_footprint` VALUES (2705, 34, 813924, 1527156172);
INSERT INTO `bbgshop_footprint` VALUES (2706, 34, 813924, 1527156186);
INSERT INTO `bbgshop_footprint` VALUES (2707, 34, 813924, 1527156304);
INSERT INTO `bbgshop_footprint` VALUES (2708, 34, 813924, 1527156321);
INSERT INTO `bbgshop_footprint` VALUES (2709, 34, 813924, 1527156363);
INSERT INTO `bbgshop_footprint` VALUES (2710, 34, 813924, 1527156395);
INSERT INTO `bbgshop_footprint` VALUES (2711, 34, 813924, 1527156535);
INSERT INTO `bbgshop_footprint` VALUES (2712, 34, 813924, 1527156576);
INSERT INTO `bbgshop_footprint` VALUES (2713, 34, 813924, 1527156780);
INSERT INTO `bbgshop_footprint` VALUES (2714, 34, 813924, 1527156803);
INSERT INTO `bbgshop_footprint` VALUES (2715, 34, 813924, 1527156843);
INSERT INTO `bbgshop_footprint` VALUES (2716, 34, 1525506079804257, 1527211609);
INSERT INTO `bbgshop_footprint` VALUES (2717, 34, 813924, 1527224864);
INSERT INTO `bbgshop_footprint` VALUES (2718, 34, 841662, 1527226374);
INSERT INTO `bbgshop_footprint` VALUES (2719, 34, 841662, 1527226625);
INSERT INTO `bbgshop_footprint` VALUES (2720, 32, 841662, 1527325081);
INSERT INTO `bbgshop_footprint` VALUES (2721, 32, 1526709239314870, 1527325088);
INSERT INTO `bbgshop_footprint` VALUES (2722, 32, 1527312668458729, 1527325271);
INSERT INTO `bbgshop_footprint` VALUES (2723, 34, 504504, 1527325368);
INSERT INTO `bbgshop_footprint` VALUES (2724, 34, 428513, 1527325410);
INSERT INTO `bbgshop_footprint` VALUES (2725, 34, 1527312668458729, 1527646798);
INSERT INTO `bbgshop_footprint` VALUES (2726, 34, 1526709239314870, 1527648629);
INSERT INTO `bbgshop_footprint` VALUES (2727, 34, 1527312668458729, 1527901381);
INSERT INTO `bbgshop_footprint` VALUES (2728, 34, 636004, 1527909665);
INSERT INTO `bbgshop_footprint` VALUES (2729, 34, 1527312668458729, 1527915474);
INSERT INTO `bbgshop_footprint` VALUES (2730, 34, 813924, 1527915481);
INSERT INTO `bbgshop_footprint` VALUES (2731, 34, 813924, 1527915519);
INSERT INTO `bbgshop_footprint` VALUES (2732, 34, 1526709239314870, 1527915730);
INSERT INTO `bbgshop_footprint` VALUES (2733, 34, 636004, 1527920304);
INSERT INTO `bbgshop_footprint` VALUES (2734, 34, 841662, 1527920397);
INSERT INTO `bbgshop_footprint` VALUES (2735, 34, 1525506079804257, 1527920553);
INSERT INTO `bbgshop_footprint` VALUES (2736, 32, 841662, 1528078610);
INSERT INTO `bbgshop_footprint` VALUES (2737, 34, 813924, 1528078779);
INSERT INTO `bbgshop_footprint` VALUES (2738, 34, 841662, 1528080967);
INSERT INTO `bbgshop_footprint` VALUES (2739, 34, 813924, 1528080977);
INSERT INTO `bbgshop_footprint` VALUES (2740, 34, 813924, 1528081003);
INSERT INTO `bbgshop_footprint` VALUES (2741, 34, 636004, 1528090917);
INSERT INTO `bbgshop_footprint` VALUES (2742, 34, 841662, 1528090921);
INSERT INTO `bbgshop_footprint` VALUES (2743, 34, 636004, 1528091545);
INSERT INTO `bbgshop_footprint` VALUES (2744, 34, 519375, 1528091874);
INSERT INTO `bbgshop_footprint` VALUES (2745, 34, 477300, 1528091955);
INSERT INTO `bbgshop_footprint` VALUES (2746, 34, 104223, 1528092328);
INSERT INTO `bbgshop_footprint` VALUES (2747, 34, 636004, 1528095519);
INSERT INTO `bbgshop_footprint` VALUES (2748, 34, 841662, 1528095521);
INSERT INTO `bbgshop_footprint` VALUES (2749, 34, 636004, 1528095540);
INSERT INTO `bbgshop_footprint` VALUES (2750, 34, 841662, 1528096401);
INSERT INTO `bbgshop_footprint` VALUES (2751, 34, 636004, 1528160978);
INSERT INTO `bbgshop_footprint` VALUES (2752, 34, 841662, 1528161204);
INSERT INTO `bbgshop_footprint` VALUES (2753, 34, 636004, 1528161208);
INSERT INTO `bbgshop_footprint` VALUES (2754, 34, 841662, 1528161424);
INSERT INTO `bbgshop_footprint` VALUES (2755, 34, 636004, 1528161435);
INSERT INTO `bbgshop_footprint` VALUES (2756, 34, 841662, 1528161490);
INSERT INTO `bbgshop_footprint` VALUES (2757, 34, 477300, 1528161494);
INSERT INTO `bbgshop_footprint` VALUES (2758, 34, 636004, 1528161651);
INSERT INTO `bbgshop_footprint` VALUES (2759, 34, 636004, 1528161864);
INSERT INTO `bbgshop_footprint` VALUES (2760, 34, 636004, 1528161989);
INSERT INTO `bbgshop_footprint` VALUES (2761, 34, 636004, 1528162236);
INSERT INTO `bbgshop_footprint` VALUES (2762, 34, 813924, 1528165439);
INSERT INTO `bbgshop_footprint` VALUES (2763, 34, 813924, 1528165474);
INSERT INTO `bbgshop_footprint` VALUES (2764, 34, 841662, 1528165616);
INSERT INTO `bbgshop_footprint` VALUES (2765, 34, 841662, 1528165722);
INSERT INTO `bbgshop_footprint` VALUES (2766, 34, 841662, 1528165784);
INSERT INTO `bbgshop_footprint` VALUES (2767, 34, 841662, 1528166087);
INSERT INTO `bbgshop_footprint` VALUES (2768, 34, 813924, 1528166104);
INSERT INTO `bbgshop_footprint` VALUES (2769, 34, 813924, 1528166356);
INSERT INTO `bbgshop_footprint` VALUES (2770, 34, 2832, 1528166975);
INSERT INTO `bbgshop_footprint` VALUES (2771, 34, 636004, 1528169307);
INSERT INTO `bbgshop_footprint` VALUES (2772, 34, 636004, 1528169494);
INSERT INTO `bbgshop_footprint` VALUES (2773, 34, 636004, 1528178667);
INSERT INTO `bbgshop_footprint` VALUES (2774, 34, 841662, 1528178679);
INSERT INTO `bbgshop_footprint` VALUES (2775, 34, 636004, 1528178691);
INSERT INTO `bbgshop_footprint` VALUES (2776, 34, 636004, 1528178706);
INSERT INTO `bbgshop_footprint` VALUES (2777, 34, 636004, 1528178718);
INSERT INTO `bbgshop_footprint` VALUES (2778, 34, 90706, 1528178741);
INSERT INTO `bbgshop_footprint` VALUES (2779, 34, 636004, 1528180453);
INSERT INTO `bbgshop_footprint` VALUES (2780, 34, 841662, 1528180466);
INSERT INTO `bbgshop_footprint` VALUES (2781, 34, 636004, 1528180723);
INSERT INTO `bbgshop_footprint` VALUES (2782, 34, 841662, 1528180726);
INSERT INTO `bbgshop_footprint` VALUES (2783, 34, 841662, 1528180751);
INSERT INTO `bbgshop_footprint` VALUES (2784, 34, 841662, 1528183204);
INSERT INTO `bbgshop_footprint` VALUES (2785, 34, 636004, 1528245490);
INSERT INTO `bbgshop_footprint` VALUES (2786, 34, 813924, 1528245580);
INSERT INTO `bbgshop_footprint` VALUES (2787, 34, 841662, 1528245698);
INSERT INTO `bbgshop_footprint` VALUES (2788, 34, 841662, 1528248890);
INSERT INTO `bbgshop_footprint` VALUES (2789, 34, 813924, 1528255402);
INSERT INTO `bbgshop_footprint` VALUES (2790, 34, 2832, 1528333549);
INSERT INTO `bbgshop_footprint` VALUES (2791, 34, 841662, 1528333745);
INSERT INTO `bbgshop_footprint` VALUES (2792, 34, 841662, 1528334035);
INSERT INTO `bbgshop_footprint` VALUES (2793, 34, 841662, 1528334088);
INSERT INTO `bbgshop_footprint` VALUES (2794, 34, 841662, 1528334114);
INSERT INTO `bbgshop_footprint` VALUES (2795, 34, 841662, 1528334139);
INSERT INTO `bbgshop_footprint` VALUES (2796, 34, 636004, 1528334166);
INSERT INTO `bbgshop_footprint` VALUES (2797, 34, 841662, 1528334190);
INSERT INTO `bbgshop_footprint` VALUES (2798, 34, 841662, 1528338146);
INSERT INTO `bbgshop_footprint` VALUES (2799, 34, 841662, 1528338159);
INSERT INTO `bbgshop_footprint` VALUES (2800, 34, 841662, 1528338357);
INSERT INTO `bbgshop_footprint` VALUES (2801, 34, 841662, 1528338688);
INSERT INTO `bbgshop_footprint` VALUES (2802, 34, 636004, 1528339228);
INSERT INTO `bbgshop_footprint` VALUES (2803, 34, 841662, 1528339321);
INSERT INTO `bbgshop_footprint` VALUES (2804, 34, 841662, 1528339459);
INSERT INTO `bbgshop_footprint` VALUES (2805, 34, 841662, 1528339497);
INSERT INTO `bbgshop_footprint` VALUES (2806, 34, 841662, 1528339521);
INSERT INTO `bbgshop_footprint` VALUES (2807, 34, 841662, 1528339581);
INSERT INTO `bbgshop_footprint` VALUES (2808, 34, 841662, 1528339772);
INSERT INTO `bbgshop_footprint` VALUES (2809, 34, 841662, 1528339808);
INSERT INTO `bbgshop_footprint` VALUES (2810, 34, 841662, 1528339901);
INSERT INTO `bbgshop_footprint` VALUES (2811, 34, 841662, 1528340085);
INSERT INTO `bbgshop_footprint` VALUES (2812, 34, 841662, 1528340341);
INSERT INTO `bbgshop_footprint` VALUES (2813, 34, 841662, 1528340355);
INSERT INTO `bbgshop_footprint` VALUES (2814, 34, 841662, 1528340415);
INSERT INTO `bbgshop_footprint` VALUES (2815, 34, 841662, 1528340585);
INSERT INTO `bbgshop_footprint` VALUES (2816, 34, 841662, 1528340614);
INSERT INTO `bbgshop_footprint` VALUES (2817, 34, 841662, 1528340657);
INSERT INTO `bbgshop_footprint` VALUES (2818, 34, 841662, 1528340713);
INSERT INTO `bbgshop_footprint` VALUES (2819, 34, 841662, 1528340737);
INSERT INTO `bbgshop_footprint` VALUES (2820, 34, 841662, 1528340835);
INSERT INTO `bbgshop_footprint` VALUES (2821, 34, 841662, 1528340991);
INSERT INTO `bbgshop_footprint` VALUES (2822, 34, 841662, 1528341057);
INSERT INTO `bbgshop_footprint` VALUES (2823, 34, 841662, 1528341427);
INSERT INTO `bbgshop_footprint` VALUES (2824, 34, 841662, 1528341505);
INSERT INTO `bbgshop_footprint` VALUES (2825, 34, 841662, 1528341785);
INSERT INTO `bbgshop_footprint` VALUES (2826, 34, 841662, 1528341860);
INSERT INTO `bbgshop_footprint` VALUES (2827, 34, 841662, 1528341905);
INSERT INTO `bbgshop_footprint` VALUES (2828, 34, 841662, 1528341979);
INSERT INTO `bbgshop_footprint` VALUES (2829, 34, 841662, 1528342093);
INSERT INTO `bbgshop_footprint` VALUES (2830, 34, 841662, 1528342313);
INSERT INTO `bbgshop_footprint` VALUES (2831, 34, 841662, 1528342360);
INSERT INTO `bbgshop_footprint` VALUES (2832, 34, 841662, 1528342657);
INSERT INTO `bbgshop_footprint` VALUES (2833, 34, 841662, 1528342666);
INSERT INTO `bbgshop_footprint` VALUES (2834, 34, 841662, 1528346166);
INSERT INTO `bbgshop_footprint` VALUES (2835, 34, 841662, 1528347059);
INSERT INTO `bbgshop_footprint` VALUES (2836, 34, 841662, 1528347079);
INSERT INTO `bbgshop_footprint` VALUES (2837, 34, 841662, 1528347127);
INSERT INTO `bbgshop_footprint` VALUES (2838, 34, 841662, 1528347226);
INSERT INTO `bbgshop_footprint` VALUES (2839, 34, 841662, 1528347240);
INSERT INTO `bbgshop_footprint` VALUES (2840, 34, 841662, 1528347266);
INSERT INTO `bbgshop_footprint` VALUES (2841, 34, 841662, 1528347295);
INSERT INTO `bbgshop_footprint` VALUES (2842, 34, 841662, 1528347441);
INSERT INTO `bbgshop_footprint` VALUES (2843, 34, 841662, 1528347459);
INSERT INTO `bbgshop_footprint` VALUES (2844, 34, 841662, 1528347502);
INSERT INTO `bbgshop_footprint` VALUES (2845, 34, 841662, 1528347511);
INSERT INTO `bbgshop_footprint` VALUES (2846, 34, 841662, 1528347719);
INSERT INTO `bbgshop_footprint` VALUES (2847, 34, 841662, 1528348122);
INSERT INTO `bbgshop_footprint` VALUES (2848, 34, 841662, 1528348179);
INSERT INTO `bbgshop_footprint` VALUES (2849, 34, 841662, 1528348186);
INSERT INTO `bbgshop_footprint` VALUES (2850, 34, 841662, 1528348303);
INSERT INTO `bbgshop_footprint` VALUES (2851, 34, 636004, 1528348311);
INSERT INTO `bbgshop_footprint` VALUES (2852, 34, 841662, 1528348432);
INSERT INTO `bbgshop_footprint` VALUES (2853, 34, 636004, 1528348542);
INSERT INTO `bbgshop_footprint` VALUES (2854, 34, 841662, 1528348575);
INSERT INTO `bbgshop_footprint` VALUES (2855, 34, 636004, 1528348585);
INSERT INTO `bbgshop_footprint` VALUES (2856, 34, 636004, 1528348636);
INSERT INTO `bbgshop_footprint` VALUES (2857, 34, 636004, 1528348656);
INSERT INTO `bbgshop_footprint` VALUES (2858, 34, 841662, 1528348726);
INSERT INTO `bbgshop_footprint` VALUES (2859, 34, 636004, 1528348812);
INSERT INTO `bbgshop_footprint` VALUES (2860, 34, 841662, 1528348829);
INSERT INTO `bbgshop_footprint` VALUES (2861, 34, 636004, 1528348875);
INSERT INTO `bbgshop_footprint` VALUES (2862, 34, 841662, 1528349144);
INSERT INTO `bbgshop_footprint` VALUES (2863, 34, 636004, 1528349158);
INSERT INTO `bbgshop_footprint` VALUES (2864, 34, 636004, 1528349182);
INSERT INTO `bbgshop_footprint` VALUES (2865, 34, 841662, 1528349251);
INSERT INTO `bbgshop_footprint` VALUES (2866, 34, 636004, 1528349259);
INSERT INTO `bbgshop_footprint` VALUES (2867, 34, 841662, 1528349362);
INSERT INTO `bbgshop_footprint` VALUES (2868, 34, 841662, 1528349443);
INSERT INTO `bbgshop_footprint` VALUES (2869, 34, 636004, 1528349447);
INSERT INTO `bbgshop_footprint` VALUES (2870, 34, 636004, 1528349465);
INSERT INTO `bbgshop_footprint` VALUES (2871, 34, 841662, 1528349714);
INSERT INTO `bbgshop_footprint` VALUES (2872, 34, 841662, 1528349724);
INSERT INTO `bbgshop_footprint` VALUES (2873, 34, 841662, 1528349773);
INSERT INTO `bbgshop_footprint` VALUES (2874, 34, 841662, 1528349784);
INSERT INTO `bbgshop_footprint` VALUES (2875, 34, 841662, 1528350704);
INSERT INTO `bbgshop_footprint` VALUES (2876, 34, 841662, 1528350786);
INSERT INTO `bbgshop_footprint` VALUES (2877, 34, 841662, 1528350796);
INSERT INTO `bbgshop_footprint` VALUES (2878, 34, 841662, 1528350827);
INSERT INTO `bbgshop_footprint` VALUES (2879, 34, 841662, 1528352777);
INSERT INTO `bbgshop_footprint` VALUES (2880, 34, 841662, 1528352826);
INSERT INTO `bbgshop_footprint` VALUES (2881, 34, 841662, 1528352838);
INSERT INTO `bbgshop_footprint` VALUES (2882, 34, 841662, 1528353032);
INSERT INTO `bbgshop_footprint` VALUES (2883, 34, 841662, 1528353112);
INSERT INTO `bbgshop_footprint` VALUES (2884, 34, 841662, 1528353247);
INSERT INTO `bbgshop_footprint` VALUES (2885, 34, 841662, 1528353368);
INSERT INTO `bbgshop_footprint` VALUES (2886, 34, 841662, 1528353423);
INSERT INTO `bbgshop_footprint` VALUES (2887, 34, 841662, 1528353489);
INSERT INTO `bbgshop_footprint` VALUES (2888, 34, 841662, 1528353846);
INSERT INTO `bbgshop_footprint` VALUES (2889, 34, 841662, 1528356142);
INSERT INTO `bbgshop_footprint` VALUES (2890, 34, 841662, 1528356179);
INSERT INTO `bbgshop_footprint` VALUES (2891, 34, 841662, 1528356256);
INSERT INTO `bbgshop_footprint` VALUES (2892, 34, 841662, 1528356454);
INSERT INTO `bbgshop_footprint` VALUES (2893, 34, 841662, 1528357490);
INSERT INTO `bbgshop_footprint` VALUES (2894, 34, 841662, 1528357754);
INSERT INTO `bbgshop_footprint` VALUES (2895, 34, 841662, 1528357834);
INSERT INTO `bbgshop_footprint` VALUES (2896, 34, 841662, 1528357844);
INSERT INTO `bbgshop_footprint` VALUES (2897, 34, 841662, 1528357907);
INSERT INTO `bbgshop_footprint` VALUES (2898, 34, 841662, 1528357924);
INSERT INTO `bbgshop_footprint` VALUES (2899, 34, 841662, 1528359094);
INSERT INTO `bbgshop_footprint` VALUES (2900, 34, 841662, 1528359744);
INSERT INTO `bbgshop_footprint` VALUES (2901, 34, 841662, 1528359762);
INSERT INTO `bbgshop_footprint` VALUES (2902, 34, 841662, 1528360348);
INSERT INTO `bbgshop_footprint` VALUES (2903, 34, 841662, 1528362205);
INSERT INTO `bbgshop_footprint` VALUES (2904, 34, 841662, 1528362243);
INSERT INTO `bbgshop_footprint` VALUES (2905, 34, 841662, 1528362258);
INSERT INTO `bbgshop_footprint` VALUES (2906, 34, 841662, 1528362305);
INSERT INTO `bbgshop_footprint` VALUES (2907, 34, 841662, 1528362350);
INSERT INTO `bbgshop_footprint` VALUES (2908, 34, 636004, 1528362510);
INSERT INTO `bbgshop_footprint` VALUES (2909, 34, 841662, 1528362517);
INSERT INTO `bbgshop_footprint` VALUES (2910, 34, 841662, 1528362553);
INSERT INTO `bbgshop_footprint` VALUES (2911, 34, 841662, 1528362574);
INSERT INTO `bbgshop_footprint` VALUES (2912, 34, 841662, 1528362622);
INSERT INTO `bbgshop_footprint` VALUES (2913, 34, 841662, 1528362663);
INSERT INTO `bbgshop_footprint` VALUES (2914, 34, 841662, 1528362725);
INSERT INTO `bbgshop_footprint` VALUES (2915, 34, 841662, 1528362748);
INSERT INTO `bbgshop_footprint` VALUES (2916, 34, 841662, 1528362800);
INSERT INTO `bbgshop_footprint` VALUES (2917, 34, 841662, 1528362818);
INSERT INTO `bbgshop_footprint` VALUES (2918, 34, 284518, 1528417835);
INSERT INTO `bbgshop_footprint` VALUES (2919, 34, 636004, 1528418141);
INSERT INTO `bbgshop_footprint` VALUES (2920, 34, 841662, 1528418165);
INSERT INTO `bbgshop_footprint` VALUES (2921, 34, 841662, 1528418407);
INSERT INTO `bbgshop_footprint` VALUES (2922, 34, 841662, 1528418928);
INSERT INTO `bbgshop_footprint` VALUES (2923, 34, 841662, 1528418950);
INSERT INTO `bbgshop_footprint` VALUES (2924, 34, 841662, 1528419042);
INSERT INTO `bbgshop_footprint` VALUES (2925, 34, 841662, 1528419057);
INSERT INTO `bbgshop_footprint` VALUES (2926, 34, 841662, 1528419290);
INSERT INTO `bbgshop_footprint` VALUES (2927, 34, 841662, 1528419424);
INSERT INTO `bbgshop_footprint` VALUES (2928, 34, 841662, 1528419819);
INSERT INTO `bbgshop_footprint` VALUES (2929, 34, 841662, 1528420825);
INSERT INTO `bbgshop_footprint` VALUES (2930, 34, 841662, 1528426143);
INSERT INTO `bbgshop_footprint` VALUES (2931, 34, 841662, 1528426335);
INSERT INTO `bbgshop_footprint` VALUES (2932, 34, 841662, 1528426551);
INSERT INTO `bbgshop_footprint` VALUES (2933, 34, 841662, 1528427268);
INSERT INTO `bbgshop_footprint` VALUES (2934, 34, 841662, 1528427353);
INSERT INTO `bbgshop_footprint` VALUES (2935, 34, 841662, 1528427373);
INSERT INTO `bbgshop_footprint` VALUES (2936, 34, 841662, 1528427630);
INSERT INTO `bbgshop_footprint` VALUES (2937, 34, 841662, 1528428081);
INSERT INTO `bbgshop_footprint` VALUES (2938, 34, 841662, 1528428095);
INSERT INTO `bbgshop_footprint` VALUES (2939, 34, 636004, 1528428233);
INSERT INTO `bbgshop_footprint` VALUES (2940, 34, 841662, 1528428241);
INSERT INTO `bbgshop_footprint` VALUES (2941, 34, 841662, 1528433635);
INSERT INTO `bbgshop_footprint` VALUES (2942, 34, 841662, 1528433797);
INSERT INTO `bbgshop_footprint` VALUES (2943, 34, 636004, 1528434046);
INSERT INTO `bbgshop_footprint` VALUES (2944, 34, 636004, 1528434149);
INSERT INTO `bbgshop_footprint` VALUES (2945, 34, 841662, 1528434169);
INSERT INTO `bbgshop_footprint` VALUES (2946, 34, 841662, 1528434479);
INSERT INTO `bbgshop_footprint` VALUES (2947, 34, 841662, 1528434490);
INSERT INTO `bbgshop_footprint` VALUES (2948, 34, 636004, 1528434506);
INSERT INTO `bbgshop_footprint` VALUES (2949, 34, 519375, 1528434512);
INSERT INTO `bbgshop_footprint` VALUES (2950, 34, 90706, 1528434521);
INSERT INTO `bbgshop_footprint` VALUES (2951, 34, 841662, 1528434536);
INSERT INTO `bbgshop_footprint` VALUES (2952, 34, 841662, 1528434626);
INSERT INTO `bbgshop_footprint` VALUES (2953, 34, 841662, 1528434884);
INSERT INTO `bbgshop_footprint` VALUES (2954, 34, 636004, 1528434893);
INSERT INTO `bbgshop_footprint` VALUES (2955, 34, 636004, 1528434933);
INSERT INTO `bbgshop_footprint` VALUES (2956, 34, 841662, 1528434945);
INSERT INTO `bbgshop_footprint` VALUES (2957, 34, 841662, 1528435316);
INSERT INTO `bbgshop_footprint` VALUES (2958, 34, 841662, 1528435527);
INSERT INTO `bbgshop_footprint` VALUES (2959, 34, 841662, 1528435772);
INSERT INTO `bbgshop_footprint` VALUES (2960, 34, 841662, 1528435845);
INSERT INTO `bbgshop_footprint` VALUES (2961, 34, 636004, 1528435891);
INSERT INTO `bbgshop_footprint` VALUES (2962, 34, 841662, 1528435900);
INSERT INTO `bbgshop_footprint` VALUES (2963, 34, 841662, 1528436333);
INSERT INTO `bbgshop_footprint` VALUES (2964, 34, 841662, 1528436458);
INSERT INTO `bbgshop_footprint` VALUES (2965, 34, 841662, 1528436805);
INSERT INTO `bbgshop_footprint` VALUES (2966, 34, 841662, 1528438291);
INSERT INTO `bbgshop_footprint` VALUES (2967, 34, 636004, 1528448612);
INSERT INTO `bbgshop_footprint` VALUES (2968, 34, 841662, 1528448621);
INSERT INTO `bbgshop_footprint` VALUES (2969, 34, 841662, 1528449154);
INSERT INTO `bbgshop_footprint` VALUES (2970, 34, 841662, 1528449285);
INSERT INTO `bbgshop_footprint` VALUES (2971, 34, 841662, 1528449710);
INSERT INTO `bbgshop_footprint` VALUES (2972, 34, 841662, 1528509744);
INSERT INTO `bbgshop_footprint` VALUES (2973, 34, 841662, 1528509755);
INSERT INTO `bbgshop_footprint` VALUES (2974, 34, 841662, 1528509846);
INSERT INTO `bbgshop_footprint` VALUES (2975, 34, 841662, 1528521140);
INSERT INTO `bbgshop_footprint` VALUES (2976, 34, 104223, 1528521148);
INSERT INTO `bbgshop_footprint` VALUES (2977, 34, 2832, 1528521156);
INSERT INTO `bbgshop_footprint` VALUES (2978, 34, 841662, 1528677038);
INSERT INTO `bbgshop_footprint` VALUES (2979, 34, 841662, 1528768501);
INSERT INTO `bbgshop_footprint` VALUES (2980, 34, 841662, 1528850269);
INSERT INTO `bbgshop_footprint` VALUES (2981, 34, 636004, 1528854396);
INSERT INTO `bbgshop_footprint` VALUES (2982, 34, 1528855134649776, 1528855144);
INSERT INTO `bbgshop_footprint` VALUES (2983, 34, 1528855134649776, 1528879509);
INSERT INTO `bbgshop_footprint` VALUES (2984, 34, 1528855134649776, 1529049565);
INSERT INTO `bbgshop_footprint` VALUES (2985, 34, 841662, 1529369515);
INSERT INTO `bbgshop_footprint` VALUES (2986, 34, 1528855134649776, 1529385407);
INSERT INTO `bbgshop_footprint` VALUES (2987, 34, 1528855134649776, 1529385493);
INSERT INTO `bbgshop_footprint` VALUES (2988, 34, 369904, 1529385543);
INSERT INTO `bbgshop_footprint` VALUES (2989, 34, 636004, 1529395667);
INSERT INTO `bbgshop_footprint` VALUES (2990, 34, 841662, 1529395770);
INSERT INTO `bbgshop_footprint` VALUES (2991, 34, 369904, 1529395917);
INSERT INTO `bbgshop_footprint` VALUES (2992, 34, 841662, 1529398881);
INSERT INTO `bbgshop_footprint` VALUES (2993, 34, 1528855134649776, 1529456340);
INSERT INTO `bbgshop_footprint` VALUES (2994, 34, 841662, 1529456478);
INSERT INTO `bbgshop_footprint` VALUES (2995, 34, 636004, 1529456532);
INSERT INTO `bbgshop_footprint` VALUES (2996, 34, 841662, 1529456535);
INSERT INTO `bbgshop_footprint` VALUES (2997, 34, 1528855134649776, 1529456658);
INSERT INTO `bbgshop_footprint` VALUES (2998, 34, 841662, 1529456662);
INSERT INTO `bbgshop_footprint` VALUES (2999, 34, 841662, 1529456750);
INSERT INTO `bbgshop_footprint` VALUES (3000, 34, 841662, 1529457683);
INSERT INTO `bbgshop_footprint` VALUES (3001, 34, 1528855134649776, 1529457709);
INSERT INTO `bbgshop_footprint` VALUES (3002, 34, 1528855134649776, 1529458687);
INSERT INTO `bbgshop_footprint` VALUES (3003, 34, 841662, 1529458727);
INSERT INTO `bbgshop_footprint` VALUES (3004, 34, 841662, 1529459460);
INSERT INTO `bbgshop_footprint` VALUES (3005, 34, 841662, 1529460137);
INSERT INTO `bbgshop_footprint` VALUES (3006, 34, 636004, 1529460224);
INSERT INTO `bbgshop_footprint` VALUES (3007, 34, 841662, 1529460282);
INSERT INTO `bbgshop_footprint` VALUES (3008, 34, 841662, 1529460297);
INSERT INTO `bbgshop_footprint` VALUES (3009, 34, 369000, 1529460334);
INSERT INTO `bbgshop_footprint` VALUES (3010, 34, 369904, 1529460340);
INSERT INTO `bbgshop_footprint` VALUES (3011, 34, 1528855134649776, 1529473139);
INSERT INTO `bbgshop_footprint` VALUES (3012, 34, 841662, 1529473149);
INSERT INTO `bbgshop_footprint` VALUES (3013, 34, 1528855134649776, 1529473166);
INSERT INTO `bbgshop_footprint` VALUES (3014, 34, 636004, 1529473169);
INSERT INTO `bbgshop_footprint` VALUES (3015, 34, 622336, 1529473322);
INSERT INTO `bbgshop_footprint` VALUES (3016, 34, 1528855134649776, 1529473597);
INSERT INTO `bbgshop_footprint` VALUES (3017, 34, 88319, 1529474784);
INSERT INTO `bbgshop_footprint` VALUES (3018, 34, 7308, 1529475316);
INSERT INTO `bbgshop_footprint` VALUES (3019, 34, 841662, 1529475913);
INSERT INTO `bbgshop_footprint` VALUES (3020, 34, 841662, 1529476157);
INSERT INTO `bbgshop_footprint` VALUES (3021, 34, 841662, 1529476192);
INSERT INTO `bbgshop_footprint` VALUES (3022, 34, 841662, 1529476235);
INSERT INTO `bbgshop_footprint` VALUES (3023, 34, 1528855134649776, 1529476243);
INSERT INTO `bbgshop_footprint` VALUES (3024, 34, 841662, 1529476246);
INSERT INTO `bbgshop_footprint` VALUES (3025, 34, 841662, 1529484787);
INSERT INTO `bbgshop_footprint` VALUES (3026, 34, 636004, 1529487450);
INSERT INTO `bbgshop_footprint` VALUES (3027, 34, 841662, 1529541154);
INSERT INTO `bbgshop_footprint` VALUES (3028, 34, 1528855134649776, 1529541161);
INSERT INTO `bbgshop_footprint` VALUES (3029, 34, 1528855134649776, 1529541164);
INSERT INTO `bbgshop_footprint` VALUES (3030, 34, 1528855134649776, 1529541168);
INSERT INTO `bbgshop_footprint` VALUES (3031, 34, 369000, 1529545428);
INSERT INTO `bbgshop_footprint` VALUES (3032, 34, 369904, 1529545612);
INSERT INTO `bbgshop_footprint` VALUES (3033, 34, 81405, 1529545634);
INSERT INTO `bbgshop_footprint` VALUES (3034, 34, 81405, 1529545838);
INSERT INTO `bbgshop_footprint` VALUES (3035, 34, 369904, 1529545843);
INSERT INTO `bbgshop_footprint` VALUES (3036, 34, 369000, 1529545849);
INSERT INTO `bbgshop_footprint` VALUES (3037, 34, 622336, 1529545854);
INSERT INTO `bbgshop_footprint` VALUES (3038, 34, 1528855134649776, 1529545934);
INSERT INTO `bbgshop_footprint` VALUES (3039, 34, 622336, 1529546122);
INSERT INTO `bbgshop_footprint` VALUES (3040, 34, 841662, 1529546233);
INSERT INTO `bbgshop_footprint` VALUES (3041, 34, 369000, 1529546386);
INSERT INTO `bbgshop_footprint` VALUES (3042, 34, 813924, 1529546407);
INSERT INTO `bbgshop_footprint` VALUES (3043, 34, 1528855134649776, 1529547345);
INSERT INTO `bbgshop_footprint` VALUES (3044, 34, 1528855134649776, 1529547365);
INSERT INTO `bbgshop_footprint` VALUES (3045, 34, 1528855134649776, 1529547418);
INSERT INTO `bbgshop_footprint` VALUES (3046, 34, 1528855134649776, 1529547564);
INSERT INTO `bbgshop_footprint` VALUES (3047, 34, 1528855134649776, 1529547649);
INSERT INTO `bbgshop_footprint` VALUES (3048, 34, 1528855134649776, 1529547735);
INSERT INTO `bbgshop_footprint` VALUES (3049, 34, 1528855134649776, 1529547744);
INSERT INTO `bbgshop_footprint` VALUES (3050, 34, 1528855134649776, 1529547754);
INSERT INTO `bbgshop_footprint` VALUES (3051, 34, 841662, 1529547803);
INSERT INTO `bbgshop_footprint` VALUES (3052, 34, 1528855134649776, 1529547944);
INSERT INTO `bbgshop_footprint` VALUES (3053, 34, 1528855134649776, 1529548017);
INSERT INTO `bbgshop_footprint` VALUES (3054, 34, 369904, 1529548113);
INSERT INTO `bbgshop_footprint` VALUES (3055, 34, 369904, 1529548130);
INSERT INTO `bbgshop_footprint` VALUES (3056, 34, 1528855134649776, 1529548286);
INSERT INTO `bbgshop_footprint` VALUES (3057, 34, 1528855134649776, 1529548309);
INSERT INTO `bbgshop_footprint` VALUES (3058, 34, 369904, 1529548340);
INSERT INTO `bbgshop_footprint` VALUES (3059, 34, 813924, 1529548357);
INSERT INTO `bbgshop_footprint` VALUES (3060, 34, 1528855134649776, 1529549545);
INSERT INTO `bbgshop_footprint` VALUES (3061, 34, 1528855134649776, 1529551105);
INSERT INTO `bbgshop_footprint` VALUES (3062, 34, 813924, 1529560437);
INSERT INTO `bbgshop_footprint` VALUES (3063, 34, 1528855134649776, 1529650565);
INSERT INTO `bbgshop_footprint` VALUES (3064, 34, 1528855134649776, 1529650864);
INSERT INTO `bbgshop_footprint` VALUES (3065, 34, 1528855134649776, 1529650932);
INSERT INTO `bbgshop_footprint` VALUES (3066, 34, 636004, 1529650938);
INSERT INTO `bbgshop_footprint` VALUES (3067, 34, 841662, 1529650961);
INSERT INTO `bbgshop_footprint` VALUES (3068, 34, 1528855134649776, 1529651278);
INSERT INTO `bbgshop_footprint` VALUES (3069, 34, 1528855134649776, 1529651312);
INSERT INTO `bbgshop_footprint` VALUES (3070, 34, 636004, 1529721654);
INSERT INTO `bbgshop_footprint` VALUES (3071, 34, 813924, 1529740257);
INSERT INTO `bbgshop_footprint` VALUES (3072, 34, 841662, 1529740349);
INSERT INTO `bbgshop_footprint` VALUES (3073, 34, 303863, 1529740355);
INSERT INTO `bbgshop_footprint` VALUES (3074, 34, 519375, 1529740362);
INSERT INTO `bbgshop_footprint` VALUES (3075, 34, 841662, 1529740369);
INSERT INTO `bbgshop_footprint` VALUES (3076, 34, 369000, 1529745556);
INSERT INTO `bbgshop_footprint` VALUES (3077, 34, 1528855134649776, 1529745608);
INSERT INTO `bbgshop_footprint` VALUES (3078, 34, 1528855134649776, 1529745613);
INSERT INTO `bbgshop_footprint` VALUES (3079, 34, 841662, 1529745616);
INSERT INTO `bbgshop_footprint` VALUES (3080, 34, 1528855134649776, 1529886981);
INSERT INTO `bbgshop_footprint` VALUES (3081, 34, 1528855134649776, 1529888626);
INSERT INTO `bbgshop_footprint` VALUES (3082, 34, 1528855134649776, 1529888714);
INSERT INTO `bbgshop_footprint` VALUES (3083, 34, 1528855134649776, 1529888748);
INSERT INTO `bbgshop_footprint` VALUES (3084, 32, 1528855134649776, 1529890522);
INSERT INTO `bbgshop_footprint` VALUES (3085, 34, 1528855134649776, 1529891301);
INSERT INTO `bbgshop_footprint` VALUES (3086, 34, 1528855134649776, 1529891997);
INSERT INTO `bbgshop_footprint` VALUES (3087, 34, 841662, 1529894334);
INSERT INTO `bbgshop_footprint` VALUES (3088, 34, 1529917389673191, 1529917452);
INSERT INTO `bbgshop_footprint` VALUES (3089, 34, 152991759190674, 1529917670);
INSERT INTO `bbgshop_footprint` VALUES (3090, 34, 477300, 1529918985);
INSERT INTO `bbgshop_footprint` VALUES (3091, 34, 152991759190674, 1529918993);
INSERT INTO `bbgshop_footprint` VALUES (3092, 34, 477300, 1529919000);
INSERT INTO `bbgshop_footprint` VALUES (3093, 34, 1528855134649776, 1529919004);
INSERT INTO `bbgshop_footprint` VALUES (3094, 34, 152991759190674, 1529919008);
INSERT INTO `bbgshop_footprint` VALUES (3095, 34, 152991759190674, 1529919026);
INSERT INTO `bbgshop_footprint` VALUES (3096, 34, 152991759190674, 1529919053);
INSERT INTO `bbgshop_footprint` VALUES (3097, 34, 813924, 1529919062);
INSERT INTO `bbgshop_footprint` VALUES (3098, 34, 284518, 1529919076);
INSERT INTO `bbgshop_footprint` VALUES (3099, 32, 477300, 1529919547);
INSERT INTO `bbgshop_footprint` VALUES (3100, 34, 1528855134649776, 1529919724);
INSERT INTO `bbgshop_footprint` VALUES (3101, 34, 152991759190674, 1529973902);
INSERT INTO `bbgshop_footprint` VALUES (3102, 34, 813924, 1529973912);
INSERT INTO `bbgshop_footprint` VALUES (3103, 34, 284518, 1529973917);
INSERT INTO `bbgshop_footprint` VALUES (3104, 34, 152991759190674, 1529974954);
INSERT INTO `bbgshop_footprint` VALUES (3105, 34, 813924, 1529974982);
INSERT INTO `bbgshop_footprint` VALUES (3106, 34, 1528855134649776, 1529974994);
INSERT INTO `bbgshop_footprint` VALUES (3107, 34, 152991759190674, 1529975044);
INSERT INTO `bbgshop_footprint` VALUES (3108, 34, 1528855134649776, 1529975059);
INSERT INTO `bbgshop_footprint` VALUES (3109, 34, 622336, 1529975063);
INSERT INTO `bbgshop_footprint` VALUES (3110, 34, 152991759190674, 1530059788);
INSERT INTO `bbgshop_footprint` VALUES (3111, 34, 477300, 1530059834);
INSERT INTO `bbgshop_footprint` VALUES (3112, 34, 152991759190674, 1530059944);
INSERT INTO `bbgshop_footprint` VALUES (3113, 34, 152991759190674, 1530059970);
INSERT INTO `bbgshop_footprint` VALUES (3114, 34, 152991759190674, 1530059987);
INSERT INTO `bbgshop_footprint` VALUES (3115, 34, 1528855134649776, 1530060015);
INSERT INTO `bbgshop_footprint` VALUES (3116, 34, 369000, 1530083159);
INSERT INTO `bbgshop_footprint` VALUES (3117, 34, 369904, 1530083167);
INSERT INTO `bbgshop_footprint` VALUES (3118, 34, 1528855134649776, 1530083604);
INSERT INTO `bbgshop_footprint` VALUES (3119, 34, 152991759190674, 1530083630);
INSERT INTO `bbgshop_footprint` VALUES (3120, 34, 813924, 1530083639);
INSERT INTO `bbgshop_footprint` VALUES (3121, 34, 841662, 1530083697);
INSERT INTO `bbgshop_footprint` VALUES (3122, 34, 813924, 1530083989);
INSERT INTO `bbgshop_footprint` VALUES (3123, 34, 841662, 1530084008);
INSERT INTO `bbgshop_footprint` VALUES (3124, 34, 369904, 1530084141);
INSERT INTO `bbgshop_footprint` VALUES (3125, 34, 152991759190674, 1530084176);
INSERT INTO `bbgshop_footprint` VALUES (3126, 34, 1528855134649776, 1530084291);
INSERT INTO `bbgshop_footprint` VALUES (3127, 34, 369000, 1530084346);
INSERT INTO `bbgshop_footprint` VALUES (3128, 34, 813924, 1530086447);
INSERT INTO `bbgshop_footprint` VALUES (3129, 34, 11154, 1530086532);
INSERT INTO `bbgshop_footprint` VALUES (3130, 32, 152991759190674, 1530146232);
INSERT INTO `bbgshop_footprint` VALUES (3131, 34, 152991759190674, 1530146249);
INSERT INTO `bbgshop_footprint` VALUES (3132, 34, 152991759190674, 1530170425);
INSERT INTO `bbgshop_footprint` VALUES (3133, 32, 67743, 1530172482);
INSERT INTO `bbgshop_footprint` VALUES (3134, 34, 7308, 1530172502);
INSERT INTO `bbgshop_footprint` VALUES (3135, 34, 1530175338457488, 1530176269);
INSERT INTO `bbgshop_footprint` VALUES (3136, 34, 813924, 1530232684);
INSERT INTO `bbgshop_footprint` VALUES (3137, 34, 813924, 1530233031);
INSERT INTO `bbgshop_footprint` VALUES (3138, 34, 2832, 1530233044);
INSERT INTO `bbgshop_footprint` VALUES (3139, 34, 1530175338457488, 1530233105);
INSERT INTO `bbgshop_footprint` VALUES (3140, 34, 841662, 1530233118);
INSERT INTO `bbgshop_footprint` VALUES (3141, 34, 1530175338457488, 1530233127);
INSERT INTO `bbgshop_footprint` VALUES (3142, 34, 813924, 1530233188);
INSERT INTO `bbgshop_footprint` VALUES (3143, 34, 622336, 1530233196);
INSERT INTO `bbgshop_footprint` VALUES (3144, 34, 1530175338457488, 1530233203);
INSERT INTO `bbgshop_footprint` VALUES (3145, 34, 841662, 1530237806);
INSERT INTO `bbgshop_footprint` VALUES (3146, 34, 841662, 1530237817);
INSERT INTO `bbgshop_footprint` VALUES (3147, 34, 841662, 1530237949);
INSERT INTO `bbgshop_footprint` VALUES (3148, 34, 841662, 1530238030);
INSERT INTO `bbgshop_footprint` VALUES (3149, 34, 519375, 1530240531);
INSERT INTO `bbgshop_footprint` VALUES (3150, 32, 813924, 1530241974);
INSERT INTO `bbgshop_footprint` VALUES (3151, 34, 1530175338457488, 1530241989);
INSERT INTO `bbgshop_footprint` VALUES (3152, 34, 841662, 1530241993);
INSERT INTO `bbgshop_footprint` VALUES (3153, 34, 622336, 1530242003);
INSERT INTO `bbgshop_footprint` VALUES (3154, 34, 841662, 1530246438);
INSERT INTO `bbgshop_footprint` VALUES (3155, 34, 841662, 1530247374);
INSERT INTO `bbgshop_footprint` VALUES (3156, 34, 841662, 1530247412);
INSERT INTO `bbgshop_footprint` VALUES (3157, 34, 152991759190674, 1530247749);
INSERT INTO `bbgshop_footprint` VALUES (3158, 34, 477300, 1530247804);
INSERT INTO `bbgshop_footprint` VALUES (3159, 34, 250852, 1530247812);
INSERT INTO `bbgshop_footprint` VALUES (3160, 34, 152991759190674, 1530251167);
INSERT INTO `bbgshop_footprint` VALUES (3161, 32, 504504, 1530261329);
INSERT INTO `bbgshop_footprint` VALUES (3162, 34, 519375, 1530261338);
INSERT INTO `bbgshop_footprint` VALUES (3163, 34, 267471, 1530261344);
INSERT INTO `bbgshop_footprint` VALUES (3164, 34, 250852, 1530261348);
INSERT INTO `bbgshop_footprint` VALUES (3165, 34, 616930, 1530261359);
INSERT INTO `bbgshop_footprint` VALUES (3166, 34, 1528855134649776, 1530261458);
INSERT INTO `bbgshop_footprint` VALUES (3167, 34, 841662, 1530320793);
INSERT INTO `bbgshop_footprint` VALUES (3168, 34, 152991759190674, 1530320881);
INSERT INTO `bbgshop_footprint` VALUES (3169, 34, 841662, 1530320889);
INSERT INTO `bbgshop_footprint` VALUES (3170, 34, 1528855134649776, 1530321607);
INSERT INTO `bbgshop_footprint` VALUES (3171, 34, 1530175338457488, 1530335520);
INSERT INTO `bbgshop_footprint` VALUES (3172, 34, 1528855134649776, 1530492037);
INSERT INTO `bbgshop_footprint` VALUES (3173, 34, 1530175338457488, 1530492040);
INSERT INTO `bbgshop_footprint` VALUES (3174, 34, 841662, 1530492045);
INSERT INTO `bbgshop_footprint` VALUES (3175, 34, 813924, 1530492052);
INSERT INTO `bbgshop_footprint` VALUES (3176, 34, 813924, 1530493112);
INSERT INTO `bbgshop_footprint` VALUES (3177, 34, 1530175338457488, 1530493177);
INSERT INTO `bbgshop_footprint` VALUES (3178, 34, 1530175338457488, 1530493745);
INSERT INTO `bbgshop_footprint` VALUES (3179, 34, 152991759190674, 1530669741);
INSERT INTO `bbgshop_footprint` VALUES (3180, 34, 813924, 1530669760);
INSERT INTO `bbgshop_footprint` VALUES (3181, 34, 813924, 1530669764);
INSERT INTO `bbgshop_footprint` VALUES (3182, 34, 813924, 1530669767);
INSERT INTO `bbgshop_footprint` VALUES (3183, 34, 152991759190674, 1530669777);
INSERT INTO `bbgshop_footprint` VALUES (3184, 34, 1528855134649776, 1530669817);
INSERT INTO `bbgshop_footprint` VALUES (3185, 34, 152991759190674, 1530680539);
INSERT INTO `bbgshop_footprint` VALUES (3186, 34, 1528855134649776, 1530680547);
INSERT INTO `bbgshop_footprint` VALUES (3187, 34, 1528855134649776, 1530691230);
INSERT INTO `bbgshop_footprint` VALUES (3188, 34, 1528855134649776, 1530691264);
INSERT INTO `bbgshop_footprint` VALUES (3189, 34, 152991759190674, 1530691386);
INSERT INTO `bbgshop_footprint` VALUES (3190, 34, 152991759190674, 1530691496);
INSERT INTO `bbgshop_footprint` VALUES (3191, 34, 152991759190674, 1530691882);
INSERT INTO `bbgshop_footprint` VALUES (3192, 34, 1528855134649776, 1530692106);
INSERT INTO `bbgshop_footprint` VALUES (3193, 34, 1528855134649776, 1530692162);
INSERT INTO `bbgshop_footprint` VALUES (3194, 34, 1528855134649776, 1530692213);
INSERT INTO `bbgshop_footprint` VALUES (3195, 34, 1528855134649776, 1530696638);
INSERT INTO `bbgshop_footprint` VALUES (3196, 34, 1530752944419263, 1530753096);
INSERT INTO `bbgshop_footprint` VALUES (3197, 34, 519375, 1530753115);
INSERT INTO `bbgshop_footprint` VALUES (3198, 34, 1530752944419263, 1530755141);
INSERT INTO `bbgshop_footprint` VALUES (3199, 34, 1528855134649776, 1530774444);
INSERT INTO `bbgshop_footprint` VALUES (3200, 34, 1530752944419263, 1530774463);
INSERT INTO `bbgshop_footprint` VALUES (3201, 34, 1530752944419263, 1530774524);
INSERT INTO `bbgshop_footprint` VALUES (3202, 34, 1528855134649776, 1530774531);
INSERT INTO `bbgshop_footprint` VALUES (3203, 34, 519375, 1530774537);
INSERT INTO `bbgshop_footprint` VALUES (3204, 34, 813924, 1530774546);
INSERT INTO `bbgshop_footprint` VALUES (3205, 34, 477300, 1530778385);
INSERT INTO `bbgshop_footprint` VALUES (3206, 34, 622336, 1530778779);
INSERT INTO `bbgshop_footprint` VALUES (3207, 34, 1530752944419263, 1530779332);
INSERT INTO `bbgshop_footprint` VALUES (3208, 34, 1530752944419263, 1530779356);
INSERT INTO `bbgshop_footprint` VALUES (3209, 34, 504504, 1530779419);
INSERT INTO `bbgshop_footprint` VALUES (3210, 34, 636004, 1530779562);
INSERT INTO `bbgshop_footprint` VALUES (3211, 34, 477300, 1530779684);
INSERT INTO `bbgshop_footprint` VALUES (3212, 34, 1530752944419263, 1530779912);
INSERT INTO `bbgshop_footprint` VALUES (3213, 34, 813924, 1530780026);
INSERT INTO `bbgshop_footprint` VALUES (3214, 34, 841662, 1530780158);
INSERT INTO `bbgshop_footprint` VALUES (3215, 34, 813924, 1530780792);
INSERT INTO `bbgshop_footprint` VALUES (3216, 34, 813924, 1530780884);
INSERT INTO `bbgshop_footprint` VALUES (3217, 34, 841662, 1530781046);
INSERT INTO `bbgshop_footprint` VALUES (3218, 34, 813924, 1530781816);
INSERT INTO `bbgshop_footprint` VALUES (3219, 34, 813924, 1530781835);
INSERT INTO `bbgshop_footprint` VALUES (3220, 34, 813924, 1530781906);
INSERT INTO `bbgshop_footprint` VALUES (3221, 34, 267471, 1530782113);
INSERT INTO `bbgshop_footprint` VALUES (3222, 34, 303863, 1530782116);
INSERT INTO `bbgshop_footprint` VALUES (3223, 34, 250852, 1530782145);
INSERT INTO `bbgshop_footprint` VALUES (3224, 34, 477300, 1530782276);
INSERT INTO `bbgshop_footprint` VALUES (3225, 34, 519375, 1530782284);
INSERT INTO `bbgshop_footprint` VALUES (3226, 34, 1530752944419263, 1530782289);
INSERT INTO `bbgshop_footprint` VALUES (3227, 34, 519375, 1530782679);
INSERT INTO `bbgshop_footprint` VALUES (3228, 34, 622336, 1530782838);
INSERT INTO `bbgshop_footprint` VALUES (3229, 34, 1528855134649776, 1530783872);
INSERT INTO `bbgshop_footprint` VALUES (3230, 34, 1528855134649776, 1530783943);
INSERT INTO `bbgshop_footprint` VALUES (3231, 34, 1528855134649776, 1530783961);
INSERT INTO `bbgshop_footprint` VALUES (3232, 34, 1528855134649776, 1530783965);
INSERT INTO `bbgshop_footprint` VALUES (3233, 34, 477300, 1530783997);
INSERT INTO `bbgshop_footprint` VALUES (3234, 34, 1530752944419263, 1530784042);
INSERT INTO `bbgshop_footprint` VALUES (3235, 34, 1530752944419263, 1530784083);
INSERT INTO `bbgshop_footprint` VALUES (3236, 34, 1530752944419263, 1530784113);
INSERT INTO `bbgshop_footprint` VALUES (3237, 34, 477300, 1530784148);
INSERT INTO `bbgshop_footprint` VALUES (3238, 34, 1528855134649776, 1530784176);
INSERT INTO `bbgshop_footprint` VALUES (3239, 34, 813924, 1530784195);
INSERT INTO `bbgshop_footprint` VALUES (3240, 34, 1530752944419263, 1530784222);
INSERT INTO `bbgshop_footprint` VALUES (3241, 34, 1530752944419263, 1530784317);
INSERT INTO `bbgshop_footprint` VALUES (3242, 34, 1530752944419263, 1530784338);
INSERT INTO `bbgshop_footprint` VALUES (3243, 34, 1530752944419263, 1530784354);
INSERT INTO `bbgshop_footprint` VALUES (3244, 34, 813924, 1530784368);
INSERT INTO `bbgshop_footprint` VALUES (3245, 34, 519375, 1530784720);
INSERT INTO `bbgshop_footprint` VALUES (3246, 34, 141400, 1530784789);
INSERT INTO `bbgshop_footprint` VALUES (3247, 34, 841662, 1530837474);
INSERT INTO `bbgshop_footprint` VALUES (3248, 34, 841662, 1530838713);
INSERT INTO `bbgshop_footprint` VALUES (3249, 34, 813924, 1530838724);
INSERT INTO `bbgshop_footprint` VALUES (3250, 34, 1530752944419263, 1530839713);
INSERT INTO `bbgshop_footprint` VALUES (3251, 34, 1528855134649776, 1530843350);
INSERT INTO `bbgshop_footprint` VALUES (3252, 34, 1530752944419263, 1530855454);
INSERT INTO `bbgshop_footprint` VALUES (3253, 34, 477300, 1530855467);
INSERT INTO `bbgshop_footprint` VALUES (3254, 34, 428513, 1530855485);
INSERT INTO `bbgshop_footprint` VALUES (3255, 34, 7308, 1530855499);
INSERT INTO `bbgshop_footprint` VALUES (3256, 34, 19845, 1530855516);
INSERT INTO `bbgshop_footprint` VALUES (3257, 34, 19845, 1530855543);
INSERT INTO `bbgshop_footprint` VALUES (3258, 34, 1528855134649776, 1530858144);
INSERT INTO `bbgshop_footprint` VALUES (3259, 34, 1528855134649776, 1530859074);
INSERT INTO `bbgshop_footprint` VALUES (3260, 34, 1530752944419263, 1531027182);
INSERT INTO `bbgshop_footprint` VALUES (3261, 34, 616930, 1531027188);
INSERT INTO `bbgshop_footprint` VALUES (3262, 34, 504504, 1531027195);
INSERT INTO `bbgshop_footprint` VALUES (3263, 34, 813924, 1531030781);
INSERT INTO `bbgshop_footprint` VALUES (3264, 34, 813924, 1531102327);
INSERT INTO `bbgshop_footprint` VALUES (3265, 34, 60564, 1531102401);
INSERT INTO `bbgshop_footprint` VALUES (3266, 34, 2052, 1531102413);
INSERT INTO `bbgshop_footprint` VALUES (3267, 34, 841662, 1531102544);
INSERT INTO `bbgshop_footprint` VALUES (3268, 34, 813924, 1531102556);
INSERT INTO `bbgshop_footprint` VALUES (3269, 34, 813924, 1531102927);
INSERT INTO `bbgshop_footprint` VALUES (3270, 34, 813924, 1531103032);
INSERT INTO `bbgshop_footprint` VALUES (3271, 34, 813924, 1531103047);
INSERT INTO `bbgshop_footprint` VALUES (3272, 34, 813924, 1531103177);
INSERT INTO `bbgshop_footprint` VALUES (3273, 34, 841662, 1531103180);
INSERT INTO `bbgshop_footprint` VALUES (3274, 34, 813924, 1531104120);
INSERT INTO `bbgshop_footprint` VALUES (3275, 34, 813924, 1531104136);
INSERT INTO `bbgshop_footprint` VALUES (3276, 34, 841662, 1531104180);
INSERT INTO `bbgshop_footprint` VALUES (3277, 34, 813924, 1531104188);
INSERT INTO `bbgshop_footprint` VALUES (3278, 34, 813924, 1531104195);
INSERT INTO `bbgshop_footprint` VALUES (3279, 34, 841662, 1531104239);
INSERT INTO `bbgshop_footprint` VALUES (3280, 34, 813924, 1531104240);
INSERT INTO `bbgshop_footprint` VALUES (3281, 34, 813924, 1531104248);
INSERT INTO `bbgshop_footprint` VALUES (3282, 34, 813924, 1531104254);
INSERT INTO `bbgshop_footprint` VALUES (3283, 34, 813924, 1531104394);
INSERT INTO `bbgshop_footprint` VALUES (3284, 36, 841662, 1531104487);
INSERT INTO `bbgshop_footprint` VALUES (3285, 36, 841662, 1531104911);
INSERT INTO `bbgshop_footprint` VALUES (3286, 34, 841662, 1531105118);
INSERT INTO `bbgshop_footprint` VALUES (3287, 34, 841662, 1531105219);
INSERT INTO `bbgshop_footprint` VALUES (3288, 34, 841662, 1531105327);
INSERT INTO `bbgshop_footprint` VALUES (3289, 34, 1528855134649776, 1531113484);
INSERT INTO `bbgshop_footprint` VALUES (3290, 34, 1530752944419263, 1531113491);
INSERT INTO `bbgshop_footprint` VALUES (3291, 34, 1528855134649776, 1531113534);
INSERT INTO `bbgshop_footprint` VALUES (3292, 34, 1528855134649776, 1531113636);
INSERT INTO `bbgshop_footprint` VALUES (3293, 34, 1528855134649776, 1531113802);
INSERT INTO `bbgshop_footprint` VALUES (3294, 34, 1530752944419263, 1531113894);
INSERT INTO `bbgshop_footprint` VALUES (3295, 34, 477300, 1531114071);
INSERT INTO `bbgshop_footprint` VALUES (3296, 34, 477300, 1531114079);
INSERT INTO `bbgshop_footprint` VALUES (3297, 34, 1528855134649776, 1531122140);
INSERT INTO `bbgshop_footprint` VALUES (3298, 34, 1528855134649776, 1531122167);
INSERT INTO `bbgshop_footprint` VALUES (3299, 34, 1528855134649776, 1531122252);
INSERT INTO `bbgshop_footprint` VALUES (3300, 34, 1530752944419263, 1531125935);
INSERT INTO `bbgshop_footprint` VALUES (3301, 34, 1530752944419263, 1531125937);
INSERT INTO `bbgshop_footprint` VALUES (3302, 34, 1528855134649776, 1531125969);
INSERT INTO `bbgshop_footprint` VALUES (3303, 34, 813924, 1531192682);
INSERT INTO `bbgshop_footprint` VALUES (3304, 34, 813924, 1531192685);
INSERT INTO `bbgshop_footprint` VALUES (3305, 34, 813924, 1531192694);
INSERT INTO `bbgshop_footprint` VALUES (3306, 34, 519375, 1531208779);
INSERT INTO `bbgshop_footprint` VALUES (3307, 34, 519375, 1531209428);
INSERT INTO `bbgshop_footprint` VALUES (3308, 34, 90706, 1531209431);
INSERT INTO `bbgshop_footprint` VALUES (3309, 34, 1528855134649776, 1531214366);
INSERT INTO `bbgshop_footprint` VALUES (3310, 34, 1528855134649776, 1531214368);
INSERT INTO `bbgshop_footprint` VALUES (3311, 34, 1528855134649776, 1531214372);
INSERT INTO `bbgshop_footprint` VALUES (3312, 34, 1528855134649776, 1531214375);
INSERT INTO `bbgshop_footprint` VALUES (3313, 34, 1528855134649776, 1531214378);
INSERT INTO `bbgshop_footprint` VALUES (3314, 34, 813924, 1531214382);
INSERT INTO `bbgshop_footprint` VALUES (3315, 34, 813924, 1531214384);
INSERT INTO `bbgshop_footprint` VALUES (3316, 34, 1528855134649776, 1531214451);
INSERT INTO `bbgshop_footprint` VALUES (3317, 34, 1528855134649776, 1531291404);
INSERT INTO `bbgshop_footprint` VALUES (3318, 34, 284518, 1531294758);
INSERT INTO `bbgshop_footprint` VALUES (3319, 34, 1530752944419263, 1531302846);
INSERT INTO `bbgshop_footprint` VALUES (3320, 34, 519375, 1531303303);
INSERT INTO `bbgshop_footprint` VALUES (3321, 34, 1530752944419263, 1531303325);
INSERT INTO `bbgshop_footprint` VALUES (3322, 34, 1528855134649776, 1531303454);
INSERT INTO `bbgshop_footprint` VALUES (3323, 34, 1528855134649776, 1531355924);
INSERT INTO `bbgshop_footprint` VALUES (3324, 34, 813924, 1531359449);
INSERT INTO `bbgshop_footprint` VALUES (3325, 34, 369904, 1531360017);
INSERT INTO `bbgshop_footprint` VALUES (3326, 34, 1528855134649776, 1531361249);
INSERT INTO `bbgshop_footprint` VALUES (3327, 34, 519375, 1531361255);
INSERT INTO `bbgshop_footprint` VALUES (3328, 32, 1528855134649776, 1531365265);
INSERT INTO `bbgshop_footprint` VALUES (3329, 32, 369904, 1531365292);
INSERT INTO `bbgshop_footprint` VALUES (3330, 32, 841662, 1531365479);
INSERT INTO `bbgshop_footprint` VALUES (3331, 32, 813924, 1531365484);
INSERT INTO `bbgshop_footprint` VALUES (3332, 32, 477300, 1531365698);
INSERT INTO `bbgshop_footprint` VALUES (3333, 32, 1528855134649776, 1531365702);
INSERT INTO `bbgshop_footprint` VALUES (3334, 32, 1528855134649776, 1531365719);
INSERT INTO `bbgshop_footprint` VALUES (3335, 34, 1528855134649776, 1531366389);
INSERT INTO `bbgshop_footprint` VALUES (3336, 34, 1530752944419263, 1531366676);
INSERT INTO `bbgshop_footprint` VALUES (3337, 34, 1528855134649776, 1531366680);
INSERT INTO `bbgshop_footprint` VALUES (3338, 34, 1530752944419263, 1531366683);
INSERT INTO `bbgshop_footprint` VALUES (3339, 34, 1530752944419263, 1531371684);
INSERT INTO `bbgshop_footprint` VALUES (3340, 34, 1530752944419263, 1531371717);
INSERT INTO `bbgshop_footprint` VALUES (3341, 34, 1530752944419263, 1531371742);
INSERT INTO `bbgshop_footprint` VALUES (3342, 34, 1530752944419263, 1531371743);
INSERT INTO `bbgshop_footprint` VALUES (3343, 34, 1530752944419263, 1531371757);
INSERT INTO `bbgshop_footprint` VALUES (3344, 34, 841662, 1531371774);
INSERT INTO `bbgshop_footprint` VALUES (3345, 34, 250852, 1531371794);
INSERT INTO `bbgshop_footprint` VALUES (3346, 34, 519375, 1531372470);
INSERT INTO `bbgshop_footprint` VALUES (3347, 34, 369000, 1531372631);
INSERT INTO `bbgshop_footprint` VALUES (3348, 34, 504504, 1531372912);
INSERT INTO `bbgshop_footprint` VALUES (3349, 34, 504504, 1531372916);
INSERT INTO `bbgshop_footprint` VALUES (3350, 34, 303863, 1531372932);
INSERT INTO `bbgshop_footprint` VALUES (3351, 34, 813924, 1531373725);
INSERT INTO `bbgshop_footprint` VALUES (3352, 34, 1528855134649776, 1531373743);
INSERT INTO `bbgshop_footprint` VALUES (3353, 34, 1530752944419263, 1531373753);
INSERT INTO `bbgshop_footprint` VALUES (3354, 32, 1530752944419263, 1531384747);
INSERT INTO `bbgshop_footprint` VALUES (3355, 34, 841662, 1531384754);
INSERT INTO `bbgshop_footprint` VALUES (3356, 34, 841662, 1531384775);
INSERT INTO `bbgshop_footprint` VALUES (3357, 34, 841662, 1531384903);
INSERT INTO `bbgshop_footprint` VALUES (3358, 34, 841662, 1531384986);
INSERT INTO `bbgshop_footprint` VALUES (3359, 34, 841662, 1531384999);
INSERT INTO `bbgshop_footprint` VALUES (3360, 34, 841662, 1531385037);
INSERT INTO `bbgshop_footprint` VALUES (3361, 34, 841662, 1531385104);
INSERT INTO `bbgshop_footprint` VALUES (3362, 34, 841662, 1531385133);
INSERT INTO `bbgshop_footprint` VALUES (3363, 34, 841662, 1531385145);
INSERT INTO `bbgshop_footprint` VALUES (3364, 34, 841662, 1531385167);
INSERT INTO `bbgshop_footprint` VALUES (3365, 34, 841662, 1531385206);
INSERT INTO `bbgshop_footprint` VALUES (3366, 34, 841662, 1531385312);
INSERT INTO `bbgshop_footprint` VALUES (3367, 34, 841662, 1531385323);
INSERT INTO `bbgshop_footprint` VALUES (3368, 34, 841662, 1531385329);
INSERT INTO `bbgshop_footprint` VALUES (3369, 34, 841662, 1531385364);
INSERT INTO `bbgshop_footprint` VALUES (3370, 34, 841662, 1531385382);
INSERT INTO `bbgshop_footprint` VALUES (3371, 34, 841662, 1531385426);
INSERT INTO `bbgshop_footprint` VALUES (3372, 34, 841662, 1531385434);
INSERT INTO `bbgshop_footprint` VALUES (3373, 34, 841662, 1531385466);
INSERT INTO `bbgshop_footprint` VALUES (3374, 34, 841662, 1531385590);
INSERT INTO `bbgshop_footprint` VALUES (3375, 34, 841662, 1531385688);
INSERT INTO `bbgshop_footprint` VALUES (3376, 34, 841662, 1531385698);
INSERT INTO `bbgshop_footprint` VALUES (3377, 34, 841662, 1531385725);
INSERT INTO `bbgshop_footprint` VALUES (3378, 34, 841662, 1531385809);
INSERT INTO `bbgshop_footprint` VALUES (3379, 34, 841662, 1531385810);
INSERT INTO `bbgshop_footprint` VALUES (3380, 34, 841662, 1531385845);
INSERT INTO `bbgshop_footprint` VALUES (3381, 34, 841662, 1531385885);
INSERT INTO `bbgshop_footprint` VALUES (3382, 34, 841662, 1531385931);
INSERT INTO `bbgshop_footprint` VALUES (3383, 34, 841662, 1531385963);
INSERT INTO `bbgshop_footprint` VALUES (3384, 34, 841662, 1531385986);
INSERT INTO `bbgshop_footprint` VALUES (3385, 34, 841662, 1531385997);
INSERT INTO `bbgshop_footprint` VALUES (3386, 34, 841662, 1531386009);
INSERT INTO `bbgshop_footprint` VALUES (3387, 34, 841662, 1531386021);
INSERT INTO `bbgshop_footprint` VALUES (3388, 34, 841662, 1531386029);
INSERT INTO `bbgshop_footprint` VALUES (3389, 34, 841662, 1531386067);
INSERT INTO `bbgshop_footprint` VALUES (3390, 34, 841662, 1531386090);
INSERT INTO `bbgshop_footprint` VALUES (3391, 34, 841662, 1531386101);
INSERT INTO `bbgshop_footprint` VALUES (3392, 34, 841662, 1531386116);
INSERT INTO `bbgshop_footprint` VALUES (3393, 34, 841662, 1531386129);
INSERT INTO `bbgshop_footprint` VALUES (3394, 34, 841662, 1531386220);
INSERT INTO `bbgshop_footprint` VALUES (3395, 34, 841662, 1531386268);
INSERT INTO `bbgshop_footprint` VALUES (3396, 34, 841662, 1531386277);
INSERT INTO `bbgshop_footprint` VALUES (3397, 34, 841662, 1531386307);
INSERT INTO `bbgshop_footprint` VALUES (3398, 34, 841662, 1531386333);
INSERT INTO `bbgshop_footprint` VALUES (3399, 34, 841662, 1531386361);
INSERT INTO `bbgshop_footprint` VALUES (3400, 34, 841662, 1531386371);
INSERT INTO `bbgshop_footprint` VALUES (3401, 34, 841662, 1531386409);
INSERT INTO `bbgshop_footprint` VALUES (3402, 34, 841662, 1531386424);
INSERT INTO `bbgshop_footprint` VALUES (3403, 34, 841662, 1531386435);
INSERT INTO `bbgshop_footprint` VALUES (3404, 34, 841662, 1531386458);
INSERT INTO `bbgshop_footprint` VALUES (3405, 34, 841662, 1531386541);
INSERT INTO `bbgshop_footprint` VALUES (3406, 34, 841662, 1531386547);
INSERT INTO `bbgshop_footprint` VALUES (3407, 34, 841662, 1531386554);
INSERT INTO `bbgshop_footprint` VALUES (3408, 34, 841662, 1531386593);
INSERT INTO `bbgshop_footprint` VALUES (3409, 34, 841662, 1531386607);
INSERT INTO `bbgshop_footprint` VALUES (3410, 34, 841662, 1531386621);
INSERT INTO `bbgshop_footprint` VALUES (3411, 34, 841662, 1531386663);
INSERT INTO `bbgshop_footprint` VALUES (3412, 34, 841662, 1531386693);
INSERT INTO `bbgshop_footprint` VALUES (3413, 34, 841662, 1531386732);
INSERT INTO `bbgshop_footprint` VALUES (3414, 34, 841662, 1531386774);
INSERT INTO `bbgshop_footprint` VALUES (3415, 34, 841662, 1531386788);
INSERT INTO `bbgshop_footprint` VALUES (3416, 34, 841662, 1531386835);
INSERT INTO `bbgshop_footprint` VALUES (3417, 34, 841662, 1531386882);
INSERT INTO `bbgshop_footprint` VALUES (3418, 34, 841662, 1531386893);
INSERT INTO `bbgshop_footprint` VALUES (3419, 34, 841662, 1531386944);
INSERT INTO `bbgshop_footprint` VALUES (3420, 34, 841662, 1531386967);
INSERT INTO `bbgshop_footprint` VALUES (3421, 34, 841662, 1531386975);
INSERT INTO `bbgshop_footprint` VALUES (3422, 34, 841662, 1531386994);
INSERT INTO `bbgshop_footprint` VALUES (3423, 34, 841662, 1531387007);
INSERT INTO `bbgshop_footprint` VALUES (3424, 34, 841662, 1531387039);
INSERT INTO `bbgshop_footprint` VALUES (3425, 34, 841662, 1531387095);
INSERT INTO `bbgshop_footprint` VALUES (3426, 34, 841662, 1531387117);
INSERT INTO `bbgshop_footprint` VALUES (3427, 34, 841662, 1531387129);
INSERT INTO `bbgshop_footprint` VALUES (3428, 34, 841662, 1531387133);
INSERT INTO `bbgshop_footprint` VALUES (3429, 32, 841662, 1531387158);
INSERT INTO `bbgshop_footprint` VALUES (3430, 34, 841662, 1531387200);
INSERT INTO `bbgshop_footprint` VALUES (3431, 34, 841662, 1531387212);
INSERT INTO `bbgshop_footprint` VALUES (3432, 34, 841662, 1531387270);
INSERT INTO `bbgshop_footprint` VALUES (3433, 34, 841662, 1531387285);
INSERT INTO `bbgshop_footprint` VALUES (3434, 34, 841662, 1531387297);
INSERT INTO `bbgshop_footprint` VALUES (3435, 34, 841662, 1531387380);
INSERT INTO `bbgshop_footprint` VALUES (3436, 34, 841662, 1531387440);
INSERT INTO `bbgshop_footprint` VALUES (3437, 34, 841662, 1531387455);
INSERT INTO `bbgshop_footprint` VALUES (3438, 34, 841662, 1531387535);
INSERT INTO `bbgshop_footprint` VALUES (3439, 34, 841662, 1531387553);
INSERT INTO `bbgshop_footprint` VALUES (3440, 34, 841662, 1531387584);
INSERT INTO `bbgshop_footprint` VALUES (3441, 34, 841662, 1531387614);
INSERT INTO `bbgshop_footprint` VALUES (3442, 34, 841662, 1531387645);
INSERT INTO `bbgshop_footprint` VALUES (3443, 34, 841662, 1531387653);
INSERT INTO `bbgshop_footprint` VALUES (3444, 34, 841662, 1531387662);
INSERT INTO `bbgshop_footprint` VALUES (3445, 34, 841662, 1531387681);
INSERT INTO `bbgshop_footprint` VALUES (3446, 34, 841662, 1531387701);
INSERT INTO `bbgshop_footprint` VALUES (3447, 34, 841662, 1531387710);
INSERT INTO `bbgshop_footprint` VALUES (3448, 34, 841662, 1531387720);
INSERT INTO `bbgshop_footprint` VALUES (3449, 34, 841662, 1531387737);
INSERT INTO `bbgshop_footprint` VALUES (3450, 34, 841662, 1531387745);
INSERT INTO `bbgshop_footprint` VALUES (3451, 34, 841662, 1531387783);
INSERT INTO `bbgshop_footprint` VALUES (3452, 34, 841662, 1531387954);
INSERT INTO `bbgshop_footprint` VALUES (3453, 34, 841662, 1531387987);
INSERT INTO `bbgshop_footprint` VALUES (3454, 34, 841662, 1531388006);
INSERT INTO `bbgshop_footprint` VALUES (3455, 34, 841662, 1531388089);
INSERT INTO `bbgshop_footprint` VALUES (3456, 34, 841662, 1531388124);
INSERT INTO `bbgshop_footprint` VALUES (3457, 34, 841662, 1531388199);
INSERT INTO `bbgshop_footprint` VALUES (3458, 34, 841662, 1531388213);
INSERT INTO `bbgshop_footprint` VALUES (3459, 34, 841662, 1531388612);
INSERT INTO `bbgshop_footprint` VALUES (3460, 34, 841662, 1531388661);
INSERT INTO `bbgshop_footprint` VALUES (3461, 34, 841662, 1531388718);
INSERT INTO `bbgshop_footprint` VALUES (3462, 34, 841662, 1531388722);
INSERT INTO `bbgshop_footprint` VALUES (3463, 34, 841662, 1531388832);
INSERT INTO `bbgshop_footprint` VALUES (3464, 34, 841662, 1531388841);
INSERT INTO `bbgshop_footprint` VALUES (3465, 34, 841662, 1531388855);
INSERT INTO `bbgshop_footprint` VALUES (3466, 34, 841662, 1531388867);
INSERT INTO `bbgshop_footprint` VALUES (3467, 34, 841662, 1531388946);
INSERT INTO `bbgshop_footprint` VALUES (3468, 34, 841662, 1531388998);
INSERT INTO `bbgshop_footprint` VALUES (3469, 34, 841662, 1531389129);
INSERT INTO `bbgshop_footprint` VALUES (3470, 34, 841662, 1531389140);
INSERT INTO `bbgshop_footprint` VALUES (3471, 34, 841662, 1531389166);
INSERT INTO `bbgshop_footprint` VALUES (3472, 34, 841662, 1531389178);
INSERT INTO `bbgshop_footprint` VALUES (3473, 34, 841662, 1531389196);
INSERT INTO `bbgshop_footprint` VALUES (3474, 34, 841662, 1531389245);
INSERT INTO `bbgshop_footprint` VALUES (3475, 34, 841662, 1531389258);
INSERT INTO `bbgshop_footprint` VALUES (3476, 34, 841662, 1531389336);
INSERT INTO `bbgshop_footprint` VALUES (3477, 34, 841662, 1531389404);
INSERT INTO `bbgshop_footprint` VALUES (3478, 34, 841662, 1531389461);
INSERT INTO `bbgshop_footprint` VALUES (3479, 34, 841662, 1531389508);
INSERT INTO `bbgshop_footprint` VALUES (3480, 34, 841662, 1531389513);
INSERT INTO `bbgshop_footprint` VALUES (3481, 34, 841662, 1531389558);
INSERT INTO `bbgshop_footprint` VALUES (3482, 34, 841662, 1531389606);
INSERT INTO `bbgshop_footprint` VALUES (3483, 34, 841662, 1531389631);
INSERT INTO `bbgshop_footprint` VALUES (3484, 34, 841662, 1531389649);
INSERT INTO `bbgshop_footprint` VALUES (3485, 34, 841662, 1531389676);
INSERT INTO `bbgshop_footprint` VALUES (3486, 34, 841662, 1531389691);
INSERT INTO `bbgshop_footprint` VALUES (3487, 34, 841662, 1531389709);
INSERT INTO `bbgshop_footprint` VALUES (3488, 34, 841662, 1531389718);
INSERT INTO `bbgshop_footprint` VALUES (3489, 34, 841662, 1531389728);
INSERT INTO `bbgshop_footprint` VALUES (3490, 34, 841662, 1531389741);
INSERT INTO `bbgshop_footprint` VALUES (3491, 34, 841662, 1531389749);
INSERT INTO `bbgshop_footprint` VALUES (3492, 34, 841662, 1531389765);
INSERT INTO `bbgshop_footprint` VALUES (3493, 34, 841662, 1531389768);
INSERT INTO `bbgshop_footprint` VALUES (3494, 34, 841662, 1531389799);
INSERT INTO `bbgshop_footprint` VALUES (3495, 34, 841662, 1531389830);
INSERT INTO `bbgshop_footprint` VALUES (3496, 34, 841662, 1531389839);
INSERT INTO `bbgshop_footprint` VALUES (3497, 34, 841662, 1531389850);
INSERT INTO `bbgshop_footprint` VALUES (3498, 34, 841662, 1531389859);
INSERT INTO `bbgshop_footprint` VALUES (3499, 34, 841662, 1531389871);
INSERT INTO `bbgshop_footprint` VALUES (3500, 34, 841662, 1531389881);
INSERT INTO `bbgshop_footprint` VALUES (3501, 34, 841662, 1531389896);
INSERT INTO `bbgshop_footprint` VALUES (3502, 34, 841662, 1531389903);
INSERT INTO `bbgshop_footprint` VALUES (3503, 34, 841662, 1531389911);
INSERT INTO `bbgshop_footprint` VALUES (3504, 34, 841662, 1531389943);
INSERT INTO `bbgshop_footprint` VALUES (3505, 34, 841662, 1531389968);
INSERT INTO `bbgshop_footprint` VALUES (3506, 34, 841662, 1531389981);
INSERT INTO `bbgshop_footprint` VALUES (3507, 34, 841662, 1531390022);
INSERT INTO `bbgshop_footprint` VALUES (3508, 34, 841662, 1531390048);
INSERT INTO `bbgshop_footprint` VALUES (3509, 34, 841662, 1531390059);
INSERT INTO `bbgshop_footprint` VALUES (3510, 34, 841662, 1531390065);
INSERT INTO `bbgshop_footprint` VALUES (3511, 34, 841662, 1531390073);
INSERT INTO `bbgshop_footprint` VALUES (3512, 34, 841662, 1531390106);
INSERT INTO `bbgshop_footprint` VALUES (3513, 34, 841662, 1531390112);
INSERT INTO `bbgshop_footprint` VALUES (3514, 34, 841662, 1531390158);
INSERT INTO `bbgshop_footprint` VALUES (3515, 34, 841662, 1531390212);
INSERT INTO `bbgshop_footprint` VALUES (3516, 34, 841662, 1531390231);
INSERT INTO `bbgshop_footprint` VALUES (3517, 34, 841662, 1531390256);
INSERT INTO `bbgshop_footprint` VALUES (3518, 34, 841662, 1531390314);
INSERT INTO `bbgshop_footprint` VALUES (3519, 34, 841662, 1531390339);
INSERT INTO `bbgshop_footprint` VALUES (3520, 34, 841662, 1531390357);
INSERT INTO `bbgshop_footprint` VALUES (3521, 34, 841662, 1531390367);
INSERT INTO `bbgshop_footprint` VALUES (3522, 34, 841662, 1531390378);
INSERT INTO `bbgshop_footprint` VALUES (3523, 34, 841662, 1531390387);
INSERT INTO `bbgshop_footprint` VALUES (3524, 34, 841662, 1531390422);
INSERT INTO `bbgshop_footprint` VALUES (3525, 34, 841662, 1531390434);
INSERT INTO `bbgshop_footprint` VALUES (3526, 34, 841662, 1531390476);
INSERT INTO `bbgshop_footprint` VALUES (3527, 34, 841662, 1531390482);
INSERT INTO `bbgshop_footprint` VALUES (3528, 34, 841662, 1531390488);
INSERT INTO `bbgshop_footprint` VALUES (3529, 34, 841662, 1531390526);
INSERT INTO `bbgshop_footprint` VALUES (3530, 34, 841662, 1531390604);
INSERT INTO `bbgshop_footprint` VALUES (3531, 34, 841662, 1531390609);
INSERT INTO `bbgshop_footprint` VALUES (3532, 34, 841662, 1531390659);
INSERT INTO `bbgshop_footprint` VALUES (3533, 34, 841662, 1531390668);
INSERT INTO `bbgshop_footprint` VALUES (3534, 34, 841662, 1531390676);
INSERT INTO `bbgshop_footprint` VALUES (3535, 34, 841662, 1531390684);
INSERT INTO `bbgshop_footprint` VALUES (3536, 34, 841662, 1531390738);
INSERT INTO `bbgshop_footprint` VALUES (3537, 34, 841662, 1531390748);
INSERT INTO `bbgshop_footprint` VALUES (3538, 34, 841662, 1531390776);
INSERT INTO `bbgshop_footprint` VALUES (3539, 34, 841662, 1531390799);
INSERT INTO `bbgshop_footprint` VALUES (3540, 34, 841662, 1531390821);
INSERT INTO `bbgshop_footprint` VALUES (3541, 34, 841662, 1531390834);
INSERT INTO `bbgshop_footprint` VALUES (3542, 34, 841662, 1531390870);
INSERT INTO `bbgshop_footprint` VALUES (3543, 34, 841662, 1531390880);
INSERT INTO `bbgshop_footprint` VALUES (3544, 34, 841662, 1531390891);
INSERT INTO `bbgshop_footprint` VALUES (3545, 34, 841662, 1531390899);
INSERT INTO `bbgshop_footprint` VALUES (3546, 34, 841662, 1531390933);
INSERT INTO `bbgshop_footprint` VALUES (3547, 34, 841662, 1531390957);
INSERT INTO `bbgshop_footprint` VALUES (3548, 34, 841662, 1531390964);
INSERT INTO `bbgshop_footprint` VALUES (3549, 34, 841662, 1531390972);
INSERT INTO `bbgshop_footprint` VALUES (3550, 34, 841662, 1531390978);
INSERT INTO `bbgshop_footprint` VALUES (3551, 34, 841662, 1531390989);
INSERT INTO `bbgshop_footprint` VALUES (3552, 34, 841662, 1531391006);
INSERT INTO `bbgshop_footprint` VALUES (3553, 34, 841662, 1531391021);
INSERT INTO `bbgshop_footprint` VALUES (3554, 34, 841662, 1531391048);
INSERT INTO `bbgshop_footprint` VALUES (3555, 34, 841662, 1531391053);
INSERT INTO `bbgshop_footprint` VALUES (3556, 34, 841662, 1531391062);
INSERT INTO `bbgshop_footprint` VALUES (3557, 34, 841662, 1531391068);
INSERT INTO `bbgshop_footprint` VALUES (3558, 34, 841662, 1531391087);
INSERT INTO `bbgshop_footprint` VALUES (3559, 34, 841662, 1531391112);
INSERT INTO `bbgshop_footprint` VALUES (3560, 34, 841662, 1531391144);
INSERT INTO `bbgshop_footprint` VALUES (3561, 34, 841662, 1531391152);
INSERT INTO `bbgshop_footprint` VALUES (3562, 34, 841662, 1531391181);
INSERT INTO `bbgshop_footprint` VALUES (3563, 34, 841662, 1531391194);
INSERT INTO `bbgshop_footprint` VALUES (3564, 34, 1530752944419263, 1531391208);
INSERT INTO `bbgshop_footprint` VALUES (3565, 34, 1528855134649776, 1531391231);
INSERT INTO `bbgshop_footprint` VALUES (3566, 34, 519375, 1531391267);
INSERT INTO `bbgshop_footprint` VALUES (3567, 34, 1530752944419263, 1531391280);
INSERT INTO `bbgshop_footprint` VALUES (3568, 34, 519375, 1531391284);
INSERT INTO `bbgshop_footprint` VALUES (3569, 34, 841662, 1531391312);
INSERT INTO `bbgshop_footprint` VALUES (3570, 34, 841662, 1531391319);
INSERT INTO `bbgshop_footprint` VALUES (3571, 34, 841662, 1531391331);
INSERT INTO `bbgshop_footprint` VALUES (3572, 34, 841662, 1531391345);
INSERT INTO `bbgshop_footprint` VALUES (3573, 34, 841662, 1531391362);
INSERT INTO `bbgshop_footprint` VALUES (3574, 34, 841662, 1531391375);
INSERT INTO `bbgshop_footprint` VALUES (3575, 34, 841662, 1531391401);
INSERT INTO `bbgshop_footprint` VALUES (3576, 34, 841662, 1531391410);
INSERT INTO `bbgshop_footprint` VALUES (3577, 34, 841662, 1531391425);
INSERT INTO `bbgshop_footprint` VALUES (3578, 34, 841662, 1531391584);
INSERT INTO `bbgshop_footprint` VALUES (3579, 34, 841662, 1531391613);
INSERT INTO `bbgshop_footprint` VALUES (3580, 34, 841662, 1531391623);
INSERT INTO `bbgshop_footprint` VALUES (3581, 34, 841662, 1531391682);
INSERT INTO `bbgshop_footprint` VALUES (3582, 34, 841662, 1531391685);
INSERT INTO `bbgshop_footprint` VALUES (3583, 34, 841662, 1531391689);
INSERT INTO `bbgshop_footprint` VALUES (3584, 34, 841662, 1531391699);
INSERT INTO `bbgshop_footprint` VALUES (3585, 34, 841662, 1531391722);
INSERT INTO `bbgshop_footprint` VALUES (3586, 34, 841662, 1531391730);
INSERT INTO `bbgshop_footprint` VALUES (3587, 34, 841662, 1531391736);
INSERT INTO `bbgshop_footprint` VALUES (3588, 34, 841662, 1531391804);
INSERT INTO `bbgshop_footprint` VALUES (3589, 34, 841662, 1531391834);
INSERT INTO `bbgshop_footprint` VALUES (3590, 34, 841662, 1531391871);
INSERT INTO `bbgshop_footprint` VALUES (3591, 34, 841662, 1531391878);
INSERT INTO `bbgshop_footprint` VALUES (3592, 34, 841662, 1531391893);
INSERT INTO `bbgshop_footprint` VALUES (3593, 34, 841662, 1531391953);
INSERT INTO `bbgshop_footprint` VALUES (3594, 34, 841662, 1531391976);
INSERT INTO `bbgshop_footprint` VALUES (3595, 34, 841662, 1531392016);
INSERT INTO `bbgshop_footprint` VALUES (3596, 34, 841662, 1531392027);
INSERT INTO `bbgshop_footprint` VALUES (3597, 34, 841662, 1531392037);
INSERT INTO `bbgshop_footprint` VALUES (3598, 34, 841662, 1531392106);
INSERT INTO `bbgshop_footprint` VALUES (3599, 34, 841662, 1531392122);
INSERT INTO `bbgshop_footprint` VALUES (3600, 34, 477300, 1531392134);
INSERT INTO `bbgshop_footprint` VALUES (3601, 34, 1530752944419263, 1531392147);
INSERT INTO `bbgshop_footprint` VALUES (3602, 34, 477300, 1531392192);
INSERT INTO `bbgshop_footprint` VALUES (3603, 34, 1530752944419263, 1531392220);
INSERT INTO `bbgshop_footprint` VALUES (3604, 34, 519375, 1531392309);
INSERT INTO `bbgshop_footprint` VALUES (3605, 34, 267471, 1531392314);
INSERT INTO `bbgshop_footprint` VALUES (3606, 34, 841662, 1531441801);
INSERT INTO `bbgshop_footprint` VALUES (3607, 34, 284518, 1531441824);
INSERT INTO `bbgshop_footprint` VALUES (3608, 34, 841662, 1531441977);
INSERT INTO `bbgshop_footprint` VALUES (3609, 34, 841662, 1531441987);
INSERT INTO `bbgshop_footprint` VALUES (3610, 34, 841662, 1531442148);
INSERT INTO `bbgshop_footprint` VALUES (3611, 34, 841662, 1531442217);
INSERT INTO `bbgshop_footprint` VALUES (3612, 34, 841662, 1531442227);
INSERT INTO `bbgshop_footprint` VALUES (3613, 34, 841662, 1531442251);
INSERT INTO `bbgshop_footprint` VALUES (3614, 34, 841662, 1531442271);
INSERT INTO `bbgshop_footprint` VALUES (3615, 34, 841662, 1531442303);
INSERT INTO `bbgshop_footprint` VALUES (3616, 34, 841662, 1531442350);
INSERT INTO `bbgshop_footprint` VALUES (3617, 34, 841662, 1531442378);
INSERT INTO `bbgshop_footprint` VALUES (3618, 34, 841662, 1531442401);
INSERT INTO `bbgshop_footprint` VALUES (3619, 34, 841662, 1531442410);
INSERT INTO `bbgshop_footprint` VALUES (3620, 34, 841662, 1531442444);
INSERT INTO `bbgshop_footprint` VALUES (3621, 34, 841662, 1531442450);
INSERT INTO `bbgshop_footprint` VALUES (3622, 34, 841662, 1531442483);
INSERT INTO `bbgshop_footprint` VALUES (3623, 34, 841662, 1531442512);
INSERT INTO `bbgshop_footprint` VALUES (3624, 34, 841662, 1531442561);
INSERT INTO `bbgshop_footprint` VALUES (3625, 34, 841662, 1531442581);
INSERT INTO `bbgshop_footprint` VALUES (3626, 34, 841662, 1531442594);
INSERT INTO `bbgshop_footprint` VALUES (3627, 34, 841662, 1531442601);
INSERT INTO `bbgshop_footprint` VALUES (3628, 34, 841662, 1531442610);
INSERT INTO `bbgshop_footprint` VALUES (3629, 34, 841662, 1531442618);
INSERT INTO `bbgshop_footprint` VALUES (3630, 34, 841662, 1531442638);
INSERT INTO `bbgshop_footprint` VALUES (3631, 34, 841662, 1531442652);
INSERT INTO `bbgshop_footprint` VALUES (3632, 34, 841662, 1531442669);
INSERT INTO `bbgshop_footprint` VALUES (3633, 34, 841662, 1531442677);
INSERT INTO `bbgshop_footprint` VALUES (3634, 34, 841662, 1531442681);
INSERT INTO `bbgshop_footprint` VALUES (3635, 34, 841662, 1531442693);
INSERT INTO `bbgshop_footprint` VALUES (3636, 34, 841662, 1531442701);
INSERT INTO `bbgshop_footprint` VALUES (3637, 34, 841662, 1531442707);
INSERT INTO `bbgshop_footprint` VALUES (3638, 34, 841662, 1531442719);
INSERT INTO `bbgshop_footprint` VALUES (3639, 34, 841662, 1531442733);
INSERT INTO `bbgshop_footprint` VALUES (3640, 34, 841662, 1531442741);
INSERT INTO `bbgshop_footprint` VALUES (3641, 34, 841662, 1531442748);
INSERT INTO `bbgshop_footprint` VALUES (3642, 34, 841662, 1531442840);
INSERT INTO `bbgshop_footprint` VALUES (3643, 34, 841662, 1531442885);
INSERT INTO `bbgshop_footprint` VALUES (3644, 34, 841662, 1531442905);
INSERT INTO `bbgshop_footprint` VALUES (3645, 34, 841662, 1531442949);
INSERT INTO `bbgshop_footprint` VALUES (3646, 34, 841662, 1531442956);
INSERT INTO `bbgshop_footprint` VALUES (3647, 34, 841662, 1531442972);
INSERT INTO `bbgshop_footprint` VALUES (3648, 34, 841662, 1531443089);
INSERT INTO `bbgshop_footprint` VALUES (3649, 34, 841662, 1531443111);
INSERT INTO `bbgshop_footprint` VALUES (3650, 34, 841662, 1531443144);
INSERT INTO `bbgshop_footprint` VALUES (3651, 34, 841662, 1531443187);
INSERT INTO `bbgshop_footprint` VALUES (3652, 34, 841662, 1531443213);
INSERT INTO `bbgshop_footprint` VALUES (3653, 34, 841662, 1531443228);
INSERT INTO `bbgshop_footprint` VALUES (3654, 34, 841662, 1531443275);
INSERT INTO `bbgshop_footprint` VALUES (3655, 34, 841662, 1531443351);
INSERT INTO `bbgshop_footprint` VALUES (3656, 34, 841662, 1531443375);
INSERT INTO `bbgshop_footprint` VALUES (3657, 34, 841662, 1531443391);
INSERT INTO `bbgshop_footprint` VALUES (3658, 34, 841662, 1531443400);
INSERT INTO `bbgshop_footprint` VALUES (3659, 34, 841662, 1531443438);
INSERT INTO `bbgshop_footprint` VALUES (3660, 34, 841662, 1531443457);
INSERT INTO `bbgshop_footprint` VALUES (3661, 34, 841662, 1531443466);
INSERT INTO `bbgshop_footprint` VALUES (3662, 34, 841662, 1531443474);
INSERT INTO `bbgshop_footprint` VALUES (3663, 34, 841662, 1531443604);
INSERT INTO `bbgshop_footprint` VALUES (3664, 34, 841662, 1531443631);
INSERT INTO `bbgshop_footprint` VALUES (3665, 32, 841662, 1531443668);
INSERT INTO `bbgshop_footprint` VALUES (3666, 34, 1530752944419263, 1531443717);
INSERT INTO `bbgshop_footprint` VALUES (3667, 34, 1528855134649776, 1531443822);
INSERT INTO `bbgshop_footprint` VALUES (3668, 34, 841662, 1531443885);
INSERT INTO `bbgshop_footprint` VALUES (3669, 32, 841662, 1531443922);
INSERT INTO `bbgshop_footprint` VALUES (3670, 34, 841662, 1531444022);
INSERT INTO `bbgshop_footprint` VALUES (3671, 34, 841662, 1531444035);
INSERT INTO `bbgshop_footprint` VALUES (3672, 34, 841662, 1531444124);
INSERT INTO `bbgshop_footprint` VALUES (3673, 34, 841662, 1531444148);
INSERT INTO `bbgshop_footprint` VALUES (3674, 34, 841662, 1531444189);
INSERT INTO `bbgshop_footprint` VALUES (3675, 34, 841662, 1531444267);
INSERT INTO `bbgshop_footprint` VALUES (3676, 34, 841662, 1531444297);
INSERT INTO `bbgshop_footprint` VALUES (3677, 34, 841662, 1531444313);
INSERT INTO `bbgshop_footprint` VALUES (3678, 34, 841662, 1531444335);
INSERT INTO `bbgshop_footprint` VALUES (3679, 34, 841662, 1531444345);
INSERT INTO `bbgshop_footprint` VALUES (3680, 34, 841662, 1531444358);
INSERT INTO `bbgshop_footprint` VALUES (3681, 34, 841662, 1531444389);
INSERT INTO `bbgshop_footprint` VALUES (3682, 34, 841662, 1531444423);
INSERT INTO `bbgshop_footprint` VALUES (3683, 34, 841662, 1531444436);
INSERT INTO `bbgshop_footprint` VALUES (3684, 34, 841662, 1531444442);
INSERT INTO `bbgshop_footprint` VALUES (3685, 34, 841662, 1531444452);
INSERT INTO `bbgshop_footprint` VALUES (3686, 34, 841662, 1531444506);
INSERT INTO `bbgshop_footprint` VALUES (3687, 34, 841662, 1531444533);
INSERT INTO `bbgshop_footprint` VALUES (3688, 34, 841662, 1531444565);
INSERT INTO `bbgshop_footprint` VALUES (3689, 34, 841662, 1531444585);
INSERT INTO `bbgshop_footprint` VALUES (3690, 34, 841662, 1531444592);
INSERT INTO `bbgshop_footprint` VALUES (3691, 34, 841662, 1531444601);
INSERT INTO `bbgshop_footprint` VALUES (3692, 34, 841662, 1531444610);
INSERT INTO `bbgshop_footprint` VALUES (3693, 34, 841662, 1531444620);
INSERT INTO `bbgshop_footprint` VALUES (3694, 34, 841662, 1531444640);
INSERT INTO `bbgshop_footprint` VALUES (3695, 34, 841662, 1531444681);
INSERT INTO `bbgshop_footprint` VALUES (3696, 34, 841662, 1531444693);
INSERT INTO `bbgshop_footprint` VALUES (3697, 34, 841662, 1531444736);
INSERT INTO `bbgshop_footprint` VALUES (3698, 34, 841662, 1531444744);
INSERT INTO `bbgshop_footprint` VALUES (3699, 34, 841662, 1531444750);
INSERT INTO `bbgshop_footprint` VALUES (3700, 34, 841662, 1531444762);
INSERT INTO `bbgshop_footprint` VALUES (3701, 34, 841662, 1531444828);
INSERT INTO `bbgshop_footprint` VALUES (3702, 34, 841662, 1531444849);
INSERT INTO `bbgshop_footprint` VALUES (3703, 34, 841662, 1531444866);
INSERT INTO `bbgshop_footprint` VALUES (3704, 34, 841662, 1531444898);
INSERT INTO `bbgshop_footprint` VALUES (3705, 34, 841662, 1531444912);
INSERT INTO `bbgshop_footprint` VALUES (3706, 34, 841662, 1531444920);
INSERT INTO `bbgshop_footprint` VALUES (3707, 34, 841662, 1531444946);
INSERT INTO `bbgshop_footprint` VALUES (3708, 34, 841662, 1531444954);
INSERT INTO `bbgshop_footprint` VALUES (3709, 34, 841662, 1531444976);
INSERT INTO `bbgshop_footprint` VALUES (3710, 34, 1528855134649776, 1531445009);
INSERT INTO `bbgshop_footprint` VALUES (3711, 34, 841662, 1531445032);
INSERT INTO `bbgshop_footprint` VALUES (3712, 34, 841662, 1531445045);
INSERT INTO `bbgshop_footprint` VALUES (3713, 34, 841662, 1531445061);
INSERT INTO `bbgshop_footprint` VALUES (3714, 34, 841662, 1531445095);
INSERT INTO `bbgshop_footprint` VALUES (3715, 34, 841662, 1531445110);
INSERT INTO `bbgshop_footprint` VALUES (3716, 34, 841662, 1531445119);
INSERT INTO `bbgshop_footprint` VALUES (3717, 34, 841662, 1531445148);
INSERT INTO `bbgshop_footprint` VALUES (3718, 34, 841662, 1531445266);
INSERT INTO `bbgshop_footprint` VALUES (3719, 34, 841662, 1531445280);
INSERT INTO `bbgshop_footprint` VALUES (3720, 34, 841662, 1531445289);
INSERT INTO `bbgshop_footprint` VALUES (3721, 34, 841662, 1531445341);
INSERT INTO `bbgshop_footprint` VALUES (3722, 34, 841662, 1531445354);
INSERT INTO `bbgshop_footprint` VALUES (3723, 34, 841662, 1531445375);
INSERT INTO `bbgshop_footprint` VALUES (3724, 34, 841662, 1531445384);
INSERT INTO `bbgshop_footprint` VALUES (3725, 34, 841662, 1531445394);
INSERT INTO `bbgshop_footprint` VALUES (3726, 34, 841662, 1531445410);
INSERT INTO `bbgshop_footprint` VALUES (3727, 34, 841662, 1531445436);
INSERT INTO `bbgshop_footprint` VALUES (3728, 34, 841662, 1531445608);
INSERT INTO `bbgshop_footprint` VALUES (3729, 34, 841662, 1531445613);
INSERT INTO `bbgshop_footprint` VALUES (3730, 34, 841662, 1531445636);
INSERT INTO `bbgshop_footprint` VALUES (3731, 34, 841662, 1531445742);
INSERT INTO `bbgshop_footprint` VALUES (3732, 34, 841662, 1531445796);
INSERT INTO `bbgshop_footprint` VALUES (3733, 34, 841662, 1531445843);
INSERT INTO `bbgshop_footprint` VALUES (3734, 34, 841662, 1531445901);
INSERT INTO `bbgshop_footprint` VALUES (3735, 34, 841662, 1531445922);
INSERT INTO `bbgshop_footprint` VALUES (3736, 34, 841662, 1531445967);
INSERT INTO `bbgshop_footprint` VALUES (3737, 34, 841662, 1531445999);
INSERT INTO `bbgshop_footprint` VALUES (3738, 34, 841662, 1531446027);
INSERT INTO `bbgshop_footprint` VALUES (3739, 34, 841662, 1531446041);
INSERT INTO `bbgshop_footprint` VALUES (3740, 34, 841662, 1531446058);
INSERT INTO `bbgshop_footprint` VALUES (3741, 34, 841662, 1531446076);
INSERT INTO `bbgshop_footprint` VALUES (3742, 34, 841662, 1531446089);
INSERT INTO `bbgshop_footprint` VALUES (3743, 34, 841662, 1531446101);
INSERT INTO `bbgshop_footprint` VALUES (3744, 34, 841662, 1531446121);
INSERT INTO `bbgshop_footprint` VALUES (3745, 34, 841662, 1531446141);
INSERT INTO `bbgshop_footprint` VALUES (3746, 34, 841662, 1531446156);
INSERT INTO `bbgshop_footprint` VALUES (3747, 34, 841662, 1531446174);
INSERT INTO `bbgshop_footprint` VALUES (3748, 34, 841662, 1531446227);
INSERT INTO `bbgshop_footprint` VALUES (3749, 34, 841662, 1531446269);
INSERT INTO `bbgshop_footprint` VALUES (3750, 34, 841662, 1531446280);
INSERT INTO `bbgshop_footprint` VALUES (3751, 34, 841662, 1531446326);
INSERT INTO `bbgshop_footprint` VALUES (3752, 34, 841662, 1531446335);
INSERT INTO `bbgshop_footprint` VALUES (3753, 34, 841662, 1531446379);
INSERT INTO `bbgshop_footprint` VALUES (3754, 34, 841662, 1531446417);
INSERT INTO `bbgshop_footprint` VALUES (3755, 34, 284518, 1531446447);
INSERT INTO `bbgshop_footprint` VALUES (3756, 34, 841662, 1531446465);
INSERT INTO `bbgshop_footprint` VALUES (3757, 34, 841662, 1531446479);
INSERT INTO `bbgshop_footprint` VALUES (3758, 34, 841662, 1531446489);
INSERT INTO `bbgshop_footprint` VALUES (3759, 34, 841662, 1531446527);
INSERT INTO `bbgshop_footprint` VALUES (3760, 34, 841662, 1531446589);
INSERT INTO `bbgshop_footprint` VALUES (3761, 34, 841662, 1531446644);
INSERT INTO `bbgshop_footprint` VALUES (3762, 34, 841662, 1531446667);
INSERT INTO `bbgshop_footprint` VALUES (3763, 34, 841662, 1531446686);
INSERT INTO `bbgshop_footprint` VALUES (3764, 34, 841662, 1531446718);
INSERT INTO `bbgshop_footprint` VALUES (3765, 34, 841662, 1531446735);
INSERT INTO `bbgshop_footprint` VALUES (3766, 34, 841662, 1531446749);
INSERT INTO `bbgshop_footprint` VALUES (3767, 34, 841662, 1531446790);
INSERT INTO `bbgshop_footprint` VALUES (3768, 34, 841662, 1531446798);
INSERT INTO `bbgshop_footprint` VALUES (3769, 34, 841662, 1531446817);
INSERT INTO `bbgshop_footprint` VALUES (3770, 34, 841662, 1531446823);
INSERT INTO `bbgshop_footprint` VALUES (3771, 34, 841662, 1531446839);
INSERT INTO `bbgshop_footprint` VALUES (3772, 34, 841662, 1531446850);
INSERT INTO `bbgshop_footprint` VALUES (3773, 34, 841662, 1531446864);
INSERT INTO `bbgshop_footprint` VALUES (3774, 34, 841662, 1531446922);
INSERT INTO `bbgshop_footprint` VALUES (3775, 34, 841662, 1531446939);
INSERT INTO `bbgshop_footprint` VALUES (3776, 34, 841662, 1531446951);
INSERT INTO `bbgshop_footprint` VALUES (3777, 34, 841662, 1531446961);
INSERT INTO `bbgshop_footprint` VALUES (3778, 34, 841662, 1531446967);
INSERT INTO `bbgshop_footprint` VALUES (3779, 34, 841662, 1531446972);
INSERT INTO `bbgshop_footprint` VALUES (3780, 34, 841662, 1531447014);
INSERT INTO `bbgshop_footprint` VALUES (3781, 34, 841662, 1531447019);
INSERT INTO `bbgshop_footprint` VALUES (3782, 34, 841662, 1531447035);
INSERT INTO `bbgshop_footprint` VALUES (3783, 34, 841662, 1531447042);
INSERT INTO `bbgshop_footprint` VALUES (3784, 34, 841662, 1531447049);
INSERT INTO `bbgshop_footprint` VALUES (3785, 34, 841662, 1531447057);
INSERT INTO `bbgshop_footprint` VALUES (3786, 34, 841662, 1531447208);
INSERT INTO `bbgshop_footprint` VALUES (3787, 34, 841662, 1531447282);
INSERT INTO `bbgshop_footprint` VALUES (3788, 34, 841662, 1531447313);
INSERT INTO `bbgshop_footprint` VALUES (3789, 34, 841662, 1531447323);
INSERT INTO `bbgshop_footprint` VALUES (3790, 34, 841662, 1531447337);
INSERT INTO `bbgshop_footprint` VALUES (3791, 34, 841662, 1531447396);
INSERT INTO `bbgshop_footprint` VALUES (3792, 34, 841662, 1531447407);
INSERT INTO `bbgshop_footprint` VALUES (3793, 34, 841662, 1531447416);
INSERT INTO `bbgshop_footprint` VALUES (3794, 34, 841662, 1531447430);
INSERT INTO `bbgshop_footprint` VALUES (3795, 34, 841662, 1531447439);
INSERT INTO `bbgshop_footprint` VALUES (3796, 34, 841662, 1531447457);
INSERT INTO `bbgshop_footprint` VALUES (3797, 34, 841662, 1531447470);
INSERT INTO `bbgshop_footprint` VALUES (3798, 34, 841662, 1531447484);
INSERT INTO `bbgshop_footprint` VALUES (3799, 34, 841662, 1531447513);
INSERT INTO `bbgshop_footprint` VALUES (3800, 34, 841662, 1531447520);
INSERT INTO `bbgshop_footprint` VALUES (3801, 34, 841662, 1531447528);
INSERT INTO `bbgshop_footprint` VALUES (3802, 34, 841662, 1531447557);
INSERT INTO `bbgshop_footprint` VALUES (3803, 34, 841662, 1531447593);
INSERT INTO `bbgshop_footprint` VALUES (3804, 34, 841662, 1531447601);
INSERT INTO `bbgshop_footprint` VALUES (3805, 34, 841662, 1531447612);
INSERT INTO `bbgshop_footprint` VALUES (3806, 34, 841662, 1531447626);
INSERT INTO `bbgshop_footprint` VALUES (3807, 34, 841662, 1531447632);
INSERT INTO `bbgshop_footprint` VALUES (3808, 34, 841662, 1531447650);
INSERT INTO `bbgshop_footprint` VALUES (3809, 34, 841662, 1531447669);
INSERT INTO `bbgshop_footprint` VALUES (3810, 34, 841662, 1531447686);
INSERT INTO `bbgshop_footprint` VALUES (3811, 34, 841662, 1531447693);
INSERT INTO `bbgshop_footprint` VALUES (3812, 34, 841662, 1531447709);
INSERT INTO `bbgshop_footprint` VALUES (3813, 34, 841662, 1531447744);
INSERT INTO `bbgshop_footprint` VALUES (3814, 34, 841662, 1531447752);
INSERT INTO `bbgshop_footprint` VALUES (3815, 34, 841662, 1531447847);
INSERT INTO `bbgshop_footprint` VALUES (3816, 34, 841662, 1531447971);
INSERT INTO `bbgshop_footprint` VALUES (3817, 34, 1528855134649776, 1531447983);
INSERT INTO `bbgshop_footprint` VALUES (3818, 34, 841662, 1531447996);
INSERT INTO `bbgshop_footprint` VALUES (3819, 34, 813924, 1531448005);
INSERT INTO `bbgshop_footprint` VALUES (3820, 34, 841662, 1531448007);
INSERT INTO `bbgshop_footprint` VALUES (3821, 34, 841662, 1531448027);
INSERT INTO `bbgshop_footprint` VALUES (3822, 34, 841662, 1531448038);
INSERT INTO `bbgshop_footprint` VALUES (3823, 34, 841662, 1531448056);
INSERT INTO `bbgshop_footprint` VALUES (3824, 34, 841662, 1531448097);
INSERT INTO `bbgshop_footprint` VALUES (3825, 34, 841662, 1531448133);
INSERT INTO `bbgshop_footprint` VALUES (3826, 34, 841662, 1531448164);
INSERT INTO `bbgshop_footprint` VALUES (3827, 34, 841662, 1531448186);
INSERT INTO `bbgshop_footprint` VALUES (3828, 34, 841662, 1531448211);
INSERT INTO `bbgshop_footprint` VALUES (3829, 34, 841662, 1531448219);
INSERT INTO `bbgshop_footprint` VALUES (3830, 34, 841662, 1531448238);
INSERT INTO `bbgshop_footprint` VALUES (3831, 34, 841662, 1531448260);
INSERT INTO `bbgshop_footprint` VALUES (3832, 34, 841662, 1531448269);
INSERT INTO `bbgshop_footprint` VALUES (3833, 34, 841662, 1531448305);
INSERT INTO `bbgshop_footprint` VALUES (3834, 34, 841662, 1531448313);
INSERT INTO `bbgshop_footprint` VALUES (3835, 34, 841662, 1531448321);
INSERT INTO `bbgshop_footprint` VALUES (3836, 34, 841662, 1531448338);
INSERT INTO `bbgshop_footprint` VALUES (3837, 34, 841662, 1531448350);
INSERT INTO `bbgshop_footprint` VALUES (3838, 34, 841662, 1531448361);
INSERT INTO `bbgshop_footprint` VALUES (3839, 34, 841662, 1531448383);
INSERT INTO `bbgshop_footprint` VALUES (3840, 34, 841662, 1531448396);
INSERT INTO `bbgshop_footprint` VALUES (3841, 34, 841662, 1531448417);
INSERT INTO `bbgshop_footprint` VALUES (3842, 34, 841662, 1531448425);
INSERT INTO `bbgshop_footprint` VALUES (3843, 34, 841662, 1531448438);
INSERT INTO `bbgshop_footprint` VALUES (3844, 34, 841662, 1531448445);
INSERT INTO `bbgshop_footprint` VALUES (3845, 34, 841662, 1531448454);
INSERT INTO `bbgshop_footprint` VALUES (3846, 34, 841662, 1531448471);
INSERT INTO `bbgshop_footprint` VALUES (3847, 34, 841662, 1531448553);
INSERT INTO `bbgshop_footprint` VALUES (3848, 34, 841662, 1531448573);
INSERT INTO `bbgshop_footprint` VALUES (3849, 34, 841662, 1531448595);
INSERT INTO `bbgshop_footprint` VALUES (3850, 34, 841662, 1531448604);
INSERT INTO `bbgshop_footprint` VALUES (3851, 34, 841662, 1531448623);
INSERT INTO `bbgshop_footprint` VALUES (3852, 34, 841662, 1531448637);
INSERT INTO `bbgshop_footprint` VALUES (3853, 34, 841662, 1531448658);
INSERT INTO `bbgshop_footprint` VALUES (3854, 34, 841662, 1531448761);
INSERT INTO `bbgshop_footprint` VALUES (3855, 34, 841662, 1531448788);
INSERT INTO `bbgshop_footprint` VALUES (3856, 34, 841662, 1531448841);
INSERT INTO `bbgshop_footprint` VALUES (3857, 34, 841662, 1531448860);
INSERT INTO `bbgshop_footprint` VALUES (3858, 34, 841662, 1531448872);
INSERT INTO `bbgshop_footprint` VALUES (3859, 34, 841662, 1531448880);
INSERT INTO `bbgshop_footprint` VALUES (3860, 34, 841662, 1531448932);
INSERT INTO `bbgshop_footprint` VALUES (3861, 34, 841662, 1531448971);
INSERT INTO `bbgshop_footprint` VALUES (3862, 34, 841662, 1531448976);
INSERT INTO `bbgshop_footprint` VALUES (3863, 34, 841662, 1531449033);
INSERT INTO `bbgshop_footprint` VALUES (3864, 34, 841662, 1531449036);
INSERT INTO `bbgshop_footprint` VALUES (3865, 34, 841662, 1531449060);
INSERT INTO `bbgshop_footprint` VALUES (3866, 34, 841662, 1531449076);
INSERT INTO `bbgshop_footprint` VALUES (3867, 34, 841662, 1531449083);
INSERT INTO `bbgshop_footprint` VALUES (3868, 34, 841662, 1531449106);
INSERT INTO `bbgshop_footprint` VALUES (3869, 34, 841662, 1531449114);
INSERT INTO `bbgshop_footprint` VALUES (3870, 34, 841662, 1531449129);
INSERT INTO `bbgshop_footprint` VALUES (3871, 34, 841662, 1531449184);
INSERT INTO `bbgshop_footprint` VALUES (3872, 34, 841662, 1531449196);
INSERT INTO `bbgshop_footprint` VALUES (3873, 34, 841662, 1531449208);
INSERT INTO `bbgshop_footprint` VALUES (3874, 34, 841662, 1531449220);
INSERT INTO `bbgshop_footprint` VALUES (3875, 34, 841662, 1531449232);
INSERT INTO `bbgshop_footprint` VALUES (3876, 34, 841662, 1531449238);
INSERT INTO `bbgshop_footprint` VALUES (3877, 34, 841662, 1531449266);
INSERT INTO `bbgshop_footprint` VALUES (3878, 34, 841662, 1531449284);
INSERT INTO `bbgshop_footprint` VALUES (3879, 34, 841662, 1531449300);
INSERT INTO `bbgshop_footprint` VALUES (3880, 34, 841662, 1531449310);
INSERT INTO `bbgshop_footprint` VALUES (3881, 34, 841662, 1531449346);
INSERT INTO `bbgshop_footprint` VALUES (3882, 34, 841662, 1531449357);
INSERT INTO `bbgshop_footprint` VALUES (3883, 34, 841662, 1531449367);
INSERT INTO `bbgshop_footprint` VALUES (3884, 34, 841662, 1531449378);
INSERT INTO `bbgshop_footprint` VALUES (3885, 34, 841662, 1531449387);
INSERT INTO `bbgshop_footprint` VALUES (3886, 34, 1528855134649776, 1531449452);
INSERT INTO `bbgshop_footprint` VALUES (3887, 34, 841662, 1531449466);
INSERT INTO `bbgshop_footprint` VALUES (3888, 34, 813924, 1531449483);
INSERT INTO `bbgshop_footprint` VALUES (3889, 34, 477300, 1531449490);
INSERT INTO `bbgshop_footprint` VALUES (3890, 34, 622336, 1531449497);
INSERT INTO `bbgshop_footprint` VALUES (3891, 34, 504504, 1531449502);
INSERT INTO `bbgshop_footprint` VALUES (3892, 34, 1528855134649776, 1531449506);
INSERT INTO `bbgshop_footprint` VALUES (3893, 34, 841662, 1531449642);
INSERT INTO `bbgshop_footprint` VALUES (3894, 34, 841662, 1531449685);
INSERT INTO `bbgshop_footprint` VALUES (3895, 34, 841662, 1531449738);
INSERT INTO `bbgshop_footprint` VALUES (3896, 34, 841662, 1531449753);
INSERT INTO `bbgshop_footprint` VALUES (3897, 34, 841662, 1531449791);
INSERT INTO `bbgshop_footprint` VALUES (3898, 34, 841662, 1531449801);
INSERT INTO `bbgshop_footprint` VALUES (3899, 34, 841662, 1531449888);
INSERT INTO `bbgshop_footprint` VALUES (3900, 34, 841662, 1531449892);
INSERT INTO `bbgshop_footprint` VALUES (3901, 34, 841662, 1531449893);
INSERT INTO `bbgshop_footprint` VALUES (3902, 34, 841662, 1531449907);
INSERT INTO `bbgshop_footprint` VALUES (3903, 34, 841662, 1531449924);
INSERT INTO `bbgshop_footprint` VALUES (3904, 34, 841662, 1531449966);
INSERT INTO `bbgshop_footprint` VALUES (3905, 34, 841662, 1531449983);
INSERT INTO `bbgshop_footprint` VALUES (3906, 34, 841662, 1531449986);
INSERT INTO `bbgshop_footprint` VALUES (3907, 34, 841662, 1531450110);
INSERT INTO `bbgshop_footprint` VALUES (3908, 34, 841662, 1531450142);
INSERT INTO `bbgshop_footprint` VALUES (3909, 34, 841662, 1531450175);
INSERT INTO `bbgshop_footprint` VALUES (3910, 34, 841662, 1531450208);
INSERT INTO `bbgshop_footprint` VALUES (3911, 34, 841662, 1531450329);
INSERT INTO `bbgshop_footprint` VALUES (3912, 34, 841662, 1531450386);
INSERT INTO `bbgshop_footprint` VALUES (3913, 34, 841662, 1531450394);
INSERT INTO `bbgshop_footprint` VALUES (3914, 34, 841662, 1531450418);
INSERT INTO `bbgshop_footprint` VALUES (3915, 34, 841662, 1531450436);
INSERT INTO `bbgshop_footprint` VALUES (3916, 34, 841662, 1531450485);
INSERT INTO `bbgshop_footprint` VALUES (3917, 34, 841662, 1531450522);
INSERT INTO `bbgshop_footprint` VALUES (3918, 34, 841662, 1531450539);
INSERT INTO `bbgshop_footprint` VALUES (3919, 34, 841662, 1531450559);
INSERT INTO `bbgshop_footprint` VALUES (3920, 34, 841662, 1531450620);
INSERT INTO `bbgshop_footprint` VALUES (3921, 34, 841662, 1531450652);
INSERT INTO `bbgshop_footprint` VALUES (3922, 34, 841662, 1531450684);
INSERT INTO `bbgshop_footprint` VALUES (3923, 34, 841662, 1531450690);
INSERT INTO `bbgshop_footprint` VALUES (3924, 34, 841662, 1531450692);
INSERT INTO `bbgshop_footprint` VALUES (3925, 34, 841662, 1531450712);
INSERT INTO `bbgshop_footprint` VALUES (3926, 34, 841662, 1531450786);
INSERT INTO `bbgshop_footprint` VALUES (3927, 34, 841662, 1531450811);
INSERT INTO `bbgshop_footprint` VALUES (3928, 34, 841662, 1531450856);
INSERT INTO `bbgshop_footprint` VALUES (3929, 34, 841662, 1531450893);
INSERT INTO `bbgshop_footprint` VALUES (3930, 34, 841662, 1531450913);
INSERT INTO `bbgshop_footprint` VALUES (3931, 34, 841662, 1531450967);
INSERT INTO `bbgshop_footprint` VALUES (3932, 34, 841662, 1531450976);
INSERT INTO `bbgshop_footprint` VALUES (3933, 34, 841662, 1531450988);
INSERT INTO `bbgshop_footprint` VALUES (3934, 34, 841662, 1531450998);
INSERT INTO `bbgshop_footprint` VALUES (3935, 34, 841662, 1531450999);
INSERT INTO `bbgshop_footprint` VALUES (3936, 34, 841662, 1531451010);
INSERT INTO `bbgshop_footprint` VALUES (3937, 34, 841662, 1531451018);
INSERT INTO `bbgshop_footprint` VALUES (3938, 34, 841662, 1531451027);
INSERT INTO `bbgshop_footprint` VALUES (3939, 34, 841662, 1531451047);
INSERT INTO `bbgshop_footprint` VALUES (3940, 34, 841662, 1531451078);
INSERT INTO `bbgshop_footprint` VALUES (3941, 34, 841662, 1531451112);
INSERT INTO `bbgshop_footprint` VALUES (3942, 34, 841662, 1531451149);
INSERT INTO `bbgshop_footprint` VALUES (3943, 34, 841662, 1531451207);
INSERT INTO `bbgshop_footprint` VALUES (3944, 34, 841662, 1531451240);
INSERT INTO `bbgshop_footprint` VALUES (3945, 34, 841662, 1531451267);
INSERT INTO `bbgshop_footprint` VALUES (3946, 34, 841662, 1531451316);
INSERT INTO `bbgshop_footprint` VALUES (3947, 34, 841662, 1531451382);
INSERT INTO `bbgshop_footprint` VALUES (3948, 34, 841662, 1531451429);
INSERT INTO `bbgshop_footprint` VALUES (3949, 34, 841662, 1531451447);
INSERT INTO `bbgshop_footprint` VALUES (3950, 34, 1528855134649776, 1531451462);
INSERT INTO `bbgshop_footprint` VALUES (3951, 34, 1530752944419263, 1531451500);
INSERT INTO `bbgshop_footprint` VALUES (3952, 34, 1528855134649776, 1531451588);
INSERT INTO `bbgshop_footprint` VALUES (3953, 34, 1530752944419263, 1531451649);
INSERT INTO `bbgshop_footprint` VALUES (3954, 34, 1530752944419263, 1531451660);
INSERT INTO `bbgshop_footprint` VALUES (3955, 34, 1528855134649776, 1531451684);
INSERT INTO `bbgshop_footprint` VALUES (3956, 34, 841662, 1531451692);
INSERT INTO `bbgshop_footprint` VALUES (3957, 34, 1530752944419263, 1531451747);
INSERT INTO `bbgshop_footprint` VALUES (3958, 34, 841662, 1531451767);
INSERT INTO `bbgshop_footprint` VALUES (3959, 34, 1530752944419263, 1531451963);
INSERT INTO `bbgshop_footprint` VALUES (3960, 34, 622336, 1531451985);
INSERT INTO `bbgshop_footprint` VALUES (3961, 34, 1528855134649776, 1531453042);
INSERT INTO `bbgshop_footprint` VALUES (3962, 34, 813924, 1531457487);
INSERT INTO `bbgshop_footprint` VALUES (3963, 34, 813924, 1531457489);
INSERT INTO `bbgshop_footprint` VALUES (3964, 34, 1530752944419263, 1531457501);
INSERT INTO `bbgshop_footprint` VALUES (3965, 34, 841662, 1531457506);
INSERT INTO `bbgshop_footprint` VALUES (3966, 32, 1528855134649776, 1531457544);
INSERT INTO `bbgshop_footprint` VALUES (3967, 34, 841662, 1531457548);
INSERT INTO `bbgshop_footprint` VALUES (3968, 34, 813924, 1531457573);
INSERT INTO `bbgshop_footprint` VALUES (3969, 34, 1528855134649776, 1531459079);
INSERT INTO `bbgshop_footprint` VALUES (3970, 34, 477300, 1531459323);
INSERT INTO `bbgshop_footprint` VALUES (3971, 34, 813924, 1531459957);
INSERT INTO `bbgshop_footprint` VALUES (3972, 34, 1530752944419263, 1531460493);
INSERT INTO `bbgshop_footprint` VALUES (3973, 34, 813924, 1531460628);
INSERT INTO `bbgshop_footprint` VALUES (3974, 34, 841662, 1531460990);
INSERT INTO `bbgshop_footprint` VALUES (3975, 34, 504504, 1531461000);
INSERT INTO `bbgshop_footprint` VALUES (3976, 34, 841662, 1531461010);
INSERT INTO `bbgshop_footprint` VALUES (3977, 34, 813924, 1531461148);
INSERT INTO `bbgshop_footprint` VALUES (3978, 34, 519375, 1531461189);
INSERT INTO `bbgshop_footprint` VALUES (3979, 34, 1530752944419263, 1531461226);
INSERT INTO `bbgshop_footprint` VALUES (3980, 25, 1530752944419263, 1531461232);
INSERT INTO `bbgshop_footprint` VALUES (3981, 34, 813924, 1531461269);
INSERT INTO `bbgshop_footprint` VALUES (3982, 25, 1530752944419263, 1531461287);
INSERT INTO `bbgshop_footprint` VALUES (3983, 25, 1530752944419263, 1531461294);
INSERT INTO `bbgshop_footprint` VALUES (3984, 36, 1530752944419263, 1531461307);
INSERT INTO `bbgshop_footprint` VALUES (3985, 34, 1528855134649776, 1531461505);
INSERT INTO `bbgshop_footprint` VALUES (3986, 34, 1530752944419263, 1531461904);
INSERT INTO `bbgshop_footprint` VALUES (3987, 34, 1528855134649776, 1531461916);
INSERT INTO `bbgshop_footprint` VALUES (3988, 34, 1528855134649776, 1531461918);
INSERT INTO `bbgshop_footprint` VALUES (3989, 34, 1530752944419263, 1531461923);
INSERT INTO `bbgshop_footprint` VALUES (3990, 34, 1528855134649776, 1531461933);
INSERT INTO `bbgshop_footprint` VALUES (3991, 34, 813924, 1531462370);
INSERT INTO `bbgshop_footprint` VALUES (3992, 34, 813924, 1531462502);
INSERT INTO `bbgshop_footprint` VALUES (3993, 34, 477300, 1531462601);
INSERT INTO `bbgshop_footprint` VALUES (3994, 34, 1528855134649776, 1531463342);
INSERT INTO `bbgshop_footprint` VALUES (3995, 34, 841662, 1531463350);
INSERT INTO `bbgshop_footprint` VALUES (3996, 34, 1528855134649776, 1531463704);
INSERT INTO `bbgshop_footprint` VALUES (3997, 34, 1530752944419263, 1531463785);
INSERT INTO `bbgshop_footprint` VALUES (3998, 34, 1530752944419263, 1531463788);
INSERT INTO `bbgshop_footprint` VALUES (3999, 34, 1528855134649776, 1531463805);
INSERT INTO `bbgshop_footprint` VALUES (4000, 34, 1528855134649776, 1531463974);
INSERT INTO `bbgshop_footprint` VALUES (4001, 34, 1530752944419263, 1531463991);
INSERT INTO `bbgshop_footprint` VALUES (4002, 34, 1530752944419263, 1531464218);
INSERT INTO `bbgshop_footprint` VALUES (4003, 34, 813924, 1531464700);
INSERT INTO `bbgshop_footprint` VALUES (4004, 34, 1530752944419263, 1531464803);
INSERT INTO `bbgshop_footprint` VALUES (4005, 34, 841662, 1531464814);
INSERT INTO `bbgshop_footprint` VALUES (4006, 34, 841662, 1531464872);
INSERT INTO `bbgshop_footprint` VALUES (4007, 34, 841662, 1531464917);
INSERT INTO `bbgshop_footprint` VALUES (4008, 34, 841662, 1531464954);
INSERT INTO `bbgshop_footprint` VALUES (4009, 34, 841662, 1531464987);
INSERT INTO `bbgshop_footprint` VALUES (4010, 34, 841662, 1531465023);
INSERT INTO `bbgshop_footprint` VALUES (4011, 34, 841662, 1531465053);
INSERT INTO `bbgshop_footprint` VALUES (4012, 34, 1530752944419263, 1531465081);
INSERT INTO `bbgshop_footprint` VALUES (4013, 34, 841662, 1531465087);
INSERT INTO `bbgshop_footprint` VALUES (4014, 34, 841662, 1531465117);
INSERT INTO `bbgshop_footprint` VALUES (4015, 34, 1530752944419263, 1531465399);
INSERT INTO `bbgshop_footprint` VALUES (4016, 34, 477300, 1531465406);
INSERT INTO `bbgshop_footprint` VALUES (4017, 34, 519375, 1531465882);
INSERT INTO `bbgshop_footprint` VALUES (4018, 34, 90706, 1531465887);
INSERT INTO `bbgshop_footprint` VALUES (4019, 34, 284518, 1531465890);
INSERT INTO `bbgshop_footprint` VALUES (4020, 34, 11154, 1531465892);
INSERT INTO `bbgshop_footprint` VALUES (4021, 34, 519375, 1531465899);
INSERT INTO `bbgshop_footprint` VALUES (4022, 34, 250852, 1531465901);
INSERT INTO `bbgshop_footprint` VALUES (4023, 34, 813924, 1531465904);
INSERT INTO `bbgshop_footprint` VALUES (4024, 34, 841662, 1531465908);
INSERT INTO `bbgshop_footprint` VALUES (4025, 34, 1530752944419263, 1531465935);
INSERT INTO `bbgshop_footprint` VALUES (4026, 34, 1528855134649776, 1531465966);
INSERT INTO `bbgshop_footprint` VALUES (4027, 34, 841662, 1531465972);
INSERT INTO `bbgshop_footprint` VALUES (4028, 32, 1528855134649776, 1531469034);
INSERT INTO `bbgshop_footprint` VALUES (4029, 34, 1530752944419263, 1531469544);
INSERT INTO `bbgshop_footprint` VALUES (4030, 34, 1530752944419263, 1531469811);
INSERT INTO `bbgshop_footprint` VALUES (4031, 34, 813924, 1531470078);
INSERT INTO `bbgshop_footprint` VALUES (4032, 34, 1530752944419263, 1531470126);
INSERT INTO `bbgshop_footprint` VALUES (4033, 34, 1528855134649776, 1531470254);
INSERT INTO `bbgshop_footprint` VALUES (4034, 34, 1530752944419263, 1531470482);
INSERT INTO `bbgshop_footprint` VALUES (4035, 34, 1528855134649776, 1531471602);
INSERT INTO `bbgshop_footprint` VALUES (4036, 34, 1530752944419263, 1531471605);
INSERT INTO `bbgshop_footprint` VALUES (4037, 34, 813924, 1531471654);
INSERT INTO `bbgshop_footprint` VALUES (4038, 34, 841662, 1531471708);
INSERT INTO `bbgshop_footprint` VALUES (4039, 34, 841662, 1531472304);
INSERT INTO `bbgshop_footprint` VALUES (4040, 34, 1530752944419263, 1531472364);
INSERT INTO `bbgshop_footprint` VALUES (4041, 34, 841662, 1531472370);
INSERT INTO `bbgshop_footprint` VALUES (4042, 34, 841662, 1531472553);
INSERT INTO `bbgshop_footprint` VALUES (4043, 34, 841662, 1531472636);
INSERT INTO `bbgshop_footprint` VALUES (4044, 34, 841662, 1531472662);
INSERT INTO `bbgshop_footprint` VALUES (4045, 34, 841662, 1531474376);
INSERT INTO `bbgshop_footprint` VALUES (4046, 34, 1528855134649776, 1531475859);
INSERT INTO `bbgshop_footprint` VALUES (4047, 34, 1530752944419263, 1531475958);
INSERT INTO `bbgshop_footprint` VALUES (4048, 37, 284518, 1531555965);
INSERT INTO `bbgshop_footprint` VALUES (4049, 37, 841662, 1531555983);
INSERT INTO `bbgshop_footprint` VALUES (4050, 37, 477300, 1531556403);
INSERT INTO `bbgshop_footprint` VALUES (4051, 37, 477300, 1531557032);
INSERT INTO `bbgshop_footprint` VALUES (4052, 37, 1530752944419263, 1531557036);
INSERT INTO `bbgshop_footprint` VALUES (4053, 37, 1528855134649776, 1531557038);
INSERT INTO `bbgshop_footprint` VALUES (4054, 37, 841662, 1531557044);
INSERT INTO `bbgshop_footprint` VALUES (4055, 37, 477300, 1531557096);
INSERT INTO `bbgshop_footprint` VALUES (4056, 37, 1530752944419263, 1531558423);
INSERT INTO `bbgshop_footprint` VALUES (4057, 37, 519375, 1531701263);
INSERT INTO `bbgshop_footprint` VALUES (4058, 37, 1530752944419263, 1531702581);
INSERT INTO `bbgshop_footprint` VALUES (4059, 37, 1530752944419263, 1531702949);
INSERT INTO `bbgshop_footprint` VALUES (4060, 37, 1530752944419263, 1531703092);
INSERT INTO `bbgshop_footprint` VALUES (4061, 37, 1528855134649776, 1531703208);
INSERT INTO `bbgshop_footprint` VALUES (4062, 37, 1528855134649776, 1531703799);
INSERT INTO `bbgshop_footprint` VALUES (4063, 37, 1528855134649776, 1531703979);
INSERT INTO `bbgshop_footprint` VALUES (4064, 37, 1528855134649776, 1531704176);
INSERT INTO `bbgshop_footprint` VALUES (4065, 37, 1528855134649776, 1531704195);
INSERT INTO `bbgshop_footprint` VALUES (4066, 37, 1528855134649776, 1531704330);
INSERT INTO `bbgshop_footprint` VALUES (4067, 37, 1528855134649776, 1531704397);
INSERT INTO `bbgshop_footprint` VALUES (4068, 37, 1530752944419263, 1531704418);
INSERT INTO `bbgshop_footprint` VALUES (4069, 37, 1530752944419263, 1531704538);
INSERT INTO `bbgshop_footprint` VALUES (4070, 37, 1528855134649776, 1531704663);
INSERT INTO `bbgshop_footprint` VALUES (4071, 37, 1528855134649776, 1531704790);
INSERT INTO `bbgshop_footprint` VALUES (4072, 37, 813924, 1531704929);
INSERT INTO `bbgshop_footprint` VALUES (4073, 37, 11154, 1531705366);
INSERT INTO `bbgshop_footprint` VALUES (4074, 37, 250852, 1531705458);
INSERT INTO `bbgshop_footprint` VALUES (4075, 37, 1528855134649776, 1531708508);
INSERT INTO `bbgshop_footprint` VALUES (4076, 37, 1530752944419263, 1531708720);
INSERT INTO `bbgshop_footprint` VALUES (4077, 37, 1528855134649776, 1531709191);
INSERT INTO `bbgshop_footprint` VALUES (4078, 34, 813924, 1531710559);
INSERT INTO `bbgshop_footprint` VALUES (4079, 37, 1528855134649776, 1531710696);
INSERT INTO `bbgshop_footprint` VALUES (4080, 32, 813924, 1531711456);
INSERT INTO `bbgshop_footprint` VALUES (4081, 37, 267471, 1531711470);
INSERT INTO `bbgshop_footprint` VALUES (4082, 37, 504504, 1531711655);
INSERT INTO `bbgshop_footprint` VALUES (4083, 37, 813924, 1531712678);
INSERT INTO `bbgshop_footprint` VALUES (4084, 37, 1528855134649776, 1531718612);
INSERT INTO `bbgshop_footprint` VALUES (4085, 32, 93860, 1531804727);
INSERT INTO `bbgshop_footprint` VALUES (4086, 37, 636004, 1531804910);
INSERT INTO `bbgshop_footprint` VALUES (4087, 37, 1528855134649776, 1531805554);
INSERT INTO `bbgshop_footprint` VALUES (4088, 32, 1528855134649776, 1531880949);
INSERT INTO `bbgshop_footprint` VALUES (4089, 37, 1530752944419263, 1531881916);
INSERT INTO `bbgshop_footprint` VALUES (4090, 37, 636004, 1531882567);
INSERT INTO `bbgshop_footprint` VALUES (4091, 37, 1530752944419263, 1531882579);
INSERT INTO `bbgshop_footprint` VALUES (4092, 37, 622336, 1531883638);
INSERT INTO `bbgshop_footprint` VALUES (4093, 37, 1530752944419263, 1531892898);
INSERT INTO `bbgshop_footprint` VALUES (4094, 37, 519375, 1531901012);
INSERT INTO `bbgshop_footprint` VALUES (4095, 37, 477300, 1531903366);
INSERT INTO `bbgshop_footprint` VALUES (4096, 37, 477300, 1531903519);
INSERT INTO `bbgshop_footprint` VALUES (4097, 37, 1528855134649776, 1531979304);
INSERT INTO `bbgshop_footprint` VALUES (4098, 37, 477300, 1531979314);
INSERT INTO `bbgshop_footprint` VALUES (4099, 32, 1530752944419263, 1531982427);
INSERT INTO `bbgshop_footprint` VALUES (4100, 38, 1530752944419263, 1532050068);
INSERT INTO `bbgshop_footprint` VALUES (4101, 38, 1530752944419263, 1532050309);
INSERT INTO `bbgshop_footprint` VALUES (4102, 38, 1530752944419263, 1532050416);
INSERT INTO `bbgshop_footprint` VALUES (4103, 38, 1530752944419263, 1532050465);
INSERT INTO `bbgshop_footprint` VALUES (4104, 38, 1530752944419263, 1532050537);
INSERT INTO `bbgshop_footprint` VALUES (4105, 32, 1530752944419263, 1532066964);
INSERT INTO `bbgshop_footprint` VALUES (4106, 37, 1530752944419263, 1532072481);
INSERT INTO `bbgshop_footprint` VALUES (4107, 37, 1530752944419263, 1532072539);
INSERT INTO `bbgshop_footprint` VALUES (4108, 37, 1530752944419263, 1532072606);
INSERT INTO `bbgshop_footprint` VALUES (4109, 37, 1530752944419263, 1532073133);
INSERT INTO `bbgshop_footprint` VALUES (4110, 37, 1530752944419263, 1532073165);
INSERT INTO `bbgshop_footprint` VALUES (4111, 37, 1530752944419263, 1532073213);
INSERT INTO `bbgshop_footprint` VALUES (4112, 37, 1528855134649776, 1532073498);
INSERT INTO `bbgshop_footprint` VALUES (4113, 37, 1530752944419263, 1532073877);
INSERT INTO `bbgshop_footprint` VALUES (4114, 37, 477300, 1532073883);
INSERT INTO `bbgshop_footprint` VALUES (4115, 37, 1530752944419263, 1532073915);
INSERT INTO `bbgshop_footprint` VALUES (4116, 32, 636004, 1532075540);
INSERT INTO `bbgshop_footprint` VALUES (4117, 32, 622336, 1532075665);
INSERT INTO `bbgshop_footprint` VALUES (4118, 37, 104223, 1532076140);
INSERT INTO `bbgshop_footprint` VALUES (4119, 37, 519375, 1532076514);
INSERT INTO `bbgshop_footprint` VALUES (4120, 37, 1530752944419263, 1532076738);
INSERT INTO `bbgshop_footprint` VALUES (4121, 37, 1530752944419263, 1532076785);
INSERT INTO `bbgshop_footprint` VALUES (4122, 37, 1530752944419263, 1532077612);
INSERT INTO `bbgshop_footprint` VALUES (4123, 37, 1530752944419263, 1532077656);
INSERT INTO `bbgshop_footprint` VALUES (4124, 37, 1530752944419263, 1532077658);
INSERT INTO `bbgshop_footprint` VALUES (4125, 37, 1530752944419263, 1532077743);
INSERT INTO `bbgshop_footprint` VALUES (4126, 37, 1528855134649776, 1532077939);
INSERT INTO `bbgshop_footprint` VALUES (4127, 37, 1530752944419263, 1532078222);
INSERT INTO `bbgshop_footprint` VALUES (4128, 37, 1530752944419263, 1532078223);
INSERT INTO `bbgshop_footprint` VALUES (4129, 37, 1528855134649776, 1532078244);
INSERT INTO `bbgshop_footprint` VALUES (4130, 37, 1528855134649776, 1532078254);
INSERT INTO `bbgshop_footprint` VALUES (4131, 37, 1528855134649776, 1532078255);
INSERT INTO `bbgshop_footprint` VALUES (4132, 37, 1530752944419263, 1532078278);
INSERT INTO `bbgshop_footprint` VALUES (4133, 37, 1528855134649776, 1532078285);
INSERT INTO `bbgshop_footprint` VALUES (4134, 37, 1528855134649776, 1532078286);
INSERT INTO `bbgshop_footprint` VALUES (4135, 37, 1530752944419263, 1532078434);
INSERT INTO `bbgshop_footprint` VALUES (4136, 37, 1528855134649776, 1532078479);
INSERT INTO `bbgshop_footprint` VALUES (4137, 37, 1528855134649776, 1532078536);
INSERT INTO `bbgshop_footprint` VALUES (4138, 37, 1528855134649776, 1532078537);
INSERT INTO `bbgshop_footprint` VALUES (4139, 37, 1530752944419263, 1532078688);
INSERT INTO `bbgshop_footprint` VALUES (4140, 37, 1530752944419263, 1532078726);
INSERT INTO `bbgshop_footprint` VALUES (4141, 37, 1528855134649776, 1532078738);
INSERT INTO `bbgshop_footprint` VALUES (4142, 37, 813924, 1532078748);
INSERT INTO `bbgshop_footprint` VALUES (4143, 37, 813924, 1532078749);
INSERT INTO `bbgshop_footprint` VALUES (4144, 37, 477300, 1532078786);
INSERT INTO `bbgshop_footprint` VALUES (4145, 37, 1528855134649776, 1532078825);
INSERT INTO `bbgshop_footprint` VALUES (4146, 37, 65621, 1532078853);
INSERT INTO `bbgshop_footprint` VALUES (4147, 37, 303863, 1532078868);
INSERT INTO `bbgshop_footprint` VALUES (4148, 37, 519375, 1532078879);
INSERT INTO `bbgshop_footprint` VALUES (4149, 37, 616930, 1532078948);
INSERT INTO `bbgshop_footprint` VALUES (4150, 37, 266000, 1532078954);
INSERT INTO `bbgshop_footprint` VALUES (4151, 37, 1530752944419263, 1532079075);
INSERT INTO `bbgshop_footprint` VALUES (4152, 37, 519375, 1532133001);
INSERT INTO `bbgshop_footprint` VALUES (4153, 37, 813924, 1532136687);
INSERT INTO `bbgshop_footprint` VALUES (4154, 37, 813924, 1532137109);
INSERT INTO `bbgshop_footprint` VALUES (4155, 37, 1530752944419263, 1532325049);
INSERT INTO `bbgshop_footprint` VALUES (4156, 37, 519375, 1532325136);
INSERT INTO `bbgshop_footprint` VALUES (4157, 37, 1530752944419263, 1532325216);
INSERT INTO `bbgshop_footprint` VALUES (4158, 37, 1528855134649776, 1532325220);
INSERT INTO `bbgshop_footprint` VALUES (4159, 37, 813924, 1532326621);
INSERT INTO `bbgshop_footprint` VALUES (4160, 37, 519375, 1532326636);
INSERT INTO `bbgshop_footprint` VALUES (4161, 37, 504504, 1532326640);
INSERT INTO `bbgshop_footprint` VALUES (4162, 37, 1528855134649776, 1532328384);
INSERT INTO `bbgshop_footprint` VALUES (4163, 37, 1530752944419263, 1532328392);
INSERT INTO `bbgshop_footprint` VALUES (4164, 37, 813924, 1532328407);
INSERT INTO `bbgshop_footprint` VALUES (4165, 37, 519375, 1532328418);
INSERT INTO `bbgshop_footprint` VALUES (4166, 37, 1528855134649776, 1532329132);
INSERT INTO `bbgshop_footprint` VALUES (4167, 37, 1530752944419263, 1532329136);
INSERT INTO `bbgshop_footprint` VALUES (4168, 37, 1528855134649776, 1532339557);
INSERT INTO `bbgshop_footprint` VALUES (4169, 37, 1528855134649776, 1532339719);
INSERT INTO `bbgshop_footprint` VALUES (4170, 37, 1530752944419263, 1532339742);
INSERT INTO `bbgshop_footprint` VALUES (4171, 37, 1530752944419263, 1532339755);
INSERT INTO `bbgshop_footprint` VALUES (4172, 37, 813924, 1532340093);
INSERT INTO `bbgshop_footprint` VALUES (4173, 37, 477300, 1532340113);
INSERT INTO `bbgshop_footprint` VALUES (4174, 37, 477300, 1532340165);
INSERT INTO `bbgshop_footprint` VALUES (4175, 37, 813924, 1532340253);
INSERT INTO `bbgshop_footprint` VALUES (4176, 37, 519375, 1532340267);
INSERT INTO `bbgshop_footprint` VALUES (4177, 37, 1530752944419263, 1532340330);
INSERT INTO `bbgshop_footprint` VALUES (4178, 37, 519375, 1532340355);
INSERT INTO `bbgshop_footprint` VALUES (4179, 37, 1528855134649776, 1532340366);
INSERT INTO `bbgshop_footprint` VALUES (4180, 37, 504504, 1532340396);
INSERT INTO `bbgshop_footprint` VALUES (4181, 37, 504504, 1532340469);
INSERT INTO `bbgshop_footprint` VALUES (4182, 37, 1530752944419263, 1532340480);
INSERT INTO `bbgshop_footprint` VALUES (4183, 37, 1528855134649776, 1532340509);
INSERT INTO `bbgshop_footprint` VALUES (4184, 37, 813924, 1532340546);
INSERT INTO `bbgshop_footprint` VALUES (4185, 37, 1528855134649776, 1532340687);
INSERT INTO `bbgshop_footprint` VALUES (4186, 107, 1528855134649776, 1532391657);
INSERT INTO `bbgshop_footprint` VALUES (4187, 37, 519375, 1532402372);
INSERT INTO `bbgshop_footprint` VALUES (4188, 37, 636004, 1532402401);
INSERT INTO `bbgshop_footprint` VALUES (4189, 107, 1530752944419263, 1532407134);
INSERT INTO `bbgshop_footprint` VALUES (4190, 38, 1530752944419263, 1532407190);
INSERT INTO `bbgshop_footprint` VALUES (4191, 38, 1530752944419263, 1532407261);
INSERT INTO `bbgshop_footprint` VALUES (4192, 38, 1530752944419263, 1532407912);
INSERT INTO `bbgshop_footprint` VALUES (4193, 38, 90706, 1532407928);
INSERT INTO `bbgshop_footprint` VALUES (4194, 38, 1528855134649776, 1532407939);
INSERT INTO `bbgshop_footprint` VALUES (4195, 38, 104223, 1532407952);
INSERT INTO `bbgshop_footprint` VALUES (4196, 38, 477300, 1532407978);
INSERT INTO `bbgshop_footprint` VALUES (4197, 38, 477300, 1532407996);
INSERT INTO `bbgshop_footprint` VALUES (4198, 38, 477300, 1532408007);
INSERT INTO `bbgshop_footprint` VALUES (4199, 38, 477300, 1532408022);
INSERT INTO `bbgshop_footprint` VALUES (4200, 38, 813924, 1532408061);
INSERT INTO `bbgshop_footprint` VALUES (4201, 107, 1530752944419263, 1532425601);
INSERT INTO `bbgshop_footprint` VALUES (4202, 38, 477300, 1532425646);
INSERT INTO `bbgshop_footprint` VALUES (4203, 38, 1530752944419263, 1532425666);
INSERT INTO `bbgshop_footprint` VALUES (4204, 38, 1528855134649776, 1532425705);
INSERT INTO `bbgshop_footprint` VALUES (4205, 107, 1530752944419263, 1532425816);
INSERT INTO `bbgshop_footprint` VALUES (4206, 38, 1530752944419263, 1532426699);
INSERT INTO `bbgshop_footprint` VALUES (4207, 107, 1528855134649776, 1532502211);
INSERT INTO `bbgshop_footprint` VALUES (4208, 38, 1530752944419263, 1532502221);
INSERT INTO `bbgshop_footprint` VALUES (4209, 38, 636004, 1532502233);
INSERT INTO `bbgshop_footprint` VALUES (4210, 38, 636004, 1532503324);
INSERT INTO `bbgshop_footprint` VALUES (4211, 38, 636004, 1532503347);
INSERT INTO `bbgshop_footprint` VALUES (4212, 38, 1530752944419263, 1532504423);
INSERT INTO `bbgshop_footprint` VALUES (4213, 38, 1530752944419263, 1532504424);
INSERT INTO `bbgshop_footprint` VALUES (4214, 38, 1528855134649776, 1532504468);
INSERT INTO `bbgshop_footprint` VALUES (4215, 38, 1528855134649776, 1532510692);
INSERT INTO `bbgshop_footprint` VALUES (4216, 38, 1528855134649776, 1532510695);
INSERT INTO `bbgshop_footprint` VALUES (4217, 107, 477300, 1532567463);
INSERT INTO `bbgshop_footprint` VALUES (4218, 38, 1528855134649776, 1532567487);
INSERT INTO `bbgshop_footprint` VALUES (4219, 38, 65621, 1532567502);
INSERT INTO `bbgshop_footprint` VALUES (4220, 38, 1528855134649776, 1532568675);
INSERT INTO `bbgshop_footprint` VALUES (4221, 38, 813924, 1532581628);
INSERT INTO `bbgshop_footprint` VALUES (4222, 38, 1530752944419263, 1532581634);
INSERT INTO `bbgshop_footprint` VALUES (4223, 38, 1530752944419263, 1532583092);
INSERT INTO `bbgshop_footprint` VALUES (4224, 38, 1530752944419263, 1532583098);
INSERT INTO `bbgshop_footprint` VALUES (4225, 38, 636004, 1532583742);
INSERT INTO `bbgshop_footprint` VALUES (4226, 38, 1530752944419263, 1532583747);
INSERT INTO `bbgshop_footprint` VALUES (4227, 38, 813924, 1532583752);
INSERT INTO `bbgshop_footprint` VALUES (4228, 38, 813924, 1532584267);
INSERT INTO `bbgshop_footprint` VALUES (4229, 38, 813924, 1532586044);
INSERT INTO `bbgshop_footprint` VALUES (4230, 38, 636004, 1532586683);
INSERT INTO `bbgshop_footprint` VALUES (4231, 38, 622336, 1532586687);
INSERT INTO `bbgshop_footprint` VALUES (4232, 38, 1530752944419263, 1532586787);
INSERT INTO `bbgshop_footprint` VALUES (4233, 107, 1530752944419263, 1532593083);
INSERT INTO `bbgshop_footprint` VALUES (4234, 38, 477300, 1532593086);
INSERT INTO `bbgshop_footprint` VALUES (4235, 38, 1528855134649776, 1532593219);
INSERT INTO `bbgshop_footprint` VALUES (4236, 38, 813924, 1532593226);
INSERT INTO `bbgshop_footprint` VALUES (4237, 38, 813924, 1532593227);
INSERT INTO `bbgshop_footprint` VALUES (4238, 38, 1530752944419263, 1532593235);
INSERT INTO `bbgshop_footprint` VALUES (4239, 38, 477300, 1532593579);
INSERT INTO `bbgshop_footprint` VALUES (4240, 38, 1528855134649776, 1532593587);
INSERT INTO `bbgshop_footprint` VALUES (4241, 38, 1530752944419263, 1532593595);
INSERT INTO `bbgshop_footprint` VALUES (4242, 38, 1530752944419263, 1532593596);
INSERT INTO `bbgshop_footprint` VALUES (4243, 38, 1530752944419263, 1532593785);
INSERT INTO `bbgshop_footprint` VALUES (4244, 38, 1528855134649776, 1532594331);
INSERT INTO `bbgshop_footprint` VALUES (4245, 38, 1528855134649776, 1532594369);
INSERT INTO `bbgshop_footprint` VALUES (4246, 38, 1528855134649776, 1532594370);
INSERT INTO `bbgshop_footprint` VALUES (4247, 38, 813924, 1532594377);
INSERT INTO `bbgshop_footprint` VALUES (4248, 38, 1528855134649776, 1532594585);
INSERT INTO `bbgshop_footprint` VALUES (4249, 38, 813924, 1532594637);
INSERT INTO `bbgshop_footprint` VALUES (4250, 38, 1530752944419263, 1532595387);
INSERT INTO `bbgshop_footprint` VALUES (4251, 38, 636004, 1532651443);
INSERT INTO `bbgshop_footprint` VALUES (4252, 38, 477300, 1532653388);
INSERT INTO `bbgshop_footprint` VALUES (4253, 38, 813924, 1532653484);
INSERT INTO `bbgshop_footprint` VALUES (4254, 38, 1530752944419263, 1532655774);
INSERT INTO `bbgshop_footprint` VALUES (4255, 38, 1530752944419263, 1532655843);
INSERT INTO `bbgshop_footprint` VALUES (4256, 38, 1530752944419263, 1532655940);
INSERT INTO `bbgshop_footprint` VALUES (4257, 38, 1530752944419263, 1532655982);
INSERT INTO `bbgshop_footprint` VALUES (4258, 38, 477300, 1532656015);
INSERT INTO `bbgshop_footprint` VALUES (4259, 38, 1530752944419263, 1532656353);
INSERT INTO `bbgshop_footprint` VALUES (4260, 38, 1530752944419263, 1532656455);
INSERT INTO `bbgshop_footprint` VALUES (4261, 107, 1530752944419263, 1532671048);
INSERT INTO `bbgshop_footprint` VALUES (4262, 38, 477300, 1532684259);
INSERT INTO `bbgshop_footprint` VALUES (4263, 38, 636004, 1532739354);
INSERT INTO `bbgshop_footprint` VALUES (4264, 38, 1530752944419263, 1532739770);
INSERT INTO `bbgshop_footprint` VALUES (4265, 107, 1528855134649776, 1532740230);
INSERT INTO `bbgshop_footprint` VALUES (4266, 38, 477300, 1532740234);
INSERT INTO `bbgshop_footprint` VALUES (4267, 38, 1530752944419263, 1532740614);
INSERT INTO `bbgshop_footprint` VALUES (4268, 38, 1530752944419263, 1532740647);
INSERT INTO `bbgshop_footprint` VALUES (4269, 107, 113262, 1532748917);
INSERT INTO `bbgshop_footprint` VALUES (4270, 38, 244590, 1532754531);
INSERT INTO `bbgshop_footprint` VALUES (4271, 107, 477300, 1532755328);
INSERT INTO `bbgshop_footprint` VALUES (4272, 38, 65621, 1532755331);
INSERT INTO `bbgshop_footprint` VALUES (4273, 38, 91574, 1532755336);
INSERT INTO `bbgshop_footprint` VALUES (4274, 38, 267471, 1532755340);
INSERT INTO `bbgshop_footprint` VALUES (4275, 38, 636004, 1532767046);
INSERT INTO `bbgshop_footprint` VALUES (4276, 107, 11154, 1532767303);
INSERT INTO `bbgshop_footprint` VALUES (4277, 38, 65621, 1532767401);
INSERT INTO `bbgshop_footprint` VALUES (4278, 38, 1530752944419263, 1532767695);
INSERT INTO `bbgshop_footprint` VALUES (4279, 38, 1530752944419263, 1532769006);
INSERT INTO `bbgshop_footprint` VALUES (4280, 38, 636004, 1532769010);
INSERT INTO `bbgshop_footprint` VALUES (4281, 38, 636004, 1532769448);
INSERT INTO `bbgshop_footprint` VALUES (4282, 38, 636004, 1532769457);
INSERT INTO `bbgshop_footprint` VALUES (4283, 38, 1530752944419263, 1532769539);
INSERT INTO `bbgshop_footprint` VALUES (4284, 38, 636004, 1532769565);
INSERT INTO `bbgshop_footprint` VALUES (4285, 38, 636004, 1532769789);
INSERT INTO `bbgshop_footprint` VALUES (4286, 107, 65621, 1532910615);
INSERT INTO `bbgshop_footprint` VALUES (4287, 38, 636004, 1532911429);
INSERT INTO `bbgshop_footprint` VALUES (4288, 38, 103275, 1532911506);
INSERT INTO `bbgshop_footprint` VALUES (4289, 38, 813924, 1532911756);
INSERT INTO `bbgshop_footprint` VALUES (4290, 38, 45045, 1532919630);
INSERT INTO `bbgshop_footprint` VALUES (4291, 38, 519375, 1532921600);
INSERT INTO `bbgshop_footprint` VALUES (4292, 38, 504504, 1532921607);
INSERT INTO `bbgshop_footprint` VALUES (4293, 38, 86982, 1532926224);
INSERT INTO `bbgshop_footprint` VALUES (4294, 38, 1530752944419263, 1532926819);
INSERT INTO `bbgshop_footprint` VALUES (4295, 107, 1530752944419263, 1532935184);
INSERT INTO `bbgshop_footprint` VALUES (4296, 38, 15800, 1532938211);
INSERT INTO `bbgshop_footprint` VALUES (4297, 38, 636004, 1532941676);
INSERT INTO `bbgshop_footprint` VALUES (4298, 107, 477300, 1533023248);
INSERT INTO `bbgshop_footprint` VALUES (4299, 38, 477300, 1533023249);
INSERT INTO `bbgshop_footprint` VALUES (4300, 38, 1530752944419263, 1533089148);
INSERT INTO `bbgshop_footprint` VALUES (4301, 38, 1528855134649776, 1533089162);
INSERT INTO `bbgshop_footprint` VALUES (4302, 38, 813924, 1533089173);
INSERT INTO `bbgshop_footprint` VALUES (4303, 38, 65621, 1533090499);
INSERT INTO `bbgshop_footprint` VALUES (4304, 38, 65621, 1533090571);
INSERT INTO `bbgshop_footprint` VALUES (4305, 38, 1530752944419263, 1533107518);
INSERT INTO `bbgshop_footprint` VALUES (4306, 38, 1528855134649776, 1533107525);
INSERT INTO `bbgshop_footprint` VALUES (4307, 38, 1530752944419263, 1533107536);
INSERT INTO `bbgshop_footprint` VALUES (4308, 38, 1530752944419263, 1533107624);
INSERT INTO `bbgshop_footprint` VALUES (4309, 38, 1530752944419263, 1533107625);
INSERT INTO `bbgshop_footprint` VALUES (4310, 38, 1530752944419263, 1533107677);
INSERT INTO `bbgshop_footprint` VALUES (4311, 38, 477300, 1533116509);
INSERT INTO `bbgshop_footprint` VALUES (4312, 38, 477300, 1533116591);
INSERT INTO `bbgshop_footprint` VALUES (4313, 38, 813924, 1533116863);
INSERT INTO `bbgshop_footprint` VALUES (4314, 38, 477300, 1533169442);
INSERT INTO `bbgshop_footprint` VALUES (4315, 38, 477300, 1533169482);
INSERT INTO `bbgshop_footprint` VALUES (4316, 38, 477300, 1533169816);
INSERT INTO `bbgshop_footprint` VALUES (4317, 38, 477300, 1533171776);
INSERT INTO `bbgshop_footprint` VALUES (4318, 38, 477300, 1533172257);
INSERT INTO `bbgshop_footprint` VALUES (4319, 38, 477300, 1533172345);
INSERT INTO `bbgshop_footprint` VALUES (4320, 38, 1530752944419263, 1533172359);
INSERT INTO `bbgshop_footprint` VALUES (4321, 38, 813924, 1533172368);
INSERT INTO `bbgshop_footprint` VALUES (4322, 38, 813924, 1533172975);
INSERT INTO `bbgshop_footprint` VALUES (4323, 38, 477300, 1533174558);
INSERT INTO `bbgshop_footprint` VALUES (4324, 39, 1530752944419263, 1533199958);
INSERT INTO `bbgshop_footprint` VALUES (4325, 39, 477300, 1533260836);
INSERT INTO `bbgshop_footprint` VALUES (4326, 39, 1530752944419263, 1533260839);
INSERT INTO `bbgshop_footprint` VALUES (4327, 39, 1528855134649776, 1533261541);
INSERT INTO `bbgshop_footprint` VALUES (4328, 39, 1530752944419263, 1533261918);
INSERT INTO `bbgshop_footprint` VALUES (4329, 39, 1528855134649776, 1533261921);
INSERT INTO `bbgshop_footprint` VALUES (4330, 39, 813924, 1533261923);
INSERT INTO `bbgshop_footprint` VALUES (4331, 39, 477300, 1533274606);
INSERT INTO `bbgshop_footprint` VALUES (4332, 39, 1530752944419263, 1533274608);
INSERT INTO `bbgshop_footprint` VALUES (4333, 39, 813924, 1533274618);
INSERT INTO `bbgshop_footprint` VALUES (4334, 39, 813924, 1533274620);
INSERT INTO `bbgshop_footprint` VALUES (4335, 39, 1528855134649776, 1533274847);
INSERT INTO `bbgshop_footprint` VALUES (4336, 39, 813924, 1533274851);
INSERT INTO `bbgshop_footprint` VALUES (4337, 39, 1530752944419263, 1533274859);
INSERT INTO `bbgshop_footprint` VALUES (4338, 39, 1530752944419263, 1533274860);
INSERT INTO `bbgshop_footprint` VALUES (4339, 40, 1530752944419263, 1533345539);
INSERT INTO `bbgshop_footprint` VALUES (4340, 40, 477300, 1533345824);
INSERT INTO `bbgshop_footprint` VALUES (4341, 40, 477300, 1533345825);
INSERT INTO `bbgshop_footprint` VALUES (4342, 40, 1530752944419263, 1533345842);
INSERT INTO `bbgshop_footprint` VALUES (4343, 40, 477300, 1533348351);
INSERT INTO `bbgshop_footprint` VALUES (4344, 40, 477300, 1533348405);
INSERT INTO `bbgshop_footprint` VALUES (4345, 40, 477300, 1533348431);
INSERT INTO `bbgshop_footprint` VALUES (4346, 40, 477300, 1533348519);
INSERT INTO `bbgshop_footprint` VALUES (4347, 40, 477300, 1533348534);
INSERT INTO `bbgshop_footprint` VALUES (4348, 40, 477300, 1533348568);
INSERT INTO `bbgshop_footprint` VALUES (4349, 40, 477300, 1533348608);
INSERT INTO `bbgshop_footprint` VALUES (4350, 40, 477300, 1533348810);
INSERT INTO `bbgshop_footprint` VALUES (4351, 40, 1530752944419263, 1533348892);
INSERT INTO `bbgshop_footprint` VALUES (4352, 40, 477300, 1533348952);
INSERT INTO `bbgshop_footprint` VALUES (4353, 40, 477300, 1533349091);
INSERT INTO `bbgshop_footprint` VALUES (4354, 40, 1530752944419263, 1533349284);
INSERT INTO `bbgshop_footprint` VALUES (4355, 40, 477300, 1533349469);
INSERT INTO `bbgshop_footprint` VALUES (4356, 40, 1530752944419263, 1533349486);
INSERT INTO `bbgshop_footprint` VALUES (4357, 40, 477300, 1533353035);
INSERT INTO `bbgshop_footprint` VALUES (4358, 40, 477300, 1533359552);
INSERT INTO `bbgshop_footprint` VALUES (4359, 40, 813924, 1533359555);
INSERT INTO `bbgshop_footprint` VALUES (4360, 40, 477300, 1533368869);
INSERT INTO `bbgshop_footprint` VALUES (4361, 173, 1530752944419263, 1533373077);
INSERT INTO `bbgshop_footprint` VALUES (4362, 40, 1528855134649776, 1533373302);
INSERT INTO `bbgshop_footprint` VALUES (4363, 32, 636004, 1533534008);
INSERT INTO `bbgshop_footprint` VALUES (4364, 41, 477300, 1533534219);
INSERT INTO `bbgshop_footprint` VALUES (4365, 40, 1528855134649776, 1533548465);
INSERT INTO `bbgshop_footprint` VALUES (4366, 40, 1530752944419263, 1533548481);
INSERT INTO `bbgshop_footprint` VALUES (4367, 40, 1530752944419263, 1533548520);
INSERT INTO `bbgshop_footprint` VALUES (4368, 40, 1530752944419263, 1533548533);
INSERT INTO `bbgshop_footprint` VALUES (4369, 40, 65621, 1533548538);
INSERT INTO `bbgshop_footprint` VALUES (4370, 40, 1530752944419263, 1533548742);
INSERT INTO `bbgshop_footprint` VALUES (4371, 40, 813924, 1533602201);
INSERT INTO `bbgshop_footprint` VALUES (4372, 40, 1528855134649776, 1533602213);
INSERT INTO `bbgshop_footprint` VALUES (4373, 40, 477300, 1533602222);
INSERT INTO `bbgshop_footprint` VALUES (4374, 40, 1530752944419263, 1533603669);
INSERT INTO `bbgshop_footprint` VALUES (4375, 40, 1530752944419263, 1533603792);
INSERT INTO `bbgshop_footprint` VALUES (4376, 40, 1530752944419263, 1533603794);
INSERT INTO `bbgshop_footprint` VALUES (4377, 40, 813924, 1533604339);
INSERT INTO `bbgshop_footprint` VALUES (4378, 40, 65621, 1533604351);
INSERT INTO `bbgshop_footprint` VALUES (4379, 40, 1530752944419263, 1533606923);
INSERT INTO `bbgshop_footprint` VALUES (4380, 40, 477300, 1533607670);
INSERT INTO `bbgshop_footprint` VALUES (4381, 40, 1530752944419263, 1533609029);
INSERT INTO `bbgshop_footprint` VALUES (4382, 40, 1528855134649776, 1533720693);
INSERT INTO `bbgshop_footprint` VALUES (4383, 175, 1528855134649776, 1533720826);
INSERT INTO `bbgshop_footprint` VALUES (4384, 40, 1530752944419263, 1533720839);
INSERT INTO `bbgshop_footprint` VALUES (4385, 40, 1530752944419263, 1533720859);
INSERT INTO `bbgshop_footprint` VALUES (4386, 40, 1530752944419263, 1533774920);
INSERT INTO `bbgshop_footprint` VALUES (4387, 40, 19845, 1533774959);
INSERT INTO `bbgshop_footprint` VALUES (4388, 40, 65621, 1533774984);
INSERT INTO `bbgshop_footprint` VALUES (4389, 40, 477300, 1533885512);
INSERT INTO `bbgshop_footprint` VALUES (4390, 175, 477300, 1533952118);
INSERT INTO `bbgshop_footprint` VALUES (4391, 42, 1530752944419263, 1533952120);
INSERT INTO `bbgshop_footprint` VALUES (4392, 42, 1530752944419263, 1533953291);
INSERT INTO `bbgshop_footprint` VALUES (4393, 42, 813924, 1533955042);
INSERT INTO `bbgshop_footprint` VALUES (4394, 42, 1530752944419263, 1533956080);
INSERT INTO `bbgshop_footprint` VALUES (4395, 42, 1530752944419263, 1533956139);
INSERT INTO `bbgshop_footprint` VALUES (4396, 42, 1530752944419263, 1533956140);
INSERT INTO `bbgshop_footprint` VALUES (4397, 42, 1530752944419263, 1533956234);
INSERT INTO `bbgshop_footprint` VALUES (4398, 42, 1530752944419263, 1533956281);
INSERT INTO `bbgshop_footprint` VALUES (4399, 42, 1530752944419263, 1533956661);
INSERT INTO `bbgshop_footprint` VALUES (4400, 42, 1530752944419263, 1533957206);
INSERT INTO `bbgshop_footprint` VALUES (4401, 42, 1530752944419263, 1533957497);
INSERT INTO `bbgshop_footprint` VALUES (4402, 42, 1530752944419263, 1533957585);
INSERT INTO `bbgshop_footprint` VALUES (4403, 42, 1528855134649776, 1533957606);
INSERT INTO `bbgshop_footprint` VALUES (4404, 42, 1528855134649776, 1533957648);
INSERT INTO `bbgshop_footprint` VALUES (4405, 42, 1528855134649776, 1533957658);
INSERT INTO `bbgshop_footprint` VALUES (4406, 42, 519375, 1533957720);
INSERT INTO `bbgshop_footprint` VALUES (4407, 42, 813924, 1533957931);
INSERT INTO `bbgshop_footprint` VALUES (4408, 42, 636004, 1533958031);
INSERT INTO `bbgshop_footprint` VALUES (4409, 42, 813924, 1533958491);
INSERT INTO `bbgshop_footprint` VALUES (4410, 42, 65621, 1533958514);
INSERT INTO `bbgshop_footprint` VALUES (4411, 42, 65621, 1533958515);
INSERT INTO `bbgshop_footprint` VALUES (4412, 42, 519375, 1533958564);
INSERT INTO `bbgshop_footprint` VALUES (4413, 42, 1530752944419263, 1533962440);
INSERT INTO `bbgshop_footprint` VALUES (4414, 42, 477300, 1533962964);
INSERT INTO `bbgshop_footprint` VALUES (4415, 42, 1528855134649776, 1533962978);
INSERT INTO `bbgshop_footprint` VALUES (4416, 42, 109248, 1533963059);
INSERT INTO `bbgshop_footprint` VALUES (4417, 42, 813924, 1533963334);
INSERT INTO `bbgshop_footprint` VALUES (4418, 42, 1530752944419263, 1533977973);
INSERT INTO `bbgshop_footprint` VALUES (4419, 42, 813924, 1534137155);
INSERT INTO `bbgshop_footprint` VALUES (4420, 42, 477300, 1534137217);
INSERT INTO `bbgshop_footprint` VALUES (4421, 42, 1530752944419263, 1534137766);
INSERT INTO `bbgshop_footprint` VALUES (4422, 42, 813924, 1534137906);
INSERT INTO `bbgshop_footprint` VALUES (4423, 42, 636004, 1534138025);
INSERT INTO `bbgshop_footprint` VALUES (4424, 42, 104223, 1534138081);
INSERT INTO `bbgshop_footprint` VALUES (4425, 42, 622336, 1534138103);
INSERT INTO `bbgshop_footprint` VALUES (4426, 42, 1528855134649776, 1534140347);
INSERT INTO `bbgshop_footprint` VALUES (4427, 42, 1528855134649776, 1534140935);
INSERT INTO `bbgshop_footprint` VALUES (4428, 42, 1530752944419263, 1534141090);
INSERT INTO `bbgshop_footprint` VALUES (4429, 42, 1530752944419263, 1534141168);
INSERT INTO `bbgshop_footprint` VALUES (4430, 42, 1530752944419263, 1534141690);
INSERT INTO `bbgshop_footprint` VALUES (4431, 42, 1530752944419263, 1534141720);
INSERT INTO `bbgshop_footprint` VALUES (4432, 42, 1530752944419263, 1534141801);
INSERT INTO `bbgshop_footprint` VALUES (4433, 42, 1530752944419263, 1534208663);
INSERT INTO `bbgshop_footprint` VALUES (4434, 42, 1530752944419263, 1534208732);
INSERT INTO `bbgshop_footprint` VALUES (4435, 42, 813924, 1534208741);
INSERT INTO `bbgshop_footprint` VALUES (4436, 42, 1530752944419263, 1534212097);
INSERT INTO `bbgshop_footprint` VALUES (4437, 175, 477300, 1534296232);
INSERT INTO `bbgshop_footprint` VALUES (4438, 42, 477300, 1534296268);
INSERT INTO `bbgshop_footprint` VALUES (4439, 42, 1530752944419263, 1534296278);
INSERT INTO `bbgshop_footprint` VALUES (4440, 42, 477300, 1534296331);
INSERT INTO `bbgshop_footprint` VALUES (4441, 42, 1530752944419263, 1534296339);
INSERT INTO `bbgshop_footprint` VALUES (4442, 42, 477300, 1534296353);
INSERT INTO `bbgshop_footprint` VALUES (4443, 42, 1528855134649776, 1534296484);
INSERT INTO `bbgshop_footprint` VALUES (4444, 42, 477300, 1534296854);
INSERT INTO `bbgshop_footprint` VALUES (4445, 42, 813924, 1534296875);
INSERT INTO `bbgshop_footprint` VALUES (4446, 42, 1528855134649776, 1534300576);
INSERT INTO `bbgshop_footprint` VALUES (4447, 42, 1530752944419263, 1534308034);
INSERT INTO `bbgshop_footprint` VALUES (4448, 42, 1530752944419263, 1534308067);
INSERT INTO `bbgshop_footprint` VALUES (4449, 42, 1530752944419263, 1534308190);
INSERT INTO `bbgshop_footprint` VALUES (4450, 42, 813924, 1534308714);
INSERT INTO `bbgshop_footprint` VALUES (4451, 42, 1530752944419263, 1534308743);
INSERT INTO `bbgshop_footprint` VALUES (4452, 42, 477300, 1534309589);
INSERT INTO `bbgshop_footprint` VALUES (4453, 175, 477300, 1534311708);
INSERT INTO `bbgshop_footprint` VALUES (4454, 175, 1530752944419263, 1534315073);
INSERT INTO `bbgshop_footprint` VALUES (4455, 42, 1530752944419263, 1534382645);
INSERT INTO `bbgshop_footprint` VALUES (4456, 42, 477300, 1534382662);
INSERT INTO `bbgshop_footprint` VALUES (4457, 42, 1530752944419263, 1534382927);
INSERT INTO `bbgshop_footprint` VALUES (4458, 42, 1530752944419263, 1534382937);
INSERT INTO `bbgshop_footprint` VALUES (4459, 42, 1530752944419263, 1534383147);
INSERT INTO `bbgshop_footprint` VALUES (4460, 42, 1530752944419263, 1534383784);
INSERT INTO `bbgshop_footprint` VALUES (4461, 42, 1530752944419263, 1534386008);
INSERT INTO `bbgshop_footprint` VALUES (4462, 42, 1528855134649776, 1534387679);
INSERT INTO `bbgshop_footprint` VALUES (4463, 42, 1530752944419263, 1534390140);
INSERT INTO `bbgshop_footprint` VALUES (4464, 42, 1530752944419263, 1534403875);
INSERT INTO `bbgshop_footprint` VALUES (4465, 42, 519375, 1534403917);
INSERT INTO `bbgshop_footprint` VALUES (4466, 42, 519375, 1534404176);
INSERT INTO `bbgshop_footprint` VALUES (4467, 175, 519375, 1534405950);
INSERT INTO `bbgshop_footprint` VALUES (4468, 42, 519375, 1534405998);
INSERT INTO `bbgshop_footprint` VALUES (4469, 42, 519375, 1534406195);
INSERT INTO `bbgshop_footprint` VALUES (4470, 42, 519375, 1534406208);
INSERT INTO `bbgshop_footprint` VALUES (4471, 175, 1534408060096423, 1534408085);
INSERT INTO `bbgshop_footprint` VALUES (4472, 175, 477300, 1534408917);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_freight_template_auxiliary
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_freight_template_auxiliary`;
CREATE TABLE `bbgshop_freight_template_auxiliary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temp_main_id` int(11) NOT NULL,
  `temp_point_city_id` varchar(1024) NOT NULL,
  `temp_point_city_name` varchar(1024) NOT NULL,
  `temp_point_city_JSONstr` varchar(4096) NOT NULL,
  `temp_first_weight` int(5) NOT NULL DEFAULT '1',
  `temp_first_freight` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '首重',
  `temp_continue_weight` int(5) NOT NULL DEFAULT '1' COMMENT '续件',
  `temp_continue_freight` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '续重(一件)',
  `create_time` varchar(32) NOT NULL DEFAULT '0',
  `handel_time` varchar(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_freight_template_auxiliary
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_freight_template_auxiliary` VALUES (39, 12, '11,10,12', ',江苏省,上海,浙江省', '[{\"id\":11,\"parent_id\":1,\"name\":\"江苏省\",\"type\":1,\"agency_id\":0},{\"id\":10,\"parent_id\":1,\"name\":\"上海\",\"type\":1,\"agency_id\":0},{\"id\":12,\"parent_id\":1,\"name\":\"浙江省\",\"type\":1,\"agency_id\":0}]', 1, 1.00, 1, 2.00, '1532593153527', '0');
INSERT INTO `bbgshop_freight_template_auxiliary` VALUES (40, 12, '2,3,4,5,6,7,8,9,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36', ',北京,天津,河北省,山西省,内蒙古自治区,辽宁省,吉林省,黑龙江省,安徽省,福建省,江西省,山东省,河南省,湖北省,湖南省,广东省,广西壮族自治区,海南省,重庆,四川省,贵州省,云南省,西藏自治区,陕西省,甘肃省,青海省,宁夏回族自治区,新疆维吾尔自治区,台湾,香港特别行政区,澳门特别行政区,海外', '[{\"id\":2,\"parent_id\":1,\"name\":\"北京\",\"type\":1,\"agency_id\":0},{\"id\":3,\"parent_id\":1,\"name\":\"天津\",\"type\":1,\"agency_id\":0},{\"id\":4,\"parent_id\":1,\"name\":\"河北省\",\"type\":1,\"agency_id\":0},{\"id\":5,\"parent_id\":1,\"name\":\"山西省\",\"type\":1,\"agency_id\":0},{\"id\":6,\"parent_id\":1,\"name\":\"内蒙古自治区\",\"type\":1,\"agency_id\":0},{\"id\":7,\"parent_id\":1,\"name\":\"辽宁省\",\"type\":1,\"agency_id\":0},{\"id\":8,\"parent_id\":1,\"name\":\"吉林省\",\"type\":1,\"agency_id\":0},{\"id\":9,\"parent_id\":1,\"name\":\"黑龙江省\",\"type\":1,\"agency_id\":0},{\"id\":13,\"parent_id\":1,\"name\":\"安徽省\",\"type\":1,\"agency_id\":0},{\"id\":14,\"parent_id\":1,\"name\":\"福建省\",\"type\":1,\"agency_id\":0},{\"id\":15,\"parent_id\":1,\"name\":\"江西省\",\"type\":1,\"agency_id\":0},{\"id\":16,\"parent_id\":1,\"name\":\"山东省\",\"type\":1,\"agency_id\":0},{\"id\":17,\"parent_id\":1,\"name\":\"河南省\",\"type\":1,\"agency_id\":0},{\"id\":18,\"parent_id\":1,\"name\":\"湖北省\",\"type\":1,\"agency_id\":0},{\"id\":19,\"parent_id\":1,\"name\":\"湖南省\",\"type\":1,\"agency_id\":0},{\"id\":20,\"parent_id\":1,\"name\":\"广东省\",\"type\":1,\"agency_id\":0},{\"id\":21,\"parent_id\":1,\"name\":\"广西壮族自治区\",\"type\":1,\"agency_id\":0},{\"id\":22,\"parent_id\":1,\"name\":\"海南省\",\"type\":1,\"agency_id\":0},{\"id\":23,\"parent_id\":1,\"name\":\"重庆\",\"type\":1,\"agency_id\":0},{\"id\":24,\"parent_id\":1,\"name\":\"四川省\",\"type\":1,\"agency_id\":0},{\"id\":25,\"parent_id\":1,\"name\":\"贵州省\",\"type\":1,\"agency_id\":0},{\"id\":26,\"parent_id\":1,\"name\":\"云南省\",\"type\":1,\"agency_id\":0},{\"id\":27,\"parent_id\":1,\"name\":\"西藏自治区\",\"type\":1,\"agency_id\":0},{\"id\":28,\"parent_id\":1,\"name\":\"陕西省\",\"type\":1,\"agency_id\":0},{\"id\":29,\"parent_id\":1,\"name\":\"甘肃省\",\"type\":1,\"agency_id\":0},{\"id\":30,\"parent_id\":1,\"name\":\"青海省\",\"type\":1,\"agency_id\":0},{\"id\":31,\"parent_id\":1,\"name\":\"宁夏回族自治区\",\"type\":1,\"agency_id\":0},{\"id\":32,\"parent_id\":1,\"name\":\"新疆维吾尔自治区\",\"type\":1,\"agency_id\":0},{\"id\":33,\"parent_id\":1,\"name\":\"台湾\",\"type\":1,\"agency_id\":0},{\"id\":34,\"parent_id\":1,\"name\":\"香港特别行政区\",\"type\":1,\"agency_id\":0},{\"id\":35,\"parent_id\":1,\"name\":\"澳门特别行政区\",\"type\":1,\"agency_id\":0},{\"id\":36,\"parent_id\":1,\"name\":\"海外\",\"type\":1,\"agency_id\":0}]', 1, 6.00, 1, 10.00, '1532593153553', '0');
INSERT INTO `bbgshop_freight_template_auxiliary` VALUES (41, 13, '2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36', ',北京,天津,河北省,山西省,内蒙古自治区,辽宁省,吉林省,黑龙江省,上海,江苏省,浙江省,安徽省,福建省,江西省,山东省,河南省,湖北省,湖南省,广东省,广西壮族自治区,海南省,重庆,四川省,贵州省,云南省,西藏自治区,陕西省,甘肃省,青海省,宁夏回族自治区,新疆维吾尔自治区,台湾,香港特别行政区,澳门特别行政区,海外', '[{\"id\":2,\"parent_id\":1,\"name\":\"北京\",\"type\":1,\"agency_id\":0},{\"id\":3,\"parent_id\":1,\"name\":\"天津\",\"type\":1,\"agency_id\":0},{\"id\":4,\"parent_id\":1,\"name\":\"河北省\",\"type\":1,\"agency_id\":0},{\"id\":5,\"parent_id\":1,\"name\":\"山西省\",\"type\":1,\"agency_id\":0},{\"id\":6,\"parent_id\":1,\"name\":\"内蒙古自治区\",\"type\":1,\"agency_id\":0},{\"id\":7,\"parent_id\":1,\"name\":\"辽宁省\",\"type\":1,\"agency_id\":0},{\"id\":8,\"parent_id\":1,\"name\":\"吉林省\",\"type\":1,\"agency_id\":0},{\"id\":9,\"parent_id\":1,\"name\":\"黑龙江省\",\"type\":1,\"agency_id\":0},{\"id\":10,\"parent_id\":1,\"name\":\"上海\",\"type\":1,\"agency_id\":0},{\"id\":11,\"parent_id\":1,\"name\":\"江苏省\",\"type\":1,\"agency_id\":0},{\"id\":12,\"parent_id\":1,\"name\":\"浙江省\",\"type\":1,\"agency_id\":0},{\"id\":13,\"parent_id\":1,\"name\":\"安徽省\",\"type\":1,\"agency_id\":0},{\"id\":14,\"parent_id\":1,\"name\":\"福建省\",\"type\":1,\"agency_id\":0},{\"id\":15,\"parent_id\":1,\"name\":\"江西省\",\"type\":1,\"agency_id\":0},{\"id\":16,\"parent_id\":1,\"name\":\"山东省\",\"type\":1,\"agency_id\":0},{\"id\":17,\"parent_id\":1,\"name\":\"河南省\",\"type\":1,\"agency_id\":0},{\"id\":18,\"parent_id\":1,\"name\":\"湖北省\",\"type\":1,\"agency_id\":0},{\"id\":19,\"parent_id\":1,\"name\":\"湖南省\",\"type\":1,\"agency_id\":0},{\"id\":20,\"parent_id\":1,\"name\":\"广东省\",\"type\":1,\"agency_id\":0},{\"id\":21,\"parent_id\":1,\"name\":\"广西壮族自治区\",\"type\":1,\"agency_id\":0},{\"id\":22,\"parent_id\":1,\"name\":\"海南省\",\"type\":1,\"agency_id\":0},{\"id\":23,\"parent_id\":1,\"name\":\"重庆\",\"type\":1,\"agency_id\":0},{\"id\":24,\"parent_id\":1,\"name\":\"四川省\",\"type\":1,\"agency_id\":0},{\"id\":25,\"parent_id\":1,\"name\":\"贵州省\",\"type\":1,\"agency_id\":0},{\"id\":26,\"parent_id\":1,\"name\":\"云南省\",\"type\":1,\"agency_id\":0},{\"id\":27,\"parent_id\":1,\"name\":\"西藏自治区\",\"type\":1,\"agency_id\":0},{\"id\":28,\"parent_id\":1,\"name\":\"陕西省\",\"type\":1,\"agency_id\":0},{\"id\":29,\"parent_id\":1,\"name\":\"甘肃省\",\"type\":1,\"agency_id\":0},{\"id\":30,\"parent_id\":1,\"name\":\"青海省\",\"type\":1,\"agency_id\":0},{\"id\":31,\"parent_id\":1,\"name\":\"宁夏回族自治区\",\"type\":1,\"agency_id\":0},{\"id\":32,\"parent_id\":1,\"name\":\"新疆维吾尔自治区\",\"type\":1,\"agency_id\":0},{\"id\":33,\"parent_id\":1,\"name\":\"台湾\",\"type\":1,\"agency_id\":0},{\"id\":34,\"parent_id\":1,\"name\":\"香港特别行政区\",\"type\":1,\"agency_id\":0},{\"id\":35,\"parent_id\":1,\"name\":\"澳门特别行政区\",\"type\":1,\"agency_id\":0},{\"id\":36,\"parent_id\":1,\"name\":\"海外\",\"type\":1,\"agency_id\":0}]', 1, 0.01, 1, 0.01, '1533169386347', '0');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_freight_template_main
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_freight_template_main`;
CREATE TABLE `bbgshop_freight_template_main` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `temp_name` varchar(128) NOT NULL,
  `temp_method` int(3) NOT NULL DEFAULT '0' COMMENT '计费方式',
  `create_time` varchar(32) NOT NULL DEFAULT '0',
  `handel_time` varchar(32) NOT NULL DEFAULT '0',
  `handel_num` int(5) NOT NULL DEFAULT '0',
  `point_rules` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_freight_template_main
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_freight_template_main` VALUES (12, '江浙沪亿元', 0, '1532593153518', '0', 0, 2);
INSERT INTO `bbgshop_freight_template_main` VALUES (13, '测试0.01元运费', 0, '1533169386340', '0', 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_goods
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_goods`;
CREATE TABLE `bbgshop_goods` (
  `id` bigint(32) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `goods_sn` bigint(32) NOT NULL,
  `name` varchar(120) NOT NULL DEFAULT '',
  `brand_id` int(11) unsigned NOT NULL DEFAULT '0',
  `goods_number` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `keywords` varchar(255) NOT NULL DEFAULT '',
  `goods_brief` varchar(255) NOT NULL DEFAULT '',
  `goods_desc` text,
  `is_on_sale` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `add_time` varchar(32) NOT NULL DEFAULT '0',
  `sort_order` smallint(4) unsigned NOT NULL DEFAULT '100',
  `is_delete` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `attribute_category` int(11) unsigned NOT NULL DEFAULT '0',
  `counter_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '专柜价格',
  `extra_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '附加价格',
  `is_new` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `goods_unit` varchar(45) NOT NULL DEFAULT '件' COMMENT '商品单位',
  `primary_pic_url` varchar(255) DEFAULT NULL COMMENT '商品主图',
  `list_pic_url` varchar(255) DEFAULT NULL COMMENT '商品列表图',
  `retail_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '零售价格',
  `sell_volume` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '销售量',
  `primary_product_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '主sku　product_id',
  `unit_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单位价格，单价',
  `promotion_desc` varchar(255) DEFAULT NULL,
  `promotion_tag` varchar(45) DEFAULT NULL,
  `app_exclusive_price` decimal(10,2) unsigned DEFAULT NULL COMMENT 'APP专享价',
  `is_app_exclusive` tinyint(1) unsigned DEFAULT NULL COMMENT '是否是APP专属',
  `is_limited` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `update_time` varchar(32) NOT NULL DEFAULT '0',
  `have_pay_num` int(11) NOT NULL DEFAULT '0',
  `have_confirm_num` int(11) NOT NULL DEFAULT '0',
  `cost_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '成本价',
  `freight_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `freight_template` int(11) NOT NULL DEFAULT '0',
  `freight_type` int(1) NOT NULL DEFAULT '0' COMMENT '运费计算规则类型',
  `short_order` int(11) NOT NULL DEFAULT '0',
  `supplier_name` varchar(128) DEFAULT NULL,
  `supplier_id` int(5) DEFAULT NULL,
  `Identity` int(2) NOT NULL DEFAULT '0' COMMENT '是否需要身份信息',
  PRIMARY KEY (`id`),
  KEY `goods_sn` (`goods_sn`),
  KEY `cat_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  KEY `goods_number` (`goods_number`),
  KEY `sort_order` (`sort_order`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_goods
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_goods` VALUES (90706, 1036047, 90706, '【直邮】Swarovski 施华洛世奇SS 优雅 项链', 0, 99, '', '【直邮】Swarovski 施华洛世奇SS 优雅 项链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FmX0mt66F6s9GLyoWLIrRD9Tt7oc\"><img src=\"http://resource.bbgshop.com/Fpoig17Y8OHkYPR5Tg1bPUsOtMjC\"><img src=\"http://resource.bbgshop.com/FsScoNWm4xXNYuO_-nFx4fR6B426\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FmX0mt66F6s9GLyoWLIrRD9Tt7oc', 'http://resource.bbgshop.com/FmX0mt66F6s9GLyoWLIrRD9Tt7oc', 709.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (519375, 1036047, 519375, '【直邮】Swarovski 施华洛世奇白天鹅手镯', 0, 97212, '', '【直邮】Swarovski 施华洛世奇白天鹅手镯', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FtykVXw0W2RDqrc7XDA1N9OYD2p8\"><img src=\"http://resource.bbgshop.com/FtYJDOwdf-yHY_5IXUksmLhFp2HC\"><img src=\"http://resource.bbgshop.com/FvHTFNqPevfHvJ7TFigdiO9jGor9\"><img src=\"http://resource.bbgshop.com/Fu10dqBNkZtjjw6Jwh1rdwegQGz2\"><img src=\"http://resource.bbgshop.com/Fjai9GShF01QDAWMTx-N5_ZVxiE4\"></p>', 1, '0', 1, 0, 0, 0.00, 1023.58, 0, '个', 'http://resource.bbgshop.com/FtDThAfHHdUjOqc4M-K2h2x6ayGF', 'http://resource.bbgshop.com/FtDThAfHHdUjOqc4M-K2h2x6ayGF', 839.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '1530690413155', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (477300, 1036047, 477300, '【直邮】Swarovski 施华洛世奇花园 项链 绿色', 0, 99, '', '【直邮】Swarovski 施华洛世奇花园 项链 绿色', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FipSsYpjx0swNzpdGheFa8rV80fg\"><img src=\"http://resource.bbgshop.com/FnqspZHDpqZhbWLlO1Iyn6LZcGe4\"><img src=\"http://resource.bbgshop.com/Fpoig17Y8OHkYPR5Tg1bPUsOtMjC\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 1, '个', 'http://resource.bbgshop.com/FshUJeYiSp4-3OsTcXCBeVuqFKui', 'http://resource.bbgshop.com/FshUJeYiSp4-3OsTcXCBeVuqFKui', 0.01, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 1, '1533607665927', 6, 9, 0.00, 0.00, 13, 1, 100, '贝堡', 6, 1);
INSERT INTO `bbgshop_goods` VALUES (104223, 1036047, 104223, '【直邮】Swarovski 施华洛世奇环钻 蓝吊坠 项链', 0, 99, '', '【直邮】Swarovski 施华洛世奇环钻 蓝吊坠 项链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FugO3OPFAK5eVjxmIJ5tuEA059mt\"><img src=\"http://resource.bbgshop.com/FkO5si43g65yz3zmfGmdi4J1mPps\"><img src=\"http://resource.bbgshop.com/Fpoig17Y8OHkYPR5Tg1bPUsOtMjC\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fix76r8FQ2glgw2dCDScqMK6Qpq7', 'http://resource.bbgshop.com/Fix76r8FQ2glgw2dCDScqMK6Qpq7', 949.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (11154, 1036047, 11154, '【直邮】Swarovski 施华洛世奇几何图案项链', 0, 99, '', '【直邮】Swarovski 施华洛世奇几何图案项链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FpKnX3hsAiTAexvvx1Svb0DD-xzI\"><img src=\"http://resource.bbgshop.com/Fvi_FyNuubacElbqZ2LcRhuOtxOv\"><img src=\"http://resource.bbgshop.com/Fnk3VCrFRiMRYcRYPR_l5Jtymbpq\"><img src=\"http://resource.bbgshop.com/Fpoig17Y8OHkYPR5Tg1bPUsOtMjC\"><img src=\"http://resource.bbgshop.com/FqIrkJctVGRMARUFza1NRqCtMQyS\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FpKnX3hsAiTAexvvx1Svb0DD-xzI', 'http://resource.bbgshop.com/FpKnX3hsAiTAexvvx1Svb0DD-xzI', 709.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (284518, 1036047, 284518, '【直邮】Swarovski 施华洛世奇渐变双天鹅手镯', 0, 99, '', '【直邮】Swarovski 施华洛世奇渐变双天鹅手镯', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FjktVgiRLnHXY6yFotGcjBLqyybX\"><img src=\"http://resource.bbgshop.com/FmVqF0fUS6oAlFT9CgW6RfwyVseH\"><img src=\"http://resource.bbgshop.com/FvNfbpzMxmMwlsBqp6hILtQY8lns\"><img src=\"http://resource.bbgshop.com/Fq3CU1Vrv2UEPF71-NuOH09naa5F\"><img src=\"http://resource.bbgshop.com/FsyKt28O0Kghd-UojNiR8AeXLLrF\"><img src=\"http://resource.bbgshop.com/FiAmDalKoBU02tCifFFcX0rJPJBs\"><img src=\"http://resource.bbgshop.com/FqhvTZID2WMpUAgzBUWdMQEOZChk\"><img src=\"http://resource.bbgshop.com/Fpp-u-cADN887SjKd8vsA8zig3Ds\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FglRPIx9qmpC2ZC6pkuJsr7wEVjb', 'http://resource.bbgshop.com/FglRPIx9qmpC2ZC6pkuJsr7wEVjb', 999.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (2832, 1036047, 2832, '【直邮】Swarovski 施华洛世奇惊艳 项链', 0, 99, '', '【直邮】Swarovski 施华洛世奇惊艳 项链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FirlYqfOkY3YjF3Dve678dYUK6Oo\"><img src=\"http://resource.bbgshop.com/Fui09Ld1bD3C8J2y4S33rIKiC813\"><img src=\"http://resource.bbgshop.com/FnXmMJdr8gpeznGGE8piCCWAldWa\"><img src=\"http://resource.bbgshop.com/Fpoig17Y8OHkYPR5Tg1bPUsOtMjC\"><img src=\"http://resource.bbgshop.com/FobuA0AUpQSlD6O0h06N_zzwJRgX\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FirlYqfOkY3YjF3Dve678dYUK6Oo', 'http://resource.bbgshop.com/FirlYqfOkY3YjF3Dve678dYUK6Oo', 709.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (83888, 1036047, 83888, '【直邮】Swarovski 施华洛世奇克里斯蒂项链 粉色', 0, 99, '', '【直邮】Swarovski 施华洛世奇克里斯蒂项链 粉色', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FqlIcaa1MGGHsOo8kkKA3JqgzN8O\"><img src=\"http://resource.bbgshop.com/Fpoig17Y8OHkYPR5Tg1bPUsOtMjC\"><img src=\"http://resource.bbgshop.com/Fh_ePaVeUcO8swzJHjbTANkERgVU\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FqlIcaa1MGGHsOo8kkKA3JqgzN8O', 'http://resource.bbgshop.com/FqlIcaa1MGGHsOo8kkKA3JqgzN8O', 709.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (103275, 1036047, 103275, '【直邮】Swarovski 施华洛世奇克里斯蒂项链 蓝色', 0, 99, '', '【直邮】Swarovski 施华洛世奇克里斯蒂项链 蓝色', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FnwjuJObAsjQZxu-BUjiDf43_CO7\"><img src=\"http://resource.bbgshop.com/Fpoig17Y8OHkYPR5Tg1bPUsOtMjC\"><img src=\"http://resource.bbgshop.com/FjWUW3Ukx9n119XibA-RzneQUWev\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FnwjuJObAsjQZxu-BUjiDf43_CO7', 'http://resource.bbgshop.com/FnwjuJObAsjQZxu-BUjiDf43_CO7', 709.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (813924, 1036047, 813924, '【直邮】Swarovski 施华洛世奇蓝调多色球手链', 0, 99, '', '【直邮】Swarovski 施华洛世奇蓝调多色球手链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FmcVN8elTJsFnHedOYZCvVYLP1uU\"><img src=\"http://resource.bbgshop.com/FvfBxZCM2o8jFjug1ej-jGQLunoe\"><img src=\"http://resource.bbgshop.com/FvmeEdnR4jYdcPIvpyKZpQ73U4en\"><img src=\"http://resource.bbgshop.com/FuGxBhQ7YcSW4Pr7Uzub6u6eWUPF\"><img src=\"http://resource.bbgshop.com/Fjd8JkTiIcY4L81Km79Ttfn_D-v3\"><img src=\"http://resource.bbgshop.com/FnLBISGuOj5vj6FU3TEgIEF62U7Y\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FnCY0GzeYIsqARI-Du22UDS2FjFE', 'http://resource.bbgshop.com/FnCY0GzeYIsqARI-Du22UDS2FjFE', 739.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '1533172957451', 1, 21, 0.00, 0.00, 12, 1, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (93860, 1036047, 93860, '【直邮】Swarovski 施华洛世奇丘比特 项链 耳钉 一套', 0, 99, '', '【直邮】Swarovski 施华洛世奇丘比特 项链 耳钉 一套', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fnv6TESYutYnPjfUYSmOc8vlr7MU\"><img src=\"http://resource.bbgshop.com/Fj3Mv2Tc4XIuw9aFd3tUPOnIKeFR\"><img src=\"http://resource.bbgshop.com/Fpoig17Y8OHkYPR5Tg1bPUsOtMjC\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FpewE5s2NxJUGj4cP4ePP2derP9k', 'http://resource.bbgshop.com/FpewE5s2NxJUGj4cP4ePP2derP9k', 829.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (2052, 1036047, 2052, '【直邮】Swarovski 施华洛世奇十二星座白羊座 2017 灵动锁骨链', 0, 99, '', '【直邮】Swarovski 施华洛世奇十二星座白羊座 2017 灵动锁骨链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fh8BfWvUeAKJZAL9xYHcPQamXqVS\"><img src=\"http://resource.bbgshop.com/Ft8L4bXqACIWmSr-GBEDr1UjDFzd\"><img src=\"http://resource.bbgshop.com/Fl5mk3MQKh-NOVbc-yeiCqqx20wt\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FuOAYLXnMnZxuXmWODIQ6XGnBr1e', 'http://resource.bbgshop.com/FuOAYLXnMnZxuXmWODIQ6XGnBr1e', 728.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (622336, 1036031, 622336, 'APM Monaco 黑色镶晶钻流星手镯星星', 0, 99, '', 'APM Monaco 黑色镶晶钻流星手镯星星', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FkNECG9orQwS2u7I32UmmRRXx3hX\"><img src=\"http://resource.bbgshop.com/FpYSVlaa-FPZcH8Avzmxp6wuGh1I\"><img src=\"http://resource.bbgshop.com/Fk0HzQ1OORoAieTydEZFqHCNHHeF\"><img src=\"http://resource.bbgshop.com/Fpgt9WkxAQtXxQQwtD8pPpqtE05t\"><img src=\"http://resource.bbgshop.com/FuPG_i6Yfatr3StyyVVUqhmTMfNn\"><img src=\"http://resource.bbgshop.com/FrWmSf5x_LAttzkuCTcDuceDA4V3\"><img src=\"http://resource.bbgshop.com/FrlwI9rl1yotwQCo9MqY9C2y6R5M\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 1218.78, 0, '个', 'http://resource.bbgshop.com/FrUsorA5Q2IPlMEQOIi2ZXpXOGtx', 'http://resource.bbgshop.com/FrUsorA5Q2IPlMEQOIi2ZXpXOGtx', 999.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '1532341283257', 0, 3, 879.12, 8.37, 0, 0, 50, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (369000, 1036031, 369000, 'APM Monaco 镶晶钻戒指多环双星时尚范', 0, 99, '', 'APM Monaco 镶晶钻戒指多环双星时尚范', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FmCMRPuYlVtoyvAIATwnuKd2v2wU\"><img src=\"http://resource.bbgshop.com/FsoqJUBU78wM-FBcN_flRR-VDINV\"><img src=\"http://resource.bbgshop.com/FuO13-etqlSiLinlZQXlAiH6dVvu\"><img src=\"http://resource.bbgshop.com/FlkKtAq4Br-bW6SxQMtL5pkjKtNN\"><img src=\"http://resource.bbgshop.com/FqxZ7wcOcNt4f4hKt78LOaosULP5\"><img src=\"http://resource.bbgshop.com/FpityHHSxBUAgmx3lNzXILW31ue3\"><img src=\"http://resource.bbgshop.com/FkwI49IC5UVlEnCRC5jwhgLUZENO\"><img src=\"http://resource.bbgshop.com/FulTaX-oTncrEhVLTtHH2knQs4ji\"><img src=\"http://resource.bbgshop.com/Fhry_onc59smF-9DvRbkSYTLbKve\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fko7MeCyg9Fi0xXZi9x_xiMjihnG', 'http://resource.bbgshop.com/Fko7MeCyg9Fi0xXZi9x_xiMjihnG', 1170.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (67743, 1036031, 67743, 'APM Monaco 镶晶钻指骨戒关节戒星星手饰', 0, 99, '', 'APM Monaco 镶晶钻指骨戒关节戒星星手饰', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fh7dTzUI8UyHpycrcs0UwfPmVAjx\"><img src=\"http://resource.bbgshop.com/Fk_K8vXfnBCLmEgEH4XONp7AQpne\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fh7dTzUI8UyHpycrcs0UwfPmVAjx', 'http://resource.bbgshop.com/Fh7dTzUI8UyHpycrcs0UwfPmVAjx', 661.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (109248, 1036047, 109248, '【直邮】Swarovski 施华洛世奇 HOLLOW圆形转运珠项链玫瑰金色', 0, 99, '', '【直邮】Swarovski 施华洛世奇 HOLLOW圆形转运珠项链玫瑰金色', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FluCNBf9p_oygFABJ5hycOBO9BBi\"><img src=\"http://resource.bbgshop.com/FrezMm1gOuTN3qJdG3DKrjN0898J\"><img src=\"http://resource.bbgshop.com/FtDtvU8_5Qr9Farfep6jOd45dXq7\"><img src=\"http://resource.bbgshop.com/Fpoig17Y8OHkYPR5Tg1bPUsOtMjC\"><img src=\"http://resource.bbgshop.com/Frv6cpwI5PXzJ-0I3e9ZOoqPrEsu\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FrezMm1gOuTN3qJdG3DKrjN0898J', 'http://resource.bbgshop.com/FrezMm1gOuTN3qJdG3DKrjN0898J', 709.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (60564, 1036047, 60564, '【直邮】Swarovski 施华洛世奇 黑天鹅对链', 0, 99, '', '【直邮】Swarovski 施华洛世奇 黑天鹅对链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fj4UYfIh7CDUitjW6kIB3kiaXvXi\"><img src=\"http://resource.bbgshop.com/FgnXVLRRFO4AVx7NadBGlF0MZrmX\"><img src=\"http://resource.bbgshop.com/FkJndNgrZcXzYvj2QpuqeabGSHZr\"><img src=\"http://resource.bbgshop.com/FpImerRDmggrP4RqzMVlUpbcTN5r\"><img src=\"http://resource.bbgshop.com/FqJmvKi0jTP_7jSoNygBn4da__Fv\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FlMsci4GyVkpA_RnlQ3Rrbox-LOz', 'http://resource.bbgshop.com/FlMsci4GyVkpA_RnlQ3Rrbox-LOz', 799.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (267471, 1036047, 267471, '【直邮】Swarovski 施华洛世奇 黑天鹅珍珠耳环', 0, 99, '', '【直邮】Swarovski 施华洛世奇 黑天鹅珍珠耳环', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fqu_zUARBEV5_55aBoVseUWj3_qI\"><img src=\"http://resource.bbgshop.com/FtB2xQN2PXFgkjo_nPDlwA4L3H2o\"><img src=\"http://resource.bbgshop.com/Fr-b6ScqA_2YEPQBC8dkp_DZvlbi\"><img src=\"http://resource.bbgshop.com/FhVlDq_W1aTrCCIyNQI3ppPq6dZr\"><img src=\"http://resource.bbgshop.com/Fia1973FfguabDelHttNGgiMW5Mq\"><img src=\"http://resource.bbgshop.com/FjKvhtlPFxqWsI3PuzOpT4JzlGhL\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fmi-fMWH84y4uj10AAGbK0XV8AHf', 'http://resource.bbgshop.com/Fmi-fMWH84y4uj10AAGbK0XV8AHf', 699.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (42827, 1036047, 42827, '【直邮】Swarovski 施华洛世奇 渐变天鹅耳钉', 0, 99, '', '【直邮】Swarovski 施华洛世奇 渐变天鹅耳钉', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FvE_DSIbKs5BpkQxIs39ON5juANf\"><img src=\"http://resource.bbgshop.com/FqDK_fZqFC_oQzXCnzxErFxqSgYr\"><img src=\"http://resource.bbgshop.com/Foet3RMjL1-dtjp5AKn5FcWBZcLi\"><img src=\"http://resource.bbgshop.com/FtuMdRvJC1wLrwv7oDcB9AVX3lnb\"><img src=\"http://resource.bbgshop.com/FvkS_LTa6wULaJFDhRAzJQ1AP8BB\"><img src=\"http://resource.bbgshop.com/FvYoQP3Xm4CAAZhekW7caqd3YZd9\"><img src=\"http://resource.bbgshop.com/FldOUz5Kk4w4-1Au5OK9OV-_wFJ4\"><img src=\"http://resource.bbgshop.com/Frsf35vT4QifkYoKKfmf8eQQuyit\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FnrVYTv59JQfPLRyj9cevotILgNV', 'http://resource.bbgshop.com/FnrVYTv59JQfPLRyj9cevotILgNV', 699.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (91574, 1036047, 91574, '【直邮】Swarovski 施华洛世奇 十二星座项链女 双子座 2017 灵动锁骨链', 0, 99, '', '【直邮】Swarovski 施华洛世奇 十二星座项链女 双子座 2017 灵动锁骨链 ', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FiW57EaIxslhgH8ecHR-yrL2w4V_\"><img src=\"http://resource.bbgshop.com/FuEC1SHhOat3J5T3ziVsJZYCWyKu\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fkqv2qntPdg4DrysuJoy3aeAfMd7', 'http://resource.bbgshop.com/Fkqv2qntPdg4DrysuJoy3aeAfMd7', 728.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (250852, 1036047, 250852, '【直邮】Swarovski 施华洛世奇 十二星座项链女狮子座2017灵动锁骨链', 0, 99, '', '【直邮】Swarovski 施华洛世奇 十二星座项链女狮子座2017灵动锁骨链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FiAdTURa1gtN9bhRzJPIMFaxkd9r\"><img src=\"http://resource.bbgshop.com/Fn1Qs-zYkifmrwaKAVdKrFvW_LDa\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FnQUYRI_8PVSQCNYsyAwtEmrLVjb', 'http://resource.bbgshop.com/FnQUYRI_8PVSQCNYsyAwtEmrLVjb', 728.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (19845, 1036047, 19845, '【直邮】Swarovski 施华洛世奇 十二星座项链女双鱼座2017灵动锁骨链', 0, 99, '', '【直邮】Swarovski 施华洛世奇 十二星座项链女双鱼座2017灵动锁骨链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FhiHAVSIQBJ4sUoKHTs6XFvgXeUr\"><img src=\"http://resource.bbgshop.com/Fl6NmwQdWbqiY3l26Fjuadn0rcLT\"><img src=\"http://resource.bbgshop.com/FqVLZ_zOykRfTCtPsCIOxpkDB5q1\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FhP-MTujONWjlBHZZiqsXCX7W_5O', 'http://resource.bbgshop.com/FhP-MTujONWjlBHZZiqsXCX7W_5O', 728.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (303863, 1036047, 303863, '【直邮】Swarovski 施华洛世奇 十二星座项链女水瓶座2017灵动锁骨链', 0, 99, '', '【直邮】Swarovski 施华洛世奇 十二星座项链女水瓶座2017灵动锁骨链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FlC4VmICme1Fu2-dCgP7zKACBW1D\"><img src=\"http://resource.bbgshop.com/FsRNl8ZBd1wfGLB2TNb0Evr_md5w\"><img src=\"http://resource.bbgshop.com/Fjo597WxPBb3pCFLoMUQX9cydWs9\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Ftn29EDSowV9rJIiG7ikHft7fTaN', 'http://resource.bbgshop.com/Ftn29EDSowV9rJIiG7ikHft7fTaN', 728.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (841662, 1036047, 841662, '【直邮】Swarovski 施华洛世奇 十二星座项链女天秤座2017灵动锁骨链', 0, 99, '', '【直邮】Swarovski 施华洛世奇 十二星座项链女天秤座2017灵动锁骨链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FrIlRNLxsdapNsA2DPS_rBBTkLqP\"><img src=\"http://resource.bbgshop.com/FkwzA9bYuUXOWkXPtozFWjFUyjtJ\"><img src=\"http://resource.bbgshop.com/FsentxD4ckhvgIUXemrzEV9AozR-\"></p>', 1, '0', 1, 0, 0, 0.00, 888.16, 0, '个', 'http://resource.bbgshop.com/FtSyNYud1ZxMLbAM0NYhlYBKM0Qm', 'http://resource.bbgshop.com/FtSyNYud1ZxMLbAM0NYhlYBKM0Qm', 728.23, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '1532140379309', 0, 0, 640.64, 2.37, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (65621, 1036047, 65621, '【直邮】Swarovski 施华洛世奇 十二星座项链女天蝎座2017灵动锁骨链', 0, 99, '', '【直邮】Swarovski 施华洛世奇 十二星座项链女天蝎座2017灵动锁骨链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fg4cYyATSAv55dDkSMt1mBYAkMZU\"><img src=\"http://resource.bbgshop.com/Fmm7l6tvMDL9H2dc_O1vRXMLn4ln\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fi1scR2PJVvBraaptdTyALvvWG6f', 'http://resource.bbgshop.com/Fi1scR2PJVvBraaptdTyALvvWG6f', 728.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '1533090551068', 0, 2, 0.00, 0.00, 12, 1, 1000, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (369904, 1036031, 369904, 'APM Monaco 黑色镶晶钻戒指星星指环', 0, 99, '', 'APM Monaco 黑色镶晶钻戒指星星指环', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fhe6B2TAin-qA2_-y4d5nJTs2M8p\"><img src=\"http://resource.bbgshop.com/FvYFxyyMxpQPt23ehLiEgLLNAr9q\"><img src=\"http://resource.bbgshop.com/FobiypZtuQrl9NuMA2bjkrRAkVTD\"><img src=\"http://resource.bbgshop.com/Fgc8n8ltbKVATRwrMKkh0CIVIqGm\"><img src=\"http://resource.bbgshop.com/Frqf0OW3ryYERpRVXl4-xl2Xave6\"><img src=\"http://resource.bbgshop.com/Fjo1GmGLrJNRQw0NEHGgQrTtkTlI\"><img src=\"http://resource.bbgshop.com/Fs2KhBG7_5WPq2FLItniwdV6DdaZ\"><img src=\"http://resource.bbgshop.com/Fhry_onc59smF-9DvRbkSYTLbKve\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FqQxhL_sg5ssdHge7vKBpRG6uReJ', 'http://resource.bbgshop.com/FqQxhL_sg5ssdHge7vKBpRG6uReJ', 661.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (7308, 1036031, 7308, 'APM Monaco XL系列 银镶晶钻扇形戒指', 0, 99, '', 'APM Monaco XL系列 银镶晶钻扇形戒指', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FikSfWFDiS4U8aG64UN-8cQj2IrS\"><img src=\"http://resource.bbgshop.com/Fpk6lQyl_fxEJU_alpR00-2YdOp-\"><img src=\"http://resource.bbgshop.com/FoK0gorVvnuQ8boIra2EsAz1KOFt\"><img src=\"http://resource.bbgshop.com/FprDVariLyBKVxJL609JCk1f1R37\"><img src=\"http://resource.bbgshop.com/FikiZrYtDvR3gzOUXTdaVzgt5qct\"><img src=\"http://resource.bbgshop.com/FmVeQlFxI5WiDcsST3OxGzIbB-ce\"><img src=\"http://resource.bbgshop.com/Fhry_onc59smF-9DvRbkSYTLbKve\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FshmFDcz96Hxb_CkiKdxq0N8iyTX', 'http://resource.bbgshop.com/FshmFDcz96Hxb_CkiKdxq0N8iyTX', 1047.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (88319, 1036031, 88319, 'APM Monaco XL系列 银镶晶钻珍珠扣针项链', 0, 99, '', 'APM Monaco XL系列 银镶晶钻珍珠扣针项链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FgUAhOrMPSvBikBwrAp-h7-n6srp\"><img src=\"http://resource.bbgshop.com/FnTpsBtNPESjt3hmb40E6CDgk7eb\"><img src=\"http://resource.bbgshop.com/Fn9HW7TF-lvJtPFJveP_xsF_ldRw\"><img src=\"http://resource.bbgshop.com/FmG1M8pCzZB9sbcfpWC-6o9lD5gU\"><img src=\"http://resource.bbgshop.com/FjIH2RX-KAJwuveTug_q4WLikOri\"><img src=\"http://resource.bbgshop.com/FjKAjrFfvcUB28cWrFiAtYndq5ZJ\"><img src=\"http://resource.bbgshop.com/FsweJ5l9E2hgvOmMF9IFBoDHlUnU\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fuu12WkNNnk_JbBk52qi-Hl4CnqE', 'http://resource.bbgshop.com/Fuu12WkNNnk_JbBk52qi-Hl4CnqE', 923.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (81405, 1036031, 81405, 'APM Monaco 不对称耳骨夹耳环女耳钉', 0, 99, '', 'APM Monaco 不对称耳骨夹耳环女耳钉', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fv1PaL7tAIreXiWC8Cm_0-Catcuc\"><img src=\"http://resource.bbgshop.com/FoWKv1m4p2m-2nZdq8EJcqpM_s3U\"><img src=\"http://resource.bbgshop.com/Fiju66bNfk7ZIeZbo8NvKHcFsX69\"><img src=\"http://resource.bbgshop.com/FjTTTRSHRvtlpt6KkzP-uzdztzBZ\"><img src=\"http://resource.bbgshop.com/Fuh0RJtQ1-xTcem9l9tR4GPF22S2\"><img src=\"http://resource.bbgshop.com/FvAcTqwflOnwF8YVI79QvACIbzlt\"><img src=\"http://resource.bbgshop.com/FstofQ7Um4vnbyWpk27yyA8g5Imm\"><img src=\"http://resource.bbgshop.com/FpWxHPraCvmKC_1PFKQlArohZ6ps\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FvjXiDCBDmD1XEsg1slzBmAJS8DH', 'http://resource.bbgshop.com/FvjXiDCBDmD1XEsg1slzBmAJS8DH', 908.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (15800, 1036031, 15800, 'APM Monaco 纯银镶晶钻别针珍珠戒指', 0, 99, '', 'APM Monaco 纯银镶晶钻别针珍珠戒指', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FgBV1fgQ1n-cx67hiL-9igNSqqhp\"><img src=\"http://resource.bbgshop.com/FuJ4x7s4i-H746urJGUSpJElfmeT\"><img src=\"http://resource.bbgshop.com/FjESBb6XbDLeX5P7ftPVYXvfQ541\"><img src=\"http://resource.bbgshop.com/FoeL8PCMN9PkgZbWmZ85AJKhiznS\"><img src=\"http://resource.bbgshop.com/FhwqAjVe-H4AUn3DFBMU1MUAIRNN\"><img src=\"http://resource.bbgshop.com/FnX_Ny4XWzUElk08Fx6RF-6Xt3d1\"><img src=\"http://resource.bbgshop.com/Fhry_onc59smF-9DvRbkSYTLbKve\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FhD1q8PeOsbVnkqAQ7dvpKE-dIih', 'http://resource.bbgshop.com/FhD1q8PeOsbVnkqAQ7dvpKE-dIih', 1062.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (45045, 1036031, 45045, 'APM Monaco 纯银镶晶钻别针珍珠项链', 0, 99, '', 'APM Monaco 纯银镶晶钻别针珍珠项链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FgruU53hPohmpX_gwSek_-Ghp85x\"><img src=\"http://resource.bbgshop.com/FrJZk2hqKizfpWsmfZc7Bij8GM4B\"><img src=\"http://resource.bbgshop.com/FooB6VmShp0VSqkUxedAGEFVxrtO\"><img src=\"http://resource.bbgshop.com/Fg9VuIcTH57Tl9trT_hG6VSa_fx1\"><img src=\"http://resource.bbgshop.com/FuRkPuNBcqHmucs48Gn_RtmKgrpz\"><img src=\"http://resource.bbgshop.com/Fg9VuIcTH57Tl9trT_hG6VSa_fx1\"><img src=\"http://resource.bbgshop.com/Fh57S8l1AjCA0Dv_Frl_z3dA-d01\"><img src=\"http://resource.bbgshop.com/FiTGnLCeVZkpIgEK6NZSYCnXRV9m\"><img src=\"http://resource.bbgshop.com/FsklIPKJP7TfavPPuHuMo_qaEUv_\"><img src=\"http://resource.bbgshop.com/FmK4PwT5arBAk1SAJISVhDJKz3IY\"><img src=\"http://resource.bbgshop.com/FqOGBoI1DHuWhaIw-otOi6byExMb\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FsYPfp-czHHML3yQAuhqXf1Cg23R', 'http://resource.bbgshop.com/FsYPfp-czHHML3yQAuhqXf1Cg23R', 1039.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (428513, 1036031, 428513, 'APM Monaco 单只纯银镶晶钻别针珍珠耳环', 0, 99, '', 'APM Monaco 单只纯银镶晶钻别针珍珠耳环', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FvWViI0ozHrFdjyv1DrVixeKRnLv\"><img src=\"http://resource.bbgshop.com/FhKNoiQ-kDaA649zC_77AACzVrYo\"><img src=\"http://resource.bbgshop.com/FhkNCJCkbqGavhUaRZtQCrEjGUPv\"><img src=\"http://resource.bbgshop.com/FrSOLf_0W6Y0GcHt6c3qMwEg2GNY\"><img src=\"http://resource.bbgshop.com/Fscy1ZgUzFLE4vn6ZhaqdlmfatJ-\"><img src=\"http://resource.bbgshop.com/FhMW9-Y7T93nTK_vsbO-WRoLplae\"><img src=\"http://resource.bbgshop.com/FhHBs1VQnA5YXgjMmTawqfv2n807\"><img src=\"http://resource.bbgshop.com/FkWMJ2TsHuxXJl1JjONEuJHzI0HR\"><img src=\"http://resource.bbgshop.com/FjU0VRmT9nwiMs-hNto4Mt7FbLG0\"><img src=\"http://resource.bbgshop.com/FkKEIptDwWbhu9H7ZipuQ_2gNt13\"><img src=\"http://resource.bbgshop.com/Fmcfait1lg6ApS85_CkPLwbTyFha\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fhy9sMi3uCKSiFFepYN8b2l-3uzO', 'http://resource.bbgshop.com/Fhy9sMi3uCKSiFFepYN8b2l-3uzO', 962.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (504504, 1036031, 504504, 'APM Monaco 单只黑色纯银镶晶钻流星耳骨夹', 0, 99, '', 'APM Monaco 单只黑色纯银镶晶钻流星耳骨夹', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fhe_Uyg7eS1Dy0zGRd34vGUJ5tFq\"><img src=\"http://resource.bbgshop.com/Fmx2_0FFj_XqYqZ4yNASkvEagM2q\"><img src=\"http://resource.bbgshop.com/FtkNYJAnXJ0Evdcgx6MChlrdQfC_\"><img src=\"http://resource.bbgshop.com/Fl-LTHoxn4VHpNpisy4xjCsDYY_J\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FoyX8fs0fM3pyzY2mDYiuG6BqZh_', 'http://resource.bbgshop.com/FoyX8fs0fM3pyzY2mDYiuG6BqZh_', 445.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (196992, 1036031, 196992, 'APM Monaco 单只银镶晶钻双流星耳骨夹耳环', 0, 99, '', 'APM Monaco 单只银镶晶钻双流星耳骨夹耳环', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fu9fbdHXJrsUa4kcslIXjJ_FUk9Z\"><img src=\"http://resource.bbgshop.com/FqfJPbKjg6ygjUIJzeBGrm3tbgDY\"><img src=\"http://resource.bbgshop.com/FvoOm8vZXpypo5LaHgpOfRVe8uCo\"><img src=\"http://resource.bbgshop.com/FghA9aXZJ70s69vDAjNr8lqnKLGl\"><img src=\"http://resource.bbgshop.com/FlrVFnbXXKyl8dSu6J4FuR1RA3S2\"><img src=\"http://resource.bbgshop.com/Fumgo1QSjkf-O_uCMjPTzDMfMaBn\"><img src=\"http://resource.bbgshop.com/FhTHSCm6jnN1FVJVT8mpk8nYiqBd\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fpz2pQOO2acM5HR0nqeUtn_qDx2Y', 'http://resource.bbgshop.com/Fpz2pQOO2acM5HR0nqeUtn_qDx2Y', 738.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (266000, 1036031, 266000, 'APM Monaco 黑色镶晶钻耳骨夹耳环女', 0, 99, '', 'APM Monaco 黑色镶晶钻耳骨夹耳环女', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fr7sRqioLECa9dU18maHljYGVjRr\"><img src=\"http://resource.bbgshop.com/Fl3tpvBsIxYkUYIf8wTfqH3iDv5V\"><img src=\"http://resource.bbgshop.com/FhJTZCZU00fUoC2XJAjp2PhdCJOe\"><img src=\"http://resource.bbgshop.com/Fmf8PODqNU892iJ3qLUIXGC1soj3\"><img src=\"http://resource.bbgshop.com/FrTjtFQsX8_A696cS9AO3zO3W1q6\"><img src=\"http://resource.bbgshop.com/FoTgQ-IvdAR2PY6sf95X6iI3tib0\"><img src=\"http://resource.bbgshop.com/FrhFRc7xgZ1qL5Q22XTZuN2YhEtT\"><img src=\"http://resource.bbgshop.com/FnRNRKWY906Pw05fTbeaPRYhdnDz\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FqeC_VO_p0WjGlk3zuDnax3RcgrY', 'http://resource.bbgshop.com/FqeC_VO_p0WjGlk3zuDnax3RcgrY', 908.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (141400, 1036031, 141400, 'APM Monaco 黑色镶晶钻戒指女士时尚', 0, 99, '', 'APM Monaco 黑色镶晶钻戒指女士时尚', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fm64-RnESkaVBcAmZg5rfTp3DoV0\"><img src=\"http://resource.bbgshop.com/Fts4NERt3Ss5lXvd3-M-PWid4QTi\"><img src=\"http://resource.bbgshop.com/FnpWXUEhuMvGY-nw1cMF2uJdlpSV\"><img src=\"http://resource.bbgshop.com/Ft6WASlJ76SIO-eE0fSG1Fk06Jn0\"><img src=\"http://resource.bbgshop.com/Fh-LAfWh0CVbaKNiXcTPBhpszhAj\"><img src=\"http://resource.bbgshop.com/FheJuzotzEFpe_60D2vKZT3WG4k9\"><img src=\"http://resource.bbgshop.com/Fi2Yh0JRfomTLcjRhFqmxKYwJTLV\"><img src=\"http://resource.bbgshop.com/FiwovBYaclOyDwzk53Xa1_XWV0Xi\"><img src=\"http://resource.bbgshop.com/Fhry_onc59smF-9DvRbkSYTLbKve\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fh5i2yCZ5HBYqQ6ZNLgYstklrfHH', 'http://resource.bbgshop.com/Fh5i2yCZ5HBYqQ6ZNLgYstklrfHH', 1170.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (616930, 1036031, 616930, 'APM Monaco VALENTINE系列 银镶晶钻扇形项链', 0, 99, '', 'APM Monaco VALENTINE系列 银镶晶钻扇形项链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FunrD-pJhWhqEpa_DNHdx8OK7lmK\"><img src=\"http://resource.bbgshop.com/FrwbKm4yCKEzV6oyoXxebnBxa83B\"><img src=\"http://resource.bbgshop.com/FumKHW8OcHJ7W_6UcJoY_grJwvib\"><img src=\"http://resource.bbgshop.com/FtUHFqqLwYW8Wk4xSH_3kkIj8zpb\"><img src=\"http://resource.bbgshop.com/FiVwvToPLeP9GH-Yme2l8fPcKWM4\"><img src=\"http://resource.bbgshop.com/Fm6cNNJkqprQMqebm1L54Jkuttw5\"><img src=\"http://resource.bbgshop.com/FgIWBwYghNcI2roEHRWA3txhvX2V\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fhgqzb3H-v0SUDSBaoPoDOOXFhe2', 'http://resource.bbgshop.com/Fhgqzb3H-v0SUDSBaoPoDOOXFhe2', 1787.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (81204, 1036031, 81204, 'APM Monaco METEORITES系列 银流星耳钉耳环', 0, 99, '', 'APM Monaco METEORITES系列 银流星耳钉耳环', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FrQeN-62YNZ1XKvqvwC9XVSnP3aO\"><img src=\"http://resource.bbgshop.com/FhKzI7XBSZr59l9vSvf-QGzpE1TQ\"><img src=\"http://resource.bbgshop.com/FgS4yT3CKIcwkvdBEPfCrA7CgIxx\"><img src=\"http://resource.bbgshop.com/FsnrQeZHj9ePt_LFOAiCoC76VUHY\"><img src=\"http://resource.bbgshop.com/FlC-2S9ojQkR_KRGvd4iciFiwlfN\"><img src=\"http://resource.bbgshop.com/FlTJW7smEj3TZXtAp47njJyAFMvH\"><img src=\"http://resource.bbgshop.com/FsS-8WN3KicCARfXYGRYuZNfBCx1\"><img src=\"http://resource.bbgshop.com/FrbcbuZ0r5mw39AziGMviZbMIEhO\"><img src=\"http://resource.bbgshop.com/FtjEVoSdke58jqNUZT6nFsgjlcf8\"><img src=\"http://resource.bbgshop.com/FsA8rEZIKVEkRxO0ajSu2iV4gxtK\"><img src=\"http://resource.bbgshop.com/Fhqltdg2IEafzXoS9i0_yl645BSA\"><img src=\"http://resource.bbgshop.com/FjB9Yvz3LgxEqhnu4T6ak33U6w74\"><img src=\"http://resource.bbgshop.com/FgrLDTC4kMW5IvkSqPyekaXZDouc\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FtuK3MaMcB-wxy32-9b1AWzMo43p', 'http://resource.bbgshop.com/FtuK3MaMcB-wxy32-9b1AWzMo43p', 460.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (19647, 1036031, 19647, 'APM Monaco METEORITES NOIRES 黑色晶钻耳钉', 0, 99, '', 'APM Monaco METEORITES NOIRES 黑色晶钻耳钉', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FljC6vJdTwoUJwJAQ-5XIT8eKMCu\"><img src=\"http://resource.bbgshop.com/FqakMHm49psFGlSeD-YXC-rfMs5h\"><img src=\"http://resource.bbgshop.com/FuB_JU_OVzY_eydEJq9lFpExgMYR\"><img src=\"http://resource.bbgshop.com/FoC96EdLmGD_ToK9DtlDXNMpU2MU\"><img src=\"http://resource.bbgshop.com/Fse-bCmxfMChkZ8rean6721ea818\"><img src=\"http://resource.bbgshop.com/Fr20DAT835AaARk3bjoiF6wTSCaj\"><img src=\"http://resource.bbgshop.com/FvpBNYe14x9ANw0VdFfNU6eDW6QI\"><img src=\"http://resource.bbgshop.com/FonTc_h9xkcsIKDfXKEzsUouJGZr\"><img src=\"http://resource.bbgshop.com/Fq_gBVIyT4vrUYY6Au4QqBOGC_1x\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fg7yGS8twEj09TbFiDEAzUM6uhQE', 'http://resource.bbgshop.com/Fg7yGS8twEj09TbFiDEAzUM6uhQE', 480.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (175032, 1036031, 175032, 'APM Monaco METEORITES系列 银流星项链吊坠', 0, 99, '', 'APM Monaco METEORITES系列 银流星项链吊坠', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FpC7Hi4rDIhSEPBJriDsBh0hEbI1\"><img src=\"http://resource.bbgshop.com/FhlZ-xwB18Pb7IAquEemY_aguQjE\"><img src=\"http://resource.bbgshop.com/FuKCArYihYHygvl04X2Vk5NOzNM8\"><img src=\"http://resource.bbgshop.com/FlkKtAq4Br-bW6SxQMtL5pkjKtNN\"><img src=\"http://resource.bbgshop.com/FulPqio9lzvv0_My2c4qxWcHFKun\"><img src=\"http://resource.bbgshop.com/Fpj2GNcfVDnOJ1eXQEELhQFIvch1\"><img src=\"http://resource.bbgshop.com/Fr2VF2tTTol77fN8LLYYtX-gonDu\"><img src=\"http://resource.bbgshop.com/FvE4qn5iZMjKkuUl5cH_ePPjlv3i\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FjL9NAbFMh__ZTRUXQt7qBRhixMX', 'http://resource.bbgshop.com/FjL9NAbFMh__ZTRUXQt7qBRhixMX', 730.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (636004, 1036031, 636004, 'APM Monaco METEORITES系列 银双流星手链', 0, 99, '', 'APM Monaco METEORITES系列 银双流星手链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fok-JSmxpD_r8537jP7cW0oRMTz-\"><img src=\"http://resource.bbgshop.com/FqZG_omu6mWzvrmyqZUcAqYkacab\"><img src=\"http://resource.bbgshop.com/FjxsMpmcQRp4kBOgVfEVGIm8bWNf\"><img src=\"http://resource.bbgshop.com/FlkKtAq4Br-bW6SxQMtL5pkjKtNN\"><img src=\"http://resource.bbgshop.com/Foq11uC6PKYsxmmFcOtUbatbkOrZ\"><img src=\"http://resource.bbgshop.com/Fgn7InAEaAAUrtkTk6JpL6Dh0Vh1\"><img src=\"http://resource.bbgshop.com/FlvRxLMAnid-wh6S8eSMR7psIBil\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 638.00, 0, '个', 'http://resource.bbgshop.com/FuS596amHzcLHEmAFAGB-hreplOG', 'http://resource.bbgshop.com/FuS596amHzcLHEmAFAGB-hreplOG', 738.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 1, 0.00, 0.00, 0, 0, 30, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (180375, 1036031, 180375, 'APM Monaco METEORITES系列 银双流星项链', 0, 99, '', 'APM Monaco METEORITES系列 银双流星项链', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FnIit-oan6ED66HYHmVhlJK8iV5g\"><img src=\"http://resource.bbgshop.com/FsVImd8crKrQREYD-0AnPzCgR5Cj\"><img src=\"http://resource.bbgshop.com/Fl7U7U7s0q3_iQuucEr6G1bUHqUM\"><img src=\"http://resource.bbgshop.com/FlkKtAq4Br-bW6SxQMtL5pkjKtNN\"><img src=\"http://resource.bbgshop.com/Fu7liKwLWELtrmtC5ZDKC4DKt_lE\"><img src=\"http://resource.bbgshop.com/Fo8oSPC4uNa2FsOBteMOjelCjsV2\"><img src=\"http://resource.bbgshop.com/FqWIjwPQJxF4ErmIQ2Xs4NOLlkSt\"><img src=\"http://resource.bbgshop.com/FkkahII-CR2kK2-ONJU9gKdmHxiV\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FsouWhH4NPBiIC3PSXv2V0hyunMV', 'http://resource.bbgshop.com/FsouWhH4NPBiIC3PSXv2V0hyunMV', 861.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (134478, 1036031, 134478, 'APM Monaco METEORITES系列 银镶晶钻开口手镯', 0, 99, '', 'APM Monaco METEORITES系列 银镶晶钻开口手镯', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FmnejGQMrgFNK21GBozUMpOQtXVP\"><img src=\"http://resource.bbgshop.com/FrVjYvzaodgod6IRcgNA2wWS6tDS\"><img src=\"http://resource.bbgshop.com/FoM_qqOZ0KJtDM8FbQqg8sa2WXza\"><img src=\"http://resource.bbgshop.com/FpX-oDmflluzYgLSeaMjGXQzkZiH\"><img src=\"http://resource.bbgshop.com/Fri1Eagj0a24xqqB5fb0gfN3OE5N\"><img src=\"http://resource.bbgshop.com/Fr0Dy0Llbyd3D3Qs3Rt69H9_UJJ-\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fhgtb0ISwIhVyEZansdRJuXQXHlp', 'http://resource.bbgshop.com/Fhgtb0ISwIhVyEZansdRJuXQXHlp', 3068.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (113262, 1036031, 113262, 'APM Monaco METEORITES系列 银镶晶钻手镯', 0, 99, '', 'APM Monaco METEORITES系列 银镶晶钻手镯', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/Fh-EEOC_FlkiW1U2EHWNeQwskdIg\"><img src=\"http://resource.bbgshop.com/FpvFHS0LcGdNtbL6BpJAhLF8ScsE\"><img src=\"http://resource.bbgshop.com/FlkKtAq4Br-bW6SxQMtL5pkjKtNN\"><img src=\"http://resource.bbgshop.com/FlqaG0X4c2Lt3PjYsrEMQa9Mg3Qd\"><img src=\"http://resource.bbgshop.com/Flcb7NmKLNGSJgmNrCZSxfie6IoO\"><img src=\"http://resource.bbgshop.com/FlEJbiIuVrZdwY8sb0BA0whslDZC\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fj9CeVSA1QRPof66UhBsG9-G_0i9', 'http://resource.bbgshop.com/Fj9CeVSA1QRPof66UhBsG9-G_0i9', 1533.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (55647, 1036031, 55647, 'APM Monaco METEORITES系列 银镶晶钻项圈', 0, 99, '', 'APM Monaco METEORITES系列 银镶晶钻项圈', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FuAm5NlRBMeGh83O4AipbXWPbjs-\"><img src=\"http://resource.bbgshop.com/FmlQY5ASegKXVMgSoSV1Nwj6J-Uk\"><img src=\"http://resource.bbgshop.com/Fg_YfP4eXGcAzlDwDYFVHHLcgTq-\"><img src=\"http://resource.bbgshop.com/FlkKtAq4Br-bW6SxQMtL5pkjKtNN\"><img src=\"http://resource.bbgshop.com/FjPZyc-KcZIQZTv4GxDREeBXcZ6A\"><img src=\"http://resource.bbgshop.com/Ft6rgsZK69kVXUWMk6nhQNU25_Cv\"><img src=\"http://resource.bbgshop.com/FttS93FUpHWWEsGSLDj0WBuh94eT\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FjU8P3SQPMggyd5syrye4MLam3Dz', 'http://resource.bbgshop.com/FjU8P3SQPMggyd5syrye4MLam3Dz', 1988.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (86982, 1036031, 86982, 'APM Monaco FLAMENCO系列 扇形吊坠女士手链 银色', 0, 99, '', 'APM Monaco FLAMENCO系列 扇形吊坠女士手链 ', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FspJOHTQebNRTX7OJ8gdI4LZqNNw\"><img src=\"http://resource.bbgshop.com/FnfA4NcJhcnF6mZZnk_KsuTXxsz0\"><img src=\"http://resource.bbgshop.com/Fpy5SLmimRCINP3-7aby5JXGPMdl\"><img src=\"http://resource.bbgshop.com/Foqgmm4RfarO9IXfqhYGoheKiOHC\"></p>', 1, '0', 2, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FtdwkOneXsmhbXmdo04zMzMIhUUC', 'http://resource.bbgshop.com/FtdwkOneXsmhbXmdo04zMzMIhUUC', 1178.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (240350, 1036031, 240350, 'APM MONACO FLAMENCO系列 时尚女士银质镶晶钻扇形耳环', 0, 99, '', 'APM MONACO FLAMENCO系列 时尚女士银质镶晶钻扇形耳环', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FsxlAwsY0H0PJvN1Q5yo2t5FQu7Q\"><img src=\"http://resource.bbgshop.com/FkFFr-x1_CLCDVlsy5M66JCr4Vcb\"><img src=\"http://resource.bbgshop.com/Fo2NnMMtCnyOWHdM8ibL14bxX0qQ\"><img src=\"http://resource.bbgshop.com/FqdKXnfYHY9hnecbnQf7VN0558LD\"><img src=\"http://resource.bbgshop.com/FiGuFjWkOeADNRQSbEO8nlRo3WsA\"><img src=\"http://resource.bbgshop.com/FlCl7IjsDwpzUJGwXAq8uQvT9YVd\"><img src=\"http://resource.bbgshop.com/FnAlsjJooFWuglNXb0AWH34F2cUt\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 3, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/FkyfH3E_erlUPNJu6w9hHTEOTUbg', 'http://resource.bbgshop.com/FkyfH3E_erlUPNJu6w9hHTEOTUbg', 1787.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (244590, 1036031, 244590, 'APM Monaco CROISETTE系列 圣诞系列银镶晶钻戒指', 0, 99, '', 'APM Monaco CROISETTE系列 圣诞系列银镶晶钻戒指', '<p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FvkIZ6yegCMAdE-UUe58gHCE143-\"><img src=\"http://resource.bbgshop.com/FsqQGytkgYb7mqRspuN8Wn7Ta4Rv\"><img src=\"http://resource.bbgshop.com/Fn-z7TgA6BFgyRPO1FG-nRowUkuR\"><img src=\"http://resource.bbgshop.com/FrNxBjGImO7a678fNYHMIZ7Oe0bN\"><img src=\"http://resource.bbgshop.com/Fhry_onc59smF-9DvRbkSYTLbKve\"><img src=\"http://resource.bbgshop.com/FtNx6zfH-tuStFeum0SfAUPAcY7W\"></p>', 1, '0', 1, 0, 0, 0.00, 0.00, 0, '个', 'http://resource.bbgshop.com/Fp6XBrlypo7wyr1o3usrROnyN9nr', 'http://resource.bbgshop.com/Fp6XBrlypo7wyr1o3usrROnyN9nr', 1493.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '贝堡', 6, 0);
INSERT INTO `bbgshop_goods` VALUES (1528855134649776, 1036045, 1528855134649776, '零食零食零食零食零食零食零食零食零食零食零食', 0, 123, '', '零食', '<p>零食阿萨德</p>', 1, '0', 1, 0, 0, 0.00, 150.06, 1, '个', 'http://resource.bbgshop.com/FsfVl-KXPGa1RtHOJvo99QRxar18', 'http://resource.bbgshop.com/FsfVl-KXPGa1RtHOJvo99QRxar18', 123.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 1, '1533261136434', 0, 5, 15.00, 0.00, 12, 1, 0, '供货商1', 2, 0);
INSERT INTO `bbgshop_goods` VALUES (1530752944419263, 1036027, 1530752944419263, '测试添测试添测试添测试添测\n试添测试添', 0, 100, '', '测试添加商品测试添加商品测试添加商品测试添加商品测试添加商品', '<p><strong><em><s><u>测试添加商品测试添加商品测试添加商品</u></s></em></strong></p>', 1, '1530752944419', 100, 0, 0, 0.00, 0.00, 1, '件', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 9.99, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 1, '1533609021120', 5, 7, 299.00, 0.00, 0, 0, 20, '供货商3', 4, 0);
INSERT INTO `bbgshop_goods` VALUES (1534408060096423, 1036029, 1534408060096423, '123123', 0, 0, '', '123123', '<p>000</p>', 1, '1534408060096', 100, 0, 0, 0.00, 0.00, 0, '件', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 0.00, 0, 0, 0.00, NULL, NULL, NULL, NULL, 0, 0, '0', 0, 0, 0.00, 0.00, 0, 0, 0, '供货商1', 2, 0);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_goods_attribute
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_goods_attribute`;
CREATE TABLE `bbgshop_goods_attribute` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(32) unsigned NOT NULL DEFAULT '0',
  `attribute_id` int(11) unsigned NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `attr_id` (`attribute_id`)
) ENGINE=MyISAM AUTO_INCREMENT=872 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_goods_gallery
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_goods_gallery`;
CREATE TABLE `bbgshop_goods_gallery` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(32) unsigned NOT NULL DEFAULT '0',
  `img_url` varchar(255) NOT NULL DEFAULT '',
  `img_desc` varchar(255) NOT NULL DEFAULT '',
  `sort_order` int(11) unsigned NOT NULL DEFAULT '5',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1424 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_goods_gallery
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_goods_gallery` VALUES (1038, 1258, 'http://resource.bbgshop.com/FlQe2VRqwBxRa73GoS1TUNJU8CCJ', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1035, 2052, 'http://resource.bbgshop.com/Fm-ksn-QlrosIJlcK0OzMCmVk-op', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1034, 2052, 'http://resource.bbgshop.com/Fq0ElwsMJ9aaWbpHIoUgc7wAKkh0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1033, 2052, 'http://resource.bbgshop.com/FuOAYLXnMnZxuXmWODIQ6XGnBr1e', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1032, 93860, 'http://resource.bbgshop.com/Fj3Mv2Tc4XIuw9aFd3tUPOnIKeFR', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1031, 93860, 'http://resource.bbgshop.com/Fnv6TESYutYnPjfUYSmOc8vlr7MU', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1407, 813924, 'http://resource.bbgshop.com/FnCY0GzeYIsqARI-Du22UDS2FjFE', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1406, 813924, 'http://resource.bbgshop.com/Fn59tPxiK-iKXrDQww9Wy4eWCjlh', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1405, 813924, 'http://resource.bbgshop.com/FsyXN0kSguMwaDh5Ch1OShZyICKQ', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1404, 813924, 'http://resource.bbgshop.com/Focz5ai445wqeYGsa1ALSbVAAcy_', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1403, 813924, 'http://resource.bbgshop.com/Fi4KU9puIEkyNbZyKPtBdC8dO6vG', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1025, 103275, 'http://resource.bbgshop.com/FnwjuJObAsjQZxu-BUjiDf43_CO7', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1024, 83888, 'http://resource.bbgshop.com/FqlIcaa1MGGHsOo8kkKA3JqgzN8O', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1023, 2832, 'http://resource.bbgshop.com/FnXmMJdr8gpeznGGE8piCCWAldWa', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1022, 2832, 'http://resource.bbgshop.com/Fui09Ld1bD3C8J2y4S33rIKiC813', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1021, 2832, 'http://resource.bbgshop.com/FirlYqfOkY3YjF3Dve678dYUK6Oo', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1020, 284518, 'http://resource.bbgshop.com/Fo-2NPd7hkSbHZ7UkDUcaaMzK89s', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1019, 284518, 'http://resource.bbgshop.com/FnHCtTT21Lzr7EbCJt6rI_P5GHVx', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1018, 284518, 'http://resource.bbgshop.com/FglRPIx9qmpC2ZC6pkuJsr7wEVjb', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1017, 11154, 'http://resource.bbgshop.com/Fnk3VCrFRiMRYcRYPR_l5Jtymbpq', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1016, 11154, 'http://resource.bbgshop.com/Fvi_FyNuubacElbqZ2LcRhuOtxOv', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1015, 11154, 'http://resource.bbgshop.com/FpKnX3hsAiTAexvvx1Svb0DD-xzI', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1014, 104223, 'http://resource.bbgshop.com/FkO5si43g65yz3zmfGmdi4J1mPps', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1013, 104223, 'http://resource.bbgshop.com/FugO3OPFAK5eVjxmIJ5tuEA059mt', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1420, 477300, 'http://resource.bbgshop.com/FipSsYpjx0swNzpdGheFa8rV80fg', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1419, 477300, 'http://resource.bbgshop.com/FnqspZHDpqZhbWLlO1Iyn6LZcGe4', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1317, 519375, 'http://resource.bbgshop.com/FtDThAfHHdUjOqc4M-K2h2x6ayGF', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1316, 519375, 'http://resource.bbgshop.com/Flq9GMmgHMBwEn_zK6ktUiTwzzLi', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1315, 519375, 'http://resource.bbgshop.com/FumnioKXPg6CNUVZ6Sd96krzL9EL', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1007, 90706, 'http://resource.bbgshop.com/FmX0mt66F6s9GLyoWLIrRD9Tt7oc', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1398, 65621, 'http://resource.bbgshop.com/Fi1scR2PJVvBraaptdTyALvvWG6f', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1397, 65621, 'http://resource.bbgshop.com/FmMisRmpQsna-NEM5tWjIBAfyGgW', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1396, 65621, 'http://resource.bbgshop.com/FrKHsH4oeNN9J4lgJVXNiO6qB3Pk', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1360, 841662, 'http://resource.bbgshop.com/FtSyNYud1ZxMLbAM0NYhlYBKM0Qm', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1359, 841662, 'http://resource.bbgshop.com/FnUZIy4UDF3jvNuIvEAqa2mNXgMp', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1358, 841662, 'http://resource.bbgshop.com/FmCR9y9Kv-ej6uJ6ZJrWSwh_Nema', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1000, 303863, 'http://resource.bbgshop.com/Fsm2G_w04wYclJPS2ZhJjIKpvnOu', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (999, 303863, 'http://resource.bbgshop.com/FvUHxj6SeCEQivK9fQEzoOhhBneY', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (998, 303863, 'http://resource.bbgshop.com/Ftn29EDSowV9rJIiG7ikHft7fTaN', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (997, 19845, 'http://resource.bbgshop.com/FiGbJ8kmpOYSYFYDLiBr1omBp2ic', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (996, 19845, 'http://resource.bbgshop.com/Fnfa_iMg2Nia45wC6zoEmgB41Rz8', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (995, 19845, 'http://resource.bbgshop.com/FhP-MTujONWjlBHZZiqsXCX7W_5O', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (994, 250852, 'http://resource.bbgshop.com/Fj0gSql5fch9Yzk6CD7BXbsqeAwi', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (993, 250852, 'http://resource.bbgshop.com/FgwIsfNjpdEBsJP-06WhGhtihXe8', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (992, 250852, 'http://resource.bbgshop.com/FnQUYRI_8PVSQCNYsyAwtEmrLVjb', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (991, 91574, 'http://resource.bbgshop.com/FmmxxHQQCq_u_TMqjTgMACcyQfQY', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (990, 91574, 'http://resource.bbgshop.com/FpkS7mE9n5hvN_fUYquEXjCn8St_', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (989, 91574, 'http://resource.bbgshop.com/Fkqv2qntPdg4DrysuJoy3aeAfMd7', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (988, 42827, 'http://resource.bbgshop.com/FszVEwFXDs5soWXvcSNZqJA-jBbX', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (987, 42827, 'http://resource.bbgshop.com/FrJGY2hjx9h9KjcROo_3UFR1ZvSA', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (986, 42827, 'http://resource.bbgshop.com/FnrVYTv59JQfPLRyj9cevotILgNV', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (985, 267471, 'http://resource.bbgshop.com/Fpmsa22w-MGqz8hcp1krAqtSj0KZ', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (984, 267471, 'http://resource.bbgshop.com/FtUY4eWrYqWpaj59J0basDtq6Ngh', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (983, 267471, 'http://resource.bbgshop.com/Fmi-fMWH84y4uj10AAGbK0XV8AHf', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (973, 60564, 'http://resource.bbgshop.com/FjvWK6SC4D8GyXCZd_N0DgAjacLC', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (972, 60564, 'http://resource.bbgshop.com/Frh7_H_aPpLOQtJ08EUVQG5ip18a', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (971, 60564, 'http://resource.bbgshop.com/FlMsci4GyVkpA_RnlQ3Rrbox-LOz', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (982, 109248, 'http://resource.bbgshop.com/FtDtvU8_5Qr9Farfep6jOd45dXq7', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (981, 109248, 'http://resource.bbgshop.com/FrezMm1gOuTN3qJdG3DKrjN0898J', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (980, 109248, 'http://resource.bbgshop.com/FluCNBf9p_oygFABJ5hycOBO9BBi', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (967, 67743, 'http://resource.bbgshop.com/Fk_K8vXfnBCLmEgEH4XONp7AQpne', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (966, 67743, 'http://resource.bbgshop.com/Fh7dTzUI8UyHpycrcs0UwfPmVAjx', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (965, 369000, 'http://resource.bbgshop.com/FnL6Z0o75hJt9GowGwychdtmLuKA', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (964, 369000, 'http://resource.bbgshop.com/Fko7MeCyg9Fi0xXZi9x_xiMjihnG', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1392, 622336, 'http://resource.bbgshop.com/FrUsorA5Q2IPlMEQOIi2ZXpXOGtx', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1391, 622336, 'http://resource.bbgshop.com/FhWzyW6t1T-6FQF_p_-HLFEqRZMw', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (961, 369904, 'http://resource.bbgshop.com/FoG251kPV5bNp3pdamBRMy85f2JG', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (960, 369904, 'http://resource.bbgshop.com/FotPDxV8NWBe5eppQe5SS13hmi2F', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (959, 369904, 'http://resource.bbgshop.com/FqQxhL_sg5ssdHge7vKBpRG6uReJ', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (958, 141400, 'http://resource.bbgshop.com/Fj2nyUo3tkdBIFxV4W6ul1leMpgK', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (957, 141400, 'http://resource.bbgshop.com/Fhr3no5AeUtwe-RpNxd1QQJGPxTM', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (956, 141400, 'http://resource.bbgshop.com/Fh5i2yCZ5HBYqQ6ZNLgYstklrfHH', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (955, 266000, 'http://resource.bbgshop.com/Fsim7_8B1VrndrFrIsmqUPcDkBIB', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (954, 266000, 'http://resource.bbgshop.com/FqeC_VO_p0WjGlk3zuDnax3RcgrY', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (953, 196992, 'http://resource.bbgshop.com/Fg9Lf_2wWum7dDb5zqLghyWOE1xr', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (952, 196992, 'http://resource.bbgshop.com/Fpz2pQOO2acM5HR0nqeUtn_qDx2Y', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (951, 504504, 'http://resource.bbgshop.com/FqyIK-tQiUyJiIOIFN-yPM9cSfsZ', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (950, 504504, 'http://resource.bbgshop.com/FoyX8fs0fM3pyzY2mDYiuG6BqZh_', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (949, 428513, 'http://resource.bbgshop.com/FlgECeqjrU25dd7984i__LlvbRBD', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (948, 428513, 'http://resource.bbgshop.com/Fhy9sMi3uCKSiFFepYN8b2l-3uzO', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (947, 45045, 'http://resource.bbgshop.com/FrMy_SZjgfQtupLerOJbf9o9BuaP', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (946, 45045, 'http://resource.bbgshop.com/FsYPfp-czHHML3yQAuhqXf1Cg23R', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (945, 15800, 'http://resource.bbgshop.com/Ft-UcrAD8qGqvxbRD0WF2QVMJ0hs', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (944, 15800, 'http://resource.bbgshop.com/FhD1q8PeOsbVnkqAQ7dvpKE-dIih', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (943, 81405, 'http://resource.bbgshop.com/FkODGYlPgGRo6WVHJQXMP9uIRUZN', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (942, 81405, 'http://resource.bbgshop.com/FvjXiDCBDmD1XEsg1slzBmAJS8DH', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (941, 88319, 'http://resource.bbgshop.com/FjygicPCny-fPP-lBTLncjL8HTwL', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (940, 88319, 'http://resource.bbgshop.com/Fuu12WkNNnk_JbBk52qi-Hl4CnqE', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (939, 7308, 'http://resource.bbgshop.com/Fm4PoAtnfzLCEc0C5Dfiz0qEwxd2', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (938, 7308, 'http://resource.bbgshop.com/FshmFDcz96Hxb_CkiKdxq0N8iyTX', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (937, 616930, 'http://resource.bbgshop.com/FlI2V5FHJmaBkDKimdCqMxQc_He-', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (936, 616930, 'http://resource.bbgshop.com/Fhgqzb3H-v0SUDSBaoPoDOOXFhe2', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (935, 55647, 'http://resource.bbgshop.com/FjWKAXtrr2nOVsPF7qmB87cp9nY5', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (934, 55647, 'http://resource.bbgshop.com/FjU8P3SQPMggyd5syrye4MLam3Dz', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (933, 113262, 'http://resource.bbgshop.com/Fj9CeVSA1QRPof66UhBsG9-G_0i9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (932, 134478, 'http://resource.bbgshop.com/FsScUsfQ3Dw9YUNsmvu3GQ6gHm18', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (931, 134478, 'http://resource.bbgshop.com/Fhgtb0ISwIhVyEZansdRJuXQXHlp', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (930, 180375, 'http://resource.bbgshop.com/FmX021uBsvwkk9UsYcMw_iBCAi-c', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (929, 180375, 'http://resource.bbgshop.com/FsouWhH4NPBiIC3PSXv2V0hyunMV', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1046, 636004, 'http://resource.bbgshop.com/FuS596amHzcLHEmAFAGB-hreplOG', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1045, 636004, 'http://resource.bbgshop.com/FlyE9iHVlUH8c5rmnWIWmKIxnrab', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (926, 175032, 'http://resource.bbgshop.com/Fr_O9kbVQdFkMxkiSz8vgUYdyPMM', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (925, 175032, 'http://resource.bbgshop.com/FgktCIVKYPDjNL_ySro0Dy0OzD26', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (924, 175032, 'http://resource.bbgshop.com/FjL9NAbFMh__ZTRUXQt7qBRhixMX', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (923, 81204, 'http://resource.bbgshop.com/FjLQEMu724XTN_V2Z-m1PG_ao6kV', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (922, 81204, 'http://resource.bbgshop.com/FpxDvNIieoskp4ZKrme6o_vQCWTK', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (921, 81204, 'http://resource.bbgshop.com/FqWGcO6fXDin5xB7vEb00VY_g6V3', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (920, 81204, 'http://resource.bbgshop.com/FmN4NHD6YDT6hw5d8lnn69LEll20', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (919, 81204, 'http://resource.bbgshop.com/FtuK3MaMcB-wxy32-9b1AWzMo43p', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (918, 19647, 'http://resource.bbgshop.com/Fg7yGS8twEj09TbFiDEAzUM6uhQE', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (917, 19647, 'http://resource.bbgshop.com/FtTLQS6kqgy6qEHZaPNfodCfDu0J', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (916, 240350, 'http://resource.bbgshop.com/FslfbOUnfU9Tpr-65FRutvLcGuMC', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (915, 240350, 'http://resource.bbgshop.com/FkyfH3E_erlUPNJu6w9hHTEOTUbg', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (914, 86982, 'http://resource.bbgshop.com/FhxBPfad0Z5pBW5MM8khhcMRgiaA', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (910, 40757, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (909, 40757, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (908, 40757, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (913, 86982, 'http://resource.bbgshop.com/FtdwkOneXsmhbXmdo04zMzMIhUUC', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (912, 244590, 'http://resource.bbgshop.com/Fv9RzkK7GkiT2wBAyFwZwqWyQT5l', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (911, 244590, 'http://resource.bbgshop.com/Fp6XBrlypo7wyr1o3usrROnyN9nr', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (901, 19992, 'http://p6dsy7wb1.bkt.clouddn.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (900, 19992, 'http://p6dsy7wb1.bkt.clouddn.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (899, 19992, 'http://p6dsy7wb1.bkt.clouddn.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (898, 215922, 'http://p6dsy7wb1.bkt.clouddn.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (897, 215922, 'http://p6dsy7wb1.bkt.clouddn.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (896, 215922, 'http://p6dsy7wb1.bkt.clouddn.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1050, 651495, 'http://resource.bbgshop.com/Fn1oDXOhlqEro7Y2WHPx4u5jI7St', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1049, 13420, 'http://resource.bbgshop.com/Fn1oDXOhlqEro7Y2WHPx4u5jI7St', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1051, 1524043362592641, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1058, 1524043689881842, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1053, 1524043760833163, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1056, 1524285675004370, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1055, 1524302054945321, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1057, 1524448977762965, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1059, 15254143629539, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1060, 15254143629539, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1061, 15254143629539, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1065, 1525506079804257, 'http://resource.bbgshop.com/Flq9W1Jk6ZS6AFD3Fb9ccAqrWN0E', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1067, 1526709239314870, 'http://resource.bbgshop.com/FsfVl-KXPGa1RtHOJvo99QRxar18', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1071, 1527312668458729, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1412, 1528855134649776, 'http://resource.bbgshop.com/FsfVl-KXPGa1RtHOJvo99QRxar18', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1080, 1529917141865313, 'http://resource.bbgshop.com/Flq9W1Jk6ZS6AFD3Fb9ccAqrWN0E', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1081, 1529917349523867, 'http://resource.bbgshop.com/Flq9W1Jk6ZS6AFD3Fb9ccAqrWN0E', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1082, 1529917389673191, 'http://resource.bbgshop.com/Flq9W1Jk6ZS6AFD3Fb9ccAqrWN0E', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1329, 152991759190674, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1092, 1530175338457488, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1091, 1530175338457488, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1328, 152991759190674, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1327, 152991759190674, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1422, 1530752944419263, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1421, 1530752944419263, 'http://resource.bbgshop.com/FmEfHXw7GYG9GKwT8hz083oupEv9', '', 5);
INSERT INTO `bbgshop_goods_gallery` VALUES (1423, 1534408060096423, 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', '', 5);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_goods_issue
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_goods_issue`;
CREATE TABLE `bbgshop_goods_issue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(32) DEFAULT NULL,
  `question` varchar(255) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_goods_issue
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_goods_issue` VALUES (1, 0, '购买运费如何收取？', '在小程序上下单没有运费！！哼，不是老板说的，是程序员说的。');
INSERT INTO `bbgshop_goods_issue` VALUES (2, 0, '使用什么快递发货？', '默认使用顺丰快递发货（个别商品使用其他快递），配送范围覆盖全国大部分地区（港澳台地区除外巴拉巴拉小巴拉）');
INSERT INTO `bbgshop_goods_issue` VALUES (3, 0, '如何申请退货？', '暂时没有退货入口，请确认后下单。两个礼拜就想让我做一个完完整整的项目，哼，我又不是神。');
INSERT INTO `bbgshop_goods_issue` VALUES (4, 0, '如何开具发票？', '如果要开发票的，请联系贝堡网络科技有限公司——开发票办事处。');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_goods_specification
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_goods_specification`;
CREATE TABLE `bbgshop_goods_specification` (
  `id` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(32) unsigned NOT NULL DEFAULT '0',
  `specification_id` int(11) unsigned NOT NULL DEFAULT '0',
  `value` varchar(50) NOT NULL DEFAULT '',
  `pic_url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`),
  KEY `specification_id` (`specification_id`)
) ENGINE=MyISAM AUTO_INCREMENT=571 DEFAULT CHARSET=utf8mb4 COMMENT='商品对应规格表值表';

-- ----------------------------
-- Records of bbgshop_goods_specification
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_goods_specification` VALUES (288, 1258, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (287, 2052, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (286, 93860, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (566, 1530752944419263, 69, '1.1KG', '');
INSERT INTO `bbgshop_goods_specification` VALUES (284, 103275, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (283, 83888, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (282, 2832, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (281, 284518, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (280, 11154, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (279, 104223, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (569, 477300, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (513, 519375, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (276, 90706, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (275, 65621, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (568, 841662, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (273, 303863, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (272, 19845, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (271, 250852, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (270, 91574, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (269, 42827, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (268, 267471, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (267, 60564, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (266, 109248, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (265, 67743, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (264, 369000, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (263, 622336, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (262, 369904, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (261, 141400, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (260, 266000, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (259, 196992, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (258, 504504, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (257, 428513, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (256, 45045, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (255, 15800, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (254, 81405, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (253, 88319, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (252, 7308, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (251, 616930, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (250, 55647, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (249, 113262, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (248, 134478, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (247, 180375, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (246, 636004, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (245, 175032, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (244, 81204, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (243, 19647, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (239, 40757, 40, '1.25M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (238, 40757, 38, '绿色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (242, 240350, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (241, 86982, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (240, 244590, 41, '正常', '');
INSERT INTO `bbgshop_goods_specification` VALUES (234, 19992, 40, 'Big', '');
INSERT INTO `bbgshop_goods_specification` VALUES (233, 19992, 38, '蓝色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (232, 19992, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (231, 215922, 40, 'Small', '');
INSERT INTO `bbgshop_goods_specification` VALUES (230, 215922, 40, 'Big', '');
INSERT INTO `bbgshop_goods_specification` VALUES (229, 215922, 39, '1.75M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (228, 215922, 39, '1.25M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (227, 215922, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (298, 651495, 42, '123', '');
INSERT INTO `bbgshop_goods_specification` VALUES (299, 651495, 42, '234', '');
INSERT INTO `bbgshop_goods_specification` VALUES (297, 13420, 38, '2354', '');
INSERT INTO `bbgshop_goods_specification` VALUES (296, 13420, 38, '123', '');
INSERT INTO `bbgshop_goods_specification` VALUES (300, 1524043362592641, 45, '2354345', '');
INSERT INTO `bbgshop_goods_specification` VALUES (316, 1524043689881842, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (302, 1524043760833163, 47, '345', '');
INSERT INTO `bbgshop_goods_specification` VALUES (311, 1524285675004370, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (304, 1524302054945321, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (305, 1524302054945321, 38, '白色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (306, 1524302054945321, 38, '灰色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (307, 1524302054945321, 39, '1.8M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (308, 1524302054945321, 39, '1.2M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (309, 1524302054945321, 48, '128G SSD', '');
INSERT INTO `bbgshop_goods_specification` VALUES (310, 1524302054945321, 48, '256G SSD', '');
INSERT INTO `bbgshop_goods_specification` VALUES (312, 1524285675004370, 38, '白色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (313, 1524285675004370, 40, '1.1M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (314, 1524285675004370, 40, '6.3M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (315, 1524448977762965, 41, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (317, 15254143629539, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (337, 1527312668458729, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (336, 1526709239314870, 50, '萨达f', '');
INSERT INTO `bbgshop_goods_specification` VALUES (335, 1525506079804257, 40, '1.2M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (334, 1525506079804257, 38, '白色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (333, 1525506079804257, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (338, 1527312668458729, 38, '白色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (339, 1527312668458729, 40, '很大', '');
INSERT INTO `bbgshop_goods_specification` VALUES (565, 1530752944419263, 39, '1.5M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (341, 1529917141865313, 51, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (342, 1529917349523867, 51, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (343, 1529917389673191, 51, '常规', '');
INSERT INTO `bbgshop_goods_specification` VALUES (430, 813924, 41, '常规14', '');
INSERT INTO `bbgshop_goods_specification` VALUES (428, 813924, 41, '常规12', '');
INSERT INTO `bbgshop_goods_specification` VALUES (564, 1530752944419263, 39, '1.1M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (532, 152991759190674, 39, '1.5M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (531, 152991759190674, 39, '1.2M', '');
INSERT INTO `bbgshop_goods_specification` VALUES (530, 152991759190674, 38, '黑色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (529, 152991759190674, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (528, 152991759190674, 38, '白色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (429, 813924, 41, '常规13', '');
INSERT INTO `bbgshop_goods_specification` VALUES (563, 1530752944419263, 38, '绿色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (562, 1530752944419263, 38, '白色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (548, 1528855134649776, 62, '测试规格1.255', '');
INSERT INTO `bbgshop_goods_specification` VALUES (547, 1528855134649776, 62, '测试规格1.3', '');
INSERT INTO `bbgshop_goods_specification` VALUES (546, 1528855134649776, 62, '测试规格1.4', '');
INSERT INTO `bbgshop_goods_specification` VALUES (545, 1528855134649776, 62, '测试规格1.5', '');
INSERT INTO `bbgshop_goods_specification` VALUES (561, 1530752944419263, 38, '黄色', '');
INSERT INTO `bbgshop_goods_specification` VALUES (570, 1534408060096423, 41, '常规', '');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_guide
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_guide`;
CREATE TABLE `bbgshop_guide` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `type` int(2) NOT NULL,
  `rules_text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_guide
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_guide` VALUES (1, 1, '<h1 class=\"ql-align-center\">新手指南</h1><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\">当您再使用过程会有任何问题请联系balabalablabal</p>');
INSERT INTO `bbgshop_guide` VALUES (3, 2, '<p class=\"ql-align-center\">dfgh<sub>bs</sub><sup>dfg</sup></p><p class=\"ql-align-center\"><sup>IUJGH <strong><em><s><u>aisdpA</u></s></em></strong></sup><sub><strong><em><s><u>SUGJH阿坚实</u></s></em></strong></sub><sup><strong><em><s><u>的f;jha dh;Hoh</u></s></em></strong></sup><sub><strong><em><s><u> OI </u></s></em></strong>HO</sub></p><h2 class=\"ql-align-center\"><sub>ASDF加大好多华盛顿fhsdfas</sub></h2><h1 class=\"ql-align-center\"><sub>df 花 <u>生 </u><s><u>豆</u></s></sub><sup><s>腐 阿</s></sup></h1><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\"><img src=\"http://resource.bbgshop.com/FsazhBO64GF47Ioe6sw0DCWY39wk\"></p><p class=\"ql-align-center\"><br></p><p class=\"ql-align-center\">123</p><h2 class=\"ql-align-center\">H2H2H2</h2><h1 class=\"ql-align-center\">H1 H<sub>1 H1H1H1</sub><sup> H1 H1H</sup><em>1</em></h1><h1 class=\"ql-align-center\"><br></h1><h1 class=\"ql-align-center\">H1 H1 H1H1</h1><p class=\"ql-align-center\"><br></p>');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_keywords
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_keywords`;
CREATE TABLE `bbgshop_keywords` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(90) NOT NULL DEFAULT '',
  `is_hot` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_default` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `sort_order` int(11) unsigned NOT NULL DEFAULT '100',
  PRIMARY KEY (`keyword`,`id`),
  KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='热闹关键词表';

-- ----------------------------
-- Records of bbgshop_keywords
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_keywords` VALUES (2, '施华洛世奇', 1, 0, 1, 8);
INSERT INTO `bbgshop_keywords` VALUES (3, '手环', 0, 0, 1, 5);
INSERT INTO `bbgshop_keywords` VALUES (4, '手链', 0, 0, 1, 100);
INSERT INTO `bbgshop_keywords` VALUES (5, '零食', 0, 0, 1, 100);
INSERT INTO `bbgshop_keywords` VALUES (6, '面膜', 0, 0, 1, 100);
INSERT INTO `bbgshop_keywords` VALUES (7, '饼干', 0, 0, 1, 100);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_luckdraw
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_luckdraw`;
CREATE TABLE `bbgshop_luckdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abled` int(2) NOT NULL DEFAULT '0',
  `luck_goods_id` bigint(32) NOT NULL DEFAULT '0',
  `luck_people_num` int(11) NOT NULL DEFAULT '0',
  `luck_goods_num` int(11) NOT NULL DEFAULT '0',
  `luck_create_time` varchar(32) NOT NULL DEFAULT '0',
  `luck_limit_time` varchar(32) NOT NULL DEFAULT '0',
  `luck_open_time` varchar(32) NOT NULL DEFAULT '0',
  `luck_goods_detail` varchar(6555) NOT NULL,
  `luck_goods_name` varchar(256) NOT NULL DEFAULT '0',
  `luck_goods_pic` varchar(256) NOT NULL DEFAULT '0',
  `luck_goods_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `have_join_people_num` int(11) NOT NULL DEFAULT '0',
  `is_del` int(2) NOT NULL DEFAULT '0',
  `is_out_time` int(2) NOT NULL DEFAULT '0',
  `is_open` int(2) NOT NULL DEFAULT '0',
  `luck_draw_user_id` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_luckdraw
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_luckdraw` VALUES (28, 1, 1530752944419263, 2, 1, '1533957349762', '1534551607795', '1534637607795', '<p><strong><em><s><u>测试添加商品测试添加商品测试添加商品</u></s></em></strong></p>', '测试添测试添测试添测试添测\n试添测试添', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 9.99, 1, 0, 0, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_luckdraw_user
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_luckdraw_user`;
CREATE TABLE `bbgshop_luckdraw_user` (
  `id` bigint(24) NOT NULL AUTO_INCREMENT,
  `luckdraw_main_id` int(11) NOT NULL DEFAULT '0',
  `join_user_id` int(11) NOT NULL DEFAULT '0',
  `join_user_nickname` varchar(128) NOT NULL DEFAULT '0',
  `join_user_avatar` varchar(256) NOT NULL DEFAULT '0',
  `join_user_openid` varchar(256) NOT NULL DEFAULT '0',
  `is_del` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_luckdraw_user
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_luckdraw_user` VALUES (34, 28, 42, '余生与诗 ', 'https://wx.qlogo.cn/mmopen/vi_32/h9YpuwGibvfD8dBC1UbicjPRxNYObn1oa2sdzbUqdOIf0ggibibvO5OjWtah73gTKlOZiaMe3ZuM5lib1AVS3gy5XibPQ/132', 'oJ-tr5QMA-A8Udc8ejjYmG9VvFyA', 0);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_order
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_order`;
CREATE TABLE `bbgshop_order` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(20) NOT NULL DEFAULT '',
  `user_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `order_status` int(3) unsigned NOT NULL DEFAULT '0',
  `shipping_status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `consignee` varchar(60) NOT NULL DEFAULT '',
  `country` smallint(5) unsigned NOT NULL DEFAULT '0',
  `province` smallint(5) unsigned NOT NULL DEFAULT '0',
  `city` smallint(5) unsigned NOT NULL DEFAULT '0',
  `district` smallint(5) unsigned NOT NULL DEFAULT '0',
  `address` varchar(255) NOT NULL DEFAULT '',
  `mobile` varchar(60) NOT NULL DEFAULT '',
  `postscript` varchar(255) NOT NULL DEFAULT '',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `pay_name` varchar(120) NOT NULL DEFAULT '',
  `pay_id` tinyint(3) NOT NULL DEFAULT '0',
  `actual_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实际需要支付的金额',
  `integral` int(10) unsigned NOT NULL DEFAULT '0',
  `integral_money` decimal(10,2) NOT NULL DEFAULT '0.00',
  `order_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单总价',
  `goods_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品总价',
  `user_level_discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `add_time` varchar(32) NOT NULL DEFAULT '0',
  `confirm_time` int(11) unsigned NOT NULL DEFAULT '0',
  `pay_time` varchar(32) NOT NULL DEFAULT '0',
  `freight_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '配送费用',
  `coupon_id` varchar(32) NOT NULL DEFAULT '0' COMMENT '使用的优惠券id',
  `parent_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `coupon_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `callback_status` enum('true','false') DEFAULT 'true',
  `is_comment` int(3) NOT NULL DEFAULT '0',
  `is_shange_price` int(3) NOT NULL DEFAULT '0',
  `admin_message` varchar(255) NOT NULL DEFAULT '',
  `collage_is_success` int(1) NOT NULL DEFAULT '0',
  `collage_type` int(1) NOT NULL DEFAULT '0' COMMENT '拼团的类型，0为发起者，1为拼团者',
  `refund_is_success` int(1) NOT NULL DEFAULT '0',
  `is_del` int(1) NOT NULL DEFAULT '0',
  `logistics_time` varchar(32) NOT NULL DEFAULT '0',
  `confirLogic_time` varchar(32) NOT NULL DEFAULT '0',
  `refund_time` varchar(32) NOT NULL DEFAULT '0',
  `collage_isouttime` int(2) NOT NULL DEFAULT '0',
  `luckdraw_id` int(11) NOT NULL DEFAULT '0',
  `change_price_num` int(11) NOT NULL DEFAULT '0',
  `Identity_Input` varchar(32) NOT NULL DEFAULT '0' COMMENT '用户的身份证信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_sn` (`order_sn`),
  KEY `user_id` (`user_id`),
  KEY `order_status` (`order_status`),
  KEY `shipping_status` (`shipping_status`),
  KEY `pay_status` (`pay_status`),
  KEY `pay_id` (`pay_id`)
) ENGINE=MyISAM AUTO_INCREMENT=722 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_order
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_order` VALUES (714, '20180813132928336907', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 949.53, 0, 0.00, 1031.37, 1023.00, 81.84, '1534138168126', 0, '0', 8.37, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534383132536', '0', 0, 0, 0, '');
INSERT INTO `bbgshop_order` VALUES (713, '20180813132726441673', 42, 300, 0, 0, '123123', 0, 3, 38, 423, '123123', '15358975705', '', 0.00, '', 0, 678.96, 0, 0.00, 738.00, 738.00, 59.04, '1534138046678', 0, '0', 0.00, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534383188159', '0', 0, 0, 0, '');
INSERT INTO `bbgshop_order` VALUES (712, '20180813132644183025', 42, 300, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 221.28, 0, 0.00, 240.00, 234.00, 18.72, '1534138004510', 0, '0', 6.00, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534383775485', '0', 0, 0, 0, '');
INSERT INTO `bbgshop_order` VALUES (711, '20180813132354543065', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 419.52, 0, 0.00, 456.00, 456.00, 36.48, '1534137834613', 0, '0', 0.00, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534404273651', '0', 0, 0, 0, '320282199701282612');
INSERT INTO `bbgshop_order` VALUES (709, '20180811112407772283', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 351.00, 0, 0.00, 351.00, 468.00, 0.00, '1533957847075', 0, '0', 6.00, '7N5EW8EKAJH', 0, 123.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534406221054', '0', 0, 0, 0, '320282199701282612');
INSERT INTO `bbgshop_order` VALUES (710, '20180813131927831456', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 3876.41, 0, 0.00, 4206.01, 4120.01, 329.60, '1534137567149', 0, '0', 86.00, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534404188194', '0', 0, 0, 0, '320282199701282612');
INSERT INTO `bbgshop_order` VALUES (719, '20180815125202901146', 42, 301, 0, 0, '123123', 0, 3, 38, 423, '123123', '15358975705', '', 0.00, '', 0, 18.30, 0, 0.00, 129.00, 123.00, 110.70, '1534308722553', 0, '0', 6.00, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534405964813', '0', 0, 0, 0, '');
INSERT INTO `bbgshop_order` VALUES (706, '20180811103320941034', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 576.00, 0, 0.00, 576.00, 576.00, 0.00, '1533954800904', 0, '0', 0.00, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534387044935', '0', 0, 0, 0, '320282199701282612');
INSERT INTO `bbgshop_order` VALUES (707, '20180811103729508162', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 129.00, 0, 0.00, 129.00, 123.00, 0.00, '1533955049976', 0, '0', 6.00, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534384337986', '0', 0, 0, 0, '');
INSERT INTO `bbgshop_order` VALUES (715, '20180813132953410388', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 949.53, 0, 0.00, 1031.37, 1023.00, 81.84, '1534138193759', 0, '0', 8.37, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534383155975', '0', 0, 0, 0, '');
INSERT INTO `bbgshop_order` VALUES (716, '20180813133004613008', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 949.53, 0, 0.00, 1031.37, 1023.00, 81.84, '1534138204356', 0, '0', 8.37, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534382957433', '0', 0, 0, 0, '');
INSERT INTO `bbgshop_order` VALUES (717, '20180813141603201926', 42, 301, 0, 0, '123123', 0, 3, 38, 423, '123123', '15358975705', '', 0.00, '', 0, 323.40, 0, 0.00, 351.00, 345.00, 27.60, '1534140963507', 0, '0', 6.00, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '1534382597361', '0', 0, 0, 0, '');
INSERT INTO `bbgshop_order` VALUES (718, '20180813142850383873', 42, 201, 0, 0, '123123', 0, 3, 38, 423, '123123', '15358975705', '', 0.00, '拼团订单(Initiator)', 2, 0.01, 0, 0.00, 0.01, 9.99, 0.00, '1534141730904', 0, '1534141746882', 0.00, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '0', '0', '0', 1, 0, 0, '0');
INSERT INTO `bbgshop_order` VALUES (720, '20180815134405383547', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 0.01, 0, 0.00, 0.02, 0.01, 0.01, '1534311845119', 0, '1534311859575', 0.01, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 1, 0, '0', '0', '1534311938074', 0, 0, 0, '320282199701282612');
INSERT INTO `bbgshop_order` VALUES (721, '20180816092445905728', 42, 301, 0, 0, '123123', 0, 3, 38, 422, '123123', '15358975705', '', 0.00, '', 0, 0.02, 0, 0.00, 0.02, 0.01, 0.00, '1534382685922', 0, '1534382704303', 0.01, '0', 0, 0.00, 'true', 0, 0, '', 0, 0, 0, 0, '1534382759374', '1534382770941', '0', 0, 0, 0, '320282199701282612');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_order_express
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_order_express`;
CREATE TABLE `bbgshop_order_express` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(32) unsigned NOT NULL DEFAULT '0',
  `shipper_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `shipper_name` varchar(120) NOT NULL DEFAULT '' COMMENT '物流公司名称',
  `shipper_code` varchar(60) NOT NULL DEFAULT '' COMMENT '物流公司代码',
  `logistic_code` varchar(20) NOT NULL DEFAULT '' COMMENT '快递单号',
  `traces` varchar(2000) NOT NULL DEFAULT '' COMMENT '物流跟踪信息',
  `is_finish` tinyint(1) NOT NULL DEFAULT '0',
  `request_count` int(11) DEFAULT '0' COMMENT '总查询次数',
  `request_time` int(11) DEFAULT '0' COMMENT '最近一次向第三方查询物流信息时间',
  `add_time` varchar(32) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(32) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COMMENT='订单物流信息表，发货时生成';

-- ----------------------------
-- Records of bbgshop_order_express
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_order_express` VALUES (44, 721, 2, '百世快递', 'HTKY', '1234123412341234', '[]', 0, 1, 1534382761, '1534382759370', 1534382761);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_order_goods`;
CREATE TABLE `bbgshop_order_goods` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `goods_id` bigint(32) unsigned NOT NULL DEFAULT '0',
  `goods_name` varchar(120) NOT NULL DEFAULT '',
  `goods_sn` varchar(60) NOT NULL DEFAULT '',
  `product_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `number` smallint(5) unsigned NOT NULL DEFAULT '1',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `retail_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `goods_specifition_name_value` text NOT NULL,
  `is_real` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `goods_specifition_ids` varchar(255) NOT NULL DEFAULT '',
  `list_pic_url` varchar(255) DEFAULT '',
  `supplier_id` int(8) NOT NULL DEFAULT '0',
  `add_time` varchar(32) NOT NULL DEFAULT '0',
  `is_Identity` int(2) NOT NULL DEFAULT '0',
  `Identity_Input` varchar(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `goods_id` (`goods_id`)
) ENGINE=MyISAM AUTO_INCREMENT=851 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_order_goods
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_order_goods` VALUES (839, 710, 813924, '【直邮】Swarovski 施华洛世奇蓝调多色球手链', 'F8139242', 579, 1, 234.00, 234.00, '常规14', 0, '430', 'http://resource.bbgshop.com/FnCY0GzeYIsqARI-Du22UDS2FjFE', 6, '1534137567181', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (840, 711, 1530752944419263, '测试添测试添测试添测试添测\n试添测试添', 'T15307529444192633', 727, 1, 456.00, 456.00, '白色;1.5M;1.1KG', 0, '562_565_566', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 4, '1534137834621', 1, '320282199701282612');
INSERT INTO `bbgshop_order_goods` VALUES (841, 712, 813924, '【直邮】Swarovski 施华洛世奇蓝调多色球手链', 'F8139242', 579, 1, 234.00, 234.00, '常规14', 0, '430', 'http://resource.bbgshop.com/FnCY0GzeYIsqARI-Du22UDS2FjFE', 6, '1534138004516', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (830, 706, 1530752944419263, '测试添测试添测试添测试添测\n试添测试添', 'T15307529444192634', 728, 1, 576.00, 576.00, '绿色;1.1M;1.1KG', 0, '563_564_566', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 4, '1533954800923', 1, '320282199701282612');
INSERT INTO `bbgshop_order_goods` VALUES (831, 707, 813924, '【直邮】Swarovski 施华洛世奇蓝调多色球手链', 'F8139240', 577, 1, 123.00, 123.00, '常规12', 0, '428', 'http://resource.bbgshop.com/FnCY0GzeYIsqARI-Du22UDS2FjFE', 6, '1533955049985', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (850, 721, 477300, '【直邮】Swarovski 施华洛世奇花园 项链 绿色', 'F4773000', 732, 1, 0.01, 0.01, '常规', 0, '569', 'http://resource.bbgshop.com/FshUJeYiSp4-3OsTcXCBeVuqFKui', 6, '1534382685932', 1, '320282199701282612');
INSERT INTO `bbgshop_order_goods` VALUES (833, 709, 1528855134649776, '零食零食零食零食零食零食零食零食零食零食零食', 'F15288551346497763', 711, 1, 123.00, 123.00, '测试规格1.255', 0, '548', 'http://resource.bbgshop.com/FsfVl-KXPGa1RtHOJvo99QRxar18', 2, '1533957847095', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (834, 709, 1530752944419263, '测试添测试添测试添测试添测\n试添测试添', 'T15307529444192632', 726, 1, 345.00, 345.00, '白色;1.1M;1.1KG', 0, '562_564_566', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 4, '1533957847095', 1, '320282199701282612');
INSERT INTO `bbgshop_order_goods` VALUES (835, 710, 1528855134649776, '零食零食零食零食零食零食零食零食零食零食零食', 'F15288551346497763', 711, 1, 123.00, 123.00, '测试规格1.255', 0, '548', 'http://resource.bbgshop.com/FsfVl-KXPGa1RtHOJvo99QRxar18', 2, '1534137567181', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (836, 710, 813924, '【直邮】Swarovski 施华洛世奇蓝调多色球手链', 'F8139240', 577, 1, 123.00, 123.00, '常规12', 0, '428', 'http://resource.bbgshop.com/FnCY0GzeYIsqARI-Du22UDS2FjFE', 6, '1534137567181', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (837, 710, 477300, '【直邮】Swarovski 施华洛世奇花园 项链 绿色', 'F4773000', 732, 1, 0.01, 0.01, '常规', 0, '569', 'http://resource.bbgshop.com/FshUJeYiSp4-3OsTcXCBeVuqFKui', 6, '1534137567181', 1, '320282199701282612');
INSERT INTO `bbgshop_order_goods` VALUES (838, 710, 65621, '【直邮】Swarovski 施华洛世奇 十二星座项链女天蝎座2017灵动锁骨链', 'F656210', 495, 5, 728.00, 728.00, '常规', 0, '275', 'http://resource.bbgshop.com/Fi1scR2PJVvBraaptdTyALvvWG6f', 6, '1534137567181', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (842, 713, 636004, 'APM Monaco METEORITES系列 银双流星手链', 'F6360040', 466, 1, 738.00, 738.00, '常规', 0, '246', 'http://resource.bbgshop.com/FuS596amHzcLHEmAFAGB-hreplOG', 6, '1534138046687', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (843, 714, 622336, 'APM Monaco 黑色镶晶钻流星手镯星星', 'F6223360', 483, 1, 1023.00, 1023.00, '常规', 0, '263', 'http://resource.bbgshop.com/FrUsorA5Q2IPlMEQOIi2ZXpXOGtx', 6, '1534138168131', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (844, 715, 622336, 'APM Monaco 黑色镶晶钻流星手镯星星', 'F6223360', 483, 1, 1023.00, 1023.00, '常规', 0, '263', 'http://resource.bbgshop.com/FrUsorA5Q2IPlMEQOIi2ZXpXOGtx', 6, '1534138193766', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (845, 716, 622336, 'APM Monaco 黑色镶晶钻流星手镯星星', 'F6223360', 483, 1, 1023.00, 1023.00, '常规', 0, '263', 'http://resource.bbgshop.com/FrUsorA5Q2IPlMEQOIi2ZXpXOGtx', 6, '1534138204360', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (846, 717, 1528855134649776, '零食零食零食零食零食零食零食零食零食零食零食', 'F15288551346497762', 710, 1, 345.00, 345.00, '测试规格1.3', 0, '547', 'http://resource.bbgshop.com/FsfVl-KXPGa1RtHOJvo99QRxar18', 2, '1534140963522', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (847, 718, 1530752944419263, '测试添测试添测试添测试添测\n试添测试添', 'T15307529444192630', 724, 1, 0.01, 0.01, '1.1KG　1.1M　黄色', 0, '561_564_566', 'http://resource.bbgshop.com/Fkenpb2x3ZM3msRYyf1s0dQ69X-0', 0, '0', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (848, 719, 813924, '【直邮】Swarovski 施华洛世奇蓝调多色球手链', 'F8139240', 577, 1, 123.00, 123.00, '常规12', 0, '428', 'http://resource.bbgshop.com/FnCY0GzeYIsqARI-Du22UDS2FjFE', 6, '1534308722571', 0, '0');
INSERT INTO `bbgshop_order_goods` VALUES (849, 720, 477300, '【直邮】Swarovski 施华洛世奇花园 项链 绿色', 'F4773000', 732, 1, 0.01, 0.01, '常规', 0, '569', 'http://resource.bbgshop.com/FshUJeYiSp4-3OsTcXCBeVuqFKui', 6, '1534311845134', 1, '320282199701282612');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_order_refund
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_order_refund`;
CREATE TABLE `bbgshop_order_refund` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(16) NOT NULL,
  `state` int(4) NOT NULL DEFAULT '0',
  `type` int(2) NOT NULL DEFAULT '0' COMMENT '类型0为未发货退款 1为发货退款',
  `order_sn` varchar(20) NOT NULL DEFAULT '0',
  `refund_sn` varchar(30) NOT NULL DEFAULT '0',
  `refund_price` varchar(10) NOT NULL DEFAULT '0',
  `reson` text NOT NULL,
  `way_index` int(2) NOT NULL DEFAULT '0',
  `way_value` varchar(64) NOT NULL DEFAULT '',
  `reson_index` int(2) NOT NULL DEFAULT '0',
  `reson_value` varchar(64) NOT NULL DEFAULT '',
  `order_price` varchar(10) NOT NULL DEFAULT '0',
  `refund_img` text,
  `back_state` int(3) NOT NULL DEFAULT '0',
  `state_text` varchar(10) DEFAULT NULL,
  `creat_time` varchar(32) NOT NULL DEFAULT '0',
  `del_time` varchar(32) NOT NULL DEFAULT '0',
  `abled` int(2) NOT NULL DEFAULT '0',
  `handle_time` varchar(32) NOT NULL DEFAULT '0',
  `rerund_num` int(5) NOT NULL DEFAULT '0',
  `isRefund` int(3) NOT NULL DEFAULT '0',
  `refund_time` varchar(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_order_refund
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_order_refund` VALUES (79, 42, 503, 0, '20180815134405383547', '20180815134428L4U34BUNFRB', '0.01', '', 0, '全额退款', 0, '拍错商品', '0.01', NULL, 201, '退款成功', '1534311868119', '0', 0, '0', 0, 1, '1534311938072');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_product
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_product`;
CREATE TABLE `bbgshop_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(32) unsigned NOT NULL DEFAULT '0',
  `goods_specification_ids` varchar(50) NOT NULL DEFAULT '',
  `goods_sn` varchar(60) NOT NULL DEFAULT '',
  `goods_number` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `retail_price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=734 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_product
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_product` VALUES (508, 1258, '288', 'F12580', 99, 0.01);
INSERT INTO `bbgshop_product` VALUES (507, 2052, '287', 'F20520', 99, 728.00);
INSERT INTO `bbgshop_product` VALUES (506, 93860, '286', 'F938600', 99, 829.00);
INSERT INTO `bbgshop_product` VALUES (577, 813924, '428', 'F8139240', 332, 123.00);
INSERT INTO `bbgshop_product` VALUES (504, 103275, '284', 'F1032750', 98, 709.00);
INSERT INTO `bbgshop_product` VALUES (503, 83888, '283', 'F838880', 98, 709.00);
INSERT INTO `bbgshop_product` VALUES (502, 2832, '282', 'F28320', 98, 709.00);
INSERT INTO `bbgshop_product` VALUES (501, 284518, '281', 'F2845180', 99, 999.00);
INSERT INTO `bbgshop_product` VALUES (500, 11154, '280', 'F111540', 99, 709.00);
INSERT INTO `bbgshop_product` VALUES (499, 104223, '279', 'F1042230', 96, 949.00);
INSERT INTO `bbgshop_product` VALUES (732, 477300, '569', 'F4773000', 72, 0.01);
INSERT INTO `bbgshop_product` VALUES (673, 519375, '513', 'F5193750', 97209, 839.00);
INSERT INTO `bbgshop_product` VALUES (496, 90706, '276', 'F907060', 98, 709.00);
INSERT INTO `bbgshop_product` VALUES (495, 65621, '275', 'F656210', 95, 728.00);
INSERT INTO `bbgshop_product` VALUES (731, 841662, '568', 'F8416620', 79, 728.23);
INSERT INTO `bbgshop_product` VALUES (493, 303863, '273', 'F3038630', 99, 728.00);
INSERT INTO `bbgshop_product` VALUES (492, 19845, '272', 'F198450', 99, 728.00);
INSERT INTO `bbgshop_product` VALUES (491, 250852, '271', 'F2508520', 99, 728.00);
INSERT INTO `bbgshop_product` VALUES (490, 91574, '270', 'F915740', 99, 728.00);
INSERT INTO `bbgshop_product` VALUES (489, 42827, '269', 'F428270', 99, 699.00);
INSERT INTO `bbgshop_product` VALUES (488, 267471, '268', 'F2674710', 99, 699.00);
INSERT INTO `bbgshop_product` VALUES (487, 60564, '267', 'F605640', 99, 799.00);
INSERT INTO `bbgshop_product` VALUES (486, 109248, '266', 'F1092480', 99, 709.00);
INSERT INTO `bbgshop_product` VALUES (485, 67743, '265', 'F677430', 98, 661.00);
INSERT INTO `bbgshop_product` VALUES (484, 369000, '264', 'F3690000', 93, 1170.00);
INSERT INTO `bbgshop_product` VALUES (483, 622336, '263', 'F6223360', 89, 1023.00);
INSERT INTO `bbgshop_product` VALUES (482, 369904, '262', 'F3699040', 92, 661.00);
INSERT INTO `bbgshop_product` VALUES (481, 141400, '261', 'F1414000', 98, 1170.00);
INSERT INTO `bbgshop_product` VALUES (480, 266000, '260', 'F2660000', 99, 908.00);
INSERT INTO `bbgshop_product` VALUES (479, 196992, '259', 'F1969920', 99, 738.00);
INSERT INTO `bbgshop_product` VALUES (478, 504504, '258', 'F5045040', 97, 445.00);
INSERT INTO `bbgshop_product` VALUES (477, 428513, '257', 'F4285130', 99, 962.00);
INSERT INTO `bbgshop_product` VALUES (476, 45045, '256', 'F450450', 99, 1039.00);
INSERT INTO `bbgshop_product` VALUES (475, 15800, '255', 'F158000', 99, 1062.00);
INSERT INTO `bbgshop_product` VALUES (474, 81405, '254', 'F814050', 97, 908.00);
INSERT INTO `bbgshop_product` VALUES (473, 88319, '253', 'F883190', 97, 923.00);
INSERT INTO `bbgshop_product` VALUES (472, 7308, '252', 'F73080', 98, 1047.00);
INSERT INTO `bbgshop_product` VALUES (471, 616930, '251', 'F6169300', 99, 1787.00);
INSERT INTO `bbgshop_product` VALUES (470, 55647, '250', 'F556470', 99, 1988.00);
INSERT INTO `bbgshop_product` VALUES (469, 113262, '249', 'F1132620', 99, 1533.00);
INSERT INTO `bbgshop_product` VALUES (468, 134478, '248', 'F1344780', 99, 3068.00);
INSERT INTO `bbgshop_product` VALUES (467, 180375, '247', 'F1803750', 99, 861.00);
INSERT INTO `bbgshop_product` VALUES (466, 636004, '246', 'F6360040', 90, 738.00);
INSERT INTO `bbgshop_product` VALUES (465, 175032, '245', 'F1750320', 99, 730.00);
INSERT INTO `bbgshop_product` VALUES (464, 81204, '244', 'F812040', 99, 460.00);
INSERT INTO `bbgshop_product` VALUES (463, 19647, '243', 'F196470', 99, 480.00);
INSERT INTO `bbgshop_product` VALUES (462, 240350, '242', 'F2403500', 99, 1787.00);
INSERT INTO `bbgshop_product` VALUES (459, 40757, '238_239', 'S407570', 123, 123.00);
INSERT INTO `bbgshop_product` VALUES (461, 86982, '241', 'F869820', 99, 1178.00);
INSERT INTO `bbgshop_product` VALUES (460, 244590, '240', 'F2445900', 99, 1493.00);
INSERT INTO `bbgshop_product` VALUES (456, 19992, '233_234', 'S199921', 0, 123.00);
INSERT INTO `bbgshop_product` VALUES (455, 19992, '232_234', 'S199920', 123, 123.00);
INSERT INTO `bbgshop_product` VALUES (454, 215922, '227_229_231', 'T2159223', 456, 456.00);
INSERT INTO `bbgshop_product` VALUES (453, 215922, '227_229_230', 'T2159222', 345, 345.00);
INSERT INTO `bbgshop_product` VALUES (452, 215922, '227_228_231', 'T2159221', 234, 234.00);
INSERT INTO `bbgshop_product` VALUES (451, 215922, '227_228_230', 'T2159220', 123, 123.00);
INSERT INTO `bbgshop_product` VALUES (518, 651495, '298', 'F6514950', 234, 123.00);
INSERT INTO `bbgshop_product` VALUES (519, 651495, '299', 'F6514951', 234, 123.00);
INSERT INTO `bbgshop_product` VALUES (517, 13420, '297', 'F134201', 99, 1234.00);
INSERT INTO `bbgshop_product` VALUES (516, 13420, '296', 'F134200', 99, 1234.00);
INSERT INTO `bbgshop_product` VALUES (520, 1524043760833163, '302', 'F15240437608331630', 35, 35.00);
INSERT INTO `bbgshop_product` VALUES (534, 1524285675004370, '311_313', 'S15242856750043700', 99, 123.00);
INSERT INTO `bbgshop_product` VALUES (522, 1524302054945321, '304_307_309', 'T15243020549453210', 99, 123.00);
INSERT INTO `bbgshop_product` VALUES (523, 1524302054945321, '304_307_310', 'T15243020549453211', 99, 234.00);
INSERT INTO `bbgshop_product` VALUES (524, 1524302054945321, '304_308_309', 'T15243020549453212', 99, 235.00);
INSERT INTO `bbgshop_product` VALUES (525, 1524302054945321, '304_308_310', 'T15243020549453213', 99, 456.00);
INSERT INTO `bbgshop_product` VALUES (526, 1524302054945321, '305_307_309', 'T15243020549453214', 99, 567.00);
INSERT INTO `bbgshop_product` VALUES (527, 1524302054945321, '305_307_310', 'T15243020549453215', 99, 678.00);
INSERT INTO `bbgshop_product` VALUES (528, 1524302054945321, '305_308_309', 'T15243020549453216', 99, 789.00);
INSERT INTO `bbgshop_product` VALUES (529, 1524302054945321, '305_308_310', 'T15243020549453217', 99, 890.00);
INSERT INTO `bbgshop_product` VALUES (530, 1524302054945321, '306_307_309', 'T15243020549453218', 99, 2356.00);
INSERT INTO `bbgshop_product` VALUES (531, 1524302054945321, '306_307_310', 'T15243020549453219', 99, 367.00);
INSERT INTO `bbgshop_product` VALUES (532, 1524302054945321, '306_308_309', 'T152430205494532110', 99, 567.00);
INSERT INTO `bbgshop_product` VALUES (533, 1524302054945321, '306_308_310', 'T152430205494532111', 99, 6780.00);
INSERT INTO `bbgshop_product` VALUES (535, 1524285675004370, '311_314', 'S15242856750043701', 99, 234.00);
INSERT INTO `bbgshop_product` VALUES (536, 1524285675004370, '312_313', 'S15242856750043702', 99, 354.00);
INSERT INTO `bbgshop_product` VALUES (537, 1524285675004370, '312_314', 'S15242856750043703', 99, 466.00);
INSERT INTO `bbgshop_product` VALUES (538, 1524448977762965, '315', 'F15244489777629650', 999, 123.00);
INSERT INTO `bbgshop_product` VALUES (539, 1524043689881842, '316', 'F15240436898818420', 94, 999.00);
INSERT INTO `bbgshop_product` VALUES (540, 15254143629539, '317', 'F152541436295390', 95, 128.00);
INSERT INTO `bbgshop_product` VALUES (559, 1527312668458729, '338_339', 'S15273126684587291', 997, 253.00);
INSERT INTO `bbgshop_product` VALUES (558, 1527312668458729, '337_339', 'S15273126684587290', 999, 128.00);
INSERT INTO `bbgshop_product` VALUES (557, 1526709239314870, '336', 'F15267092393148700', 1184, 0.01);
INSERT INTO `bbgshop_product` VALUES (556, 1525506079804257, '334_335', 'S15255060798042571', 449, 345.00);
INSERT INTO `bbgshop_product` VALUES (555, 1525506079804257, '333_335', 'S15255060798042570', 230, 123.00);
INSERT INTO `bbgshop_product` VALUES (561, 1529917141865313, '341', 'F15299171418653130', 999, 125.00);
INSERT INTO `bbgshop_product` VALUES (562, 1529917349523867, '342', 'F15299173495238670', 999, 125.00);
INSERT INTO `bbgshop_product` VALUES (563, 1529917389673191, '343', 'F15299173896731910', 999, 0.01);
INSERT INTO `bbgshop_product` VALUES (578, 813924, '429', 'F8139241', 343, 123.00);
INSERT INTO `bbgshop_product` VALUES (566, 1530175338457488, '346_349_351', 'T15301753384574880', 112131, 112131.00);
INSERT INTO `bbgshop_product` VALUES (567, 1530175338457488, '346_350_351', 'T15301753384574881', 112231, 112231.00);
INSERT INTO `bbgshop_product` VALUES (568, 1530175338457488, '347_349_351', 'T15301753384574882', 122131, 122131.00);
INSERT INTO `bbgshop_product` VALUES (569, 1530175338457488, '347_350_351', 'T15301753384574883', 122231, 122231.00);
INSERT INTO `bbgshop_product` VALUES (570, 1530175338457488, '348_349_351', 'T15301753384574884', 132131, 132131.00);
INSERT INTO `bbgshop_product` VALUES (571, 1530175338457488, '348_350_351', 'T15301753384574885', 132231, 132231.00);
INSERT INTO `bbgshop_product` VALUES (579, 813924, '430', 'F8139242', 48, 234.00);
INSERT INTO `bbgshop_product` VALUES (729, 1530752944419263, '563_565_566', 'T15307529444192635', 995, 8667.00);
INSERT INTO `bbgshop_product` VALUES (728, 1530752944419263, '563_564_566', 'T15307529444192634', 996, 576.00);
INSERT INTO `bbgshop_product` VALUES (727, 1530752944419263, '562_565_566', 'T15307529444192633', 992, 456.00);
INSERT INTO `bbgshop_product` VALUES (726, 1530752944419263, '562_564_566', 'T15307529444192632', 987, 345.00);
INSERT INTO `bbgshop_product` VALUES (725, 1530752944419263, '561_565_566', 'T15307529444192631', 997, 234.00);
INSERT INTO `bbgshop_product` VALUES (724, 1530752944419263, '561_564_566', 'T15307529444192630', 979, 0.01);
INSERT INTO `bbgshop_product` VALUES (711, 1528855134649776, '548', 'F15288551346497763', 110, 123.00);
INSERT INTO `bbgshop_product` VALUES (695, 152991759190674, '530_532', 'S1529917591906745', 999, 0.06);
INSERT INTO `bbgshop_product` VALUES (694, 152991759190674, '530_531', 'S1529917591906744', 999, 0.05);
INSERT INTO `bbgshop_product` VALUES (693, 152991759190674, '529_532', 'S1529917591906743', 999, 0.04);
INSERT INTO `bbgshop_product` VALUES (692, 152991759190674, '529_531', 'S1529917591906742', 999, 0.03);
INSERT INTO `bbgshop_product` VALUES (691, 152991759190674, '528_532', 'S1529917591906741', 999, 0.02);
INSERT INTO `bbgshop_product` VALUES (690, 152991759190674, '528_531', 'S1529917591906740', 999, 0.01);
INSERT INTO `bbgshop_product` VALUES (710, 1528855134649776, '547', 'F15288551346497762', 339, 345.00);
INSERT INTO `bbgshop_product` VALUES (709, 1528855134649776, '546', 'F15288551346497761', 452, 456.00);
INSERT INTO `bbgshop_product` VALUES (708, 1528855134649776, '545', 'F15288551346497760', 560, 567.00);
INSERT INTO `bbgshop_product` VALUES (733, 1534408060096423, '570', 'F15344080600964230', 0, 0.00);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_rechange_order
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_rechange_order`;
CREATE TABLE `bbgshop_rechange_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(32) NOT NULL DEFAULT '0',
  `add_time` varchar(32) NOT NULL DEFAULT '0',
  `rechange_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `pay_status` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_rechange_order
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_rechange_order` VALUES (27, '20180813110149', '1534129309852', 12.23, 42, 0);
INSERT INTO `bbgshop_rechange_order` VALUES (28, '20180813110837', '1534129717486', 0.01, 42, 0);
INSERT INTO `bbgshop_rechange_order` VALUES (29, '20180813110846', '1534129726430', 0.01, 42, 0);
INSERT INTO `bbgshop_rechange_order` VALUES (30, '20180813110905', '1534129745695', 0.01, 42, 1);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_region
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_region`;
CREATE TABLE `bbgshop_region` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `name` varchar(120) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '2',
  `agency_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `region_type` (`type`),
  KEY `agency_id` (`agency_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4044 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_region
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_region` VALUES (1, 0, '中国', 0, 0);
INSERT INTO `bbgshop_region` VALUES (2, 1, '北京', 1, 0);
INSERT INTO `bbgshop_region` VALUES (3, 1, '天津', 1, 0);
INSERT INTO `bbgshop_region` VALUES (4, 1, '河北省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (5, 1, '山西省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (6, 1, '内蒙古自治区', 1, 0);
INSERT INTO `bbgshop_region` VALUES (7, 1, '辽宁省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (8, 1, '吉林省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (9, 1, '黑龙江省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (10, 1, '上海', 1, 0);
INSERT INTO `bbgshop_region` VALUES (11, 1, '江苏省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (12, 1, '浙江省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (13, 1, '安徽省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (14, 1, '福建省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (15, 1, '江西省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (16, 1, '山东省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (17, 1, '河南省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (18, 1, '湖北省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (19, 1, '湖南省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (20, 1, '广东省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (21, 1, '广西壮族自治区', 1, 0);
INSERT INTO `bbgshop_region` VALUES (22, 1, '海南省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (23, 1, '重庆', 1, 0);
INSERT INTO `bbgshop_region` VALUES (24, 1, '四川省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (25, 1, '贵州省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (26, 1, '云南省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (27, 1, '西藏自治区', 1, 0);
INSERT INTO `bbgshop_region` VALUES (28, 1, '陕西省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (29, 1, '甘肃省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (30, 1, '青海省', 1, 0);
INSERT INTO `bbgshop_region` VALUES (31, 1, '宁夏回族自治区', 1, 0);
INSERT INTO `bbgshop_region` VALUES (32, 1, '新疆维吾尔自治区', 1, 0);
INSERT INTO `bbgshop_region` VALUES (33, 1, '台湾', 1, 0);
INSERT INTO `bbgshop_region` VALUES (34, 1, '香港特别行政区', 1, 0);
INSERT INTO `bbgshop_region` VALUES (35, 1, '澳门特别行政区', 1, 0);
INSERT INTO `bbgshop_region` VALUES (36, 1, '海外', 1, 0);
INSERT INTO `bbgshop_region` VALUES (37, 2, '北京市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (38, 3, '天津市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (39, 4, '石家庄市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (40, 4, '唐山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (41, 4, '秦皇岛市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (42, 4, '邯郸市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (43, 4, '邢台市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (44, 4, '保定市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (45, 4, '张家口市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (46, 4, '承德市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (47, 4, '沧州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (48, 4, '廊坊市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (49, 4, '衡水市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (50, 5, '太原市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (51, 5, '大同市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (52, 5, '阳泉市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (53, 5, '长治市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (54, 5, '晋城市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (55, 5, '朔州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (56, 5, '晋中市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (57, 5, '运城市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (58, 5, '忻州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (59, 5, '临汾市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (60, 5, '吕梁市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (61, 6, '呼和浩特市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (62, 6, '包头市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (63, 6, '乌海市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (64, 6, '赤峰市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (65, 6, '通辽市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (66, 6, '鄂尔多斯市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (67, 6, '呼伦贝尔市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (68, 6, '巴彦淖尔市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (69, 6, '乌兰察布市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (70, 6, '兴安盟', 2, 0);
INSERT INTO `bbgshop_region` VALUES (71, 6, '锡林郭勒盟', 2, 0);
INSERT INTO `bbgshop_region` VALUES (72, 6, '阿拉善盟', 2, 0);
INSERT INTO `bbgshop_region` VALUES (73, 7, '沈阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (74, 7, '大连市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (75, 7, '鞍山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (76, 7, '抚顺市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (77, 7, '本溪市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (78, 7, '丹东市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (79, 7, '锦州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (80, 7, '营口市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (81, 7, '阜新市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (82, 7, '辽阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (83, 7, '盘锦市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (84, 7, '铁岭市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (85, 7, '朝阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (86, 7, '葫芦岛市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (87, 8, '长春市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (88, 8, '吉林市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (89, 8, '四平市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (90, 8, '辽源市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (91, 8, '通化市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (92, 8, '白山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (93, 8, '松原市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (94, 8, '白城市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (95, 8, '延边朝鲜族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (96, 9, '哈尔滨市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (97, 9, '齐齐哈尔市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (98, 9, '鸡西市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (99, 9, '鹤岗市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (100, 9, '双鸭山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (101, 9, '大庆市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (102, 9, '伊春市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (103, 9, '佳木斯市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (104, 9, '七台河市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (105, 9, '牡丹江市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (106, 9, '黑河市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (107, 9, '绥化市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (108, 9, '大兴安岭地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (109, 10, '上海市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (110, 11, '南京市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (111, 11, '无锡市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (112, 11, '徐州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (113, 11, '常州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (114, 11, '苏州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (115, 11, '南通市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (116, 11, '连云港市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (117, 11, '淮安市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (118, 11, '盐城市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (119, 11, '扬州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (120, 11, '镇江市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (121, 11, '泰州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (122, 11, '宿迁市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (123, 12, '杭州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (124, 12, '宁波市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (125, 12, '温州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (126, 12, '嘉兴市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (127, 12, '湖州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (128, 12, '绍兴市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (129, 12, '金华市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (130, 12, '衢州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (131, 12, '舟山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (132, 12, '台州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (133, 12, '丽水市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (134, 13, '合肥市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (135, 13, '芜湖市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (136, 13, '蚌埠市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (137, 13, '淮南市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (138, 13, '马鞍山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (139, 13, '淮北市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (140, 13, '铜陵市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (141, 13, '安庆市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (142, 13, '黄山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (143, 13, '滁州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (144, 13, '阜阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (145, 13, '宿州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (146, 13, '六安市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (147, 13, '亳州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (148, 13, '池州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (149, 13, '宣城市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (150, 14, '福州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (151, 14, '厦门市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (152, 14, '莆田市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (153, 14, '三明市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (154, 14, '泉州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (155, 14, '漳州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (156, 14, '南平市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (157, 14, '龙岩市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (158, 14, '宁德市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (159, 15, '南昌市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (160, 15, '景德镇市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (161, 15, '萍乡市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (162, 15, '九江市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (163, 15, '新余市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (164, 15, '鹰潭市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (165, 15, '赣州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (166, 15, '吉安市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (167, 15, '宜春市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (168, 15, '抚州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (169, 15, '上饶市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (170, 16, '济南市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (171, 16, '青岛市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (172, 16, '淄博市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (173, 16, '枣庄市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (174, 16, '东营市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (175, 16, '烟台市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (176, 16, '潍坊市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (177, 16, '济宁市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (178, 16, '泰安市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (179, 16, '威海市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (180, 16, '日照市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (181, 16, '莱芜市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (182, 16, '临沂市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (183, 16, '德州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (184, 16, '聊城市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (185, 16, '滨州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (186, 16, '菏泽市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (187, 17, '郑州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (188, 17, '开封市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (189, 17, '洛阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (190, 17, '平顶山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (191, 17, '安阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (192, 17, '鹤壁市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (193, 17, '新乡市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (194, 17, '焦作市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (195, 17, '濮阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (196, 17, '许昌市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (197, 17, '漯河市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (198, 17, '三门峡市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (199, 17, '南阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (200, 17, '商丘市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (201, 17, '信阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (202, 17, '周口市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (203, 17, '驻马店市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (204, 18, '武汉市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (205, 18, '黄石市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (206, 18, '十堰市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (207, 18, '宜昌市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (208, 18, '襄阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (209, 18, '鄂州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (210, 18, '荆门市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (211, 18, '孝感市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (212, 18, '荆州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (213, 18, '黄冈市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (214, 18, '咸宁市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (215, 18, '随州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (216, 18, '恩施土家族苗族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (217, 19, '长沙市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (218, 19, '株洲市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (219, 19, '湘潭市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (220, 19, '衡阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (221, 19, '邵阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (222, 19, '岳阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (223, 19, '常德市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (224, 19, '张家界市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (225, 19, '益阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (226, 19, '郴州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (227, 19, '永州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (228, 19, '怀化市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (229, 19, '娄底市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (230, 19, '湘西土家族苗族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (231, 20, '广州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (232, 20, '韶关市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (233, 20, '深圳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (234, 20, '珠海市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (235, 20, '汕头市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (236, 20, '佛山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (237, 20, '江门市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (238, 20, '湛江市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (239, 20, '茂名市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (240, 20, '肇庆市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (241, 20, '惠州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (242, 20, '梅州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (243, 20, '汕尾市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (244, 20, '河源市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (245, 20, '阳江市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (246, 20, '清远市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (247, 20, '东莞市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (248, 20, '中山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (249, 20, '东沙群岛', 2, 0);
INSERT INTO `bbgshop_region` VALUES (250, 20, '潮州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (251, 20, '揭阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (252, 20, '云浮市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (253, 21, '南宁市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (254, 21, '柳州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (255, 21, '桂林市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (256, 21, '梧州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (257, 21, '北海市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (258, 21, '防城港市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (259, 21, '钦州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (260, 21, '贵港市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (261, 21, '玉林市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (262, 21, '百色市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (263, 21, '贺州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (264, 21, '河池市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (265, 21, '来宾市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (266, 21, '崇左市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (267, 22, '海口市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (268, 22, '三亚市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (269, 22, '三沙市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (270, 23, '重庆市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (271, 24, '成都市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (272, 24, '自贡市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (273, 24, '攀枝花市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (274, 24, '泸州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (275, 24, '德阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (276, 24, '绵阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (277, 24, '广元市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (278, 24, '遂宁市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (279, 24, '内江市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (280, 24, '乐山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (281, 24, '南充市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (282, 24, '眉山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (283, 24, '宜宾市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (284, 24, '广安市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (285, 24, '达州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (286, 24, '雅安市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (287, 24, '巴中市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (288, 24, '资阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (289, 24, '阿坝藏族羌族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (290, 24, '甘孜藏族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (291, 24, '凉山彝族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (292, 25, '贵阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (293, 25, '六盘水市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (294, 25, '遵义市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (295, 25, '安顺市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (296, 25, '铜仁市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (297, 25, '黔西南布依族苗族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (298, 25, '毕节市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (299, 25, '黔东南苗族侗族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (300, 25, '黔南布依族苗族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (301, 26, '昆明市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (302, 26, '曲靖市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (303, 26, '玉溪市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (304, 26, '保山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (305, 26, '昭通市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (306, 26, '丽江市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (307, 26, '普洱市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (308, 26, '临沧市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (309, 26, '楚雄彝族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (310, 26, '红河哈尼族彝族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (311, 26, '文山壮族苗族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (312, 26, '西双版纳傣族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (313, 26, '大理白族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (314, 26, '德宏傣族景颇族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (315, 26, '怒江傈僳族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (316, 26, '迪庆藏族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (317, 27, '拉萨市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (318, 27, '昌都市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (319, 27, '山南地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (320, 27, '日喀则市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (321, 27, '那曲地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (322, 27, '阿里地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (323, 27, '林芝市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (324, 28, '西安市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (325, 28, '铜川市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (326, 28, '宝鸡市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (327, 28, '咸阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (328, 28, '渭南市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (329, 28, '延安市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (330, 28, '汉中市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (331, 28, '榆林市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (332, 28, '安康市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (333, 28, '商洛市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (334, 29, '兰州市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (335, 29, '嘉峪关市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (336, 29, '金昌市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (337, 29, '白银市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (338, 29, '天水市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (339, 29, '武威市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (340, 29, '张掖市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (341, 29, '平凉市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (342, 29, '酒泉市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (343, 29, '庆阳市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (344, 29, '定西市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (345, 29, '陇南市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (346, 29, '临夏回族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (347, 29, '甘南藏族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (348, 30, '西宁市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (349, 30, '海东市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (350, 30, '海北藏族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (351, 30, '黄南藏族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (352, 30, '海南藏族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (353, 30, '果洛藏族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (354, 30, '玉树藏族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (355, 30, '海西蒙古族藏族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (356, 31, '银川市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (357, 31, '石嘴山市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (358, 31, '吴忠市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (359, 31, '固原市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (360, 31, '中卫市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (361, 32, '乌鲁木齐市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (362, 32, '克拉玛依市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (363, 32, '吐鲁番市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (364, 32, '哈密地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (365, 32, '昌吉回族自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (366, 32, '博尔塔拉蒙古自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (367, 32, '巴音郭楞蒙古自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (368, 32, '阿克苏地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (369, 32, '克孜勒苏柯尔克孜自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (370, 32, '喀什地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (371, 32, '和田地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (372, 32, '伊犁哈萨克自治州', 2, 0);
INSERT INTO `bbgshop_region` VALUES (373, 32, '塔城地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (374, 32, '阿勒泰地区', 2, 0);
INSERT INTO `bbgshop_region` VALUES (375, 33, '台北市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (376, 33, '高雄市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (377, 33, '台南市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (378, 33, '台中市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (379, 33, '金门县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (380, 33, '南投县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (381, 33, '基隆市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (382, 33, '新竹市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (383, 33, '嘉义市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (384, 33, '新北市', 2, 0);
INSERT INTO `bbgshop_region` VALUES (385, 33, '宜兰县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (386, 33, '新竹县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (387, 33, '桃园县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (388, 33, '苗栗县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (389, 33, '彰化县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (390, 33, '嘉义县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (391, 33, '云林县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (392, 33, '屏东县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (393, 33, '台东县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (394, 33, '花莲县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (395, 33, '澎湖县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (396, 33, '连江县', 2, 0);
INSERT INTO `bbgshop_region` VALUES (397, 34, '香港岛', 2, 0);
INSERT INTO `bbgshop_region` VALUES (398, 34, '九龙', 2, 0);
INSERT INTO `bbgshop_region` VALUES (399, 34, '新界', 2, 0);
INSERT INTO `bbgshop_region` VALUES (400, 35, '澳门半岛', 2, 0);
INSERT INTO `bbgshop_region` VALUES (401, 35, '离岛', 2, 0);
INSERT INTO `bbgshop_region` VALUES (402, 36, '海外', 2, 0);
INSERT INTO `bbgshop_region` VALUES (403, 37, '东城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (404, 37, '西城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (405, 37, '崇文区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (406, 37, '宣武区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (407, 37, '朝阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (408, 37, '丰台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (409, 37, '石景山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (410, 37, '海淀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (411, 37, '门头沟区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (412, 37, '房山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (413, 37, '通州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (414, 37, '顺义区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (415, 37, '昌平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (416, 37, '大兴区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (417, 37, '怀柔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (418, 37, '平谷区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (419, 37, '密云县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (420, 37, '延庆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (421, 37, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (422, 38, '和平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (423, 38, '河东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (424, 38, '河西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (425, 38, '南开区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (426, 38, '河北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (427, 38, '红桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (428, 38, '塘沽区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (429, 38, '汉沽区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (430, 38, '大港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (431, 38, '东丽区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (432, 38, '西青区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (433, 38, '津南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (434, 38, '北辰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (435, 38, '武清区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (436, 38, '宝坻区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (437, 38, '滨海新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (438, 38, '宁河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (439, 38, '静海县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (440, 38, '蓟县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (441, 38, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (442, 39, '长安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (443, 39, '桥东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (444, 39, '桥西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (445, 39, '新华区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (446, 39, '井陉矿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (447, 39, '裕华区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (448, 39, '井陉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (449, 39, '正定县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (450, 39, '栾城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (451, 39, '行唐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (452, 39, '灵寿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (453, 39, '高邑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (454, 39, '深泽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (455, 39, '赞皇县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (456, 39, '无极县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (457, 39, '平山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (458, 39, '元氏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (459, 39, '赵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (460, 39, '辛集市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (461, 39, '藁城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (462, 39, '晋州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (463, 39, '新乐市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (464, 39, '鹿泉区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (465, 39, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (466, 40, '路南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (467, 40, '路北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (468, 40, '古冶区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (469, 40, '开平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (470, 40, '丰南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (471, 40, '丰润区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (472, 40, '滦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (473, 40, '滦南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (474, 40, '乐亭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (475, 40, '迁西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (476, 40, '玉田县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (477, 40, '曹妃甸区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (478, 40, '遵化市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (479, 40, '迁安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (480, 40, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (481, 41, '海港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (482, 41, '山海关区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (483, 41, '北戴河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (484, 41, '青龙满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (485, 41, '昌黎县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (486, 41, '抚宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (487, 41, '卢龙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (488, 41, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (489, 41, '经济技术开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (490, 42, '邯山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (491, 42, '丛台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (492, 42, '复兴区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (493, 42, '峰峰矿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (494, 42, '邯郸县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (495, 42, '临漳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (496, 42, '成安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (497, 42, '大名县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (498, 42, '涉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (499, 42, '磁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (500, 42, '肥乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (501, 42, '永年县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (502, 42, '邱县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (503, 42, '鸡泽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (504, 42, '广平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (505, 42, '馆陶县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (506, 42, '魏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (507, 42, '曲周县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (508, 42, '武安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (509, 42, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (510, 43, '桥东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (511, 43, '桥西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (512, 43, '邢台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (513, 43, '临城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (514, 43, '内丘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (515, 43, '柏乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (516, 43, '隆尧县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (517, 43, '任县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (518, 43, '南和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (519, 43, '宁晋县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (520, 43, '巨鹿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (521, 43, '新河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (522, 43, '广宗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (523, 43, '平乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (524, 43, '威县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (525, 43, '清河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (526, 43, '临西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (527, 43, '南宫市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (528, 43, '沙河市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (529, 43, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (530, 44, '新市区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (531, 44, '北市区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (532, 44, '南市区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (533, 44, '满城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (534, 44, '清苑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (535, 44, '涞水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (536, 44, '阜平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (537, 44, '徐水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (538, 44, '定兴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (539, 44, '唐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (540, 44, '高阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (541, 44, '容城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (542, 44, '涞源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (543, 44, '望都县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (544, 44, '安新县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (545, 44, '易县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (546, 44, '曲阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (547, 44, '蠡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (548, 44, '顺平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (549, 44, '博野县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (550, 44, '雄县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (551, 44, '涿州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (552, 44, '定州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (553, 44, '安国市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (554, 44, '高碑店市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (555, 44, '高开区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (556, 44, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (557, 45, '桥东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (558, 45, '桥西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (559, 45, '宣化区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (560, 45, '下花园区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (561, 45, '宣化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (562, 45, '张北县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (563, 45, '康保县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (564, 45, '沽源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (565, 45, '尚义县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (566, 45, '蔚县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (567, 45, '阳原县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (568, 45, '怀安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (569, 45, '万全县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (570, 45, '怀来县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (571, 45, '涿鹿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (572, 45, '赤城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (573, 45, '崇礼县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (574, 45, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (575, 46, '双桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (576, 46, '双滦区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (577, 46, '鹰手营子矿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (578, 46, '承德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (579, 46, '兴隆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (580, 46, '平泉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (581, 46, '滦平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (582, 46, '隆化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (583, 46, '丰宁满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (584, 46, '宽城满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (585, 46, '围场满族蒙古族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (586, 46, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (587, 47, '新华区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (588, 47, '运河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (589, 47, '沧县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (590, 47, '青县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (591, 47, '东光县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (592, 47, '海兴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (593, 47, '盐山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (594, 47, '肃宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (595, 47, '南皮县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (596, 47, '吴桥县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (597, 47, '献县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (598, 47, '孟村回族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (599, 47, '泊头市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (600, 47, '任丘市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (601, 47, '黄骅市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (602, 47, '河间市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (603, 47, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (604, 48, '安次区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (605, 48, '广阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (606, 48, '固安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (607, 48, '永清县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (608, 48, '香河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (609, 48, '大城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (610, 48, '文安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (611, 48, '大厂回族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (612, 48, '开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (613, 48, '燕郊经济技术开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (614, 48, '霸州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (615, 48, '三河市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (616, 48, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (617, 49, '桃城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (618, 49, '枣强县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (619, 49, '武邑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (620, 49, '武强县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (621, 49, '饶阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (622, 49, '安平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (623, 49, '故城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (624, 49, '景县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (625, 49, '阜城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (626, 49, '冀州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (627, 49, '深州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (628, 49, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (629, 50, '小店区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (630, 50, '迎泽区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (631, 50, '杏花岭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (632, 50, '尖草坪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (633, 50, '万柏林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (634, 50, '晋源区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (635, 50, '清徐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (636, 50, '阳曲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (637, 50, '娄烦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (638, 50, '古交市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (639, 50, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (640, 51, '城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (641, 51, '矿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (642, 51, '南郊区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (643, 51, '新荣区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (644, 51, '阳高县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (645, 51, '天镇县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (646, 51, '广灵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (647, 51, '灵丘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (648, 51, '浑源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (649, 51, '左云县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (650, 51, '大同县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (651, 51, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (652, 52, '城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (653, 52, '矿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (654, 52, '郊区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (655, 52, '平定县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (656, 52, '盂县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (657, 52, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (658, 53, '长治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (659, 53, '襄垣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (660, 53, '屯留县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (661, 53, '平顺县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (662, 53, '黎城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (663, 53, '壶关县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (664, 53, '长子县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (665, 53, '武乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (666, 53, '沁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (667, 53, '沁源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (668, 53, '潞城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (669, 53, '城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (670, 53, '郊区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (671, 53, '高新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (672, 53, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (673, 54, '城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (674, 54, '沁水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (675, 54, '阳城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (676, 54, '陵川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (677, 54, '泽州县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (678, 54, '高平市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (679, 54, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (680, 55, '朔城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (681, 55, '平鲁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (682, 55, '山阴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (683, 55, '应县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (684, 55, '右玉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (685, 55, '怀仁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (686, 55, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (687, 56, '榆次区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (688, 56, '榆社县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (689, 56, '左权县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (690, 56, '和顺县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (691, 56, '昔阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (692, 56, '寿阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (693, 56, '太谷县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (694, 56, '祁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (695, 56, '平遥县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (696, 56, '灵石县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (697, 56, '介休市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (698, 56, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (699, 57, '盐湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (700, 57, '临猗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (701, 57, '万荣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (702, 57, '闻喜县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (703, 57, '稷山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (704, 57, '新绛县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (705, 57, '绛县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (706, 57, '垣曲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (707, 57, '夏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (708, 57, '平陆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (709, 57, '芮城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (710, 57, '永济市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (711, 57, '河津市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (712, 57, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (713, 58, '忻府区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (714, 58, '定襄县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (715, 58, '五台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (716, 58, '代县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (717, 58, '繁峙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (718, 58, '宁武县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (719, 58, '静乐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (720, 58, '神池县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (721, 58, '五寨县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (722, 58, '岢岚县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (723, 58, '河曲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (724, 58, '保德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (725, 58, '偏关县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (726, 58, '原平市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (727, 58, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (728, 59, '尧都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (729, 59, '曲沃县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (730, 59, '翼城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (731, 59, '襄汾县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (732, 59, '洪洞县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (733, 59, '古县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (734, 59, '安泽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (735, 59, '浮山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (736, 59, '吉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (737, 59, '乡宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (738, 59, '大宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (739, 59, '隰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (740, 59, '永和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (741, 59, '蒲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (742, 59, '汾西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (743, 59, '侯马市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (744, 59, '霍州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (745, 59, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (746, 60, '离石区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (747, 60, '文水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (748, 60, '交城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (749, 60, '兴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (750, 60, '临县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (751, 60, '柳林县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (752, 60, '石楼县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (753, 60, '岚县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (754, 60, '方山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (755, 60, '中阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (756, 60, '交口县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (757, 60, '孝义市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (758, 60, '汾阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (759, 60, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (760, 61, '新城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (761, 61, '回民区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (762, 61, '玉泉区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (763, 61, '赛罕区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (764, 61, '土默特左旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (765, 61, '托克托县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (766, 61, '和林格尔县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (767, 61, '清水河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (768, 61, '武川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (769, 61, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (770, 62, '东河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (771, 62, '昆都仑区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (772, 62, '青山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (773, 62, '石拐区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (774, 62, '白云鄂博矿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (775, 62, '九原区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (776, 62, '土默特右旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (777, 62, '固阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (778, 62, '达尔罕茂明安联合旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (779, 62, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (780, 63, '海勃湾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (781, 63, '海南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (782, 63, '乌达区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (783, 63, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (784, 64, '红山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (785, 64, '元宝山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (786, 64, '松山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (787, 64, '阿鲁科尔沁旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (788, 64, '巴林左旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (789, 64, '巴林右旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (790, 64, '林西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (791, 64, '克什克腾旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (792, 64, '翁牛特旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (793, 64, '喀喇沁旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (794, 64, '宁城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (795, 64, '敖汉旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (796, 64, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (797, 65, '科尔沁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (798, 65, '科尔沁左翼中旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (799, 65, '科尔沁左翼后旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (800, 65, '开鲁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (801, 65, '库伦旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (802, 65, '奈曼旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (803, 65, '扎鲁特旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (804, 65, '霍林郭勒市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (805, 65, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (806, 66, '东胜区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (807, 66, '达拉特旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (808, 66, '准格尔旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (809, 66, '鄂托克前旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (810, 66, '鄂托克旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (811, 66, '杭锦旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (812, 66, '乌审旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (813, 66, '伊金霍洛旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (814, 66, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (815, 67, '海拉尔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (816, 67, '扎赉诺尔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (817, 67, '阿荣旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (818, 67, '莫力达瓦达斡尔族自治旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (819, 67, '鄂伦春自治旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (820, 67, '鄂温克族自治旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (821, 67, '陈巴尔虎旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (822, 67, '新巴尔虎左旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (823, 67, '新巴尔虎右旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (824, 67, '满洲里市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (825, 67, '牙克石市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (826, 67, '扎兰屯市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (827, 67, '额尔古纳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (828, 67, '根河市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (829, 67, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (830, 68, '临河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (831, 68, '五原县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (832, 68, '磴口县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (833, 68, '乌拉特前旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (834, 68, '乌拉特中旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (835, 68, '乌拉特后旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (836, 68, '杭锦后旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (837, 68, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (838, 69, '集宁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (839, 69, '卓资县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (840, 69, '化德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (841, 69, '商都县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (842, 69, '兴和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (843, 69, '凉城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (844, 69, '察哈尔右翼前旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (845, 69, '察哈尔右翼中旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (846, 69, '察哈尔右翼后旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (847, 69, '四子王旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (848, 69, '丰镇市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (849, 69, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (850, 70, '乌兰浩特市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (851, 70, '阿尔山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (852, 70, '科尔沁右翼前旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (853, 70, '科尔沁右翼中旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (854, 70, '扎赉特旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (855, 70, '突泉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (856, 70, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (857, 71, '二连浩特市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (858, 71, '锡林浩特市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (859, 71, '阿巴嘎旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (860, 71, '苏尼特左旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (861, 71, '苏尼特右旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (862, 71, '东乌珠穆沁旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (863, 71, '西乌珠穆沁旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (864, 71, '太仆寺旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (865, 71, '镶黄旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (866, 71, '正镶白旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (867, 71, '正蓝旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (868, 71, '多伦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (869, 71, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (870, 72, '阿拉善左旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (871, 72, '阿拉善右旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (872, 72, '额济纳旗', 3, 0);
INSERT INTO `bbgshop_region` VALUES (873, 72, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (874, 73, '和平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (875, 73, '沈河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (876, 73, '大东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (877, 73, '皇姑区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (878, 73, '铁西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (879, 73, '苏家屯区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (880, 73, '浑南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (881, 73, '新城子区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (882, 73, '于洪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (883, 73, '辽中县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (884, 73, '康平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (885, 73, '法库县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (886, 73, '新民市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (887, 73, '浑南新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (888, 73, '张士开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (889, 73, '沈北新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (890, 73, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (891, 74, '中山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (892, 74, '西岗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (893, 74, '沙河口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (894, 74, '甘井子区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (895, 74, '旅顺口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (896, 74, '金州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (897, 74, '长海县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (898, 74, '开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (899, 74, '瓦房店市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (900, 74, '普兰店市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (901, 74, '庄河市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (902, 74, '岭前区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (903, 74, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (904, 75, '铁东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (905, 75, '铁西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (906, 75, '立山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (907, 75, '千山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (908, 75, '台安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (909, 75, '岫岩满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (910, 75, '高新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (911, 75, '海城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (912, 75, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (913, 76, '新抚区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (914, 76, '东洲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (915, 76, '望花区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (916, 76, '顺城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (917, 76, '抚顺县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (918, 76, '新宾满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (919, 76, '清原满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (920, 76, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (921, 77, '平山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (922, 77, '溪湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (923, 77, '明山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (924, 77, '南芬区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (925, 77, '本溪满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (926, 77, '桓仁满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (927, 77, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (928, 78, '元宝区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (929, 78, '振兴区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (930, 78, '振安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (931, 78, '宽甸满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (932, 78, '东港市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (933, 78, '凤城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (934, 78, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (935, 79, '古塔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (936, 79, '凌河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (937, 79, '太和区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (938, 79, '黑山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (939, 79, '义县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (940, 79, '凌海市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (941, 79, '北镇市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (942, 79, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (943, 80, '站前区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (944, 80, '西市区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (945, 80, '鲅鱼圈区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (946, 80, '老边区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (947, 80, '盖州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (948, 80, '大石桥市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (949, 80, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (950, 81, '海州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (951, 81, '新邱区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (952, 81, '太平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (953, 81, '清河门区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (954, 81, '细河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (955, 81, '阜新蒙古族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (956, 81, '彰武县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (957, 81, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (958, 82, '白塔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (959, 82, '文圣区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (960, 82, '宏伟区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (961, 82, '弓长岭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (962, 82, '太子河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (963, 82, '辽阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (964, 82, '灯塔市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (965, 82, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (966, 83, '双台子区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (967, 83, '兴隆台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (968, 83, '大洼县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (969, 83, '盘山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (970, 83, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (971, 84, '银州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (972, 84, '清河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (973, 84, '铁岭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (974, 84, '西丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (975, 84, '昌图县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (976, 84, '调兵山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (977, 84, '开原市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (978, 84, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (979, 85, '双塔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (980, 85, '龙城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (981, 85, '朝阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (982, 85, '建平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (983, 85, '喀喇沁左翼蒙古族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (984, 85, '北票市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (985, 85, '凌源市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (986, 85, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (987, 86, '连山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (988, 86, '龙港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (989, 86, '南票区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (990, 86, '绥中县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (991, 86, '建昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (992, 86, '兴城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (993, 86, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (994, 87, '南关区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (995, 87, '宽城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (996, 87, '朝阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (997, 87, '二道区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (998, 87, '绿园区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (999, 87, '双阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1000, 87, '农安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1001, 87, '九台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1002, 87, '榆树市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1003, 87, '德惠市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1004, 87, '高新技术产业开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1005, 87, '汽车产业开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1006, 87, '经济技术开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1007, 87, '净月旅游开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1008, 87, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1009, 88, '昌邑区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1010, 88, '龙潭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1011, 88, '船营区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1012, 88, '丰满区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1013, 88, '永吉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1014, 88, '蛟河市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1015, 88, '桦甸市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1016, 88, '舒兰市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1017, 88, '磐石市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1018, 88, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1019, 89, '铁西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1020, 89, '铁东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1021, 89, '梨树县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1022, 89, '伊通满族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1023, 89, '公主岭市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1024, 89, '双辽市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1025, 89, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1026, 90, '龙山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1027, 90, '西安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1028, 90, '东丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1029, 90, '东辽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1030, 90, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1031, 91, '东昌区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1032, 91, '二道江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1033, 91, '通化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1034, 91, '辉南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1035, 91, '柳河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1036, 91, '梅河口市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1037, 91, '集安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1038, 91, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1039, 92, '浑江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1040, 92, '抚松县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1041, 92, '靖宇县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1042, 92, '长白朝鲜族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1043, 92, '江源区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1044, 92, '临江市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1045, 92, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1046, 93, '宁江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1047, 93, '前郭尔罗斯蒙古族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1048, 93, '长岭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1049, 93, '乾安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1050, 93, '扶余市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1051, 93, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1052, 94, '洮北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1053, 94, '镇赉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1054, 94, '通榆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1055, 94, '洮南市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1056, 94, '大安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1057, 94, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1058, 95, '延吉市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1059, 95, '图们市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1060, 95, '敦化市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1061, 95, '珲春市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1062, 95, '龙井市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1063, 95, '和龙市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1064, 95, '汪清县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1065, 95, '安图县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1066, 95, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1067, 96, '道里区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1068, 96, '南岗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1069, 96, '道外区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1070, 96, '香坊区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1071, 96, '动力区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1072, 96, '平房区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1073, 96, '松北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1074, 96, '呼兰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1075, 96, '依兰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1076, 96, '方正县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1077, 96, '宾县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1078, 96, '巴彦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1079, 96, '木兰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1080, 96, '通河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1081, 96, '延寿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1082, 96, '阿城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1083, 96, '双城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1084, 96, '尚志市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1085, 96, '五常市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1086, 96, '阿城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1087, 96, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1088, 97, '龙沙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1089, 97, '建华区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1090, 97, '铁锋区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1091, 97, '昂昂溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1092, 97, '富拉尔基区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1093, 97, '碾子山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1094, 97, '梅里斯达斡尔族区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1095, 97, '龙江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1096, 97, '依安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1097, 97, '泰来县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1098, 97, '甘南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1099, 97, '富裕县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1100, 97, '克山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1101, 97, '克东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1102, 97, '拜泉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1103, 97, '讷河市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1104, 97, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1105, 98, '鸡冠区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1106, 98, '恒山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1107, 98, '滴道区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1108, 98, '梨树区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1109, 98, '城子河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1110, 98, '麻山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1111, 98, '鸡东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1112, 98, '虎林市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1113, 98, '密山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1114, 98, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1115, 99, '向阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1116, 99, '工农区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1117, 99, '南山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1118, 99, '兴安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1119, 99, '东山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1120, 99, '兴山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1121, 99, '萝北县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1122, 99, '绥滨县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1123, 99, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1124, 100, '尖山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1125, 100, '岭东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1126, 100, '四方台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1127, 100, '宝山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1128, 100, '集贤县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1129, 100, '友谊县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1130, 100, '宝清县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1131, 100, '饶河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1132, 100, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1133, 101, '萨尔图区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1134, 101, '龙凤区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1135, 101, '让胡路区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1136, 101, '红岗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1137, 101, '大同区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1138, 101, '肇州县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1139, 101, '肇源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1140, 101, '林甸县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1141, 101, '杜尔伯特蒙古族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1142, 101, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1143, 102, '伊春区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1144, 102, '南岔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1145, 102, '友好区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1146, 102, '西林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1147, 102, '翠峦区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1148, 102, '新青区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1149, 102, '美溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1150, 102, '金山屯区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1151, 102, '五营区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1152, 102, '乌马河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1153, 102, '汤旺河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1154, 102, '带岭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1155, 102, '乌伊岭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1156, 102, '红星区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1157, 102, '上甘岭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1158, 102, '嘉荫县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1159, 102, '铁力市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1160, 102, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1161, 103, '永红区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1162, 103, '向阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1163, 103, '前进区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1164, 103, '东风区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1165, 103, '郊区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1166, 103, '桦南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1167, 103, '桦川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1168, 103, '汤原县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1169, 103, '抚远县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1170, 103, '同江市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1171, 103, '富锦市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1172, 103, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1173, 104, '新兴区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1174, 104, '桃山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1175, 104, '茄子河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1176, 104, '勃利县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1177, 104, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1178, 105, '东安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1179, 105, '阳明区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1180, 105, '爱民区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1181, 105, '西安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1182, 105, '东宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1183, 105, '林口县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1184, 105, '绥芬河市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1185, 105, '海林市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1186, 105, '宁安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1187, 105, '穆棱市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1188, 105, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1189, 106, '爱辉区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1190, 106, '嫩江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1191, 106, '逊克县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1192, 106, '孙吴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1193, 106, '北安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1194, 106, '五大连池市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1195, 106, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1196, 107, '北林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1197, 107, '望奎县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1198, 107, '兰西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1199, 107, '青冈县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1200, 107, '庆安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1201, 107, '明水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1202, 107, '绥棱县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1203, 107, '安达市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1204, 107, '肇东市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1205, 107, '海伦市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1206, 107, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1207, 108, '松岭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1208, 108, '新林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1209, 108, '呼中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1210, 108, '呼玛县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1211, 108, '塔河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1212, 108, '漠河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1213, 108, '加格达奇区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1214, 108, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1215, 109, '黄浦区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1216, 109, '卢湾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1217, 109, '徐汇区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1218, 109, '长宁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1219, 109, '静安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1220, 109, '普陀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1221, 109, '闸北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1222, 109, '虹口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1223, 109, '杨浦区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1224, 109, '闵行区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1225, 109, '宝山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1226, 109, '嘉定区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1227, 109, '浦东新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1228, 109, '金山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1229, 109, '松江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1230, 109, '青浦区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1231, 109, '南汇区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1232, 109, '奉贤区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1233, 109, '川沙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1234, 109, '崇明县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1235, 109, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1236, 110, '玄武区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1237, 110, '白下区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1238, 110, '秦淮区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1239, 110, '建邺区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1240, 110, '鼓楼区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1241, 110, '下关区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1242, 110, '浦口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1243, 110, '栖霞区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1244, 110, '雨花台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1245, 110, '江宁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1246, 110, '六合区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1247, 110, '溧水区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1248, 110, '高淳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1249, 110, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1250, 111, '崇安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1251, 111, '南长区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1252, 111, '北塘区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1253, 111, '锡山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1254, 111, '惠山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1255, 111, '滨湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1256, 111, '江阴市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1257, 111, '宜兴市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1258, 111, '新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1259, 111, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1260, 112, '鼓楼区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1261, 112, '云龙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1262, 112, '九里区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1263, 112, '贾汪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1264, 112, '泉山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1265, 112, '丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1266, 112, '沛县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1267, 112, '铜山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1268, 112, '睢宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1269, 112, '新沂市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1270, 112, '邳州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1271, 112, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1272, 113, '天宁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1273, 113, '钟楼区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1274, 113, '戚墅堰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1275, 113, '新北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1276, 113, '武进区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1277, 113, '溧阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1278, 113, '金坛市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1279, 113, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1280, 114, '沧浪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1281, 114, '平江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1282, 114, '金阊区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1283, 114, '虎丘区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1284, 114, '吴中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1285, 114, '相城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1286, 114, '姑苏区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1287, 114, '常熟市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1288, 114, '张家港市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1289, 114, '昆山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1290, 114, '吴江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1291, 114, '太仓市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1292, 114, '新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1293, 114, '园区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1294, 114, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1295, 115, '崇川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1296, 115, '港闸区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1297, 115, '通州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1298, 115, '海安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1299, 115, '如东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1300, 115, '启东市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1301, 115, '如皋市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1302, 115, '通州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1303, 115, '海门市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1304, 115, '开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1305, 115, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1306, 116, '连云区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1307, 116, '新浦区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1308, 116, '海州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1309, 116, '赣榆区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1310, 116, '东海县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1311, 116, '灌云县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1312, 116, '灌南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1313, 116, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1314, 117, '清河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1315, 117, '淮安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1316, 117, '淮阴区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1317, 117, '清浦区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1318, 117, '涟水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1319, 117, '洪泽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1320, 117, '盱眙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1321, 117, '金湖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1322, 117, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1323, 118, '亭湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1324, 118, '盐都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1325, 118, '响水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1326, 118, '滨海县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1327, 118, '阜宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1328, 118, '射阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1329, 118, '建湖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1330, 118, '东台市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1331, 118, '大丰市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1332, 118, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1333, 119, '广陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1334, 119, '邗江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1335, 119, '维扬区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1336, 119, '宝应县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1337, 119, '仪征市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1338, 119, '高邮市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1339, 119, '江都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1340, 119, '经济开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1341, 119, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1342, 120, '京口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1343, 120, '润州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1344, 120, '丹徒区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1345, 120, '丹阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1346, 120, '扬中市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1347, 120, '句容市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1348, 120, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1349, 121, '海陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1350, 121, '高港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1351, 121, '兴化市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1352, 121, '靖江市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1353, 121, '泰兴市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1354, 121, '姜堰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1355, 121, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1356, 122, '宿城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1357, 122, '宿豫区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1358, 122, '沭阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1359, 122, '泗阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1360, 122, '泗洪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1361, 122, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1362, 123, '上城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1363, 123, '下城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1364, 123, '江干区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1365, 123, '拱墅区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1366, 123, '西湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1367, 123, '滨江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1368, 123, '萧山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1369, 123, '余杭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1370, 123, '桐庐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1371, 123, '淳安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1372, 123, '建德市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1373, 123, '富阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1374, 123, '临安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1375, 123, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1376, 124, '海曙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1377, 124, '江东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1378, 124, '江北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1379, 124, '北仑区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1380, 124, '镇海区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1381, 124, '鄞州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1382, 124, '象山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1383, 124, '宁海县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1384, 124, '余姚市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1385, 124, '慈溪市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1386, 124, '奉化市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1387, 124, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1388, 125, '鹿城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1389, 125, '龙湾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1390, 125, '瓯海区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1391, 125, '洞头县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1392, 125, '永嘉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1393, 125, '平阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1394, 125, '苍南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1395, 125, '文成县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1396, 125, '泰顺县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1397, 125, '瑞安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1398, 125, '乐清市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1399, 125, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1400, 126, '南湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1401, 126, '秀洲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1402, 126, '嘉善县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1403, 126, '海盐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1404, 126, '海宁市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1405, 126, '平湖市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1406, 126, '桐乡市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1407, 126, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1408, 127, '吴兴区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1409, 127, '南浔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1410, 127, '德清县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1411, 127, '长兴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1412, 127, '安吉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1413, 127, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1414, 128, '越城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1415, 128, '柯桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1416, 128, '新昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1417, 128, '诸暨市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1418, 128, '上虞区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1419, 128, '嵊州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1420, 128, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1421, 129, '婺城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1422, 129, '金东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1423, 129, '武义县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1424, 129, '浦江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1425, 129, '磐安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1426, 129, '兰溪市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1427, 129, '义乌市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1428, 129, '东阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1429, 129, '永康市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1430, 129, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1431, 130, '柯城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1432, 130, '衢江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1433, 130, '常山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1434, 130, '开化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1435, 130, '龙游县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1436, 130, '江山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1437, 130, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1438, 131, '定海区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1439, 131, '普陀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1440, 131, '岱山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1441, 131, '嵊泗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1442, 131, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1443, 132, '椒江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1444, 132, '黄岩区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1445, 132, '路桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1446, 132, '玉环县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1447, 132, '三门县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1448, 132, '天台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1449, 132, '仙居县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1450, 132, '温岭市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1451, 132, '临海市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1452, 132, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1453, 133, '莲都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1454, 133, '青田县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1455, 133, '缙云县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1456, 133, '遂昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1457, 133, '松阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1458, 133, '云和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1459, 133, '庆元县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1460, 133, '景宁畲族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1461, 133, '龙泉市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1462, 133, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1463, 134, '瑶海区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1464, 134, '庐阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1465, 134, '蜀山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1466, 134, '包河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1467, 134, '长丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1468, 134, '肥东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1469, 134, '肥西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1470, 134, '高新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1471, 134, '中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1472, 134, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1473, 135, '镜湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1474, 135, '弋江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1475, 135, '鸠江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1476, 135, '三山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1477, 135, '芜湖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1478, 135, '繁昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1479, 135, '南陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1480, 135, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1481, 136, '龙子湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1482, 136, '蚌山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1483, 136, '禹会区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1484, 136, '淮上区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1485, 136, '怀远县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1486, 136, '五河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1487, 136, '固镇县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1488, 136, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1489, 137, '大通区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1490, 137, '田家庵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1491, 137, '谢家集区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1492, 137, '八公山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1493, 137, '潘集区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1494, 137, '凤台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1495, 137, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1496, 138, '金家庄区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1497, 138, '花山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1498, 138, '雨山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1499, 138, '博望区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1500, 138, '当涂县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1501, 138, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1502, 139, '杜集区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1503, 139, '相山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1504, 139, '烈山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1505, 139, '濉溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1506, 139, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1507, 140, '铜官山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1508, 140, '狮子山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1509, 140, '郊区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1510, 140, '铜陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1511, 140, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1512, 141, '迎江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1513, 141, '大观区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1514, 141, '宜秀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1515, 141, '怀宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1516, 141, '枞阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1517, 141, '潜山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1518, 141, '太湖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1519, 141, '宿松县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1520, 141, '望江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1521, 141, '岳西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1522, 141, '桐城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1523, 141, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1524, 142, '屯溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1525, 142, '黄山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1526, 142, '徽州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1527, 142, '歙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1528, 142, '休宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1529, 142, '黟县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1530, 142, '祁门县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1531, 142, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1532, 143, '琅琊区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1533, 143, '南谯区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1534, 143, '来安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1535, 143, '全椒县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1536, 143, '定远县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1537, 143, '凤阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1538, 143, '天长市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1539, 143, '明光市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1540, 143, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1541, 144, '颍州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1542, 144, '颍东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1543, 144, '颍泉区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1544, 144, '临泉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1545, 144, '太和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1546, 144, '阜南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1547, 144, '颍上县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1548, 144, '界首市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1549, 144, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1550, 145, '埇桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1551, 145, '砀山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1552, 145, '萧县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1553, 145, '灵璧县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1554, 145, '泗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1555, 145, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1556, 134, '巢湖市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1557, 134, '居巢区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1558, 134, '庐江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1559, 135, '无为县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1560, 138, '含山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1561, 138, '和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1562, 146, '金安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1563, 146, '裕安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1564, 146, '寿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1565, 146, '霍邱县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1566, 146, '舒城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1567, 146, '金寨县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1568, 146, '霍山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1569, 146, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1570, 147, '谯城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1571, 147, '涡阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1572, 147, '蒙城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1573, 147, '利辛县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1574, 147, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1575, 148, '贵池区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1576, 148, '东至县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1577, 148, '石台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1578, 148, '青阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1579, 148, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1580, 149, '宣州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1581, 149, '郎溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1582, 149, '广德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1583, 149, '泾县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1584, 149, '绩溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1585, 149, '旌德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1586, 149, '宁国市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1587, 149, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1588, 150, '鼓楼区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1589, 150, '台江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1590, 150, '仓山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1591, 150, '马尾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1592, 150, '晋安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1593, 150, '闽侯县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1594, 150, '连江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1595, 150, '罗源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1596, 150, '闽清县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1597, 150, '永泰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1598, 150, '平潭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1599, 150, '福清市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1600, 150, '长乐市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1601, 150, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1602, 151, '思明区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1603, 151, '海沧区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1604, 151, '湖里区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1605, 151, '集美区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1606, 151, '同安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1607, 151, '翔安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1608, 151, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1609, 152, '城厢区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1610, 152, '涵江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1611, 152, '荔城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1612, 152, '秀屿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1613, 152, '仙游县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1614, 152, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1615, 153, '梅列区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1616, 153, '三元区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1617, 153, '明溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1618, 153, '清流县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1619, 153, '宁化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1620, 153, '大田县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1621, 153, '尤溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1622, 153, '沙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1623, 153, '将乐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1624, 153, '泰宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1625, 153, '建宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1626, 153, '永安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1627, 153, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1628, 154, '鲤城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1629, 154, '丰泽区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1630, 154, '洛江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1631, 154, '泉港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1632, 154, '惠安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1633, 154, '安溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1634, 154, '永春县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1635, 154, '德化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1636, 154, '金门县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1637, 154, '石狮市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1638, 154, '晋江市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1639, 154, '南安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1640, 154, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1641, 155, '芗城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1642, 155, '龙文区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1643, 155, '云霄县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1644, 155, '漳浦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1645, 155, '诏安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1646, 155, '长泰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1647, 155, '东山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1648, 155, '南靖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1649, 155, '平和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1650, 155, '华安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1651, 155, '龙海市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1652, 155, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1653, 156, '延平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1654, 156, '顺昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1655, 156, '浦城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1656, 156, '光泽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1657, 156, '松溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1658, 156, '政和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1659, 156, '邵武市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1660, 156, '武夷山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1661, 156, '建瓯市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1662, 156, '建阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1663, 156, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1664, 157, '新罗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1665, 157, '长汀县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1666, 157, '永定区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1667, 157, '上杭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1668, 157, '武平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1669, 157, '连城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1670, 157, '漳平市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1671, 157, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1672, 158, '蕉城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1673, 158, '霞浦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1674, 158, '古田县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1675, 158, '屏南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1676, 158, '寿宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1677, 158, '周宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1678, 158, '柘荣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1679, 158, '福安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1680, 158, '福鼎市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1681, 158, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1682, 159, '东湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1683, 159, '西湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1684, 159, '青云谱区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1685, 159, '湾里区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1686, 159, '青山湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1687, 159, '南昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1688, 159, '新建县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1689, 159, '安义县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1690, 159, '进贤县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1691, 159, '红谷滩新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1692, 159, '经济技术开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1693, 159, '昌北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1694, 159, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1695, 160, '昌江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1696, 160, '珠山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1697, 160, '浮梁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1698, 160, '乐平市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1699, 160, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1700, 161, '安源区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1701, 161, '湘东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1702, 161, '莲花县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1703, 161, '上栗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1704, 161, '芦溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1705, 161, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1706, 162, '庐山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1707, 162, '浔阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1708, 162, '九江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1709, 162, '武宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1710, 162, '修水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1711, 162, '永修县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1712, 162, '德安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1713, 162, '星子县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1714, 162, '都昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1715, 162, '湖口县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1716, 162, '彭泽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1717, 162, '瑞昌市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1718, 162, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1719, 162, '共青城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1720, 163, '渝水区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1721, 163, '分宜县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1722, 163, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1723, 164, '月湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1724, 164, '余江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1725, 164, '贵溪市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1726, 164, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1727, 165, '章贡区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1728, 165, '赣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1729, 165, '信丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1730, 165, '大余县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1731, 165, '上犹县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1732, 165, '崇义县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1733, 165, '安远县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1734, 165, '龙南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1735, 165, '定南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1736, 165, '全南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1737, 165, '宁都县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1738, 165, '于都县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1739, 165, '兴国县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1740, 165, '会昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1741, 165, '寻乌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1742, 165, '石城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1743, 165, '黄金区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1744, 165, '瑞金市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1745, 165, '南康区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1746, 165, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1747, 166, '吉州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1748, 166, '青原区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1749, 166, '吉安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1750, 166, '吉水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1751, 166, '峡江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1752, 166, '新干县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1753, 166, '永丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1754, 166, '泰和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1755, 166, '遂川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1756, 166, '万安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1757, 166, '安福县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1758, 166, '永新县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1759, 166, '井冈山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1760, 166, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1761, 167, '袁州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1762, 167, '奉新县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1763, 167, '万载县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1764, 167, '上高县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1765, 167, '宜丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1766, 167, '靖安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1767, 167, '铜鼓县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1768, 167, '丰城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1769, 167, '樟树市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1770, 167, '高安市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1771, 167, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1772, 168, '临川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1773, 168, '南城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1774, 168, '黎川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1775, 168, '南丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1776, 168, '崇仁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1777, 168, '乐安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1778, 168, '宜黄县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1779, 168, '金溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1780, 168, '资溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1781, 168, '东乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1782, 168, '广昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1783, 168, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1784, 169, '信州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1785, 169, '上饶县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1786, 169, '广丰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1787, 169, '玉山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1788, 169, '铅山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1789, 169, '横峰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1790, 169, '弋阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1791, 169, '余干县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1792, 169, '鄱阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1793, 169, '万年县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1794, 169, '婺源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1795, 169, '德兴市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1796, 169, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1797, 170, '历下区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1798, 170, '市中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1799, 170, '槐荫区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1800, 170, '天桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1801, 170, '历城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1802, 170, '长清区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1803, 170, '平阴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1804, 170, '济阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1805, 170, '商河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1806, 170, '章丘市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1807, 170, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1808, 171, '市南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1809, 171, '市北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1810, 171, '四方区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1811, 171, '黄岛区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1812, 171, '崂山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1813, 171, '李沧区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1814, 171, '城阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1815, 171, '开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1816, 171, '胶州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1817, 171, '即墨市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1818, 171, '平度市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1819, 171, '胶南市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1820, 171, '莱西市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1821, 171, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1822, 172, '淄川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1823, 172, '张店区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1824, 172, '博山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1825, 172, '临淄区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1826, 172, '周村区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1827, 172, '桓台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1828, 172, '高青县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1829, 172, '沂源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1830, 172, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1831, 173, '市中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1832, 173, '薛城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1833, 173, '峄城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1834, 173, '台儿庄区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1835, 173, '山亭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1836, 173, '滕州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1837, 173, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1838, 174, '东营区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1839, 174, '河口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1840, 174, '垦利县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1841, 174, '利津县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1842, 174, '广饶县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1843, 174, '西城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1844, 174, '东城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1845, 174, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1846, 175, '芝罘区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1847, 175, '福山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1848, 175, '牟平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1849, 175, '莱山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1850, 175, '长岛县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1851, 175, '龙口市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1852, 175, '莱阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1853, 175, '莱州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1854, 175, '蓬莱市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1855, 175, '招远市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1856, 175, '栖霞市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1857, 175, '海阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1858, 175, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1859, 176, '潍城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1860, 176, '寒亭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1861, 176, '坊子区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1862, 176, '奎文区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1863, 176, '临朐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1864, 176, '昌乐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1865, 176, '开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1866, 176, '青州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1867, 176, '诸城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1868, 176, '寿光市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1869, 176, '安丘市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1870, 176, '高密市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1871, 176, '昌邑市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1872, 176, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1873, 177, '市中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1874, 177, '任城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1875, 177, '微山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1876, 177, '鱼台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1877, 177, '金乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1878, 177, '嘉祥县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1879, 177, '汶上县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1880, 177, '泗水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1881, 177, '梁山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1882, 177, '曲阜市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1883, 177, '兖州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1884, 177, '邹城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1885, 177, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1886, 178, '泰山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1887, 178, '岱岳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1888, 178, '宁阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1889, 178, '东平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1890, 178, '新泰市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1891, 178, '肥城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1892, 178, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1893, 179, '环翠区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1894, 179, '文登区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1895, 179, '荣成市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1896, 179, '乳山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1897, 179, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1898, 180, '东港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1899, 180, '岚山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1900, 180, '五莲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1901, 180, '莒县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1902, 180, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1903, 181, '莱城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1904, 181, '钢城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1905, 181, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1906, 182, '兰山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1907, 182, '罗庄区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1908, 182, '河东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1909, 182, '沂南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1910, 182, '郯城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1911, 182, '沂水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1912, 182, '兰陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1913, 182, '费县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1914, 182, '平邑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1915, 182, '莒南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1916, 182, '蒙阴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1917, 182, '临沭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1918, 182, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1919, 183, '德城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1920, 183, '陵城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1921, 183, '宁津县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1922, 183, '庆云县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1923, 183, '临邑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1924, 183, '齐河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1925, 183, '平原县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1926, 183, '夏津县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1927, 183, '武城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1928, 183, '开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1929, 183, '乐陵市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1930, 183, '禹城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1931, 183, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1932, 184, '东昌府区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1933, 184, '阳谷县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1934, 184, '莘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1935, 184, '茌平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1936, 184, '东阿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1937, 184, '冠县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1938, 184, '高唐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1939, 184, '临清市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1940, 184, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1941, 185, '滨城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1942, 185, '惠民县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1943, 185, '阳信县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1944, 185, '无棣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1945, 185, '沾化区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1946, 185, '博兴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1947, 185, '邹平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1948, 185, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1949, 186, '牡丹区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1950, 186, '曹县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1951, 186, '单县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1952, 186, '成武县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1953, 186, '巨野县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1954, 186, '郓城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1955, 186, '鄄城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1956, 186, '定陶县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1957, 186, '东明县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1958, 186, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1959, 187, '中原区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1960, 187, '二七区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1961, 187, '管城回族区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1962, 187, '金水区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1963, 187, '上街区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1964, 187, '惠济区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1965, 187, '中牟县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1966, 187, '巩义市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1967, 187, '荥阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1968, 187, '新密市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1969, 187, '新郑市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1970, 187, '登封市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1971, 187, '郑东新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1972, 187, '高新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1973, 187, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1974, 188, '龙亭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1975, 188, '顺河回族区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1976, 188, '鼓楼区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1977, 188, '禹王台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1978, 188, '金明区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1979, 188, '杞县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1980, 188, '通许县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1981, 188, '尉氏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1982, 188, '祥符区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1983, 188, '兰考县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1984, 188, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1985, 189, '老城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1986, 189, '西工区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1987, 189, '瀍河回族区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1988, 189, '涧西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1989, 189, '吉利区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1990, 189, '洛龙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1991, 189, '孟津县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1992, 189, '新安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1993, 189, '栾川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1994, 189, '嵩县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1995, 189, '汝阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1996, 189, '宜阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1997, 189, '洛宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1998, 189, '伊川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (1999, 189, '偃师市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2000, 190, '新华区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2001, 190, '卫东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2002, 190, '石龙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2003, 190, '湛河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2004, 190, '宝丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2005, 190, '叶县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2006, 190, '鲁山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2007, 190, '郏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2008, 190, '舞钢市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2009, 190, '汝州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2010, 190, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2011, 191, '文峰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2012, 191, '北关区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2013, 191, '殷都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2014, 191, '龙安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2015, 191, '安阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2016, 191, '汤阴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2017, 191, '滑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2018, 191, '内黄县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2019, 191, '林州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2020, 191, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2021, 192, '鹤山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2022, 192, '山城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2023, 192, '淇滨区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2024, 192, '浚县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2025, 192, '淇县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2026, 192, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2027, 193, '红旗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2028, 193, '卫滨区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2029, 193, '凤泉区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2030, 193, '牧野区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2031, 193, '新乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2032, 193, '获嘉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2033, 193, '原阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2034, 193, '延津县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2035, 193, '封丘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2036, 193, '长垣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2037, 193, '卫辉市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2038, 193, '辉县市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2039, 193, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2040, 194, '解放区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2041, 194, '中站区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2042, 194, '马村区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2043, 194, '山阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2044, 194, '修武县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2045, 194, '博爱县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2046, 194, '武陟县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2047, 194, '温县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2048, 194, '沁阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2049, 194, '孟州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2050, 194, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2051, 195, '华龙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2052, 195, '清丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2053, 195, '南乐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2054, 195, '范县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2055, 195, '台前县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2056, 195, '濮阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2057, 195, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2058, 196, '魏都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2059, 196, '许昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2060, 196, '鄢陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2061, 196, '襄城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2062, 196, '禹州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2063, 196, '长葛市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2064, 196, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2065, 197, '源汇区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2066, 197, '郾城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2067, 197, '召陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2068, 197, '舞阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2069, 197, '临颍县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2070, 197, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2071, 198, '湖滨区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2072, 198, '渑池县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2073, 198, '陕州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2074, 198, '卢氏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2075, 198, '义马市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2076, 198, '灵宝市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2077, 198, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2078, 199, '宛城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2079, 199, '卧龙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2080, 199, '南召县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2081, 199, '方城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2082, 199, '西峡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2083, 199, '镇平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2084, 199, '内乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2085, 199, '淅川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2086, 199, '社旗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2087, 199, '唐河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2088, 199, '新野县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2089, 199, '桐柏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2090, 199, '邓州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2091, 199, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2092, 200, '梁园区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2093, 200, '睢阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2094, 200, '民权县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2095, 200, '睢县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2096, 200, '宁陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2097, 200, '柘城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2098, 200, '虞城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2099, 200, '夏邑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2100, 200, '永城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2101, 200, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2102, 201, '浉河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2103, 201, '平桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2104, 201, '罗山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2105, 201, '光山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2106, 201, '新县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2107, 201, '商城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2108, 201, '固始县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2109, 201, '潢川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2110, 201, '淮滨县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2111, 201, '息县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2112, 201, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2113, 202, '川汇区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2114, 202, '扶沟县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2115, 202, '西华县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2116, 202, '商水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2117, 202, '沈丘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2118, 202, '郸城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2119, 202, '淮阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2120, 202, '太康县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2121, 202, '鹿邑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2122, 202, '项城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2123, 202, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2124, 203, '驿城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2125, 203, '西平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2126, 203, '上蔡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2127, 203, '平舆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2128, 203, '正阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2129, 203, '确山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2130, 203, '泌阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2131, 203, '汝南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2132, 203, '遂平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2133, 203, '新蔡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2134, 203, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2135, 204, '江岸区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2136, 204, '江汉区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2137, 204, '硚口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2138, 204, '汉阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2139, 204, '武昌区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2140, 204, '青山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2141, 204, '洪山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2142, 204, '东西湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2143, 204, '汉南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2144, 204, '蔡甸区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2145, 204, '江夏区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2146, 204, '黄陂区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2147, 204, '新洲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2148, 204, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2149, 205, '黄石港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2150, 205, '西塞山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2151, 205, '下陆区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2152, 205, '铁山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2153, 205, '阳新县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2154, 205, '大冶市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2155, 205, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2156, 206, '茅箭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2157, 206, '张湾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2158, 206, '郧阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2159, 206, '郧西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2160, 206, '竹山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2161, 206, '竹溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2162, 206, '房县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2163, 206, '丹江口市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2164, 206, '城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2165, 206, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2166, 207, '西陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2167, 207, '伍家岗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2168, 207, '点军区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2169, 207, '猇亭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2170, 207, '夷陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2171, 207, '远安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2172, 207, '兴山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2173, 207, '秭归县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2174, 207, '长阳土家族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2175, 207, '五峰土家族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2176, 207, '葛洲坝区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2177, 207, '开发区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2178, 207, '宜都市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2179, 207, '当阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2180, 207, '枝江市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2181, 207, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2182, 208, '襄城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2183, 208, '樊城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2184, 208, '襄州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2185, 208, '南漳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2186, 208, '谷城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2187, 208, '保康县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2188, 208, '老河口市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2189, 208, '枣阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2190, 208, '宜城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2191, 208, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2192, 209, '梁子湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2193, 209, '华容区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2194, 209, '鄂城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2195, 209, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2196, 210, '东宝区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2197, 210, '掇刀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2198, 210, '京山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2199, 210, '沙洋县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2200, 210, '钟祥市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2201, 210, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2202, 211, '孝南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2203, 211, '孝昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2204, 211, '大悟县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2205, 211, '云梦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2206, 211, '应城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2207, 211, '安陆市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2208, 211, '汉川市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2209, 211, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2210, 212, '沙市区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2211, 212, '荆州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2212, 212, '公安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2213, 212, '监利县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2214, 212, '江陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2215, 212, '石首市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2216, 212, '洪湖市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2217, 212, '松滋市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2218, 212, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2219, 213, '黄州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2220, 213, '团风县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2221, 213, '红安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2222, 213, '罗田县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2223, 213, '英山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2224, 213, '浠水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2225, 213, '蕲春县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2226, 213, '黄梅县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2227, 213, '麻城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2228, 213, '武穴市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2229, 213, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2230, 214, '咸安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2231, 214, '嘉鱼县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2232, 214, '通城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2233, 214, '崇阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2234, 214, '通山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2235, 214, '赤壁市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2236, 214, '温泉城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2237, 214, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2238, 215, '曾都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2239, 215, '随县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2240, 215, '广水市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2241, 215, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2242, 216, '恩施市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2243, 216, '利川市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2244, 216, '建始县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2245, 216, '巴东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2246, 216, '宣恩县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2247, 216, '咸丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2248, 216, '来凤县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2249, 216, '鹤峰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2250, 216, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2251, 217, '芙蓉区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2252, 217, '天心区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2253, 217, '岳麓区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2254, 217, '开福区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2255, 217, '雨花区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2256, 217, '长沙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2257, 217, '望城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2258, 217, '宁乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2259, 217, '浏阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2260, 217, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2261, 218, '荷塘区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2262, 218, '芦淞区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2263, 218, '石峰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2264, 218, '天元区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2265, 218, '株洲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2266, 218, '攸县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2267, 218, '茶陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2268, 218, '炎陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2269, 218, '醴陵市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2270, 218, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2271, 219, '雨湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2272, 219, '岳塘区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2273, 219, '湘潭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2274, 219, '湘乡市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2275, 219, '韶山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2276, 219, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2277, 220, '珠晖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2278, 220, '雁峰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2279, 220, '石鼓区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2280, 220, '蒸湘区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2281, 220, '南岳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2282, 220, '衡阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2283, 220, '衡南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2284, 220, '衡山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2285, 220, '衡东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2286, 220, '祁东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2287, 220, '耒阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2288, 220, '常宁市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2289, 220, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2290, 221, '双清区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2291, 221, '大祥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2292, 221, '北塔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2293, 221, '邵东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2294, 221, '新邵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2295, 221, '邵阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2296, 221, '隆回县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2297, 221, '洞口县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2298, 221, '绥宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2299, 221, '新宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2300, 221, '城步苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2301, 221, '武冈市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2302, 221, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2303, 222, '岳阳楼区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2304, 222, '云溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2305, 222, '君山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2306, 222, '岳阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2307, 222, '华容县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2308, 222, '湘阴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2309, 222, '平江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2310, 222, '汨罗市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2311, 222, '临湘市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2312, 222, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2313, 223, '武陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2314, 223, '鼎城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2315, 223, '安乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2316, 223, '汉寿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2317, 223, '澧县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2318, 223, '临澧县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2319, 223, '桃源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2320, 223, '石门县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2321, 223, '津市市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2322, 223, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2323, 224, '永定区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2324, 224, '武陵源区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2325, 224, '慈利县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2326, 224, '桑植县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2327, 224, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2328, 225, '资阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2329, 225, '赫山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2330, 225, '南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2331, 225, '桃江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2332, 225, '安化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2333, 225, '沅江市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2334, 225, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2335, 226, '北湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2336, 226, '苏仙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2337, 226, '桂阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2338, 226, '宜章县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2339, 226, '永兴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2340, 226, '嘉禾县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2341, 226, '临武县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2342, 226, '汝城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2343, 226, '桂东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2344, 226, '安仁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2345, 226, '资兴市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2346, 226, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2347, 227, '零陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2348, 227, '冷水滩区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2349, 227, '祁阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2350, 227, '东安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2351, 227, '双牌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2352, 227, '道县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2353, 227, '江永县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2354, 227, '宁远县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2355, 227, '蓝山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2356, 227, '新田县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2357, 227, '江华瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2358, 227, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2359, 228, '鹤城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2360, 228, '中方县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2361, 228, '沅陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2362, 228, '辰溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2363, 228, '溆浦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2364, 228, '会同县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2365, 228, '麻阳苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2366, 228, '新晃侗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2367, 228, '芷江侗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2368, 228, '靖州苗族侗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2369, 228, '通道侗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2370, 228, '洪江市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2371, 228, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2372, 229, '娄星区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2373, 229, '双峰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2374, 229, '新化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2375, 229, '冷水江市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2376, 229, '涟源市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2377, 229, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2378, 230, '吉首市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2379, 230, '泸溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2380, 230, '凤凰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2381, 230, '花垣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2382, 230, '保靖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2383, 230, '古丈县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2384, 230, '永顺县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2385, 230, '龙山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2386, 230, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2387, 231, '荔湾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2388, 231, '越秀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2389, 231, '海珠区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2390, 231, '天河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2391, 231, '白云区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2392, 231, '黄埔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2393, 231, '番禺区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2394, 231, '花都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2395, 231, '南沙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2396, 231, '萝岗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2397, 231, '增城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2398, 231, '从化区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2399, 231, '东山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2400, 231, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2401, 232, '武江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2402, 232, '浈江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2403, 232, '曲江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2404, 232, '始兴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2405, 232, '仁化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2406, 232, '翁源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2407, 232, '乳源瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2408, 232, '新丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2409, 232, '乐昌市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2410, 232, '南雄市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2411, 232, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2412, 233, '罗湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2413, 233, '福田区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2414, 233, '南山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2415, 233, '宝安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2416, 233, '龙岗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2417, 233, '盐田区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2418, 233, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2419, 233, '光明新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2420, 233, '坪山新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2421, 233, '大鹏新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2422, 233, '龙华新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2423, 234, '香洲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2424, 234, '斗门区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2425, 234, '金湾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2426, 234, '金唐区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2427, 234, '南湾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2428, 234, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2429, 235, '龙湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2430, 235, '金平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2431, 235, '濠江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2432, 235, '潮阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2433, 235, '潮南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2434, 235, '澄海区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2435, 235, '南澳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2436, 235, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2437, 236, '禅城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2438, 236, '南海区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2439, 236, '顺德区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2440, 236, '三水区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2441, 236, '高明区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2442, 236, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2443, 237, '蓬江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2444, 237, '江海区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2445, 237, '新会区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2446, 237, '台山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2447, 237, '开平市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2448, 237, '鹤山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2449, 237, '恩平市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2450, 237, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2451, 238, '赤坎区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2452, 238, '霞山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2453, 238, '坡头区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2454, 238, '麻章区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2455, 238, '遂溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2456, 238, '徐闻县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2457, 238, '廉江市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2458, 238, '雷州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2459, 238, '吴川市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2460, 238, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2461, 239, '茂南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2462, 239, '电白区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2463, 239, '电白县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2464, 239, '高州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2465, 239, '化州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2466, 239, '信宜市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2467, 239, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2468, 240, '端州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2469, 240, '鼎湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2470, 240, '广宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2471, 240, '怀集县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2472, 240, '封开县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2473, 240, '德庆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2474, 240, '高要市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2475, 240, '四会市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2476, 240, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2477, 241, '惠城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2478, 241, '惠阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2479, 241, '博罗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2480, 241, '惠东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2481, 241, '龙门县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2482, 241, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2483, 242, '梅江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2484, 242, '梅县区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2485, 242, '大埔县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2486, 242, '丰顺县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2487, 242, '五华县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2488, 242, '平远县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2489, 242, '蕉岭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2490, 242, '兴宁市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2491, 242, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2492, 243, '城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2493, 243, '海丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2494, 243, '陆河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2495, 243, '陆丰市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2496, 243, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2497, 244, '源城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2498, 244, '紫金县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2499, 244, '龙川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2500, 244, '连平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2501, 244, '和平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2502, 244, '东源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2503, 244, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2504, 245, '江城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2505, 245, '阳西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2506, 245, '阳东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2507, 245, '阳春市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2508, 245, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2509, 246, '清城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2510, 246, '佛冈县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2511, 246, '阳山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2512, 246, '连山壮族瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2513, 246, '连南瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2514, 246, '清新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2515, 246, '英德市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2516, 246, '连州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2517, 246, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2518, 250, '湘桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2519, 250, '潮安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2520, 250, '饶平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2521, 250, '枫溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2522, 250, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2523, 251, '榕城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2524, 251, '揭东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2525, 251, '揭西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2526, 251, '惠来县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2527, 251, '普宁市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2528, 251, '东山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2529, 251, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2530, 252, '云城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2531, 252, '新兴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2532, 252, '郁南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2533, 252, '云安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2534, 252, '罗定市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2535, 252, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2536, 253, '兴宁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2537, 253, '青秀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2538, 253, '江南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2539, 253, '西乡塘区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2540, 253, '良庆区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2541, 253, '邕宁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2542, 253, '武鸣区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2543, 253, '隆安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2544, 253, '马山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2545, 253, '上林县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2546, 253, '宾阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2547, 253, '横县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2548, 253, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2549, 254, '城中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2550, 254, '鱼峰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2551, 254, '柳南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2552, 254, '柳北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2553, 254, '柳江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2554, 254, '柳城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2555, 254, '鹿寨县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2556, 254, '融安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2557, 254, '融水苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2558, 254, '三江侗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2559, 254, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2560, 255, '秀峰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2561, 255, '叠彩区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2562, 255, '象山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2563, 255, '七星区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2564, 255, '雁山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2565, 255, '阳朔县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2566, 255, '临桂区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2567, 255, '灵川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2568, 255, '全州县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2569, 255, '兴安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2570, 255, '永福县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2571, 255, '灌阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2572, 255, '龙胜各族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2573, 255, '资源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2574, 255, '平乐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2575, 255, '荔浦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2576, 255, '恭城瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2577, 255, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2578, 256, '万秀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2579, 256, '蝶山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2580, 256, '长洲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2581, 256, '龙圩区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2582, 256, '苍梧县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2583, 256, '藤县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2584, 256, '蒙山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2585, 256, '岑溪市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2586, 256, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2587, 257, '海城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2588, 257, '银海区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2589, 257, '铁山港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2590, 257, '合浦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2591, 257, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2592, 258, '港口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2593, 258, '防城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2594, 258, '上思县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2595, 258, '东兴市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2596, 258, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2597, 259, '钦南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2598, 259, '钦北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2599, 259, '灵山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2600, 259, '浦北县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2601, 259, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2602, 260, '港北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2603, 260, '港南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2604, 260, '覃塘区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2605, 260, '平南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2606, 260, '桂平市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2607, 260, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2608, 261, '玉州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2609, 261, '福绵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2610, 261, '容县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2611, 261, '陆川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2612, 261, '博白县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2613, 261, '兴业县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2614, 261, '北流市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2615, 261, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2616, 262, '右江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2617, 262, '田阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2618, 262, '田东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2619, 262, '平果县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2620, 262, '德保县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2621, 262, '靖西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2622, 262, '那坡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2623, 262, '凌云县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2624, 262, '乐业县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2625, 262, '田林县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2626, 262, '西林县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2627, 262, '隆林各族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2628, 262, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2629, 263, '八步区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2630, 263, '平桂管理区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2631, 263, '昭平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2632, 263, '钟山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2633, 263, '富川瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2634, 263, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2635, 264, '金城江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2636, 264, '南丹县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2637, 264, '天峨县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2638, 264, '凤山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2639, 264, '东兰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2640, 264, '罗城仫佬族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2641, 264, '环江毛南族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2642, 264, '巴马瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2643, 264, '都安瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2644, 264, '大化瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2645, 264, '宜州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2646, 264, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2647, 265, '兴宾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2648, 265, '忻城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2649, 265, '象州县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2650, 265, '武宣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2651, 265, '金秀瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2652, 265, '合山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2653, 265, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2654, 266, '江州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2655, 266, '扶绥县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2656, 266, '宁明县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2657, 266, '龙州县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2658, 266, '大新县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2659, 266, '天等县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2660, 266, '凭祥市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2661, 266, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2662, 267, '秀英区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2663, 267, '龙华区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2664, 267, '琼山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2665, 267, '美兰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2666, 267, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2667, 269, '西沙群岛', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2668, 269, '南沙群岛', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2669, 269, '中沙群岛的岛礁及其海域', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2670, 189, '高新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2671, 189, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2672, 270, '万州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2673, 270, '涪陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2674, 270, '渝中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2675, 270, '大渡口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2676, 270, '江北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2677, 270, '沙坪坝区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2678, 270, '九龙坡区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2679, 270, '南岸区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2680, 270, '北碚区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2681, 270, '万盛区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2682, 270, '双桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2683, 270, '渝北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2684, 270, '巴南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2685, 270, '黔江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2686, 270, '长寿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2687, 270, '綦江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2688, 270, '潼南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2689, 270, '铜梁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2690, 270, '大足区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2691, 270, '荣昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2692, 270, '璧山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2693, 270, '梁平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2694, 270, '城口县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2695, 270, '丰都县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2696, 270, '垫江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2697, 270, '武隆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2698, 270, '忠县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2699, 270, '开县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2700, 270, '云阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2701, 270, '奉节县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2702, 270, '巫山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2703, 270, '巫溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2704, 270, '石柱土家族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2705, 270, '秀山土家族苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2706, 270, '酉阳土家族苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2707, 270, '彭水苗族土家族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2708, 270, '江津区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2709, 270, '合川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2710, 270, '永川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2711, 270, '南川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2712, 270, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2713, 271, '锦江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2714, 271, '青羊区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2715, 271, '金牛区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2716, 271, '武侯区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2717, 271, '成华区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2718, 271, '龙泉驿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2719, 271, '青白江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2720, 271, '新都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2721, 271, '温江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2722, 271, '金堂县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2723, 271, '双流县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2724, 271, '郫县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2725, 271, '大邑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2726, 271, '蒲江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2727, 271, '新津县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2728, 271, '都江堰市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2729, 271, '彭州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2730, 271, '邛崃市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2731, 271, '崇州市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2732, 271, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2733, 272, '自流井区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2734, 272, '贡井区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2735, 272, '大安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2736, 272, '沿滩区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2737, 272, '荣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2738, 272, '富顺县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2739, 272, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2740, 273, '东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2741, 273, '西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2742, 273, '仁和区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2743, 273, '米易县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2744, 273, '盐边县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2745, 273, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2746, 274, '江阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2747, 274, '纳溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2748, 274, '龙马潭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2749, 274, '泸县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2750, 274, '合江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2751, 274, '叙永县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2752, 274, '古蔺县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2753, 274, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2754, 275, '旌阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2755, 275, '中江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2756, 275, '罗江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2757, 275, '广汉市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2758, 275, '什邡市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2759, 275, '绵竹市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2760, 275, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2761, 276, '涪城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2762, 276, '游仙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2763, 276, '三台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2764, 276, '盐亭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2765, 276, '安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2766, 276, '梓潼县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2767, 276, '北川羌族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2768, 276, '平武县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2769, 276, '高新区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2770, 276, '江油市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2771, 276, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2772, 277, '利州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2773, 277, '昭化区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2774, 277, '朝天区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2775, 277, '旺苍县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2776, 277, '青川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2777, 277, '剑阁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2778, 277, '苍溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2779, 277, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2780, 278, '船山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2781, 278, '安居区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2782, 278, '蓬溪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2783, 278, '射洪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2784, 278, '大英县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2785, 278, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2786, 279, '市中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2787, 279, '东兴区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2788, 279, '威远县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2789, 279, '资中县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2790, 279, '隆昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2791, 279, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2792, 280, '市中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2793, 280, '沙湾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2794, 280, '五通桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2795, 280, '金口河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2796, 280, '犍为县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2797, 280, '井研县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2798, 280, '夹江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2799, 280, '沐川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2800, 280, '峨边彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2801, 280, '马边彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2802, 280, '峨眉山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2803, 280, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2804, 281, '顺庆区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2805, 281, '高坪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2806, 281, '嘉陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2807, 281, '南部县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2808, 281, '营山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2809, 281, '蓬安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2810, 281, '仪陇县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2811, 281, '西充县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2812, 281, '阆中市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2813, 281, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2814, 282, '东坡区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2815, 282, '仁寿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2816, 282, '彭山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2817, 282, '洪雅县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2818, 282, '丹棱县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2819, 282, '青神县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2820, 282, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2821, 283, '翠屏区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2822, 283, '宜宾县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2823, 283, '南溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2824, 283, '江安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2825, 283, '长宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2826, 283, '高县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2827, 283, '珙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2828, 283, '筠连县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2829, 283, '兴文县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2830, 283, '屏山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2831, 283, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2832, 284, '广安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2833, 284, '前锋区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2834, 284, '岳池县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2835, 284, '武胜县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2836, 284, '邻水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2837, 284, '华蓥市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2838, 284, '市辖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2839, 284, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2840, 285, '通川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2841, 285, '达川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2842, 285, '宣汉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2843, 285, '开江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2844, 285, '大竹县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2845, 285, '渠县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2846, 285, '万源市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2847, 285, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2848, 286, '雨城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2849, 286, '名山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2850, 286, '荥经县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2851, 286, '汉源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2852, 286, '石棉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2853, 286, '天全县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2854, 286, '芦山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2855, 286, '宝兴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2856, 286, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2857, 287, '巴州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2858, 287, '恩阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2859, 287, '通江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2860, 287, '南江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2861, 287, '平昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2862, 287, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2863, 288, '雁江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2864, 288, '安岳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2865, 288, '乐至县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2866, 288, '简阳市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2867, 288, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2868, 289, '汶川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2869, 289, '理县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2870, 289, '茂县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2871, 289, '松潘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2872, 289, '九寨沟县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2873, 289, '金川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2874, 289, '小金县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2875, 289, '黑水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2876, 289, '马尔康县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2877, 289, '壤塘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2878, 289, '阿坝县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2879, 289, '若尔盖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2880, 289, '红原县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2881, 289, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2882, 290, '康定市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2883, 290, '泸定县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2884, 290, '丹巴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2885, 290, '九龙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2886, 290, '雅江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2887, 290, '道孚县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2888, 290, '炉霍县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2889, 290, '甘孜县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2890, 290, '新龙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2891, 290, '德格县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2892, 290, '白玉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2893, 290, '石渠县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2894, 290, '色达县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2895, 290, '理塘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2896, 290, '巴塘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2897, 290, '乡城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2898, 290, '稻城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2899, 290, '得荣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2900, 290, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2901, 291, '西昌市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2902, 291, '木里藏族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2903, 291, '盐源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2904, 291, '德昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2905, 291, '会理县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2906, 291, '会东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2907, 291, '宁南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2908, 291, '普格县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2909, 291, '布拖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2910, 291, '金阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2911, 291, '昭觉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2912, 291, '喜德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2913, 291, '冕宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2914, 291, '越西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2915, 291, '甘洛县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2916, 291, '美姑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2917, 291, '雷波县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2918, 291, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2919, 292, '南明区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2920, 292, '云岩区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2921, 292, '花溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2922, 292, '乌当区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2923, 292, '白云区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2924, 292, '小河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2925, 292, '开阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2926, 292, '息烽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2927, 292, '修文县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2928, 292, '观山湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2929, 292, '清镇市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2930, 292, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2931, 293, '钟山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2932, 293, '六枝特区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2933, 293, '水城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2934, 293, '盘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2935, 293, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2936, 294, '红花岗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2937, 294, '汇川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2938, 294, '遵义县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2939, 294, '桐梓县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2940, 294, '绥阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2941, 294, '正安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2942, 294, '道真仡佬族苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2943, 294, '务川仡佬族苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2944, 294, '凤冈县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2945, 294, '湄潭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2946, 294, '余庆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2947, 294, '习水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2948, 294, '赤水市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2949, 294, '仁怀市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2950, 294, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2951, 295, '西秀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2952, 295, '平坝区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2953, 295, '普定县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2954, 295, '镇宁布依族苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2955, 295, '关岭布依族苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2956, 295, '紫云苗族布依族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2957, 295, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2958, 296, '碧江区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2959, 296, '江口县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2960, 296, '玉屏侗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2961, 296, '石阡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2962, 296, '思南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2963, 296, '印江土家族苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2964, 296, '德江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2965, 296, '沿河土家族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2966, 296, '松桃苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2967, 296, '万山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2968, 296, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2969, 297, '兴义市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2970, 297, '兴仁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2971, 297, '普安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2972, 297, '晴隆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2973, 297, '贞丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2974, 297, '望谟县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2975, 297, '册亨县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2976, 297, '安龙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2977, 297, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2978, 298, '七星关区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2979, 298, '大方县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2980, 298, '黔西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2981, 298, '金沙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2982, 298, '织金县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2983, 298, '纳雍县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2984, 298, '威宁彝族回族苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2985, 298, '赫章县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2986, 298, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2987, 299, '凯里市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2988, 299, '黄平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2989, 299, '施秉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2990, 299, '三穗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2991, 299, '镇远县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2992, 299, '岑巩县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2993, 299, '天柱县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2994, 299, '锦屏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2995, 299, '剑河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2996, 299, '台江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2997, 299, '黎平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2998, 299, '榕江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (2999, 299, '从江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3000, 299, '雷山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3001, 299, '麻江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3002, 299, '丹寨县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3003, 299, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3004, 300, '都匀市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3005, 300, '福泉市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3006, 300, '荔波县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3007, 300, '贵定县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3008, 300, '瓮安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3009, 300, '独山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3010, 300, '平塘县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3011, 300, '罗甸县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3012, 300, '长顺县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3013, 300, '龙里县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3014, 300, '惠水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3015, 300, '三都水族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3016, 300, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3017, 301, '五华区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3018, 301, '盘龙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3019, 301, '官渡区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3020, 301, '西山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3021, 301, '东川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3022, 301, '呈贡区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3023, 301, '晋宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3024, 301, '富民县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3025, 301, '宜良县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3026, 301, '石林彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3027, 301, '嵩明县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3028, 301, '禄劝彝族苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3029, 301, '寻甸回族彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3030, 301, '安宁市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3031, 301, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3032, 302, '麒麟区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3033, 302, '马龙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3034, 302, '陆良县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3035, 302, '师宗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3036, 302, '罗平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3037, 302, '富源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3038, 302, '会泽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3039, 302, '沾益县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3040, 302, '宣威市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3041, 302, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3042, 303, '红塔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3043, 303, '江川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3044, 303, '澄江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3045, 303, '通海县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3046, 303, '华宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3047, 303, '易门县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3048, 303, '峨山彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3049, 303, '新平彝族傣族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3050, 303, '元江哈尼族彝族傣族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3051, 303, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3052, 304, '隆阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3053, 304, '施甸县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3054, 304, '腾冲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3055, 304, '龙陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3056, 304, '昌宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3057, 304, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3058, 305, '昭阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3059, 305, '鲁甸县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3060, 305, '巧家县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3061, 305, '盐津县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3062, 305, '大关县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3063, 305, '永善县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3064, 305, '绥江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3065, 305, '镇雄县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3066, 305, '彝良县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3067, 305, '威信县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3068, 305, '水富县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3069, 305, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3070, 306, '古城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3071, 306, '玉龙纳西族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3072, 306, '永胜县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3073, 306, '华坪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3074, 306, '宁蒗彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3075, 306, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3076, 307, '思茅区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3077, 307, '宁洱哈尼族彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3078, 307, '墨江哈尼族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3079, 307, '景东彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3080, 307, '景谷傣族彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3081, 307, '镇沅彝族哈尼族拉祜族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3082, 307, '江城哈尼族彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3083, 307, '孟连傣族拉祜族佤族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3084, 307, '澜沧拉祜族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3085, 307, '西盟佤族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3086, 307, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3087, 308, '临翔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3088, 308, '凤庆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3089, 308, '云县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3090, 308, '永德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3091, 308, '镇康县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3092, 308, '双江拉祜族佤族布朗族傣族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3093, 308, '耿马傣族佤族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3094, 308, '沧源佤族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3095, 308, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3096, 309, '楚雄市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3097, 309, '双柏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3098, 309, '牟定县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3099, 309, '南华县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3100, 309, '姚安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3101, 309, '大姚县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3102, 309, '永仁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3103, 309, '元谋县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3104, 309, '武定县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3105, 309, '禄丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3106, 309, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3107, 310, '个旧市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3108, 310, '开远市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3109, 310, '蒙自市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3110, 310, '屏边苗族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3111, 310, '建水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3112, 310, '石屏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3113, 310, '弥勒市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3114, 310, '泸西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3115, 310, '元阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3116, 310, '红河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3117, 310, '金平苗族瑶族傣族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3118, 310, '绿春县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3119, 310, '河口瑶族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3120, 310, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3121, 311, '文山市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3122, 311, '砚山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3123, 311, '西畴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3124, 311, '麻栗坡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3125, 311, '马关县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3126, 311, '丘北县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3127, 311, '广南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3128, 311, '富宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3129, 311, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3130, 312, '景洪市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3131, 312, '勐海县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3132, 312, '勐腊县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3133, 312, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3134, 313, '大理市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3135, 313, '漾濞彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3136, 313, '祥云县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3137, 313, '宾川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3138, 313, '弥渡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3139, 313, '南涧彝族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3140, 313, '巍山彝族回族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3141, 313, '永平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3142, 313, '云龙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3143, 313, '洱源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3144, 313, '剑川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3145, 313, '鹤庆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3146, 313, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3147, 314, '瑞丽市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3148, 314, '芒市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3149, 314, '梁河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3150, 314, '盈江县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3151, 314, '陇川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3152, 314, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3153, 315, '泸水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3154, 315, '福贡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3155, 315, '贡山独龙族怒族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3156, 315, '兰坪白族普米族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3157, 315, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3158, 316, '香格里拉市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3159, 316, '德钦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3160, 316, '维西傈僳族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3161, 316, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3162, 317, '城关区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3163, 317, '林周县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3164, 317, '当雄县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3165, 317, '尼木县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3166, 317, '曲水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3167, 317, '堆龙德庆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3168, 317, '达孜县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3169, 317, '墨竹工卡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3170, 317, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3171, 318, '卡若区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3172, 318, '江达县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3173, 318, '贡觉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3174, 318, '类乌齐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3175, 318, '丁青县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3176, 318, '察雅县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3177, 318, '八宿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3178, 318, '左贡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3179, 318, '芒康县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3180, 318, '洛隆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3181, 318, '边坝县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3182, 318, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3183, 319, '乃东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3184, 319, '扎囊县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3185, 319, '贡嘎县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3186, 319, '桑日县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3187, 319, '琼结县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3188, 319, '曲松县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3189, 319, '措美县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3190, 319, '洛扎县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3191, 319, '加查县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3192, 319, '隆子县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3193, 319, '错那县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3194, 319, '浪卡子县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3195, 319, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3196, 320, '桑珠孜区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3197, 320, '南木林县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3198, 320, '江孜县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3199, 320, '定日县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3200, 320, '萨迦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3201, 320, '拉孜县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3202, 320, '昂仁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3203, 320, '谢通门县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3204, 320, '白朗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3205, 320, '仁布县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3206, 320, '康马县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3207, 320, '定结县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3208, 320, '仲巴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3209, 320, '亚东县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3210, 320, '吉隆县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3211, 320, '聂拉木县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3212, 320, '萨嘎县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3213, 320, '岗巴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3214, 320, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3215, 321, '那曲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3216, 321, '嘉黎县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3217, 321, '比如县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3218, 321, '聂荣县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3219, 321, '安多县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3220, 321, '申扎县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3221, 321, '索县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3222, 321, '班戈县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3223, 321, '巴青县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3224, 321, '尼玛县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3225, 321, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3226, 321, '双湖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3227, 322, '普兰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3228, 322, '札达县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3229, 322, '噶尔县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3230, 322, '日土县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3231, 322, '革吉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3232, 322, '改则县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3233, 322, '措勤县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3234, 322, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3235, 323, '巴宜区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3236, 323, '工布江达县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3237, 323, '米林县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3238, 323, '墨脱县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3239, 323, '波密县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3240, 323, '察隅县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3241, 323, '朗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3242, 323, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3243, 324, '新城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3244, 324, '碑林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3245, 324, '莲湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3246, 324, '灞桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3247, 324, '未央区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3248, 324, '雁塔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3249, 324, '阎良区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3250, 324, '临潼区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3251, 324, '长安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3252, 324, '蓝田县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3253, 324, '周至县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3254, 324, '户县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3255, 324, '高陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3256, 324, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3257, 325, '王益区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3258, 325, '印台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3259, 325, '耀州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3260, 325, '宜君县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3261, 325, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3262, 326, '渭滨区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3263, 326, '金台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3264, 326, '陈仓区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3265, 326, '凤翔县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3266, 326, '岐山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3267, 326, '扶风县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3268, 326, '眉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3269, 326, '陇县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3270, 326, '千阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3271, 326, '麟游县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3272, 326, '凤县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3273, 326, '太白县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3274, 326, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3275, 327, '秦都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3276, 327, '杨陵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3277, 327, '渭城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3278, 327, '三原县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3279, 327, '泾阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3280, 327, '乾县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3281, 327, '礼泉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3282, 327, '永寿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3283, 327, '彬县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3284, 327, '长武县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3285, 327, '旬邑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3286, 327, '淳化县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3287, 327, '武功县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3288, 327, '兴平市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3289, 327, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3290, 328, '临渭区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3291, 328, '华县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3292, 328, '潼关县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3293, 328, '大荔县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3294, 328, '合阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3295, 328, '澄城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3296, 328, '蒲城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3297, 328, '白水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3298, 328, '富平县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3299, 328, '韩城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3300, 328, '华阴市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3301, 328, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3302, 329, '宝塔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3303, 329, '延长县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3304, 329, '延川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3305, 329, '子长县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3306, 329, '安塞县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3307, 329, '志丹县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3308, 329, '吴起县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3309, 329, '甘泉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3310, 329, '富县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3311, 329, '洛川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3312, 329, '宜川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3313, 329, '黄龙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3314, 329, '黄陵县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3315, 329, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3316, 330, '汉台区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3317, 330, '南郑县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3318, 330, '城固县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3319, 330, '洋县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3320, 330, '西乡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3321, 330, '勉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3322, 330, '宁强县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3323, 330, '略阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3324, 330, '镇巴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3325, 330, '留坝县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3326, 330, '佛坪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3327, 330, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3328, 331, '榆阳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3329, 331, '神木县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3330, 331, '府谷县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3331, 331, '横山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3332, 331, '靖边县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3333, 331, '定边县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3334, 331, '绥德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3335, 331, '米脂县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3336, 331, '佳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3337, 331, '吴堡县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3338, 331, '清涧县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3339, 331, '子洲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3340, 331, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3341, 332, '汉滨区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3342, 332, '汉阴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3343, 332, '石泉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3344, 332, '宁陕县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3345, 332, '紫阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3346, 332, '岚皋县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3347, 332, '平利县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3348, 332, '镇坪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3349, 332, '旬阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3350, 332, '白河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3351, 332, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3352, 333, '商州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3353, 333, '洛南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3354, 333, '丹凤县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3355, 333, '商南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3356, 333, '山阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3357, 333, '镇安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3358, 333, '柞水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3359, 333, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3360, 334, '城关区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3361, 334, '七里河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3362, 334, '西固区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3363, 334, '安宁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3364, 334, '红古区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3365, 334, '永登县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3366, 334, '皋兰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3367, 334, '榆中县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3368, 334, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3369, 336, '金川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3370, 336, '永昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3371, 336, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3372, 337, '白银区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3373, 337, '平川区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3374, 337, '靖远县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3375, 337, '会宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3376, 337, '景泰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3377, 337, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3378, 338, '秦州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3379, 338, '麦积区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3380, 338, '清水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3381, 338, '秦安县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3382, 338, '甘谷县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3383, 338, '武山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3384, 338, '张家川回族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3385, 338, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3386, 339, '凉州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3387, 339, '民勤县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3388, 339, '古浪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3389, 339, '天祝藏族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3390, 339, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3391, 340, '甘州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3392, 340, '肃南裕固族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3393, 340, '民乐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3394, 340, '临泽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3395, 340, '高台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3396, 340, '山丹县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3397, 340, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3398, 341, '崆峒区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3399, 341, '泾川县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3400, 341, '灵台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3401, 341, '崇信县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3402, 341, '华亭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3403, 341, '庄浪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3404, 341, '静宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3405, 341, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3406, 342, '肃州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3407, 342, '金塔县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3408, 342, '瓜州县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3409, 342, '肃北蒙古族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3410, 342, '阿克塞哈萨克族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3411, 342, '玉门市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3412, 342, '敦煌市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3413, 342, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3414, 343, '西峰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3415, 343, '庆城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3416, 343, '环县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3417, 343, '华池县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3418, 343, '合水县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3419, 343, '正宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3420, 343, '宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3421, 343, '镇原县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3422, 343, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3423, 344, '安定区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3424, 344, '通渭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3425, 344, '陇西县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3426, 344, '渭源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3427, 344, '临洮县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3428, 344, '漳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3429, 344, '岷县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3430, 344, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3431, 345, '武都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3432, 345, '成县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3433, 345, '文县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3434, 345, '宕昌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3435, 345, '康县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3436, 345, '西和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3437, 345, '礼县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3438, 345, '徽县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3439, 345, '两当县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3440, 345, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3441, 346, '临夏市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3442, 346, '临夏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3443, 346, '康乐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3444, 346, '永靖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3445, 346, '广河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3446, 346, '和政县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3447, 346, '东乡族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3448, 346, '积石山保安族东乡族撒拉族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3449, 346, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3450, 347, '合作市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3451, 347, '临潭县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3452, 347, '卓尼县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3453, 347, '舟曲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3454, 347, '迭部县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3455, 347, '玛曲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3456, 347, '碌曲县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3457, 347, '夏河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3458, 347, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3459, 348, '城东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3460, 348, '城中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3461, 348, '城西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3462, 348, '城北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3463, 348, '大通回族土族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3464, 348, '湟中县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3465, 348, '湟源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3466, 348, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3467, 349, '平安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3468, 349, '民和回族土族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3469, 349, '乐都区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3470, 349, '互助土族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3471, 349, '化隆回族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3472, 349, '循化撒拉族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3473, 349, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3474, 350, '门源回族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3475, 350, '祁连县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3476, 350, '海晏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3477, 350, '刚察县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3478, 350, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3479, 351, '同仁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3480, 351, '尖扎县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3481, 351, '泽库县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3482, 351, '河南蒙古族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3483, 351, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3484, 352, '共和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3485, 352, '同德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3486, 352, '贵德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3487, 352, '兴海县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3488, 352, '贵南县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3489, 352, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3490, 353, '玛沁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3491, 353, '班玛县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3492, 353, '甘德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3493, 353, '达日县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3494, 353, '久治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3495, 353, '玛多县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3496, 353, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3497, 354, '玉树市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3498, 354, '杂多县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3499, 354, '称多县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3500, 354, '治多县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3501, 354, '囊谦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3502, 354, '曲麻莱县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3503, 354, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3504, 355, '格尔木市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3505, 355, '德令哈市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3506, 355, '乌兰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3507, 355, '都兰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3508, 355, '天峻县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3509, 355, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3510, 356, '兴庆区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3511, 356, '西夏区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3512, 356, '金凤区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3513, 356, '永宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3514, 356, '贺兰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3515, 356, '灵武市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3516, 356, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3517, 357, '大武口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3518, 357, '惠农区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3519, 357, '平罗县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3520, 357, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3521, 358, '利通区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3522, 358, '红寺堡区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3523, 358, '盐池县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3524, 358, '同心县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3525, 358, '青铜峡市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3526, 358, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3527, 359, '原州区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3528, 359, '西吉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3529, 359, '隆德县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3530, 359, '泾源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3531, 359, '彭阳县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3532, 359, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3533, 360, '沙坡头区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3534, 360, '中宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3535, 360, '海原县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3536, 360, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3537, 361, '天山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3538, 361, '沙依巴克区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3539, 361, '新市区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3540, 361, '水磨沟区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3541, 361, '头屯河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3542, 361, '达坂城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3543, 361, '东山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3544, 361, '米东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3545, 361, '乌鲁木齐县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3546, 361, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3547, 362, '独山子区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3548, 362, '克拉玛依区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3549, 362, '白碱滩区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3550, 362, '乌尔禾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3551, 362, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3552, 363, '高昌区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3553, 363, '鄯善县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3554, 363, '托克逊县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3555, 363, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3556, 364, '哈密市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3557, 364, '巴里坤哈萨克自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3558, 364, '伊吾县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3559, 364, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3560, 365, '昌吉市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3561, 365, '阜康市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3562, 365, '米泉市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3563, 365, '呼图壁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3564, 365, '玛纳斯县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3565, 365, '奇台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3566, 365, '吉木萨尔县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3567, 365, '木垒哈萨克自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3568, 365, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3569, 366, '博乐市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3570, 366, '阿拉山口市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3571, 366, '精河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3572, 366, '温泉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3573, 366, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3574, 367, '库尔勒市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3575, 367, '轮台县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3576, 367, '尉犁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3577, 367, '若羌县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3578, 367, '且末县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3579, 367, '焉耆回族自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3580, 367, '和静县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3581, 367, '和硕县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3582, 367, '博湖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3583, 367, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3584, 368, '阿克苏市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3585, 368, '温宿县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3586, 368, '库车县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3587, 368, '沙雅县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3588, 368, '新和县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3589, 368, '拜城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3590, 368, '乌什县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3591, 368, '阿瓦提县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3592, 368, '柯坪县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3593, 368, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3594, 369, '阿图什市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3595, 369, '阿克陶县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3596, 369, '阿合奇县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3597, 369, '乌恰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3598, 369, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3599, 370, '喀什市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3600, 370, '疏附县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3601, 370, '疏勒县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3602, 370, '英吉沙县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3603, 370, '泽普县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3604, 370, '莎车县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3605, 370, '叶城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3606, 370, '麦盖提县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3607, 370, '岳普湖县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3608, 370, '伽师县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3609, 370, '巴楚县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3610, 370, '塔什库尔干塔吉克自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3611, 370, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3612, 371, '和田市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3613, 371, '和田县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3614, 371, '墨玉县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3615, 371, '皮山县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3616, 371, '洛浦县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3617, 371, '策勒县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3618, 371, '于田县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3619, 371, '民丰县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3620, 371, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3621, 372, '伊宁市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3622, 372, '奎屯市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3623, 372, '伊宁县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3624, 372, '察布查尔锡伯自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3625, 372, '霍城县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3626, 372, '巩留县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3627, 372, '新源县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3628, 372, '昭苏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3629, 372, '特克斯县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3630, 372, '尼勒克县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3631, 372, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3632, 373, '塔城市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3633, 373, '乌苏市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3634, 373, '额敏县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3635, 373, '沙湾县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3636, 373, '托里县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3637, 373, '裕民县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3638, 373, '和布克赛尔蒙古自治县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3639, 373, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3640, 374, '阿勒泰市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3641, 374, '布尔津县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3642, 374, '富蕴县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3643, 374, '福海县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3644, 374, '哈巴河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3645, 374, '青河县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3646, 374, '吉木乃县', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3647, 374, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3648, 375, '中正区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3649, 375, '大同区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3650, 375, '中山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3651, 375, '松山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3652, 375, '大安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3653, 375, '万华区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3654, 375, '信义区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3655, 375, '士林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3656, 375, '北投区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3657, 375, '内湖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3658, 375, '南港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3659, 375, '文山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3660, 375, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3661, 376, '新兴区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3662, 376, '前金区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3663, 376, '芩雅区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3664, 376, '盐埕区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3665, 376, '鼓山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3666, 376, '旗津区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3667, 376, '前镇区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3668, 376, '三民区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3669, 376, '左营区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3670, 376, '楠梓区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3671, 376, '小港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3672, 376, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3673, 376, '苓雅区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3674, 376, '仁武区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3675, 376, '大社区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3676, 376, '冈山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3677, 376, '路竹区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3678, 376, '阿莲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3679, 376, '田寮区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3680, 376, '燕巢区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3681, 376, '桥头区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3682, 376, '梓官区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3683, 376, '弥陀区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3684, 376, '永安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3685, 376, '湖内区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3686, 376, '凤山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3687, 376, '大寮区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3688, 376, '林园区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3689, 376, '鸟松区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3690, 376, '大树区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3691, 376, '旗山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3692, 376, '美浓区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3693, 376, '六龟区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3694, 376, '内门区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3695, 376, '杉林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3696, 376, '甲仙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3697, 376, '桃源区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3698, 376, '那玛夏区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3699, 376, '茂林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3700, 376, '茄萣区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3701, 377, '中西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3702, 377, '东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3703, 377, '南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3704, 377, '北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3705, 377, '安平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3706, 377, '安南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3707, 377, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3708, 377, '永康区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3709, 377, '归仁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3710, 377, '新化区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3711, 377, '左镇区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3712, 377, '玉井区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3713, 377, '楠西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3714, 377, '南化区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3715, 377, '仁德区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3716, 377, '关庙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3717, 377, '龙崎区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3718, 377, '官田区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3719, 377, '麻豆区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3720, 377, '佳里区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3721, 377, '西港区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3722, 377, '七股区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3723, 377, '将军区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3724, 377, '学甲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3725, 377, '北门区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3726, 377, '新营区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3727, 377, '后壁区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3728, 377, '白河区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3729, 377, '东山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3730, 377, '六甲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3731, 377, '下营区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3732, 377, '柳营区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3733, 377, '盐水区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3734, 377, '善化区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3735, 377, '大内区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3736, 377, '山上区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3737, 377, '新市区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3738, 377, '安定区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3739, 378, '中区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3740, 378, '东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3741, 378, '南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3742, 378, '西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3743, 378, '北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3744, 378, '北屯区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3745, 378, '西屯区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3746, 378, '南屯区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3747, 378, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3748, 378, '太平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3749, 378, '大里区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3750, 378, '雾峰区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3751, 378, '乌日区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3752, 378, '丰原区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3753, 378, '后里区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3754, 378, '石冈区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3755, 378, '东势区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3756, 378, '和平区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3757, 378, '新社区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3758, 378, '潭子区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3759, 378, '大雅区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3760, 378, '神冈区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3761, 378, '大肚区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3762, 378, '沙鹿区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3763, 378, '龙井区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3764, 378, '梧栖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3765, 378, '清水区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3766, 378, '大甲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3767, 378, '外埔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3768, 378, '大安区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3769, 379, '金沙镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3770, 379, '金湖镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3771, 379, '金宁乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3772, 379, '金城镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3773, 379, '烈屿乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3774, 379, '乌坵乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3775, 380, '南投市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3776, 380, '中寮乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3777, 380, '草屯镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3778, 380, '国姓乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3779, 380, '埔里镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3780, 380, '仁爱乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3781, 380, '名间乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3782, 380, '集集镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3783, 380, '水里乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3784, 380, '鱼池乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3785, 380, '信义乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3786, 380, '竹山镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3787, 380, '鹿谷乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3788, 381, '仁爱区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3789, 381, '信义区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3790, 381, '中正区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3791, 381, '中山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3792, 381, '安乐区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3793, 381, '暖暖区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3794, 381, '七堵区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3795, 381, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3796, 382, '东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3797, 382, '北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3798, 382, '香山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3799, 382, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3800, 383, '东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3801, 383, '西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3802, 383, '其它区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3803, 384, '万里区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3804, 384, '金山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3805, 384, '板桥区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3806, 384, '汐止区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3807, 384, '深坑区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3808, 384, '石碇区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3809, 384, '瑞芳区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3810, 384, '平溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3811, 384, '双溪区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3812, 384, '贡寮区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3813, 384, '新店区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3814, 384, '坪林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3815, 384, '乌来区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3816, 384, '永和区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3817, 384, '中和区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3818, 384, '土城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3819, 384, '三峡区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3820, 384, '树林区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3821, 384, '莺歌区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3822, 384, '三重区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3823, 384, '新庄区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3824, 384, '泰山区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3825, 384, '林口区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3826, 384, '芦洲区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3827, 384, '五股区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3828, 384, '八里区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3829, 384, '淡水区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3830, 384, '三芝区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3831, 384, '石门区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3832, 385, '宜兰市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3833, 385, '头城镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3834, 385, '礁溪乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3835, 385, '壮围乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3836, 385, '员山乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3837, 385, '罗东镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3838, 385, '三星乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3839, 385, '大同乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3840, 385, '五结乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3841, 385, '冬山乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3842, 385, '苏澳镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3843, 385, '南澳乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3844, 385, '钓鱼台', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3845, 386, '竹北市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3846, 386, '湖口乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3847, 386, '新丰乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3848, 386, '新埔镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3849, 386, '关西镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3850, 386, '芎林乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3851, 386, '宝山乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3852, 386, '竹东镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3853, 386, '五峰乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3854, 386, '横山乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3855, 386, '尖石乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3856, 386, '北埔乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3857, 386, '峨眉乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3858, 387, '中坜市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3859, 387, '平镇市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3860, 387, '龙潭乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3861, 387, '杨梅市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3862, 387, '新屋乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3863, 387, '观音乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3864, 387, '桃园市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3865, 387, '龟山乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3866, 387, '八德市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3867, 387, '大溪镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3868, 387, '复兴乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3869, 387, '大园乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3870, 387, '芦竹乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3871, 388, '竹南镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3872, 388, '头份镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3873, 388, '三湾乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3874, 388, '南庄乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3875, 388, '狮潭乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3876, 388, '后龙镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3877, 388, '通霄镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3878, 388, '苑里镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3879, 388, '苗栗市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3880, 388, '造桥乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3881, 388, '头屋乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3882, 388, '公馆乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3883, 388, '大湖乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3884, 388, '泰安乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3885, 388, '铜锣乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3886, 388, '三义乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3887, 388, '西湖乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3888, 388, '卓兰镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3889, 389, '彰化市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3890, 389, '芬园乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3891, 389, '花坛乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3892, 389, '秀水乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3893, 389, '鹿港镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3894, 389, '福兴乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3895, 389, '线西乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3896, 389, '和美镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3897, 389, '伸港乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3898, 389, '员林镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3899, 389, '社头乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3900, 389, '永靖乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3901, 389, '埔心乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3902, 389, '溪湖镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3903, 389, '大村乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3904, 389, '埔盐乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3905, 389, '田中镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3906, 389, '北斗镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3907, 389, '田尾乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3908, 389, '埤头乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3909, 389, '溪州乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3910, 389, '竹塘乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3911, 389, '二林镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3912, 389, '大城乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3913, 389, '芳苑乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3914, 389, '二水乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3915, 390, '番路乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3916, 390, '梅山乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3917, 390, '竹崎乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3918, 390, '阿里山乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3919, 390, '中埔乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3920, 390, '大埔乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3921, 390, '水上乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3922, 390, '鹿草乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3923, 390, '太保市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3924, 390, '朴子市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3925, 390, '东石乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3926, 390, '六脚乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3927, 390, '新港乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3928, 390, '民雄乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3929, 390, '大林镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3930, 390, '溪口乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3931, 390, '义竹乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3932, 390, '布袋镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3933, 391, '斗南镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3934, 391, '大埤乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3935, 391, '虎尾镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3936, 391, '土库镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3937, 391, '褒忠乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3938, 391, '东势乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3939, 391, '台西乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3940, 391, '仑背乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3941, 391, '麦寮乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3942, 391, '斗六市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3943, 391, '林内乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3944, 391, '古坑乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3945, 391, '莿桐乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3946, 391, '西螺镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3947, 391, '二仑乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3948, 391, '北港镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3949, 391, '水林乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3950, 391, '口湖乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3951, 391, '四湖乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3952, 391, '元长乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3953, 392, '屏东市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3954, 392, '三地门乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3955, 392, '雾台乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3956, 392, '玛家乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3957, 392, '九如乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3958, 392, '里港乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3959, 392, '高树乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3960, 392, '盐埔乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3961, 392, '长治乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3962, 392, '麟洛乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3963, 392, '竹田乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3964, 392, '内埔乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3965, 392, '万丹乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3966, 392, '潮州镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3967, 392, '泰武乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3968, 392, '来义乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3969, 392, '万峦乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3970, 392, '崁顶乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3971, 392, '新埤乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3972, 392, '南州乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3973, 392, '林边乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3974, 392, '东港镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3975, 392, '琉球乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3976, 392, '佳冬乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3977, 392, '新园乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3978, 392, '枋寮乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3979, 392, '枋山乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3980, 392, '春日乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3981, 392, '狮子乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3982, 392, '车城乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3983, 392, '牡丹乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3984, 392, '恒春镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3985, 392, '满州乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3986, 393, '台东市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3987, 393, '绿岛乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3988, 393, '兰屿乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3989, 393, '延平乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3990, 393, '卑南乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3991, 393, '鹿野乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3992, 393, '关山镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3993, 393, '海端乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3994, 393, '池上乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3995, 393, '东河乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3996, 393, '成功镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3997, 393, '长滨乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3998, 393, '金峰乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (3999, 393, '大武乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4000, 393, '达仁乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4001, 393, '太麻里乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4002, 394, '花莲市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4003, 394, '新城乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4004, 394, '太鲁阁', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4005, 394, '秀林乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4006, 394, '吉安乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4007, 394, '寿丰乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4008, 394, '凤林镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4009, 394, '光复乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4010, 394, '丰滨乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4011, 394, '瑞穗乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4012, 394, '万荣乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4013, 394, '玉里镇', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4014, 394, '卓溪乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4015, 394, '富里乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4016, 395, '马公市', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4017, 395, '西屿乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4018, 395, '望安乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4019, 395, '七美乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4020, 395, '白沙乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4021, 395, '湖西乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4022, 396, '南竿乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4023, 396, '北竿乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4024, 396, '莒光乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4025, 396, '东引乡', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4026, 397, '中西区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4027, 397, '湾仔', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4028, 397, '东区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4029, 397, '南区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4030, 398, '九龙城区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4031, 398, '油尖旺区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4032, 398, '深水埗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4033, 398, '黄大仙区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4034, 398, '观塘区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4035, 399, '北区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4036, 399, '大埔区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4037, 399, '沙田区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4038, 399, '西贡区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4039, 399, '元朗区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4040, 399, '屯门区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4041, 399, '荃湾区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4042, 399, '葵青区', 3, 0);
INSERT INTO `bbgshop_region` VALUES (4043, 399, '离岛区', 3, 0);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_related_goods
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_related_goods`;
CREATE TABLE `bbgshop_related_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` binary(32) NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `related_goods_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for bbgshop_search_history
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_search_history`;
CREATE TABLE `bbgshop_search_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` char(50) NOT NULL,
  `from` varchar(45) NOT NULL DEFAULT '' COMMENT '搜索来源，如PC、小程序、APP等',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '搜索时间',
  `user_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_search_history
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_search_history` VALUES (23, '母亲节', '', 1500564813, '1');
INSERT INTO `bbgshop_search_history` VALUES (24, '日式', '', 1500564816, '1');
INSERT INTO `bbgshop_search_history` VALUES (25, '日式', '', 1500564822, '1');
INSERT INTO `bbgshop_search_history` VALUES (26, '清新', '', 1500564835, '1');
INSERT INTO `bbgshop_search_history` VALUES (27, '日式', '', 1500638161, '1');
INSERT INTO `bbgshop_search_history` VALUES (30, '日式', '', 1520570594, '14');
INSERT INTO `bbgshop_search_history` VALUES (31, '日式', '', 1520570596, '14');
INSERT INTO `bbgshop_search_history` VALUES (32, '日式', '', 1520570596, '14');
INSERT INTO `bbgshop_search_history` VALUES (33, '日式', '', 1520570597, '14');
INSERT INTO `bbgshop_search_history` VALUES (34, '日式', '', 1520570598, '14');
INSERT INTO `bbgshop_search_history` VALUES (35, '日式', '', 1520570600, '14');
INSERT INTO `bbgshop_search_history` VALUES (36, '日式', '', 1520570601, '14');
INSERT INTO `bbgshop_search_history` VALUES (37, '日式', '', 1520989537, '14');
INSERT INTO `bbgshop_search_history` VALUES (38, '秋冬', '', 1521803829, '14');
INSERT INTO `bbgshop_search_history` VALUES (39, '单鞋', '', 1522111435, '14');
INSERT INTO `bbgshop_search_history` VALUES (40, '秋冬', '', 1522289300, '14');
INSERT INTO `bbgshop_search_history` VALUES (41, '秋冬', '', 1522289303, '14');
INSERT INTO `bbgshop_search_history` VALUES (42, '秋冬', '', 1522289306, '14');
INSERT INTO `bbgshop_search_history` VALUES (43, '秋冬', '', 1522289307, '14');
INSERT INTO `bbgshop_search_history` VALUES (44, '秋冬', '', 1522289308, '14');
INSERT INTO `bbgshop_search_history` VALUES (45, '秋冬', '', 1522289310, '14');
INSERT INTO `bbgshop_search_history` VALUES (46, '秋冬', '', 1522289311, '14');
INSERT INTO `bbgshop_search_history` VALUES (47, '日式', '', 1522289315, '14');
INSERT INTO `bbgshop_search_history` VALUES (48, '耳钉', '', 1522652451, '21');
INSERT INTO `bbgshop_search_history` VALUES (50, '丘比特', '', 1525415790, '32');
INSERT INTO `bbgshop_search_history` VALUES (105, '施华洛世奇', '', 1527226572, '34');
INSERT INTO `bbgshop_search_history` VALUES (106, '施华洛世奇', '', 1527226574, '34');
INSERT INTO `bbgshop_search_history` VALUES (107, '施华洛世奇', '', 1529886910, '34');
INSERT INTO `bbgshop_search_history` VALUES (108, '施华洛世奇', '', 1529919061, '34');
INSERT INTO `bbgshop_search_history` VALUES (109, '施华洛世奇', '', 1530232410, '34');
INSERT INTO `bbgshop_search_history` VALUES (110, '施华洛世奇', '', 1530232443, '34');
INSERT INTO `bbgshop_search_history` VALUES (111, 's', '', 1530241367, '32');
INSERT INTO `bbgshop_search_history` VALUES (112, '施华洛世奇', '', 1530493138, '34');
INSERT INTO `bbgshop_search_history` VALUES (113, '施华洛世奇', '', 1530692285, '34');
INSERT INTO `bbgshop_search_history` VALUES (114, '施华洛世奇', '', 1530753143, '34');
INSERT INTO `bbgshop_search_history` VALUES (115, '123131', '', 1530754103, '34');
INSERT INTO `bbgshop_search_history` VALUES (116, '123131', '', 1530754239, '34');
INSERT INTO `bbgshop_search_history` VALUES (117, '23', '', 1530754354, '34');
INSERT INTO `bbgshop_search_history` VALUES (118, '施华洛世奇', '', 1530778786, '34');
INSERT INTO `bbgshop_search_history` VALUES (119, '施华洛世奇', '', 1530780446, '34');
INSERT INTO `bbgshop_search_history` VALUES (120, '施华洛世奇', '', 1530780505, '34');
INSERT INTO `bbgshop_search_history` VALUES (121, '施华洛世奇', '', 1530780556, '34');
INSERT INTO `bbgshop_search_history` VALUES (122, '施华洛世奇', '', 1530780584, '34');
INSERT INTO `bbgshop_search_history` VALUES (123, '施华洛世奇', '', 1530780788, '34');
INSERT INTO `bbgshop_search_history` VALUES (124, '施华洛世奇', '', 1530780852, '34');
INSERT INTO `bbgshop_search_history` VALUES (125, '施华洛世奇', '', 1530780865, '34');
INSERT INTO `bbgshop_search_history` VALUES (126, '施华洛世奇', '', 1530780882, '34');
INSERT INTO `bbgshop_search_history` VALUES (127, '施华洛世奇', '', 1530780893, '34');
INSERT INTO `bbgshop_search_history` VALUES (128, '施华洛世奇', '', 1530780895, '34');
INSERT INTO `bbgshop_search_history` VALUES (129, '施华洛世奇', '', 1530780895, '34');
INSERT INTO `bbgshop_search_history` VALUES (130, '施华洛世奇', '', 1530780896, '34');
INSERT INTO `bbgshop_search_history` VALUES (131, '施华洛世奇', '', 1530782079, '34');
INSERT INTO `bbgshop_search_history` VALUES (132, '施华洛世奇', '', 1530782169, '34');
INSERT INTO `bbgshop_search_history` VALUES (133, '施华洛世奇', '', 1530838723, '34');
INSERT INTO `bbgshop_search_history` VALUES (149, '施华洛世奇', '', 1531705450, '37');
INSERT INTO `bbgshop_search_history` VALUES (150, '施华洛世奇', '', 1531705503, '37');
INSERT INTO `bbgshop_search_history` VALUES (151, '丘比特', '', 1531804724, '32');
INSERT INTO `bbgshop_search_history` VALUES (152, '施华洛世奇', '', 1531804793, '37');
INSERT INTO `bbgshop_search_history` VALUES (153, 'qiubite', '', 1531804806, '37');
INSERT INTO `bbgshop_search_history` VALUES (154, '手链', '', 1531804810, '37');
INSERT INTO `bbgshop_search_history` VALUES (155, '施华洛世奇', '', 1531804844, '37');
INSERT INTO `bbgshop_search_history` VALUES (156, '手链', '', 1531804848, '37');
INSERT INTO `bbgshop_search_history` VALUES (157, '手链', '', 1531804897, '37');
INSERT INTO `bbgshop_search_history` VALUES (158, '手链', '', 1531806087, '37');
INSERT INTO `bbgshop_search_history` VALUES (159, '手链', '', 1531806102, '37');
INSERT INTO `bbgshop_search_history` VALUES (160, '手链', '', 1531806116, '37');
INSERT INTO `bbgshop_search_history` VALUES (161, '手链', '', 1532406871, '107');
INSERT INTO `bbgshop_search_history` VALUES (162, '手链', '', 1532406890, '107');
INSERT INTO `bbgshop_search_history` VALUES (195, '绿', '', 1533803839, '40');
INSERT INTO `bbgshop_search_history` VALUES (196, '施华洛世奇', '', 1533803851, '40');
INSERT INTO `bbgshop_search_history` VALUES (197, '施华洛 世奇', '', 1533803854, '40');
INSERT INTO `bbgshop_search_history` VALUES (198, '施华洛 世奇', '', 1533803860, '40');
INSERT INTO `bbgshop_search_history` VALUES (199, '项链', '', 1533803869, '40');
INSERT INTO `bbgshop_search_history` VALUES (200, '施华洛世奇', '', 1533803915, '40');
INSERT INTO `bbgshop_search_history` VALUES (201, '绿', '', 1533803922, '40');
INSERT INTO `bbgshop_search_history` VALUES (202, '施华洛世 奇', '', 1533803936, '40');
INSERT INTO `bbgshop_search_history` VALUES (203, '施华洛世 奇', '', 1533803940, '40');
INSERT INTO `bbgshop_search_history` VALUES (204, '施华洛', '', 1533803952, '40');
INSERT INTO `bbgshop_search_history` VALUES (205, '施华洛世奇', '', 1533803955, '40');
INSERT INTO `bbgshop_search_history` VALUES (206, '施华洛世奇', '', 1533803958, '40');
INSERT INTO `bbgshop_search_history` VALUES (207, '施华洛 世奇', '', 1533876801, '40');
INSERT INTO `bbgshop_search_history` VALUES (208, '施华   洛 世奇', '', 1533876806, '40');
INSERT INTO `bbgshop_search_history` VALUES (209, '施华   洛 世奇 绿', '', 1533876819, '40');
INSERT INTO `bbgshop_search_history` VALUES (210, '绿施华   洛 世奇', '', 1533876833, '40');
INSERT INTO `bbgshop_search_history` VALUES (211, '绿 施华   洛 世奇', '', 1533876840, '40');
INSERT INTO `bbgshop_search_history` VALUES (212, '手环', '', 1533957714, '42');
INSERT INTO `bbgshop_search_history` VALUES (213, '施华洛世奇', '', 1533957717, '42');
INSERT INTO `bbgshop_search_history` VALUES (214, '施华洛世奇', '', 1533963056, '42');
INSERT INTO `bbgshop_search_history` VALUES (215, '零食', '', 1534300575, '42');
INSERT INTO `bbgshop_search_history` VALUES (216, '零 食', '', 1534301670, '42');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_shipper
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_shipper`;
CREATE TABLE `bbgshop_shipper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '快递公司名称',
  `code` varchar(10) NOT NULL DEFAULT '' COMMENT '快递公司代码',
  `sort_order` int(11) NOT NULL DEFAULT '10' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `bbgshop_shipper_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COMMENT='快递公司';

-- ----------------------------
-- Records of bbgshop_shipper
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_shipper` VALUES (1, '顺丰速运', 'SF', 1);
INSERT INTO `bbgshop_shipper` VALUES (2, '百世快递', 'HTKY', 2);
INSERT INTO `bbgshop_shipper` VALUES (3, '中通快递', 'ZTO', 3);
INSERT INTO `bbgshop_shipper` VALUES (4, '申通快递', 'STO', 4);
INSERT INTO `bbgshop_shipper` VALUES (5, '圆通速递', 'YTO', 5);
INSERT INTO `bbgshop_shipper` VALUES (6, '韵达速递', 'YD', 6);
INSERT INTO `bbgshop_shipper` VALUES (7, '邮政快递包裹', 'YZPY', 7);
INSERT INTO `bbgshop_shipper` VALUES (8, 'EMS', 'EMS', 8);
INSERT INTO `bbgshop_shipper` VALUES (9, '天天快递', 'HHTT', 9);
INSERT INTO `bbgshop_shipper` VALUES (10, '京东物流', 'JD', 10);
INSERT INTO `bbgshop_shipper` VALUES (11, '全峰快递', 'QFKD', 11);
INSERT INTO `bbgshop_shipper` VALUES (12, '国通快递', 'GTO', 12);
INSERT INTO `bbgshop_shipper` VALUES (13, '优速快递', 'UC', 13);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_specification
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_specification`;
CREATE TABLE `bbgshop_specification` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `sort_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COMMENT='规格表';

-- ----------------------------
-- Records of bbgshop_specification
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_specification` VALUES (38, '颜色', 1);
INSERT INTO `bbgshop_specification` VALUES (39, '长度', 2);
INSERT INTO `bbgshop_specification` VALUES (40, '大小', 3);
INSERT INTO `bbgshop_specification` VALUES (41, '规格', 1);
INSERT INTO `bbgshop_specification` VALUES (42, '123', 1);
INSERT INTO `bbgshop_specification` VALUES (43, 'y7ans额', 1);
INSERT INTO `bbgshop_specification` VALUES (44, '1234', 1);
INSERT INTO `bbgshop_specification` VALUES (45, '123234', 1);
INSERT INTO `bbgshop_specification` VALUES (46, '2134', 1);
INSERT INTO `bbgshop_specification` VALUES (47, '345', 1);
INSERT INTO `bbgshop_specification` VALUES (48, '配置', 3);
INSERT INTO `bbgshop_specification` VALUES (49, '234', 2);
INSERT INTO `bbgshop_specification` VALUES (50, '萨达f', 1);
INSERT INTO `bbgshop_specification` VALUES (51, '', 1);
INSERT INTO `bbgshop_specification` VALUES (52, '测试规格名 1', 1);
INSERT INTO `bbgshop_specification` VALUES (53, '测试规格名 2', 2);
INSERT INTO `bbgshop_specification` VALUES (54, '测试规格名 3', 3);
INSERT INTO `bbgshop_specification` VALUES (55, '规格1', 0);
INSERT INTO `bbgshop_specification` VALUES (56, '规格2', 1);
INSERT INTO `bbgshop_specification` VALUES (57, '规格值2', 1);
INSERT INTO `bbgshop_specification` VALUES (58, '规格3', 2);
INSERT INTO `bbgshop_specification` VALUES (59, '规格名1', 0);
INSERT INTO `bbgshop_specification` VALUES (60, '规格名2', 1);
INSERT INTO `bbgshop_specification` VALUES (61, '规格名3', 2);
INSERT INTO `bbgshop_specification` VALUES (62, '测试规格一', 0);
INSERT INTO `bbgshop_specification` VALUES (63, '测试规格二', 1);
INSERT INTO `bbgshop_specification` VALUES (64, '测试规格三', 2);
INSERT INTO `bbgshop_specification` VALUES (69, '重量', 2);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_supplier
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_supplier`;
CREATE TABLE `bbgshop_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `create_time` varchar(32) NOT NULL DEFAULT '0',
  `handel_time` varchar(32) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_supplier
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_supplier` VALUES (2, '供货商1', '1533188080263', '1533188295382');
INSERT INTO `bbgshop_supplier` VALUES (3, '供货商2', '1533188301942', '1533188301942');
INSERT INTO `bbgshop_supplier` VALUES (4, '供货商3', '1533188308519', '1533188308519');
INSERT INTO `bbgshop_supplier` VALUES (5, '供货商4', '1533188316862', '1533188316862');
INSERT INTO `bbgshop_supplier` VALUES (6, '贝堡', '1533259644024', '1533259644024');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_topic
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_topic`;
CREATE TABLE `bbgshop_topic` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '''''',
  `content` text,
  `avatar` varchar(255) NOT NULL DEFAULT '',
  `item_pic_url` varchar(255) NOT NULL DEFAULT '',
  `subtitle` varchar(255) NOT NULL DEFAULT '''',
  `topic_category_id` int(11) unsigned NOT NULL DEFAULT '0',
  `price_info` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `read_count` varchar(255) NOT NULL DEFAULT '0',
  `scene_pic_url` varchar(255) NOT NULL DEFAULT '',
  `topic_template_id` int(11) unsigned NOT NULL DEFAULT '0',
  `topic_tag_id` int(11) unsigned NOT NULL DEFAULT '0',
  `sort_order` int(11) unsigned NOT NULL DEFAULT '100',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1',
  KEY `topic_id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=316 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_topic
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_topic` VALUES (314, '关爱他成长的每一个足迹', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14943186689221563.png', 'https://yanxuan.nosdn.127.net/14943267735961674.jpg', '专业运动品牌同厂，毛毛虫鞋买二送一', 2, 0.00, '6.4k', 'http://127.0.0.1:8360/static/upload/topic/0f7d63fe-778c-4f8d-9615-ed40dcc6afc6.jpg', 0, 0, 1, 1);
INSERT INTO `bbgshop_topic` VALUES (313, '一次解决5个节日送礼难题', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14942967243991290.png', 'https://yanxuan.nosdn.127.net/14942996754171334.jpg', '这些就是他们想要的礼a qqa a a ', 0, 59.90, '7.8k', 'https://yanxuan.nosdn.127.net/14942996754171334.jpg', 0, 0, 1, 1);
INSERT INTO `bbgshop_topic` VALUES (300, '秒杀化学洗涤剂的纯天然皂', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14939843011001088.png', 'https://yanxuan.nosdn.127.net/14939843143621089.jpg', '前段时间有朋友跟我抱怨，和婆婆住到一起才发现生活理念有太多不和。别的不提，光是洗...', 1, 0.00, '15.3k', 'https://yanxuan.nosdn.127.net/14939843143621089.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (299, '买过的人都说它是差旅神器', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14938873720850678.png', 'https://yanxuan.nosdn.127.net/14938873919030679.jpg', '许多人经历过旅途中内裤洗晾不便的烦恼，尤其与旅伴同居一室时，晾在卫生间里的内裤更...', 1, 0.00, '28.7k', 'https://yanxuan.nosdn.127.net/14938873919030679.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (295, '他们在严选遇见的新生活', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14937987677390284.png', 'https://yanxuan.nosdn.127.net/14938092956370380.jpg', '多款商品直减中，最高直减400元', 0, 35.80, '36.6k', 'https://yanxuan.nosdn.127.net/14938092956370380.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (294, '这只锅，可以从祖母用到孙辈', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14937214529340142.png', 'https://yanxuan.nosdn.127.net/14937214454750141.jpg', '买100年传世珐琅锅送迷你马卡龙色小锅', 4, 149.00, '108.1k', 'https://yanxuan.nosdn.127.net/14937214454750141.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (291, '舒适新主张', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14933596154560938.png', 'https://yanxuan.nosdn.127.net/14939496197300723.jpg', '如何挑选适合自己的好物？', 0, 29.00, '67.8k', 'https://yanxuan.nosdn.127.net/14939496197300723.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (289, '专业运动袜也可以高性价比', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14932840884890614.png', 'https://yanxuan.nosdn.127.net/14932840600970609.jpg', '越来越多运动人士意识到，运动鞋要购置好的，鞋里的运动袜也不可忽视。专业运动袜帮助...', 1, 0.00, '11.9k', 'https://yanxuan.nosdn.127.net/14932840600970609.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (287, '严选新式样板间', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14931133750100134.png', 'https://yanxuan.nosdn.127.net/14931970965550315.jpg', '一种软装一个家', 3, 29.90, '55.6k', 'https://yanxuan.nosdn.127.net/14931970965550315.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (286, '无“油”无虑的甜蜜酥脆', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14931121505610125.png', 'https://yanxuan.nosdn.127.net/14931121822100127.jpg', '大家都知道，饮食组是严选体重最重的一组，基本上每个新人都能在一个月之内迅速长胖。...', 1, 0.00, '15.6k', 'https://yanxuan.nosdn.127.net/14931121822100127.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (281, '条纹新风尚', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14926859949660827.png', 'https://yanxuan.nosdn.127.net/14926859849200826.jpg', '经典百搭，时尚线条', 3, 29.00, '76.5k', 'https://yanxuan.nosdn.127.net/14926859849200826.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (282, '成就一室笋香', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14927695155801070.png', 'https://yanxuan.nosdn.127.net/14927695046601069.jpg', '三石哥办公室常备小食推荐', 2, 12.00, '40.9k', 'https://yanxuan.nosdn.127.net/14927695046601069.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (283, '孩子成长中少不了的一双鞋', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14927748094971079.png', 'https://yanxuan.nosdn.127.net/14927748974441080.jpg', '说起毛毛虫鞋，好处实在太多了，作为一个2岁孩子的宝妈选品员，按捺不住想告诉大家，...', 1, 0.00, '42.5k', 'https://yanxuan.nosdn.127.net/14927748974441080.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (277, '治愈生活的满怀柔软', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14926748590030593.png', 'https://yanxuan.nosdn.127.net/14926737925770587.jpg', '太鼓抱枕的上架历程，是从失踪开始的。由于表面的绒感，最初它被安排在秋冬季上架。某...', 1, 0.00, '19.6k', 'https://yanxuan.nosdn.127.net/14926737925770587.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (274, '没有软木拖，怎么过夏天', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14925821004620235.png', 'https://yanxuan.nosdn.127.net/14925822213780237.jpg', '刚入四月，杭州的气温就已升高至30度。店庆时买了软木拖的用户，陆续发回评价说，很...', 1, 0.00, '46.4k', 'https://yanxuan.nosdn.127.net/14925822213780237.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (272, '料理也要精细简单', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14925201467400187.png', 'https://yanxuan.nosdn.127.net/14925200530030186.jpg', '享受天然的味道，日子每天都好新鲜', 2, 69.00, '125.6k', 'https://yanxuan.nosdn.127.net/14925200530030186.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (271, '选式新懒人', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14924199159971698.png', 'https://yanxuan.nosdn.127.net/14924199099661697.jpg', '懒出格调，懒出好生活。', 3, 15.00, '57.7k', 'https://yanxuan.nosdn.127.net/14924199099661697.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (268, '米饭好吃的秘诀：会呼吸的锅', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14920712417610604.png', 'https://yanxuan.nosdn.127.net/14920623353130483.jpg', '今年1月份，我们联系到了日本伊贺地区的长谷园，那里有着180年伊贺烧历史的窑厂。...', 1, 0.00, '33.3k', 'https://yanxuan.nosdn.127.net/14920623353130483.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (266, '一条丝巾就能提升时髦度', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14919005600900208.png', 'https://yanxuan.nosdn.127.net/14919007135160213.jpg', '不知道大家对去年G20时，严选与国礼制造商一起推出的《凤凰于飞》等几款丝巾是否还...', 1, 0.00, '35.0k', 'https://yanxuan.nosdn.127.net/14919007135160213.jpg', 0, 0, 0, 1);
INSERT INTO `bbgshop_topic` VALUES (264, '设计师们推荐的应季好物', '<img src=\"//yanxuan.nosdn.127.net/75c55a13fde5eb2bc2dd6813b4c565cc.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/e27e1de2b271a28a21c10213b9df7e95.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/9d413d1d28f753cb19096b533d53418d.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/64b0f2f350969e9818a3b6c43c217325.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/a668e6ae7f1fa45565c1eac221787570.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/0d4004e19728f2707f08f4be79bbc774.jpg\">\n    <img src=\"//yanxuan.nosdn.127.net/79ee021bbe97de7ecda691de6787241f.jpg\">', 'https://yanxuan.nosdn.127.net/14920662001560500.png', 'https://yanxuan.nosdn.127.net/14918201901050274.jpg', '原创设计春款系列上新', 0, 29.90, '77.7k', 'https://yanxuan.nosdn.127.net/14918201901050274.jpg', 0, 0, 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_topic_category
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_topic_category`;
CREATE TABLE `bbgshop_topic_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL DEFAULT '',
  `pic_url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_topic_category
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_topic_category` VALUES (1, '严选幕后', 'https://yanxuan.nosdn.127.net/dc1b671ad54e16339f1b26cfeec6a1ea.jpg');
INSERT INTO `bbgshop_topic_category` VALUES (2, '丁磊私物推荐', 'https://yanxuan.nosdn.127.net/1de4da49367dd7c01af1f7a2b23b0237.jpg');
INSERT INTO `bbgshop_topic_category` VALUES (3, '特色系列', 'https://yanxuan.nosdn.127.net/14939888170021096.png');
INSERT INTO `bbgshop_topic_category` VALUES (4, '明星商品', 'https://yanxuan.nosdn.127.net/14939888168151095.png');
INSERT INTO `bbgshop_topic_category` VALUES (5, '严选推荐', 'https://yanxuan.nosdn.127.net/d943675462a06f817d33062d4eb059f5.jpg');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_user
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_user`;
CREATE TABLE `bbgshop_user` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(60) NOT NULL DEFAULT '',
  `password` varchar(32) NOT NULL DEFAULT '',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `birthday` int(11) unsigned NOT NULL DEFAULT '0',
  `register_time` int(11) unsigned NOT NULL DEFAULT '0',
  `last_login_time` int(11) unsigned NOT NULL DEFAULT '0',
  `last_login_ip` varchar(15) NOT NULL DEFAULT '',
  `user_level_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(60) NOT NULL,
  `mobile` varchar(20) NOT NULL DEFAULT '',
  `register_ip` varchar(45) NOT NULL DEFAULT '',
  `avatar` varchar(255) NOT NULL DEFAULT '',
  `weixin_openid` varchar(50) NOT NULL DEFAULT '',
  `integral` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `user_all_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户总消费',
  `user_recharge_monery` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '用户充值的金额',
  `user_level` int(2) NOT NULL DEFAULT '0',
  `user_discount` decimal(10,2) NOT NULL DEFAULT '1.00',
  `user_level_is_fockers` int(2) NOT NULL DEFAULT '0',
  `user_level_name` varchar(128) NOT NULL DEFAULT '0',
  `mobile_country` varchar(64) DEFAULT NULL,
  `mobile_country_code` varchar(64) DEFAULT NULL,
  `mobile_code` varchar(64) DEFAULT NULL,
  `mobile_country_e` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_user
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_user` VALUES (43, 'sdfsdfsdf', 'sadfsadfasdf', 0, 0, 0, 0, '', 0, 'ceshi', '', '', '', '', 0, 0.00, 0.00, 0, 1.00, 0, '普通用户', NULL, NULL, NULL, NULL);
INSERT INTO `bbgshop_user` VALUES (42, '微信用户1cd180ed-d0a3-444c-b5f8-07343a40e11a', 'oJ-tr5QMA-A8Udc8ejjYmG9VvFyA', 1, 0, 1533949099, 1534408918, '', 0, '余生与诗 ', '18020525538', '', 'https://wx.qlogo.cn/mmopen/vi_32/h9YpuwGibvfD8dBC1UbicjPRxNYObn1oa2sdzbUqdOIf0ggibibvO5OjWtah73gTKlOZiaMe3ZuM5lib1AVS3gy5XibPQ/132', 'oJ-tr5QMA-A8Udc8ejjYmG9VvFyA', 0, 14107.71, 0.01, 3, 9.40, 0, '白金会员', '特克斯和凯科斯群岛	', 'TC', '1649', 'Turks and Caicos Islands');
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_user_level
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_user_level`;
CREATE TABLE `bbgshop_user_level` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `recharge_monery` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '充值所需金额',
  `consumption_monery` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '消费所需金额',
  `discount_scale` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '折扣比例',
  `level` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_user_level
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_user_level` VALUES (1, '普通会员', 300.00, 1000.00, 9.80, 0);
INSERT INTO `bbgshop_user_level` VALUES (2, '大众会员', 800.00, 3000.00, 9.60, 0);
INSERT INTO `bbgshop_user_level` VALUES (3, '白金会员', 2000.00, 6000.00, 9.40, 0);
INSERT INTO `bbgshop_user_level` VALUES (4, '黄金会员', 5000.00, 150000.00, 9.20, 0);
COMMIT;

-- ----------------------------
-- Table structure for bbgshop_user_level_rules
-- ----------------------------
DROP TABLE IF EXISTS `bbgshop_user_level_rules`;
CREATE TABLE `bbgshop_user_level_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of bbgshop_user_level_rules
-- ----------------------------
BEGIN;
INSERT INTO `bbgshop_user_level_rules` VALUES (1, 2);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
