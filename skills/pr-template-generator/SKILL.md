---
skill_name: pr-template-generator
version: 1.0.0
required_tools: [git, handlebars]
input_schema:
  commits: array
  branch: string
output_schema:
  pr_body: string
  pr_title: string
side_effects: [generates PR description]
minimal_self_test_command: git log --oneline -5
---

# PR Template Generator

## Purpose

Generate PR descriptions from commits.

## Sections

- Description
- Changes
- Testing
- Checklist
