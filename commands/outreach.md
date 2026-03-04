# /outreach <company> — Draft Outreach Messages

## Purpose
Draft personalized cold outreach and follow-up messages.

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use company info, products, brand voice, and contact email. If config is missing, stop and tell the user to run `/bd setup`.

## Step 1: Gather Context
- Company name (from argument)
- Message type: cold email, DM, follow-up, intro request, conference follow-up
- Recipient name and role (if known)
- Angle or specific hook (if any)
- Tone preference (or use config default)

## Step 2: Load Existing Intelligence
- Check `{paths.research}/{company}*.md` for existing research
- Check Linear for deal status and recent updates
- Check `{paths.meeting_notes}` for any prior meeting context
- If no research exists, offer to run `/prospect <company>` first

## Step 3: Execute
Delegate to `skills/outreach-drafter/SKILL.md` with all context.

## Step 4: Present & Iterate
- Show draft with subject line, body, timing recommendation
- Offer alternative angles
- Offer to log as Linear status update
