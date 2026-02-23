# Hero Section Optimizer

## Purpose
Optimize hero sections for 5-second clarity and conversion.

## Step-by-Step

### Step 1: Analyze Current Hero
```bash
opencode run --agent "analyze hero: headline, subhead, CTA, visual hierarchy" --file website/hero-analysis.md
```

### Step 2: Apply Psychology Framework
```bash
opencode run --agent "apply: transformation > features, single clear CTA, social proof headline" --file website/hero-optimized.md
```

### Step 3: Validate 5-Second Test
```bash
opencode run --agent "validate: can user understand value prop in 5 seconds?" --file website/hero-validation.md
```

## Anatomy Checklist
- [ ] Headline states transformation (not features)
- [ ] Subhead clarifies the "how"
- [ ] Single primary CTA
- [ ] Social proof visible (logos/stats)
- [ ] Visual supports message (not decorative)

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Clarity | 30% |
| Transformation Focus | 25% |
| CTA Prominence | 20% |
| Visual Support | 15% |
| Social Proof | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/sections/hero.tsx
  - website/sections/hero.css
RL_SCORE: 96
HERO_VIOLATIONS: []
```
