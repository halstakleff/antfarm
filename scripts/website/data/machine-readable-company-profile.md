# Machine-Readable Company Profile

## Purpose
Create comprehensive machine-readable company profile for LLM ingestion.

## Step-by-Step

### Step 1: Profile Compilation
```bash
opencode run --agent "compile profile: entity data, offerings, people, locations, news" --file website/company-profile-compile.md
```

### Step 2: Formatting
```bash
opencode run --agent "format: JSON-LD, structured, scannable" --file website/company-profile.json
```

### Step 3: Publication
```bash
opencode run --agent "publish: /about/data.json, schema integration, sitemap update" --file website/profile-published.md
```

## Profile Contents
```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "...",
  "description": "...",
  "url": "...",
  "logo": "...",
  "foundingDate": "...",
  "founders": [...],
  "employees": [...],
  "products": [...],
  "sameAs": [...],
  "hasOfferCatalog": {...}
}
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Completeness | 30% |
| Schema Validity | 25% |
| LLM Parseability | 25% |
| Freshness | 10% |
| Accessibility | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/public/company-profile.json
  - website/schema/organization.json
RL_SCORE: 97
PROFILE_COMPLETE: true
```
