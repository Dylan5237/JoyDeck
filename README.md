# JoyDeck

用现有的 Nintendo Switch 一代右 Joy-Con（Joy-Con R）在 Windows 上实现零新增硬件成本的体感鼠标，随后逐步接入 Codex 原生听写和震动事件反馈。

**当前阶段：v0.1 / 体感鼠标验证**。未进行 Windows 实机与 Joy-Con 实物验收，不宣称功能已验证成功。

## 原则

- 不改装 Switch、不购买新硬件；Windows PC 已有蓝牙和 Codex。
- 优先复用成熟开源项目 [JoyShockMapper](https://github.com/Electronicks/JoyShockMapper)；不从零开发蓝牙/HID 驱动。
- 第一版只做：蓝牙检测与连接指引、右手柄体感鼠标（按住 ZR 才移动）、A/B 左右键、退出与校准。
- Codex 听写和震动事件属于后续阶段；无实测依据前不混入 v0.1。
- 代码只在本仓库工作目录或用户指定工具目录操作；未经明确同意不改系统安全配置、不安装内核驱动、不获取管理员权限。
- 自动化、诊断和测试尽可能交给用户本机 Codex，用户仅负责按 Joy-Con SYNC 键和最终实际握持验收。

## 启动本机 Codex

在 Windows PowerShell（已安装 Git 和 Codex CLI）中执行：

```powershell
git clone https://github.com/Dylan5237/JoyDeck.git
cd JoyDeck
.\run-codex.cmd
```

上述命令启动本机 Codex 读取 `docs/tasks/issue-1.md`，自动开发和验证 v0.1 所需脚本。**GitHub Issue 不会自行唤醒用户电脑上的 Codex**，必须在本机执行一次启动命令。已经克隆仓库的情况下，无需重复克隆。

## 路线

1. **v0.1**：Joy-Con R 体感鼠标与 Windows 环境诊断；真实硬件验证。
2. **v0.2（待 v0.1 验收）**：适配当前 Codex 客户端的原生听写快捷键；不重新实现 ASR。
3. **v0.3（待可行性验证）**：Codex 事件通知与 Joy-Con 震动；先测试 HID 访问互斥与事件可靠性。

## 任务与验收

GitHub Issues 是任务事实源，`docs/tasks/` 存放本机 Codex 可直接读取的执行说明。开发约束见 [AGENTS.md](AGENTS.md)。

**环境测试 ≠ 硬件验收**：脚本生成、文档完成和单元测试通过不等于 Joy-Con 实际控制鼠标成功。由本机 Codex 输出明确的已验证 / 未验证 / 阻断项。
