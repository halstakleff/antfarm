---
skill_name: rollback-drill-simulator
version: 1.0.0
required_tools: [kubectl, helm, terraform]
input_schema:
  deployment_name: string
  rollback_strategy: string
output_schema:
  rollback_plan: object
  estimated_downtime: string
side_effects: [creates rollback scripts]
minimal_self_test_command: helm rollback --dry-run
---

# Rollback Drill Simulator

## Purpose

Simulate rollback procedures.

## Strategies

- Blue/green rollback
- Database rollback
- Feature flag rollback
