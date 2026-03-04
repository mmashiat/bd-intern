# Linear Conventions for BD Pipeline

How the BD pipeline maps to Linear concepts.

## Hierarchy

| Linear Concept | BD Mapping |
|----------------|-----------|
| Initiative | Product line or strategic category |
| Project | One deal / one company (one project per lead) |
| Issue | Individual task or action item within a deal |

## Team

BD pipeline lives in the team specified by `crm.team_name` in config (default: "Partnerships").

## Project Statuses (Deal Stages)

### Discovery
- **1. Discovery Backlog** — New lead, no conversation yet
- **2. Discovery Active** — In conversations
- **3. Discovery Done** — Qualified, ready for engagement

### Delivery
- **4. Delivery Backlog** — Engagement agreed, not started
- **5. Delivery Active** — Active integration/project work
- **6. Delivery Review** — Work complete, in review
- **7. Delivery Done** — Approved, preparing to launch
- **8. Launched** — Live in production

### Terminal
- **Blocked** — Stalled (add reason)
- **Abandoned** — Dead (add post-mortem)
- **Archived Done** — Completed, archived

## Labels

### Stage Labels
- 1. Lead
- 2. Qualified
- 3. Proposal
- 4. Negotiation
- 5. Committed
- 6. Closed Won

### Customer Type Labels
Customize per your industry. Examples:
- Enterprise
- Mid-Market
- Startup
- Partner
- (Add your own based on config)

## Issue Statuses

For individual tasks within deals:
- Triage → Backlog → Todo → In Progress → In Review → Blocked → Done → Canceled → Duplicate

## Common Operations

### List all projects in BD team
Use Linear MCP tools to list projects filtered by team name.

### Create new deal
Create project in team with:
- Name: Company name
- Status: "1. Discovery Backlog"
- Labels: Stage + Customer Type
- Lead: Assign to user
- Description: Product interest, context, key contacts

### Move deal stage
Update project status to the next stage label.

### Add status update
Create a status update on the project with notes about recent activity.

### Search for a company
Search projects by name within the BD team.
