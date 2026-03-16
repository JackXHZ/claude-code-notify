# Claude Code notification hook: plays system sound + shows popup with decision details

# Read JSON from stdin
$input = [Console]::In.ReadToEnd()

# Extract the message from the JSON
try {
    $data = $input | ConvertFrom-Json
    $message = $data.message
} catch {
    $message = $null
}

# Fallback if parsing fails
if (-not $message) {
    $message = "Claude Code needs your decision"
}

# Get the project name from current working directory
$project = Split-Path -Leaf (Get-Location)

# Combine project name + message
$fullMessage = "[$project] $message"

# Play system sound (non-blocking)
Add-Type -AssemblyName System.Media
[System.Media.SystemSounds]::Asterisk.Play()

# Show popup dialog
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.MessageBox]::Show(
    $fullMessage,
    "Claude Code — $project",
    [System.Windows.Forms.MessageBoxButtons]::OK,
    [System.Windows.Forms.MessageBoxIcon]::Information
) | Out-Null

# After clicking OK, activate the Cursor window
try {
    $wshell = New-Object -ComObject WScript.Shell
    $wshell.AppActivate("Cursor") | Out-Null
} catch {
    # Silently ignore if Cursor is not running
}

exit 0
