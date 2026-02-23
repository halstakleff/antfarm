# Pre-Build: Resilience Basics

## Purpose

Circuit breakers, rate limiting, health checks.

## Step-by-Step

### Step 1: Circuit Breaker
```bash
opencode run --agent "circuit breaker: open/half-open/closed states" --file src/resilience/circuit-breaker.ts
```

### Step 2: Rate Limiting
```bash
opencode run --agent "rate limiting: token bucket, Redis-based" --file src/resilience/rate-limiter.ts
```

### Step 3: Health Checks
```bash
opencode run --agent "health checks: liveness, readiness" --file src/resilience/health.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - src/resilience/
RL_SCORE: 95
```
