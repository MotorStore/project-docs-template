# 数据库说明

## 脚本(右键另存)

1. [清库](clean.sql)
1. [初始化数据库](db-create.sql)

## 用户表 Users

用户信息、对应的 手机号码、sn信息

```
CREATE TABLE `Users` (
  `id` int(11) NOT NULL ,
  `userId` char(40) NOT NULL,
  `phone` char(14) NOT NULL,
  `name` varchar(64) NOT NULL,
  `role` char(8) NOT NULL,
  `portrait` char(255) DEFAULT '',
  `imToken` char(128) NOT NULL,
  `cookie` char(64) NOT NULL,
  `cookieExpire` datetime DEFAULT NULL,
  `regTime` datetime DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `Users` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;

```

## 联系人表 Contacts

联系人信息

```
CREATE TABLE `Contact` (
  `sn` char(64) NOT NULL,
  `role` char(40) NOT NULL,
  `padUserId` char(40) NOT NULL,
  `phoneUserId` char(128) NOT NULL,
  `bindTime` datetime DEFAULT NULL,
  PRIMARY KEY (`padUserId`,`phoneUserId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `Contact`
  ADD KEY `sn` (`sn`);
COMMIT;

```


## 设备号表 Devices

```
CREATE TABLE `Devices` (
  `sn` char(64) NOT NULL,
  `userId` char(64) NOT NULL,
  `isActive` char(8) NOT NULL,
  `regTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```


## 验证码 Verifies

手机验证码

```
CREATE TABLE `Verifies` (
  `id` int(11) NOT NULL ,
  `ip` char(16) NOT NULL,
  `phone` char(14) NOT NULL,
  `verify` char(8) DEFAULT NULL,
  `verifyExpire` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `Verifies` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT;

```

