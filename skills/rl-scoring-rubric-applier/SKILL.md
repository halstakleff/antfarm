---
skill_name: rl-scoring-rubric-applier
version: 1.0.0
required_tools: [node]
input_schema:
  task_type: string
  artifacts: array
output_schema:
  rl_score: number
  breakdown: object
  recommendations: array
side_effects: [updates RL_SCORES.md]
minimal_self_test_command: node rl-score.js --dry-run
---

# RL Scoring Rubric Applier

## Purpose

Apply Microsoft RL scoring rubric.

## Formula

```
Score = Σ(criterion × weight)
```

## Thresholds

- 80-89: Iterate
- 90-94: PR-ready
- 95-100: Release-ready
