---
skill_name: diagram-generator
version: 1.0.0
required_tools: [mermaid-cli, plantuml]
input_schema:
  diagram_type: string
  source: string
output_schema:
  output_path: string
  format: string
side_effects: [generates images/SVGs]
minimal_self_test_command: mmdc --version
---

# Diagram Generator

## Purpose

Generate architecture diagrams.

## Types

- ER diagrams
- Flowcharts
- Sequence diagrams
- State machines

## Usage

```bash
mmdc -i input.mmd -o output.svg
```
