---
skill_name: doc-auto-generator
version: 1.0.0
required_tools: [typedoc, jsdoc, markdown-it]
input_schema:
  source_path: string
  doc_type: string
output_schema:
  generated_docs: array
  index_path: string
side_effects: [generates documentation]
minimal_self_test_command: typedoc --version
---

# Documentation Auto-Generator

## Purpose

Auto-generate API docs from code.

## Outputs

- API reference
- Type definitions
- Usage examples
