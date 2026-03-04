---
name: deal-brief
description: Generate comprehensive deal summary synthesizing all intelligence
version: 1.0.0
---

# Deal Brief

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use:
- `company.name`, `products[]` — for value proposition
- `pipeline.engagement_offer` — for recommended next steps
- `crm.team_name` — for Linear queries
- `paths.research`, `paths.meeting_notes`, `paths.content` — for intelligence

If config is missing, stop and tell the user to run `/bd-intern setup`.

## Step 1: Identify Deal

- Company name (from user)
- Search Linear for project in `{crm.team_name}` team
- If not found, inform user and offer to create via bd-pipeline skill

## Step 2: Collect All Intelligence

### From Linear
- Project status, stage, health
- All status updates (chronological)
- Related issues and their statuses
- Labels, lead owner
- Initiative association

### From Research
- `{paths.research}/{company}*.md` — prospect research
- `{paths.research}/Competitive/{company}*.md` — competitive research

### From Meeting Notes
- Search `{paths.meeting_notes}` for all company mentions
- Extract: timeline, decisions, commitments, attendees, sentiment

### From Content
- Any existing outreach drafts, proposals, one-pagers in `{paths.content}`

## Step 3: Synthesize

Use the **writer agent** (`agents/writer.md`) to produce:

### Executive Summary
3-5 sentences: Who they are, where the deal stands, what's next, key risk.

### Company Overview
Condensed from research — what matters for this deal.

### Relationship Timeline
```
| Date | Event | Key Outcome |
```

### Deal Status
- Current stage and time in stage
- Health assessment
- Active blockers
- Key milestones achieved

### Value Proposition
- Which product(s) from config fit
- Specific technical fit (how our product solves their problem)
- Quantified value if possible

### Competitive Landscape
- Who else they're evaluating or using
- Our advantages and disadvantages vs. each

### Open Items
- Outstanding action items (with owners)
- Commitments made by both sides
- Unanswered questions

### Risk Assessment
- What could kill this deal
- Mitigations for each risk
- Overall deal health verdict

### Recommended Next Steps
3 specific actions with suggested owners and dates.

## Step 4: Save

Save to `{paths.research}/{Company} Deal Brief.md`
