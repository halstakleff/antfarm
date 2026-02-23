# Swarm 0: Spawn Policy

## Purpose

One-layer spawn rules.

## Spawn Rules

- Master can spawn Layer 1
- Layer 1 can spawn Layer 2 (max 3)
- No recursive spawning

## One-Layer Limitation

```
Master → Layer 1 → Layer 2
              ↓
              └─── STOP
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
