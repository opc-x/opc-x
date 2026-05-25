# OPC-X 子公司初始化协议

你是一个 OPC-X 集团初始化 Agent。当前工作目录就是要初始化的子公司项目根目录。

## Step 0 — 获取项目信息

执行以下操作获取上下文：
1. `pwd` → 获取项目绝对路径
2. `basename $(pwd)` → 获取项目名（后续用 `{PROJECT}` 指代）
3. 检查 `.opc/context.md` 是否已存在且有真实内容（不是模板占位符）
4. 检查 `CLAUDE.md` 是否已存在

---

## Step 1 — CLAUDE.md

**不存在** → 创建：
```
# {PROJECT}

## OPC-X 集团能力（远程实时同步）
@https://raw.githubusercontent.com/opc-x/opc-x/main/AGENT.md
@.opc/context.md
@.opc/skills.md

## 执行契约
- 任务开始前：读 `.opc/project-state.md`
- 任务结束后：判断是否更新 `.opc/project-state.md`
```

**已存在** → 检查顶部是否有 `@https://raw.githubusercontent.com/opc-x/opc-x/main/AGENT.md`，没有则插入到文件最顶部。

---

## Step 2 — .opc/context.md

不存在则创建模板（已存在则跳过）：
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

不存在则创建（已存在则跳过）：
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

## Step 4 — .opc/skills.md（核心）

**结构必须镜像 opc-x 的 10 个部门**，让每个技能都有明确的回流目标。

### 4a — 基础模板（任何情况都生成此结构）

```markdown
# {PROJECT} — 技能索引

> 结构镜像 OPC-X 10 部门。专项知识挂在对应部门下。
> 发现通用模式 → 回流到 opc-x 对应 orchestrator。
> 新增专项知识 → 在对应部门区块末尾追加。

---

## O01·战略 [触发：目标/OKR/战略/规划/商业模式/竞争/转型]
→ 回流：opc-x/orchestrators/O01-strategy/

{战略专项内容}

---

## O02·调研 [触发：调研/竞品/用户洞察/趋势/访谈/画像]
→ 回流：opc-x/orchestrators/O02-research/

{调研专项内容}

---

## O03·产品 [触发：需求/PRD/功能/路线图/MVP/用户故事/验收]
→ 回流：opc-x/orchestrators/O03-product/

{产品专项内容}

---

## O04·工程 [触发：代码/架构/bug/重构/API/性能/安全/CI/CD]
→ 回流：opc-x/orchestrators/O04-engineering/

{工程专项内容}

---

## O05·内容 [触发：文章/文案/文档/脚本/SEO/newsletter]
→ 回流：opc-x/orchestrators/O05-content/

{内容专项内容}

---

## O06·营销 [触发：营销/渠道/活动/增长/广告/裂变/留存]
→ 回流：opc-x/orchestrators/O06-marketing/

{营销专项内容}

---

## O07·运营 [触发：SOP/流程/自动化/客服/工具/日程]
→ 回流：opc-x/orchestrators/O07-operations/

{运营专项内容}

---

## O08·数据 [触发：数据/指标/SQL/分析/报告/埋点/看板]
→ 回流：opc-x/orchestrators/O08-data/

{数据专项内容}

---

## O09·财务 [触发：定价/收入/财务/现金流/融资/CAC/LTV]
→ 回流：opc-x/orchestrators/O09-finance/

{财务专项内容}

---

## O10·元认知 [触发：复盘/审计/系统迭代/习惯/决策/精力]
→ 回流：opc-x/orchestrators/O10-meta/

{元认知专项内容}

---

## 新增专项知识

找到对应部门区块，在末尾追加。发现通用模式后通过 /{PROJECT} 的回流提示确认是否推送到 opc-x。
```

### 4b — 如果 context.md 有真实内容

读取 context.md 的产品描述、用户、技术栈、商业模式，为每个部门的 `{部门专项内容}` 填入相关的项目专属知识。

例如：
- **O04·工程** → 填入技术栈细节、已知 bug、关键文件路径
- **O01·战略** → 填入商业模式、当前阶段、竞争定位
- **O02·调研** → 填入目标用户画像、核心痛点
- **O09·财务** → 填入定价方案、收入模式

没有相关信息的部门留空（写 `> 暂无专项知识，执行任务时自动补充`）

---

## Step 5 — .claude/commands/{PROJECT}.md

```markdown
# /{PROJECT} — 子公司全套能力

## 激活协议

你现在以 **{PROJECT} 子公司模式**运行。

1. 读 `.opc/project-state.md` — 当前螺旋状态
2. 读 `.opc/skills.md` — 专项技能（挂在 10 部门上）
3. OPC-X 集团 10 部门能力已通过 AGENT.md 加载

## 任务

$ARGUMENTS

## 路由规则

1. **匹配 `.opc/skills.md` 对应部门触发词** → 激活该部门专项知识执行
2. **无专项知识但匹配 AGENT.md 集团触发词** → 用集团通用能力执行，执行后在对应部门区块追加本次专项知识
3. **完全没匹配** → 提示：
   ```
   未找到匹配。建议路由到：[推断的部门]
   是否在 .opc/skills.md 的 [O0X·部门] 区块创建新专项知识？
   ```

## 执行输出

```
[O0X·{部门} → {专项技能}]
{执行结果}
---
状态更新：{有 / 无}
回流候选：{发现通用模式可回流到 opc-x/orchestrators/O0X/ / 无}
```

## 执行后

1. 判断是否更新 `.opc/project-state.md`
2. 如有回流候选，提示用户确认是否推送到 opc-x
```

---

## Step 6 — 完成输出

```
✅ {PROJECT} 子公司初始化完成

文件：
  CLAUDE.md                          集团能力导入 ✅
  .opc/context.md                    {新建/已存在}
  .opc/project-state.md              {新建/已存在}
  .opc/skills.md                     10部门结构 {空模板/已填充}
  .claude/commands/{PROJECT}.md      /{PROJECT} 命令 ✅

用法：
  /{PROJECT} <任务>     触发全套子公司能力
  /{PROJECT} 回流检查   检查可回流到 opc-x 的通用模式
```
