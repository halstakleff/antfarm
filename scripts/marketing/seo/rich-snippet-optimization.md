# Rich Snippet Optimization

## Purpose
Optimize for rich snippets in SERPs.

## Step-by-Step

### Step 1: Opportunity Analysis
```bash
opencode run --agent "analyze snippets: FAQ, HowTo, Review, Product opportunities" --file seo/snippet-opportunities.md
```

### Step 2: Schema Implementation
```bash
opencode run --agent "implement schema: FAQPage, HowTo, Review, Product" --file seo/snippet-schema.md
```

### Step 3: Validation
```bash
opencode run --agent "validate: Google Rich Results Test" --file seo/snippet-validate.md
```

## Snippet Types
- FAQ Snippet
- HowTo Snippet
- Review Snippet
- Product Snippet
- Article Snippet
- Video Snippet

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Schema Validity | 35% |
| Rich Result Eligibility | 35% |
| CTR Improvement | 20% |
| Coverage | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/schema/
  - website/sections/FAQ.tsx
RL_SCORE: 97
SNIPPETS_ELIGIBLE: 8
```
