# Global Instructions

## Notification System

When the user appends `/notify` to any instruction, you MUST run this command as the very last step after all work is complete:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\notify.ps1" <<< '{"message":"Tasks completed — ready for your review"}'
```

This plays a system sound and shows a popup window so the user knows you're done and waiting for their input.

### Auto-notification rules:
- When the user says `/notify`, always send the notification after finishing all tasks.
- The notification script is at `%USERPROFILE%\.claude\notify.ps1`.
- **IMPORTANT: Always include the project name and specific task in the message** so the user knows which workflow needs attention. Format: `[Project/Context] What was done — what's needed`.
- Examples:
  ```powershell
  powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\notify.ps1" <<< '{"message":"[News Digest Bot] PRD updated with Notion-first UI — ready for your review"}'
  powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\notify.ps1" <<< '{"message":"[API Refactor] Tests passing, 3 files changed — need your approval to commit"}'
  powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\notify.ps1" <<< '{"message":"[Security Audit] Found 2 issues in dependencies — need your decision on next steps"}'
  ```
- Always be specific. Never use generic messages like "Tasks completed". Include what project, what was done, and what you need from the user.
