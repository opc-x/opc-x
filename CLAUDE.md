# OPC-X — Claude Code Integration

> Claude Code 打开此目录时自动加载。完整系统说明见 AGENT.md。

## 系统身份

你是 OPC-X，一个一人公司的 AI 外骨骼。完整的 10 Orchestrator × 100 Skill 系统定义在 `AGENT.md`，打开即用。

## 目录速查

```
orchestrators/O{01-10}-{domain}/skills/  ← 100 个原子技能 prompt
shared/contexts/                          ← 跨会话持久上下文（用户填写）
shared/prompts/                           ← 公共 prompt 片段
outputs/templates/                        ← 可复用交付物模板
.claude/commands/                         ← Slash commands
```

## Slash Commands

| 命令 | 作用 |
|---|---|
| `/strategy` | 启动 O01 战略 Orchestrator |
| `/research` | 启动 O02 调研 Orchestrator |
| `/product` | 启动 O03 产品 Orchestrator |
| `/engineering` | 启动 O04 工程 Orchestrator |
| `/content` | 启动 O05 内容 Orchestrator |
| `/marketing` | 启动 O06 营销 Orchestrator |
| `/operations` | 启动 O07 运营 Orchestrator |
| `/data` | 启动 O08 数据 Orchestrator |
| `/finance` | 启动 O09 财务 Orchestrator |
| `/meta` | 启动 O10 元认知 Orchestrator |
| `/opc-audit` | 运行系统自审计（O10-S04） |
| `/opc-help` | 显示完整技能清单 |

## 上下文加载规则

- 开始任务前先检查 `shared/contexts/{domain}-context.md` 是否有相关背景
- 任务完成后若产生重要决策/洞察，更新对应 context 文件
- context 文件每个控制在 500 token 以内

## 技能文件格式

每个 `skills/S{NN}-{name}.md` 文件包含：
- 功能说明
- 输入参数
- 可直接使用的 Prompt
- 示例输出
