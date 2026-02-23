---
skill_name: project-kb-updater
version: 1.0.0
required_tools: [git, markdown]
input_schema:
  update_type: string
  content: object
output_schema:
  updated_sections: array
  kb_version: string
side_effects: [mutates PROJECT_KB.md]
minimal_self_test_command: cat PROJECT_KB.md
---

# Project KB Updater

## Purpose

Update PROJECT_KB.md after each iteration.

## Sections

- Patterns
- Decisions
- Issues
- RL scores
- Iteration log
