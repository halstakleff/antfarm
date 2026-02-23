# Internal Link Graph Builder

## Purpose
Build strategic internal linking structure for SEO and user navigation.

## Step-by-Step

### Step 1: Page Inventory
```bash
opencode run --agent "inventory all pages: collect URLs, topics, target keywords" --file website/page-inventory.md
```

### Step 2: Cluster Mapping
```bash
opencode run --agent "map clusters: pillar pages + cluster content + logical connections" --file website/link-clusters.md
```

### Step 3: Link Insertion
```bash
opencode run --agent "insert links: 3-5 internal links per page, descriptive anchors" --file website/links-inserted.md
```

## Link Strategy
- **Homepage** → Pillar pages
- **Pillar pages** → Cluster content (and back)
- **Cluster content** → Related cluster content
- **All pages** → Contact, About, Product

## Anchor Text Rules
- Descriptive (not "click here")
- Keyword-rich (naturally)
- Short (2-4 words)
- Relevant to target page

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Cluster Coverage | 25% |
| Link Relevance | 25% |
| Anchor Quality | 25% |
| Graph Depth | 15% |
| No Orphans | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/content/*.md
  - website/data/link-graph.json
RL_SCORE: 95
LINKS_CREATED: 87
ORPHAN_PAGES: 0
```
