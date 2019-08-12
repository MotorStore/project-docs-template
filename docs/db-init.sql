
LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1,'papa','13800138000','baba','baba','LnWdDdx9rA2AgSKTi+\\/YjvHDlKxuUva3nL1owWyEuVPii4+SW7rCBr7QQvjVM+yi5EYlp6ZRKw2WP06iKjZNYw==','','2019-07-01 00:00:00',''),(2,'mama','13800138001','mama','mama','7ljrDIEUHCga3SfNLzXwWpltMLEfik9DxpqXaALr0RG40x4A5bh2XWB1iU7Zov6SDbm45nZ6e2w5BMJG6C6jQw==','','2019-07-10 00:00:00',''),(3,'grandma','13800138002','grandma','grandma','uUl3jIBlGvnQogwhox4uZ5ltMLEfik9DxpqXaALr0RG40x4A5bh2Xc5OELjfbYmCfXpYSKSHTvK6qp5AnJP17A==','','2019-07-10 00:00:00',''),(4,'grandpa','13800138003','grandpa','grandpa','xbkz\\/y2gHYYNbxlcXKsBoWSH6ouuI8NT\\/fNmMkzF+4J9pha7EmfLQknf2s3VcP1j6LRSPSNcvjGSrtZ8E7aVf5u0lrvbppBk','','2019-07-10 00:00:00','');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `pad_contact` WRITE;
/*!40000 ALTER TABLE `pad_contact` DISABLE KEYS */;
INSERT INTO `pad_contact` VALUES ('8123456789001','boy','grandma','13800138002'),('8123456789001','boy','grandpa','13800138003'),('8123456789001','boy','mama','13800138001'),('8123456789001','boy','papa','13800138000'),('8123456789002','girl','grandma','13800138002'),('8123456789002','girl','grandpa','13800138003'),('8123456789002','girl','mama','13800138001'),('8123456789002','girl','papa','13800138000');
/*!40000 ALTER TABLE `pad_contact` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'public','12345678','test','{\'test\':\'123\',\'id\':\'a1b2c3\'}'),(2,'private','12345678','test','{\"test\":\"123\",\"id\":\"a1b2c3\"}');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;


LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('8123456789001','body','boy','+Rwh9WuqaQH2nU4ivbui8uHR\\/ySxKaD1cAX2biXsYR4IiIQ2LaHIumKYVYjxl3zqOdkXsTnmqoU=','/portrait/faces/user001.jpg','1'),('8123456789002','girl','girl','joyoNrTUD9ARa47hz7a4wGSH6ouuI8NT\\/fNmMkzF+4J9pha7EmfLQqimfabPpd+LlytaLi3MEoEOHdnhZaKJjg==','/portrait/faces/user002.jpg','1');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

