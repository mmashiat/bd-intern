# BOSS Integration (Optional)

BOSS (Business Operations Skill Sharing) is a team skill-sharing system. If your team uses BOSS, BD Intern can delegate to shared skills for common operations.

## What is BOSS?

- Shared skills live in `~/.boss/repo/`
- Installed skills in `~/.claude/skills/`
- Skills follow a standard format (YAML frontmatter + markdown instructions)

## Skill Delegation

When a BOSS skill covers an operation that BD Intern would handle, delegate to the BOSS skill instead. This ensures consistency across your team.

| BD Intern Operation | Potential BOSS Skill |
|--------------------|---------------------|
| Linear operations | Your team's Linear skill |
| New lead creation | `new-lead` |
| Lead updates | `update-lead` |
| Prospect research | `research-lead` |
| Meeting processing | `meeting-recap` |
| Comparative analysis | `comparative-research` |
| Internal comms | `internal-comms` |

## Delegation Rules

1. **If BOSS skill covers the full task** → Delegate entirely
2. **If BOSS skill covers part of the task** → Use it for that part, handle the rest
3. **If no BOSS skill available** → Use BD Intern's built-in skills
4. **Never modify BOSS skills** — they're shared across your team

## Producing BOSS Skills

BD Intern skills follow BOSS format (YAML frontmatter). You can share them:
- `/boss share <skill-name>` to share a skill with your team
- Add `private: true` to frontmatter for sensitive/company-specific skills

## Skill Discovery

- `/boss list` — See installed skills
- `/boss what's new` — Check for new shared skills
- `/boss install <skill>` — Install a shared skill

## Configuration

BOSS integration is enabled by default if BOSS skills are detected. No configuration needed.
