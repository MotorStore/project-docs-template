# 操作手册

使用前需安装配置 (Node.js、Gitbook)

流程图文档： https://mermaidjs.github.io/

流程图使用：https://shuise.github.io/tech-research/md-page/flow.html

MD工具推荐：https://typora.io/ (支持 windows、mac、linux)

使用前请根据实际情况修改 book.json 配置


# 代码、模板

[markdown 语法参考文档](./templates/example.md)

[mermaid 参考文档](./templates/flow.md)

[pandoc 转化 word 模板](./templates/tpl.docx)

```
pandoc -s design.md --reference-doc tpl.doc -o design.docx
```


# 引导说明

1. 使用此项目为模板创建 git 工程
2. 严格准守必选项，并完成工作
3. 工作必须从文档开始，开发功能先写文档，验收先看文档
4. 文档项目必须附加必要的原型、设计稿
5. 必须遵守规范、无规范时遵守之前约定
6. 之前约定有错误随时沟通处理并同步给所有项目组成员


# 工程源码及命名规范

1. server https://github.com/shuise/{project}-server
2. web  https://github.com/shuise/{project}-web
3. Android  https://github.com/shuise/{project}-android
4. iOS  https://github.com/shuise/{project}-ios
5. 文档  https://github.com/shuise/{project}-docs
