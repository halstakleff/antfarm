# Value Proposition Clarifier

## Purpose
Clarify and sharpen value propositions for maximum impact.

## Step-by-Step

### Step 1: Extract Current Value Prop
```bash
opencode run --agent "extract current value proposition from all copy" --file website/value-prop-extract.md
```

### Step 2: Apply Framework
```bash
opencode run --agent "apply framework: Problem → Solution → Differentiation → Proof" --file website/value-prop-framework.md
```

### Step 3: Validate Clarity
```bash
opencode run --agent "test with 5 users: do they understand in 10 seconds?" --file website/value-prop-test.md
```

## Framework
1. **Problem Agitation** — "Are you struggling with...?"
2. **Solution Presentation** — "Here's how we fix it..."
3. **Differentiation** — "Unlike others, we..."
4. **Proof Points** — "Join X customers who..."

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Problem Clarity | 25% |
| Solution Distinctiveness | 25% |
| Differentiation | 25% |
| Proof Strength | 25% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/copy/value-prop.md
  - website/sections/hero.tsx
RL_SCORE: 97
```
