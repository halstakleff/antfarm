---
skill_name: faq-objection-writer
version: 1.0.0
required_tools: [opencode CLI]
input_schema:
  product: string
  common_objections: array
  guarantees: array
  target_audience: string
output_schema:
  faqs: array
  schema_ready: boolean
  objection_coverage: number
  rl_score: number
side_effects: [generates FAQ content + JSON-LD]
minimal_self_test_command: opencode run --agent "generate FAQs" --dry-run
---

# FAQ Objection Writer

## Purpose
Write objection-first FAQs that convert.

## Input Schema

```yaml
product: "AIOSEO"
common_objections:
  - "Will this slow down my site?"
  - "Do I need technical skills?"
  - "What if it doesn't work for my niche?"
guarantees:
  - "14-day money back"
  - "Cancel anytime"
  - "Free migration"
target_audience: "Solopreneurs"
```

## Output Schema

```yaml
faqs:
  - objection: "Will this slow down my site?"
    answer: "No—it adds zero load time"
    proof: "Our infrastructure runs separate from your site"
    safety_net: "Plus if you're unhappy, full refund in 14 days"
  - objection: "Do I need technical skills?"
    answer: "Nope. Takes 10 minutes to set up"
    proof: "Most users are non-technical"
    cta: "Watch the 3-minute setup video"

objection_coverage: 100%
schema_ready: true
rl_score: 97
```

## Structure Per FAQ
```
Question: Objection as customer asks
Answer: Direct, concise
Proof: Evidence/social proof
Safety Net: Guarantee/risk reversal
Micro-CTA: Contextual CTA
```

## Usage

```bash
opencode run --agent "write FAQs for CRM targeting solopreneurs" --file faqs/
```
