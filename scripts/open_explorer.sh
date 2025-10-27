#!/usr/bin/env bash
# Opens Windows File Explorer in the current WSL directory (tmux-aware)

set -e

notify_tmux() {
  if [ -n "$TMUX" ]; then
    tmux display-message "$1"
  else
    echo "$1"
  fi
}

# Get the current path (allow running from tmux)
path="${1:-$(pwd)}"

# Convert WSL path to Windows path using wslpath
win_path=$(wslpath -w "$path" 2>/dev/null || true)

if [[ -z "$win_path" ]]; then
  notify_tmux "❌ Unable to convert path to Windows format"
  exit 1
fi

# Use PowerShell to open Explorer
powershell_exe=$(wslpath "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe")

if [ -x "$powershell_exe" ]; then
  "$powershell_exe" -NoProfile -ExecutionPolicy Bypass -Command \
    "Start-Process 'explorer.exe' '$win_path'" >/dev/null 2>&1 &
  notify_tmux "📂 Opening Windows Explorer at: $win_path"
else
  notify_tmux "⚠️ PowerShell not found in WSL path"
  exit 1
fi
