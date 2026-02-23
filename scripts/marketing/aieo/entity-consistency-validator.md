# Entity Consistency Validator

## Purpose
Validate entity consistency across all web properties.

## Step-by-Step

### Step 1: Entity Extraction
```bash
opencode run --agent "extract entities: website, social, directories" --file aieo/entity-extract-all.md
```

### Step 2: Comparison
```bash
opencode run --agent "compare: name, description, URL, logo consistency" --file aieo/entity-compare.md
```

### Step 3: Fix Application
```bash
opencode run --agent "fix inconsistencies: update all to canonical definition" --file aieo/entity-fix.md
```

## Validation Checklist
- [ ] Same company name everywhere
- [ ] Same description
- [ ] Same URL
- [ ] Same founding date
- [ ] Same logo
- [ ] Same social links

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Name Consistency | 40% |
| Description Consistency | 30% |
| URL Consistency | 15% |
| Logo Consistency | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/ENTITY_MAP.md
RL_SCORE: 98
CONSISTENCY_SCORE: 100%
```
