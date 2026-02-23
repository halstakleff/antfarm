# Browser Agent Security

**Version**: 1.0.0

---

## Environment Variables

### Required
```bash
HYPERBROWSER_API_KEY=hb_live_xxx  # Never commit
```

### Optional
```bash
HYPERBROWSER_BASE_URL=https://api.hyperbrowser.ai  # Self-hosted
BROWSER_RATE_LIMIT=10  # req/min
BROWSER_TIMEOUT_MS=30000
```

---

## Secrets Policy

- **API keys in .env only**: Never in source code
- **.env files in .gitignore**: Enforced
- **No logs with keys**: Sanitized in all outputs
- **Rotate quarterly**: Key rotation schedule

---

## Data Retention

| Data Type | Retention | Action After |
|-----------|-----------|--------------|
| Raw HTML | 30 days | Archive |
| Screenshots | 7 days | Delete |
| Extracted JSON | 90 days | Archive |
| Logs | 30 days | Compress |

---

## Domain Allowlist/Denylist

### Allowlist (Explicit Only)
By default, only these domains are permitted:
- `*.github.com`
- `*.example.com` (test)
- Explicitly configured domains

### Denylist (Always Blocked)
- Banking sites (*.bank)
- Government portals (*.gov)
- Private intranets
- Any domain with auth-required content

### Override Process
Add to `config/browser-domains.json`:
```json
{
  "allowed": ["client-site.com"],
  "denied": ["internal-dashboard.com"]
}
```

---

## PII Handling

Auto-redacted fields:
- Email addresses → `[EMAIL_REDACTED]`
- Phone numbers → `[PHONE_REDACTED]`
- Credit cards → `[PAYMENT_REDACTED]`
- SSNs → `[SSN_REDACTED]`

---

## Security Incidents

If unauthorized domain accessed:
1. Log incident
2. Alert via webhook
3. Block further requests
4. Manual review required

---

## Audit Trail

All browser actions logged to `BROWSER_USAGE.md`:
```yaml
- timestamp: "2026-02-22T21:00:00Z"
  script: "seo-audit"
  url: "example.com"
  skill_used: "dom-extractor"
  output_path: "outputs/browser/..."
  rl_score: 96
  errors: []
```
