# Universal Writing & Copy Doctrine

## Message Hierarchy (Top-down Clarity)

Every page must answer, in order:

1. **Who it's for** — The specific persona
2. **What it does** — The functional value
3. **Outcome promised** — The transformation
4. **Why believe it** — Proof elements
5. **What to do next** — CTA

---

## Copy Frameworks

### PAS (Problem → Agitate → Solve)
**Use for:** Pain-aware markets

```
[Problem]: "Most websites lose 70% of visitors on the first screen"
[Agitate]: "That's money spent on ads, wasted. Every bounce is a lost customer."
[Solve]: "Here's how to fix it..."
```

### JTBD (Jobs-To-Be-Done)
**Use for:** Understanding customer motivation

```
[Job]: "Hire a website to generate leads"
[Trigger]: "Current site isn't converting"
[Desired Outcome]: "More qualified leads, less effort"
[Barriers]: "Don't know what to write, afraid of technical complexity"
```

### AIDA (Attention → Interest → Desire → Action)
**Use for:** Landing page sections

```
[Attention]: Headline that stops the scroll
[Interest]: Subhead with unexpected insight
[Desire]: Benefits that paint the after-state
[Action]: CTA that feels like the obvious next step
```

### "So What?" Ladder
**Use for:** Every claim must answer

```
Claim: "Our platform uses AI"
So what? "It learns from your data"
So what? "It predicts what customers want"
So what? "You make offers they can't refuse"
→ Final benefit: "You close 3x more deals"
```

---

## Objection-First FAQ Pattern

Structure every FAQ:

```
[Objection]: "What if it doesn't work for my industry?"
[Short Answer]: "It adapts to any vertical"
[Proof]: "We serve 12 industries, from healthcare to construction"
[Safety Net]: "Plus 30-day money-back guarantee"
```

---

## Proof Stack Types (Must Rotate)

Don't rely only on testimonials. Use variety:

1. **Logos** — Trusted company names
2. **Numbers** — "15,000+ customers", "4.9/5 rating"
3. **Process Transparency** — "Here's exactly how it works"
4. **Demos/Screens** — Visual proof of value
5. **Case Studies** — Before/after stories
6. **Guarantees/Risk Reversal** — "Cancel anytime", "Money back"
7. **Third-Party Citations** — "As seen in..."

---

## Pricing Psychology Rules

### Plan Names = Outcome or Persona
❌ Bad: "Basic / Pro / Premium"
✅ Good: "Starter / Professional / Enterprise"

### Required Elements
- [ ] "Most Popular" badge on middle tier
- [ ] "Best for" line under each plan
- [ ] Info tooltips for complex features
- [ ] Switch/cancel language near CTA
- [ ] FAQs directly beneath pricing

---

## Standard Copy Blocks

### Hero Block Template
```
[H1]: Headline with outcome
[Subhead]: Specific who + what + why
[3 Bullets]:
  - Benefit with metric
  - Benefit with metric
  - Benefit with metric
[Primary CTA]: Action + outcome
[Secondary CTA]: Lower commitment option
[Proof]: Logo strip above fold
```

### Benefits Block Template
```
[H2]: "What you'll get"
[3-6 Benefits]:
  [Icon] [H3] Benefit title
  [P] Specific outcome
  [Optional] "So what" line
[CTA]: Contextual link or button
```

### Features Block Template
```
[H2]: "How it works"
[3-6 Features]:
  [Icon] [H3] Feature name
  [P] What it does
  [P] Why it matters (benefit translation)
[Visual]: Screenshot or demo
```

### Social Proof Block Template
```
[Logo Strip] — 4-6 company logos
[Testimonial] — Quote + photo + name + title
[Stats] — "X customers", "Y% improvement", "Z rating"
[Case Study Teaser] — Before/after
[CTA]: "See similar results"
```

### Pricing Block Template
```
[H2]: "Simple pricing, powerful results"
[3 Tiers]:
  [Plan Name] — Outcome-based
  [Price] — Annual/Monthly toggle
  [Features] — Checkmark list
  ["Most Popular"] — Badge on middle
  [CTA]: Action + plan name
[FAQ] — 3-5 questions below
```

### Comparison Block Template
```
[H2]: "How we compare"
[Table]: Us vs Competitors
[Highlight]: Our column emphasized
[CTA]: "Choose [Our Product]"
```

### FAQ Block Template
```
[H2]: "Common questions"
[5-10 FAQs]:
  [Q] Question as customer would ask
  [A] Direct answer
  [Proof] Evidence
  [Safety Net] Guarantee/risk reversal
[Final CTA] — "Still have questions?"
```

### Final CTA Block Template
```
[H2]: Headline with urgency or value
[Subhead]: Remove final objections
[Primary CTA]: Big button
[Secondary CTA]: Lower friction option
[Trust Badge]: "No credit card required" or "Cancel anytime"
```

---

## Voice Guidelines

### Tone
- **Confident** — Not arrogant, but assured
- **Direct** — No fluff
- **Specific** — Numbers over adjectives

### Reading Level
- Target: Grade 7-9
- Tool: Hemingway Editor
- Goal: "Good" or "Very Good"

### Forbidden Words
Replace vague claims with proof:

| ❌ Vague | ✅ Specific |
|----------|-------------|
| "Best" | "Top-rated by X customers" |
| "Easy" | "Set up in 10 minutes" |
| "Simple" | "One-click deployment" |
| "Powerful" | "Handles 10,000 requests/sec" |
| "Seamless" | "Works with your existing stack" |
| "World-class" | "99.99% uptime SLA" |

---

## Standard Website Output Format

Every page script must output:

### Section List with IDs
```json
{
  "sections": [
    {"id": "hero", "type": "hero"},
    {"id": "benefits", "type": "benefits"},
    {"id": "features", "type": "features"}
  ]
}
```

### Semantic HTML Mapping
```json
{
  "headings": [
    {"level": "H1", "text": "...", "section": "hero"},
    {"level": "H2", "text": "...", "section": "benefits"}
  ]
}
```

### JSON-LD Schema Bundle
```json
{
  "schemas": ["Organization", "WebPage", "FAQPage"]
}
```

### Internal Link Targets
```json
{
  "links": [
    {"from": "hero", "to": "/pricing", "text": "See pricing"}
  ]
}
```

### Agent Readable Summary
```
This page is a landing page for [product], targeting [persona].
It emphasizes [key benefit] and includes [proof elements].
Primary CTA is [action], expected conversion rate [X%].
```

---

## RL Scoring (Marketing/Website Scripts)

### Writing Quality Rubric
| Criterion | Points |
|-----------|--------|
| Clarity | 0-20 |
| Specificity | 0-15 |
| Proof Strength | 0-15 |
| Skimmability | 0-10 |
| CTA Strength | 0-10 |
| Objection Handling | 0-10 |
| SEO/AIEO Compliance | 0-20 |
| **TOTAL** | **100** |

**REQUIREMENT: ≥95 for DONE**

### If RL_SCORE < 95
1. Trigger Ralph loop
2. Rewrite copy blocks
3. Improve proof stack
4. Tighten CTA
5. Re-score

---

## Validation Checklist (Per File)

- [ ] No vague words without proof
- [ ] Every CTA = Action + Outcome
- [ ] Benefits:Features ratio ≥ 2:1
- [ ] Reading level 7-9
- [ ] Contains all required copy blocks
- [ ] Proof stack has 3+ types
- [ ] FAQs cover top 5 objections
- [ ] Pricing has psychology elements
- [ ] Schema included
- [ ] RL score ≥95

**LOG:** COPY VALIDATED: `<path>` + timestamp
