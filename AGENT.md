# OPC-X — One-Person Company eXoskeleton

> **opc-x = GitHub 远程仓库 `https://github.com/opc-x/opc-x`**
> 所有提到「opc-x」「集团」「元项目」均指此仓库。本地项目通过 `@import` 拉取，无需克隆。

**新建项目（唯一入口）：**
```bash
curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.sh | bash
```

进入项目根目录执行，生成 `.opc/` + `CLAUDE.md` + `/{项目名}` 命令，Claude Code 打开即激活全部集团能力。

---

## 语义定义（消歧义，优先读）

OPC-X 同时承载两层语义，两种说法指向同一个东西：

| 维度 | OPC-X 本体 | 具体项目 |
|---|---|---|
| **组织维度** | 集团 | 子公司 |
| **项目维度** | 元项目 | 专项 |

**推理规则**：
- 问「能力从哪来 / 技能归谁所有」→ 用**组织维度**：集团提供，子公司继承
- 问「现在执行什么范围 / 读哪个上下文」→ 用**项目维度**：专项隔离，读 `.opc/`
- 两层语义**不冲突**，分别回答不同问题，可同时成立

**文件归属**：
```
元项目(集团) = opc-x/              → 通用能力，跨专项复用
专项(子公司) = {project}/.opc/     → 项目状态，专项隔离
```

### 名词对照（组织视角 ↔ 工程视角）

| 组织视角（人看） | 工程视角（Agent 执行） | 说明 |
|---|---|---|
| 集团 | OPC-X / AGENT.md | 整个系统，宪法文件 |
| 子公司 | 专项 / `.opc/` | 具体项目，状态独立 |
| 部门 | Orchestrator | 职能域，10个，结构静态 |
| 员工 / 岗位 | Skill | 原子执行单元，动态增删 |
| 运营节律 | 螺旋协议 | 全公司工作节奏，凌驾于部门之上 |
| 一轮工作 | 螺旋一圈 | 决策→需求→执行→验收→反馈 |
| 靶心 / 目标 | Vision | `project-state.md` 里的终极目标 |
| 项目进度 | `project-state.md` | 螺旋记忆，每轮任务前读、后写 |
| 全局战略仪表盘 | `strategy-board.md` | 跨部门综合视图，上帝视角，O10 维护 |
| 部门任务队列 | GitHub Issues + O0X Label | 每个部门的持久化工作记忆 |
| CEO 办公室 | O10 · 元认知 | 复盘 / 审计 / 系统迭代 / strategy-board 维护 |
| 招聘 | 新建技能文件 | 按需增加岗位能力 |
| 离职 | 删除技能文件 | 淘汰过时岗位 |
| 调岗 | 技能回流 | 专项技能 → 元项目，需人确认 |
| 升职 | Prompt 迭代优化 | 同岗位能力提升 |

---

## 用例图（你怎么用这套系统）

```mermaid
graph TB
    U(["👤 你"])

    subgraph ONCE["一次性操作"]
        UC1["新建专项\ncurl init.sh | bash"]
    end

    subgraph DAILY["日常操作（随时）"]
        UC2["描述任务\nAI 自动路由执行"]
        UC3["查看/更新\nproject-state.md"]
    end

    subgraph LOOP["每轮结束"]
        UC4["O10 复盘\n推进螺旋下一圈"]
    end

    subgraph AUDIT["每2周"]
        UC5["/opc-audit\n双向审计"]
        UC6["确认回流改进\n更新元项目技能"]
    end

    subgraph AUTO["AI 自动完成（无需干预）"]
        A1["读上下文 → 路由 → 执行 → 更新状态"]
        A2["识别回流候选 → 等待你确认"]
    end

    U -->|"有新项目时"| UC1
    U -->|"有任何任务"| UC2
    U -->|"轮次推进时"| UC3
    U -->|"每轮结束"| UC4
    U -->|"定期"| UC5
    UC5 --> UC6
    UC2 -.->|"触发"| A1
    UC5 -.->|"触发"| A2
    A2 -.->|"建议"| UC6
```

---

## 视角一：组织架构

> 回答「这个公司有什么、谁干什么」。方便人理解和调用。

### 全链路层级（集团 → 子公司 → 部门 → 员工 → 执行）

```mermaid
graph TB
    OPC["🏢 OPC-X 集团\nAGENT.md — 集团宪法"]

    subgraph SUBS["子公司（每个项目独立）"]
        SUB_A["📦 TalkFlow\n.opc/project-state.md"]
        SUB_B["📦 项目 B\n.opc/project-state.md"]
        SUB_DOT["..."]
    end

    subgraph DEPTS["10 部门（集团通用）"]
        direction LR
        D1["O01 战略"] --- D2["O02 调研"] --- D3["O03 产品"] --- D4["O04 工程"] --- D5["O05 内容"]
        D6["O06 营销"] --- D7["O07 运营"] --- D8["O08 数据"] --- D9["O09 财务"] --- D10["O10 元认知"]
    end

    subgraph SKILLS["员工（动态挂载）"]
        SK["每个部门 × 10 原子技能\norchestrator.md 定义协调规则"]
    end

    EXEC["⚡ Agent 执行\n最终触达：具体技能 Skill"]

    OPC --> SUBS
    OPC --> DEPTS
    DEPTS --> SKILLS
    SUBS -->|"继承集团部门能力\n+ .opc/skills.md 专项扩展"| SKILLS
    SKILLS --> EXEC
```

### 部门内层级

```mermaid
graph TB
    RHYTHM["⟳ 全局运营节律 · 螺旋协议\n决策→需求→执行→验收→反馈→+1圈\n凌驾于所有部门之上，不属于任何单一部门"]

    subgraph COMPANY["🏢 OPC-X 集团"]
        subgraph DEPTS["10 部门（Orchestrators）"]
            direction LR
            O01["O01\n战略"] --- O02["O02\n调研"] --- O03["O03\n产品"] --- O04["O04\n工程"] --- O05["O05\n内容"]
            O06["O06\n营销"] --- O07["O07\n运营"] --- O08["O08\n数据"] --- O09["O09\n财务"] --- O10["O10\n元认知"]
        end
        SKILLS["🧑 岗位 · Skills（动态员工）\n100+ 原子技能文件 · 可增 / 删 / 迁 / 升"]
        DEPTS --> SKILLS
    end

    RHYTHM -->|"协调各部门按节律运转"| DEPTS
```

| 层 | 公司类比 | 实现 | 特性 |
|---|---|---|---|
| 运营节律 | 公司运作节奏 | 螺旋协议 | 全局，静态规则 |
| 部门 | 10 个职能域 | Orchestrators | 静态结构 |
| 员工 | 原子执行岗位 | Skills (.md) | **动态流动** |

**员工（Skills）流动规则**：

| 动作 | 操作 |
|---|---|
| 招聘 | 按需新建技能文件 |
| 离职 | 删除过时技能 |
| 调岗（回流） | 专项技能 → 元项目，需人确认 |
| 升职 | prompt 迭代优化 |

### 全局运营节律（螺旋协议）

> 公司级别的执行节奏，不是任何一个部门的功能。O10 元认知负责「反馈」这一步，让 +1圈 能发生，但螺旋本身属于全公司。

<img src="docs/spiral.svg" alt="OPC-X 螺旋执行协议" width="500"/>

> 三环同构：决策(O01)→需求(O03)→执行(O04-07)→验收(O08)→反馈(O10)，每圈 +1 层，螺旋上升至靶心。

### 反哺协议（技能回流）

```mermaid
graph LR
    META["🏢 元项目\nOPC-X"]
    SUB["📦 专项\n.opc/"]
    O10["O10 元认知\n审计 + 提炼"]

    META -->|"赋能：通用技能"| SUB
    SUB -->|"执行中发现改进"| O10
    O10 -->|"提炼通用模式 → 回流"| META
    O10 -->|"专项特有 → 留在 .opc/"| SUB
```

| 改进类型 | 判断标准 | 动作 |
|---|---|---|
| 通用模式 | 其他专项也能用 | 更新 `opc-x/orchestrators/` 对应技能 |
| 专项特有 | 只有这个领域用 | 留在 `.opc/skills/`，不回流 |

触发路径：专项执行 → `/opc-audit` 识别候选 → **你确认** → 更新元项目技能文件

---

## 视角二：工程执行

> 回答「Agent 怎么跑、状态怎么传、一次任务的完整流程」。方便人机协同。

### 单次任务执行契约

```mermaid
flowchart LR
    IN([用户输入]) --> RS[读\nproject-state.md]
    RS --> RT{路由\n意图匹配}
    RT --> LOAD[加载\nOrchestrator+Skill]
    LOAD --> EXEC[Agent Loop\nperceive→think→act→observe]
    EXEC --> OUT[输出\n交付物]
    OUT --> UPD{状态\n有变化?}
    UPD -->|是| WS[写\nproject-state.md]
    UPD -->|否| DONE([完成])
    WS --> DONE
    DONE -.->|"反馈→+1圈 / 命中靶心"| RS
```

输出格式：
```
[O{NN}·{域} → S{NN}·{技能名}]
{交付物}
---
状态更新：{更新了什么 / 无}
💡 下一步：{推荐关联技能}
```

**微观层（agent-loop，所有 agent 内置，无需定义）**：
```
perceive → think → act → observe → loop
OPC-X 螺旋运行在它之上，不干涉它。
```

### 路由表

#### O01 · Strategy · 战略部
触发：目标 / OKR / 战略 / 规划 / 转型 / 竞争 / 商业模式 / 市场
`S01`目标设定 · `S02`优先级矩阵 · `S03`市场规模 · `S04`商业模式 · `S05`转型决策
`S06`风险评估 · `S07`资源分配 · `S08`OKR设计 · `S09`竞争定位 · `S10`扩张退出

#### O02 · Research · 调研部
触发：调研 / 竞品 / 用户洞察 / 趋势 / 问卷 / 数据来源
`S01`竞品分析 · `S02`用户访谈 · `S03`趋势扫描 · `S04`文献综述 · `S05`问卷设计
`S06`数据来源 · `S07`洞察合成 · `S08`用户画像 · `S09`JTBD分析 · `S10`行业标杆

#### O03 · Product · 产品部
触发：PRD / 需求 / 功能 / 路线图 / MVP / 用户故事 / 验收
`S01`PRD撰写 · `S02`功能范围 · `S03`路线图 · `S04`用户故事 · `S05`线框图规格
`S06`验收标准 · `S07`AB测试 · `S08`MVP定义 · `S09`Changelog · `S10`反馈分类

#### O04 · Engineering · 工程部
触发：代码 / 架构 / bug / 重构 / API / 安全 / 性能 / CI/CD
`S01`代码评审 · `S02`架构设计 · `S03`调试诊断 · `S04`重构规划 · `S05`API设计
`S06`测试策略 · `S07`性能审计 · `S08`安全审查 · `S09`DevOps配置 · `S10`技术债

#### O05 · Content · 内容部
触发：文章 / 文案 / 文档 / 社交 / 邮件 / 脚本 / SEO / newsletter
`S01`博客文章 · `S02`营销文案 · `S03`技术文档 · `S04`社交媒体 · `S05`邮件序列
`S06`视频脚本 · `S07`SEO优化 · `S08`标题测试 · `S09`案例研究 · `S10`订阅通讯

#### O06 · Marketing · 营销部
触发：营销 / 渠道 / 活动 / 增长 / 广告 / 发布 / 裂变 / 留存
`S01`渠道筛选 · `S02`活动策划 · `S03`落地页优化 · `S04`增长实验 · `S05`裂变设计
`S06`广告创意 · `S07`漏斗分析 · `S08`留存策略 · `S09`合作开发 · `S10`产品发布

#### O07 · Operations · 运营部
触发：SOP / 流程 / 工具 / 自动化 / 客服 / 日程 / 供应商
`S01`SOP撰写 · `S02`工具选型 · `S03`自动化设计 · `S04`工作流梳理 · `S05`供应商管理
`S06`客服流程 · `S07`用户引导 · `S08`日程规划 · `S09`会议协调 · `S10`故障响应

#### O08 · Data · 数据部
触发：数据 / 指标 / SQL / 分析 / 报告 / 埋点 / 看板
`S01`指标定义 · `S02`仪表盘设计 · `S03`SQL查询 · `S04`队列分析 · `S05`报告撰写
`S06`数据清洗 · `S07`数据可视化 · `S08`异常检测 · `S09`预测建模 · `S10`埋点设计

#### O09 · Finance · 财务部
触发：定价 / 收入 / 财务 / 现金流 / 合同 / 融资 / CAC / LTV
`S01`定价策略 · `S02`收入预测 · `S03`支出追踪 · `S04`发票生成 · `S05`税务规划
`S06`单位经济学 · `S07`现金流 · `S08`融资材料 · `S09`财务模型 · `S10`合同审查

#### O10 · Meta · 元认知
触发：复盘 / 学习 / 习惯 / 审计 / 决策 / 精力 / 系统迭代
`S01`周复盘 · `S02`技能差距 · `S03`学习计划 · `S04`系统审计 · `S05`习惯设计
`S06`知识沉淀 · `S07`精力管理 · `S08`决策日志 · `S09`失败分析 · `S10`愿景迭代

---

## OPC-X 扩展点（仅此两处）

OPC-X 设计为对外只暴露两个扩展点，其余结构不要随意修改：

```
扩展点                              用途                        操作方式
──────────────────────────────      ────────────────────────    ──────────────────
orchestrators/O0X-*/skills/         往部门挂原子技能              新建 S{NN}-{name}.md
outputs/templates/O0X-{dept}.md     控制部门输出格式              编辑对应模板文件
```

**两个扩展点严格 1:1 对应，共 10 对：**

```
orchestrators/O01-strategy/    ←→   outputs/templates/O01-strategy.md
orchestrators/O02-research/    ←→   outputs/templates/O02-research.md
orchestrators/O03-product/     ←→   outputs/templates/O03-product.md
orchestrators/O04-engineering/ ←→   outputs/templates/O04-engineering.md
orchestrators/O05-content/     ←→   outputs/templates/O05-content.md
orchestrators/O06-marketing/   ←→   outputs/templates/O06-marketing.md
orchestrators/O07-operations/  ←→   outputs/templates/O07-operations.md
orchestrators/O08-data/        ←→   outputs/templates/O08-data.md
orchestrators/O09-finance/     ←→   outputs/templates/O09-finance.md
orchestrators/O10-meta/        ←→   outputs/templates/O10-meta.md
```

规则：`orchestrators/O0X-{name}/orchestrator.md` 定义「**执行什么**」，`outputs/templates/O0X-{name}.md` 定义「**输出什么格式**」。同一个 `O0X` 前缀，永远绑定在一起。

**扩展点1 — 技能挂载**

在对应部门的 `skills/` 目录新建文件即可。命名：`S{NN}-{kebab-name}.md`。
子公司专项技能挂在 `.opc/orchestrators/O0X-*/skills/`，通用技能回流到此处。

**扩展点2 — 输出模板**

每个部门在 `outputs/templates/O0X-{dept}.md` 有默认输出格式。
子公司可在 `.opc/outputs/templates/` 下同名文件覆盖集团默认模板。
覆盖时只改对应 `O0X` 的文件，不要新增或跳号 — 模板数量永远是 10 个。

---

## 子公司接入协议

**一条命令完成全套初始化：**

```bash
cd your-project
curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.sh | bash
```

生成结构（镜像集团）：
```
your-project/
├── CLAUDE.md                          ← @AGENT.md + @.opc/context.md
├── .claude/commands/{project}.md      ← /{project} slash command
└── .opc/
    ├── context.md                     ← 填：领域知识
    ├── project-state.md               ← 填：Vision + 螺旋状态
    └── orchestrators/                 ← 镜像集团10部门
        └── O0X-*/
            ├── orchestrator.md        ← 专项上下文（继承+覆盖）
            └── skills/                ← 专项原子技能
```

**后续维护：**
- 新增专项技能 → `.opc/orchestrators/O0X-*/skills/` 新建文件
- 覆盖输出模板 → `.opc/outputs/templates/O0X-{dept}.md`
- 技能回流 → `/{project} 回流检查` → 确认 → 迁移到集团 `orchestrators/O0X-*/skills/`

---

---

## GitHub Issue 协议（部门任务队列）

每个部门在项目 GitHub repo 拥有同名标签，Issues = 该部门的持久化任务队列。

### 标准 Label（10 个，init.sh 自动创建）

| Label | 颜色 | 部门 | Cursor接单 |
|---|---|---|---|
| `O01-strategy` | `#0052CC` | 战略 | ❌ |
| `O02-research` | `#5319E7` | 调研 | ❌ |
| `O03-product` | `#006B75` | 产品 | ❌ |
| `O04-engineering` | `#E4E669` | 工程 | ✅ |
| `O05-content` | `#EE9900` | 内容 | ⚠️ 文档类可派 |
| `O06-marketing` | `#E99695` | 营销 | ❌ |
| `O07-operations` | `#BFD4F2` | 运营 | ❌ |
| `O08-data` | `#D93F0B` | 数据 | ⚠️ SQL类可派 |
| `O09-finance` | `#0E8A16` | 财务 | ❌ |
| `O10-meta` | `#CCCCCC` | 元认知 | ❌ |

### 核心规则

**读：永远自动**（orchestrator 激活时执行，无副作用）
```bash
gh issue list --label {O0X-name} --state open
```

**写：仅当有明确 action item**（不在每次激活时自动创建 issue）
```bash
gh issue create --label {O0X-name} [--label child-issue|master-issue] \
  --title "[O0X] {描述}" --body "{内容}"
```

**安全阀**：人是唯一触发源，orchestrator 不自我触发，不跨部门自动创建 issue。

### 双标签策略（归属 + 级别同时打）

```
[child-issue][O04-engineering]   代码任务
[master-issue][O01-strategy]     战略编排主任务
[research-issue][O02-research]   调研任务
[solo][O06-marketing]            独立营销任务
```

### Issue 生命周期

```
O0X 产生 action item
  → gh issue create (open)
  → /cursor 派发（O04/O05/O08 可代码化任务）
  → Cursor 执行 + gh issue close
  → O0X 下次激活读 closed issues → 更新 strategy-board.md 信号灯
```

---

## strategy-board.md（战略作战室）

每个子公司 `.opc/strategy-board.md`：上帝视角的跨部门综合仪表盘。

**包含**：北极星 / 螺旋位置 / 各部门信号灯 / 跨部门阻断关系 / 决策待办 / 决策历史

**维护规则**：
- O10 每轮复盘后更新信号灯 + 追加决策记录
- 任意 orchestrator 产出重大决策时写入决策历史
- `/talkflow`（或对应专项命令）激活时自动读取

**模板位置**：`opc-x/outputs/templates/strategy-board.md`

---

*OPC-X v2.4 · 两扩展点 + Issue队列 + 战略作战室 · 集团能力通用 · 子公司状态独立 · 终身复用。*