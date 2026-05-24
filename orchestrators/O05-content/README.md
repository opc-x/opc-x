# O05 · Content — 内容创作

> 负责博客、文案、文档、社交媒体及邮件内容的创作与优化。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-blog-writing | 博客文章撰写 | 主题 + 受众 | 完整博客文章 |
| 2 | S02-copywriting | 营销文案 | 产品 + 场景 | 转化导向文案 |
| 3 | S03-doc-writing | 技术文档 | 功能描述 + 受众 | 结构化文档 |
| 4 | S04-social-post | 社交媒体内容 | 主题 + 平台 | 平台适配内容 |
| 5 | S05-email-sequence | 邮件序列 | 目标 + 用户阶段 | 邮件序列脚本 |
| 6 | S06-video-script | 视频脚本 | 主题 + 时长 | 分镜脚本 |
| 7 | S07-seo-optimization | SEO 优化 | 内容草稿 + 关键词 | 优化后内容 + meta |
| 8 | S08-headline-testing | 标题测试 | 内容主题 | 5-10 个标题变体 |
| 9 | S09-case-study | 案例研究 | 客户故事原始信息 | 结构化案例文档 |
| 10 | S10-newsletter | 订阅通讯 | 本期主题 + 更新 | newsletter 成稿 |

## 调用示例

```
触发词: "写一篇关于AI工具的博客"
Orchestrator 路由: S08-headline-testing → S01-blog-writing → S07-seo-optimization
输出: SEO优化后的完整文章 + 备选标题
```

## 上下游

- **输入来源**: O06-marketing (内容计划) / 用户直接触发
- **输出去向**: O06-marketing (分发) / outputs/templates
- **共享 context**: `shared/contexts/brand-context.md`
