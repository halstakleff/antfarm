# Pre-Build: Opinionated Backend Setup

## Purpose

Establish backend foundation with best practices before feature work. Sets architectural patterns.

## Step-by-Step

### Step 1: Project Structure
```bash
opencode run --agent "create folder structure: src/{domain,infra,api,workers}, tests/{unit,integration,e2e}, docs" --file structure.sh
```

### Step 2: Dependency Injection
```bash
opencode run --agent "setup DI container: service registration, lifetime scopes, module boundaries" --file src/infra/di.ts
```

### Step 3: Module Boundaries
```bash
opencode run --agent "define clean architecture: domain (business), application (use cases), infrastructure (details)" --file ARCHITECTURE.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - project structure
  - DI container
RL_SCORE: 95
```
