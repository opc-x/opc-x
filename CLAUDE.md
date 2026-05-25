# OPC-X — 元项目工作指南

> 你现在在 OPC-X **元项目**本身。这里是集团能力的源头，不是某个子公司。

## 当前身份

- **你在哪**：opc-x 元项目（集团宪法仓库）
- **你的职责**：维护和进化集团通用能力
- **不要做**：把这里当 talkflow 或其他子公司用

## 核心文件

```
AGENT.md                          ← 集团宪法，所有子公司 @import 这个
init.sh                           ← 子公司初始化脚本（curl 直接跑）
orchestrators/O{01-10}/
  orchestrator.md                 ← 部门协调规则 + 技能链
  skills/S{01-10}-*.md            ← 100 个原子技能 prompt
outputs/templates/                ← 子公司 CLAUDE.md 模板
```

## Slash Commands

| 命令 | 作用 |
|---|---|
| `/opc-audit` | 双向审计：元项目自检 + 专项回流识别 |
| `/opc-help` | 显示完整技能清单和使用指南 |

## 修改元项目的规则

- 修改 `AGENT.md` → 影响所有子公司（下次 Claude Code 开 session 生效）
- 修改 `orchestrators/*/skills/*.md` → 影响对应技能的 prompt
- 新增技能 → 创建文件 + 更新对应 `orchestrator.md` 的技能索引
- **不接受子公司专项逻辑**，只接受通用化改进（见 AGENT.md 反哺协议）
