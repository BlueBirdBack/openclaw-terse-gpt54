# openclaw-direct-gpt54

[English](./README.md)

让 OpenClaw 里的 GPT-5.4 少说废话，回答更短、更清楚、更直接。

## 给 OpenClaw 用

直接发这段话：

> 从 https://github.com/BlueBirdBack/openclaw-direct-gpt54 安装并应用这个 skill 的最新版本。先备份我当前的 `SOUL.md` 和 `USER.md`。合并修改，不要覆盖我现有的身份设定、安全规则和运维规则。

这个 skill 主要会收紧这几个文件：
- `SOUL.md`
- `USER.md`
- `RESPONSE_PROTOCOL.md`

它改的是提示文件，不是插件，也不是运行时护栏。
如果用了以后，GPT-5.4 还是会冒出 `If you want, I can...` 这种话，那就还得另做运行时修复。

## 更新这个 skill

更新时，还是发同一段话：

> 从 https://github.com/BlueBirdBack/openclaw-direct-gpt54 安装并应用这个 skill 的最新版本。先备份我当前的 `SOUL.md` 和 `USER.md`。合并修改，不要覆盖我现有的身份设定、安全规则和运维规则。

## 关键规则

- 先给答案
- 默认简短
- 只在确实需要时展开
- 别夸人，别绕圈，别复述用户原话
- 主任务做完后，凡是顺手就该做、风险又很低的内部收尾，直接做完再汇报，不要再问
- 如果刚创建了一个明显该登记到索引或追踪清单里的文件或记录，先补登记，再回复
- 只有当后续动作有破坏性、会对外发送 / 公开，或确实拿不准时，才提问
- 事情做完就停

## 目标行为示例

坏：

> 已创建 `docs/project-x.md`。如果你愿意，我可以把它加到 `Projects.md`。

好：

> 已创建 `docs/project-x.md`，并已把它链接到 `Projects.md`。

## 安全修改原则

- 合并修改，不要替换
- 保留本地更强的安全规则和运维规则
- 保留目标 agent 自己的名字、身份和语气
- 先备份，方便回滚

## 许可证

MIT
