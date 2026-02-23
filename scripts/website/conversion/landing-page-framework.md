# Landing Page Framework

## Purpose
Build landing pages using SCR (Situation-Complication-Resolution) framework.

## Step-by-Step

### Step 1: SCR Structure
```bash
opencode run --agent "apply SCR: Situation (agitate problem), Complication (why solutions fail), Resolution (your solution)" --file website/landing-scr.md
```

### Step 2: Section Flow
```bash
opencode run --agent "build flow: Hero → Problem → Solution → Features → Social Proof → Pricing → FAQ → CTA" --file website/landing-flow.md
```

### Step 3: Optimization
```bash
opencode run --agent "optimize: headline clarity, CTA placement, friction removal" --file website/landing-optimize.md
```

## Landing Page Anatomy (SCR Framework)
1. **Hero** — Headline + subhead + primary CTA
2. **Situation** — Agitate the problem (they feel this)
3. **Complication** — Why existing solutions fail
4. **Resolution** — Your solution (how it works)
5. **Features** — Proof it works
6. **Social Proof** — Testimonials/case studies
7. **Pricing** — Clear value proposition
8. **FAQ** — Objection removal
9. **Final CTA** — Conversion push

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| SCR Clarity | 25% |
| Flow Coherence | 20% |
| CTA Optimization | 20% |
| Objection Handling | 15% |
| Proof Strength | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/pages/landing.tsx
  - website/sections/*.tsx
RL_SCORE: 95
SECTIONS: 9/9 complete
```
