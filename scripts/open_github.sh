#!/usr/bin/env bash
# Opens current repo's GitHub page in Windows Brave from WSL (tmux friendly)

set -e

notify_tmux() {
  if [ -n "$TMUX" ]; then
    tmux display-message "$1"
  else
    echo "$1"
  fi
}

# Must be in a Git repo
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  notify_tmux "❌ Not inside a Git repository"
  exit 1
fi

# Get remote URL
url=$(git remote get-url origin 2>/dev/null || true)
if [[ -z "$url" ]]; then
  notify_tmux "❌ No remote 'origin' found"
  exit 1
fi

# Convert SSH → HTTPS
if [[ "$url" =~ ^git@ ]]; then
  url="${url/git@/https://}"
  url="${url/:/\/}"
fi

# Remove trailing .git
url="${url%.git}"

# Normalize GitHub URLs with .com if missing (safety)
url="${url//git@github.com:/https://github.com/}"

# Launch in Windows Brave via PowerShell
# (this works even if Brave is installed only on Windows)
powershell_exe=$(wslpath "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe")

if [ -x "$powershell_exe" ]; then
  "$powershell_exe" -NoProfile -ExecutionPolicy Bypass -Command \
    "Start-Process 'brave.exe' '$url'" >/dev/null 2>&1 &
  notify_tmux "🌐 Opening: $url"
else
  notify_tmux "⚠️ PowerShell not found at expected path"
  exit 1
fi
