# Git 使用要求

## 提交原则

1. 按照要求撰写 log 并提交
2. 事件之间保持独立，根据事件进行提交



举例说明
```
开发功能 A 修改了文件 F1、F2
修改功能 B 修改了文件 F1
```

正确处理方式
```
开发功能 A

git add F1、F2
git commit -m "feat: 功能 A"

修改功能 B

git add F1
git commit -m "fix: 功能 B"

git push
```


## git types

每次提交必须填写完整的log，格式为 type: message，比如 fix: 修复域名验证错误

特别强调，短时间重复提交一定是属于异常情况，log一定要说明相关信息

```	
types
	
feat: A new feature
fix: A bug fix
docs: Documentation only changes
style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
refactor: A code change that neither fixes a bug nor adds a feature
perf: A code change that improves performance
test: Adding missing tests or correcting existing tests
chore: Other changes that don't modify src or test files

git commit -m "feat: 价格页面"
```	

## review 

1. 提交之前可以请其他同事进行 code review
2. 典型问题通过 issue 记录


## 建立分支

1. 当且仅当需要开发新功能时，才能创建新分支，而且必须在一个分支里完整一个功能的开发测试和上线
2. 必须按照业务诉求命名分支，比如xmas，加默认前缀feature-xmas
3. 拒绝使用无意义的字符串，更不得使用个人标识命名

```
查看分支 git branch
创建分支 git branch (branchname)
切换分支 git checkout (branchname)
```

## 分支必须保持更新

要求每天早上和下午开始工作前从前master执行git pull操作

```
git add
git commit
git pull
```


## 参考文档

1. log：http://blog.jobbole.com/109197/
2. Git手册：http://www.runoob.com/git/git-tutorial.html
3. 分支管理思想遵循 Vincent Driessen 的 《A successful Git branching model》，原文链接：http://nvie.com/posts/a-successful-git-branching-model/

