# AGENTS.md
## Purpose
Code project repository for DeepSqueak.
## Folder map
.github/workflows/weekly-agent.yml - Weekly automation
## Run and test
none
## Start of every run
1. Read AGENT_TASK_LOG.md (Summary first, then In Progress).
2. Claim a task with a UTC ISO 8601 timestamp under In Progress. Other agents can override this lock if idle > 24h.
3. Do not duplicate another agent's active work.
## Agent roles
- Claude: Hard tasks, but allowed to do easier tasks if invoked directly.
- Gemini / Antigravity: Hard tasks, complex code, architecture, GUI polish.
- Codex: small bug fixes, tests, typos.
- Copilot: in-editor edits and small completions.
- Perplexity: literature and web research.
## Rules
- Keep patches small. Keep the GUI and app intuitive.
- Update the HTML manual and tutorial when user-visible behavior changes.
- Fix bugs directly in the code if you are really sure, otherwise leave a note.
- Important work (data analysis, mathematical calculations) needs review by a different agent before merge. Verify every number twice with different methods and report it only if both agree. Never auto-merge these; require a PR/Branch.
## Style
Strictly use hyphens only (no em dashes, no en dashes). Concise. Cite exact files, pages or sections. State if a file was not fully read.
## End of every run
Append a report to AGENT_TASK_LOG.md: what you did, files changed, next steps. Update the Summary.
