#!/bin/sh
# kshell-launcher: hidden
# agent-notify — let an agent tell you, through kshell, that it finished or needs you.
#
#   agent-notify stamp      [agent] [session]
#   agent-notify done       [agent] [message]
#   agent-notify attention  [agent] [message]
#   agent-notify error      [agent] [message]
#
# Call `stamp` when a turn starts and `done` when it ends: a turn shorter than
# KSHELL_NOTIFY_MIN_SECONDS is not news, so it stays quiet. `attention` and
# `error` always speak up.
#
# The project is the working directory's name, so a card reads
# "opencode needs you · kshell". It stays silent while a terminal is frontmost —
# you are already looking — and falls back to a macOS banner when kshell isn't
# running. Both are deliberate: an agent that pings while you are watching is
# noise, and one that fails silently is worse than no notification at all.
#
# Environment:
#   KSHELL_NOTIFY_OFF=1           do nothing at all
#   KSHELL_NOTIFY_ALWAYS=1        notify even when a terminal is frontmost
#   KSHELL_NOTIFY_OFFLINE=1       skip kshell, use the system banner
#   KSHELL_NOTIFY_MIN_SECONDS=8   quiet threshold for `done`
#   KSHELL_NOTIFY_ACTION=CMD      shell command to run when the card is clicked
#   KSHELL_NOTIFY_PROJECT=NAME    override the project name

set -u

kind="${1:-}"
agent="${2:-agent}"
message="${3:-}"

[ "${KSHELL_NOTIFY_OFF:-}" = "1" ] && exit 0

state_dir="${TMPDIR:-/tmp}/kshell-agent-notify"
mkdir -p "$state_dir" 2>/dev/null || true
stamp="$state_dir/$agent.stamp"
now=$(date +%s)

case "$kind" in
  stamp)
    printf '%s' "$now" > "$stamp"
    exit 0
    ;;
  done|attention|error) ;;
  *)
    echo "usage: agent-notify stamp|done|attention|error [agent] [message]" >&2
    echo "       (see the header of this script for the environment switches)" >&2
    exit 2
    ;;
esac

# Already looking at it? Then there is nothing to announce.
if [ "${KSHELL_NOTIFY_ALWAYS:-}" != "1" ]; then
  front=$(/usr/bin/lsappinfo front 2>/dev/null || true)
  if [ -n "$front" ]; then
    front_name=$(/usr/bin/lsappinfo info -only name "$front" 2>/dev/null \
      | sed -n 's/.*"LSDisplayName"="\(.*\)"/\1/p')
    case "${front_name:-}" in
      kitty|iTerm|iTerm2|WezTerm|Alacritty|Ghostty|Terminal|Warp|Hyper|tmux) exit 0 ;;
    esac
  fi
fi

# A quick turn that has just finished is not worth a card.
if [ "$kind" != "attention" ] && [ -f "$stamp" ]; then
  started=$(cat "$stamp" 2>/dev/null || echo 0)
  case "$started" in
    ''|*[!0-9]*) started=0 ;;
  esac
  if [ $((now - started)) -lt "${KSHELL_NOTIFY_MIN_SECONDS:-8}" ]; then
    exit 0
  fi
fi
rm -f "$stamp" 2>/dev/null || true

project=$(basename "${KSHELL_NOTIFY_PROJECT:-$PWD}" 2>/dev/null || true)
[ -n "${project:-}" ] || project="a project"

case "$kind" in
  done)
    title="$agent finished · $project"
    tone="success"
    [ -n "$message" ] || message="Ready when you are."
    ;;
  attention)
    title="$agent needs you · $project"
    tone="warning"
    [ -n "$message" ] || message="Waiting on you."
    ;;
  error)
    title="$agent stopped · $project"
    tone="error"
    [ -n "$message" ] || message="It ended with an error."
    ;;
esac

# Hooks can fire in bursts (a permission prompt retried, two event names for the
# same thing); don't stack identical cards.
rate_key="last-$(printf '%s-%s' "$kind" "$project" | tr -c 'A-Za-z0-9._-' '_')"
rate_file="$state_dir/$rate_key"
if [ -f "$rate_file" ]; then
  last=$(cat "$rate_file" 2>/dev/null || echo 0)
  case "$last" in
    ''|*[!0-9]*) last=0 ;;
  esac
  [ $((now - last)) -lt 3 ] && exit 0
fi
printf '%s' "$now" > "$rate_file"

# Clicking the card should bring the terminal back, when we know which one it is.
terminal_app() {
  case "${TERM_PROGRAM:-}" in
    kitty) echo "kitty" ;;
    iTerm.app) echo "iTerm" ;;
    Apple_Terminal) echo "Terminal" ;;
    WezTerm) echo "WezTerm" ;;
    ghostty) echo "Ghostty" ;;
    alacritty) echo "Alacritty" ;;
    vscode) echo "Visual Studio Code" ;;
    *) echo "" ;;
  esac
}

kshell_bin="$HOME/.local/bin/kshell"
if [ "${KSHELL_NOTIFY_OFFLINE:-}" != "1" ] && [ -x "$kshell_bin" ]; then
  action="${KSHELL_NOTIFY_ACTION:-}"
  if [ -z "$action" ]; then
    app=$(terminal_app)
    [ -n "$app" ] && action="open -a '$app'"
  fi
  if [ -n "$action" ]; then
    "$kshell_bin" notify "$title" "$message" --app="$agent" --tone="$tone" --action="$action" >/dev/null 2>&1 && exit 0
  else
    "$kshell_bin" notify "$title" "$message" --app="$agent" --tone="$tone" >/dev/null 2>&1 && exit 0
  fi
fi

# No shell listening: the system's own banner still reaches you.
osascript -e 'on run argv' \
  -e 'display notification (item 2 of argv) with title (item 1 of argv)' \
  -e 'end run' -- "$title" "$message" >/dev/null 2>&1 || true
exit 0
