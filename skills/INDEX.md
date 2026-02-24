# Skills Index

| Skill | Purpose | Input | Output |
|-------|---------|-------|--------|
| universal-framework-loader | Load framework scripts | project_path, phase | loaded_scripts, execution_plan |
| ralph-loop-with-rl-scoring | Iterate until score ≥95 | task, max_iterations | iteration_count, final_score |
| opencode-cli-master | Route code through OpenCode | action, file, prompt | result, session_id |
| invariant-enforcer | Verify invariants | invariants, code_path | violations, status |
| openapi-generator | Generate typed clients | spec_path, language | client_sdk_path |
| diagram-generator | Create architecture diagrams | diagram_type, source | output_path |
| git-workflow-enforcer | Enforce commit/PR standards | branch, message | pr_url, status |
| security-scan-orchestrator | Run security scans | scan_type, threshold | vulnerabilities |
| performance-profiler | Profile bottlenecks | target_script | report_path, hotspots |
| a11y-auditor | WCAG compliance | url, wcag_level | violations, score |
| test-coverage-enforcer | Enforce coverage | threshold, pattern | coverage_report |
| doc-auto-generator | Generate API docs | source_path | generated_docs |
| rollback-drill-simulator | Simulate rollbacks | deployment_name | rollback_plan |
| rl-scoring-rubric-applier | Calculate RL scores | task_type, artifacts | rl_score, breakdown |
| project-kb-updater | Update PROJECT_KB.md | update_type, content | updated_sections |
| sacred-document-validator | Validate sacred docs | document | is_valid, errors |
| pr-template-generator | Generate PR descriptions | commits | pr_body |
| full-lifecycle-orchestrator-wrapper | Orchestrate full build | project_type, phases | execution_plan |

## Verification Skills

| Skill | Purpose | Input | Output |
|-------|---------|-------|--------|
| tiered-reliability-enforcer | Auto FAST/STRICT verification | task_text, files_changed | mode, v_level, status |

## Browser Skills

| Skill | Purpose | Input | Output |
|-------|---------|-------|--------|
| rendered-html-fetcher | Get JS-rendered DOM | url, wait_for | html, metadata |
| dom-extractor | Extract via selectors | url, selectors | extracted, evidence |
| jsonld-schema-extractor | Validate schema | url, types | schemas, consistency |
| site-crawler | Multi-page crawl | seed_url, rules | pages[], index |
| page-anatomy-extractor | Full page structure | url | anatomy, hierarchy |
| llm-crawl-simulator | Raw vs rendered | url | coverage_gap, risks |
| dataset-generator | Site → JSONL | seed_url, selectors | dataset.jsonl |
| web-to-tools-generator | DOM → TypeScript | url, element_types | tools.ts |
| scrape-to-openapi-generator | Web → OpenAPI | url, selectors | openapi.yaml |
| post-deploy-validator | Post-deploy QA | url, checks | regression_report |

**Total: 28 skills (18 core + 10 browser)**

## Memory/Integration Skills

| Skill | Purpose | Input | Output |
|-------|---------|-------|--------|
| clawos-router | Low-token routing to ClawOS | task_type, project, stakes | allowed_paths, mode, caps |

**Total: 29 skills (18 core + 10 browser + 1 memory)**
