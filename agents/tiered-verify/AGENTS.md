# AGENTS.md — Tiered-Verify Agent

## Interaction Contract

### Input Required
- task_text: string
- files_changed: array of file paths
- force_mode: optional FAST/STRICT override

### Output Format


### Escalation Rules
- S0/S1: Block immediately, trigger Ralph loop
- Missing artifact (STRICT): Block, retry
- Tool failure: Escalate to human
- Timeout: Escalate to human

## Failure Modes
| Severity | Action |
|----------|--------|
| S0 | Immediate block, remediation required |
| S1 | Block until resolved |
| S2 | Pass with warning, backlog |
| S3 | Pass, no action |
