# 接口文档

1. postman接口文档、用例设计及自动化测试脚本
2. 服务器接口测试脚本及配置检查脚本


## A01: 加载配置文件

https://baby.motorstore.cn/setting-public.json

appkey、navi、version、pages


## A02: 登录接口(注册)

1. 短信服务: https://zz.253.com/v5.html#/api_word
	API入口：http://smssh1.253.com/msg/variable/json
	account:N2450801 password:c96Ew0toi
	
```
url: /api/login 

method: post

request:
	{
		"phone": "13812341234", //手机号码
		"verify": "7451",  	//验证码

		/** 以下三个参数不做检查，也不产生效果 ***/
		"role": "ma", 	//端上选择，初始化name、portrait与 role 保持一致
		"name": "ma",
		"portrait": "https://ma.png" // 如果 portrait=='' 且用户未注册，则自动注册时使用对应关系 https://baby.motorstore.cn/roles/{role}.png
	}

respnse:
	{
		"code": "ok/fail",
		"message": "错误提示信息"
		"data": {
			"userId": "user9", 	//应用服务器分配
			"name": "ma",
			"role": "ma",
			"portrait": "ma",   // 
			"cookie": "cookiexxxxxxxxxxxxxxxxx"  
		}
	}
```


## A03: Pad端 sn 登录

1. 端上用户输入用户名、选择头像，获取 Pad 设备 sn （Android标准接口）并[加密](./tech.html)上传
2. 应用服务器检查 sn 是否在白名单，通过后应用服务器分配，分配之前根据 sn 查询，有直接用这，没有再分配
3. 应用服务器请求 IM 服务器 [sn 校验接口](./oem-imei.html) 分配 imtoken
4. 本请求的 header 部分，存在 Debug: true 的， http头时，不对 sn 进行解密，直接明文使用。

```
url: /api/pad/login

method: post

request:
	{
		"sn": "xxxxxxx", // [sn加密传输方式](./tech.html) , 目前有效sn: 8123456789001, 8123456789001
		"role": "boy/girl", //端上选择
		// role 为必选， name，portrait 可以选填
		"name": "boy/girl", //与 role 一致
		"portrait": "http://nana.png" //端上选择，role、name与选择一致
	}

response:
	{
		"code": "ok/fail",
		"message": "设备未授权"
		"data": {
			"userId": "user9",
			"name": "girl",
			"role": "girl",
			"portrait": "girl",
			"imToken": "ZThhLI1Xa1BX5EMREAdArWSH6ouuI8NT/fNmMkzF+4IOKIoFvbsi6JnH8QmnSltLkCcsK8vOgKl3IZgfbxFiWg==“,
			"cookie": "cookiexxxxxxxxxxxxxxxxx" // pad下的cookie永久有效
		}
	}
```

## A04: 退出登录

```
url: /api/logout

method: post

request:
	{
		"cookie": "cookiexxxxxxxxxxxxxxxxx" 
	}

response:
	{
		"code": "ok"
	}
```


## A05: 联系人（设备）列表接口

```
url: /api/contact

method: post

request:
	{
		"cookie": "cookiexxxxxxxxxxxxxxxxx" 
	}

response:
	{
		"code": "ok",
		"data": // 当前手机用户绑定的pad设备对应的用户列表；或 pad 设备对应的手机用户列表
		[
			{
				"userId": "userId",
				"name": "妈妈",
				"role": "ma",
				"portrait": "https://……………….png"	
			},
			{
				"userId": "userId",
				"name": "爸爸",
				"role": "pa",
				"portrait": "https://……………….png"	
			}
		]
	}
```


## A06: 添加联系人（绑定设备）接口

1. 有数量限制，通过融云 [设备绑定接口](./oem-imei.html) 校验
2. 手机端如果不是链接状态，通过 A13 获取 token 并链接，如果链接状态继续下一步
3. 手机端通过消息通知 Pad，消息类型见 [messageType](./messages.html)
4. Pad 收到通知后调用接口获取结果

```
url: /api/contact/add

method: post

request:
	{
		"cookie": "cookiexxxxxxxxxxxxxxxxx", // 手机端的cookie
		"target": "padUserId1" // 通过pad的二维码获得的padUserId
		"role": "{role}",
		"timestamp": "1563344426186" // 扫码时使用，通过pad的二维码获得的时间戳
	}

response:
	{
		"code": "ok/fail",
		"message": "已达到数量上限，无法继续绑定",
		"data": // 同 A05: /api/contact
	}
```


