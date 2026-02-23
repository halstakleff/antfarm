# Swarm 2: Handoff Contract Template

## Purpose

Clear I/O contracts between agents.

## Template

```yaml
HANDOFF_CONTRACT:
  FROM: <agent_id>
  TO: <agent_id>
  INPUTS:
    - param: <name>
      type: <type>
      required: true|false
  OUTPUTS:
    - artifact: <name>
      path: <path>
  ACCEPTANCE_CRITERIA:
    - <criterion>
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
