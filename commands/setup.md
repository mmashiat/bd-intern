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

Ask these questions one at a time, conversationally:

1. **Company name**: "What's your company name?"
2. **Website**: "What's your company website?"
3. **Description**: "Give me a 1-2 sentence description of what your company does. What problem do you solve, and for whom?"
4. **Industry/vertical**: "What industry or vertical are you in? (e.g., fintech, developer tools, healthcare, SaaS)"
5. **Stage**: "What stage is your company at? (e.g., pre-seed, Series A, growth, public)"
6. **Team size**: "Roughly how big is your team? (e.g., 5, 50, 500)"

### Step 3: Products & Market

7. **Products**: "What products/services do you sell? For each, give me a name and brief description."
   - Collect at least one. Ask "Any more?" after each until they say no.
8. **Target customers**: "Who's your ideal customer? (e.g., 'enterprise SaaS companies', 'crypto protocols', 'mid-market retailers')"
9. **Deal size**: "What's a typical deal worth? (e.g., '$10K/year', '$50K pilot', 'usage-based — varies'). This helps me calibrate outreach tone."
10. **Sales cycle**: "How long does a typical deal take from first contact to close? (e.g., '2 weeks', '3 months', '6+ months')"

### Step 4: BD & Outreach

11. **Contact email**: "What email should go on outreach materials? (e.g., partnerships@yourco.com)"
12. **Your name & role**: "What's your name and title? (for email signatures)"
13. **Engagement offer**: "Do you have a standard first offer — like a free pilot, POC, or trial? Describe it briefly. (If not, I'll skip this.)"
14. **Outreach channels**: "What channels do you typically use for outreach? (e.g., email, LinkedIn DMs, Twitter DMs, conference networking)"

### Step 5: Voice & Brand

15. **Brand voice**: "How would you describe your company's tone in outreach? Pick one or describe your own:"
    - Direct and technical
    - Friendly and approachable
    - Formal and authoritative
    - Casual and conversational
    - Custom: describe
16. **Avoid words**: "Any words or phrases you hate seeing in sales emails? (e.g., 'synergy', 'leverage', 'circle back')"
17. **Differentiator**: "In one sentence, what makes you different from competitors? This becomes your go-to positioning line."

### Step 6: Pipeline & Tools

18. **CRM tool**: "What do you use to track deals? (Linear, Notion, spreadsheet, nothing yet)"
19. **CRM team name**: "What's your pipeline team/workspace called? (default: Partnerships)"
20. **Meeting notes**: "Where do you store meeting notes? (default: ~/.meeting-notes/)"
21. **Slack channel**: "What Slack channel for pipeline updates? (leave blank to skip)"

### Step 7: Competitive Landscape

22. **Competitors**: "Who are your top 2-3 competitors? For each, give me a name and one line on how they compete with you."
    - Collect until they say done or skip.
23. **Win/loss insight**: "When you lose deals, what's the most common reason? (e.g., 'price', 'they already use X', 'timing')"

### Step 8: Generate Config

Write the collected information to `config/company.yaml` in the plugin directory, following the structure of `config/company.example.yaml`.

Map the answers:
- Questions 1-6 → `company.*` section (name, website, description, plus `industry`, `stage`, `team_size` as extra fields)
- Questions 7-10 → `products[]`, `target_customers`, `typical_deal_size`, `sales_cycle`
- Questions 11-14 → `contact.*` section (email, name, role, channels)
- Question 13 → `pipeline.engagement_offer`
- Questions 15-17 → `brand_voice.*` section (tone, avoid_words, differentiator)
- Questions 18-21 → `crm.*` and `paths.*` and `integrations.*`
- Questions 22-23 → `competitors[]` and `common_loss_reasons`

Use proper YAML formatting. Include comments for sections they skipped.

### Step 9: Confirm

Display:
```
Config saved to config/company.yaml!

Here's your profile:
- Company: {name} ({industry}, {stage})
- Products: {list}
- Target: {target_customers}
- Contact: {name} ({email})
- Voice: {tone}
- Differentiator: {differentiator}
- Competitors: {list}

Try these commands:
- /bd-intern pipeline — View your deal pipeline
- /prospect <company> — Research a prospect
- /outreach <company> — Draft outreach

Run /bd-intern setup anytime to reconfigure.
```

### Step 10: Offer Product Knowledge

Ask: "One last thing — do you have detailed product docs, pitch decks, or technical specs? If you drop them into `references/product-knowledge.md` in the plugin directory, I'll use them as ground truth for all sales content. You can do this now or later."

## Notes
- Be conversational, not form-like — this should feel like an onboarding chat, not a form
- Accept brief answers — don't force long descriptions
- If they seem impatient or say "skip" / "defaults", jump to generating config with sensible defaults for anything unanswered
- Group questions naturally — don't rapid-fire all 23. Pause between sections with a brief transition like "Great. Now let's talk about your products." or "Almost done — a few questions about your pipeline."
- The config file should be valid YAML that loads without errors
- If a question doesn't apply (e.g., no competitors yet, no Slack), skip gracefully
