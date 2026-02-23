---
skill_name: dataset-generator
version: 1.0.0
required_tools: [hyperbrowser-sdk, jq]
input_schema:
  seed_url: string
  max_pages: number
  content_selector: string
  title_selector: string
output_schema:
  dataset_path: string
  records_count: number
  avg_content_length: number
  quality_score: number
  deduplication_stats: object
  confidence: number
side_effects: [site_crawl, file_output]
minimal_self_test_command: scripts/browser/site-to-dataset-blueprint.md
---

# Skill: Dataset Generator

## Purpose
Transform websites into LLM-ready datasets (JSONL). Multi-page crawl with content extraction.

## Patterns Applied
- PATTERN-003: Contextual Analysis
- PATTERN-005: JSON Response

## Input Schema

```yaml
seed_url: "https://docs.example.com"
max_pages: 50
content_selector: "main article"
title_selector: "h1"
```

## Output Schema

```json
{
  "analysis": "Generated dataset: 45 records, 92% quality",
  "structured_output": {
    "dataset_path": "outputs/browser/2026-02-22/job-uuid/dataset.jsonl",
    "records_count": 45,
    "avg_content_length": 1247,
    "quality_score": 92,
    "deduplication_stats": { "removed": 2, "kept": 45 }
  },
  "confidence": 0.93
}
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Coverage | 30% |
| Quality score | 30% |
| Deduplication | 25% |
| Token efficiency | 15% |
