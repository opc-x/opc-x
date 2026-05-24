# O03 · Product — 产品规划

> 负责产品定义、需求文档、功能设计与路线图管理。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-prd-writing | PRD 撰写 | 功能需求描述 | 标准 PRD 文档 |
| 2 | S02-feature-scoping | 功能范围界定 | 需求列表 | In/Out scope 表 |
| 3 | S03-roadmap-planning | 路线图规划 | 目标 + 资源 | 季度路线图 |
| 4 | S04-user-story | 用户故事拆解 | Epic 描述 | Story + AC 清单 |
| 5 | S05-wireframe-spec | 线框图规格 | 功能描述 | 交互规格文档 |
| 6 | S06-acceptance-criteria | 验收标准定义 | 功能描述 | AC 检查清单 |
| 7 | S07-ab-test-design | A/B 测试设计 | 假设 + 指标 | 实验方案 |
| 8 | S08-mvp-definition | MVP 定义 | 产品愿景 | MVP 范围 + 成功标准 |
| 9 | S09-changelog-writing | 更新日志撰写 | 变更列表 | 用户友好 changelog |
| 10 | S10-feedback-triage | 反馈分类处理 | 用户反馈原文 | 分类 + 优先级标注 |

## 调用示例

```
触发词: "为新功能写PRD"
Orchestrator 路由: S08-mvp-definition → S01-prd-writing → S04-user-story
输出: PRD文档 + 用户故事列表
```

## 上下游

- **输入来源**: O01-strategy (目标) / O02-research (用户需求)
- **输出去向**: O04-engineering (开发需求) / O07-operations (发布流程)
- **共享 context**: `shared/contexts/product-context.md`
