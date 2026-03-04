# /prospect <company> — Research a Prospect

## Purpose
Research a prospect company thoroughly using public sources, produce a structured research document.

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use company products for fit assessment. If config is missing, stop and tell the user to run `/bd-intern setup`.

## Step 1: Gather Context
- Company name (from command argument)
- Ask: relationship type (cold lead, warm intro, inbound, existing contact)
- Ask: which product(s) are they potentially interested in? (list from config)
- Ask: any URLs, decks, or notes to start with?

## Step 2: Check Existing Research
- Look for existing research in `{paths.research}/{company}*.md`
- If found, ask: "I found existing research from {date}. Want me to update it or start fresh?"

## Step 3: Execute Research
Delegate to `skills/prospect-research/SKILL.md` with gathered context.

## Step 4: Offer Next Steps
After research is complete:
- Offer to create/update a Linear project via `/pipeline create`
- Offer to draft outreach via `/outreach <company>`
- Offer to prep for a meeting via `/prep <company>`
