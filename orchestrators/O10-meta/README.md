# O10 · Meta — 元认知

> 负责系统复盘、学习迭代、习惯设计与 OPC-X 自身的持续进化。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-weekly-review | 周复盘 | 本周工作记录 | 复盘报告 + 下周计划 |
| 2 | S02-skill-gap-analysis | 技能差距分析 | 目标能力 + 现状 | 差距图 + 学习路径 |
| 3 | S03-learning-plan | 学习计划 | 学习目标 + 时间约束 | 结构化学习方案 |
| 4 | S04-system-audit | 系统审计 | OPC-X 使用记录 | 效率报告 + 优化建议 |
| 5 | S05-habit-design | 习惯设计 | 目标行为 + 现有习惯 | 习惯堆叠方案 |
| 6 | S06-knowledge-capture | 知识沉淀 | 经验/决策记录 | 结构化知识条目 |
| 7 | S07-energy-management | 精力管理 | 任务清单 + 精力状态 | 时间分配方案 |
| 8 | S08-decision-log | 决策日志 | 决策描述 + 背景 | 决策记录 + 评估框架 |
| 9 | S09-failure-analysis | 失败分析 | 失败事件描述 | 根因分析 + 改进措施 |
| 10 | S10-vision-update | 愿景迭代 | 当前愿景 + 新信息 | 更新后的愿景文档 |

## 调用示例

```
触发词: "帮我做周复盘"
Orchestrator 路由: S01-weekly-review → S08-decision-log → S06-knowledge-capture
输出: 复盘报告 + 决策日志更新 + 知识沉淀条目
```

## 上下游

- **输入来源**: 定期触发（每周/每月）/ 用户主动触发
- **输出去向**: O01-strategy (战略调整) / shared/contexts (系统更新)
- **共享 context**: `shared/contexts/meta-context.md`

---

> O10 是 OPC-X 的"大脑皮层"——唯一能修改其他 Orchestrator 的 Orchestrator。
