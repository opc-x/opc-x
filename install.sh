#!/bin/bash
# OPC-X 一键安装脚本
# 用法: curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/install.sh | bash

set -e

OPC_X_DIR="$HOME/.opc-x"
BIN_DIR="$HOME/.local/bin"
REPO="https://github.com/opc-x/opc-x.git"

echo ""
echo "🏢  OPC-X — One-Person Company eXoskeleton"
echo "────────────────────────────────────────────"

# 1. 安装或更新 OPC-X 到标准位置
if [ -d "$OPC_X_DIR/.git" ]; then
  echo "🔄  更新 OPC-X..."
  git -C "$OPC_X_DIR" pull --quiet --ff-only
  echo "✅  已更新 → $OPC_X_DIR"
else
  echo "📦  安装 OPC-X..."
  git clone --quiet "$REPO" "$OPC_X_DIR"
  echo "✅  已安装 → $OPC_X_DIR"
fi

# 2. 创建 opc 命令
mkdir -p "$BIN_DIR"
cat > "$BIN_DIR/opc" << 'OPCEOF'
#!/bin/bash
exec "$HOME/.opc-x/opc.sh" "$@"
OPCEOF
chmod +x "$BIN_DIR/opc"
echo "✅  命令已创建 → $BIN_DIR/opc"

# 3. 注入 PATH（幂等）
SHELL_RC=""
if [ -f "$HOME/.zshrc" ]; then
  SHELL_RC="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
  SHELL_RC="$HOME/.bashrc"
fi

PATH_LINE='export PATH="$HOME/.local/bin:$PATH"'
if [ -n "$SHELL_RC" ] && ! grep -qF "$HOME/.local/bin" "$SHELL_RC"; then
  echo "$PATH_LINE" >> "$SHELL_RC"
  echo "✅  PATH 已写入 $SHELL_RC"
fi

# 使当前 shell 立即可用
export PATH="$BIN_DIR:$PATH"

echo ""
echo "────────────────────────────────────────────"
echo "🎉  安装完成！"
echo ""
echo "📋  快速开始："
echo "    opc init <项目名>              # 在当前目录初始化子公司"
echo "    opc init <项目名> <路径>       # 指定路径初始化"
echo "    opc update                    # 更新 OPC-X 到最新版"
echo ""
echo "💡  如果 opc 命令暂时不可用，运行："
echo "    source $SHELL_RC"
echo "    或重开终端窗口"
echo ""
