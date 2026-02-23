# Entity Sitemap Generator

## Purpose
Generate machine-readable sitemap with entity metadata for LLM crawling.

## Step-by-Step

### Step 1: Page Discovery
```bash
opencode run --agent "discover all pages: routes, content, entities present" --file website/site-discovery.md
```

### Step 2: Entity Mapping
```bash
opencode run --agent "map entities per page: what entities, relationships" --file website/page-entities.md
```

### Step 3: Sitemap Generation
```bash
opencode run --agent "generate entity-sitemap.xml with metadata" --file website/public/entity-sitemap.xml
```

## Sitemap Format
```xml
<url>
  <loc>https://example.com/product</loc>
  <lastmod>2026-02-22</lastmod>
  <priority>0.9</priority>
  <xhtml:meta name="entity-type" content="ProductPage"/>
  <xhtml:meta name="entities" content="Product A, Feature X"/>
</url>
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Completeness | 30% |
| Entity Accuracy | 25% |
| Freshness | 20% |
| LLM Parseability | 15% |
| Valid XML | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/public/sitemap.xml
  - website/public/entity-sitemap.xml
RL_SCORE: 96
URLS_INDEXED: 42
```
