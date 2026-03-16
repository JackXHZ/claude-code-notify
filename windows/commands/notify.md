When you have completed all the tasks in this conversation turn, run this command to notify the user:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\.claude\notify.ps1" <<< '{"message":"Tasks completed — ready for your review"}'
```

This is a non-negotiable final step. Always run this notification at the very end after all work is done.
