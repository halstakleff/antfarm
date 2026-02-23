# Pre-Build: UI Component Library

## Purpose

Reusable component catalog with design system.

## Step-by-Step

### Step 1: Base Components
```bash
opencode run --agent "create base components: Button, Input, Card, Modal, Table" --file ui/components/base/
```

### Step 2: Design System
```bash
opencode run --agent "define design system: colors, typography, spacing, shadows" --file ui/theme.ts
```

### Step 3: Storybook
```bash
opencode run --agent "setup Storybook for component documentation" --file .storybook/main.js
```

## Status Output

```
STATUS: done
FILES_MODIFIED:
  - ui/components/
  - theme.ts
RL_SCORE: 95
```
