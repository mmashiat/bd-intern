# /crm — Stakeholder & Contact Lookup

## Purpose
Look up stakeholders and contacts across deals. Quick CRM for people and companies.

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use `crm.team_name` and `paths.meeting_notes`. If config is missing, stop and tell the user to run `/bd-intern setup`.

## Step 1: Parse Query

| Input | Mode |
|-------|------|
| `/crm <company>` | List all known stakeholders at a company |
| `/crm <person name>` | Find what company a person is at and their role |
| `/crm list` | List all known contacts across pipeline |

Disambiguate: if the query matches a known company in Linear, use company mode. Otherwise, try person mode.

## Step 2: Gather Data

### Data Sources (in priority order)
1. **Linear project descriptions** — primary source for stakeholder info
2. **Meeting notes** (`{paths.meeting_notes}`) — attendees, mentioned contacts
3. **Research files** (`{paths.research}`) — Key People sections
4. **Linear status updates** — mentions of people

### Parsing
- Look for structured tables (Prospect Profile, Key People sections)
- Parse freeform text mentions of names + roles
- Extract meeting attendees from recap headers
- Check Linear project lead field

## Step 3: Output

### Company Mode
```
Contacts at {Company}
Stage: {deal stage} | Last Contact: {date}

| Name | Role | Last Seen | Context |
```

### Person Mode
```
{Person Name}
Company: {company} | Role: {role}
Deal Stage: {stage}
Last Interaction: {date} — {context}
Other Mentions: {count}
```

### List Mode
Deduped contact table grouped by deal stage:
```
| Name | Company | Role | Stage | Last Seen |
```

## Notes
- Deduplicate contacts across sources
- Flag stale contacts (no mention in 30+ days)
- Offer to update Linear if new info discovered
