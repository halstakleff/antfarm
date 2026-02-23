---
skill_name: brand-voice-enforcer
version: 1.0.0
required_tools: [opencode CLI]
input_schema:
  content: string
  voice_profile: object
  checks: array
output_schema:
  violations: array
  tone_score: number
  voice_consistency: number
  rl_score: number
side_effects: [flags tone/voice issues]
minimal_self_test_command: opencode run --agent "check voice" --dry-run
---

# Brand Voice Enforcer

## Purpose
Enforce consistent brand voice across all copy.

## Input Schema

```yaml
content: "We are the leading provider of innovative solutions..."
voice_profile:
  tone: "confident, direct"
  reading_level: 8
  forbidden: ["leading", "innovative", "solutions"]
  required: ["you", "your"]
checks: ["tone", "clarity", "forbidden_words", "second_person"]
```

## Output Schema

```yaml
violations:
  - type: "forbidden_word"
    word: "leading"
    suggestion: "used by 15,000+"
  - type: "third_person"
    fix: "Change 'We' to 'You'"
tone_score: 85
voice_consistency: 92
suggestions:
  - "Replace corporate speak with specific claims"
  - "Use 'you' not 'customers'"
  - "Add concrete numbers"
rl_score: 94  # Below threshold - needs rewrite
```

## Voice Rules
- Use "you" not "customers"
- Specifics over generics
- Confidence over hedging
- Active voice
- Short sentences

## Usage

```bash
opencode run --agent "enforce brand voice on landing page copy" --file landing.md
```
