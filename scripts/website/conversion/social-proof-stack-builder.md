# Social Proof Stack Builder

## Purpose
Build comprehensive social proof sections that convert.

## Step-by-Step

### Step 1: Proof Inventory
```bash
opencode run --agent "inventory all proof: logos, testimonials, case studies, stats, reviews" --file website/proof-inventory.md
```

### Step 2: Stack Building
```bash
opencode run --agent "build 5-layer stack: logos → testimonials → stats → case studies → video" --file website/proof-stack.md
```

### Step 3: Schema Integration
```bash
opencode run --agent "inject Review schema + AggregateRating schema" --file website/proof-schema.md
```

## 5-Layer Stack
1. **Logos** — Trusted company names
2. **Testimonials** — Quote + name + title + photo
3. **Stats** — "X customers", "Y% improvement", "Z rating"
4. **Case Studies** — Before/after stories
5. **Video** — Customer testimonials

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Proof Diversity | 25% |
| Credibility | 25% |
| Relevance | 20% |
| Schema Validity | 15% |
| Visual Appeal | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/sections/SocialProof.tsx
  - website/sections/Testimonials.tsx
  - website/schema/review-schema.json
RL_SCORE: 97
PROOF_LAYERS: 5/5
```
