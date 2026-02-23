---
skill_name: security-scan-orchestrator
version: 1.0.0
required_tools: [npm audit, trivy, snyk]
input_schema:
  scan_type: string
  severity_threshold: string
output_schema:
  vulnerabilities: array
  remediation_plan: object
side_effects: [scans dependencies]
minimal_self_test_command: npm audit --dry-run
---

# Security Scan Orchestrator

## Purpose

Orchestrate security scans.

## Scans

- Dependency vulnerabilities
- Container scanning
- Secret detection
- SAST
