# /bd-intern setup — Interactive Setup Wizard

## Purpose
Guide first-time users through creating their `config/company.yaml` file.

## Trigger
- Automatically launched when `/bd-intern` detects no `config/company.yaml`
- Manually via `/bd-intern setup`

## Behavior

### Step 1: Welcome
Display:
```
Welcome to BD Intern Agent! Let's set up your company profile.
This takes about 2 minutes. I'll create your config/company.yaml file.
```

### Step 2: Name Your Intern

1. **Intern name**: "First things first — want to give me a name? Instead of typing `/bd-intern`, you could use `/leo` or `/scout` or whatever you like. This creates a local shortcut you can use going forward."
    - If they provide a name:
      - Copy `~/.claude/skills/bd-intern/` to `~/.claude/skills/{name}/`
      - In the copied SKILL.md, update the frontmatter `name:` field to the chosen name
      - Replace all `/bd-intern` references with `/{name}` in the copied SKILL.md
      - Add the intern's name prominently in the menu header (e.g., "**{Company}** | {Name} — What do you need?")
      - Store in config as `intern.name: "{name}"`
      - Use the chosen name throughout the rest of setup (e.g., "Great, I'm {name}. Let's get you set up.")
    - If they skip, no alias is created — `/bd-intern` works as-is

### Step 3: Company Basics

2. **Company name and website**: "What's your company name and website?"
   - Use WebFetch to scrape the website — extract description, products/services, team info
   - Use WebSearch to find additional context (Crunchbase, LinkedIn, press, etc.)
   - Auto-derive: description, industry/vertical, stage, team size, AND initial product list
   - If scraping fails or info is sparse, fall back to asking directly
3. **Confirm profile**: Present what you found and ask: "Here's what I found — anything to correct or add?"
   - Show: description, industry, stage, team size, products found
   - Let them correct anything that's off

### Step 4: Products & Market

4. **Additional product links** (if needed): "I found these products on your site: {list}. Any other links I should check — landing pages, pitch decks, Product Hunt, etc.?"
   - Only ask if the website scrape in Step 3 missed products or the user wants to add more
   - Scrape additional links using WebFetch
   - Skip entirely if Step 3 already captured everything and user confirmed
5. **Example customers**: "Name 2-3 companies or people that are your ideal customers — actual names, not categories. (e.g., 'Uniswap', 'a16z', 'Shopify'). I'll use these to build out your customer segmentation."
   - Store the examples in `target_customers.examples[]`
   - Use WebSearch to research the examples and derive `target_customers.segments` — industry, size, stage, common traits
   - Generate a brief customer profile summary in `target_customers.description`
   - Confirm: "Based on those, your target segments look like {segments}. Sound right?"
6. **Deal basics**: "Roughly — what's a typical deal worth and how long does it take to close? (e.g., '$10K/month, about 3 weeks' or 'varies widely')"
   - Parse into `typical_deal_size` and `sales_cycle`
   - One question instead of two — keep it moving

### Step 5: BD & Outreach

Ask this as one block: "Quick outreach profile — fill in what applies, skip what doesn't:"

7. **Outreach profile**:
    - "Name and title?" (for signatures)
    - "Contact email for outreach?" (e.g., partnerships@yourco.com)
    - "What channels do you use?" (email, LinkedIn DMs, Twitter DMs, conferences, etc.)
    - "Do you have a standard first offer — like a free pilot, POC, or trial?"
    - Accept all answers in one message or across a few — be flexible
    - Store in `contact.*` (name, role, email, channels) and `pipeline.engagement_offer`

### Step 6: Voice & Brand

8. **Brand voice**: "How would you describe your company's tone in outreach? Pick one or describe your own:"
    - Direct and technical
    - Friendly and approachable
    - Formal and authoritative
    - Casual and conversational
    - Custom: describe
9. **Voice samples**: "Want me to really nail your tone? Paste in 2-3 old emails, Slack messages, or DMs that sound like *you*. I'll use them to calibrate how I write for you."
    - Accept any pasted text — emails, Slack messages, tweets, LinkedIn posts, etc.
    - Analyze the samples for tone, sentence length, formality, humor, vocabulary patterns
    - Store key observations in `brand_voice.samples_analysis` in the config
    - If they skip, that's fine — move on
10. **Avoid words**: "Any words or phrases you hate seeing in sales emails? (e.g., 'synergy', 'leverage', 'circle back')"
11. **Differentiator**: "In one sentence, what makes you different from competitors? This becomes your go-to positioning line."

### Step 7: Pipeline & Tools

Present this as a questionnaire. Ask: "What are the different tools that you use and for what? Check all that apply, and I'll wire them up."

12. **Tools inventory**: Present as a checklist:
    - **Communication**: Gmail, Slack, other
    - **Calendar**: Google Calendar, Outlook, other
    - **CRM**: HubSpot, Clay, Airtable, Linear, Notion, Google Sheets, Salesforce, other
    - **Project management**: Linear, Notion, Asana, Trello, other
    - **Notes**: Notion, Google Docs, Obsidian, other
    - **Custom**: "Any other tools you use day-to-day? List them and I'll check if there's an MCP integration available."
    - For each tool selected, ask what they use it for (e.g., "Gmail — outreach and follow-ups", "Airtable — deal tracking")
    - Store in `tools` section of config with tool name, category, and use case
    - For custom tools, note them and flag whether an MCP exists
13. **CRM team name**: "What's your pipeline team/workspace called? (default: Partnerships)"
14. **Meeting notes**: "Where do you store meeting notes? (default: ~/.meeting-notes/)"
15. **Slack channel**: "What Slack channel for pipeline updates? (leave blank to skip)"

### Step 8: Competitive Landscape

16. **Competitors**: "Who are your top 2-3 competitors? For each, give me a name and one line on how they compete with you."
    - Collect 2-3 competitors. Ask "Any more?" after each until they say done or skip.
17. **Win/loss insight**: "When you lose deals, what's the most common reason? (e.g., 'price', 'they already use X', 'timing')"

### Step 9: Documentation & Context

18. **Documentation and resources**: "Any docs, pitch decks, wikis, or other context I should know about? This can be links (Google Docs, Notion, GitHub) or local files. The more context I have, the better I can represent your company."
    - Accept multiple links — store in `references.documentation_links` in the config as a list
    - Mention: "You can also drop local files (PDFs, markdown, specs) into `references/product-knowledge.md` in the plugin directory anytime — I'll use them as ground truth for all sales content."
    - This single step replaces both documentation collection AND the old "product knowledge" offer

### Step 10: Daily Agenda

19. **Daily agenda**: "Last thing — want a daily morning briefing? I can scan your calendar, Slack, and email each morning and give you a quick rundown of your day — meetings, messages, and pipeline updates. I can deliver it to your terminal, Slack, email, or both."
    - If yes, ask:
      - "Where should I deliver it?" — terminal (default), slack, email, or both
      - If Slack: "What's your Slack user ID? (You can find it in your Slack profile under 'More' > 'Copy member ID')"
      - If email: confirm the contact email from Q7 is correct for delivery
    - Store preferences in `agenda.*` section of config:
      - `agenda.enabled: true`
      - `agenda.delivery: "slack"` (or "email", "both", "terminal")
      - `agenda.slack_user_id: "U..."` (if Slack selected)
      - `agenda.time: "8:00 AM"` (default)
    - Install the agenda skill: copy `skills/agenda/SKILL.md` from the plugin directory to `~/.claude/skills/agenda/SKILL.md`
    - If they skip, set `agenda.enabled: false` and move on

### Step 11: Generate Config

Write the collected information to `config/company.yaml` in the plugin directory, following the structure of `config/company.example.yaml`.

Map the answers:
- Question 1 → `intern.name`
- Questions 2-3 → `company.*` section (name, website, description, industry, stage, team_size — mostly auto-derived from scraping)
- Question 4 → `products[]` (scraped from links, or manually entered)
- Question 5 → `target_customers.examples[]`, `target_customers.segments`, `target_customers.description`
- Question 6 → `typical_deal_size`, `sales_cycle`
- Question 7 → `contact.*` (name, role, email, channels) and `pipeline.engagement_offer`
- Questions 8-11 → `brand_voice.*` section (tone, samples_analysis, avoid_words, differentiator)
- Question 12 → `tools[]` section (each with name, category, use_case, has_mcp)
- Questions 13-15 → `crm.*` and `paths.*` and `integrations.*`
- Questions 16-17 → `competitors[]` and `common_loss_reasons`
- Question 18 → `references.documentation_links[]`
- Question 19 → `agenda.*` section (enabled, delivery, slack_user_id, time)

Use proper YAML formatting. Include comments for sections they skipped.

### Step 12: Confirm

Display:
```
Config saved to config/company.yaml!

Here's your profile:
- Intern: {name or "bd-intern (default)"}
- Company: {name} ({industry}, {stage}, ~{team_size} people)
- Products: {list}
- Target: {target_customers.description} (examples: {examples})
- Deal: {typical_deal_size}, ~{sales_cycle} cycle
- Contact: {name}, {role} ({email})
- Channels: {channels list}
- Engagement offer: {engagement_offer}
- Voice: {tone}
- Avoid: {avoid_words list}
- Differentiator: {differentiator}
- Tools: {tools list}
- Competitors: {list}
- Docs: {documentation_links count} links saved
- Agenda: {enabled — delivery channel} | {disabled}

Try these commands:
- /{intern_name or "bd-intern"} pipeline — View your deal pipeline
- /prospect <company> — Research a prospect
- /outreach <company> — Draft outreach
- /agenda — Morning briefing (if enabled)

Run /{intern_name or "bd-intern"} setup anytime to reconfigure.
```

If the user created an alias, also install the agenda skill under the alias-friendly name (it stays as `/agenda` regardless).

## Notes
- Be conversational, not form-like — this should feel like an onboarding chat, not a form
- Accept brief answers — don't force long descriptions
- If they seem impatient or say "skip" / "defaults", jump to generating config with sensible defaults for anything unanswered
- Group questions naturally — don't rapid-fire all 19. Pause between sections with a brief transition like "Great. Now let's talk about your products." or "Almost done — a few questions about your pipeline."
- The config file should be valid YAML that loads without errors
- If a question doesn't apply (e.g., no competitors yet, no Slack), skip gracefully
