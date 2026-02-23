# Phase 1: API Contract First

## Purpose

Design API contracts before implementation. Contract-first development prevents integration failures.

## Step-by-Step

### Step 1: Endpoint Design
```bash
opencode run --agent "design REST/GraphQL endpoints with OpenAPI spec: paths, methods, request/response schemas, status codes" --file contracts/openapi.yaml
```

### Step 2: Schema Definition
```bash
opencode run --agent "define all request/response schemas with validation rules" --file contracts/schemas.md
```

### Step 3: Consumer Validation
```bash
opencode run --agent "validate API design against consumer needs, check for breaking changes" --file contracts/consumer-review.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - contracts/openapi.yaml
  - contracts/schemas.md
RL_SCORE: 97
NEXT_STEPS: Phase 1d - Permissions
```
