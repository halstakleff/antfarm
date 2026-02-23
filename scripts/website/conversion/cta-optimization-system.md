# CTA Optimization System

## Purpose
Optimize all CTAs for maximum click-through and conversion.

## Step-by-Step

### Step 1: CTA Audit
```bash
opencode run --agent "audit all CTAs: hero, inline, exit-intent, sidebar, footer" --file website/cta-audit.md
```

### Step 2: Optimization Pass
```bash
opencode run --agent "optimize: action-oriented text, contrast colors, size, placement" --file website/cta-optimized.md
```

### Step 3: Reinforcement Loops
```bash
opencode run --agent "add reinforcement: primary CTA → secondary CTA → exit CTA → contextual CTA" --file website/cta-reinforcement.md
```

## CTA Framework
| Type | Use | Example |
|------|-----|---------|
| **Primary** | Main conversion | "Start Free Trial" |
| **Secondary** | Alternative path | "Book Demo" |
| **Exit** | Before leaving | "Get Free Guide" |
| **Contextual** | In content | "Learn More" |
| **Micro** | After sections | "See Pricing" |

## Best Practices
- Action verb first
- Benefit implied
- Fear/reward balanced
- Contrast against background
- Large enough to click (44px min)

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Action Clarity | 25% |
| Visual Contrast | 25% |
| Placement Strategy | 20% |
| Message Consistency | 15% |
| Mobile Accessibility | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/components/CTA.tsx
  - website/styles/cta.css
RL_SCORE: 97
CTA_COUNT: 8 optimized
```
