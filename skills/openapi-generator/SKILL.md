---
skill_name: openapi-generator
version: 1.0.0
required_tools: [openapi-generator-cli]
input_schema:
  spec_path: string
  target_language: string
output_schema:
  generated_files: array
  client_sdk_path: string
side_effects: [generates code files]
minimal_self_test_command: openapi-generator --version
---

# OpenAPI Generator

## Purpose

Generate typed clients from OpenAPI specs.

## Usage

```bash
openapi-generator generate -i spec.yaml -g typescript
```
