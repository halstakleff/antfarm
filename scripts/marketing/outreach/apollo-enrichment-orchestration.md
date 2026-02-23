# Apollo Enrichment Orchestration

## Purpose
Enrich prospect data using Apollo.io.

## Step-by-Step

### Step 1: List Upload
```bash
opencode run --agent "upload: contacts to Apollo" --file outreach/apollo-upload.md
```

### Step 2: Enrichment
```bash
opencode run --agent "enrich: emails, phones, titles, company data" --file outreach/apollo-enrich.md
```

### Step 3: Export
```bash
opencode run --agent "export: enriched data for campaigns" --file outreach/apollo-export.md
```

## Data Enriched
- Email
- Phone
- Title
- Company info
- Industry
- Revenue
- Employee count

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Coverage | 35% |
| Accuracy | 35% |
| Completeness | 20% |
| Cost | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - outreach/prospects-enriched.csv
RL_SCORE: 96
CONTACTS_ENRICHED: 1000
EMAILS_FOUND: 85%
PHONES_FOUND: 42%
```
