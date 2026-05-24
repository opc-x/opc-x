# O01 · Strategy — 战略决策

> 负责目标设定、优先级判断、商业逻辑与资源分配。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-goal-setting | 目标设定与分解 | 愿景描述 | OKR / 里程碑树 |
| 2 | S02-prioritization | 优先级矩阵 | 任务列表 | 排序后的行动清单 |
| 3 | S03-market-sizing | 市场规模评估 | 品类描述 | TAM/SAM/SOM |
| 4 | S04-business-model | 商业模式分析 | 产品描述 | 收入/成本/壁垒分析 |
| 5 | S05-pivot-decision | 转型决策框架 | 当前状态+信号 | 留/转/退建议 |
| 6 | S06-risk-assessment | 风险评估 | 计划/决策 | 风险矩阵 |
| 7 | S07-resource-allocation | 资源分配 | 目标+资源清单 | 分配方案 |
| 8 | S08-okr-design | OKR 设计 | 季度目标 | OKR 文档 |
| 9 | S09-competitive-positioning | 竞争定位 | 竞品列表 | 定位图+差异化策略 |
| 10 | S10-exit-strategy | 扩张/退出策略 | 当前规模+目标 | 阶段性路径 |

## 调用示例

```
触发词: "帮我规划Q3目标"
Orchestrator 路由: S08-okr-design → S01-goal-setting → S02-prioritization
输出: OKR文档 + 优先级行动表
```

## 上下游

- **输入来源**: 用户直接触发 / O10-meta 复盘结论
- **输出去向**: O03-product (产品路线图) / O06-marketing (营销目标)
- **共享 context**: `shared/contexts/strategy-context.md`
