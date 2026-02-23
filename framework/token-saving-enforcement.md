# Token-Saving Enforcement Rules v4.2

## FAST Mode Output Rules

### ❌ NEVER Do
- Print evidence blocks
- Over-structure responses
- Re-state context
- Add speculative filler
- Include verbose reasoning

### ✅ ALWAYS Do
- Keep responses concise
- Focus on actionable content
- Use brief summaries
- Reference artifacts by path
- Omit obvious explanations

### FAST Output Template
```
## Analysis
[2-3 sentences max]

## Key Points
- Point 1
- Point 2
- Point 3

Assumptions: [material only]
```

## STRICT Mode Output Rules

### ❌ NEVER Do
- Print full evidence dumps
- Repeat spec sections
- Include boilerplate warnings
- Verbose step-by-step unless requested

### ✅ ALWAYS Do
- Print evidence summary only (3 lines max)
- Link to artifact path
- Provide rollback + verification commands
- Summarize long outputs

### STRICT Output Template
```
## Evidence Summary
[3 lines max]
- Verification: V3 ✓
- Severity: S2
- Confidence: HIGH

Artifact: outputs/verification/TIMESTAMP/report.json
Rollback: [command]
```

## Global Token Rules

| Rule | Implementation |
|------|----------------|
| Avoid duplicate reasoning | Reference prior, don't repeat |
| Avoid speculative filler | State facts only |
| Compress long explanations | Summary + link |
| Prefer structured JSON | When chaining agents |
| Summarize tool outputs | First 10 lines + "..." |
| Skip unchanged context | "As previously established..." |
| Use abbreviations | Standard: ✅, ❌, →, etc. |
| Omit obvious steps | "Step 1: Open file" not needed |

## Cost-Aware Verification

### Hash Caching
- Check PROJECT_KB.md before file operations
- Skip verification if hash unchanged
- Reference prior artifact

### Tool Call Optimization
```
# ❌ WRONG: Redundant calls
cat file.txt
cat file.txt
cat file.txt

# ✅ RIGHT: Cache result
CONTENT=$(cat file.txt)
echo "$CONTENT"
echo "$CONTENT"
```

## RL Scoring for Token Efficiency

| Metric | Target | Penalty |
|--------|--------|---------|
| Tokens per task | <500 (FAST) | -5 if >1000 |
| Redundant content | 0% | -10 if >10% |
| Evidence blocks (FAST) | 0 | -5 if present |
| Artifact links | Present | -5 if missing |

## Examples

**❌ VERBOSE (BAD)**
```
I'll help you with that. Let me start by first checking what files exist in the directory...
[10 lines of tool output]
Now I'll read the file...
[20 lines of file content]
Based on what I see, I think the answer is...
```

**✅ CONCISE (GOOD)**
```
## Analysis
File contains X. Solution is Y.

## Action
[do Y]
```

**❌ EVIDENCE DUMP (BAD)**
```
Here is the complete tool output showing every step:
[50 lines]
```

**✅ SUMMARY (GOOD)**
```
## Evidence Summary
- 3 files changed
- 1 test failed
- Report: outputs/verification/20260223/report.json
```

## Enforcement

| Violation | Action |
|-----------|--------|
| Token count > threshold | RL score penalty |
| Evidence block in FAST | Request rewrite |
| Missing artifact link (STRICT) | Request add |
| Repetitive content | Auto-summarize |

---

**Applied automatically on all outputs.**
