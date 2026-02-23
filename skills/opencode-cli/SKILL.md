---
name: opencode-cli
description: "MANDATORY wrapper for ALL coding tasks. Never write raw code—always route through OpenCode CLI."
user-invocable: false
---

# OpenCode CLI Skill

MANDATORY wrapper for ALL coding tasks. Never write raw code—always route through OpenCode.

## Installation

```bash
# Install OpenCode CLI globally
npm install -g @opencode/cli

# Or use npx
npx @opencode/cli <command>
```

## Usage Patterns

### Pattern 1: Single File Edit
```bash
opencode run --file src/utils.ts --agent "Add error handling to fetchData() function"
```

### Pattern 2: Multi-File Session
```bash
# Start persistent server
opencode serve --dir /path/to/repo

# In another terminal, attach and work
opencode attach --session <session-id> --prompt "Implement user authentication module"
```

### Pattern 3: Stateless Batch
```bash
opencode run --dir /path/to/repo --agent "Refactor all console.log to logger calls across the codebase"
```

## Required Flags

| Flag | Description |
|------|-------------|
| `--file` | Target specific file |
| `--dir` | Target directory (repo root) |
| `--agent` | Natural language task description |
| `--session` | Session ID for persistence |

## Tech Lead Protocol

1. **ALWAYS** use OpenCode for code changes
2. **NEVER** use direct file edit tools
3. **Export/Import** sessions for state across sub-steps
4. **Fork** sessions for parallel module work

## Example Workflows

```bash
# Create auth module
opencode run --dir ./src --agent "Create JWT authentication middleware with TypeScript"

# Debug failing test
opencode run --file tests/auth.test.ts --agent "Fix failing JWT verification test"

# Refactor
opencode run --dir ./src --agent "Refactor UserController to use Repository pattern"
```

## Safety

- OpenCode uses LSP for precise edits
- Multi-model support (Claude, GPT-4, Gemini)
- Built-in type checking
