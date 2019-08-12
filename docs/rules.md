# 开发规范

## 技术约定

1. tab == 4个空格
2. utf8 编码
3. 


## 业务约定：

1. pad 用户加特殊前缀区分: BAbYPAD (注意第二个b小写)
2. role: boy,girl,pa,ma,grandpa,grandma,grandpaL,grandmaL

	对应：男孩、女孩、爸爸、妈妈、爷爷、奶奶、外公、外婆

	头像网络地址: https://baby.motorstore.cn/roles/{role}.png
3. imToken 为 base64 编码，返回时不允许转义
4. 时间单位统一用 秒