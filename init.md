# OPC-X 子公司初始化协议

你是一个 OPC-X 集团初始化 Agent。当前工作目录就是要初始化的子公司项目根目录。

## Step 0 — 获取项目信息

1. `pwd` → 项目绝对路径
2. `basename $(pwd)` → 项目名（后续用 `{PROJECT}` 指代）
3. 检查以下文件是否已存在（已存在的跳过，不覆盖）

---

## Step 1 — CLAUDE.md

**不存在** → 创建：
```
# {PROJECT}

## OPC-X 集团能力（远程实时同步）
@https://raw.githubusercontent.com/opc-x/opc-x/main/AGENT.md
@.opc/context.md

## 执行契约
- 任务开始前：读 `.opc/project-state.md`
- 任务结束后：判断是否更新 `.opc/project-state.md`
```

**已存在** → 检查顶部有没有 `@https://raw.githubusercontent.com/opc-x/opc-x/main/AGENT.md`，没有则插入到文件最顶部。

---

## Step 2 — .opc/context.md

不存在则创建（已存在跳过）：
```
# {PROJECT} — 领域上下文

## 产品描述
[这个产品是什么，解决什么问题]

## 目标用户
[核心用户画像]

## 技术栈
[主要技术选型]

## 商业模式
[收入模式，定价区间]

## 当前阶段
[MVP / PMF验证 / 增长 / 规模化]
```

---

## Step 3 — .opc/project-state.md

不存在则创建（已存在跳过）：
```
# {PROJECT} — 螺旋状态

## Vision（靶心）
[终极目标]

## 当前圈层：第 1 圈
决策 → 需求 → 执行 → 验收 → 反馈
↑ 当前在这里

## 本圈核心目标
[这一圈要解决的最重要的一件事]

## 已完成
- [ ] 无

## 待决策
[下一个需要决策的问题]

---
最后更新：{今天日期}
```

---

## Step 4 — .opc/orchestrators/（核心，镜像 opc-x 结构）

为每个部门创建目录和 orchestrator.md。结构与 opc-x 完全一致，内容换成项目专属。

**目录结构**：
```
.opc/orchestrators/
├── O01-strategy/
│   ├── orchestrator.md
│   └── skills/
├── O02-research/
│   ├── orchestrator.md
│   └── skills/
├── O03-product/
│   ├── orchestrator.md
│   └── skills/
├── O04-engineering/
│   ├── orchestrator.md
│   └── skills/
├── O05-content/
│   ├── orchestrator.md
│   └── skills/
├── O06-marketing/
│   ├── orchestrator.md
│   └── skills/
├── O07-operations/
│   ├── orchestrator.md
│   └── skills/
├── O08-data/
│   ├── orchestrator.md
│   └── skills/
├── O09-finance/
│   ├── orchestrator.md
│   └── skills/
└── O10-meta/
    ├── orchestrator.md
    └── skills/
```

每个 `orchestrator.md` 默认内容：
```
# O0X · {部门名} — {PROJECT} 专项

> 暂无专项内容，使用集团通用能力。
> 执行相关任务时在此追加 {PROJECT} 专属知识。

## 回流路径
opc-x/orchestrators/O0X-{name}/
```

**如果 context.md 有真实内容**（不是占位符）：
读取产品描述、用户、技术栈、商业模式，为相关部门的 orchestrator.md 填入专项知识：
- O01 → 商业模式、竞争定位、当前阶段
- O02 → 目标用户、核心痛点
- O03 → 核心功能、路线图现状
- O04 → 技术栈、关键文件、已知 Bug
- O06 → 获客渠道、增长策略
- O08 → 核心指标、数据来源
- O09 → 定价、收入模式

无相关信息的部门保留默认占位内容。

---

## Step 5 — .claude/commands/{PROJECT}.md

```
# /{PROJECT} — 子公司全套能力

## 激活协议

你现在以 **{PROJECT} 子公司模式**运行。

1. 读 `.opc/project-state.md` — 当前螺旋状态
2. 集团 10 部门能力已通过 AGENT.md 加载
3. 专项 orchestrator 在 `.opc/orchestrators/O0X-*/orchestrator.md`

## 任务

$ARGUMENTS

## 路由规则

1. 意图匹配 → 确定部门 O0X
2. 读 `.opc/orchestrators/O0X-*/orchestrator.md` — 专项上下文
3. 读 `.opc/orchestrators/O0X-*/skills/` — 专项技能（有则用）
4. 专项为空 → 降级用集团通用能力，执行后将专项知识追加到对应 orchestrator.md

## 执行输出

[O0X·{部门} → {技能}]
{执行结果}
---
状态更新：{有/无}
回流候选：{通用模式 → opc-x/orchestrators/O0X/ / 无}

## 执行后

1. 判断是否更新 `.opc/project-state.md`
2. 有回流候选时提示用户确认

## 特殊命令

/{PROJECT} 回流检查 → 扫描 `.opc/orchestrators/` 识别可回流到 opc-x 的通用模式
```

---

## Step 6 — 完成输出

```
✅ {PROJECT} 子公司初始化完成

已创建：
  CLAUDE.md                              集团能力导入
  .opc/context.md                        填写领域知识
  .opc/project-state.md                  填写 Vision
  .opc/orchestrators/O01~O10/            镜像集团部门结构
  .claude/commands/{PROJECT}.md          /{PROJECT} 命令可用

用法：
  /{PROJECT} <任务>       触发全套子公司能力
  /{PROJECT} 回流检查     识别可推回 opc-x 的通用模式
```
