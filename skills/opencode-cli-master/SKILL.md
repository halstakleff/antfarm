---
skill_name: opencode-cli-master
version: 1.0.0
required_tools: [opencode CLI]
input_schema:
  action: string
  file: string
  agent_prompt: string
output_schema:
  result: string
  files_modified: array
  session_id: string
side_effects: [modifies files, spawns sessions]
minimal_self_test_command: opencode --version
---

# OpenCode CLI Master

## Purpose

Route all code changes through OpenCode CLI.

## Commands

```bash
opencode run --file file.ts --agent "prompt"
opencode serve --dir ./repo
opencode attach --session ID
```

## Safety

- Never raw file edits
- Always LSP-backed
- Multi-model support
