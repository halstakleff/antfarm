---
skill_name: git-workflow-enforcer
version: 1.0.0
required_tools: [git, gh CLI]
input_schema:
  branch: string
  commit_message: string
output_schema:
  pr_url: string
  checks_status: string
side_effects: [pushes code, creates PRs]
minimal_self_test_command: git --version
---

# Git Workflow Enforcer

## Purpose

Enforce conventional commits and PR standards.

## Checks

- Commit message format
- Branch naming
- PR template
- Required reviews
