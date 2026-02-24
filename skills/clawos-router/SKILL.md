# ClawOS Router Skill

## Metadata
- skill_name: clawos-router
- version: 1.0.0
- required_tools: qmd, memory_search

## Purpose
Low-token routing to ClawOS institutional memory.

## Input Schema
```json
{
  "task_type": "string (status|check|edit|deploy|write)",
  "project": "string",
  "client": "string",
  "stakes": "string (low|medium|high)"
}
```

## Output Schema
```json
{
  "allowed_paths": ["array of path strings"],
  "retrieval_mode": "string (fast|normal|strict)",
  "maxResults": "number",
  "injectedCharCap": "number",
  "write_policy": "string (none|review-queue|approval)"
}
```

## Routing Logic

### FAST mode (no retrieval)
type: status, check, brainstorm
maxResults: 0
injectedCharCap: 0
write_policy: none

### NORMAL mode (light retrieval)
type: show, list
stakes: low, medium
maxResults: 4
injectedCharCap: 1400
write_policy: review-queue

### STRICT mode (full retrieval)
type: edit, modify, fix, deploy, write
stakes: high
maxResults: 6
injectedCharCap: 2800
write_policy: approval

## Allowed Paths
- 00-Identity/
- 01-Operating-System/policies/
- 02-Projects/active/
- 03-Decisions/
- 06-Lessons/

## Safety Constraints
- NEVER expand to 99-Archive/**
- NEVER expand to 00-Inbox/quarantine/**
- NEVER auto-write to MEMORY.md
- ALWAYS respect frontmatter: retrieval: exclude

## Self-Test
```bash
opencode run --agent clawos-router -- "{\"task_type\": \"check\", \"project\": \"antfarm\", \"stakes\": \"low\"}"
```

## Sacred Documents
- clawos-integration-contract.md
