# AGENTS.md — JoyDeck

## 目标与边界

- 当前任务仅为 **Windows 11 + Nintendo Switch 一代右 Joy-Con (R) 的零成本体感鼠标 MVP**。优先复用 JoyShockMapper；不要先造驱动、Web UI、托盘应用、语音模块或震动中间层。
- GitHub Issue 是需求和状态的事实源；本机可执行任务说明在 `docs/tasks/`。只实现当前 Issue，后续功能另行推进。
- 仅在本仓库、新建的用户目录工具文件夹内写入。不得修改其他代码仓库、用户 Codex 配置、浏览器数据、系统安全策略；禁止绕过 hook、强推、向 main 推功能实现。
- 如果需要下载依赖，优先官方 GitHub release，校验来源/版本；不添加不必要的二进制到 Git 仓库，不运行未知安装器。
- 已有配置先检测、备份和避免覆盖；不要求管理员权限，不安装内核驱动。确需提升权限或运行不受信任文件时停止并说明原因。

## 实施要求

1. 先检查现实环境和上游文档，再实现最小闭环。不要根据旧版本或记忆猜测 JoyShockMapper 语法，重点验证 Joy-Con R 单只使用、`GYRO_ON = ZR`、方向键名称映射。
2. 脚本重复执行不损坏环境；输出可读的诊断及回退指引。发现 Steam Input 等手柄映射冲突时先检测和提示，不擅自结束用户进程。
3. 自动验证必须与真实实机测试明确分开。没连接 Joy-Con，就输出 `MANUAL_PENDING`，不声称鼠标可用。
4. 代码提交使用 `type(scope): 中文标题`，scope 沿用模块名称。功能变更写特性分支和 PR，不能直接改 main；不要绕过已有 hook。
5. 运行完成须汇报：做了什么、实际执行了哪些检测/测试、结果证据、仍需用户完成的最少动作、相关提交或 PR 链接。不能执行的环节明确标注 `BLOCKED`。

## 对本机 Codex 的执行优先级

**你自己完成所有能自动化的工作；只有必须触碰硬件的步骤才交给用户。** 优先检查能否自动安装与运行 JoyShockMapper；若需用户参与蓝牙配对，只要求长按 SYNC 并确认一次。不要重复向用户询问仓库地址、项目目标和所用操作系统。

## 参考

- [JoyShockMapper 官方维护仓库](https://github.com/Electronicks/JoyShockMapper)
- [JoyShockMapper 详细配置文档](https://github.com/JibbSmart/JoyShockMapper/blob/master/README.md)
- [Issue #1：v0.1 体感鼠标](https://github.com/Dylan5237/JoyDeck/issues/1)
