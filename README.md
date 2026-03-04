# BD Intern Agent

A configurable BD (Business Development) agent for [Claude Code](https://claude.com/claude-code). Automates prospect research, outreach drafting, deal pipeline management, meeting prep, competitive analysis, and content creation.

**Works for any company** — configure once with your company details, products, and voice, then use immediately.

## Quick Start

### 1. Install

```bash
git clone https://github.com/mmashiat/bd-intern.git ~/.claude/plugins/bd-intern
```

### 2. Configure

Start Claude Code and run:

```
/bd-intern setup
```

The setup wizard walks you through creating your `config/company.yaml`. Takes ~2 minutes.

Or copy the example and edit manually:

```bash
cp ~/.claude/plugins/bd-intern/config/company.example.yaml ~/.claude/plugins/bd-intern/config/company.yaml
```

### 3. Use

```
/bd-intern                   # Main menu
/pipeline                    # View your deal pipeline
/prospect <company>          # Research a prospect
/outreach <company>          # Draft outreach messages
/prep <company>              # Meeting prep briefing
/weekly                      # Weekly pipeline review
/deal <company>              # Deal brief
/crm <company or person>     # Stakeholder lookup
/sales-enablement            # Decks, briefings, one-pagers
```

## What It Does

| Feature | Description |
|---------|-------------|
| **Prospect Research** | Deep-dives on companies using public sources. Produces structured research docs with product fit assessment. |
| **Outreach Drafting** | Personalized cold emails, DMs, and follow-ups grounded in research and meeting history. |
| **Pipeline Management** | View, create, and update deals in Linear. Health checks flag stale and at-risk deals. |
| **Meeting Prep** | Briefing docs with company snapshot, relationship history, talking points, and strategic questions. |
| **Weekly Review** | Pipeline health digest — what moved, what's stale, what needs attention. |
| **Deal Briefs** | Comprehensive deal summaries synthesizing all intelligence. |
| **CRM Lookup** | Find contacts and stakeholders across your pipeline. |
| **Sales Enablement** | Meeting decks, pre-call briefings, post-meeting debriefs, technical briefs, one-pagers, competitive positioning. |
| **Competitive Intel** | Competitor profiles, landscape maps, and battle cards. |
| **Follow-Up Tracking** | Surfaces overdue action items across all deals. |

## Configuration

All company-specific settings live in `config/company.yaml` (gitignored). See `config/company.example.yaml` for full documentation.

### Required Fields
- `company.name`, `company.website`, `company.description`
- `products[]` — at least one product with name and description
- `contact.email`

### Optional Fields
- `brand_voice` — tone, personality traits, words to avoid/prefer
- `crm.team_name` — Linear team name (default: "Partnerships")
- `paths.meeting_notes` — where meeting notes live (default: `~/.meeting-notes/`)
- `pipeline.engagement_offer` — your standard pilot/POC offer
- `competitors[]` — known competitors for positioning
- `integrations.slack_channel` — for pipeline update posts

### Product Knowledge

For rich sales enablement content, add a `references/product-knowledge.md` file with detailed product documentation. The sales-enablement skill uses this as ground truth — it won't make claims not documented here.

## Architecture

```
commands/     → User-facing commands (routing + UX)
skills/       → Execution logic (one skill per capability)
agents/       → Specialized sub-agents (researcher, writer, analyst, reviewer)
references/   → Templates, conventions, pipeline stages
config/       → Company-specific configuration
hooks/        → Session startup context loading
examples/     → Example configs and outputs using fictional companies
```

### How It Works

1. Every command loads `config/company.yaml` first
2. Commands delegate to skills for execution
3. Skills use agents for specialized work (web research, content writing, analysis)
4. All output uses your configured brand voice, products, and engagement offer
5. Pipeline state tracked in Linear (or configured CRM)

## BOSS Integration (Optional)

If your team uses [BOSS](https://github.com/zkmash/boss) for skill sharing, BD Intern delegates to installed BOSS skills when available. No configuration needed — it auto-detects.

## Examples

The `examples/` directory contains sample configs and outputs using fictional companies:
- `example-config-saas.yaml` — SaaS payment company (NovaPay)
- `example-config-devtools.yaml` — Developer tools company (Lattice Labs)
- `example-research.md` — Prospect research output
- `example-outreach.md` — Cold email drafts
- `example-meeting-prep.md` — Meeting prep briefing

## Updating

BD Intern auto-updates on every `/bd-intern` invocation (silent `git pull`). Manual update:

```bash
cd ~/.claude/plugins/bd-intern && git pull
```

## License

MIT
