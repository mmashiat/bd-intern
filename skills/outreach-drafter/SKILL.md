---
name: outreach-drafter
description: Draft personalized cold outreach and follow-up messages
version: 1.0.0
---

# Outreach Drafter

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use:
- `company.name`, `company.description` — for company context
- `products[]` — for product references
- `brand_voice` — for tone and word choices
- `contact.email` — for signatures
- `pipeline.engagement_offer` — for CTAs
- `paths.research`, `paths.meeting_notes` — for loading context

If config is missing, stop and tell the user to run `/bd setup`.

## Step 1: Gather Context

Collect:
- Company name (required)
- Message type: cold email, cold DM, follow-up, intro request, conference follow-up
- Recipient: name, role (if known)
- Angle: specific hook or value proposition (if any)
- Tone preference: override config voice for this message (optional)

## Step 2: Load Intelligence

Before drafting, gather all available context:
- **Research**: `{paths.research}/{company}*.md`
- **Linear**: Deal status, stage, recent updates
- **Meeting Notes**: `{paths.meeting_notes}` — search for company mentions

If no research exists, tell the user and offer to run prospect research first.

## Step 3: Draft

Use the **writer agent** (`agents/writer.md`) with:
- Message type and template from `references/templates.md`
- All loaded context
- Config voice settings

### Template Selection

| Type | Template | Max Length |
|------|----------|-----------|
| Cold email (technical) | Cold Email — Technical Decision Maker | 150 words |
| Cold email (executive) | Cold Email — Executive/Business | 150 words |
| Cold DM | Cold DM | 80 words |
| Follow-up | Follow-Up | 100 words |
| Conference follow-up | Conference Follow-Up | 120 words |
| Intro request | Intro Request | 100 words |

### Personalization Requirements
- Specific opening that proves research (reference their product, recent news, or shared context)
- Clear connection between their situation and your product
- Concrete detail (not vague value props)
- Single, specific CTA
- No buzzwords from `brand_voice.avoid_words`

## Step 4: Present

Show:
- Subject line (for emails)
- Message body
- Timing recommendation (best day/time to send)
- Alternative angle (one-liner for a different approach)

## Step 5: Iterate & Log

- Accept feedback and revise
- Offer to log as Linear status update on the deal
