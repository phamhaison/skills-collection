# ============================================================================
# AUTO SETUP - Phiên bản đơn giản (Copy & Paste)
# ============================================================================
# Cách sử dụng:
#   1. Mở PowerShell với quyền Admin
#   2. Copy TOÀN BỘ nội dung bên dưới
#   3. Paste vào PowerShell và nhấn Enter
# ============================================================================

# Bắt đầu setup
$ErrorActionPreference = "Continue"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  AUTO SETUP - AI Skills & Tools" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# PHẦN 1: Cài prerequisites
Write-Host "`n[PHẦN 1] Cài prerequisites..." -ForegroundColor Yellow

# Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "  Đang cài Git..." -ForegroundColor Gray
    winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# Node.js
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "  Đang cài Node.js..." -ForegroundColor Gray
    winget install --id OpenJS.NodeJS.LTS -e --accept-package-agreements --accept-source-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# Python
if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    Write-Host "  Đang cài Python..." -ForegroundColor Gray
    winget install --id Python.Python.3.12 -e --accept-package-agreements --accept-source-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# npm packages
Write-Host "  Đang cài npm packages..." -ForegroundColor Gray
npm install -g @anthropic-ai/claude-code @openai/codex typescript ts-node

Write-Host "  [OK] Prerequisites" -ForegroundColor Green

# PHẦN 2: Clone repos
Write-Host "`n[PHẦN 2] Clone repos..." -ForegroundColor Yellow

$BASE_DIR = "C:\Users\$env:USERNAME\Documents"
if (-not (Test-Path $BASE_DIR)) { New-Item -ItemType Directory -Path $BASE_DIR -Force | Out-Null }

# skills-collection
Write-Host "  Clone skills-collection..." -ForegroundColor Gray
git clone --depth 1 https://github.com/phamhaison/skills-collection.git "$BASE_DIR\skills-collection" 2>&1 | Out-Null

# obsidian-mind
Write-Host "  Clone obsidian-mind..." -ForegroundColor Gray
git clone --depth 1 https://github.com/phamhaison/obsidian-mind.git "$BASE_DIR\obsidian-mind" 2>&1 | Out-Null

# cli-anything-setup
Write-Host "  Clone cli-anything-setup..." -ForegroundColor Gray
git clone --depth 1 https://github.com/phamhaison/cli-anything-setup.git "$BASE_DIR\cli-anything-setup" 2>&1 | Out-Null

Write-Host "  [OK] Repos" -ForegroundColor Green

# PHẦN 3: Cài skills
Write-Host "`n[PHẦN 3] Cài skills..." -ForegroundColor Yellow

$SKILLS_DIR = "$env:USERPROFILE\.config\opencode\skills"
if (-not (Test-Path $SKILLS_DIR)) { New-Item -ItemType Directory -Path $SKILLS_DIR -Force | Out-Null }

$skillCount = 0
Get-ChildItem -Path "$BASE_DIR\skills-collection\*\*\SKILL.md" -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
    $skillName = $_.Directory.Name
    $destDir = "$SKILLS_DIR\$skillName"
    if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
    Copy-Item $_.FullName "$destDir\SKILL.md" -Force
    $skillCount++
}

Write-Host "  [OK] Đã cài $skillCount skills" -ForegroundColor Green

# PHẦN 4: Cấu hình OpenCode
Write-Host "`n[PHẦN 4] Cấu hình OpenCode..." -ForegroundColor Yellow

$opencodeDir = "$env:USERPROFILE\.config\opencode"
if (-not (Test-Path $opencodeDir)) { New-Item -ItemType Directory -Path $opencodeDir -Force | Out-Null }

# opencode.json
$opencodeJson = @"
{
  "provider": {
    "default": "anthropic",
    "providers": {
      "anthropic": { "apiKey": "`${ANTHROPIC_API_KEY}" },
      "openai": { "apiKey": "`${OPENAI_API_KEY}" }
    }
  },
  "mcp": {
    "github": {
      "type": "local", "enabled": true,
      "command": "npx", "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "`${GITHUB_PERSONAL_ACCESS_TOKEN}" }
    },
    "playwright": {
      "type": "local", "enabled": true,
      "command": "npx", "args": ["-y", "@playwright/mcp@latest"]
    },
    "context7": {
      "type": "local", "enabled": true,
      "command": "npx", "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
"@
$opencodeJson | Out-File -FilePath "$opencodeDir\opencode.json" -Encoding utf8 -NoNewline

# .mcp.json
$mcpJson = @"
{
  "mcpServers": {
    "github": { "command": "npx", "args": ["-y", "@modelcontextprotocol/server-github"] },
    "playwright": { "command": "npx", "args": ["-y", "@playwright/mcp@latest"] },
    "context7": { "command": "npx", "args": ["-y", "@upstash/context7-mcp@latest"] }
  }
}
"@
$mcpJson | Out-File -FilePath "$opencodeDir\.mcp.json" -Encoding utf8 -NoNewline

Write-Host "  [OK] OpenCode config" -ForegroundColor Green

# PHẦN 5: Hoàn thành
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  SETUP HOÀN THÀNH!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nThiết lập API Keys:" -ForegroundColor Yellow
Write-Host '  [Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "sk-ant-xxx", "User")' -ForegroundColor White
Write-Host '  [Environment]::SetEnvironmentVariable("OPENAI_API_KEY", "sk-xxx", "User")' -ForegroundColor White
Write-Host '  [Environment]::SetEnvironmentVariable("GITHUB_PERSONAL_ACCESS_TOKEN", "ghp_xxx", "User")' -ForegroundColor White
Write-Host "`nThư mục:" -ForegroundColor Yellow
Write-Host "  - Skills: $SKILLS_DIR" -ForegroundColor White
Write-Host "  - Config: $opencodeDir" -ForegroundColor White
Write-Host "  - Repos: $BASE_DIR" -ForegroundColor White
