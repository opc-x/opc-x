#!/bin/bash
# OPC-X 子公司初始化 — 无需本地安装，curl 直接跑
#
# 用法:
#   curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.sh | bash -s -- <项目名> [路径]
#
# 示例:
#   curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.sh | bash -s -- talkflow
#   curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.sh | bash -s -- talkflow ~/projects/talkflow

set -e

RAW_BASE="https://raw.githubusercontent.com/opc-x/opc-x/main"

PROJECT_NAME="${1:-}"
PROJECT_PATH="${2:-}"

if [ -z "$PROJECT_NAME" ]; then
  printf "📦  项目名: "
  read -r PROJECT_NAME
fi
[ -z "$PROJECT_NAME" ] && echo "❌  需要项目名" && exit 1

[ -z "$PROJECT_PATH" ] && PROJECT_PATH="$(pwd)/$PROJECT_NAME"

echo ""
echo "🏗️   初始化子公司: $PROJECT_NAME"
echo "📁   路径: $PROJECT_PATH"
echo "🏢   集团: $RAW_BASE/AGENT.md"
echo ""

mkdir -p "$PROJECT_PATH/.opc/skills"

# ── CLAUDE.md ──────────────────────────────────────────────
if [ ! -f "$PROJECT_PATH/CLAUDE.md" ]; then
cat > "$PROJECT_PATH/CLAUDE.md" << CLAUDEEOF
# $PROJECT_NAME

## OPC-X 集团能力（远程实时同步）
@https://raw.githubusercontent.com/opc-x/opc-x/main/AGENT.md
@.opc/context.md

## 执行契约
- 任务开始前：读 \`.opc/project-state.md\`
- 任务结束后：判断是否更新 \`.opc/project-state.md\`
CLAUDEEOF
  echo "✅  CLAUDE.md"
else
  echo "⚠️   CLAUDE.md 已存在，跳过（手动在顶部添加 @${RAW_BASE}/AGENT.md）"
fi

# ── .opc/context.md ────────────────────────────────────────
cat > "$PROJECT_PATH/.opc/context.md" << CTXEOF
# $PROJECT_NAME — 领域上下文

> 集团 Orchestrator 执行任何技能前读取此文件。

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

## 关键指标
[最重要的3个业务指标及当前值]

## 竞争格局
[主要竞品，差异化定位]

## 特殊约束
[该项目特有的限制或背景]
CTXEOF
echo "✅  .opc/context.md"

# ── .opc/project-state.md ──────────────────────────────────
cat > "$PROJECT_PATH/.opc/project-state.md" << STATEEOF
# Project State — $PROJECT_NAME

> 螺旋的记忆。每轮任务前读它，结束后更新它。

---

## Vision（靶心）
[这个项目/产品的终极目标]

## 当前轮次
第 1 轮

## 当前阶段
\`\`\`
决策 → 需求 → 执行 → 验收 → 反馈
 ↑
[当前在这里]
\`\`\`

## 本轮核心目标
[这一轮要解决的最重要的一件事]

## 本轮已完成
- [ ] 无

## 本轮产出物
| 产出 | 文件位置 | 状态 |
|------|----------|------|
| -    | -        | -    |

## 待决策项
[下一个需要做决策的问题]

## 关键约束
[当前最重要的资源/时间/能力限制]

## 跨域上下文摘要
[最近几轮的关键信息]

---
最后更新：[日期 · 由哪个 Orchestrator 更新]
STATEEOF
echo "✅  .opc/project-state.md"

echo ""
echo "────────────────────────────────────────────────────"
echo "🎉  完成！"
echo ""
echo "📋  接下来："
echo "  1. 填写 $PROJECT_PATH/.opc/context.md"
echo "  2. 填写 Vision（.opc/project-state.md 第一行）"
echo "  3. 用 Claude Code 打开 $PROJECT_PATH"
echo "     → 集团能力自动加载，无需任何额外配置"
echo ""
