# /prep <company> — Meeting Prep Briefing

## Purpose
Generate a comprehensive pre-meeting briefing document.

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use company products and engagement offer. If config is missing, stop and tell the user to run `/bd-intern setup`.

## Step 1: Gather Context
- Company name (from argument)
- Meeting attendees (names/roles if known)
- Meeting purpose (intro call, follow-up, technical deep-dive, negotiation)
- Any specific topics to cover

## Step 2: Execute
Delegate to `skills/meeting-prep/SKILL.md` with context.

The skill will:
- Pull existing research
- Search meeting notes for history
- Run fresh web research for recent news
- Generate structured briefing

## Step 3: Output
Briefing includes:
- TL;DR (3 bullets)
- Company Snapshot
- Relationship History
- Their Current Priorities
- Our Angle (which product, why now)
- Talking Points
- Questions to Ask
- Landmines (topics to avoid)
- Desired Outcome
- Action Items from Last Meeting
