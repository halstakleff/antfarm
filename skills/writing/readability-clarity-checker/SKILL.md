---
skill_name: readability-clarity-checker
version: 1.0.0
required_tools: [opencode CLI, readability engine]
input_schema:
  content: string
  target_grade: number
  forbidden_words: array
  min_benefit_ratio: number
output_schema:
  grade_level: number
  forbidden_found: array
  vague_words: array
  benefit_ratio: number
  suggestions: array
  readability_score: number
  rl_score: number
side_effects: [flags issues, suggests fixes]
minimal_self_test_command: opencode run --agent "check readability" --dry-run
---

# Readability Clarity Checker

## Purpose
Check and improve copy clarity.

## Input Schema

```yaml
content: "Our powerful platform makes it easy to get seamless results"
target_grade: 8
forbidden_words: ["best", "easy", "simple", "powerful", "seamless"]
min_benefit_ratio: 0.67  # 2:1 benefits to features
```

## Output Schema

```yaml
grade_level: 11
forbidden_found: ["powerful", "easy", "seamless"]
vague_words:
  - word: "powerful"
    suggestion: "handles 10,000 requests/sec"
  - word: "easy"
    suggestion: "set up in 10 minutes"
benefit_ratio: 0.5  # Needs improvement
suggestions:
  - "Replace 'powerful' with specific metric"
  - "Add 2 more benefits to section"
  - "Simplify sentence structure"
readability_score: 72
rl_score_need: rewrite
```

## Forbidden Words List
| Word | Replacement |
|------|-------------|
| Best | Top-rated by X |
| Easy | 10-min setup |
| Simple | One-click |
| Powerful | [specific metric] |
| Seamless | [integration details] |

## Thresholds
- Grade Level: 7-9
- Reading Score: 80+
- RL Score: ≥95

## Usage

```bash
opencode run --agent "check clarity of hero section" --file hero.md
```
