# Technical SEO Audit

## Purpose
Complete technical SEO audit with fixes and recommendations.

## Step-by-Step

### Step 1: Technical Crawl
```bash
opencode run --agent "crawl site: status codes, redirects, canonicals, robots" --file seo/technical-crawl.md
```

### Step 2: Issue Detection
```bash
opencode run --agent "detect issues: 404s, duplicates, slow pages, mobile issues" --file seo/technical-issues.md
```

### Step 3: Fix Application
```bash
opencode run --agent "apply fixes: redirects, canonicals, speed, mobile" --file seo/technical-fixes.md
```

## Audit Checklist
- [ ] Crawlability (robots.txt, sitemap)
- [ ] Indexability (noindex, canonicals)
- [ ] Mobile-friendliness
- [ ] Page speed (Core Web Vitals)
- [ ] HTTPS/security
- [ ] URL structure
- [ ] Duplicate content
- [ ] Redirect chains
- [ ] 404 errors
- [ ] Schema markup

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Issue Coverage | 30% |
| Fix Success | 30% |
| Speed Score | 20% |
| Mobile Score | 10% |
| Crawl Health | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - seo/technical-audit.json
  - website/.htaccess
RL_SCORE: 97
ERRORS_FIXED: 18
WARNINGS: 3
```
