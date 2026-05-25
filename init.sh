#!/bin/bash
# OPC-X 子公司初始化
# 用法: curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.sh | bash
set -e
claude -p "$(curl -fsSL https://raw.githubusercontent.com/opc-x/opc-x/main/init.md)"
