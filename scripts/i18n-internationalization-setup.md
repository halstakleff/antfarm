# i18n Internationalization Setup

## Purpose

Multi-language support.

## Step-by-Step

### Step 1: i18n Framework
```bash
opencode run --agent "setup i18n: react-i18n, ICU format" --file i18n/setup.ts
```

### Step 2: Translation Files
```bash
opencode run --agent "extract strings: JSON files" --file i18n/locales/
```

## Status Output

```
STATUS: done
RL_SCORE: 95
```
