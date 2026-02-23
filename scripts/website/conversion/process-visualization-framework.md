# Process Visualization Framework

## Purpose
Visualize process steps in engaging, scannable formats.

## Step-by-Step

### Step 1: Process Mapping
```bash
opencode run --agent "map process: step 1 → step 2 → step 3 → outcome" --file website/process-map.md
```

### Step 2: Visual Selection
```bash
opencode run --agent "choose visualization: timeline, numbered steps, flow diagram, cards" --file website/process-visual.md
```

### Step 3: Component Build
```bash
opencode run --agent "build ProcessSteps component with animations" --file website/components/ProcessSteps.tsx
```

## Visualization Types
- **Timeline** — For chronological processes
- **Numbered Steps** — For how-to guides
- **Flow Diagram** — For decision trees
- **Cards** — For feature highlights
- **Before/After** — For transformation

## Structure
```
Step 1: [Icon] [Title] [Description]
   ↓
Step 2: [Icon] [Title] [Description]
   ↓
Step 3: [Icon] [Title] [Description]
   ↓
Outcome: [Result] [CTA]
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Clarity | 30% |
| Visual Appeal | 25% |
| Flow Coherence | 20% |
| Animation Smoothness | 15% |
| CTA Integration | 10% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/components/ProcessSteps.tsx
  - website/sections/Process.tsx
RL_SCORE: 95
STEPS_VISUALIZED: 4
```
