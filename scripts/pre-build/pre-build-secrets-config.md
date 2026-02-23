# Pre-Build: Secrets & Config

## Purpose

Secure secret management and environment config.

## Step-by-Step

### Step 1: Secret Store
```bash
opencode run --agent "secrets management: 1Password/Vault/AWS Secrets Manager" --file infra/secrets.md
```

### Step 2: Config Schema
```bash
opencode run --agent "config validation: zod/schema validation" --file src/config/schema.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - src/config/
RL_SCORE: 95
```
