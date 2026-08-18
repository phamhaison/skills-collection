# Hướng dẫn Auto Setup trên máy mới

## Cách sử dụng

### Cách 1: Copy & Paste (Đơn giản nhất)

1. Mở **PowerShell** với quyền **Admin**
2. Copy toàn bộ nội dung file `QUICK-SETUP.ps1`
3. Paste vào PowerShell và nhấn Enter
4. Chờ quá trình cài đặt hoàn thành

### Cách 2: Chạy script (Chi tiết hơn)

1. Mở PowerShell với quyền Admin
2. Chạy lệnh sau:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
& "C:\path\to\AUTO-SETUP.ps1"
```

### Cách 3: Tải từ GitHub và chạy

```powershell
# Tải script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/phamhaison/cli-anything-setup/main/setup/AUTO-SETUP.ps1" -OutFile "AUTO-SETUP.ps1"

# Chạy script
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
.\AUTO-SETUP.ps1
```

## Sau khi setup xong

### 1. Thiết lập API Keys

```powershell
# Anthropic API Key (cho Claude)
[Environment]::SetEnvironmentVariable("ANTHROPIC_API_KEY", "sk-ant-xxx", "User")

# OpenAI API Key (cho Codex)
[Environment]::SetEnvironmentVariable("OPENAI_API_KEY", "sk-xxx", "User")

# GitHub Token
[Environment]::SetEnvironmentVariable("GITHUB_PERSONAL_ACCESS_TOKEN", "ghp_xxx", "User")
```

### 2. Kiểm tra hệ thống

```powershell
# Chạy script kiểm tra
& "C:\Users\$env:USERNAME\Documents\scripts\check-system.ps1"
```

### 3. Bắt đầu sử dụng

```powershell
# Mở OpenCode
opencode

# Hoặc chạy trong thư mục dự án
cd C:\Users\$env:USERNAME\Documents\skills-collection
opencode
```

## Danh sách Skills đã cài đặt

### SKILLS (6)
- learn-claude-code
- karpathy-skills
- superpowers
- ponytail
- gstack
- ECC

### UI/UX (6)
- taste-skill
- anthropics-skills
- wshobson-agents
- claude-plugin
- ui-ux-pro-max
- awesome-claude-skills

### MEMORY (5)
- planning-with-files
- claude-mem
- codegraph
- graphify
- repomix

### TOOLS (8)
- multica
- firecrawl
- cc-switch
- vibe-kanban
- github-mcp
- playwright-mcp
- claude-code-router
- awesome-mcp-servers

### COST (5)
- system-prompts-ai
- best-practice
- codex-plugin-cc
- claude-hud
- caveman

## MCP Servers đã cấu hình

- **GitHub MCP** - Quản lý GitHub repos, issues, PRs
- **Playwright MCP** - Web scraping, testing
- **Context7 MCP** - Documentation lookup
- **Chrome DevTools MCP** - Browser debugging

## Thư mục quan trọng

| Thư mục | Mục đích |
|---------|----------|
| `~/.config/opencode/skills/` | Skills đã cài đặt |
| `~/.config/opencode/opencode.json` | Config OpenCode |
| `~/Documents/skills-collection/` | Tất cả skills repos |
| `~/Documents/obsidian-mind/` | Obsidian Mind vault |
| `~/Documents/cli-anything-setup/` | CLI Anything setup |

## Khắc phục sự cố

### Lỗi "Execution Policy"
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
```

### Lỗi "Command not found"
```powershell
# Reload PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
```

### Lỗi "Permission denied"
```powershell
# Chạy PowerShell với quyền Admin
# Click phải → Run as Administrator
```

## Liên hệ

- GitHub: https://github.com/phamhaison
- Repos: https://github.com/phamhaison/skills-collection
