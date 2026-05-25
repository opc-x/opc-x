#!/bin/bash
# OPC-X — 唯一入口
#
# 远程用（无需安装）:
#   curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.sh | bash -s -- <项目名> [路径]
#
# 本地用（安装 opc 命令后）:
#   opc <项目名> [路径]   # 初始化子公司
#   opc --install         # 安装 / 更新本地 opc 命令
#   opc update            # 更新 OPC-X 集团能力
#   opc status            # 查看版本

set -e

RAW_BASE="https://raw.githubusercontent.com/opc-x/opc-x/main"
OPC_X_DIR="$HOME/.opc-x"
BIN_DIR="$HOME/.local/bin"
REPO="https://github.com/opc-x/opc-x.git"

CMD="${1:-}"

# ─────────────────────────────────────────────────────────────
# 子命令：--install  安装本地 opc CLI
# ─────────────────────────────────────────────────────────────
if [ "$CMD" = "--install" ]; then
  echo ""
  echo "OPC-X — 安装本地 CLI"
  echo "─────────────────────────────────────────────"

  if [ -d "$OPC_X_DIR/.git" ]; then
    echo "更新 OPC-X..."
    git -C "$OPC_X_DIR" pull --quiet --ff-only
    echo "已更新 → $OPC_X_DIR"
  else
    echo "安装 OPC-X..."
    git clone --quiet "$REPO" "$OPC_X_DIR"
    echo "已安装 → $OPC_X_DIR"
  fi

  mkdir -p "$BIN_DIR"
  cat > "$BIN_DIR/opc" << 'WRAPEOF'
#!/bin/bash
exec "$HOME/.opc-x/init.sh" "$@"
WRAPEOF
  chmod +x "$BIN_DIR/opc"
  echo "命令已创建 → $BIN_DIR/opc"

  SHELL_RC=""
  [ -f "$HOME/.zshrc" ]  && SHELL_RC="$HOME/.zshrc"
  [ -f "$HOME/.bashrc" ] && [ -z "$SHELL_RC" ] && SHELL_RC="$HOME/.bashrc"

  PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'
  if [ -n "$SHELL_RC" ] && ! grep -qF "$HOME/.local/bin" "$SHELL_RC" 2>/dev/null; then
    echo "$PATH_LINE" >> "$SHELL_RC"
    echo "PATH 已写入 $SHELL_RC"
  fi
  export PATH="$BIN_DIR:$PATH"

  echo ""
  echo "安装完成！"
  echo ""
  echo "使用方式："
  echo "  opc <项目名>              # 初始化子公司"
  echo "  opc <项目名> <路径>       # 指定路径初始化"
  echo "  opc update                # 更新集团能力"
  echo ""
  echo "如果 opc 命令暂时不可用，运行: source $SHELL_RC"
  exit 0
fi

# ─────────────────────────────────────────────────────────────
# 子命令：update  更新本地安装
# ─────────────────────────────────────────────────────────────
if [ "$CMD" = "update" ]; then
  if [ ! -d "$OPC_X_DIR/.git" ]; then
    echo "OPC-X 未安装本地版，无法 update"
    echo "先运行: curl -fsSL $RAW_BASE/init.sh | bash -s -- --install"
    exit 1
  fi
  echo "更新 OPC-X..."
  git -C "$OPC_X_DIR" pull --ff-only
  echo "已更新至最新版"
  exit 0
fi

# ─────────────────────────────────────────────────────────────
# 子命令：status  查看版本
# ─────────────────────────────────────────────────────────────
if [ "$CMD" = "status" ]; then
  if [ -d "$OPC_X_DIR/.git" ]; then
    HASH=$(git -C "$OPC_X_DIR" rev-parse --short HEAD 2>/dev/null || echo "unknown")
    DATE=$(git -C "$OPC_X_DIR" log -1 --format="%ci" 2>/dev/null || echo "unknown")
    echo "OPC-X (本地)"
    echo "  路径: $OPC_X_DIR"
    echo "  版本: $HASH"
    echo "  更新: $DATE"
  else
    echo "OPC-X (远程，未安装本地版)"
    echo "  集团能力: $RAW_BASE/AGENT.md"
  fi
  exit 0
fi

# ─────────────────────────────────────────────────────────────
# 默认：初始化子公司
# ─────────────────────────────────────────────────────────────
PROJECT_NAME="$CMD"

if [ -z "$PROJECT_NAME" ]; then
  printf "项目名: "
  read -r PROJECT_NAME
fi
[ -z "$PROJECT_NAME" ] && echo "需要项目名" && exit 1

PROJECT_PATH="${2:-}"
[ -z "$PROJECT_PATH" ] && PROJECT_PATH="$(pwd)/$PROJECT_NAME"

echo ""
echo "初始化子公司: $PROJECT_NAME"
echo "路径: $PROJECT_PATH"
echo "集团: $RAW_BASE/AGENT.md"
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
if [ ! -f "$PROJECT_PATH/.opc/context.md" ]; then
cat > "$PROJECT_PATH/.opc/context.md" << CTXEOF
# $PROJECT_NAME — 领域上下文

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
CTXEOF
  echo "✅  .opc/context.md"
fi

# ── .opc/project-state.md ──────────────────────────────────
if [ ! -f "$PROJECT_PATH/.opc/project-state.md" ]; then
cat > "$PROJECT_PATH/.opc/project-state.md" << STATEEOF
# Project State — $PROJECT_NAME

## Vision（靶心）
[终极目标]

## 当前轮次
第 1 轮 · 决策阶段

## 本轮核心目标
[这一轮要解决的最重要的一件事]

## 已完成
- [ ] 无

## 待决策
[下一个需要决策的问题]

---
最后更新：$(date +%Y-%m-%d)
STATEEOF
  echo "✅  .opc/project-state.md"
fi

echo ""
echo "────────────────────────────────────────────────────"
echo "完成！"
echo ""
echo "接下来："
echo "  1. 填写 .opc/context.md（领域知识）"
echo "  2. 用 Claude Code 打开 $PROJECT_PATH"
echo "     → 集团能力自动加载，开干"
echo ""
