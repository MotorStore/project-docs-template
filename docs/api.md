# 接口文档（PHP 实现）

postman接口文档、用例设计及自动化测试脚本

服务器接口测试脚本及配置检查脚本



## A01: 加载配置文件

https://baby.motorstore.cn/setting-public.json

appkey、navi、version、pages


## A02: 登录接口(注册)

1. 短信服务: https://zz.253.com/v5.html#/api_word
	API入口：http://smssh1.253.com/msg/variable/json
	account:N2450801 password:c96Ew0toi
<del>获取 token: https://www.rongcloud.cn/docs/server.html#user_get_token</del>
	
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

## A07: 删除联系人（解除绑定设备）接口

1. 融云需要提供解除绑定接口
2. 同步删除云端，[解除设备绑定接口](./oem-imei.html) 校验
3. 手机端通过消息通知 Pad，消息类型见 [messageType](./messages.html)
4. Pad 收到通知后调用接口获取结果

```
url: /api/contact/remove

method: post

request:
	{
		"cookie": "cookiexxxxxxxxxxxxxxxxx",
		"target": "padUserId1"
	}

response:
	{
		"code": "ok",
		"data": // 同 A05: /api/contact
	}
```

## A08: 扫码绑定逻辑，非接口

1. pad端使用 `{"timestamp":"1563443064975", "userId":"BAbYPADgirl"}` 生成二维码
2. 手机扫码获取 userId, timestamp
3. 加上本端 cookie 使用 A06 接口添加
4. 绑定后给 pad 端取名，本地保存，默认值 “宝宝”
5. 手机端通过消息通知 Pad，消息类型见 [messageType](./messages.html)
6. Pad 收到通知后调用接口获取结果


## A09: 应用下载二维码, 非接口

1. 从 A01 获取 url 追加本端 userId， pages.download + ?userId={padUserId}
2. 端上生成二维码供手机扫码


## A10: /api/sms


### 短信调试模式

1. 短信接口增加开关 real，标识是否真正发送验证码
2. real = 1；真正发送短信按接口定义实现，端上用户收到短信后手工输入，提交验证
3. real = 0；不发送短信；验证码通过接口下行，端上自动输入验证码

返回值改为
```
"data": {
	"real": 0,
	"verify": "2345", 
	"expire": 60
}	
```
	
1. 短信服务: http://smssh1.253.com/msg/variable/json 
	account:N2450801 password:c96Ew0toi
2. 需要注意 IP 锁定、次数限制，防止恶意消耗
	
```
url: /api/sms

method: post

request:
	{
		"phone": "13812341234"
	}

response:
	{
		"code": "ok",
		"message": "600秒不能超过 3 次",
		"data":{
			"expire": 60 // 秒，验证码有效时间，接口返回开始倒计时
		}
	}
```

## <del>A11 Pad 被扫码轮询接口</del>

暂不实现，通过消息通知对端做数据同步

为了返回被扫码后的状态

```
url: /api/getScanResult

method: post

request:
	{
		"cookie": "cookiexxxxxxxxxxxxxxxxx", // Pad 设备的 cookie
		"timstamp": "1563344426186" // 二维码创建时的时间戳
	}

response:
	{
		"code": "ok/fail", // fail 可能出现在 cookie 被篡改的情况，需要重启 pad 设备
		"message": "cookie失效，请重启设备", 
		"data": // 同A05
	}
```


## A12: 用户信息更新接口

```
url: /api/contact/update

method: post

request:
	{
		"cookie": "cookiexxxxxxxxxxxxxxxxx",
		"role": "ma", 	//端上选择
		"name": "ma",
		"portrait": "https://ma.png" //对应关系
	}

respnse:
	{
		"code": "ok/fail/logout",
		"message": "成功/失败原因" 
		"data":{
			"userId": "user9", 	//应用服务器分配
			"name": "ma",
			"role": "ma",
			"portrait": "ma",
			"imToken": "ZThhLI1Xa1BX5EMREAdArWSH6ouuI8NT/fNmMkzF+4IOKIoFvbsi6JnH8QmnSltLkCcsK8vOgKl3IZgfbxFiWg==“
		}
	}	

```

## A13: 用户刷新 token

token incorrect 时重新获取 token

注1: pad 端登录时返回 token，所以 token 失效重新使用登录接口接客
注2: 手机端登录时无法给予 token，因此单独调用此接口获取新 token

```
url: /api/token

method: post

request: 
	{
		"cookie": "cookiexxxxxxxxxxxxxxxxx",
		"userId": "userId"
	}

response: 
	{
		"code": "ok",
		"data": {
			"userId": "user9", 	//应用服务器分配
			"name": "ma",
			"role": "ma",
			"portrait": "ma",   // 
			"imToken": "ZThhLI1Xa1BX5EMREAdArWSH6ouuI8NT/fNmMkzF+4IOKIoFvbsi6JnH8QmnSltLkCcsK8vOgKl3IZgfbxFiWg==“,
			"cookie": "cookiexxxxxxxxxxxxxxxxx"  
		}
	}

```

## sn 导入方法

批量导入 sn 至应用服务器数据库

```
url: /api/pad/import
method: post
```

```
<form action="/api/pad/import">
	<file name='devices'>
	<button>Upload</button>
</form>
```


```
# 文本格式，每行2列，中间用‘,’隔开。第一列为设备SN，第二列为是否激活的标志
# 每行前导空格会被忽略，‘#’开头的行为注释行
10000,1
10001,1
10002,1
10003,1
10004,1
10005,1
```


## 底层呼叫方法

提供给 h5 页面使用、其他原生模块使用


## 数据统计打点

```
todo
```

