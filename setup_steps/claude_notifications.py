"""Claude Code hooks for pane-aware tmux status and desktop notifications."""

import html
import json
import os
from pathlib import Path
import re
import shlex
import subprocess
import sys
import tempfile


STATE = "@agent_notify_state"

# Event: (Claude matcher, pane state, desktop title)
EVENTS = {
    "UserPromptSubmit": (None, "working", None),
    "Stop": (None, "done", "Claude reply ready"),
    "StopFailure": (None, "clear", "Claude turn failed"),
    "PermissionRequest": (None, "waiting", "Claude needs approval"),
    "Notification": ("permission_prompt", "waiting", "Claude needs approval"),
    "PreToolUse": ("AskUserQuestion|ExitPlanMode", "waiting", "Claude needs input"),
    "Elicitation": (None, "waiting", "Claude needs MCP input"),
    "ElicitationResult": (None, "resume", None),
    "PostToolUse": (None, "resume", None),
    "PostToolUseFailure": (None, "resume", None),
    "SessionEnd": (None, "clear", None),
}


def update_pane(state):
    """Return the pane label and whether to send this alert."""
    pane = os.environ.get("TMUX_PANE", "")
    if not os.environ.get("TMUX") or not re.fullmatch(r"%\d+", pane):
        return "", True
    set_state = f"set-option -pq -t {pane} {STATE}"
    label = f'display-message -p -t {pane} "#{{session_name}}:#{{window_index}}.#{{pane_index}}\t#{{pane_tty}}"'
    if state == "resume":
        command = ["if-shell", "-Ft", pane, f"#{{==:#{{{STATE}}},waiting}}", f"{set_state} working"]
    elif state == "waiting":
        command = ["if-shell", "-Ft", pane, f"#{{!=:#{{{STATE}}},waiting}}", f"{set_state} waiting ; {label}"]
    elif state == "clear":
        command = ["set-option", "-puq", "-t", pane, STATE, ";", *shlex.split(label)]
    else:
        command = [*shlex.split(set_state), state, ";", *shlex.split(label)]
    try:
        result = subprocess.run(["tmux", *command], capture_output=True, text=True, timeout=2)
    except (OSError, subprocess.TimeoutExpired):
        return "", True
    location, _, tty = result.stdout.rstrip("\n").partition("\t")
    if state == "waiting" and tty:
        # tmux forwards the pane bell to the terminal, which can flag window urgency.
        try:
            fd = os.open(tty, os.O_WRONLY | os.O_NOCTTY | os.O_NONBLOCK)
            with os.fdopen(fd, "wb") as terminal:
                terminal.write(b"\a")
        except OSError:
            pass
    return location, bool(location) or state != "waiting" or result.returncode != 0


def handle_hook(payload):
    event = payload.get("hook_event_name")
    if event not in EVENTS:
        return
    matcher, state, title = EVENTS[event]
    if event == "Notification" and payload.get("notification_type") != matcher:
        return
    if event == "PreToolUse" and payload.get("tool_name") not in matcher.split("|"):
        return
    location, should_alert = update_pane(state)
    if title and should_alert:
        project = Path(payload.get("cwd") or os.getcwd()).name
        body = " · ".join(html.escape(part) for part in (project, location) if part)
        try:
            urgency = "critical" if state == "waiting" else "normal"
            subprocess.run(
                ["notify-send", "--app-name=Claude Code", f"--urgency={urgency}", title, body],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=3,
            )
        except (OSError, subprocess.TimeoutExpired):
            pass  # A desktop delivery failure cannot change Claude's hook decision.


def write_atomic(path, content, mode):
    with tempfile.NamedTemporaryFile(dir=path.parent, delete=False) as staged:
        temp_path = Path(staged.name)
        try:
            staged.write(content)
            staged.close()
            temp_path.chmod(mode)
            temp_path.replace(path)
        finally:
            temp_path.unlink(missing_ok=True)


def configure(enable):
    config_dir = Path(os.environ.get("CLAUDE_CONFIG_DIR") or Path.home() / ".claude").expanduser()
    settings = (config_dir / "settings.json").resolve()
    helper = config_dir.resolve() / "dotfiles-notifications.py"
    if not enable and not settings.exists():
        return
    config = json.loads(settings.read_text()) if settings.exists() else {}
    original = json.dumps(config)
    hooks = config.setdefault("hooks", {})
    handler = {"type": "command", "command": shlex.join(["python3", str(helper)]), "timeout": 6}
    for event, (matcher, _, _) in EVENTS.items():
        groups = hooks.get(event, [])
        for group in groups[:]:
            group["hooks"] = [item for item in group.get("hooks", []) if item.get("command") != handler["command"]]
            if not group["hooks"]:
                groups.remove(group)
        if enable:
            group = {"hooks": [handler]}
            if matcher:
                group["matcher"] = matcher
            groups.append(group)
        if groups:
            hooks[event] = groups
        else:
            hooks.pop(event, None)
    if not hooks:
        config.pop("hooks", None)
    if enable:
        settings.parent.mkdir(parents=True, exist_ok=True)
        write_atomic(helper, Path(__file__).read_bytes(), 0o600)
    if json.dumps(config) != original:
        mode = settings.stat().st_mode & 0o777 if settings.exists() else 0o600
        write_atomic(settings, (json.dumps(config, indent=2, ensure_ascii=False) + "\n").encode(), mode)
    print(f"Claude notification hooks {'enabled' if enable else 'disabled'} in {settings}")


if __name__ == "__main__":
    if sys.argv[1:] in (["--install"], ["--disable"]):
        configure(sys.argv[1] == "--install")
    elif not sys.argv[1:]:
        try:
            payload = json.load(sys.stdin)
        except (ValueError, UnicodeError):
            payload = None
        if isinstance(payload, dict):
            handle_hook(payload)
    else:
        sys.exit(f"Usage: {sys.argv[0]} [--install | --disable]")
