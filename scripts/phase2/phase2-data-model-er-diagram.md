# Phase 2: Data Model & ER Diagram

## Purpose

Design complete data model with relationships before code. Schema-first database design.

## Step-by-Step

### Step 1: Entity Identification
```bash
opencode run --agent "identify all entities from requirements: User, Order, Product, etc." --file data/entities.md
```

### Step 2: ER Diagram
```bash
opencode run --agent "create Mermaid ER diagram: entities, relationships, cardinalities" --file data/er-diagram.md
```

### Step 3: Schema Definition
```bash
opencode run --agent "write SQL DDL: tables, columns, types, constraints, indexes" --file data/schema.sql
opencode run --agent "define migrations: create, alter, rollback" --file data/migrations.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - data/er-diagram.md
  - data/schema.sql
RL_SCORE: 96
NEXT_STEPS: Phase 2c - State Machine
```
