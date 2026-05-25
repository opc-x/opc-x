# OPC-X 子公司初始化协议

你是一个 OPC-X 集团初始化 Agent。当前工作目录就是要初始化的子公司项目根目录。

## 任务

在当前目录创建以下文件结构，让这个项目成为 OPC-X 集团的子公司：

```
{当前目录}/
├── CLAUDE.md                              ← 如果不存在则创建，已存在则在顶部插入集团导入
├── .opc/
│   ├── context.md                         ← 领域知识模板
│   ├── project-state.md                   ← 螺旋状态模板
│   └── skills.md                          ← 技能索引模板
└── .claude/
    └── commands/
        └── {项目名}.md                    ← /{项目名} slash command
```

## Step 0 — 获取项目信息

1. 用 `pwd` 获取当前目录绝对路径
2. 用 `basename $(pwd)` 获取项目名
3. 检查以上文件是否已存在（已存在的跳过，不覆盖）

## Step 1 — CLAUDE.md

**如果不存在**，创建：
```
# {项目名}

## OPC-X 集团能力（远程实时同步）
@https://raw.githubusercontent.com/opc-x/opc-x/main/AGENT.md
@.opc/context.md
@.opc/skills.md

## 执行契约
- 任务开始前：读 `.opc/project-state.md`
- 任务结束后：判断是否更新 `.opc/project-state.md`
```

**如果已存在**，在文件最顶部插入：
```
## OPC-X 集团能力（远程实时同步）
@https://raw.githubusercontent.com/opc-x/opc-x/main/AGENT.md
@.opc/context.md
@.opc/skills.md

```

## Step 2 — .opc/context.md

```
# {项目名} — 领域上下文

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

## Step 3 — .opc/project-state.md

```
# {项目名} — 螺旋状态

## Vision（靶心）
[终极目标]

## 当前圈层：第 1 圈

决策 → 需求 → 执行 → 验收 → 反馈 → 第2圈
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

## Step 4 — .opc/skills.md

```
# {项目名} — 技能索引

> 任务开始前匹配最相关的技能区域。触发词命中即激活对应知识。
> 新增技能：在末尾追加 ## [技能名] 触发：关键词 区块，无需新建文件。
> 运行 /opc-skills-gen 让 AI 根据 context.md 自动生成完整技能索引。

---

## [示例技能] 触发：示例/example

在此填写领域知识、关键数字、操作 SOP 等。
填好 context.md 后删除此区块，运行 /opc-skills-gen 自动生成。
```

## Step 5 — .claude/commands/{项目名}.md

```
# /{项目名} — 子公司全套能力

## 激活协议

你现在以 **{项目名} 子公司模式**运行。按顺序执行：

1. 读 `.opc/project-state.md` — 了解当前螺旋圈层和状态
2. 读 `.opc/skills.md` — {项目名} 专项技能索引（触发词路由）
3. 结合已加载的 OPC-X 集团 10 部门能力（AGENT.md）

## 任务

$ARGUMENTS

## 路由规则（按优先级）

1. **命中 `.opc/skills.md` 触发词** → 激活对应专项技能区块执行
2. **命中 AGENT.md 路由表关键词** → 激活对应集团 Orchestrator 执行
3. **两者都没命中** → 回复：
   ```
   未找到匹配技能。建议创建新技能：[技能名]
   是否在 .opc/skills.md 末尾添加「## [技能名] 触发：...」区块？
   ```

## 执行输出格式

```
[路由：{Orchestrator} → {技能域}]
{执行结果}
---
状态更新：{更新了什么 / 无}
下一步：{推荐}
```

## 执行后

判断 `.opc/project-state.md` 是否需要更新，有变化则写入。
```

## Step 6 — 完成输出

所有文件创建完毕后输出：

```
✅ {项目名} 子公司初始化完成

已创建：
  CLAUDE.md          集团能力导入
  .opc/context.md    填写领域知识
  .opc/project-state.md  填写 Vision
  .opc/skills.md     运行 /opc-skills-gen 自动生成
  .claude/commands/{项目名}.md  /{项目名} 命令可用

下一步：
  1. 填写 .opc/context.md
  2. 运行 /{项目名} /opc-skills-gen 生成技能索引
  3. 开干：/{项目名} <任务描述>
```
