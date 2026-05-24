# O06 · Marketing — 增长营销

> 负责用户获取、渠道策略、活动策划与增长实验。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-channel-selection | 渠道筛选 | 产品 + 目标用户 | 渠道优先级矩阵 |
| 2 | S02-campaign-design | 活动策划 | 目标 + 预算 | 完整活动方案 |
| 3 | S03-landing-page | 落地页优化 | 当前页面 + 目标 | 优化建议 + 文案 |
| 4 | S04-growth-experiment | 增长实验 | 假设 + 指标 | 实验设计 + 评估框架 |
| 5 | S05-referral-design | 裂变设计 | 产品 + 用户激励 | 裂变机制方案 |
| 6 | S06-ad-creative | 广告创意 | 产品 + 渠道 | 广告素材 + 文案变体 |
| 7 | S07-funnel-analysis | 漏斗分析 | 漏斗数据 | 瓶颈定位 + 优化建议 |
| 8 | S08-retention-strategy | 留存策略 | 流失数据 + 用户行为 | 留存干预方案 |
| 9 | S09-partnership | 合作伙伴开发 | 目标领域 | 合作方清单 + 接触策略 |
| 10 | S10-launch-planning | 产品发布策划 | 产品描述 + 时间线 | 发布计划 + checklist |

## 调用示例

```
触发词: "规划产品发布"
Orchestrator 路由: S10-launch-planning → S01-channel-selection → S02-campaign-design
输出: 发布计划 + 渠道矩阵 + 活动方案
```

## 上下游

- **输入来源**: O01-strategy (增长目标) / O02-research (用户洞察)
- **输出去向**: O05-content (内容需求) / O08-data (转化追踪)
- **共享 context**: `shared/contexts/growth-context.md`
