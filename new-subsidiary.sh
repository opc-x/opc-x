#!/bin/bash
# OPC-X 子公司脚手架
# 用法: ./new-subsidiary.sh <项目名> <项目绝对路径>
# 例如: ./new-subsidiary.sh talkflow /Users/cuijianchen/gh-projects/talkflow

set -e

PROJECT_NAME=$1
PROJECT_PATH=$2
OPC_X_PATH=$(cd "$(dirname "$0")" && pwd)

if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_PATH" ]; then
  echo "用法: ./new-subsidiary.sh <项目名> <项目绝对路径>"
  exit 1
fi

echo "🏗️  正在生成子公司: $PROJECT_NAME"
echo "📁  路径: $PROJECT_PATH"
echo "🏢  集团: $OPC_X_PATH"
echo ""

mkdir -p "$PROJECT_PATH/.opc/skills"

# project-state.md
sed "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" \
  "$OPC_X_PATH/outputs/templates/project-state-template.md" \
  > "$PROJECT_PATH/.opc/project-state.md"

# context.md（领域知识，用户填写）
cat > "$PROJECT_PATH/.opc/context.md" << CONTEXT
# $PROJECT_NAME — 领域上下文

> 由子公司维护的领域知识，集团 Orchestrator 执行前读取。

## 产品描述
[这个产品是什么，解决什么问题]

## 目标用户
[核心用户画像]

## 技术栈
[主要技术选型]

## 商业模式
[收入模式，定价区间]

## 当前阶段
[产品处于哪个阶段：MVP / PMF验证 / 增长 / 规模化]

## 关键指标
[最重要的3个业务指标及当前值]

## 竞争格局
[主要竞品，差异化定位]

## 特殊约束
[该项目特有的限制或背景]
CONTEXT

# CLAUDE.md（如果不存在则创建，存在则追加）
if [ ! -f "$PROJECT_PATH/CLAUDE.md" ]; then
  sed -e "s|{{PROJECT_NAME}}|$PROJECT_NAME|g" \
      -e "s|{{OPC_X_PATH}}|$OPC_X_PATH|g" \
      "$OPC_X_PATH/outputs/templates/subsidiary-claude-template.md" \
      > "$PROJECT_PATH/CLAUDE.md"
  echo "✅  已创建 CLAUDE.md"
else
  echo ""
  echo "⚠️   CLAUDE.md 已存在，请手动添加以下内容："
  echo "---"
  echo "## OPC-X 集团能力"
  echo "@$OPC_X_PATH/AGENT.md"
  echo "@.opc/context.md"
  echo "---"
fi

echo ""
echo "✅  子公司结构生成完成！"
echo ""
echo "📋  接下来："
echo "  1. 填写 $PROJECT_PATH/.opc/context.md（项目领域知识）"
echo "  2. 填写 $PROJECT_PATH/.opc/project-state.md 的 Vision"
echo "  3. 按需在 $PROJECT_PATH/.opc/skills/ 添加项目专项技能"
echo "  4. 用 Claude Code 打开 $PROJECT_PATH，集团能力立即可用"
