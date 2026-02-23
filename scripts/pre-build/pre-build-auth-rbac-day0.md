# Pre-Build: Auth & RBAC (Day 0)

## Purpose

Authentication and authorization from day one. Security-first approach.

## Step-by-Step

### Step 1: Auth Provider
```bash
opencode run --agent "setup auth: JWT/OAuth2/SSO, token validation, refresh flow" --file src/auth/provider.ts
```

### Step 2: Permission System
```bash
opencode run --agent "implement RBAC: roles, permissions, resource guards" --file src/auth/rbac.ts
```

### Step 3: Middleware
```bash
opencode run --agent "auth middleware: extract token, validate, attach user" --file src/api/middleware/auth.ts
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - auth provider
  - RBAC system
RL_SCORE: 97
```
