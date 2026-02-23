# Browser Usage Log

## Format

```yaml
- timestamp: "YYYY-MM-DDTHH:MM:SSZ"
  script: <script_name>
  url: <target_url>
  skill_used: <skill_name>
  output_path: <path>
  rl_score: <0-100>
  errors: []
```

---

## Schema

```yaml
record:
  timestamp:
    type: string
    format: date-time
  script:
    type: string
    description: Which script invoked the browser
  url:
    type: string
    format: uri
  skill_used:
    type: string
    description: Browser skill that executed
  output_path:
    type: string
    description: Path to generated evidence
  rl_score:
    type: integer
    minimum: 0
    maximum: 100
  errors:
    type: array
    items:
      type: string
```

---

## Usage Entries

*(No entries yet - awaiting first execution)*

---

## Statistics

| Metric | Value |
|--------|-------|
| Total Invocations | 0 |
| Avg RL Score | N/A |
| Success Rate | N/A |
| Unique URLs | 0 |
| Top Skill | N/A |
