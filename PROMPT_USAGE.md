# Prompt Usage Log

## Format

```yaml
- timestamp: "YYYY-MM-DDTHH:MM:SSZ"
  script: <script_name>
  pattern_id: <PATTERN-XXX>
  input_summary: <brief_description>
  output_path: <file_path>
  rl_score: <0-100>
  tokens_used: <count>
  refinement_count: <iterations>
```

---

## Usage Entries

### 2026-02-22

- timestamp: "2026-02-22T18:00:00Z"
  script: "hero-optimizer"
  pattern_id: "PATTERN-007"
  input_summary: "ecommerce, hero section, 3 benefits"
  output_path: "scripts/website/conversion/hero-optimizer.md"
  rl_score: 96
  tokens_used: 2847
  refinement_count: 1

- timestamp: "2026-02-22T18:05:00Z"
  script: "seo-audit-full"
  pattern_id: "PATTERN-005"
  input_summary: "technical SEO, 3 categories"
  output_path: "scripts/marketing/seo/technical-seo-audit-full.md"
  rl_score: 97
  tokens_used: 3124
  refinement_count: 0

- timestamp: "2026-02-22T18:10:00Z"
  script: "aieo-visibility"
  pattern_id: "PATTERN-006"
  input_summary: "entity consistency check"
  output_path: "scripts/marketing/aieo/llm-visibility-audit.md"
  rl_score: 94
  tokens_used: 2567
  refinement_count: 2

---

## Statistics

| Metric | Value |
|--------|-------|
| Total Invocations | 3 |
| Avg RL Score | 95.7 |
| Avg Tokens | 2846 |
| Refinement Rate | 33% |
| Success Rate | 100% |

---

## Schema Validation

All entries validated against:
```yaml
type: object
properties:
  timestamp: {type: string, format: date-time}
  script: {type: string}
  pattern_id: {type: string}
  input_summary: {type: string}
  output_path: {type: string}
  rl_score: {type: integer, minimum: 0, maximum: 100}
  tokens_used: {type: integer}
  refinement_count: {type: integer}
required: [timestamp, script, pattern_id, rl_score, tokens_used]
```
