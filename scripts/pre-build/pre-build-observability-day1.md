# Pre-Build: Observability (Day 1)

## Purpose

Structured logging, metrics, tracing from day one.

## Step-by-Step

### Step 1: Logging
```bash
opencode run --agent "structured JSON logging: correlation IDs, log levels" --file observability/logger.ts
```

### Step 2: Metrics
```bash
opencode run --agent "metrics collection: Prometheus, custom counters" --file observability/metrics.ts
```

### Step 3: Tracing
```bash
opencode run --agent "distributed tracing: OpenTelemetry spans" --file observability/tracing.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - observability/
RL_SCORE: 95
```
