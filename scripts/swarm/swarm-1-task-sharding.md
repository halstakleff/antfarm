# Swarm 1: Task Sharding

## Purpose

Break tasks into sub-agent work packets.

## Sharding Strategy

### Step 1: Task Analysis
```bash
opencode run --agent "analyze task: independent sub-tasks" --file swarm/sharding/analyze.md
```

### Step 2: Packet Creation
```bash
opencode run --agent "create packets: clear I/O contracts" --file swarm/sharding/packets.md
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
