---
name: prospect-research
description: Research a prospect company thoroughly using public sources
version: 1.0.0
---

# Prospect Research

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use:
- `products[]` — for fit assessment
- `company.name` — for positioning context
- `paths.research` — where to save output (default: "Research/")
- `competitors[]` — for competitive context

If config is missing, stop and tell the user to run `/bd-intern setup`.

## BOSS Skill Delegation
Check if a research-specific BOSS skill is installed (e.g., `research-lead`). If so, delegate.

## Step 1: Gather Context
Collect from the user:
- Company name (required)
- Relationship type: cold lead, warm intro, inbound, existing contact
- Product interest: which product(s) from config might be relevant
- Starting materials: URLs, decks, notes (optional)

## Step 2: Launch Research

Use the **researcher agent** (`agents/researcher.md`) to investigate:

### Company Overview
- Website, about page, mission
- Crunchbase: funding, investors, valuation
- LinkedIn: headcount, growth, key hires
- Press: recent news, announcements

### Product & Technology
- What they build, how it works
- Technical architecture, stack
- API/SDK documentation
- GitHub activity (repos, contributors, activity level)

### Market Position
- Market segment
- Key competitors
- Notable partnerships and customers
- Regulatory/compliance posture

### Key People
- Founders, C-suite, technical leads
- Conference talks, podcasts, blog posts
- LinkedIn profiles

## Step 3: Product Fit Assessment

Create a fit assessment table for each product in `config.products`:

```
| Product | Fit | Rationale |
|---------|-----|-----------|
| {product.name} | High/Medium/Low/Unknown | Why |
```

Identify:
- **Strongest Fit**: Which product and why
- **Recommended Approach**: How to position, what angle to lead with

## Step 4: Output

Save to `{paths.research}/{Company Name} Research.md` using the template from `references/research-template.md`.

Include:
- Research date
- Executive Summary (3-5 bullet points)
- All sections from Step 2
- Fit Assessment from Step 3
- Sources (numbered list with URLs)
- Gaps & Open Questions

## Step 5: Next Steps

Offer:
- Create Linear project via bd-pipeline skill
- Draft outreach via outreach-drafter skill
- Prep for meeting via meeting-prep skill
