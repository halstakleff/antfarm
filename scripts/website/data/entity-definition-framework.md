# Entity Definition Framework

## Purpose
Define and maintain consistent entity definitions across all properties.

## Step-by-Step

### Step 1: Entity Extraction
```bash
opencode run --agent "extract entities: company name, product names, people, locations" --file website/entity-extract.md
```

### Step 2: Definition Standardization
```bash
opencode run --agent "standardize definitions: one description per entity, consistent everywhere" --file website/entity-standardize.md
```

### Step 3: ENTITY_MAP.md Update
```bash
opencode run --agent "update ENTITY_MAP.md with all definitions" --file website/ENTITY_MAP.md
```

## Entity Map Structure
```yaml
entities:
  company:
    name: "Company Name"
    description: "Exact same description everywhere"
    url: "https://example.com"
    founded: "2020"
    
  products:
    - name: "Product Name"
      description: "Consistent product description"
      category: "Software"
      
  people:
    - name: "Person Name"
      title: "Job Title"
      bio: "Standardized bio"
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Completeness | 30% |
| Consistency | 30% |
| Accuracy | 25% |
| LLM Visibility | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/ENTITY_MAP.md
  - website/schema/*.json
RL_SCORE: 95
ENTITIES_DEFINED: 24
```
