@echo off
setlocal
cd /d "%~dp0"

echo.
echo === JoyDeck Lite - local Codex dispatch (Issue #1) ===
echo.

if not exist "AGENTS.md" (
  echo [ERROR] Missing AGENTS.md. Please re-clone the repository.
  pause
  exit /b 1
)
if not exist "docs\tasks\issue-1.md" (
  echo [ERROR] Missing docs\tasks\issue-1.md.
  pause
  exit /b 1
)
where git >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Git was not found in PATH.
  pause
  exit /b 1
)
where codex >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Codex CLI was not found in PATH. Try "codex --version" in PowerShell.
  pause
  exit /b 1
)

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  echo [ERROR] This must be run inside a Git checkout.
  pause
  exit /b 1
)

rem Do not switch branches if there are uncommitted tracked changes.
git diff --quiet
if errorlevel 1 (
  echo [ERROR] Uncommitted changes detected. Commit or stash them before dispatch.
  pause
  exit /b 1
)
git diff --cached --quiet
if errorlevel 1 (
  echo [ERROR] Staged changes detected. Commit or stash them before dispatch.
  pause
  exit /b 1
)

rem Explicit feature branch: never develop directly on main.
git switch -c feat/1-joycon-mouse >nul 2>&1
if errorlevel 1 (
  git switch feat/1-joycon-mouse >nul 2>&1
  if errorlevel 1 (
    echo [ERROR] Failed to switch to feature branch feat/1-joycon-mouse.
    pause
    exit /b 1
  )
)

echo [INFO] Starting Codex in workspace-write sandbox.
echo [INFO] It will follow AGENTS.md and docs/tasks/issue-1.md.
echo [INFO] It must report hardware tests as MANUAL_PENDING until physically verified.
echo.

codex exec --sandbox workspace-write "Read AGENTS.md and docs/tasks/issue-1.md, then IMPLEMENT GitHub Issue #1 in this repository. Do the available Windows checks and code/tests yourself. Never claim real hardware verification without a connected Joy-Con. Do not bypass hooks, install drivers, or push to main. Finish with a compact report containing actual commands run, AUTO_PASS/MANUAL_PENDING/BLOCKED, and only the necessary physical step for the user."
set "CODEX_EXIT=%ERRORLEVEL%"

echo.
echo === Codex exit code: %CODEX_EXIT% ===
git status --short
echo.
if not "%CODEX_EXIT%"=="0" (
  echo [WARN] Codex exited with an error. Review the output; your files were not automatically discarded.
)
echo Changes have NOT been merged into main.
pause
exit /b %CODEX_EXIT%
