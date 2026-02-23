---
skill_name: value-prop-clarifier
version: 1.0.0
required_tools: [opencode CLI]
input_schema:
  current_value_prop: string
  target_audience: string
  pain_point: string
  outcome: string
  differentiation: string
output_schema:
  clarified_prop: string
  headline_options: array
  subhead: string
  proof: string
  ctas: array
  rl_score: number
side_effects: [mutates value prop file]
minimal_self_test_command: opencode run --agent "clarify value prop" --dry-run
---

# Value Prop Clarifier

## Purpose
Sharpen value propositions using the "So What?" ladder.

## Input Schema

```yaml
current_value_prop: "We use AI to optimize websites"
target_audience: "Marketing Directors"
pain_point: "Low conversion rates"
outcome: "More customers from existing traffic"
differentiation: "Only platform with built-in CRO testing"
```

## Output Schema

```yaml
clarified_prop: "Get 3x more customers from your existing traffic—automatically"
headline_options:
  - "3x Your Customers Without Buying More Traffic"
  - "The Easiest Way to Convert More Visitors"
  - "Stop Losing 70% of Your Website Visitors"
subhead: "AI-powered CRO that runs tests for you"
proof: "Join 15,000+ Marketing Directors using [Product]"
ctas: ["Start free trial", "See demo"]
rl_score: 97
```

## Framework
1. Feature → Benefit → Transformation
2. PAS (Problem, Agitate, Solve)
3. "So What?" Ladder (5 levels deep)

## Usage

```bash
opencode run --agent "clarify value prop for SaaS onboarding product" --file value-prop/
```
