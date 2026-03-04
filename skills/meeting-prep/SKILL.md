---
name: meeting-prep
description: Generate comprehensive pre-meeting briefing documents
version: 1.0.0
---

# Meeting Prep

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use:
- `company.name`, `products[]` — for positioning
- `pipeline.engagement_offer` — for desired outcomes
- `paths.research`, `paths.meeting_notes` — for intelligence gathering

If config is missing, stop and tell the user to run `/bd setup`.

## Step 1: Gather Context

Collect:
- Company name (required)
- Meeting attendees (names, roles — if known)
- Meeting purpose: intro call, follow-up, technical deep-dive, negotiation, check-in
- Specific topics or concerns to address

## Step 2: Collect Intelligence

### Existing Research
- Search `{paths.research}/{company}*.md`
- Search Linear for project in `{crm.team_name}` — get stage, health, updates

### Meeting History
- Search `{paths.meeting_notes}` for files mentioning company name
- Extract:
  - Relationship timeline (first contact → most recent)
  - Key contacts and their roles/dynamics
  - What resonated in past conversations
  - Outstanding commitments from both sides
  - Open questions
  - Temperature (warming up? cooling? stalled?)

### Fresh Intelligence
- Use **researcher agent** for:
  - News in last 30 days
  - Twitter/X activity
  - Press releases
  - Market developments relevant to discussion
  - Any recent competitor moves

## Step 3: Build Briefing

Structure:

### TL;DR
3 bullets:
1. Where we are with them (stage, last interaction)
2. What we want from this meeting (specific outcome)
3. What to watch for (risks, sensitivities)

### Company Snapshot
Key facts from research (condensed — 5-8 lines max)

### Relationship History
Timeline table:
```
| Date | Event | Key Outcome |
```

### Their Current Priorities
What they care about right now (from news, job postings, announcements)

### Our Angle
- Which product from `config.products` fits best
- Why now (timing hook)
- What specific problem we solve for them

### Talking Points
3 specific points with supporting detail. Not generic — tied to their situation.

### Questions to Ask
3-5 strategic questions that:
- Reveal decision-making process
- Uncover technical requirements
- Surface competitive alternatives
- Clarify timeline and budget

### Landmines
Topics to avoid or handle carefully (past issues, competitive sensitivities, known objections)

### Desired Outcome
Specific success definition for this meeting (e.g., "Agree to technical deep-dive next week" not "Good conversation")

### Action Items from Last Meeting
List any outstanding items, flag overdue ones.

## Step 4: Save

Save to `{paths.research}/{Company} Meeting Prep {YYYY-MM-DD}.md`
