---
skill_name: proof-stack-builder
version: 1.0.0
required_tools: [opencode CLI]
input_schema:
  available_proofs: array
  page_type: string
  target_skepticism: string
output_schema:
  proof_sequence: array
  logos: array
  testimonials: array
  stats: array
  case_studies: array
  third_party: array
  rl_score: number
side_effects: [generates proof stack content]
minimal_self_test_command: node test/proof-test.js
---

# Proof Stack Builder

## Purpose
Build varied proof stacks (not just testimonials).

## Input Schema

```yaml
available_proofs:
  - type: "logo"
    value: "Google"
  - type: "testimonial"
    value: "John, CEO of Acme: '10x ROI in 3 months'"
  - type: "stat"
    value: "15,000+ customers"
  - type: "case_study"
    value: "How Acme increased leads 340%"
page_type: "landing"
target_skepticism: "high"
```

## Output Schema

```yaml
proof_sequence:
  - position: "hero"
    type: "logos"
    content: ["Google", "Microsoft", "Amazon"]
  - position: "benefits"
    type: "stats"
    content: "15,000+ customers trust us"
  - position: "features"
    type: "demo"
    content: "Screen recording of product"
  - position: "social_proof"
    type: "testimonials"
    content: [3 quotes with photos]
  - position: "cta"
    type: "guarantee"
    content: "30-day money back"

diversity_score: 7/7
rl_score: 96
```

## Proof Types
1. Logos — Trust by association
2. Numbers — Quantified credibility
3. Process — Transparency builds trust
4. Demos — Visual proof
5. Case Studies — Narrative proof
6. Guarantees — Risk reversal
7. Third-Party — External validation

## Rule: Use ≥3 types per page

## Usage

```bash
opencode run --agent "build proof stack for enterprise SaaS landing page" --file proof/
```
