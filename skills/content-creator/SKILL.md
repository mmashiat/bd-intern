---
name: content-creator
description: Create BD content — one-pagers, battle cards, case studies, partnership proposals
version: 1.0.0
---

# Content Creator

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use:
- `company.name`, `company.description` — for company context
- `products[]` — for product references
- `brand_voice` — for tone and style
- `contact.email` — for CTAs
- `pipeline.engagement_offer` — for next steps
- `paths.content` — where to save output (default: "Content/")

If config is missing, stop and tell the user to run `/bd setup`.

## Content Types

### One-Pager

1. Ask: which product, target audience, primary use case
2. Use **writer agent** with one-pager template (`references/templates/one-pager.md`)
3. Structure:
   - Header: `{product.name}` for `{audience}`
   - One-line value proposition
   - Problem (2-3 specific sentences)
   - How `{product.name}` Solves It (2-3 mechanism sentences)
   - Key Capabilities (4 bullets)
   - Under the Hood (1 paragraph technical)
   - Why Now (1-2 sentences)
   - Next Step: `{pipeline.engagement_offer}` + `{contact.email}`
4. Save to `{paths.content}/One-Pagers/{Product} for {Audience}.md`

### Battle Card

1. Ask: which competitor, which product
2. Use competitive-intel skill for research if needed
3. Format per battle card template (`references/templates/battle-card.md`)
4. Save to `{paths.content}/Battle-Cards/{Competitor} vs {Product}.md`

### Partnership Proposal

1. Gather: partner company, proposed collaboration, mutual benefits
2. Research partner if no existing research
3. Use **writer agent** to produce:
   - Executive Summary
   - About `{company.name}` (from config)
   - About {Partner} (from research)
   - Proposed Collaboration
   - Technical Integration (how products work together)
   - Mutual Benefits
   - Next Steps + Timeline
4. Save to `{paths.content}/Proposals/{Company} Partnership Proposal.md`

### Case Study Outline

1. Gather: customer, product used, use case, results
2. Structure:
   - Challenge (what problem they had)
   - Solution (how your product solved it)
   - Implementation (timeline, approach)
   - Results (quantified outcomes)
   - Quote (placeholder for customer quote)
3. Save to `{paths.content}/Case Studies/{Company} Case Study.md`

## Writing Rules
- Use templates from `references/templates/`
- Follow `config.brand_voice` settings
- Every claim needs concrete detail or number
- No buzzwords from avoid list
- Format for scanning: headers, bullets, bold key terms
- Offer Google Docs publishing if skill available
