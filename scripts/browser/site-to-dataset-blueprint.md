---
script_id: browser-site-to-dataset-blueprint
version: 1.0.0
sacred_docs: [PROJECT_KB.md, MARKETING_KB.md]
framework_refs: [framework/browser-agent-layer.md]
---

# Script: Site-to-Dataset Blueprint

## Title
Site-to-Dataset — Multi-Page Crawl with Content Extraction

## Purpose
Transform entire documentation sites or knowledge bases into LLM-ready datasets. Multi-page crawling with include/exclude rules, content extraction, and JSONL export.

## When to Run
- Knowledge base indexing
- Training data generation
- SEO content analysis
- AIEO dataset creation

## Prerequisites
- Seed URL
- Crawl rules (include/exclude patterns)
- Output directory

## Inputs

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| seed_url | string | Yes | Starting point |
| max_pages | number | No | Max pages to crawl (default: 50) |
| include_patterns | array | No | URL patterns to include |
| exclude_patterns | array | No | URL patterns to exclude |
| dedupe | boolean | No | Enable deduplication (default: true) |

## Outputs

| File | Path | Description |
|------|------|-------------|
| dataset.jsonl | outputs/browser/<date>/<job_id>/dataset.jsonl | Extracted content |
| quality_report.json | outputs/browser/<date>/<job_id>/quality_report.json | Quality metrics |
| pages_index.json | outputs/browser/<date>/<job_id>/pages_index.json | Crawled URLs |

## Step-by-Step Execution

### Step 1: Configure Crawl
```bash
crawl_rules='{
  "max_pages": 50,
  "include": ["/docs", "/guides"],
  "exclude": ["/admin", "/api"],
  "same_domain": true
}'
```

### Step 2: Execute Crawl
```bash
node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs crawl \
  "$seed_url" \
  "$crawl_rules" > /tmp/crawl_result.json
```

### Step 3: Extract Content
```bash
# For each page, extract:
# - title
# - headings (h1-h3)
# - main content
# - FAQs if present

jq -c '.pages[]' /tmp/crawl_result.json | while read page; do
  url=$(echo "$page" | jq -r '.url')
  html=$(echo "$page" | jq -r '.html')
  
  # Extract elements
  title=$(echo "$html" | pup 'h1 text{}' | head -1)
  h2s=$(echo "$html" | pup 'h2 text{}')
  content=$(echo "$html" | pup 'main text{}')
  
  # Write to dataset
  echo "{\"url\":\"$url\",\"title\":\"$title\",\"content\":\"$content\"}" >> dataset.jsonl
done
```

### Step 4: Deduplicate and Clean
```bash
# Remove duplicate content (based on URL and title hash)
awk '!seen[$0]++' dataset.jsonl > dataset_deduped.jsonl
mv dataset_deduped.jsonl dataset.jsonl

# Strip boilerplate (footer, header content)
echo "Boilerplate stripping..." # Implementation varies by site
```

### Step 5: Generate Report
```json
{
  "job_id": "uuid",
  "timestamp": "2026-02-22T21:00:00Z",
  "crawl_stats": {
    "seed_url": "https://example.com/docs",
    "pages_crawled": 47,
    "pages_failed": 3,
    "avg_page_size": 45231
  },
  "dataset_stats": {
    "total_records": 47,
    "deduplicated": 2,
    "final_count": 45,
    "file_size_bytes": 2847391
  },
  "quality_scores": {
    "content_completeness": 92,
    "boilerplate_ratio": 8,
    "avg_word_count": 1247
  }
}
```

## Deduplication Strategy

1. URL-based: Skip if URL already crawled
2. Content hash: Skip if content hash matches previous
3. Title similarity: Skip if title similarity > 90%

## Token Efficiency

- Batch process: 5 pages at a time
- Compress HTML before processing
- Summarize content over 5000 chars

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Crawl coverage | 25% |
| Extraction accuracy | 25% |
| Deduplication quality | 20% |
| Dataset completeness | 15% |
| Token efficiency | 10% |
| Schema validity | 5% |
| **TOTAL** | **100%** |

## Status Output

```json
{
  "STATUS": "COMPLETE",
  "FILES_MODIFIED": [
    "outputs/browser/2026-02-22/job-uuid/dataset.jsonl",
    "outputs/browser/2026-02-22/job-uuid/quality_report.json"
  ],
  "TEST_RESULTS": {
    "pages_crawled": 47,
    "final_dataset_size": 45
  },
  "RL_SCORE": 94,
  "NEXT_STEPS": ["Review quality_report.json"]
}
```
