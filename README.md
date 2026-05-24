# OPC-X — One-Person Company eXoskeleton

> 一人公司的 AI 外骨骼系统，终身复用，高内聚低耦合。

## 三层架构

```
┌─────────────────────────────────────────┐
│           决策层 (Decision)              │
│   10 Orchestrators — 协调、规划、判断    │
├─────────────────────────────────────────┤
│           产出层 (Output)                │
│   Templates / Artifacts / Deliverables  │
├─────────────────────────────────────────┤
│           能力层 (Capability)            │
│   100 原子技能 — 每个 Orchestrator × 10  │
└─────────────────────────────────────────┘
```

## 10 Orchestrators

| # | 域 | 职责 |
|---|---|---|
| O01 | Strategy  | 战略决策、目标设定、优先级管理 |
| O02 | Research  | 调研分析、竞品、用户洞察 |
| O03 | Product   | 产品规划、PRD、路线图 |
| O04 | Engineering | 工程开发、架构、代码评审 |
| O05 | Content   | 内容创作、文案、文档 |
| O06 | Marketing | 增长营销、渠道、活动策划 |
| O07 | Operations | 运营流程、SOP、自动化 |
| O08 | Data      | 数据分析、指标、报表 |
| O09 | Finance   | 财务管理、定价、预测 |
| O10 | Meta      | 元认知、复盘、系统迭代 |

## 目录结构

```
opc-x/
├── orchestrators/     # 决策层 — 10 个 Orchestrator
│   ├── O01-strategy/
│   ├── O02-research/
│   ├── O03-product/
│   ├── O04-engineering/
│   ├── O05-content/
│   ├── O06-marketing/
│   ├── O07-operations/
│   ├── O08-data/
│   ├── O09-finance/
│   └── O10-meta/
├── outputs/           # 产出层 — 模板与交付物
│   └── templates/
├── shared/            # 共享 prompts / contexts
└── docs/              # 架构文档
```

## 设计原则

- **原子化**：每个技能单一职责，可独立调用
- **高内聚**：同域技能归属同一 Orchestrator
- **低耦合**：Orchestrator 间通过 shared context 传递，不直接依赖
- **终身复用**：一人公司场景驱动，持续沉淀

---

*Built for a one-person company. Owned by one human, operated by AI.*
