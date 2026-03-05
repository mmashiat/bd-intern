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

### Step 2: Company Basics

1. **Company name and website**: "What's your company name and website?"
   - Use WebFetch to scrape the website — extract description, products/services, team info
   - Use WebSearch to find additional context (Crunchbase, LinkedIn, press, etc.)
   - Auto-derive: description, industry/vertical, stage, team size, AND initial product list
   - If scraping fails or info is sparse, fall back to asking directly
2. **Confirm profile**: Present what you found and ask: "Here's what I found — anything to correct or add?"
   - Show: description, industry, stage, team size, products found
   - Let them correct anything that's off

### Step 3: Products & Market

3. **Additional product links** (if needed): "I found these products on your site: {list}. Any other links I should check — landing pages, pitch decks, Product Hunt, etc.?"
   - Only ask if the website scrape in Step 2 missed products or the user wants to add more
   - Scrape additional links using WebFetch
   - Skip entirely if Step 2 already captured everything and user confirmed
4. **Example customers**: "Name 2-3 companies or people that are your ideal customers — actual names, not categories. (e.g., 'Uniswap', 'a16z', 'Shopify'). I'll use these to build out your customer segmentation."
   - Store the examples in `target_customers.examples[]`
   - Use WebSearch to research the examples and derive `target_customers.segments` — industry, size, stage, common traits
   - Generate a brief customer profile summary in `target_customers.description`
   - Confirm: "Based on those, your target segments look like {segments}. Sound right?"
5. **Deal basics**: "Roughly — what's a typical deal worth and how long does it take to close? (e.g., '$10K/month, about 3 weeks' or 'varies widely')"
   - Parse into `typical_deal_size` and `sales_cycle`
   - One question instead of two — keep it moving

### Step 4: BD & Outreach

Ask this as one block: "Quick outreach profile — fill in what applies, skip what doesn't:"

6. **Outreach profile**:
    - "Name and title?" (for signatures)
    - "Contact email for outreach?" (e.g., partnerships@yourco.com)
    - "What channels do you use?" (email, LinkedIn DMs, Twitter DMs, conferences, etc.)
    - "Do you have a standard first offer — like a free pilot, POC, or trial?"
    - Accept all answers in one message or across a few — be flexible
    - Store in `contact.*` (name, role, email, channels) and `pipeline.engagement_offer`

### Step 5: Voice & Brand

7. **Brand voice**: "How would you describe your company's tone in outreach? Pick one or describe your own:"
    - Direct and technical
    - Friendly and approachable
    - Formal and authoritative
    - Casual and conversational
    - Custom: describe
8. **Voice samples**: "Want me to really nail your tone? Paste in 2-3 old emails, Slack messages, or DMs that sound like *you*. I'll use them to calibrate how I write for you."
    - Accept any pasted text — emails, Slack messages, tweets, LinkedIn posts, etc.
    - Analyze the samples for tone, sentence length, formality, humor, vocabulary patterns
    - Store key observations in `brand_voice.samples_analysis` in the config
    - If they skip, that's fine — move on
9. **Avoid words**: "Any words or phrases you hate seeing in sales emails? (e.g., 'synergy', 'leverage', 'circle back')"
10. **Differentiator**: "In one sentence, what makes you different from competitors? This becomes your go-to positioning line."

### Step 6: Pipeline & Tools

Present this as a questionnaire. Ask: "What are the different tools that you use and for what? Check all that apply, and I'll wire them up."

11. **Tools inventory**: Present as a checklist:
    - **Communication**: Gmail, Slack, other
    - **Calendar**: Google Calendar, Outlook, other
    - **CRM**: HubSpot, Clay, Airtable, Linear, Notion, Google Sheets, Salesforce, other
    - **Project management**: Linear, Notion, Asana, Trello, other
    - **Notes**: Notion, Google Docs, Obsidian, other
    - **Custom**: "Any other tools you use day-to-day? List them and I'll check if there's an MCP integration available."
    - For each tool selected, ask what they use it for (e.g., "Gmail — outreach and follow-ups", "Airtable — deal tracking")
    - Store in `tools` section of config with tool name, category, and use case
    - For custom tools, note them and flag whether an MCP exists
12. **CRM team name**: "What's your pipeline team/workspace called? (default: Partnerships)"
13. **Meeting notes**: "Where do you store meeting notes? (default: ~/.meeting-notes/)"
14. **Slack channel**: "What Slack channel for pipeline updates? (leave blank to skip)"

### Step 7: Competitive Landscape

15. **Competitors**: "Who are your top 2-3 competitors? For each, give me a name and one line on how they compete with you."
    - Collect 2-3 competitors. Ask "Any more?" after each until they say done or skip.
16. **Win/loss insight**: "When you lose deals, what's the most common reason? (e.g., 'price', 'they already use X', 'timing')"

### Step 8: Documentation & Context

17. **Documentation and resources**: "Last thing — any docs, pitch decks, wikis, or other context I should know about? This can be links (Google Docs, Notion, GitHub) or local files. The more context I have, the better I can represent your company."
    - Accept multiple links — store in `references.documentation_links` in the config as a list
    - Mention: "You can also drop local files (PDFs, markdown, specs) into `references/product-knowledge.md` in the plugin directory anytime — I'll use them as ground truth for all sales content."
    - This single step replaces both documentation collection AND the old "product knowledge" offer

### Step 9: Generate Config

Write the collected information to `config/company.yaml` in the plugin directory, following the structure of `config/company.example.yaml`.

Map the answers:
- Questions 1-2 → `company.*` section (name, website, description, industry, stage, team_size — mostly auto-derived from scraping)
- Question 3 → `products[]` (scraped from links, or manually entered)
- Question 4 → `target_customers.examples[]`, `target_customers.segments`, `target_customers.description`
- Question 5 → `typical_deal_size`, `sales_cycle`
- Question 6 → `contact.*` (name, role, email, channels) and `pipeline.engagement_offer`
- Questions 7-10 → `brand_voice.*` section (tone, samples_analysis, avoid_words, differentiator)
- Question 11 → `tools[]` section (each with name, category, use_case, has_mcp)
- Questions 12-14 → `crm.*` and `paths.*` and `integrations.*`
- Questions 15-16 → `competitors[]` and `common_loss_reasons`
- Question 17 → `references.documentation_links[]`

Use proper YAML formatting. Include comments for sections they skipped.

### Step 10: Confirm

Display:
```
Config saved to config/company.yaml!

Here's your profile:
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

Try these commands:
- /bd-intern pipeline — View your deal pipeline
- /prospect <company> — Research a prospect
- /outreach <company> — Draft outreach

Run /bd-intern setup anytime to reconfigure.
```

## Notes
- Be conversational, not form-like — this should feel like an onboarding chat, not a form
- Accept brief answers — don't force long descriptions
- If they seem impatient or say "skip" / "defaults", jump to generating config with sensible defaults for anything unanswered
- Group questions naturally — don't rapid-fire all 17. Pause between sections with a brief transition like "Great. Now let's talk about your products." or "Almost done — a few questions about your pipeline."
- The config file should be valid YAML that loads without errors
- If a question doesn't apply (e.g., no competitors yet, no Slack), skip gracefully
