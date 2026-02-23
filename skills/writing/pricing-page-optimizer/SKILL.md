---
skill_name: pricing-page-optimizer
version: 1.0.0
required_tools: [opencode CLI, currency converter]
input_schema:
  tiers: array
  plan_names: array
  features: array
  target_currency: string
output_schema:
  optimized_tiers: array
  anchor_price: number
  highlighted_tier: number
  best_for_labels: array
  tooltips: array
  switching_language: string
  faqs: array
  rl_score: number
side_effects: [generates pricing page copy]
minimal_self_test_command: node test/pricing-test.js
---

# Pricing Page Optimizer

## Purpose
Optimize pricing pages using psychological triggers.

## Input Schema

```yaml
tiers:
  - name: "Starter"
    price: 29
    features: ["1 user", "100 contacts", "Email support"]
  - name: "Professional"
    price: 99
    features: ["5 users", "10k contacts", "Priority support"]
  - name: "Enterprise"
    price: 299
    features: ["Unlimited", "Dedicated support", "Custom features"]
target_currency: "USD"
```

## Output Schema

```yaml
optimized_tiers:
  - name: "Starter"  # → "For Side Projects"
    price: 29
    best_for: "Side projects and testing"
    annual_price: 290  # 2 months free
    highlight: false
  - name: "Professional"
    price: 99
    best_for: "Growing teams who need results"
    annual_price: 990
    highlight: true  # "Most Popular"
    badge: "Most Popular"

tooltips:
  - feature: "Priority support"
    tooltip: "Get answers within 2 hours"

faqs:
  - Q: "Can I switch plans?"
    A: "Yes, anytime. Prorated automatically."

rl_score: 96
```

## Psychology Rules
- Anchor high price first
- Middle tier = "Most Popular"
- Show annual savings ("2 months free")
- Plan names = outcome/persona
- Tooltips for complex features
- FAQ below pricing

## Usage

```bash
opencode run --agent "optimize pricing for SaaS with 3 tiers" --file pricing/
```
