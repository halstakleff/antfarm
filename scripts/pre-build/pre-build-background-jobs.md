# Pre-Build: Background Jobs

## Purpose

Queue-based job processing with retries.

## Step-by-Step

### Step 1: Job Queue
```bash
opencode run --agent "setup queue: Bull/BullMQ/Celery, job definitions" --file workers/queue.ts
```

### Step 2: Worker Process
```bash
opencode run --agent "background workers: job handler, retry logic, dead letter" --file workers/worker.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - workers/
RL_SCORE: 96
```
