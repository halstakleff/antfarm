# Page Speed Batch Optimization

## Purpose
Optimize page speed across all pages for Core Web Vitals.

## Step-by-Step

### Step 1: Speed Audit
```bash
opencode run --agent "audit speed: LCP, FID, CLS for all pages" --file seo/speed-audit.md
```

### Step 2: Optimization
```bash
opencode run --agent "optimize: images, code splitting, lazy loading, caching" --file seo/speed-optimize.md
```

### Step 3: Validation
```bash
opencode run --agent "validate: all pages pass Core Web Vitals" --file seo/speed-validate.md
```

## Optimization Tactics
- Image optimization (WebP, lazy loading)
- Code splitting
- Critical CSS inlining
- Font optimization
- Third-party script management
- Caching headers
- CDN usage

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| LCP | 30% |
| FID | 30% |
| CLS | 20% |
| Overall Score | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/next.config.js
  - website/public/images/
RL_SCORE: 96
LCP: <2.5s
FID: <100ms
CLS: <0.1
```
