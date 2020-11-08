# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: fshop
# Generation Time: 2020-11-08 06:32:53 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table admin
# ------------------------------------------------------------

CREATE TABLE `admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员名称',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;

INSERT INTO `admin` (`id`, `name`, `created`, `updated`)
VALUES
	(1,'wangwu','2020-03-03 15:24:28','2020-03-03 15:24:28'),
	(2,'zhaoliu','2020-03-03 15:24:36','2020-03-03 15:24:36');

/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cart
# ------------------------------------------------------------

CREATE TABLE `cart` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `num` int(11) NOT NULL COMMENT '数量',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车';

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;

INSERT INTO `cart` (`id`, `user_id`, `goods_id`, `num`, `created`, `updated`)
VALUES
	(11,1,1,1,'2020-11-07 17:20:54','2020-11-07 17:20:54'),
	(12,1,2,1,'2020-11-07 17:20:54','2020-11-07 17:20:54');

/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table delivery
# ------------------------------------------------------------

CREATE TABLE `delivery` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `order_no` varchar(65) NOT NULL DEFAULT '订单id',
  `tracking_number` varchar(65) DEFAULT NULL COMMENT '快递单号',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='发货存根';

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;

INSERT INTO `delivery` (`id`, `admin_id`, `order_no`, `tracking_number`, `created`, `updated`)
VALUES
	(2,1,'1586601953','6791947784987','2020-04-12 18:29:15','2020-04-12 18:29:15'),
	(3,1,'1586687439','6791947784987','2020-04-12 18:31:14','2020-04-12 18:31:14'),
	(4,1,'1589704785','6791947784987','2020-05-17 16:40:19','2020-05-17 16:40:19'),
	(5,1,'1590226363','6791947784987','2020-05-23 17:33:09','2020-05-23 17:33:09'),
	(6,1,'1590228134','6791947784987','2020-05-23 18:02:52','2020-05-23 18:02:52'),
	(7,1,'1590815716','6791947784987','2020-05-30 13:15:35','2020-05-30 13:15:35');

/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table domain_event
# ------------------------------------------------------------

CREATE TABLE `domain_event` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `send` tinyint(4) DEFAULT NULL COMMENT '0未发送，1发送',
  `content` text COMMENT '内容',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `domain_event` WRITE;
/*!40000 ALTER TABLE `domain_event` DISABLE KEYS */;

INSERT INTO `domain_event` (`id`, `name`, `send`, `content`, `created`, `updated`)
VALUES
	(7,'ChangePassword',1,'{\"userID\":3,\"newPassword\":\"123321\",\"oldPassword\":\"123321\"}','2020-11-08 14:28:37','2020-11-08 14:28:37');

/*!40000 ALTER TABLE `domain_event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods
# ------------------------------------------------------------

CREATE TABLE `goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '商品名称',
  `price` int(11) NOT NULL COMMENT '价格',
  `stock` int(11) NOT NULL COMMENT '库存',
  `tag` enum('HOT','NEW','NONE') NOT NULL DEFAULT 'NONE' COMMENT '标签',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品';

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;

INSERT INTO `goods` (`id`, `name`, `price`, `stock`, `tag`, `created`, `updated`)
VALUES
	(1,'iPhone',500,1903,'NEW','2020-01-16 18:06:31','2020-11-07 17:40:23'),
	(2,'iMac',1000,399,'HOT','2020-01-16 18:06:44','2020-11-07 17:21:04'),
	(3,'杜蕾斯',20,50,'NEW','2020-01-16 18:07:02','2020-03-04 11:17:21'),
	(4,'轩辕剑',600,68,'NONE','2020-01-16 18:07:22','2020-11-08 14:29:24'),
	(5,'布加迪威龙',3000,40,'HOT','2020-02-18 21:53:51','2020-11-07 17:21:06');

/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table order
# ------------------------------------------------------------

CREATE TABLE `order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(65) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `total_price` int(11) NOT NULL COMMENT '总价',
  `status` enum('PAID','NON_PAYMENT','SHIPMENT','DONE') NOT NULL DEFAULT 'NON_PAYMENT' COMMENT '支付,未支付，发货，完成',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单';



# Dump of table order_detail
# ------------------------------------------------------------

CREATE TABLE `order_detail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(65) NOT NULL DEFAULT '' COMMENT '订单id',
  `goods_id` int(11) NOT NULL COMMENT '商品id',
  `num` int(11) NOT NULL COMMENT '数量',
  `goods_name` varchar(32) NOT NULL DEFAULT '' COMMENT '商品名称',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单商品';



# Dump of table user
# ------------------------------------------------------------

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名称',
  `money` int(11) NOT NULL COMMENT '金钱',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '密码',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户';

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `name`, `money`, `password`, `created`, `updated`)
VALUES
	(1,'zhangsan',63500,'123','2020-02-18 21:55:21','2020-11-07 17:21:44'),
	(2,'lisi',100000,'321','2020-02-18 21:55:29','2020-04-12 14:28:32'),
	(38,'freedom',10000,'123321','2020-11-08 14:32:29','2020-11-08 14:32:29');

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
