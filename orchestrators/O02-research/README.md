# O02 · Research — 调研分析

> 负责市场调研、竞品分析、用户洞察与趋势扫描。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-competitor-analysis | 竞品分析 | 竞品列表/品类 | 对比表 + 差距图 |
| 2 | S02-user-interview | 用户访谈设计 | 研究问题 | 访谈提纲 + 分析框架 |
| 3 | S03-trend-scanning | 趋势扫描 | 领域关键词 | 趋势报告 |
| 4 | S04-literature-review | 文献综述 | 研究主题 | 结构化摘要 |
| 5 | S05-survey-design | 问卷设计 | 研究目标 | 问卷 + 分析方法 |
| 6 | S06-data-sourcing | 数据来源发现 | 数据需求描述 | 数据源清单 |
| 7 | S07-insight-synthesis | 洞察合成 | 原始调研数据 | 核心洞察 + 行动建议 |
| 8 | S08-persona-building | 用户画像构建 | 用户访谈/数据 | Persona 文档 |
| 9 | S09-jobs-to-be-done | JTBD 分析 | 用户行为描述 | JTBD 地图 |
| 10 | S10-benchmarking | 行业标杆对比 | 指标 + 行业 | 标杆分析报告 |

## 调用示例

```
触发词: "分析AI写作工具竞品"
Orchestrator 路由: S01-competitor-analysis → S07-insight-synthesis
输出: 竞品对比表 + 差异化机会点
```

## 上下游

- **输入来源**: 用户直接触发 / O01-strategy 战略问题
- **输出去向**: O03-product (用户需求) / O06-marketing (目标用户)
- **共享 context**: `shared/contexts/research-context.md`
