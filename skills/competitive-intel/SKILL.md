---
name: competitive-intel
description: Competitive landscape analysis and battle cards
version: 1.0.0
---

# Competitive Intelligence

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use:
- `company.name`, `products[]` — for positioning
- `competitors[]` — for known competitors
- `paths.research` — for saving output

If config is missing, stop and tell the user to run `/bd-intern setup`.

## Modes

### Single Competitor Profile

1. Ask: company name + which of your products they compete with
2. Use **analyst agent** (`agents/analyst.md`) to research:
   - Company overview (what they do, size, funding, team)
   - Product and technology (architecture, features, pricing)
   - Customers and partnerships
   - Strengths vs. your product
   - Weaknesses vs. your product
   - Recent moves (last 90 days)
3. Save to `{paths.research}/Competitive/{Company} Profile.md`

### Landscape Map

1. Ask: which product from `config.products` to map
2. Use **analyst agent** to produce:
   - Market segments relevant to this product
   - Key competitors by segment
   - Emerging players
   - Your product's differentiation
   - Gaps in your positioning
3. Save to `{paths.research}/Competitive/{Product} Landscape.md`

### Battle Card

1. Pull from existing competitor profile or research fresh
2. Format as one-page quick reference:

```
# {Competitor} vs. {Your Product} — Battle Card
Last Updated: {date}

## Them in Two Sentences
{concise description}

## Their Pitch
{how they position themselves}

## Our Pitch Against Them
{how to position against them}

## Where They Win
- {advantage 1}
- {advantage 2}

## Where We Win
- {advantage 1}
- {advantage 2}
- {advantage 3}

## Common Objections
| Objection | Response |
|-----------|----------|

## Trap Questions
{questions they might ask that are hard to answer}

## Key Differentiators
| Dimension | Us | Them |
|-----------|-----|------|

## Deal Intelligence
{what we know about deals where they competed}
```

3. Save to `{paths.research}/Competitive/{Company} Battle Card.md`

## Freshness
- Note research date on all documents
- Flag if any competitive intel is >90 days old
- Offer to refresh stale profiles
