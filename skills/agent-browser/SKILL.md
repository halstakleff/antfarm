---
name: agent-browser
description: "Browser automation skill for visual verification and testing of frontend changes."
user-invocable: false
---

# Agent Browser Skill

Browser automation for visual verification during code review and testing.

## Capabilities

- Open local files (file:// URLs)
- Spin up dev servers for projects that require them
- Take screenshots of rendered pages
- Verify visual elements (layout, colors, styling)
- Check for console errors

## Usage

```javascript
// Open file directly
browser.open("file:///path/to/page.html");

// Or spin up dev server
browser.serve("npm run dev", { port: 3000 });
browser.open("http://localhost:3000");

// Take screenshot
browser.screenshot();

// Check console for errors
browser.console.check();
```

## Visual Verification Checklist

- Layout renders correctly (no broken/overlapping elements)
- Styling applied (colors, fonts, spacing)
- Content visible and readable
- Interactive elements look clickable
- No console errors in dev tools
- Overall design looks polished (not placeholder-quality)

## Integration

Used by:
- Verifier agent (verify frontend changes)
- Reviewer agent (design review)
- Tester agent (e2e visual tests)
