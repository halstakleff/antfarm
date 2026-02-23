# Multi-Platform Distribution Loop

## Purpose
Automate content distribution across platforms.

## Step-by-Step

### Step 1: Content Queue
```bash
opencode run --agent "queue content: schedule, prioritize" --file content/distribution-queue.md
```

### Step 2: Platform Adaptation
```bash
opencode run --agent "adapt: format for each platform" --file content/distribution-adapt.md
```

### Step 3: Publishing
```bash
opencode run --agent "publish: across platforms with tracking" --file content/distribution-publish.md
```

## Platforms
- LinkedIn
- Twitter/X
- Facebook
- Instagram
- YouTube
- Email
- Blog

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Platform Coverage | 30% |
| Adaptation Quality | 25% |
| Timing | 20% |
| Tracking | 15% |
| Engagement | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - content/distribution-schedule.json
RL_SCORE: 95
PLATFORMS: 7
POSTS_SCHEDULED: 42
```
