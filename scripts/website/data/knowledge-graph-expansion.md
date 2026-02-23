# Knowledge Graph Expansion

## Purpose
Expand knowledge graph presence through entity building and citation acquisition.

## Step-by-Step

### Step 1: Graph Audit
```bash
opencode run --agent "audit current graph: what entities exist, what edges, what's missing" --file website/graph-audit.md
```

### Step 2: Expansion Strategy
```bash
opencode run --agent "plan expansion: new entities, new relationships, citation opportunities" --file website/graph-expansion-plan.md
```

### Step 3: Implementation
```bash
opencode run --agent "implement: add new entities, build citations, update sameAs" --file website/graph-expand.md
```

## Expansion Tactics
- Claim Wikipedia page (if notable)
- Create Crunchbase profile
- Optimize LinkedIn Company
- Build Google Business Profile
- Get industry directory listings
- Earn backlinks with entity mentions
- Publish thought leadership

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Entity Coverage | 30% |
| Citation Quality | 25% |
| Graph Density | 20% |
| Accuracy | 15% |
| LLM Visibility | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/data/knowledge-graph.json
  - website/data/entity-citations.json
RL_SCORE: 96
ENTITIES_EXPANDED: 8
CITATIONS_ACQUIRED: 12
```
