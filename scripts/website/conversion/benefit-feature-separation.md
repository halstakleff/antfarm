# Benefit-Feature Separation

## Purpose
Ensure clear separation between features (what it has) and benefits (what it does for users).

## Step-by-Step

### Step 1: Feature Extraction
```bash
opencode run --agent "extract all features from product docs" --file website/features-extract.md
```

### Step 2: Benefit Translation
```bash
opencode run --agent "translate each feature to benefit: 'We have X' → 'You get Y'" --file website/benefits-translate.md
```

### Step 3: Transformation Layer
```bash
opencode run --agent "add transformation: 'You get Y' → 'You become Z'" --file website/transformation-layer.md
```

## Hierarchy
```
FEATURE → BENEFIT → TRANSFORMATION

"API Integration" → "Connects your tools" → "Your workflow becomes seamless"
"24/7 Support" → "Help when needed" → "You never feel stuck"
"Automated Reports" → "Saves you hours" → "You focus on strategy"
```

## Implementation
- **Features** → In product page feature grid
- **Benefits** → In hero and landing sections
- **Transformation** → In testimonials and case studies

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Clarity of Separation | 30% |
| Benefit Relevance | 25% |
| Transformation Power | 25% |
| Copy Engagement | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/copy/features.md
  - website/copy/benefits.md
  - website/sections/Features.tsx
RL_SCORE: 95
FEATURES_MAPPED: 24/24
```
