#!/bin/bash
# OPC-X 子公司脚手架（本地版）— 内部调用 init.sh
# 推荐直接用: curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.sh | bash -s -- <项目名> [路径]

set -e

OPC_X_DIR="$(cd "$(dirname "$0")" && pwd)"
exec "$OPC_X_DIR/init.sh" "$@"
