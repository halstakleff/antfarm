# Content Repurposing Swarm

## Purpose
Repurpose content across multiple formats and platforms.

## Step-by-Step

### Step 1: Content Selection
```bash
opencode run --agent "select content: best performing, evergreen, repurposable" --file content/repurpose-select.md
```

### Step 2: Format Generation
```bash
opencode run --agent "generate formats: blog → thread → carousel → video script" --file content/repurpose-formats.md
```

### Step 3: Distribution
```bash
opencode run --agent "distribute: schedule across platforms" --file content/repurpose-distribute.md
```

## Repurposing Matrix
| Source | Formats |
|--------|---------|
| Blog post | Twitter thread, LinkedIn, Carousel, Email |
| Video | Blog transcript, Quotes, Shorts |
| Podcast | Blog, Quotes, Audiograms |
| Data | Infographic, Social stats, Email |

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Format Coverage | 30% |
| Quality | 25% |
| Platform Fit | 25% |
| Engagement | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - content/repurposed/
RL_SCORE: 95
SOURCE_PIECES: 8
OUTPUTS_CREATED: 32
```
