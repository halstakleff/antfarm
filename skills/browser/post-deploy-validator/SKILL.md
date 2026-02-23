---
skill_name: post-deploy-validator
version: 1.0.0
required_tools: [hyperbrowser-sdk, curl]
input_schema:
  url: string
  checks: array
  fail_on_critical: boolean
output_schema:
  overall_status: string
  checks_passed: number
  checks_failed: number
  critical_failures: array
  regression_report_path: string
  confidence: number
side_effects: [browser_session, file_output]
minimal_self_test_command: scripts/browser/post-deploy-regression-suite.md
---

# Skill: Post-Deploy Validator

## Purpose
Automated QA after production deployment. Validates CTAs, pricing, schema, headings, navigation.

## Patterns Applied
- PATTERN-005: JSON Response
- PATTERN-008: Constrained Output

## Input Schema

```yaml
url: "https://example.com"
checks:
  - h1_present
  - cta_present
  - schema_valid
  - pricing_present
  - nav_links_work
fail_on_critical: true
```

## Output Schema

```json
{
  "analysis": "3 passed, 1 failed, 1 warning",
  "structured_output": {
    "overall_status": "FAIL",
    "checks_passed": 3,
    "checks_failed": 1,
    "critical_failures": ["missing_schema"],
    "regression_report_path": "outputs/browser/.../regression_report.json"
  },
  "confidence": 0.95
}
```

## RL Scoring

| Criterion | Weight |
|-----------|--------|
| Check coverage | 25% |
| Detection accuracy | 30% |
| Report clarity | 25% |
| Gating logic | 10% |
| Token efficiency | 10% |
