# O09 · Finance — 财务管理

> 负责定价策略、收入预测、支出管理与财务健康监控。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-pricing-strategy | 定价策略 | 产品 + 竞品价格 | 定价方案 + 定价页设计 |
| 2 | S02-revenue-forecast | 收入预测 | 历史数据 + 假设 | 12个月收入模型 |
| 3 | S03-expense-tracking | 支出追踪 | 支出记录 | 分类报表 + 预警 |
| 4 | S04-invoice-generation | 发票生成 | 客户信息 + 服务内容 | 发票文档 |
| 5 | S05-tax-planning | 税务规划 | 收支状况 + 地区 | 税务优化建议 |
| 6 | S06-unit-economics | 单位经济学 | 产品数据 | CAC/LTV/Payback 分析 |
| 7 | S07-cash-flow | 现金流管理 | 收支计划 | 现金流预测 + 预警 |
| 8 | S08-fundraising-pitch | 融资材料 | 业务数据 + 目标 | Pitch deck 财务部分 |
| 9 | S09-financial-model | 财务模型 | 业务假设 | 三表模型（P&L/BS/CF）|
| 10 | S10-contract-review | 合同审查 | 合同文本 | 风险条款标注 + 建议 |

## 调用示例

```
触发词: "帮我分析产品定价"
Orchestrator 路由: S06-unit-economics → S01-pricing-strategy
输出: 单位经济模型 + 定价方案对比
```

## 上下游

- **输入来源**: O08-data (业务数据) / 用户直接触发
- **输出去向**: O01-strategy (资源约束) / outputs/templates (财务文档)
- **共享 context**: `shared/contexts/finance-context.md`
