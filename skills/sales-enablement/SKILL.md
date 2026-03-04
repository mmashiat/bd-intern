---
name: sales-enablement
description: Create sales content — decks, briefings, debriefs, tech briefs, one-pagers, competitive positioning
version: 1.0.0
---

# Sales Enablement

## Step 0: Load Config (Critical)
Read `config/company.yaml` from the bd-intern plugin directory. Use ALL fields:
- `company.name`, `company.website`, `company.description`
- `products[]` — names, descriptions, capabilities
- `brand_voice` — tone, personality, avoid/prefer words
- `contact.email` — for CTAs and signatures
- `pipeline.engagement_offer` — name, description, duration, cost
- `competitors[]` — for competitive positioning
- `crm.team_name`, `paths.*` — for context loading

Also load `references/product-knowledge.md` if it exists. This file is ground truth for product claims. **Never fabricate capabilities not documented here.**

If config is missing, stop and tell the user to run `/bd setup`.

## Step 0b: Load Client Context (Critical — Do This ALWAYS)

Before generating ANY content for a specific prospect:

1. **Linear**: List projects in `{crm.team_name}`, find the prospect's project, get status updates, issues, deal stage, health
2. **Meeting Notes**: Search `{paths.meeting_notes}` for company mentions. Extract relationship timeline, key contacts, what resonated, commitments, temperature
3. **Research**: Check `{paths.research}/{company}*.md` and `{paths.research}/Competitive/{company}*.md`
4. **Existing Content**: Check `{paths.content}/**/{company}*.md`

**Use what you find**: Content must reflect the current relationship state. If an NDA was signed, reference that. If they liked a specific feature, lead with it. If they had concerns, address them.

## Content Types

### 1. Client Meeting Deck

Slide-by-slide outline tailored to prospect's situation.

- **Slide 1: Market Opportunity** — Their market, the problem, why it matters now. Use specific numbers from product knowledge.
- **Slide 2: What {company.name} Adds** — Key capabilities from `products[]`. Emphasize 2-3 most relevant to prospect.
- **Slide 3: Architecture** — How your product integrates with their stack. Emphasize low friction (from product knowledge).
- **Slide 4: Use Cases** — Pick 1-3 most relevant to prospect from product knowledge.
- **Slide 5: {engagement_offer.name}** — Duration, scope, cost, what they get.

Adapt per prospect type. Lead with THEIR problem, not your product.

### 2. Pre-Call Briefing (Internal)

- **Background**: What they do, architecture, recent moves, backers
- **Technical Detail**: Architecture deep-dive relevant to integration
- **The Opportunity**: Their gaps → your capabilities
- **How We Work Together**: Complementary stacks, not competitive
- **Going Into the Call**: 5-6 key points to hit (not competing, gap we fill, technical fit, the ask, credibility proof, leverage)

### 3. Post-Meeting Debrief (Internal)

- **How Their Platform Works**: Technical summary from discussion
- **What We Pitched**: Exactly what was presented and how it was framed
- **Key Interests & What Resonated**: What landed, what mattered, surprises
- **Key People**: Names, roles, read on each person
- **Agreements & Process**: NDAs, intake forms, next meetings, timelines
- **Action Items**: Numbered, with owners and deadlines
- **Revenue & Commercial Model**: Any signals on commercialization

### 4. Technical Brief (Internal Engineering)

- **How They Work**: 60-second version
- **Links to Read**: Ordered reading list (start with 3, then deeper)
- **Integration Surface**: Multiple options ranked by feasibility
- **Option A**: Most likely path — detailed walkthrough
- **Option B**: Alternative with tradeoffs
- **Option C**: Long-term vision
- **PoC Recommendation**: Week-by-week breakdown

### 5. One-Pager (External)

- Lead with THEIR problem, not your product
- Use specific stats from product knowledge
- Name the specific use case
- Architecture overview
- Integration simplicity statement
- End with `{engagement_offer}` + `{contact.email}`

### 6. Competitive Positioning

When prospect is evaluating alternatives:
- Build comparison matrix from `config.competitors` + research
- For each competitor: your advantage, their advantage, key differentiator
- Frame as complementary where possible, competitive only when necessary
- Common objections + responses

## Global Output Rules

### Length & Format
- 2-3 pages max. Concise. Cut filler.
- **External docs**: Include 2-3 sentence company intro from `config.company.description`
- **All docs**: End with `{engagement_offer}` next steps + `{contact.email}`
- Every claim traceable to product knowledge. Specific numbers preferred.

### Voice
- Follow `config.brand_voice` settings throughout
- Never use words from `brand_voice.avoid_words`

### Design Language
- **Decks/Polished**: Bold stat callouts, clean section numbering, comparison tables, flow diagrams as text, key property callouts, glossary sidebars if needed
- **Internal Docs**: Clean — bold/headers/bullets, short paragraphs, lists over prose, tables for comparisons, monospace for technical, "Internal — Do Not Share" label
- **Output**: Markdown. Deck outlines include visual treatment notes. Offer Google Docs publishing if available.
