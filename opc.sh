#!/bin/bash
# OPC-X CLI — opc 命令入口
# 安装后通过 ~/.local/bin/opc 调用

set -e

OPC_X_DIR="$(cd "$(dirname "$0")" && pwd)"

_usage() {
  echo ""
  echo "🏢  OPC-X — One-Person Company eXoskeleton"
  echo ""
  echo "用法："
  echo "  opc init <项目名> [路径]    初始化新子公司（默认路径：当前目录）"
  echo "  opc update                  更新 OPC-X 到最新版"
  echo "  opc status                  显示已安装版本和路径"
  echo ""
  echo "示例："
  echo "  opc init talkflow"
  echo "  opc init talkflow ~/projects/talkflow"
  echo ""
}

case "${1:-}" in
  init)
    PROJECT_NAME="${2:-}"
    if [ -z "$PROJECT_NAME" ]; then
      echo "❌  缺少项目名"
      echo "    用法: opc init <项目名> [路径]"
      exit 1
    fi
    PROJECT_PATH="${3:-$(pwd)/$PROJECT_NAME}"
    PROJECT_PATH="$(mkdir -p "$PROJECT_PATH" && cd "$PROJECT_PATH" && pwd)"
    exec "$OPC_X_DIR/new-subsidiary.sh" "$PROJECT_NAME" "$PROJECT_PATH"
    ;;

  update)
    echo "🔄  更新 OPC-X..."
    git -C "$OPC_X_DIR" pull --ff-only
    echo "✅  已更新至最新版"
    ;;

  status)
    HASH=$(git -C "$OPC_X_DIR" rev-parse --short HEAD 2>/dev/null || echo "unknown")
    DATE=$(git -C "$OPC_X_DIR" log -1 --format="%ci" 2>/dev/null || echo "unknown")
    echo "📦  OPC-X"
    echo "    路径:   $OPC_X_DIR"
    echo "    版本:   $HASH"
    echo "    更新:   $DATE"
    ;;

  help|--help|-h|"")
    _usage
    ;;

  *)
    echo "❌  未知命令: $1"
    _usage
    exit 1
    ;;
esac
