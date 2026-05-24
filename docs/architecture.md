# OPC-X 架构文档

## 层级关系

```
用户需求 / 外部触发
        │
        ▼
  ┌─────────────┐
  │  决策层      │  ← Orchestrator 接收任务，分解，分发
  │  (10 ORC)   │
  └──────┬──────┘
         │ 调用原子技能
         ▼
  ┌─────────────┐
  │  能力层      │  ← 100 个原子技能，单一职责
  │  (100 Skills)│
  └──────┬──────┘
         │ 输出交付物
         ▼
  ┌─────────────┐
  │  产出层      │  ← 模板、文档、代码、报告
  │  (Outputs)  │
  └─────────────┘
```

## Orchestrator 设计规范

每个 Orchestrator 必须包含：
- `README.md` — 职责域、10个技能清单、调用示例
- `skills/` — 各原子技能的 prompt 文件
- `context.md` — 该域的背景知识与约束

## 技能原子化规范

- 单一职责：一个技能只做一件事
- 输入/输出明确：定义清晰的 input schema 和 output format
- 无状态：技能本身不持久化，通过 shared/contexts 传递上下文
- 可测试：每个技能有对应的测试用例

## 跨域协作规范

```
O01 → shared/contexts/strategy-context.md → O03 (Product)
O02 → shared/contexts/research-context.md → O06 (Marketing)
O04 → shared/contexts/tech-context.md     → O07 (Operations)
O08 → shared/contexts/data-context.md     → O09 (Finance)
O10 → shared/contexts/meta-context.md     → 所有 Orchestrator
```

## 命名规范

| 类型 | 格式 | 示例 |
|------|------|------|
| Orchestrator | `O{NN}-{domain}` | `O01-strategy` |
| Skill | `S{NN}-{action}-{object}` | `S01-set-goal` |
| Output template | `T-{type}-{name}` | `T-prd-template` |
| Context file | `{domain}-context.md` | `strategy-context.md` |
