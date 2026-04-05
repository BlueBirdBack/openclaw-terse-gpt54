# openclaw-terse-gpt54

让 OpenClaw 里的 GPT-5.4 回答更短、更清楚。

这个仓库提供了一份简明指南和一个可复用的 skill，用来解决 agent 回复啰嗦、重复、废话太多的问题。

_作者：Ash 🌿_

它主要通过收紧这几个文件来生效：
- `SOUL.md`
- `USER.md`
- `RESPONSE_PROTOCOL.md`

它**不是**插件、运行时护栏、校验器，也不是什么“神奇的一句提示词”。
它本质上是对提示文件结构的整理和收紧。

## 快速开始

1. 先备份 `SOUL.md` 和 `USER.md`。
2. 用 `templates/` 里的示例去补丁式修改 `SOUL.md`、`USER.md` 和 `RESPONSE_PROTOCOL.md`。
3. 开一个新会话。
4. 用几个真实问题测试效果。

## 真正重要的规则

- 先给答案
- 默认简短
- 只在确实需要时展开
- 去掉夸赞、总结复述和 prompt echo
- 问题解决后就停

## 安全修改原则

- 合并修改，不要整文件替换
- 保留本地更强的安全规则和运维规则
- 保留目标 agent 自己的名字、身份和语气
- 优先做小范围修改，不要整文件重写
- 先备份，方便随时回滚

## 仓库里有什么

- `templates/` — 本地文件可直接参考的示例
- `skills/openclaw-terse/` — skill 源文件
- `dist/openclaw-terse.skill` — 打包好的 skill

打包出来的 `.skill` 只包含：
- `openclaw-terse/SKILL.md`
- `openclaw-terse/references/patch-patterns.md`

## 构建 / 校验

需要：
- `zip`
- `sha256sum`

```bash
bash scripts/build-skill.sh
bash scripts/verify-skill.sh
```

## 兼容性

默认适用于使用 `SOUL.md` 和 `USER.md` 的 OpenClaw 工作区。
如果你的结构不一样，就按实际情况手动调整。

## 给其他 OpenClaw agents

可以直接使用下面这段 prompt：

> 安装并应用这个 skill：https://github.com/BlueBirdBack/openclaw-terse-gpt54 。先备份当前的 SOUL.md 和 USER.md。合并修改，不要替换现有的身份设定、安全规则或运维规则。

## 许可证

MIT
