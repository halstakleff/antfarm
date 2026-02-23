# Product Page Architecture

## Purpose
Build high-converting product pages following proven anatomy.

## Step-by-Step

### Step 1: Structure Definition
```bash
opencode run --agent "define product page structure: header, hero, social proof, features, use cases, pricing teaser, FAQ, CTA" --file website/product-page-structure.md
```

### Step 2: Component Generation
```bash
opencode run --agent "generate ProductPage components with all sections" --file website/components/ProductPage.tsx
```

### Step 3: Schema Injection
```bash
opencode run --agent "inject Product schema + Review schema + Offer schema" --file website/schema/product-json-ld.md
```

## Anatomy (8 Sections)
1. Header — Product name + tagline
2. Hero — Image + key benefit + CTA
3. Social Proof — Rating + reviews + badges
4. Feature Grid — 3-6 key features with icons
5. Use Cases — Who uses it + how + results
6. Pricing Teaser — Starting price + included
7. FAQ — 3-5 questions with schema
8. Final CTA — Reinforce value + remove friction

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Section Completeness | 20% |
| CTA Clarity | 20% |
| Social Proof | 15% |
| Schema Validity | 15% |
| Mobile Experience | 15% |
| Load Speed | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/pages/product.tsx
  - website/components/ProductPage.tsx
  - website/schema/product-schema.json
RL_SCORE: 95
SECTIONS_COMPLETE: 8/8
```
