---
name: weekly-pipeline-review
description: Weekly pipeline health digest across all active deals
version: 1.0.0
---

# Weekly Pipeline Review

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use:
- `crm.team_name` — for pipeline queries
- `paths.meeting_notes` — for meeting context
- `integrations.slack_channel` — for Slack posting

If config is missing, stop and tell the user to run `/bd-intern setup`.

## BOSS Skill Delegation
Check for a `weekly-recap` BOSS skill. If found, coordinate — this skill owns pipeline analysis, weekly-recap owns meeting summaries.

## Step 1: Gather Pipeline Data

Use the **pipeline-reviewer agent** (`agents/pipeline-reviewer.md`):
- Pull all projects from `{crm.team_name}` team in Linear
- For each: stage, health, last update date and content, labels, lead

## Step 2: Load Meeting Context

Search `{paths.meeting_notes}` for notes from the past 7 days. Extract:
- Which deals had meetings
- Key outcomes and action items
- Any new leads surfaced

## Step 3: Analyze & Categorize

### Moving Forward
Deals that advanced stage or had positive updates this week.

### Stale
Deals with no update in 14+ days:
- 14-21 days: Nudge — suggest specific action
- 21-30 days: Escalation — recommend reaching out or reassessing
- 30+ days: Consider abandoning — be direct

### At Risk
Deals with health=atRisk/offTrack or negative signals in updates.

### New This Week
Deals created in the last 7 days.

## Step 4: Write Digest

Structure:

### Summary
One-line stats: "X active deals. Y moved forward. Z stale. W at risk. V new."

### Deals Moving Forward
```
| Company | Stage Change | Key Update | Next Step |
```

### Needs Attention
```
| Company | Issue | Days Since Update | Recommended Action |
```

### New Deals
```
| Company | Product Interest | Source | Status |
```

### Action Items
Consolidated from all deals, sorted by urgency. Include:
- Overdue items (from meeting notes)
- This week's follow-ups
- Upcoming deadlines

### Pipeline by Stage
```
| Stage | Count | Deals |
```

### Looking Ahead
- Upcoming meetings this week
- Expected decisions or milestones
- Deals approaching stage transitions

## Step 5: Save & Distribute

- Save to `{paths.meeting_notes}/_weekly-digests/Pipeline Review {YYYY-MM-DD}.md`
- If Slack channel configured and user requested, post condensed version to `{integrations.slack_channel}`
