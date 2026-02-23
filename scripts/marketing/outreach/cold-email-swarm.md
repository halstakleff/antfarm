# Cold Email Swarm

## Purpose
Orchestrate cold email campaigns with personalized outreach.

## Step-by-Step

### Step 1: List Building
```bash
opencode run --agent "build: enrich contacts with Apollo, verify emails" --file outreach/email-list.md
```

### Step 2: Personalization
```bash
opencode run --agent "personalize: research each prospect, customize messages" --file outreach/email-personalize.md
```

### Step 3: Sequence Execution
```bash
opencode run --agent "execute: multi-touch sequences with tracking" --file outreach/email-sequence.md
```

## Email Framework
1. **Subject**: Curiosity + relevance
2. **Opening**: Context + personalization
3. **Value**: What's in it for them
4. **CTA**: Clear next step
5. **Follow-up**: 3-5 touch sequence

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Open Rate | 30% |
| Reply Rate | 30% |
| Meeting Rate | 25% |
| Deliverability | 15% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - outreach/campaign-report.json
RL_SCORE: 94
EMAILS_SENT: 500
OPEN_RATE: 45%
REPLY_RATE: 8%
```
