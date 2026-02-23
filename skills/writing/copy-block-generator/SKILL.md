---
skill_name: copy-block-generator
version: 1.0.0
required_tools: [opencode CLI, node]
input_schema:
  page_type: string
  target_persona: string
  key_benefit: string
  proof_elements: array
  cta_action: string
output_schema:
  hero_block: object
  benefits_block: object
  features_block: object
  social_proof_block: object
  pricing_block: object
  faq_block: object
  final_cta_block: object
  rl_score: number
side_effects: [generates copy files, validates against doctrine]
minimal_self_test_command: node test/copy-block-test.js
---

# Copy Block Generator

## Purpose
Generate standardized copy blocks following the Universal Writing Doctrine.

## Input Schema

```yaml
page_type: "landing"
target_persona: "Marketing Director"
key_benefit: "3x more leads from existing traffic"
proof_elements: ["15000 customers", "4.9/5 rating", "Case study: Acme Co"]
cta_action: "Start free trial"
```

## Output Schema

```yaml
hero_block:
  h1: "Turn Visitors Into Customers—Without More Traffic"
  subhead: "For Marketing Directors who need better conversion"
  bullets: [...]
  primary_cta: "Start Your Free Trial"
  secondary_cta: "See how it works"
  proof: "Join 15,000+ companies"

rl_score: 96
```

## Usage

```bash
opencode run --agent "generate copy blocks for landing page targeting enterprise sales teams" --file copy-blocks/
```

## RL Components
- Clarity: 20%
- Specificity: 15%
- Proof: 15%
- CTA Strength: 10%
- Objection Handling: 10%

**Threshold: ≥95**
