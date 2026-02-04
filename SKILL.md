---
name: feishu-doc-manager
description: |
  飞书文档综合管理工具 - 支持创建、写入、更新、权限管理。
  使用 Markdown 格式写入时会自动渲染为飞书结构化文档。
  支持添加协作者、修改权限、转移所有权。
  Use when: 创建飞书文档、写入 Markdown 内容、管理文档权限、添加协作者
homepage: https://github.com/openclaw/skills/feishu-doc-manager
metadata: {
  "clawdbot": {
    "emoji": "📄",
    "requires": {
      "channels": ["feishu"]
    }
  }
}
---

# 飞书文档管理器

综合管理飞书文档（docx）的创建、内容写入和权限控制。

## 核心功能

| 功能 | 说明 |
|------|------|
| **创建文档** | 新建飞书文档，支持指定文件夹 |
| **写入内容** | 支持 Markdown，自动渲染为结构化文档 |
| **追加内容** | 在文档末尾添加内容 |
| **更新块** | 修改指定块的内容 |
| **权限管理** | 添加/删除协作者，修改权限级别 |

## 使用方法

### 1. 创建文档

```json
{
  "action": "create",
  "title": "文档标题",
  "folder_token": "可选：文件夹token"
}
```

### 2. 写入 Markdown 内容

**关键要点：** 使用 `write` 动作，Markdown 会被**自动渲染**

```json
{
  "action": "write",
  "doc_token": "UWpxdSnmXo6mPdxwOyCcWTPUndD",
  "content": "# 标题\n\n## 二级标题\n\n- **粗体列表项**\n- 普通列表项\n\n> 引用块内容"
}
```

**支持的 Markdown 语法：**

| Markdown | 飞书效果 |
|----------|----------|
| `# 标题` | 标题1 |
| `## 标题` | 标题2 |
| `### 标题` | 标题3 |
| `- 列表` | 无序列表 |
| `1. 列表` | 有序列表 |
| `**粗体**` | 粗体 |
| `*斜体*` | 斜体 |
| `` `代码` `` | 行内代码 |
| `> 引用` | 引用块 |
| `---` | 分隔线 |

**⚠️ 不支持的语法：**
- 表格（会被跳过）
- 图片（需单独处理）

### 3. 追加内容

```json
{
  "action": "append",
  "doc_token": "UWpxdSnmXo6mPdxwOyCcWTPUndD",
  "content": "追加的 Markdown 内容"
}
```

### 4. 更新指定块

**⚠️ 注意：** `update_block` 只支持纯文本，**不支持 Markdown 渲染**

```json
{
  "action": "update_block",
  "doc_token": "UWpxdSnmXo6mPdxwOyCcWTPUndD",
  "block_id": "doxcnXXX",
  "content": "纯文本内容"
}
```

### 5. 删除块

```json
{
  "action": "delete_block",
  "doc_token": "UWpxdSnmXo6mPdxwOyCcWTPUndD",
  "block_id": "doxcnXXX"
}
```

### 6. 查看文档块列表

```json
{
  "action": "list_blocks",
  "doc_token": "UWpxdSnmXo6mPdxwOyCcWTPUndD"
}
```

## 权限管理

### 添加协作者

```bash
curl -X POST "https://open.feishu.cn/open-apis/drive/v1/permissions/{doc_token}/members?type=docx&need_notification=false" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{
    "member_type": "openid",
    "member_id": "ou_xxx",
    "perm": "edit"
  }'
```

**权限级别：**
- `view` - 可查看
- `edit` - 可编辑
- `full_access` - 完全访问（可管理权限）

### 更新协作者权限

```bash
curl -X PUT "https://open.feishu.cn/open-apis/drive/v1/permissions/{doc_token}/members/{member_id}?type=docx" \
  -H "Authorization: Bearer {token}" \
  -H "Content-Type: application/json" \
  -d '{
    "member_type": "openid",
    "perm": "full_access"
  }'
```

### 删除协作者

```bash
curl -X DELETE "https://open.feishu.cn/open-apis/drive/v1/permissions/{doc_token}/members?type=docx&member_type=openid&member_id=ou_xxx" \
  -H "Authorization: Bearer {token}"
```

### 列出现有协作者

```bash
curl "https://open.feishu.cn/open-apis/drive/v1/permissions/{doc_token}/members?type=docx" \
  -H "Authorization: Bearer {token}"
```

## Token 获取

### 获取 tenant_access_token

```bash
curl -X POST "https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal" \
  -H "Content-Type: application/json" \
  -d '{
    "app_id": "cli_xxx",
    "app_secret": "xxx"
  }'
```

### 从 URL 提取 doc_token

```
https://xxx.feishu.cn/docx/ABC123def
                        └─ doc_token ─┘
```

## 常见错误

| 错误 | 原因 | 解决 |
|------|------|------|
| Markdown 不渲染 | 使用了 `update_block` | 改用 `write` 或 `append` |
| 400 Bad Request | 内容过长 | 分段写入 |
| 404 Not Found | API 路径错误 | 检查 URL 格式 |
| 权限错误 | 未开通权限 | 申请 `docs:permission.member` |

## 最佳实践

1. **写入 Markdown 用 `write`/`append`** - 自动渲染格式
2. **修改纯文本用 `update_block`** - 快速更新指定块
3. **长内容分段写入** - 避免 400 错误
4. **表格用列表代替** - 原生表格不支持

## 依赖

- 飞书应用已配置
- 权限：`docx:document`, `docs:permission.member`
