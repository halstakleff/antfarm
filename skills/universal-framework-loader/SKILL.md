---
skill_name: universal-framework-loader
version: 1.0.0
required_tools: [opencode CLI, node]
input_schema:
  project_path: string
  phase: string
  task: string
output_schema:
  loaded_scripts: array
  execution_plan: object
  rl_threshold: number
side_effects: [reads scripts/, updates PROJECT_KB.md]
minimal_self_test_command: opencode run --agent "load framework" --dry-run
---

# Universal Framework Loader

## Purpose

Load and execute framework scripts in sequence.

## Input Schema

```yaml
project_path: "/path/to/project"
phase: "phase0"
task: "ideation"
```

## Output Schema

```yaml
loaded_scripts: ["phase0-ideation", "phase0-risk"]
execution_plan: {order: [], dependencies: []}
rl_threshold: 95
```

## Usage Example

```bash
opencode run --agent "execute framework phase0" --file PROJECT_KB.md
```

## Ralph Loop Integration

- Each phase triggers Ralph loop
- Fresh context per script
- RL score ≥95 required

## Error Recovery

- Failed script: retry 3x
- Still failing: escalate
