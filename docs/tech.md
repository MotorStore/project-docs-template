# 技术方案

## 依赖的服务、版本、基础信息

1. IM 2.3.0
2. RTC 3.0.8
3. 七牛云
4. 各端技术选型（PHP + JavaScript + OC..）
5. 对设备、操作系统、应用软件的要求


## 应用服务器环境要求

1. 域名：已备案，且带有效 https 证书
2. 操作系统：CentOS 7.x
3. Web服务器：Nginx 1.16
4. 脚本语言： PHP 7.0 with openssl
5. 数据库：MySQL5.7 (7.0)
6. 服务器配置说明
7. 更详细技术说明可以跳转到 https://github.com/shuise/{project}-server


## 方案说明

1. Web 站点：提供接口服务、静态页面
2. Android、Android Pad、iOS 三端调用接口、通过 cookie 鉴权
3. cookie逻辑
4. 本地数据缓存方案
5. 更详细技术说明可以跳转到 https://github.com/shuise/{project}-(web|android|ios)


## 接口

1. [表结构](./db.html)
2. [接口](./api.html)


## 其他特殊说明

1. 特殊的模块，比如加密、图形处理、视频处理等
2. 特殊的技术选型，比如 ffmpeg 等




 