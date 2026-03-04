#!/bin/bash
# BD Intern Agent — Session Start Hook
# Checks for available resources and reports context

PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONFIG="$PLUGIN_DIR/config/company.yaml"

echo "--- BD Intern Agent ---"

# Check for config
if [ ! -f "$CONFIG" ]; then
  echo "⚠ No config found. Run /bd-intern setup to configure."
  exit 0
fi

# Extract company name from config (basic yaml parsing)
COMPANY=$(grep "^  name:" "$CONFIG" | head -1 | sed 's/.*name: *"\?\([^"]*\)"\?/\1/' | xargs)
if [ -n "$COMPANY" ]; then
  echo "Company: $COMPANY"
fi

# Check for meeting notes
MEETING_NOTES=$(grep "meeting_notes:" "$CONFIG" 2>/dev/null | sed 's/.*: *"\?\([^"]*\)"\?/\1/' | xargs)
MEETING_NOTES="${MEETING_NOTES:-$HOME/.meeting-notes}"
MEETING_NOTES="${MEETING_NOTES/#\~/$HOME}"

if [ -d "$MEETING_NOTES" ]; then
  RECENT=$(find "$MEETING_NOTES" -name "*.md" -mtime -7 2>/dev/null | wc -l | xargs)
  echo "Meeting notes: $MEETING_NOTES ($RECENT updated in last 7 days)"
fi

# Check for research directory
RESEARCH=$(grep "research:" "$CONFIG" 2>/dev/null | sed 's/.*: *"\?\([^"]*\)"\?/\1/' | xargs)
RESEARCH="${RESEARCH:-Research}"

if [ -d "$RESEARCH" ]; then
  COUNT=$(find "$RESEARCH" -name "*.md" 2>/dev/null | wc -l | xargs)
  echo "Research files: $COUNT available"
fi

echo "---"
