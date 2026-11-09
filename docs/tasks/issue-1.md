# 本机 Codex 任务：Issue #1 / JoyDeck Lite v0.1

任务来源：https://github.com/Dylan5237/JoyDeck/issues/1
执行规则：先读仓库 `AGENTS.md`。**这是一项实际开发任务，不是只写实施方案。**

## 已知事实

- Windows PC（用户已安装 Codex，使用 Windows 电脑）。
- 任天堂 Switch 一代续航版（港版），原厂系统；右侧 Joy-Con 可拆卸，计划通过蓝牙连接电脑。
- 用户不购买新硬件、不改装主机；已有键盘鼠标可供回退。
- 仓库刚创建，尚无历史应用代码。现有 `README.md`、`AGENTS.md` 是任务底座。
- 不能直接访问真实 Joy-Con 时，**应开发/诊断到可自动完成的最大程度**，仅留下按 SYNC、选择配对、按键移动等物理步骤。

## 本次要真正交付的东西

1. **环境检测脚本**：检测 OS、蓝牙能力、右 Joy-Con 配对状态（只读、仅检查目标设备）、已存在的 JoyShockMapper 和必要命令，输出清晰状态，不扫描/上报其他软件清单。
2. **JoyShockMapper 安装/启动脚本**：选择当前官方维护仓库的 Windows release，能在用户目录或项目限定目录安装，不需要管理员权限，不静默添加驱动或系统服务；如官方下载环境不可用，明确提示并输出可信下载链接。避免覆盖用户已有 JoyShockMapper 配置。
3. **右手柄配置文件**：从官方 README 实际核对后，实现按住 ZR 才启用体感、松开停止、A 左键、B 右键；初始灵敏度可调整，校准可重复；不要默认常开陀螺仪。优先从 `GYRO_ON = ZR`、`E = LMOUSE`、`S = RMOUSE` 等已记录语法开始核查。确认 `RESET_MAPPINGS` 和 `RECONNECT_CONTROLLERS` 的调用方式。
4. **一键本地运行入口**：尽量只需执行一个 PowerShell 脚本即可按「诊断 → 确保依赖 → 启动 → 提示验证」顺序运行。不得以无人值守方式修改 Windows 蓝牙配对与安全配置；配对需人工物理操作时生成简短明确步骤。
5. **基础自动化验证**：PowerShell 语法检查、配置静态校验（可按真实命令集校验）及必要的模拟诊断。能做的实际执行，不能运行的标记原因；不要伪造手柄操作通过。
6. **本机报告**：一份简洁的 `v0.1` 验收结果，区分 `AUTO_PASS`、`MANUAL_PENDING`、`BLOCKED`，写出真实运行证据和最少用户操作。

## 实际验收（必须留给真实手柄）

- Windows 蓝牙列表存在 Joy-Con (R)，映射软件能收到事件。
- 握住 ZR + 轻微转动手腕：光标跟随；松开 ZR：立即停止。
- A：鼠标左键；B：右键。
- 陀螺仪静置校准后没有明显漂移；退出软件后常规鼠标可用。

## 限制

- 不做 Codex 语音、震动功能、GUI、自建 HID 驱动、驱动签名修改、后台自启动、管理员权限安装等扩展。
- 不改系统全局蓝牙/安全设置，不结束用户其它进程，不能静默卸载 Steam 等工具。
- **只在 feature 分支实现，不能直接改 main**。若当前已在 main，先确认工作区干净，再创建 `feat/1-joycon-mouse`（若已存在，安全复用）；不可强推。
- Git commit 格式 `type(scope): 中文标题`。能正常联网与获取 GitHub 权限时可推送分支并创建 Draft PR；如果无法联网，不把未推送当成已推送，直接报告本地工作区进展。
- 最终报告真实做了什么、执行了什么命令、验证结论与待手工步骤。**不要停在计划和反复审查。**

## 参考

- https://github.com/Electronicks/JoyShockMapper
- https://github.com/JibbSmart/JoyShockMapper/blob/master/README.md

开始执行。
