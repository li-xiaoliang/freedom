# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: freedom
# Generation Time: 2020-11-08 10:37:25 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table domain_event_publish
# ------------------------------------------------------------

DROP TABLE IF EXISTS `domain_event_publish`;

CREATE TABLE `domain_event_publish` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic` varchar(64) DEFAULT NULL,
  `send` tinyint(4) DEFAULT NULL COMMENT '0未发送，1发送',
  `content` text COMMENT '内容',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领域事件发布表';



# Dump of table domain_event_subscribe
# ------------------------------------------------------------

DROP TABLE IF EXISTS `domain_event_subscribe`;

CREATE TABLE `domain_event_subscribe` (
  `id` int(11) unsigned NOT NULL,
  `topic` varchar(64) NOT NULL DEFAULT '',
  `progress` tinyint(4) NOT NULL COMMENT '0未处理，1处理',
  `content` text NOT NULL COMMENT '内容',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='领域事件消费表';



# Dump of table goods
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '商品名称',
  `price` int(11) NOT NULL COMMENT '价格',
  `stock` int(11) NOT NULL COMMENT '库存',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;

INSERT INTO `goods` (`id`, `name`, `price`, `stock`, `created`, `updated`)
VALUES
	(1,'冈本',15,139445,'2020-01-16 18:06:31','2020-11-07 17:35:21'),
	(2,'杰士邦',15,186,'2020-01-16 18:06:44','2020-03-20 22:35:51'),
	(3,'杜蕾斯',20,186,'2020-01-16 18:07:02','2020-03-20 22:35:51'),
	(4,'第六感',80,186,'2020-01-16 18:07:22','2020-03-23 22:20:30'),
	(5,'测试主键1',100,100,'2020-03-23 22:21:10','2020-03-23 22:21:10'),
	(6,'测试主键2',100,100,'2020-03-23 22:21:10','2020-03-23 22:21:10'),
	(7,'测试主键3',100,100,'2020-03-23 22:21:10','2020-03-23 22:21:10'),
	(8,'测试主键4',100,100,'2020-03-23 22:21:10','2020-03-23 22:21:10'),
	(9,'测试主键5',100,100,'2020-03-23 22:21:10','2020-03-23 22:21:10');

/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `num` int(11) NOT NULL COMMENT '数量',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;

INSERT INTO `order` (`id`, `user_id`, `goods_id`, `num`, `created`, `updated`)
VALUES
	(1,1001,1,10,'2020-03-29 16:19:43','2020-04-07 14:46:18'),
	(1003,1001,1,10,'2020-03-29 16:19:43','2020-03-29 16:19:43'),
	(1004,1001,1,10,'2020-03-29 16:19:43','2020-03-29 16:19:43'),
	(1005,1001,1,10,'2020-03-29 16:19:43','2020-03-29 16:19:43');

/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
