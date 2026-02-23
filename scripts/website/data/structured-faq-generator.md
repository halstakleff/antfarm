# Structured FAQ Generator

## Purpose
Generate FAQ content with embedded JSON-LD schema for LLM visibility.

## Step-by-Step

### Step 1: Question Research
```bash
opencode run --agent "research questions: SERP 'People Also Ask', AnswerThePublic, competitor FAQs" --file website/faq-questions.md
```

### Step 2: Answer Generation
```bash
opencode run --agent "generate answers: concise, direct, scannable" --file website/faq-answers.md
```

### Step 3: Schema Injection
```bash
opencode run --agent "inject FAQPage schema: Question + acceptedAnswer pairs" --file website/faq-schema.md
```

## Output Format
```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [{
    "@type": "Question",
    "name": "What is...?",
    "acceptedAnswer": {
      "@type": "Answer",
      "text": "Answer..."
    }
  }]
}
</script>
```

## RL Scoring Rubric
| Criterion | Weight |
|-----------|--------|
| Question Relevance | 30% |
| Answer Clarity | 25% |
| Schema Validity | 25% |
| LLM Visibility | 20% |

## Status Output
```
STATUS: done
FILES_MODIFIED:
  - website/sections/FAQ.tsx
  - website/data/faqs.json
RL_SCORE: 97
FAQ_ITEMS_GENERATED: 12
```
