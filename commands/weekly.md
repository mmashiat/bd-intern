# /weekly — Weekly Pipeline Review

## Purpose
Run a weekly pipeline health digest across all active deals.

## Step 0: Load Config
Read `config/company.yaml` from the bd-intern plugin directory. Use `crm.team_name` and `integrations.slack_channel`. If config is missing, stop and tell the user to run `/bd-intern setup`.

## Step 1: Parse Options

| Input | Action |
|-------|--------|
| `/weekly` | Generate full digest |
| `/weekly slack` | Generate digest + post condensed version to Slack |

## Step 2: Execute
Delegate to `skills/weekly-pipeline-review/SKILL.md`.

## Step 3: Output
Save digest to `{paths.meeting_notes}/_weekly-digests/Pipeline Review {date}.md`.

If `/weekly slack` was used, post a condensed summary to `{integrations.slack_channel}`.
