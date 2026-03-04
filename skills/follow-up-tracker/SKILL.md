---
name: follow-up-tracker
description: Track and surface action items across all deals
version: 1.0.0
---

# Follow-Up Tracker

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use:
- `crm.team_name` — for Linear queries
- `paths.meeting_notes` — for meeting note scanning

If config is missing, stop and tell the user to run `/bd setup`.

## Modes

### Scan All Deals

1. Pull all projects from `{crm.team_name}` team in Linear
2. For each project:
   - Read latest status updates
   - Search `{paths.meeting_notes}` for recent notes mentioning company
3. Extract action items from:
   - Meeting notes (look for "action items", "next steps", "TODO", "follow up")
   - Linear status updates
   - Linear issues linked to the project
4. Classify each item:
   - **Overdue**: Has a date that's passed
   - **Due Soon**: Due within 7 days
   - **On Track**: Due later
   - **No Date**: Action item with no deadline assigned
5. Present consolidated view:

```
## Overdue ({count})
| Company | Action Item | Due Date | Days Overdue | Source |

## Due This Week ({count})
| Company | Action Item | Due Date | Source |

## No Deadline Set ({count})
| Company | Action Item | Source |
```

### Single Deal

1. Ask for company name
2. Pull all meeting notes + Linear updates for that company
3. Build chronological action item list:
   - When it was created (which meeting/update)
   - Status (done / overdue / pending / no date)
   - Owner (if assigned)
4. Flag overdue and undated items
5. Offer to update Linear (create issues, update health)

### Flag in Linear

For overdue items, offer to:
- Create Linear issues for untracked action items
- Update project health to "atRisk" if multiple items overdue
- Add status update noting overdue items
- Set due dates on undated items
