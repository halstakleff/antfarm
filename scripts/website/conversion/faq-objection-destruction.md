# FAQ Objection Destructor

## Purpose
Build FAQ sections that destroy objections and boost conversion.

## Step-by-Step

### Step 1: Objection Mining
```bash
opencode run --agent "mine objections from sales calls, support tickets, competitor reviews" --file website/faq-objections.md
```

### Step 2: Answer Engineering
```bash
opencode run --agent "craft answers: acknowledge concern, provide solution, include CTA" --file website/faq-answers.md
```

### Step 3: Schema Injection
```bash
opencode run --agent "inject FAQPage schema with JSON-LD" --file website/faq-schema.md
```

## FAQ Pattern
Each FAQ item:
1. **Question** — Exact wording customers use
2. **Answer** — Direct, concise, helpful
3. **Solution Highlight** — How you solve it
4. **Micro-CTA** — "Start free trial" / "See pricing"

## Common Objections to Address
- Price/ROI
- Security/Privacy
- Setup/Onboarding
- Support quality
- Comparison to competitors
- Cancellation policy

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Objection Coverage | 30% |
| Answer Clarity | 25% |
| Solution Emphasis | 20% |
| Schema Validity | 15% |
| CTA Integration | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/sections/FAQ.tsx
  - website/schema/faq-schema.json
RL_SCORE: 96
OBJECTIONS_ADDRESSED: 12/12
```
