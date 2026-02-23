# Setup: Hyperbrowser SDK Wrapper

## Prerequisites

- Node.js 18+
- npm or yarn
- Hyperbrowser API key

## Installation

### 1. Install Hyperbrowser SDK

```bash
cd /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser
npm init -y
npm install @hyperbrowser/client
```

### 2. Set Environment Variable

```bash
export HYPERBROWSER_API_KEY="your_api_key_here"
```

Or create `.env`:
```
HYPERBROWSER_API_KEY=your_api_key_here
```

## Verification

Test the wrapper:

```bash
# Test render
node run.mjs render https://example.com --wait=2000

# Test extract
node run.mjs extract https://example.com '{"title":"h1","h2s":"h2"}'

# Test crawl
node run.mjs crawl https://example.com '{"max_pages":3}'

# Test screenshot
node run.mjs screenshot https://example.com
```

## Outputs

All commands output JSON to stdout:

```json
{
  "success": true,
  "url": "https://example.com",
  "title": "Example Domain",
  "timestamp": "2026-02-22T21:00:00Z"
}
```

## Integration

Scripts call via:

```bash
output=$(node /Users/nit/.openclaw/workspace/antfarm/tools/hyperbrowser/run.mjs render "$url")
echo "$output" | jq '.html'
```
