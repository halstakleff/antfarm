---
skill_name: test-coverage-enforcer
version: 1.0.0
required_tools: [jest, c8, nyc]
input_schema:
  coverage_threshold: number
  test_pattern: string
output_schema:
  coverage_report: object
  uncovered_files: array
side_effects: [runs tests, generates reports]
minimal_self_test_command: npm test -- --coverage --dry-run
---

# Test Coverage Enforcer

## Purpose

Enforce minimum coverage thresholds.

## Thresholds

- Statements: 80%
- Branches: 75%
- Functions: 80%
- Lines: 80%
