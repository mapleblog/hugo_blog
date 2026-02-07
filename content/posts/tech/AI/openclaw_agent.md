# 🔧 Manual Agent Setup Guide

A step-by-step guide to create new OpenClaw agents with Telegram integration.

---

## Part 1: Create the Workspace Files

### Step 1: Create the folder
```bash
mkdir -p ~/.openclaw/workspaces/YOUR-AGENT-NAME
```

### Step 2: Create SOUL.md (Personality)
```bash
nano ~/.openclaw/workspaces/YOUR-AGENT-NAME/SOUL.md
```

Example SOUL.md:
```markdown
# SOUL.md - Your Agent Name

You are **Agent Name** 🎯 — a brief description of personality.

## Personality
- Trait 1
- Trait 2
- Trait 3

## How You Respond
- Style guide 1
- Style guide 2

## Emoji You Use
🎯 ✨ 💡 (pick your favorites)
```

Save: Ctrl+O, Enter, Ctrl+X

### Step 3: Create AGENTS.md (Job Description)
```bash
nano ~/.openclaw/workspaces/YOUR-AGENT-NAME/AGENTS.md
```

Example AGENTS.md:
```markdown
# AGENTS.md

Read SOUL.md first — that's who you are.

## Your Job
- Task 1
- Task 2
- Task 3

## What You DON'T Do
- Limitation 1
- Limitation 2
```

Save: Ctrl+O, Enter, Ctrl+X

---

## Part 2: Edit OpenClaw Config

### Step 4: Open the config file
```bash
nano ~/.openclaw/openclaw.json
```

### Step 5: Add your agent to `agents.list`

Find this section:
```json
"agents": {
  "list": [
```

Add your agent (with comma after previous entry):
```json
{
  "id": "your-agent-name",
  "name": "Your Agent Display Name",
  "workspace": "/home/YOUR-USERNAME/.openclaw/workspaces/YOUR-AGENT-NAME"
}
```

⚠️ Replace `YOUR-USERNAME` with your actual Linux username!

---

## Part 3: Create Telegram Group & Get Chat ID

### Step 6: Create Telegram group
1. Open Telegram
2. Tap ☰ menu → "New Group"
3. Name your group
4. Add your bot (search for it by username)
5. Create the group

### Step 7: Get the Chat ID

**Option A:** Type `/chatid` in the group

**Option B:** Check gateway logs:
```bash
journalctl -u openclaw -f
```
Then send a message in the group and look for the chat ID in logs.

The chat ID looks like: `-1234567890` (negative number for groups)

---

## Part 4: Add Binding & Allowlist

### Step 8: Add binding to config

In `openclaw.json`, find:
```json
"bindings": [
```

Add your binding **AT THE TOP** (before other bindings):
```json
{
  "agentId": "your-agent-name",
  "match": {
    "channel": "telegram",
    "peer": {
      "kind": "group",
      "id": "-YOUR-CHAT-ID"
    }
  }
},
```

⚠️ Don't forget the comma! Bindings are matched top-to-bottom.

### Step 9: Add group to allowlist

Find:
```json
"channels": {
  "telegram": {
    "groups": {
```

Add your group:
```json
"-YOUR-CHAT-ID": {
  "enabled": true,
  "requireMention": false
}
```

- `enabled: true` → Bot listens to this group
- `requireMention: false` → Bot responds without @mention

---

## Part 5: Restart OpenClaw

### Step 10: Restart to apply changes
```bash
openclaw gateway restart
```

Or if running as a service:
```bash
sudo systemctl restart openclaw
```

---

## 📋 Quick Checklist

| ✓ | Step | Location |
|---|------|----------|
| ☐ | Create workspace folder | `~/.openclaw/workspaces/` |
| ☐ | Create SOUL.md | In workspace folder |
| ☐ | Create AGENTS.md | In workspace folder |
| ☐ | Add agent to list | `openclaw.json` → `agents.list` |
| ☐ | Create Telegram group | Telegram app |
| ☐ | Get chat ID | `/chatid` command |
| ☐ | Add binding | `openclaw.json` → `bindings` (top!) |
| ☐ | Add to group allowlist | `openclaw.json` → `channels.telegram.groups` |
| ☐ | Restart gateway | `openclaw gateway restart` |

---

## 🔍 Troubleshooting

### Bot not responding?
1. Check if group is in allowlist
2. Check if `requireMention` is `false`
3. Try `/reset` in the group to clear old session
4. Check logs: `journalctl -u openclaw -f`

### Wrong agent responding?
1. Make sure your binding is ABOVE the catch-all binding
2. Run `/reset` in the group
3. Restart gateway

### Can't find chat ID?
1. Make sure bot is added to the group
2. Send a message and check logs
3. Or use `/chatid` command

---

## 📁 File Structure

```
~/.openclaw/
├── openclaw.json          ← Main config file
└── workspaces/
    ├── ai-tools/          ← Your main agent
    │   ├── SOUL.md
    │   └── AGENTS.md
    ├── ai-news/           ← AI News agent
    │   ├── SOUL.md
    │   └── AGENTS.md
    └── python-tutor/      ← Python Tutor agent
        ├── SOUL.md
        └── AGENTS.md
```

---

*Guide created by Clawbot 🤖 — Happy agent building!*
