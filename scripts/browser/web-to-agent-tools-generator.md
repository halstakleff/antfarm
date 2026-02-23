---
script_id: browser-web-to-agent-tools-generator
version: 1.0.0
sacred_docs: [PROJECT_KB.md]
framework_refs: [framework/browser-agent-layer.md]
---

# Script: Web-to-Agent Tools Generator

## Title
Web-to-Agent — Generate Actionable Tools from Website

## Purpose
Analyze any website to generate TypeScript functions that can interact with it: click buttons, fill forms, extract data, and navigate.

## When to Run
- Building automation workflows
- Creating integration tools
- Competitor monitoring setup
- Lead generation automation

## Prerequisites
- HYPERBROWSER_API_KEY
- Target URL with interactive elements

## Inputs

| Field | Type | Required | Default |
|-------|------|----------|---------|
| url | string | Yes | - |
| element_types | array | No | ["button", "input", "form"] |
| generate_tests | boolean | No | true |

## Outputs

| File | Path | Description |
|------|------|-------------|
| tools.ts | outputs/browser/<date>/<task>/generated/tools.ts | TypeScript functions |
| tool_manifest.json | outputs/browser/<date>/<task>/tool_manifest.json | Tool metadata |
| selector_validation.json | outputs/browser/<date>/<task>/selector_validation.json | Validation results |

## Step-by-Step Execution

### Step 1: Crawl and Extract
```bash
# Get interactive elements
node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs extract \
  "$url" \
  '{
    "buttons": "button, [role=button], .btn",
    "inputs": "input[type=text], input[type=email], textarea",
    "forms": "form"
  }' > /tmp/elements.json
```

### Step 2: Classify Elements
```javascript
// Generate tool descriptions
const tools = elements.map(el => ({
  name: `${el.type}_${el.text.toLowerCase().replace(/\s+/g, '_')}`,
  description: `${el.type}: ${el.text}`,
  selector: el.selector,
  action: el.type === 'button' ? 'click' : 'input',
  params: el.type === 'input' ? ['value'] : []
}));
```

### Step 3: Generate TypeScript
```typescript
// tools.ts template
export const siteTools = {
  search: {
    selector: '#search-input',
    action: async (page, query) => {
      await page.fill('#search-input', query);
      await page.click('#search-btn');
    }
  },
  // ... more tools
};
```

### Step 4: Validate Selectors
```bash
# Test each selector exists
for selector in $(jq -r '.[].selector' tool_manifest.json); do
  node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs extract \
    "$url" \
    "{\"test\":\"$selector\"}" > /tmp/validation.json
  
  if [ $(jq '.extracted.test | length' /tmp/validation.json) -eq 0 ]; then
    echo "WARNING: Selector $selector not found"
  fi
done
```

### Step 5: Output
```json
{
  "url": "https://example.com",
  "tools_generated": 12,
  "valid_selectors": 10,
  "invalid_selectors": 2,
  "output_files": {
    "tools": "generated/tools.ts",
    "manifest": "tool_manifest.json"
  }
}
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Element detection | 30% |
| Selector accuracy | 25% |
| TypeScript validity | 20% |
| Validation coverage | 15% |
| Token efficiency | 10% |

## Status Output

```json
{
  "STATUS": "COMPLETE",
  "FILES_MODIFIED": [
    "outputs/browser/2026-02-22/site-tools/generated/tools.ts"
  ],
  "TEST_RESULTS": {
    "tools_generated": 12,
    "valid_selectors": 10
  },
  "RL_SCORE": 95,
  "NEXT_STEPS": ["Review invalid selectors"]
}
```
