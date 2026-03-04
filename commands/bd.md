# /bd — Main Router

## Purpose
Entry point for all BD Intern operations. Routes to sub-commands or shows menu.

## Step 0: Load Config

Check if `config/company.yaml` exists in the bd-intern plugin directory.

- **If missing**: Launch setup wizard (`commands/setup.md`). Do not proceed until config is created.
- **If present**: Load config and continue.

## Step 1: Auto-Update (Silent)

Run a silent `git pull --rebase` in the plugin directory. Do not show output unless there's an error.

## Step 2: Route

Parse the user's input after `/bd`:

| Input | Route to |
|-------|----------|
| (nothing) | Show menu (Step 3) |
| `setup` | `commands/setup.md` |
| `pipeline` or `pipe` | `commands/pipeline.md` |
| `prospect <company>` | `commands/prospect.md` |
| `outreach <company>` | `commands/outreach.md` |
| `prep <company>` | `commands/prep.md` |
| `weekly` | `commands/weekly.md` |
| `deal <company>` | `commands/deal.md` |
| `crm <query>` | `commands/crm.md` |
| `sales-enablement` or `se` | `commands/sales-enablement.md` |
| Other | Interpret intent and route to best match |

## Step 3: Menu (if no sub-command)

Display:

```
BD Intern — {company.name}

Commands:
  /pipeline              Pipeline view & management
  /prospect <company>    Research a prospect
  /outreach <company>    Draft outreach messages
  /prep <company>        Meeting prep briefing
  /weekly                Weekly pipeline review
  /deal <company>        Deal brief
  /crm <query>           Stakeholder & contact lookup
  /sales-enablement      Decks, briefings, debriefs

  /bd setup              Reconfigure company profile

What would you like to do?
```

## Step 4: Proactive Checks

After showing the menu, briefly check:
1. Any deals with no update in 14+ days? Mention them.
2. Any overdue action items from recent meeting notes? Surface them.
3. Any upcoming meetings this week? Offer to prep.

Keep this to 2-3 lines max. Don't overwhelm.
