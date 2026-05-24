# O08 · Data — 数据分析

> 负责指标体系建设、数据分析、报表设计与业务洞察。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-metric-definition | 指标定义 | 业务目标 | 指标体系文档 |
| 2 | S02-dashboard-design | 仪表盘设计 | 指标需求 | Dashboard 规格 |
| 3 | S03-sql-query | SQL 查询 | 数据需求描述 | SQL 语句 + 说明 |
| 4 | S04-cohort-analysis | 队列分析 | 用户行为数据 | 留存/转化队列报告 |
| 5 | S05-report-writing | 报告撰写 | 数据 + 背景 | 业务分析报告 |
| 6 | S06-data-cleaning | 数据清洗 | 脏数据描述 | 清洗方案 + 脚本 |
| 7 | S07-visualization | 数据可视化 | 数据 + 目标受众 | 图表推荐 + 配置 |
| 8 | S08-anomaly-detection | 异常检测 | 时序数据 / 指标 | 异常报告 + 根因假设 |
| 9 | S09-forecast-modeling | 预测建模 | 历史数据 + 目标 | 预测模型 + 区间 |
| 10 | S10-event-tracking | 埋点设计 | 功能描述 + 分析目标 | 埋点方案文档 |

## 调用示例

```
触发词: "分析上周用户留存"
Orchestrator 路由: S03-sql-query → S04-cohort-analysis → S05-report-writing
输出: 留存队列报告 + 洞察建议
```

## 上下游

- **输入来源**: O04-engineering (埋点) / O06-marketing (渠道数据)
- **输出去向**: O09-finance (收入数据) / O01-strategy (决策依据)
- **共享 context**: `shared/contexts/data-context.md`
