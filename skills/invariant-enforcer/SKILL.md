---
skill_name: invariant-enforcer
version: 1.0.0
required_tools: [node, grep]
input_schema:
  invariants: array
  code_path: string
output_schema:
  violations: array
  status: string
side_effects: [scans code, creates report]
minimal_self_test_command: node invariant-check.js --dry-run
---

# Invariant Enforcer

## Purpose

Verify invariants are not violated.

## Check Types

- Business rules
- Technical constraints
- Security invariants

## Output

```yaml
violations: []
status: "pass"
```
