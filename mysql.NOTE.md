# mysql 操作

## .sq配置文件说明

1. 创建数据库
CREATE DATABASE `dwshop`; 

2. 设置填充的数据库
USE `dwshop`;

3. 创建表table， 并插入数据

/* 创建table表 */

DROP TABLE IF EXISTS `bbgshop_ad`;

CREATE TABLE `bbgshop_ad` (
  // 属性字段及配置
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

/*Data for the table `bbgshop_ad` */

insert  into `bbgshop_ad` (`id`,`ad_position_id`,`media_type`,`name`,`link`,`image_url`,`content`,`end_time`,`enabled`) values (174,1,1,'售后指南 (指定页面) ','/pages/ucenter/AftersaleGuide/AftersaleGuide','http://resource.bbgshop.com/Fp2YGSTKuVR-Rq5hgXZ2Z86dQ1aT','哈哈哈',0,1),(175,1,1,'轻奢首饰 (一级分类) ','/pages/category/category?id=1036030','http://resource.bbgshop.com/FmeLmWLzWZsMV3LaabncbSVFR5ls','zanwu',0,1),(176,1,1,'砍价页面 (指定页面) ','/pages/Resagin_bargain/Resagin_bargain','http://resource.bbgshop.com/FgP6H7EOwKfKx3scwIQG0DomJmL4','哈哈哈',0,1);

#### 引擎
MySQL默认的存储引擎是MyISAM，其他常用的就是InnoDB了。

#### AUTO_INCREMENT

就是insert的时候，这个字段的值会自动加1，一般用来作为主键，很方便的

#### key
索引用于： 

快速找出匹配一个WHERE子句的行； 
当执行联结时，从其他表检索行； 
对特定的索引列找出MAX()或MIN()值； 
如果排序或分组在一个可用键的最左面前缀上进行(例如，ORDER BY key_part_1,key_part_2)，排序或分组一个表。

如果所有键值部分跟随DESC，键以倒序被读取。 
在一些情况中，一个查询能被优化来检索值，不用咨询数据文件。

如果对某些表的所有使用的列是数字型的并且构成某些键的最左面前缀，为了更快，值可以从索引树被检索出来。 

key 是数据库的物理结构，它包含两层意义和作用，

一是约束（偏重于约束和规范数据库的结构完整性），

二是索引（辅助查询用的）。

**SQL PRIMARY KEY 约束** 

PRIMARY KEY 约束唯一标识数据库表中的每条记录。

主键必须包含唯一的值。

主键列不能包含 NULL 值。

每个表都应该有一个主键，并且每个表只能有一个主键。

**unique key** 

也有两个作用，一是约束作用（constraint），规范数据的唯一性，但同时也在这个key上建立了一个唯一索引；
UNIQUE 约束：唯一标识数据库表中的每条记录。
UNIQUE 和 PRIMARY KEY 约束均为列或列集合提供了唯一性的保证。每个表可以有多个 UNIQUE 约束，但是每个表只能有一个 PRIMARY KEY 约束）

**foreign key**
也有两个作用，一是约束作用（constraint），规范数据的引用完整性，但同时也在这个key上建立了一个index；


## mysql中的数据类型

### number类型

INT(size)	-2147483648 到 2147483647 常规。0 到 4294967295 无符号*。在括号中规定最大位数。

TINYINT(size)	-128 到 127 常规。0 到 255 无符号*。在括号中规定最大位数。

SMALLINT(size)	-32768 到 32767 常规。0 到 65535 无符号*。在括号中规定最大位数。

MEDIUMINT(size)	-8388608 到 8388607 普通。0 to 16777215 无符号*。在括号中规定最大位数。

### 字符串

varchar(n)	可变长度的字符串。最多 8,000 个字符。

text  可变长度的字符串。最多 2GB 字符数据。存放最大长度为 65,535 个字符的字符串。 2的16次方。


## CHARSET表的编码类型

个人建议,数据库字符集尽量使用utf8(HTML页面对应的是utf-8),以使你的数据能很顺利的实现迁移,因为utf8字符集是目前最适合于实现多种不同字符集之间的转换的字符集,尽管你在命令行工具上可能无法正确查看数据库中的内容,我依然强烈建议使用utf8作为默认字符集.