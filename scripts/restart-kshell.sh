#!/bin/bash
# restart-kshell.sh — stop the running shell and start a fresh one.
#
# Safe to run from a kitty prompt or from kshell's own script launcher (which
# runs it detached, with no terminal): the new shell gets no controlling
# terminal and its own log, so closing the terminal that ran this does not take
# the shell with it.
#
# The old version killed and restarted without waiting, so the two raced over the
# IPC socket — the new shell would bind it and the dying one would remove it, and
# triggers then went nowhere.

set -u

KSHELL="$HOME/.local/bin/kshell"
LOG="$HOME/Library/Logs/kshell/kshell.log"
SOCKET="$HOME/Library/Application Support/kshell/kshell.sock"

if [ ! -x "$KSHELL" ]; then
    echo "restart-kshell: $KSHELL is not executable — build it first (swift build -c release)" >&2
    exit 1
fi

mkdir -p "$(dirname "$LOG")"

# ── one restart at a time ────────────────────────────────────────────────────
# Two restarts racing each kill what they can see and both start a shell, which
# leaves two sets of bars. macOS has no flock, so the lock is a directory:
# acquired with mkdir, which is atomic, and only ever broken when it is *stale*
# (a run that died and left it behind) — never while another run is using it.
LOCK="${TMPDIR:-/tmp}/kshell-restart.lock"
acquired=0
for _ in $(seq 1 150); do                       # wait up to 15s for our turn
    if mkdir "$LOCK" 2>/dev/null; then acquired=1; break; fi
    if [ -d "$LOCK" ]; then
        age=$(( $(date +%s) - $(stat -f %m "$LOCK" 2>/dev/null || echo 0) ))
        if [ "$age" -gt 15 ]; then
            rm -rf "$LOCK"
            continue
        fi
    fi
    sleep 0.1
done
if [ "$acquired" -ne 1 ]; then
    echo "restart-kshell: another restart is still running — try again in a moment" >&2
    exit 1
fi
trap 'rmdir "$LOCK" 2>/dev/null' EXIT INT TERM

# ── stop ─────────────────────────────────────────────────────────────────────
# `pgrep -x kshell` matches the executable name, not the command line, so this
# script (or anything else whose path contains "kshell") is never a target.
pids=$(pgrep -x kshell || true)
if [ -n "$pids" ]; then
    echo "restart-kshell: stopping ${pids//$'\n'/ }"
    kill $pids 2>/dev/null || true
    # Let it take its windows down and close its socket before a new one binds.
    for _ in $(seq 1 30); do
        pgrep -x kshell >/dev/null || break
        sleep 0.1
    done
    if pgrep -x kshell >/dev/null; then
        echo "restart-kshell: it did not exit, killing"
        pkill -9 -x kshell 2>/dev/null || true
        sleep 0.3
    fi
fi

# A shell that was killed never runs its own cleanup, and a stale socket would
# swallow every trigger aimed at the new one.
rm -f "$SOCKET"

# ── start ────────────────────────────────────────────────────────────────────
# No controlling terminal, no inherited stdio: nothing here dies with this
# script, this terminal, or the launcher.
nohup "$KSHELL" >"$LOG" 2>&1 </dev/null &
disown 2>/dev/null || true

# ── check it actually came up ────────────────────────────────────────────────
for _ in $(seq 1 80); do
    if "$KSHELL" trigger bar_show >/dev/null 2>&1; then
        echo "restart-kshell: up (pid $(pgrep -x kshell | head -1))"
        exit 0
    fi
    sleep 0.1
done

echo "restart-kshell: it did not answer on the socket — see $LOG" >&2
tail -5 "$LOG" >&2 2>/dev/null
exit 1
