/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imid` char(40) NOT NULL,
  `phone` char(14) NOT NULL,
  `name` varchar(64) NOT NULL,
  `role` char(8) NOT NULL,
  `imToken` char(128) NOT NULL,
  `verify` char(8) NOT NULL,
  `verifyexpire` datetime NOT NULL,
  `cookie` char(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pad_contact` (
  `device_sn` char(64) NOT NULL,
  `device_imid` char(40) NOT NULL,
  `contact_imid` char(128) NOT NULL,
  `contact_phone` char(16) NOT NULL,
  PRIMARY KEY (`device_imid`,`contact_imid`) USING BTREE,
  KEY `sn` (`device_imid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visible` char(16) NOT NULL,
  `appkey` char(64) NOT NULL,
  `name` char(64) NOT NULL,
  `pages` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `sn` char(64) NOT NULL,
  `name` varchar(32) NOT NULL,
  `imid` char(64) NOT NULL,
  `imToken` char(128) NOT NULL,
  `portrait` varchar(255) NOT NULL,
  `isValide` char(8) NOT NULL,
  UNIQUE KEY `sn` (`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

