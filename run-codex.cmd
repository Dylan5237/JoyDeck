@echo off
setlocal
cd /d "%~dp0"

echo.
echo === JoyDeck Lite - local Codex dispatch (Issue #1) ===
echo.

if not exist "AGENTS.md" (
  echo [ERROR] Missing AGENTS.md. Please update the repository.
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

rem Protect existing changes before branch operations.
git diff --quiet
if errorlevel 1 (
  echo [ERROR] Uncommitted tracked changes detected. Please resolve them first.
  pause
  exit /b 1
)
git diff --cached --quiet
if errorlevel 1 (
  echo [ERROR] Staged changes detected. Please resolve them first.
  pause
  exit /b 1
)

for /f "delims=" %%B in ('git branch --show-current') do set "CURRENT_BRANCH=%%B"
if /I not "%CURRENT_BRANCH%"=="main" if /I not "%CURRENT_BRANCH%"=="feat/1-joycon-mouse" (
  echo [ERROR] Unexpected branch: %CURRENT_BRANCH%.
  echo Run the launcher on main or feat/1-joycon-mouse only.
  pause
  exit /b 1
)
if /I "%CURRENT_BRANCH%"=="main" (
  git switch -c feat/1-joycon-mouse >nul 2>&1
  if errorlevel 1 (
    git switch feat/1-joycon-mouse >nul 2>&1
    if errorlevel 1 (
      echo [ERROR] Cannot switch to feat/1-joycon-mouse. Nothing was overwritten.
      pause
      exit /b 1
    )
  )
)

set "TASK=Read AGENTS.md and docs/tasks/issue-1.md, then IMPLEMENT GitHub Issue #1 in this repository. Execute all available Windows diagnostics and tests yourself; minimize human steps. Do not claim physical hardware tests without a Joy-Con, do not install drivers or bypass hooks, and never push directly to main. End with real test evidence and only the required physical step for the user."
echo [INFO] Ready. Local work will remain on feat/1-joycon-mouse.
echo [INFO] Codex will attempt safe automatic approvals when its version supports them.
echo.

codex exec --help 2>nul | findstr /C:"--approve-for-me" >nul
if errorlevel 1 (
  codex exec --sandbox workspace-write "%TASK%"
) else (
  codex exec --approve-for-me "%TASK%"
)
set "CODEX_EXIT=%ERRORLEVEL%"

echo.
echo === Codex exit code: %CODEX_EXIT% ===
git status --short
echo.
if not "%CODEX_EXIT%"=="0" (
  echo [WARN] Codex exited with an error. Review the output; no files were automatically discarded.
)
echo Changes have NOT been merged into main.
pause
exit /b %CODEX_EXIT%
