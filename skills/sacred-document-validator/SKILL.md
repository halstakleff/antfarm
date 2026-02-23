---
skill_name: sacred-document-validator
version: 1.0.0
required_tools: [markdownlint, node]
input_schema:
  document: string
  validation_rules: array
output_schema:
  validation_errors: array
  is_valid: boolean
side_effects: [validates files]
minimal_self_test_command: markdownlint README.md
---

# Sacred Document Validator

## Purpose

Validate sacred documents.

## Documents

- PRODUCT_THESIS.md
- ARCHITECTURE.md
- RL_SCORES.md
- PROJECT_KB.md
