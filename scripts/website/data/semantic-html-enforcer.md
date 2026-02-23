# Semantic HTML Enforcer

## Purpose
Ensure proper semantic HTML structure for accessibility, SEO, and LLM parsing.

## Step-by-Step

### Step 1: HTML Audit
```bash
opencode run --agent "audit HTML: remove div soup, add semantic elements" --file website/html-audit.md
```

### Step 2: Heading Hierarchy Validation
```bash
opencode run --agent "validate H1-H6: single H1, logical order, no skips" --file website/heading-validation.md
```

### Step 3: ARIA Integration
```bash
opencode run --agent "add ARIA labels: roles, labels, descriptions" --file website/aria-integration.md
```

## Semantic Structure
```html
<header> — Site header
  <nav> — Navigation
<main> — Main content
  <article> — Independent content
    <header> — Article header
    <section> — Content sections
    <aside> — Related content
    <footer> — Article footer
<aside> — Sidebar
<footer> — Site footer
```

## Heading Rules
- [ ] Exactly one H1 per page
- [ ] No skipped levels (H2 → H4)
- [ ] Logical nesting
- [ ] Descriptive text
- [ ] Keywords included naturally

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Semantic Correctness | 30% |
| Heading Hierarchy | 25% |
| ARIA Compliance | 25% |
| LLM Parseability | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/components/*.tsx
  - website/pages/*.tsx
RL_SCORE: 96
SEMANTIC_VIOLATIONS: []
```
