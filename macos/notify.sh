#!/bin/bash
# Claude Code notification hook: plays Glass sound + shows popup with decision details

# Read JSON from stdin
input=$(cat)

# Extract the message from the JSON (the notification message field)
message=$(echo "$input" | python3 -c "import sys,json; data=json.load(sys.stdin); print(data.get('message','Claude Code needs your decision'))" 2>/dev/null)

# Fallback if parsing fails
if [ -z "$message" ]; then
  message="Claude Code needs your decision"
fi

# Get the project name from current working directory
project=$(basename "$PWD")

# Combine project name + message
full_message="[$project] $message"

# Play sound (non-blocking)
afplay /System/Library/Sounds/Glass.aiff &

# Show popup, then navigate to the SPECIFIC Cursor window matching this project
osascript <<EOF &
set dialogResult to display dialog "$full_message" with title "Claude Code — $project" buttons {"Got it"} default button "Got it" giving up after 10
if button returned of dialogResult is "Got it" then
    tell application "Cursor"
        activate
        set targetProject to "$project"
        set foundWindow to false
        repeat with w in (every window)
            if name of w contains targetProject then
                set index of w to 1
                set foundWindow to true
                exit repeat
            end if
        end repeat
    end tell
end if
EOF

exit 0
