# Semantic Site Architecture

## Purpose
Optimize site architecture for SEO crawlability and topical authority.

## Step-by-Step

### Step 1: Architecture Audit
```bash
opencode run --agent "audit architecture: depth, crawlability, orphaned pages, silo structure" --file seo/architecture-audit.md
```

### Step 2: Silo Mapping
```bash
opencode run --agent "map silos: pillar pages, cluster content, supporting pages" --file seo/silo-map.md
```

### Step 3: URL Optimization
```bash
opencode run --agent "optimize URLs: short, descriptive, keyword-rich, hierarchy" --file seo/url-optimization.md
```

## Architecture Rules
- Max depth: 3 clicks from homepage
- Clear silo structure
- No orphaned pages
- Logical URL hierarchy
- Internal linking matrix

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Depth | 25% |
| Silo Clarity | 25% |
| URL Quality | 20% |
| Internal Links | 20% |
| Crawlability | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/structure/sitemap.md
  - website/structure/silos.json
RL_SCORE: 96
MAX_DEPTH: 3
ORPHANED_PAGES: 0
```
