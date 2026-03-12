# /improve — Weekly Agent Improvement Audit

Runs every Wednesday. Analyzes the past week of agent usage and posts a report to Slack.

## What it does

- Parses `~/.claude/history.jsonl` for command usage and correction patterns
- Audits skill/plugin files for token weight and redundancy
- Generates a prioritized report: corrections, token efficiency, overkill, prompt templates, automation opportunities
- DMs the report to you in Slack via the Slack MCP

## Setup (one-time)

### 1. Create the skill file

Create `~/.claude/skills/improve/SKILL.md` — copy from:
`~/.claude/plugins/bd-intern/skills/improve/SKILL.md`

Or install it:
```bash
mkdir -p ~/.claude/skills/improve
cp ~/.claude/plugins/bd-intern/skills/improve/SKILL.md ~/.claude/skills/improve/SKILL.md
```

### 2. Create the weekly log

```bash
mkdir -p ~/.claude/projects/$(pwd | sed 's|/|-|g')/memory
```

Create `improve_log.md` in your project memory directory:
```markdown
# Improve Log
Log issues or wins with agents during the week. /improve reads this every Wednesday.

## This Week
<!-- Add notes here -->
```

### 3. Set up the Wednesday reminder (Railway — always on)

Deploy a cron job to Railway that sends you a Slack reminder every Wednesday 9am:

1. Create a GitHub repo (e.g. `agent-ops`) with this file as `main.py`:

```python
import os, json, urllib.request
from datetime import datetime

webhook_url = os.environ["SLACK_WEBHOOK_URL"]
payload = json.dumps({"text": f":robot_face: *Time to run `/improve`* — open Claude Code and type `/improve`\n_{datetime.now().strftime('%A, %B %d %Y')}_"})
req = urllib.request.Request(webhook_url, data=payload.encode(), headers={"Content-Type": "application/json"})
urllib.request.urlopen(req)
```

2. Go to **railway.app** → New Project → Deploy from GitHub → select your repo
3. Settings → Cron Schedule: `0 16 * * 3` (Wednesday 9am PT / 12pm ET)
4. Start Command: `python main.py`
5. Variables → add `SLACK_WEBHOOK_URL` (get from api.slack.com/apps → Incoming Webhooks)

### 4. Add to CLAUDE.md (session cron backup)

Add this to `~/.claude/CLAUDE.md` so Claude recreates the cron on every session start:
```
On every session start, silently schedule: CronCreate cron="3 9 * * 3" prompt="/improve" recurring=true
```

## Usage

```
/improve
```

Runs the full audit and DMs the report to your Slack. At the end it will ask if you want to implement any fixes.

## Mid-week logging

Drop notes in your `improve_log.md` during the week — `/improve` picks them up automatically on Wednesday:
```
- [2026-03-10] /bd — Linear write flow failed twice, had to manually correct
- [2026-03-11] /agenda — wrong name in greeting, fix the config
```
