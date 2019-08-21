# 安装操作手册

使用前需安装配置 (Node.js、Gitbook)

流程图文档： https://mermaidjs.github.io/

流程图使用：https://shuise.github.io/tech-research/md-page/flow.html

MD工具推荐：https://typora.io/ (支持 windows、mac、linux)

使用前请根据实际情况修改 `book.json` 配置


# 代码、模板

[markdown 语法参考文档](./templates/example.md)

[mermaid 参考文档](./templates/flow.md)

[pandoc 转化 word 模板](./templates/tpl.docx)

```
pandoc -s design.md --reference-doc tpl.doc -o design.docx
```