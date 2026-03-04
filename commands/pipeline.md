# /pipeline — Pipeline View & Management

## Purpose
Quick pipeline view, creation, updates, and health checks.

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use `crm.team_name` for the pipeline team. If config is missing, stop and tell the user to run `/bd setup`.

## Step 1: Parse Sub-Command

| Input | Action |
|-------|--------|
| `/pipeline` (no args) | List active deals |
| `/pipeline create` | Create new deal |
| `/pipeline update <company>` | Update existing deal |
| `/pipeline health` | Run health check |

## Step 2: Execute

Delegate to `skills/bd-pipeline/SKILL.md` with the parsed sub-command.

### List (default)
- Pull all projects from the `{crm.team_name}` team in Linear
- Show as compact table sorted by stage, then staleness:

```
| Company | Stage | Initiative | Lead | Last Updated |
```

- Flag stale deals (14+ days) with a marker
- Show total count and stage distribution

### Create
- Gather: company name, product initiative (from `config.products`), customer type, context
- Create Linear project in `{crm.team_name}` team
- Set stage to "1. Discovery Backlog", assign lead

### Update
- Search for the company's project in Linear
- Ask what to update: stage, health, notes, labels
- Apply changes

### Health Check
- Flag stale deals (14+ days no update)
- Flag stuck deals (30+ days same stage in discovery)
- Flag at-risk deals (health set to atRisk/offTrack)
- Flag deals missing key info
- Present prioritized action list
