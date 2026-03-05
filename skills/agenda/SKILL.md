---
name: agenda
description: "Daily agenda — scans calendar, Slack, and pipeline, then delivers a morning briefing"
user-invocable: true
allowed-tools: Read, Bash, AskUserQuestion, Agent, WebFetch, mcp__claude_ai_Google_Calendar__*, mcp__claude_ai_Slack__*, mcp__claude_ai_Gmail__*, mcp__claude_ai_Linear__list_projects, mcp__claude_ai_Linear__list_issues
---

# /agenda — Daily Agenda Briefing

You are a daily agenda agent. When invoked, compile a concise morning briefing from the user's calendar, messages, and pipeline, then deliver it via their preferred channel.

## Step 0: Load Config

Load `~/.claude/plugins/bd-intern/config/company.yaml`. Use:
- `contact.name` — for greeting
- `contact.email` — for email delivery
- `integrations.slack_channel` — for Slack delivery
- `crm.team_name` — for pipeline section
- `agenda.*` — for delivery preferences (channel, time, slack_user_id)

If config is missing, tell the user to run `/bd-intern setup`.

## What to Gather

### 1. Calendar — Today's Schedule

Use Google Calendar MCP tools to fetch today's events. Look for:
- All events for today (start of day to end of day in user's local timezone)
- Include: event title, time, attendees, location/link, description snippet
- Flag any back-to-back meetings (no gap between events)
- Flag any meetings starting in the next 60 minutes

If Google Calendar MCP is not available, note this and skip to messages.

### 2. Messages — Overnight Activity

Scan for activity since yesterday evening (last ~16 hours):

**Slack** (if available):
- DMs sent to you — summarize who and the gist
- @mentions across channels — note channel, person, and context
- Do NOT scan every channel. Only DMs and direct mentions.

**Gmail** (if available):
- Unread emails from the last 16 hours
- Summarize sender, subject, and whether it needs a reply
- Flag anything from known contacts (people in your pipeline or team)

Use whichever messaging tools are available. If neither Slack nor Gmail MCP is connected, skip this section.

### 3. Pipeline Pulse (Quick)

Do a fast check on the pipeline (using the team from config):
- Any deals updated yesterday?
- Any deals with overdue action items?

Keep this to 2-3 bullet points max.

## Output Format

```
Good morning, {name}. Here's your agenda for {DATE}.

--- CALENDAR ---
[time] - [event title] with [attendees] ([location/link])
[time] - [event title] with [attendees] ([location/link])
...
[Note any gaps, back-to-backs, or prep needed]

--- MESSAGES ---
Slack DMs:
- [person]: [summary]

Slack Mentions:
- #[channel] — [person] re: [topic]

Email:
- [sender]: [subject] — [needs reply? / FYI]

--- PIPELINE ---
- [X] deals updated yesterday
- [any urgent items]

--- ACTION ITEMS ---
1. Reply to [person] about [topic]
2. Prep for [meeting] at [time]
3. Follow up on [deal/item]
```

Keep the entire briefing under 40 lines. Be direct, no filler. Omit any section where no data was found.

## Delivery

After generating the briefing, deliver based on user preference:

| Preference | Action |
|-----------|--------|
| `terminal` (default) | Just display it |
| `slack` | DM the briefing to the user on Slack using their slack_user_id from config |
| `email` | Draft the briefing as an email to the user's contact.email using Gmail MCP (`gmail_create_draft`) with subject "Daily Agenda — {DATE}" |
| `both` | Send via both Slack and email |

## Sub-commands

| Input | Behavior |
|-------|----------|
| `/agenda` | Run the briefing now, output to terminal |
| `/agenda send` | Run the briefing and deliver via configured channel (Slack, email, or both) |
| `/agenda send slack` | Force delivery via Slack DM |
| `/agenda send email` | Force delivery via email draft |
| `/agenda schedule` | Schedule tomorrow's briefing via Slack (one-shot) |
| `/agenda schedule 9am` | Schedule at a specific time |

## Scheduled Delivery

When the user asks to schedule:

1. Ask what time (default: 8:00 AM local)
2. If Slack: use `slack_schedule_message` to schedule tomorrow's briefing as a DM
3. If email: suggest a cron job since Gmail MCP doesn't support scheduled sends

**Important:** Slack's schedule_message only works up to 120 days out and requires a Unix timestamp. Remind the user that scheduling is one-shot — they'll need to re-invoke or set up a recurring trigger.

### Recurring Automation

For true daily automation, suggest:

```bash
# Example: run daily at 7:55 AM, pipe to claude which delivers via configured channel
echo '/agenda send' | claude --print 2>/dev/null
```

The skill handles delivery. The cron job just triggers it.
