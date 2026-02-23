---
skill_name: performance-profiler
version: 1.0.0
required_tools: [clinic, clinic-doctor, 0x]
input_schema:
  target_script: string
  profile_type: string
output_schema:
  report_path: string
  hotspots: array
side_effects: [generates flamegraphs]
minimal_self_test_command: clinic --version
---

# Performance Profiler

## Purpose

Profile and identify performance bottlenecks.

## Usage

```bash
clinic doctor -- node app.js
```
