# O04 · Engineering — 工程开发

> 负责架构设计、代码质量、调试诊断与工程效率。

## 10 原子技能

| # | 技能 ID | 名称 | 输入 | 输出 |
|---|---------|------|------|------|
| 1 | S01-code-review | 代码评审 | PR diff / 代码片段 | 问题清单 + 建议 |
| 2 | S02-architecture-design | 架构设计 | 需求描述 | 架构图 + 决策文档 |
| 3 | S03-debug-diagnosis | 调试诊断 | 错误信息 + 上下文 | 根因 + 修复方案 |
| 4 | S04-refactor-plan | 重构规划 | 现有代码 + 目标 | 重构路径 + 风险评估 |
| 5 | S05-api-design | API 设计 | 功能需求 | RESTful/GraphQL spec |
| 6 | S06-test-strategy | 测试策略 | 功能描述 | 测试用例 + 覆盖矩阵 |
| 7 | S07-performance-audit | 性能审计 | 性能数据 + 代码 | 瓶颈定位 + 优化建议 |
| 8 | S08-security-review | 安全审查 | 代码 / 架构 | 漏洞报告 + 修复优先级 |
| 9 | S09-devops-setup | DevOps 配置 | 项目类型 + 目标 | CI/CD 配置文件 |
| 10 | S10-tech-debt-tracking | 技术债管理 | 代码库状态 | 技术债清单 + 还债计划 |

## 调用示例

```
触发词: "审查这段代码"
Orchestrator 路由: S01-code-review → S08-security-review
输出: 问题清单 + 安全风险报告
```

## 上下游

- **输入来源**: O03-product (PRD) / 用户直接触发
- **输出去向**: O07-operations (部署流程) / O08-data (埋点需求)
- **共享 context**: `shared/contexts/tech-context.md`
