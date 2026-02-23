# Pre-Build: Repository Standards

## Purpose

Conventional commits, branch protection, PR templates.

## Step-by-Step

### Step 1: Commit Standards
```bash
opencode run --agent "conventional commits: feat:, fix:, docs:, refactor:" --file .github/commits.md
```

### Step 2: Branch Protection
```bash
opencode run --agent "branch rules: require PR, required checks" --file .github/branch-protection.md
```

### Step 3: PR Template
```bash
opencode run --agent "PR template: checklist, description" --file .github/pull_request_template.md
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - .github/
RL_SCORE: 95
```
