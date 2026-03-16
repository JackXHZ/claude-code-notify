# Claude Code Notify

Sound + popup notifications for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) so you never miss when a task finishes or a decision is needed.

## Features

- **Glass sound** (macOS) / **System asterisk sound** (Windows) plays immediately
- **Popup dialog** shows the project name and task context (e.g. "[My Project] Auth module refactored -- ready for review")
- **Auto-navigate back to Cursor** after clicking "Got it" (macOS) or "OK" (Windows)
- Works with Claude Code hooks (`permission_prompt`) for automatic notifications
- Works with the `/notify` slash command for on-demand notifications

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and working
- macOS: Python 3 (pre-installed on modern macOS)
- Windows: PowerShell 5.1+ (pre-installed on Windows 10/11)

## Installation

### macOS

**Option A: Automated setup**

```bash
cd /path/to/claude-code-notify
chmod +x setup-macos.sh
./setup-macos.sh
```

Then open Claude Code and run `/hooks` to verify the hook is registered.

**Option B: Manual setup**

1. Copy the macOS files to your Claude config directory:

```bash
cp macos/notify.sh ~/.claude/notify.sh
cp macos/settings.json ~/.claude/settings.json
cp macos/CLAUDE.md ~/.claude/CLAUDE.md
mkdir -p ~/.claude/commands
cp macos/commands/notify.md ~/.claude/commands/notify.md
```

2. Make the notification script executable:

```bash
chmod +x ~/.claude/notify.sh
```

3. Open Claude Code and run `/hooks` to verify the hook is registered.

### Windows

**Option A: Automated setup**

Open PowerShell and run:

```powershell
cd \path\to\claude-code-notify
.\setup-windows.ps1
```

Then open Claude Code and run `/hooks` to verify the hook is registered.

**Option B: Manual setup**

1. Copy the Windows files to your Claude config directory:

```powershell
Copy-Item windows\notify.ps1 "$env:USERPROFILE\.claude\notify.ps1"
Copy-Item windows\settings.json "$env:USERPROFILE\.claude\settings.json"
Copy-Item windows\CLAUDE.md "$env:USERPROFILE\.claude\CLAUDE.md"
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\commands"
Copy-Item windows\commands\notify.md "$env:USERPROFILE\.claude\commands\notify.md"
```

2. Open Claude Code and run `/hooks` to verify the hook is registered.

## Usage

Append `/notify` to any instruction in Claude Code:

```
refactor the auth module /notify
fix the failing tests in user-service /notify
update the API docs for v2 endpoints /notify
```

Claude will complete all the requested work, then play a sound and show a popup with context about what was done.

Notifications also fire automatically whenever Claude Code hits a permission prompt (configured via the `permission_prompt` hook).

## How It Works

This package uses two Claude Code mechanisms:

1. **Hooks** (`settings.json`): The `permission_prompt` hook runs the notification script whenever Claude Code pauses to ask for permission. This gives you an audible + visual alert so you can switch back to approve or deny.

2. **Slash command** (`commands/notify.md` + `CLAUDE.md`): The `/notify` command instructs Claude to run the notification script as its very last step after completing all work. The `CLAUDE.md` file teaches Claude how to use the script and format contextual messages.

The notification script itself reads a JSON message from stdin, extracts the project name from the current working directory, plays a system sound, and shows a dialog. When you dismiss the dialog, it brings Cursor back to the foreground.

## Automated Setup

You can paste the following prompt directly into Claude Code to have it set everything up for you:

```
Set up Claude Code notifications for me. Copy the notification files from this repo to ~/.claude/ (macOS) or %USERPROFILE%\.claude\ (Windows). On macOS, make notify.sh executable. Then run /hooks to verify the setup. The repo is at: [PATH_TO_REPO]
```

Replace `[PATH_TO_REPO]` with the actual path to this repository on your machine.
