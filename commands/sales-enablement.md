# /sales-enablement — Sales Content Creation

## Purpose
Create sales content: client meeting decks, pre-call briefings, post-meeting debriefs, technical briefs, one-pagers, and competitive positioning documents.

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use company name, products, engagement offer, brand voice, and contact email. If config is missing, stop and tell the user to run `/bd setup`.

Also load `references/product-knowledge.md` if it exists — this is the ground truth for product claims. Never fabricate capabilities not in this file.

## Step 1: Select Content Type

Ask what they want to create:

| Type | Description |
|------|-------------|
| `deck` or `meeting deck` | Client meeting deck (slide-by-slide outline) |
| `briefing` or `pre-call` | Pre-call briefing (internal) |
| `debrief` or `post-meeting` | Post-meeting debrief (internal) |
| `tech brief` | Technical brief (internal engineering) |
| `one-pager` | Single-page prospect-tailored overview |
| `positioning` or `competitive` | Competitive positioning document |

## Step 2: Gather Context
- **For all types**: Which prospect/company? Which product(s)?
- **For deck**: What's the meeting purpose? Who's attending?
- **For briefing**: What do we know so far? What's the ask?
- **For debrief**: What happened in the meeting? Key takeaways?
- **For tech brief**: What technical details matter?
- **For one-pager**: Target audience role? Key pain point?
- **For positioning**: Which competitor(s)?

## Step 3: Load Context (Critical)

Before generating ANY content, load all available intelligence:
- **Linear**: Project status, stage, health, status updates, issues
- **Meeting Notes**: Search `{paths.meeting_notes}` for company mentions, extract relationship timeline, key contacts, what resonated, commitments
- **Research**: `{paths.research}/{company}*.md`, competitive research
- **Content**: Any existing content about this company in `{paths.content}`

**Use what you find**: Content must reflect the current relationship state. If an NDA was signed, reference that. If they expressed interest in a specific feature, lead with it.

## Step 4: Execute
Delegate to `skills/sales-enablement/SKILL.md` with content type, context, and all loaded intelligence.

## Step 5: Output Rules

### Global Rules
- **Length**: 2-3 pages max. Concise. Cut filler.
- **Company Intro** (external docs only): 2-3 sentence block about your company from `config.company.description`
- **Next Steps**: Always end with your engagement offer from `config.pipeline.engagement_offer` + contact email from `config.contact.email`
- **Writing**: Every claim traceable to product knowledge file. Specific numbers. No vague superlatives.
- **Voice**: Follow `config.brand_voice` settings

### Design Language
- **Decks/Polished**: Bold stat callouts, clean section numbering, comparison tables, flow diagrams as text, key property callouts
- **Internal Docs**: Clean — bold/headers/bullets only, short paragraphs, lists over prose, tables for comparisons, monospace for technical details, "Internal — Do Not Share" label
- **Output**: Markdown files. Deck outlines include visual treatment notes. Offer Google Docs publishing if skill available.
