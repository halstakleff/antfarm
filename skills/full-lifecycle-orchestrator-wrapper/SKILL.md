---
skill_name: full-lifecycle-orchestrator-wrapper
version: 1.0.0
required_tools: [antfarm, opencode]
input_schema:
  project_type: string
  phases: array
output_schema:
  execution_plan: object
  orchestration_status: string
side_effects: [spawns agents, runs scripts]
minimal_self_test_command: antfarm workflow list
---

# Full Lifecycle Orchestrator Wrapper

## Purpose

Orchestrate entire build lifecycle.

## Lifecycle

Phase 0 → Phase 1 → ... → Phase 8

## Output

Complete build with RL ≥95.
