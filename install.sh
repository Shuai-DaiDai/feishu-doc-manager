#!/bin/bash
#
# Feishu Doc Manager - 一键安装脚本
# Usage: curl -sSL https://raw.githubusercontent.com/Shuai-DaiDai/feishu-doc-manager/main/install.sh | bash
#

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的信息
info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

# 检测 OpenClaw Workspace 路径
detect_workspace() {
    if [ -n "$OPENCLAW_WORKSPACE" ]; then
        echo "$OPENCLAW_WORKSPACE"
    elif [ -d "$HOME/.openclaw/workspace" ]; then
        echo "$HOME/.openclaw/workspace"
    elif [ -d "/root/.openclaw/workspace" ]; then
        echo "/root/.openclaw/workspace"
    else
        echo ""
    fi
}

# 主安装流程
main() {
    echo ""
    echo "📄 Feishu Doc Manager - OpenClaw Skill"
    echo "========================================"
    echo ""

    # 检测 workspace
    WORKSPACE=$(detect_workspace)
    
    if [ -z "$WORKSPACE" ]; then
        error "未找到 OpenClaw Workspace"
        echo ""
        echo "请手动指定路径:"
        echo "  export OPENCLAW_WORKSPACE=/path/to/workspace"
        echo ""
        exit 1
    fi

    info "检测到 Workspace: $WORKSPACE"
    
    # 创建 skills 目录
    SKILL_DIR="$WORKSPACE/skills"
    mkdir -p "$SKILL_DIR"
    
    # 检查是否已存在
    if [ -d "$SKILL_DIR/feishu-doc-manager" ]; then
        warning "Skill 已存在，执行更新..."
        cd "$SKILL_DIR/feishu-doc-manager"
        git pull origin main
        success "Skill 已更新到最新版本"
    else
        info "正在下载 feishu-doc-manager..."
        cd "$SKILL_DIR"
        git clone https://github.com/Shuai-DaiDai/feishu-doc-manager.git
        success "Skill 安装完成"
    fi
    
    echo ""
    echo "📋 安装信息:"
    echo "  位置: $SKILL_DIR/feishu-doc-manager"
    echo "  文档: $SKILL_DIR/feishu-doc-manager/README.md"
    echo ""
    echo "🚀 使用方法:"
    echo "  1. 重启 OpenClaw 或刷新 skills"
    echo "  2. 使用 feishu_doc 工具管理飞书文档"
    echo ""
    success "安装成功！"
    echo ""
}

# 执行主函数
main
