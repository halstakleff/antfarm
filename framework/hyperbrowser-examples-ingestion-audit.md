# Hyperbrowser Examples Ingestion Audit

**Source Repository**: https://github.com/hyperbrowserai/hyperbrowser-app-examples  
**Date**: 2026-02-22

## License Verification

**License Type**: MIT License (mentioned in README, no LICENSE file present)

**Permission Status**: ✅ PERMITTED for reference and pattern abstraction

**Attribution**: MIT License allows reuse with attribution; we implement our own patterns, not copy code.

## Repository Structure Analyzed

| Example Folder | Pattern We Use | Status |
|----------------|----------------|--------|
| scrape-to-api | Scrape-to-OpenAPI blueprint | ✅ Reference |
| site-to-dataset | Site-to-Dataset blueprint | ✅ Reference |
| web-to-agent | Web-to-Agent Tools generator | ✅ Reference |
| deep-crawler-bot | Multi-page crawling patterns | ✅ Reference |
| competitor-tracker | Monitoring patterns | ✅ Reference |

## Policy Statement

**We do NOT vendor/copy the repo into production paths.**

We:
1. Reference the examples for structural patterns
2. Implement our own canonical scripts and skills
3. Follow our existing framework standards
4. Add attribution where patterns inspire our implementation

## Key Patterns Extracted

### scrape-to-api Pattern
- Visual element selection
- REST API endpoint generation
- OpenAPI spec auto-generation
- TypeScript SDK scaffolding

### site-to-dataset Pattern
- Multi-page crawling with include/exclude rules
- Content extraction (title, headings, main content)
- Q/A generation from content
- JSONL export with quality scoring
- Deduplication strategy

### web-to-agent Pattern
- Interactive element extraction
- DOM analysis for actionable tools
- TypeScript function generation
- Live testing with screenshots

## Risk Assessment

| Risk | Level | Mitigation |
|------|-------|------------|
| Copyright violation | None | MIT license + original implementation |
| License ambiguity | Low | Documented as reference-only |
| Code similarity | Low | Complete rewrite in our style |

## Compliance Actions

- [x] Repository cloned to `vendor/` (not committed)
- [x] Examples referenced for patterns only
- [x] Original implementation created
- [x] Attribution documented

**Location of vendor clone**: `vendor/hyperbrowser-app-examples/` (gitignored)
