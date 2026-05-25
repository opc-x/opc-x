# OPC-X — One-Person Company eXoskeleton

一人公司的 AI 外骨骼。10 个部门，100 个原子技能，一套螺旋执行协议。
丢给任意 AI，集团能力立即激活。

## 新建项目

```bash
curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.sh | bash -s -- <项目名>
```

生成 `.opc/` 结构 + `CLAUDE.md`，用 Claude Code 打开即用。无需克隆 opc-x，远程自动同步。

## 架构

```
OPC-X 集团（本仓库）
├── 运营节律：螺旋协议（全局，凌驾于部门之上）
│   决策(O01) → 需求(O03) → 执行(O04-07) → 验收(O08) → 反馈(O10) → +1圈
│
├── 10 部门（Orchestrators）
│   O01 战略 · O02 调研 · O03 产品 · O04 工程 · O05 内容
│   O06 营销 · O07 运营 · O08 数据 · O09 财务 · O10 元认知
│
└── 100 技能（Skills）— 动态挂载，可增/删/迁/升

子公司（你的项目）
└── .opc/
    ├── context.md         ← 项目领域知识
    ├── project-state.md   ← 螺旋状态（每轮更新）
    └── skills/            ← 专项技能（扩展集团能力）
```

## 项目里的 CLAUDE.md

```markdown
## OPC-X 集团能力（远程实时同步）
@https://raw.githubusercontent.com/opc-x/opc-x/main/AGENT.md
@.opc/context.md
```

opc-x 更新 → 所有项目下次打开 Claude Code 自动获得新版本。

## 文件结构

```
opc-x/
├── AGENT.md                    ← 集团宪法（所有子公司 @import）
├── init.sh                     ← 子公司初始化（curl 直接跑）
├── orchestrators/
│   └── O{01-10}-{domain}/
│       ├── orchestrator.md     ← 部门协调规则 + 技能链
│       └── skills/S{01-10}-*.md
├── docs/spiral.svg             ← 螺旋执行协议图
└── outputs/templates/          ← 子公司 CLAUDE.md 模板
```

---

*OPC-X v2.1 · 集团能力通用 · 子公司状态独立 · 终身复用*
