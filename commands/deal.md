# /deal <company> — Deal Brief

## Purpose
Generate a comprehensive deal summary synthesizing all available intelligence.

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use company products and engagement offer. If config is missing, stop and tell the user to run `/bd setup`.

## Step 1: Identify Deal
- Company name from argument
- Search Linear for the company's project in `{crm.team_name}` team
- If not found, ask if they want to create one via `/pipeline create`

## Step 2: Execute
Delegate to `skills/deal-brief/SKILL.md` with company name and Linear project info.

## Step 3: Output
Deal brief includes:
- Executive Summary
- Company Overview
- Relationship Timeline
- Deal Status (stage, health, blockers)
- Value Proposition (which product, specific fit)
- Competitive Landscape
- Open Items
- Risk Assessment
- Recommended Next Steps
