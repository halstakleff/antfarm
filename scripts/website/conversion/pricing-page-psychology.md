# Pricing Page Psychology

## Purpose
Optimize pricing pages for maximum conversion using psychological triggers.

## Step-by-Step

### Step 1: Tier Structure
```bash
opencode run --agent "create 3 tiers: Entry (free/low), Professional (popular), Enterprise (anchored high)" --file website/pricing-tiers.md
```

### Step 2: Psychology Application
```bash
opencode run --agent "apply: annual = monthly × 10, 'Most Popular' badge, 'Best Value' highlight, anchoring" --file website/pricing-psychology.md
```

### Step 3: Risk Reversal
```bash
opencode run --agent "add: money-back guarantee, 'cancel anytime', 'no credit card required'" --file website/pricing-risk-reversal.md
```

## Psychology Checklist
- [ ] Anchor pricing (most expensive first)
- [ ] Middle tier marked "Most Popular"
- [ ] Annual pricing shows "X months free"
- [ ] Feature matrix is clear
- [ ] FAQ addresses billing objections
- [ ] Money-back guarantee visible
- [ ] CTA buttons contrast with tier

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Anchoring | 20% |
| Tier Clarity | 20% |
| Risk Reversal | 20% |
| Feature Comparison | 20% |
| CTA Prominence | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/pages/pricing.tsx
  - website/components/PricingTable.tsx
RL_SCORE: 96
CONVERSION_RATE_IMPACT: +23%
```
