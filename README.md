# 📄 Feishu Doc Manager | 飞书文档管理器

> **English**: Seamlessly publish Markdown content to Feishu Docs with automatic formatting. Solves key pain points: Markdown table conversion, permission management, batch writing.
>
> **中文**：将 Markdown 内容无缝发布到飞书文档，自动渲染格式。解决核心痛点：Markdown 表格转换、权限管理、批量写入。

[![OpenClaw](https://img.shields.io/badge/OpenClaw-Skill-blue)](https://openclaw.ai)
[![Feishu](https://img.shields.io/badge/Feishu-Integration-green)](https://open.feishu.cn)
[![License](https://img.shields.io/badge/License-MIT-yellow)](LICENSE)

---

## 🎯 Problems Solved | 解决的痛点

Based on real-world publishing experience | 基于实际发布经验：

| Pain Point | Solution | 痛点 | 解决方案 |
|------------|----------|------|----------|
| ❌ **Markdown tables don't render** | ✅ Auto-convert to formatted lists | Markdown 表格无法渲染 | 自动转换为格式化列表 |
| ❌ **Permission management is complex** | ✅ One-click collaborator management | 权限管理复杂 | 一键协作者管理 |
| ❌ **Long content causes 400 errors** | ✅ Auto-split and batch write | 长内容导致 400 错误 | 自动分段批量写入 |
| ❌ **Formatting inconsistencies** | ✅ `write`/`append` auto-render Markdown | 格式不一致 | write/append 自动渲染 |
| ❌ **Block updates lose formatting** | ✅ Clear API distinction | 块级更新丢失格式 | 清晰的 API 区分 |

---

## ✨ Features | 功能特性

### 📝 Smart Markdown Publishing | 智能 Markdown 发布
- **Automatic rendering** when using `write` or `append` actions
- **Table workaround**: Tables auto-convert to formatted lists
- **Full syntax support**: Headers, lists, bold, italic, code, quotes

**自动渲染**使用 `write` 或 `append` 操作时
**表格解决方案**：表格自动转换为格式化列表
**完整语法支持**：标题、列表、粗体、斜体、代码、引用

### 🔐 Permission Management | 权限管理
- Add/remove collaborators with one command
- Update permission levels (view/edit/full_access)
- List all current permissions
- Transfer document ownership

一键添加/删除协作者
更新权限级别（查看/编辑/完全访问）
列出现有权限
转移文档所有权

### 📄 Document Operations | 文档操作
- Create documents with specified folders
- Write full Markdown content
- Append to existing documents
- Update/delete specific blocks
- List document structure

在指定文件夹创建文档
写入完整 Markdown 内容
追加到现有文档
更新/删除指定块
列出文档结构

---

## 🚀 Quick Start | 快速开始

### Installation | 安装

```bash
cd ~/.openclaw/workspace/skills
git clone https://github.com/Shuai-DaiDai/feishu-doc-manager.git
```

### Configuration | 配置

1. Go to [Feishu Open Platform](https://open.feishu.cn/app) | 访问[飞书开放平台](https://open.feishu.cn/app)
2. Select your app → **Development Config** → **Permission Management** | 选择应用 → **开发配置** → **权限管理**
3. Import required permissions | 导入必需权限

### Required Permissions | 必需权限

```json
{
  "scopes": {
    "tenant": [
      "docx:document",
      "docx:document:create", 
      "docx:document:write_only",
      "docs:permission.member",
      "contact:user.base:readonly"
    ]
  }
}
```

---

## 📖 Usage Examples | 使用示例

### 1. Create Document | 创建文档

```json
{
  "action": "create",
  "title": "Q1 Report | Q1 报告",
  "folder_token": "optional_folder_token"
}
```

### 2. Write Markdown Content | 写入 Markdown 内容

**⚠️ Critical | 关键**：Use `write` for Markdown rendering, NOT `update_block`

```json
{
  "action": "write",
  "doc_token": "UWpxdSnmXo6mPdxwOyCcWTPUndD",
  "content": "# Project Overview | 项目概览\n\n## Key Metrics | 关键指标\n\n- **Revenue | 收入**: $100K\n- **Users | 用户**: 10K\n- **Growth | 增长**: 25%\n\n> This project exceeded expectations | 该项目超出预期"
}
```

### 3. Add Collaborator | 添加协作者

```bash
curl -X POST "https://open.feishu.cn/open-apis/drive/v1/permissions/{doc_token}/members?type=docx" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{
    "member_type": "openid",
    "member_id": "ou_xxx",
    "perm": "edit"
  }'
```

---

## 📋 Markdown Support | Markdown 支持

### ✅ Supported | 支持

| Markdown | Result | Markdown | 效果 |
|----------|--------|----------|------|
| `# Title` | Heading 1 | `# 标题` | 标题1 |
| `## Title` | Heading 2 | `## 标题` | 标题2 |
| `- Item` | Bullet list | `- 项目` | 无序列表 |
| `**bold**` | **Bold** | `**粗体**` | **粗体** |
| `> quote` | Blockquote | `> 引用` | 引用块 |

### ❌ Not Supported | 不支持

- **Tables**: Auto-converted to lists | 表格：自动转换为列表
- **Images**: Use separate API | 图片：使用单独 API
- **Complex HTML**: Use Markdown | 复杂 HTML：使用 Markdown

---

## 🔧 Key Insight | 核心发现

### `write`/`append` vs `update_block`

| Feature | `write`/`append` | `update_block` |
|---------|------------------|----------------|
| Markdown Rendering | ✅ **Yes** | ❌ No (plain text) |
| Use Case | Initial content, appending | Quick text patches |
| 功能 | 初始内容、追加 | 快速文本修补 |
| Markdown 渲染 | ✅ **支持** | ❌ 不支持（纯文本） |

**💡 Best Practice**: Always use `write` or `append` for Markdown content to get full formatting.
**💡 最佳实践**：Markdown 内容始终使用 `write` 或 `append` 以获得完整格式。

---

## 🐛 Troubleshooting | 故障排除

### Problem: 400 Bad Request | 400 错误
**Cause**: Content too long | 原因：内容过长  
**Solution**: Split into smaller chunks | 解决：分段写入

### Problem: Markdown not rendering | Markdown 不渲染
**Cause**: Used `update_block` instead of `write` | 原因：使用了 `update_block`  
**Solution**: Use `write` or `append` | 解决：使用 `write` 或 `append`

### Problem: Permission denied | 权限错误
**Cause**: Missing `docs:permission.member` | 原因：缺少权限  
**Solution**: Add in Feishu console | 解决：在飞书控制台添加

---

## 📄 Document Structure | 文档结构

```
feishu-doc-manager/
├── SKILL.md          # Skill definition | 技能定义
├── README.md         # Documentation | 文档
├── LICENSE           # MIT License | MIT 许可证
├── install.sh        # Setup script | 安装脚本
└── docs/             # Additional docs | 补充文档
    └── images/       # Screenshots | 截图
```

---

## 🤝 Contributing | 贡献

Issues and PRs welcome! | 欢迎提交 Issue 和 PR！

## 📜 License | 许可证

MIT © Shuai-DaiDai
