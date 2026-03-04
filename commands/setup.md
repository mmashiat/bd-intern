# /bd setup — Interactive Setup Wizard

## Purpose
Guide first-time users through creating their `config/company.yaml` file.

## Trigger
- Automatically launched when `/bd` detects no `config/company.yaml`
- Manually via `/bd setup`

## Behavior

### Step 1: Welcome
Display:
```
Welcome to BD Intern Agent! Let's set up your company profile.
This takes about 2 minutes. I'll create your config/company.yaml file.
```

### Step 2: Collect Required Fields

Ask these questions one at a time, conversationally:

1. **Company name**: "What's your company name?"
2. **Website**: "What's your company website?"
3. **Description**: "Give me a 1-2 sentence description of what your company does."
4. **Products**: "What products/services do you sell? For each, give me a name and brief description."
   - Collect at least one. Ask "Any more?" after each until they say no.
5. **Contact email**: "What email should go on outreach materials? (e.g., partnerships@yourco.com)"

### Step 3: Optional Fields

Ask: "Want to customize optional settings? (brand voice, competitors, paths, engagement offer) Or use sensible defaults?"

If they want to customize:
- **Brand voice**: "How would you describe your company's tone? (e.g., 'direct and technical', 'friendly and approachable')"
- **Avoid words**: "Any words or phrases to avoid in outreach?"
- **CRM team name**: "What's your pipeline team called in Linear? (default: Partnerships)"
- **Meeting notes path**: "Where do you store meeting notes? (default: ~/.meeting-notes/)"
- **Engagement offer**: "Do you have a standard engagement offer (like a pilot program)? Describe it briefly."
- **Competitors**: "Who are your main competitors? (name and brief notes for each)"
- **Slack channel**: "What Slack channel for pipeline updates? (e.g., #bd-pipeline)"

### Step 4: Generate Config

Write the collected information to `config/company.yaml` in the plugin directory, following the structure of `config/company.example.yaml`.

Use proper YAML formatting. Include comments for sections they skipped.

### Step 5: Confirm

Display:
```
Config saved to config/company.yaml!

You're all set. Here's what I configured:
- Company: {name}
- Products: {list}
- Contact: {email}
- Voice: {tone or "default (direct, specific)"}

Try these commands:
- /bd pipeline — View your deal pipeline
- /prospect <company> — Research a prospect
- /outreach <company> — Draft outreach

Run /bd setup anytime to reconfigure.
```

### Step 6: Offer Product Knowledge

Ask: "Do you have detailed product documentation you'd like me to reference for sales content? If so, you can add a `references/product-knowledge.md` file to the plugin directory later."

## Notes
- Be conversational, not form-like
- Accept brief answers — don't force long descriptions
- If they seem impatient, skip to defaults quickly
- The config file should be valid YAML that loads without errors
