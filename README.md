# Feishu Doc Manager

飞书文档综合管理工具 - 支持创建、写入、更新、权限管理。

## 功能特性

- 📄 **创建文档** - 新建飞书文档，支持指定文件夹
- 📝 **写入内容** - 支持 Markdown，自动渲染为结构化文档
- ➕ **追加内容** - 在文档末尾添加内容
- 🔄 **更新块** - 修改指定块的内容
- 🔐 **权限管理** - 添加/删除协作者，修改权限级别

## 快速开始

### 安装

将此 skill 复制到你的 OpenClaw workspace:

```bash
cd ~/.openclaw/workspace/skills
git clone https://github.com/<your-username>/feishu-doc-manager.git
```

### 配置

确保你的 OpenClaw 已配置飞书渠道：

```json
{
  "channels": {
    "feishu": {
      "enabled": true,
      "appId": "cli_xxx",
      "appSecret": "xxx"
    }
  }
}
```

## 使用方法

### 创建文档

```json
{
  "action": "create",
  "title": "我的文档",
  "folder_token": "可选"
}
```

### 写入 Markdown 内容

```json
{
  "action": "write",
  "doc_token": "UWpxdSnmXo6mPdxwOyCcWTPUndD",
  "content": "# 标题\n\n## 二级标题\n\n- **粗体**\n- 列表项"
}
```

### 权限管理

```bash
# 添加协作者
curl -X POST "https://open.feishu.cn/open-apis/drive/v1/permissions/{token}/members?type=docx" \
  -H "Authorization: Bearer {token}" \
  -d '{"member_type": "openid", "member_id": "ou_xxx", "perm": "edit"}'
```

## Markdown 支持

| Markdown | 效果 |
|----------|------|
| `# 标题` | 标题1 |
| `## 标题` | 标题2 |
| `- 列表` | 无序列表 |
| `**粗体**` | 粗体 |
| `> 引用` | 引用块 |

⚠️ **注意**: `write`/`append` 支持 Markdown 渲染，`update_block` 仅支持纯文本。

## 详细文档

查看 [SKILL.md](SKILL.md) 获取完整使用指南。

## 许可证

MIT
