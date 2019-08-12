# 技术方案

概要设计/详细设计

数据库：mysql，[表结构说明](./db.md)

应用服务器语言确认：PHP

## 依赖的服务

1. IM
2. RTC
3. 七牛云
4. 各端技术选型
5. 对设备、操作系统、应用软件的要求


## 应用服务器环境要求：

域名：已备案，且带有效 https 证书

操作系统：CentOS 7.x

Web服务器：Nginx 1.16

脚本语言： PHP 7.0 with openssl

数据库：MySQL5.7 (7.0)


## 各端关系

Web 站点：提供接口服务、静态页面

Android、Android Pad、iOS 三端调用接口、通过 cookie 鉴权


## 服务器端设计逻辑

1. session 与 cookie:

    本项目不存在 web 端，只有设备端和 app 端，所有 cookie 都通过 JSON 格式的 http body 进行传递。

    所有的接口均以 url + post json 的方式进行调用，post json 的数据内，除登录接口可以不含 cookie 字段，其他接口必须要有 cookie 字段，否则响应为 {"code": "logout"}

    session 保存一下信息：

    ​	userId: 也用作本系统的用户 id；

    ​    sn: 设备用户才有这个变量；

    ​	expire: cookie 过期时间

    ​	其他值，根据需要使用

    传输中的 cookie 值，与服务器端 cookieId 不同，是 cookieId 与 id (非 userId)的计算结果

2. sessionId 的生成， 用 手机号注册时，可以生成唯一的 sessionId。

	```
    $a = md5($phone);
    $b = base_convert($a, 16, 35);
    $sessionid = strtoupper($b);
	```

3. A03 接口需要传递 sn 值的接口
	使用加密算法传输 sn 值，加密算法为：
	使用 openssl 库 的 openssl encrypt 算法，参数设置为：
		cipher:DES-ECB, key:CrystalBaby, 实际生效的只有前8个字符
	加密结果用 base64 方式表示和传输
	如：
	加密 "hello"
	```
		$res = "NO THIS CIPHER":
		$cipher = "DES-ECB"; // 选择算法
		if(in_array($cipher, openssl_get_cipher_methods()) // 检查算法存在
		{
			$res = openssl_encrypt("hello", $cipher, "CrystalBaby");
		}
		print_r($res); // 输出为：n42nJwpRIQs=, 结果的二进制表示为: 9f 8d a7 27 a 51 21 
	```

	解密 "n42nJwpRIQs="
	```
		$res = "NO THIS CIPHER":
		$cipher = "DES-ECB"; // 选择算法
		if(in_array($cipher, openssl_get_cipher_methods()) // 检查算法存在
		{
			$res = openssl_decrypt("n42nJwpRIQs=", $cipher, "CrystalBaby");
		}
		print_r($res); // 输出 hello
	```

	测试用sn的加密结果：左侧为16进制表示，右侧为MD5表示
	```
	10000 - 10005: encode:
	3e a3 9d 8c f2 e4 34 ff   :PqOdjPLkNP8=
	24 2f 7f 54 78 d3 1f 9d   :JC9/VHjTH50=
	e5 65 d 25 26 18 8e be    :5WUNJSYYjr4=
	17 5 cf 9c a7 6 b4 9f     :FwXPnKcGtJ8=
	c5 a9 1e d0 3f b6 86 c7   :xake0D+2hsc=
	75 e1 d4 cc 9f 35 6f 8d   :deHUzJ81b40=	
	```


4. /api/login 接口，调用时，如果用户库中不存在对应的手机号，则创建用户，自动分配 userId 。
	userId 以 mb 开头，以时间和手机号计算得出唯一字符串，长度为 64 位。

	（解 token 跟这里有关系吗？现在不知道，以后再说）

5. 测试流程：
	1. 初始化设备列表
	2. 手机注册
	3. 设备开机，登录
	4. 手机扫码，加好友
	

6. 倒入SN的文本格式, 纯文本，一行一个, ","号分割，第一列为sn串，第二列为是否已经激活，以#开头的行为注释，行前后的空格会被忽略
如：
#sn,active
xxxxxx, 1
xxxxxx, 1



 