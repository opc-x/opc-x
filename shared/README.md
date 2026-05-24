# Shared — 共享资源

跨 Orchestrator 传递的上下文与公共 prompt 模板。

## 目录结构

```
shared/
├── contexts/          # 各域持久化上下文（跨对话传递）
│   ├── strategy-context.md
│   ├── research-context.md
│   ├── product-context.md
│   ├── tech-context.md
│   ├── brand-context.md
│   ├── growth-context.md
│   ├── ops-context.md
│   ├── data-context.md
│   ├── finance-context.md
│   └── meta-context.md
└── prompts/           # 公共 prompt 片段（可复用）
    ├── output-format.md
    ├── persona.md
    └── constraints.md
```

## 使用规范

- Context 文件由各 Orchestrator 的输出自动更新
- 每个 context 文件控制在 500 token 以内（避免膨胀）
- 修改 context 需通过 O10-meta 审核（防止信息腐化）
