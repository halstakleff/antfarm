# JSON-LD Schema System

## Purpose
Comprehensive JSON-LD schema injection for rich results and LLM visibility.

## Step-by-Step

### Step 1: Schema Mapping
```bash
opencode run --agent "map schemas: Organization, Website, WebPage, Product, FAQPage, LocalBusiness" --file website/schema-mapping.md
```

### Step 2: JSON-LD Generation
```bash
opencode run --agent "generate JSON-LD for each page type" --file website/schema-generation.md
```

### Step 3: Validation
```bash
opencode run --agent "validate: Schema.org validator + Google Rich Results Test" --file website/schema-validation.md
```

## Required Schemas

### Organization
```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Company Name",
  "url": "https://example.com",
  "logo": "https://example.com/logo.png",
  "sameAs": [
    "https://twitter.com/company",
    "https://linkedin.com/company"
  ]
}
```

### Website
```json
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": "Site Name",
  "url": "https://example.com",
  "potentialAction": {
    "@type": "SearchAction",
    "target": "https://example.com/search?q={search_term_string}",
    "query-input": "required name=search_term_string"
  }
}
```

### FAQPage
```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [{
    "@type": "Question",
    "name": "Question text?",
    "acceptedAnswer": {
      "@type": "Answer",
      "text": "Answer text."
    }
  }]
}
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Schema Completeness | 30% |
| Validity (Google Test) | 30% |
| Rich Results Eligibility | 25% |
| LLM Parseability | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/schema/organization.json
  - website/schema/website.json
  - website/schema/faq.json
RL_SCORE: 97
SCHEMAS_VALID: 8/8
```
