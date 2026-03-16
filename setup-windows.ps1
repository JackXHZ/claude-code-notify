# Automated setup for Claude Code Notify (Windows)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = Join-Path $env:USERPROFILE ".claude"
$CommandsDir = Join-Path $ClaudeDir "commands"

Write-Host "Setting up Claude Code Notify for Windows..."

# Create directories if they don't exist
New-Item -ItemType Directory -Force -Path $CommandsDir | Out-Null

# Copy files
Copy-Item (Join-Path $ScriptDir "windows\notify.ps1") (Join-Path $ClaudeDir "notify.ps1") -Force
Copy-Item (Join-Path $ScriptDir "windows\settings.json") (Join-Path $ClaudeDir "settings.json") -Force
Copy-Item (Join-Path $ScriptDir "windows\CLAUDE.md") (Join-Path $ClaudeDir "CLAUDE.md") -Force
Copy-Item (Join-Path $ScriptDir "windows\commands\notify.md") (Join-Path $CommandsDir "notify.md") -Force

Write-Host ""
Write-Host "Setup complete! Files installed to $ClaudeDir\"
Write-Host ""
Write-Host "Next step: Open Claude Code and run /hooks to verify the hook is registered."
