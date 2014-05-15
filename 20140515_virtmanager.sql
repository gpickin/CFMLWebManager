# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.31)
# Database: virtmanager
# Generation Time: 2014-05-15 15:40:50 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table engine
# ------------------------------------------------------------

DROP TABLE IF EXISTS `engine`;

CREATE TABLE `engine` (
  `engineID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `version` float DEFAULT NULL,
  `moduleFile` varchar(500) DEFAULT NULL,
  `fk_providerID` int(11) DEFAULT NULL,
  PRIMARY KEY (`engineID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `engine` WRITE;
/*!40000 ALTER TABLE `engine` DISABLE KEYS */;

INSERT INTO `engine` (`engineID`, `name`, `version`, `moduleFile`, `fk_providerID`)
VALUES
	(1,'ColdFusion 9',9,'/www/_servers/conf/inc_cf9_module.inc',1),
	(2,'ColdFusion 10',10,'/www/_servers/conf/inc_cfmulti_module.inc',1),
	(3,'ColdFusion 11',11,'/www/_servers/conf/inc_cfmulti_module.inc',1),
	(4,'Railo',4,NULL,2);

/*!40000 ALTER TABLE `engine` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table engine_provider
# ------------------------------------------------------------

DROP TABLE IF EXISTS `engine_provider`;

CREATE TABLE `engine_provider` (
  `providerID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`providerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `engine_provider` WRITE;
/*!40000 ALTER TABLE `engine_provider` DISABLE KEYS */;

INSERT INTO `engine_provider` (`providerID`, `name`)
VALUES
	(1,'Adobe'),
	(2,'Railo'),
	(3,'Blue Dragon');

/*!40000 ALTER TABLE `engine_provider` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table instance
# ------------------------------------------------------------

DROP TABLE IF EXISTS `instance`;

CREATE TABLE `instance` (
  `instanceID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `configFile` varchar(500) DEFAULT NULL,
  `connectionFile` varchar(500) DEFAULT NULL,
  `FK_serverID` int(11) DEFAULT NULL,
  `FK_engineID` int(11) DEFAULT NULL,
  PRIMARY KEY (`instanceID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `instance` WRITE;
/*!40000 ALTER TABLE `instance` DISABLE KEYS */;

INSERT INTO `instance` (`instanceID`, `name`, `configFile`, `connectionFile`, `FK_serverID`, `FK_engineID`)
VALUES
	(1,'CF 9',NULL,'/www/_servers/conf/inc_cf9_conn.inc',1,1),
	(2,'CF 10',NULL,'/www/_servers/conf/inc_cf10_conn.inc',1,2),
	(3,'CF 11',NULL,'/www/_servers/conf/inc_cf11_conn.inc',1,3),
	(4,'Railo 1','/www/_servers/conf/inc_railo1_hosts.xml','/www/_servers/conf/inc_railo1_conn.inc',1,4),
	(5,'Railo 2','/www/_servers/conf/inc_railo2_hosts.xml','/www/_servers/conf/inc_railo2_conn.inc',1,4),
	(6,'Railo Cluster',NULL,'/www/_servers/conf/inc_railocluster_conn.inc',1,4);

/*!40000 ALTER TABLE `instance` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table server
# ------------------------------------------------------------

DROP TABLE IF EXISTS `server`;

CREATE TABLE `server` (
  `serverID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `os` varchar(11) DEFAULT NULL,
  `hostsFile` varchar(500) DEFAULT NULL,
  `apacheHosts` varchar(500) DEFAULT NULL,
  `apacheModules` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`serverID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `server` WRITE;
/*!40000 ALTER TABLE `server` DISABLE KEYS */;

INSERT INTO `server` (`serverID`, `name`, `os`, `hostsFile`, `apacheHosts`, `apacheModules`)
VALUES
	(1,'Localhost','MacOSX','/etc/hosts','/www/_servers/conf/apache/apacheHosts.conf','/www/_servers/conf/apache/apacheModules.inc');

/*!40000 ALTER TABLE `server` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table website
# ------------------------------------------------------------

DROP TABLE IF EXISTS `website`;

CREATE TABLE `website` (
  `websiteID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `path` varchar(500) DEFAULT NULL,
  `FK_instanceID` int(11) DEFAULT NULL,
  PRIMARY KEY (`websiteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `website` WRITE;
/*!40000 ALTER TABLE `website` DISABLE KEYS */;

INSERT INTO `website` (`websiteID`, `name`, `url`, `path`, `FK_instanceID`)
VALUES
	(1,'Just Mock It Demo','justmockit.local.com','/www/JustMockIt',4),
	(2,'Meet the Family','meetthefamily.local.com','/www/ITB2014-Meet-The-Family',4),
	(3,'What Am I?','whatami.local.com','/www/_wwwcfo/whoami.local.com',2);

/*!40000 ALTER TABLE `website` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table website_mapping
# ------------------------------------------------------------

DROP TABLE IF EXISTS `website_mapping`;

CREATE TABLE `website_mapping` (
  `mappingID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `path` varchar(500) DEFAULT NULL,
  `FK_websiteID` int(11) DEFAULT NULL,
  PRIMARY KEY (`mappingID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `website_mapping` WRITE;
/*!40000 ALTER TABLE `website_mapping` DISABLE KEYS */;

INSERT INTO `website_mapping` (`mappingID`, `name`, `path`, `FK_websiteID`)
VALUES
	(1,'/coldbox','/www/_includes/coldbox/coldbox_standalone_3.8.1/coldbox',1),
	(2,'/cfide','/nothere/',2),
	(3,'/coldbox','/www/_includes/coldbox/coldbox_standalone_3.8.1/coldbox',2);

/*!40000 ALTER TABLE `website_mapping` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table website_server_alias
# ------------------------------------------------------------

DROP TABLE IF EXISTS `website_server_alias`;

CREATE TABLE `website_server_alias` (
  `serverAliasID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `FK_websiteID` int(11) DEFAULT NULL,
  PRIMARY KEY (`serverAliasID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `website_server_alias` WRITE;
/*!40000 ALTER TABLE `website_server_alias` DISABLE KEYS */;

INSERT INTO `website_server_alias` (`serverAliasID`, `name`, `FK_websiteID`)
VALUES
	(1,'www.justmockit.com',1);

/*!40000 ALTER TABLE `website_server_alias` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
