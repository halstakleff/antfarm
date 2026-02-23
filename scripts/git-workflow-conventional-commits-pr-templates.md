# Git Workflow: Conventional Commits + PR Templates

## Purpose

Standardize commits and PRs.

## Step-by-Step

### Step 1: Commit Convention
```bash
opencode run --agent "enforce conventional commits: feat:, fix:, docs:" --file .github/commitlint.yml
```

### Step 2: PR Template
```bash
opencode run --agent "PR template: checklist, description" --file .github/pull_request_template.md
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
