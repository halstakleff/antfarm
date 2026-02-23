---
skill_name: ralph-loop-with-rl-scoring
version: 1.0.0
required_tools: [bash, git]
input_schema:
  task: string
  max_iterations: number
  rl_threshold: number
output_schema:
  iteration_count: number
  final_rl_score: number
  status: string
side_effects: [creates sessions, mutates PROJECT_KB.md]
minimal_self_test_command: ./ralph-loop.sh "test" 5 95
---

# Ralph Loop with RL Scoring

## Purpose

Iterate until RL score ≥95.

## Input Schema

```yaml
task: "Implement feature"
max_iterations: 5
rl_threshold: 95
```

## Output Schema

```yaml
iteration_count: 3
final_rl_score: 97
status: "done"
```

## Usage

```bash
./ralph-loop.sh "task" 5 95
```

## RL Scoring

Completeness ×0.25 + Tests ×0.20 + Typecheck ×0.15 + Security ×0.20 + Perf ×0.10 + Maintainability ×0.10
