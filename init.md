# OPC-X 子公司初始化协议

你是一个 OPC-X 集团初始化 Agent。当前工作目录就是要初始化的子公司项目根目录。

## 你需要理解的结构

opc-x（集团，GitHub 远程 `https://github.com/opc-x/opc-x`）有且仅有两个扩展点：

```
扩展点                                用途
────────────────────────────────────  ──────────────────────────
orchestrators/O0X-*/skills/           往部门挂原子技能
outputs/templates/O0X-{dept}.md       控制部门输出格式
```

**关键规则：两个扩展点严格 1:1 对应。** 同一个 `O0X` 前缀永远绑定在一起：

```
orchestrators/O0X-{name}/  ←→  outputs/templates/O0X-{name}.md
```

`orchestrator.md` = 执行规则（做什么）；`O0X-{name}.md` = 输出格式（输出长什么样）。
永远 10 对，不多不少，不跳号。

你要在本地项目生成的 `.opc/` 完全镜像这两个扩展点：

```
.opc/
├── context.md                        项目领域知识
├── project-state.md                  螺旋状态
├── orchestrators/O0X-*/              镜像集团部门，放专项技能
│   ├── orchestrator.md               专项上下文（覆盖集团通用）
│   └── skills/                       ← 扩展点1 专项版
└── outputs/
    └── templates/                    ← 扩展点2 专项版（覆盖集团默认输出格式）
        └── O0X-{dept}.md
```

---

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
- 契约层（只读）：opc-x AGENT.md + .opc/ 本地文件
- 输出层（读写）：GitHub Issues（战术板 + 部门队列）
- 任务开始前：读 `.opc/project-state.md` + 读 GitHub 战术板
- 任务结束后：结果写回 GitHub 战术板 / 部门 Issue，判断是否更新 `.opc/project-state.md`
```

**已存在** → 检查顶部有没有 `@https://raw.githubusercontent.com/opc-x/opc-x/main/AGENT.md`，没有则插入到文件最顶部。

---

## Step 2 — .opc/context.md

**定位：永久静态领域知识，跨圈不变。** 不记录当前圈的执行状态——那些属于战术板 Issue。

不存在则创建（已存在跳过）：
```
# {PROJECT} — 领域上下文

> 永久静态领域知识。跨圈不变。当前圈的运行上下文在战术板 GitHub Issue 里。

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

## Step 2.5 — .opc/strategy-board.md（协议指针）

不存在则创建（已存在跳过）。本地文件只存协议，不存内容：

```
# {PROJECT} 战术板（协议指针）

战术板活在 GitHub Issues，每轮螺旋一个，指挥官管生命周期。

## 操作

​```bash
# 找当前战术板
gh issue list --label strategy-board --state open --limit 1

# 新开一圈
gh issue create --label strategy-board \
  --title "🗺️ {PROJECT} 战术板 · 第N圈" \
  --body "..."

# 查历史
gh issue list --label strategy-board --state closed
​```
```

如果有 GitHub remote，同步创建第 1 圈战术板 Issue（使用集团模板 `opc-x/outputs/templates/strategy-board.md` 作为 body）：

```bash
TEMPLATE=$(curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/outputs/templates/strategy-board.md)
gh issue create --label strategy-board \
  --title "🗺️ {PROJECT} 战术板 · 第1圈" \
  --body "$TEMPLATE"
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

## Step 5 — .opc/outputs/templates/（扩展点2 专项版）

为每个部门创建输出模板文件，内容继承集团默认，子公司可按需覆盖。

创建 `.opc/outputs/templates/` 目录，生成以下10个文件：

| 文件 | 初始内容 |
|---|---|
| `O01-strategy.md` | 继承集团默认（见 opc-x/outputs/templates/O01-strategy.md） |
| `O02-research.md` | 继承集团默认 |
| `O03-product.md` | 继承集团默认 |
| `O04-engineering.md` | 继承集团默认，**如果 context.md 有技术栈则补充验证命令** |
| `O05-content.md` | 继承集团默认 |
| `O06-marketing.md` | 继承集团默认 |
| `O07-operations.md` | 继承集团默认 |
| `O08-data.md` | 继承集团默认 |
| `O09-finance.md` | 继承集团默认，**如果 context.md 有定价信息则补充** |
| `O10-meta.md` | 继承集团默认 |

每个文件格式：
```
# O0X·{部门} — {PROJECT} 输出模板

> 继承集团默认模板。在此追加或覆盖 {PROJECT} 专项格式。

{集团默认模板内容}
```

---

## Step 5.5 — GitHub Labels（O01-O10 部门标签）

检查当前目录是否有 `.git` + GitHub remote：
```bash
git remote get-url origin 2>/dev/null
```

如果有 GitHub remote，批量创建 10 个部门标签（已存在的跳过，不报错）：

```bash
gh label create "O01-strategy"    --color "0052CC" --description "战略部任务队列" --force
gh label create "O02-research"    --color "5319E7" --description "调研部任务队列" --force
gh label create "O03-product"     --color "006B75" --description "产品部任务队列" --force
gh label create "O04-engineering" --color "E4E669" --description "工程部任务队列（Cursor接单）" --force
gh label create "O05-content"     --color "EE9900" --description "内容部任务队列" --force
gh label create "O06-marketing"   --color "E99695" --description "营销部任务队列" --force
gh label create "O07-operations"  --color "BFD4F2" --description "运营部任务队列" --force
gh label create "O08-data"        --color "D93F0B" --description "数据部任务队列（SQL类Cursor接单）" --force
gh label create "O09-finance"     --color "0E8A16" --description "财务部任务队列" --force
gh label create "O10-meta"        --color "CCCCCC" --description "元认知任务队列（strategy-board维护）" --force
gh label create "strategy-board"  --color "0075CA" --description "战术板 - 指挥官作战面板（每项目唯一）" --force
```

如果没有 GitHub remote，跳过此步，提示用户后续手动执行或在连接 GitHub 后运行。

---

## Step 6 — .claude/commands/{PROJECT}.md

```
# /{PROJECT} — 子公司全套能力

## 激活协议

你现在以 **{PROJECT} 子公司模式**运行。

**激活时必读（按顺序）：**
1. GitHub 战术板：`gh issue list --label strategy-board --json number,body --jq '.[0]'`
2. `.opc/project-state.md` — 螺旋状态（契约层）
3. 集团 AGENT.md 跨部门级联协议已加载（契约层）

## 任务

$ARGUMENTS

## 执行决策树

```
有 $ARGUMENTS？
  YES → 按意图路由到对应部门执行
  NO  → 读 GitHub 战术板「作战命令」→ 找状态=待执行 → 执行
        → 找不到 → 输出战术板全局状态分析
```

## 路由规则

1. 意图匹配 → 确定部门 O0X
2. 读 `.opc/orchestrators/O0X-*/orchestrator.md` — 专项上下文
3. 读 `.opc/orchestrators/O0X-*/skills/` — 专项技能（有则用）
4. 按 AGENT.md 级联协议判断是否触发下一棒部门

## 执行输出

[O0X·{部门} → {技能}]
{执行结果}
---
战术板写回：gh issue edit {N} — 命令#X 状态→完成，追加战略结果
级联触发：{下一棒部门 / 无}
回流候选：{通用模式 / 无}

## 执行后（必须做）

1. 结果写回 GitHub 战术板 Issue（`gh issue edit`，不改本地文件）
2. 判断是否触发级联 → 触发则继续执行，不等指挥官开口
3. 本圈全部完成 → O10 在战术板写入「战略结果」+ 更新 `.opc/project-state.md`

## 特殊命令

/{PROJECT} 回流检查 → 扫描 `.opc/orchestrators/` 识别可回流到 opc-x 的通用模式
```

---

## Step 7 — 完成输出

```
✅ {PROJECT} 子公司初始化完成

已创建：
  CLAUDE.md                              集团能力导入 + strategy-board 挂载
  .opc/context.md                        填写领域知识
  .opc/project-state.md                  填写 Vision + 螺旋状态
  .opc/strategy-board.md                 战略作战室（上帝视角，O10 维护）
  .opc/orchestrators/O01~O10/            镜像集团部门（扩展点1：专项技能）
  .opc/outputs/templates/O01~O10/        镜像集团输出模板（扩展点2：输出格式）
  .claude/commands/{PROJECT}.md          /{PROJECT} 命令可用
  GitHub Labels O01~O10                  部门任务队列标签（有 remote 时自动创建）

扩展方式：
  专项技能   → .opc/orchestrators/O0X-*/skills/ 新建文件
  覆盖输出   → .opc/outputs/templates/O0X-{dept}.md 编辑

用法：
  /{PROJECT} <任务>         触发全套子公司能力
  /{PROJECT} 回流检查       识别可推回 opc-x 的通用模式
  gh issue list --label O04-engineering  查看工程部待办队列
```
