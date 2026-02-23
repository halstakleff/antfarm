# Performance Profiling & Optimization

## Purpose

Profile and optimize performance.

## Step-by-Step

### Step 1: Profiling
```bash
opencode run --agent "profile: CPU, memory, async" --file perf/profile.ts
```

### Step 2: Optimization
```bash
opencode run --agent "optimize: hot paths, caching" --file perf/optimize.ts
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
