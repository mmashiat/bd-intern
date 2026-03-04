---
name: bd-pipeline
description: Manage BD deal pipeline in Linear (or configured CRM)
version: 1.0.0
---

# BD Pipeline Management

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use:
- `crm.team_name` — Linear team for pipeline (default: "Partnerships")
- `crm.tool` — CRM tool (default: "linear")
- `products[]` — for product initiative options

If config is missing, stop and tell the user to run `/bd-intern setup`.

## BOSS Skill Delegation
Check if any of these BOSS skills are installed. If so, delegate the relevant operation:
- `new-lead` — for creating new pipeline entries
- `update-lead` — for updating existing entries
- Linear operations skill — for raw Linear queries

If no BOSS skills available, use Linear MCP tools directly.

## Operations

### List Active Deals

1. Use Linear MCP tools to list all projects in `{crm.team_name}` team
2. For each project, get: name, status (stage), initiative, lead, last updated date
3. Sort by stage (ascending), then by staleness (most stale first)
4. Display as table:

```
| Company | Stage | Initiative | Lead | Last Updated | Health |
|---------|-------|-----------|------|-------------|--------|
```

5. Below table, show:
   - Total active deals
   - Deals by stage (e.g., "Discovery: 5 | Delivery: 3 | Launched: 2")
   - Stale deals count (14+ days)

### Create New Deal

1. Gather info:
   - Company name (required)
   - Product initiative — which product from `config.products`? (required)
   - Customer type label (optional)
   - Context / notes (optional)
2. Create Linear project:
   - Team: `{crm.team_name}`
   - Name: Company name
   - Status: "1. Discovery Backlog"
   - Labels: Stage label + Customer type (if provided)
   - Lead: Current user
   - Description: Include product initiative, customer type, context
3. Confirm creation with project link

### Update Deal

1. Search Linear projects in `{crm.team_name}` for company name
2. If multiple matches, ask user to disambiguate
3. Ask what to update:
   - Stage (move to next/specific stage)
   - Health (on track / at risk / off track)
   - Notes (add status update)
   - Labels (add/remove)
4. Apply changes
5. Confirm with updated status

### Health Check

1. Pull all active projects from `{crm.team_name}`
2. For each, assess:
   - **Stale**: Days since last update. Flag at 14+, 21+, 30+.
   - **Stuck**: Days in current stage. Flag discovery 30+, delivery 60+.
   - **At Risk**: Health field set to atRisk or offTrack.
   - **Missing Info**: No description, no lead, no labels.
3. Present as prioritized action list:
   - Red (urgent): 30+ days stale, off track
   - Orange (soon): 21-30 days stale, at risk, stuck
   - Yellow (watch): 14-21 days stale, missing info
