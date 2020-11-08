# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: fshop
# Generation Time: 2020-11-08 09:59:14 +0000
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

DROP TABLE IF EXISTS `admin`;

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

DROP TABLE IF EXISTS `cart`;

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



# Dump of table delivery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `delivery`;

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

LOCK TABLES `domain_event_publish` WRITE;
/*!40000 ALTER TABLE `domain_event_publish` DISABLE KEYS */;

INSERT INTO `domain_event_publish` (`id`, `topic`, `send`, `content`, `created`, `updated`)
VALUES
	(7,'ChangePassword',1,'{\"userID\":3,\"newPassword\":\"123321\",\"oldPassword\":\"123321\"}','2020-11-08 14:28:37','2020-11-08 14:58:14'),
	(8,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604818624\",\"goodsID\":1,\"goodsNum\":2,\"goodsName\":\"iPhone\"}','2020-11-08 14:57:05','2020-11-08 14:57:04'),
	(11,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604819337\",\"goodsID\":1,\"goodsNum\":1,\"goodsName\":\"iPhone\"}','2020-11-08 15:08:57','2020-11-08 15:08:57'),
	(12,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604819337\",\"goodsID\":2,\"goodsNum\":1,\"goodsName\":\"iMac\"}','2020-11-08 15:08:57','2020-11-08 15:08:57'),
	(13,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604819634\",\"goodsID\":1,\"goodsNum\":1,\"goodsName\":\"iPhone\"}','2020-11-08 15:13:54','2020-11-08 15:13:54'),
	(14,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604819634\",\"goodsID\":2,\"goodsNum\":1,\"goodsName\":\"iMac\"}','2020-11-08 15:13:54','2020-11-08 15:13:54'),
	(15,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604819670\",\"goodsID\":1,\"goodsNum\":2,\"goodsName\":\"iPhone\"}','2020-11-08 15:14:30','2020-11-08 15:14:30'),
	(16,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604819680\",\"goodsID\":2,\"goodsNum\":2,\"goodsName\":\"iMac\"}','2020-11-08 15:14:41','2020-11-08 15:14:40'),
	(17,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604819711\",\"goodsID\":3,\"goodsNum\":1,\"goodsName\":\"杜蕾斯\"}','2020-11-08 15:15:11','2020-11-08 15:15:11'),
	(18,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604819711\",\"goodsID\":2,\"goodsNum\":1,\"goodsName\":\"iMac\"}','2020-11-08 15:15:11','2020-11-08 15:15:11'),
	(19,'ChangePassword',1,'{\"userID\":3,\"newPassword\":\"123321\",\"oldPassword\":\"123321\"}','2020-11-08 16:40:47','2020-11-08 16:40:46'),
	(20,'ChangePassword',1,'{\"userID\":3,\"newPassword\":\"123321\",\"oldPassword\":\"123321\"}','2020-11-08 16:42:50','2020-11-08 16:42:50'),
	(21,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604825027\",\"goodsID\":2,\"goodsNum\":2,\"goodsName\":\"iMac\"}','2020-11-08 16:43:47','2020-11-08 16:43:47'),
	(22,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604825052\",\"goodsID\":3,\"goodsNum\":1,\"goodsName\":\"杜蕾斯\"}','2020-11-08 16:44:12','2020-11-08 16:44:12'),
	(23,'ShopGoods',1,'{\"userID\":1,\"orderNO\":\"1604825052\",\"goodsID\":2,\"goodsNum\":1,\"goodsName\":\"iMac\"}','2020-11-08 16:44:12','2020-11-08 16:44:12');

/*!40000 ALTER TABLE `domain_event_publish` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table goods
# ------------------------------------------------------------

DROP TABLE IF EXISTS `goods`;

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
	(1,'iPhone',500,1887,'NEW','2020-01-16 18:06:31','2020-11-08 15:14:31'),
	(2,'iMac',1000,395,'HOT','2020-01-16 18:06:44','2020-11-08 16:44:14'),
	(3,'杜蕾斯',20,50,'NEW','2020-01-16 18:07:02','2020-11-08 16:44:13'),
	(4,'轩辕剑',600,137,'NONE','2020-01-16 18:07:22','2020-11-08 16:44:16'),
	(5,'布加迪威龙',3000,40,'HOT','2020-02-18 21:53:51','2020-11-07 17:21:06');

/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order`;

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

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;

INSERT INTO `order` (`id`, `order_no`, `user_id`, `total_price`, `status`, `created`, `updated`)
VALUES
	(96,'1604817907',1,1000,'NON_PAYMENT','2020-11-08 14:45:08','2020-11-08 14:45:08'),
	(97,'1604817941',1,1000,'NON_PAYMENT','2020-11-08 14:45:41','2020-11-08 14:45:41'),
	(98,'1604818215',1,1000,'NON_PAYMENT','2020-11-08 14:50:16','2020-11-08 14:50:16'),
	(99,'1604818226',1,1000,'NON_PAYMENT','2020-11-08 14:50:26','2020-11-08 14:50:26'),
	(100,'1604818379',1,1000,'NON_PAYMENT','2020-11-08 14:52:59','2020-11-08 14:52:59'),
	(101,'1604818624',1,1000,'NON_PAYMENT','2020-11-08 14:57:05','2020-11-08 14:57:05'),
	(102,'1604818717',1,3000,'NON_PAYMENT','2020-11-08 14:58:38','2020-11-08 14:58:38'),
	(103,'1604818740',1,1500,'NON_PAYMENT','2020-11-08 14:59:00','2020-11-08 14:59:00'),
	(104,'1604819325',1,0,'NON_PAYMENT','2020-11-08 15:08:45','2020-11-08 15:08:45'),
	(105,'1604819337',1,1500,'NON_PAYMENT','2020-11-08 15:08:57','2020-11-08 15:08:57'),
	(106,'1604819621',1,0,'NON_PAYMENT','2020-11-08 15:13:41','2020-11-08 15:13:41'),
	(107,'1604819634',1,1500,'NON_PAYMENT','2020-11-08 15:13:54','2020-11-08 15:13:54'),
	(108,'1604819670',1,1000,'NON_PAYMENT','2020-11-08 15:14:30','2020-11-08 15:14:30'),
	(109,'1604819680',1,2000,'NON_PAYMENT','2020-11-08 15:14:41','2020-11-08 15:14:41'),
	(110,'1604819711',1,1020,'NON_PAYMENT','2020-11-08 15:15:11','2020-11-08 15:15:11'),
	(111,'1604825027',1,2000,'NON_PAYMENT','2020-11-08 16:43:47','2020-11-08 16:43:47'),
	(112,'1604825052',1,1020,'NON_PAYMENT','2020-11-08 16:44:12','2020-11-08 16:44:12');

/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table order_detail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order_detail`;

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

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;

INSERT INTO `order_detail` (`id`, `order_no`, `goods_id`, `num`, `goods_name`, `created`, `updated`)
VALUES
	(122,'1604817907',1,2,'iPhone','2020-11-08 14:45:08','2020-11-08 14:45:08'),
	(123,'1604817941',1,2,'iPhone','2020-11-08 14:45:41','2020-11-08 14:45:41'),
	(124,'1604818215',1,2,'iPhone','2020-11-08 14:50:16','2020-11-08 14:50:16'),
	(125,'1604818226',1,2,'iPhone','2020-11-08 14:50:26','2020-11-08 14:50:26'),
	(126,'1604818379',1,2,'iPhone','2020-11-08 14:52:59','2020-11-08 14:52:59'),
	(127,'1604818624',1,2,'iPhone','2020-11-08 14:57:05','2020-11-08 14:57:05'),
	(128,'1604818717',1,2,'iPhone','2020-11-08 14:58:38','2020-11-08 14:58:38'),
	(129,'1604818717',2,2,'iMac','2020-11-08 14:58:38','2020-11-08 14:58:38'),
	(130,'1604818740',1,1,'iPhone','2020-11-08 14:59:00','2020-11-08 14:59:00'),
	(131,'1604818740',2,1,'iMac','2020-11-08 14:59:00','2020-11-08 14:59:00'),
	(132,'1604819337',1,1,'iPhone','2020-11-08 15:08:57','2020-11-08 15:08:57'),
	(133,'1604819337',2,1,'iMac','2020-11-08 15:08:57','2020-11-08 15:08:57'),
	(134,'1604819634',1,1,'iPhone','2020-11-08 15:13:54','2020-11-08 15:13:54'),
	(135,'1604819634',2,1,'iMac','2020-11-08 15:13:54','2020-11-08 15:13:54'),
	(136,'1604819670',1,2,'iPhone','2020-11-08 15:14:30','2020-11-08 15:14:30'),
	(137,'1604819680',2,2,'iMac','2020-11-08 15:14:41','2020-11-08 15:14:41'),
	(138,'1604819711',3,1,'杜蕾斯','2020-11-08 15:15:11','2020-11-08 15:15:11'),
	(139,'1604819711',2,1,'iMac','2020-11-08 15:15:11','2020-11-08 15:15:11'),
	(140,'1604825027',2,2,'iMac','2020-11-08 16:43:47','2020-11-08 16:43:47'),
	(141,'1604825052',3,1,'杜蕾斯','2020-11-08 16:44:12','2020-11-08 16:44:12'),
	(142,'1604825052',2,1,'iMac','2020-11-08 16:44:12','2020-11-08 16:44:12');

/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

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
	(3,'freedom',10000,'123321','2020-11-08 14:32:29','2020-11-08 16:40:34');

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
