# Swarm 4: Swimlane Status Reporting

## Purpose

Unified status from distributed agents.

## Status Format

```
SWARM_STATUS:
  AGENT: <id>
  STATUS: [pending|running|done|failed]
  RL_SCORE: [0-100]
  BLOCKED_BY: []
  BLOCKING: []
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
