# OPC-X — One-Person Company eXoskeleton

> 把这个文件或整个目录丢给任意 AI → 集团能力立即激活。

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

---

## 用例图（你怎么用这套系统）

```mermaid
graph TB
    U(["👤 你"])

    subgraph ONCE["一次性操作"]
        UC1["新建专项\n./new-subsidiary.sh"]
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

## 反哺协议（专项 → 元项目，闭环）

```mermaid
graph LR
    META["🏢 元项目\nOPC-X"]
    SUB["📦 专项\n.opc/"]
    O10["O10 Meta\n审计 + 提炼"]

    META -->|"赋能：通用技能"| SUB
    SUB -->|"执行中发现改进"| O10
    O10 -->|"提炼通用模式 → 回流"| META
    O10 -->|"专项特有 → 留在 .opc/"| SUB
```

**回流类型判断**：

| 改进类型 | 判断标准 | 动作 |
|---|---|---|
| 通用模式 | 其他专项也能用 | 更新 `opc-x/orchestrators/` 对应技能 |
| 专项特有 | 只有这个领域用 | 留在 `.opc/skills/`，不回流 |

**触发路径**：专项执行 → `/opc-audit` 识别候选 → **你确认** → 更新元项目技能文件

**规则**：元项目只接受通用化的改进，不接受项目特有逻辑。最终由人拍板。

---

## 架构总览

```mermaid
graph TB
    subgraph GROUP["🏢 OPC-X 集团"]
        AGENT["📜 AGENT.md — 集团宪法"]
        subgraph ORCS["10 Orchestrators · 100 Skills"]
            direction LR
            O01["O01\nStrategy"] --- O02["O02\nResearch"] --- O03["O03\nProduct"] --- O04["O04\nEngineering"] --- O05["O05\nContent"]
            O06["O06\nMarketing"] --- O07["O07\nOperations"] --- O08["O08\nData"] --- O09["O09\nFinance"] --- O10["O10\nMeta 🔄"]
        end
        SHARED["shared/contexts/ — 集团知识库"]
        STATE["project-state.md — 运行时状态（各子公司独立）"]
    end

    subgraph SUB_A["📦 子公司 TalkFlow"]
        TF[".opc/ 专项技能包\nproject-state.md"]
    end
    subgraph SUB_B["📦 子公司 N"]
        SN[".opc/ 专项技能包\nproject-state.md"]
    end
    subgraph SUB_NEW["📦 子公司 ..."]
        direction LR
        SCRIPT["new-subsidiary.sh\n一键生成"]
    end

    TF -->|"@AGENT.md 引入集团能力"| GROUP
    SN -->|"@AGENT.md 引入集团能力"| GROUP
    SCRIPT -->|"从集团 clone"| GROUP
    O10 -->|"Loop Controller"| O01
```

---

## 螺旋执行协议

<img src="docs/spiral.svg" alt="OPC-X 螺旋执行协议" width="500"/>

> 三环同构：决策(O01)→需求(O03)→执行(O04-07)→验收(O08)→反馈(O10)，每圈 +1 层，螺旋上升至靶心。

---

## 单次任务执行契约

```mermaid
flowchart LR
    IN([用户输入]) --> R[读\nproject-state.md]
    R --> ROUTE{路由\n意图匹配}
    ROUTE --> ORC[执行\nOrchestrator+Skill]
    ORC --> OUT[输出\n交付物]
    OUT --> UPD{更新\n状态?}
    UPD -->|是| W[写\nproject-state.md]
    UPD -->|否| END([完成])
    W --> END
```

输出格式：
```
[O{NN}·{域} → S{NN}·{技能名}]
{交付物}
---
状态更新：{更新了什么 / 无}
💡 下一步：{推荐关联技能}
```

---

## 微观层（agent-loop，所有 agent 内置，无需定义）

```
perceive → think → act → observe → loop
OPC-X 螺旋运行在它之上，不干涉它。
```

---

## 路由表

### O01 · Strategy
触发：目标 / OKR / 战略 / 规划 / 转型 / 竞争 / 商业模式 / 市场
`S01`目标设定 · `S02`优先级矩阵 · `S03`市场规模 · `S04`商业模式 · `S05`转型决策
`S06`风险评估 · `S07`资源分配 · `S08`OKR设计 · `S09`竞争定位 · `S10`扩张退出

### O02 · Research
触发：调研 / 竞品 / 用户洞察 / 趋势 / 问卷 / 数据来源
`S01`竞品分析 · `S02`用户访谈 · `S03`趋势扫描 · `S04`文献综述 · `S05`问卷设计
`S06`数据来源 · `S07`洞察合成 · `S08`用户画像 · `S09`JTBD分析 · `S10`行业标杆

### O03 · Product
触发：PRD / 需求 / 功能 / 路线图 / MVP / 用户故事 / 验收
`S01`PRD撰写 · `S02`功能范围 · `S03`路线图 · `S04`用户故事 · `S05`线框图规格
`S06`验收标准 · `S07`AB测试 · `S08`MVP定义 · `S09`Changelog · `S10`反馈分类

### O04 · Engineering
触发：代码 / 架构 / bug / 重构 / API / 安全 / 性能 / CI/CD
`S01`代码评审 · `S02`架构设计 · `S03`调试诊断 · `S04`重构规划 · `S05`API设计
`S06`测试策略 · `S07`性能审计 · `S08`安全审查 · `S09`DevOps配置 · `S10`技术债

### O05 · Content
触发：文章 / 文案 / 文档 / 社交 / 邮件 / 脚本 / SEO / newsletter
`S01`博客文章 · `S02`营销文案 · `S03`技术文档 · `S04`社交媒体 · `S05`邮件序列
`S06`视频脚本 · `S07`SEO优化 · `S08`标题测试 · `S09`案例研究 · `S10`订阅通讯

### O06 · Marketing
触发：营销 / 渠道 / 活动 / 增长 / 广告 / 发布 / 裂变 / 留存
`S01`渠道筛选 · `S02`活动策划 · `S03`落地页优化 · `S04`增长实验 · `S05`裂变设计
`S06`广告创意 · `S07`漏斗分析 · `S08`留存策略 · `S09`合作开发 · `S10`产品发布

### O07 · Operations
触发：SOP / 流程 / 工具 / 自动化 / 客服 / 日程 / 供应商
`S01`SOP撰写 · `S02`工具选型 · `S03`自动化设计 · `S04`工作流梳理 · `S05`供应商管理
`S06`客服流程 · `S07`用户引导 · `S08`日程规划 · `S09`会议协调 · `S10`故障响应

### O08 · Data
触发：数据 / 指标 / SQL / 分析 / 报告 / 埋点 / 看板
`S01`指标定义 · `S02`仪表盘设计 · `S03`SQL查询 · `S04`队列分析 · `S05`报告撰写
`S06`数据清洗 · `S07`数据可视化 · `S08`异常检测 · `S09`预测建模 · `S10`埋点设计

### O09 · Finance
触发：定价 / 收入 / 财务 / 现金流 / 合同 / 融资 / CAC / LTV
`S01`定价策略 · `S02`收入预测 · `S03`支出追踪 · `S04`发票生成 · `S05`税务规划
`S06`单位经济学 · `S07`现金流 · `S08`融资材料 · `S09`财务模型 · `S10`合同审查

### O10 · Meta — Loop Controller
触发：复盘 / 学习 / 习惯 / 审计 / 决策 / 精力 / 系统迭代
`S01`周复盘 · `S02`技能差距 · `S03`学习计划 · `S04`系统审计 · `S05`习惯设计
`S06`知识沉淀 · `S07`精力管理 · `S08`决策日志 · `S09`失败分析 · `S10`愿景迭代

---

## 子公司接入协议

新项目运行：`./new-subsidiary.sh <项目名> <项目路径>`

生成结构：
```
project/
├── CLAUDE.md          ← @OPC-X/AGENT.md + @.opc/context.md
├── .opc/
│   ├── context.md     ← 该项目的领域知识
│   ├── project-state.md  ← 该项目的螺旋状态
│   └── skills/        ← 项目专项技能（覆盖/扩展集团技能）
```

---

*OPC-X v2.0 · 集团能力通用，子公司状态独立，终身复用。*
