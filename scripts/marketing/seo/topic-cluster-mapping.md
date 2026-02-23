# Topic Cluster Mapping

## Purpose
Build topic clusters for topical authority and internal linking.

## Step-by-Step

### Step 1: Pillar Identification
```bash
opencode run --agent "identify pillars: broad topics, high volume, business relevant" --file seo/pillar-identify.md
```

### Step 2: Cluster Generation
```bash
opencode run --agent "generate clusters: long-tail keywords, supporting topics" --file seo/cluster-generate.md
```

### Step 3: Link Structure
```bash
opencode run --agent "create structure: pillar → clusters, clusters ↔ clusters" --file seo/cluster-links.md
```

## Cluster Format
```
PILLAR: "Digital Marketing"
├── Cluster: "SEO Basics"
├── Cluster: "Content Marketing"
├── Cluster: "Email Marketing"
└── Cluster: "Social Media Marketing"
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Pillar Quality | 30% |
| Cluster Coverage | 25% |
| Link Structure | 25% |
| Keyword Alignment | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - seo/topic-clusters.json
  - website/content/pillars/
RL_SCORE: 95
PILLARS: 5
CLUSTERS: 23
```
