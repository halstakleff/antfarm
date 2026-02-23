# Pre-Build: API Contract & Typed Client

## Purpose

Auto-generate types from OpenAPI specs.

## Step-by-Step

### Step 1: OpenAPI Generator
```bash
opencode run --agent "setup OpenAPI generator: TypeScript types, client SDK" --file api/openapi-generator.ts
```

### Step 2: Type-Safe Client
```bash
opencode run --agent "generate typed HTTP client from spec" --file api/typed-client.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - api/types/
RL_SCORE: 95
```
