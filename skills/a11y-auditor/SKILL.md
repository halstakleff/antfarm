---
skill_name: a11y-auditor
version: 1.0.0
required_tools: [axe-core, lighthouse, pa11y]
input_schema:
  url: string
  wcag_level: string
output_schema:
  violations: array
  score: number
side_effects: [generates reports]
minimal_self_test_command: lighthouse --version
---

# Accessibility Auditor

## Purpose

WCAG compliance auditing.

## Standards

- WCAG 2.1 AA/AAA
- Section 508
- Keyboard navigation
- Screen reader
