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

### 飞书机器人权限配置

使用本 Skill 需要配置以下飞书开放平台权限：

#### 批量导入权限

1. 登录 [飞书开放平台](https://open.feishu.cn/app)
2. 选择你的应用 → **权限管理** → **批量导入**
3. 粘贴以下内容导入所有必需权限：

```json
{
  "scopes": {
    "tenant": [
      "aily:message:read",
      "aily:message:write",
      "application:application.app_message_stats.overview:readonly",
      "bitable:app",
      "contact:user.base:readonly",
      "docs:permission.member",
      "docs:permission.member:auth",
      "docs:permission.member:create",
      "docs:permission.member:delete",
      "docs:permission.member:readonly",
      "docs:permission.member:retrieve",
      "docs:permission.member:transfer",
      "docs:permission.member:update",
      "docs:permission.setting",
      "docs:permission.setting:read",
      "docs:permission.setting:readonly",
      "docs:permission.setting:write_only",
      "docx:document",
      "docx:document.block:convert",
      "docx:document:create",
      "docx:document:readonly",
      "docx:document:write_only",
      "drive:drive",
      "drive:drive:readonly",
      "im:app_feed_card:write",
      "im:chat:readonly",
      "im:message",
      "im:message.group_at_msg:readonly",
      "im:message.group_msg",
      "im:message.p2p_msg:readonly",
      "im:message.reactions:read",
      "im:message:readonly",
      "im:message:recall",
      "im:message:send_as_bot",
      "im:message:update",
      "im:resource",
      "wiki:wiki",
      "wiki:wiki:readonly"
    ],
    "user": [
      "docx:document:readonly"
    ]
  }
}
```

#### 核心权限说明

| 权限 | 用途 |
|------|------|
| `docx:document` | 文档读写操作 |
| `docx:document:create` | 创建新文档 |
| `docx:document:write_only` | 写入文档内容 |
| `docs:permission.member` | 管理文档协作者 |
| `docs:permission.member:update` | 更新协作者权限 |
| `contact:user.base:readonly` | 读取用户信息 |
| `im:message:send_as_bot` | 以机器人身份发送消息 |

⚠️ **注意**: 部分权限需要管理员审核，请确保你的飞书组织已开启相应权限。

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
