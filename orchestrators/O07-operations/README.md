# O07 · Operations — 运营流程

> 负责 SOP 建设、工具链管理、自动化设计与日常运营效率。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-sop-writing | SOP 撰写 | 流程描述 | 标准化操作文档 |
| 2 | S02-tool-selection | 工具选型 | 需求场景 | 工具对比 + 推荐 |
| 3 | S03-automation-design | 自动化设计 | 重复性流程 | 自动化方案 + 配置 |
| 4 | S04-workflow-mapping | 工作流梳理 | 业务流程描述 | 流程图 + 瓶颈识别 |
| 5 | S05-vendor-management | 供应商管理 | 供应商列表 + 需求 | 评估矩阵 + 谈判要点 |
| 6 | S06-customer-support | 客服流程设计 | 常见问题 + 产品 | FAQ + 响应模板 |
| 7 | S07-onboarding-design | 用户引导设计 | 产品功能 + 新用户痛点 | onboarding 流程 |
| 8 | S08-calendar-planning | 日程规划 | 目标 + 时间约束 | 周/月计划 |
| 9 | S09-meeting-facilitation | 会议协调 | 议题 + 参与者 | 议程 + 会议纪要模板 |
| 10 | S10-incident-response | 故障响应 | 故障描述 | 响应 playbook + 复盘模板 |

## 调用示例

```
触发词: "帮我梳理客服流程"
Orchestrator 路由: S04-workflow-mapping → S06-customer-support → S01-sop-writing
输出: 客服流程图 + FAQ + SOP文档
```

## 上下游

- **输入来源**: O03-product (发布节点) / O04-engineering (部署)
- **输出去向**: O05-content (FAQ文档) / O08-data (运营指标)
- **共享 context**: `shared/contexts/ops-context.md`
