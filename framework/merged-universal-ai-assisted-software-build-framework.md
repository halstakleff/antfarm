# Merged Universal AI-Assisted Software Build Framework

**Version:** 2.0  
**Last Updated:** 2026-02-22  
**Purpose:** Complete lifecycle protocol for AI-assisted software builds with Ralph loops, Microsoft RL scoring, and swarm orchestration.

---

## Table of Contents

1. [Overview & Philosophy](#1-overview--philosophy)
2. [Pre-Build Base Layers](#2-pre-build-base-layers)
3. [Build Lifecycle Phases](#3-build-lifecycle-phases)
   - [Phase 0: Inception & Alignment](#phase-0-inception--alignment)
   - [Phase 1: Requirements & Contracts](#phase-1-requirements--contracts)
   - [Phase 2: Design & Architecture](#phase-2-design--architecture)
   - [Phase 3: Foundation Setup](#phase-3-foundation-setup)
   - [Phase 4: Vertical Slice Build](#phase-4-vertical-slice-build)
   - [Phase 5: Hardening & Validation](#phase-5-hardening--validation)
   - [Phase 6: UI/UX Polish](#phase-6-uiux-polish)
   - [Phase 7: Release Preparation](#phase-7-release-preparation)
   - [Phase 8: Post-Launch Operations](#phase-8-post-launch-operations)
4. [Severity Enforcement Model](#4-severity-enforcement-model)
5. [Swarm Orchestration](#5-swarm-orchestration)
6. [Sacred Documents](#6-sacred-documents)
7. [Ralph Loop Execution](#7-ralph-loop-execution)
8. [Microsoft RL Scoring](#8-microsoft-rl-scoring)
9. [Final Doctrine](#9-final-doctrine)

---

## 1. Overview & Philosophy

### Core Principles

This framework establishes a **memory-proof, reproducible, verifiable** protocol for large-scale software development using AI assistance. Every phase includes:

- **Canonical script structure** with mandatory sections
- **Ralph loop iteration** (fresh context per cycle)
- **Microsoft RL scoring** (≥95 threshold for completion)
- **OpenCode CLI integration** (all code changes via OpenCode)
- **Sacred document updates** (PROJECT_KB.md, ARCHITECTURE.md, etc.)

### Execution Flow

```
Phase 0 → Phase 1 → Phase 2 → Phase 3 → Phase 4 → Phase 5 → Phase 6 → Phase 7 → Phase 8
     ↓
   [RL Score ≥95 required before advancing]
```

---

## 2. Pre-Build Base Layers

Before any project-specific work, establish these foundation layers:

### A) Opinionated Backend
- Stack selection documented
- Project structure enforced
- Module boundaries defined

### B) Auth & RBAC (Day 0)
- Authentication system in place
- Role-based access control configured
- Identity providers integrated

### C) Database & Migrations
- Schema versioning established
- Migration tooling configured
- Rollback procedures documented

### D) Admin Panel Generator
- CRUD scaffolding automated
- Permission-aware UI generation
- Audit logging included

### E) UI Component Library
- Design system established
- Reusable components catalogued
- Storybook or equivalent configured

### F) Form & Table Primitives
- Validation patterns standardized
- Pagination/filtering/sorting unified
- Error handling consistent

### G) API Contract & Typed Client
- OpenAPI/Swagger specs generated
- Type-safe clients (TypeScript/Go/etc.)
- Contract-first development enforced

### H) Workflow Engine
- State machines defined
- Job queues configured
- Event-driven patterns established

### I) Background Jobs
- Queue workers configured (Bull, Celery, etc.)
- Job scheduling and retries
- Dead letter handling

### J) Observability (Day 1)
- Structured logging (JSON)
- Metrics collection (Prometheus)
- Distributed tracing (OpenTelemetry)
- Alerting rules defined

### K) Testing Harness
- Unit test framework
- Integration test setup
- E2E test scaffold
- Coverage thresholds

### L) CI/CD & Environments
- Build pipelines configured
- Multiple environments (dev/staging/prod)
- Infrastructure as code
- Secrets management

### M) Secrets & Config
- Environment variable management
- Encryption at rest/transit
- Rotation procedures

### N) Resilience Basics
- Circuit breakers configured
- Rate limiting implemented
- Health checks standardized

### O) Repository Standards
- Conventional commits enforced
- Branch protection rules
- PR templates
- Code review requirements

---

## 3. Build Lifecycle Phases

### Phase 0: Inception & Alignment

**Purpose:** Establish what we're building, why, and the guardrails.

**Scripts:**
- `phase0-ideation-product-thesis.md` — Core problem statement, success metrics
- `phase0-risk-constraint-mapping.md` — Technical, business, and operational risks
- `phase0-critical-invariants.md` — Non-negotiable constraints and boundaries

**Output:** Product thesis document, risk register, invariant list

**RL Scoring:**
- Completeness: 30%
- Risk coverage: 25%
- Constraint clarity: 20%
- Success metric definition: 15%
- Stakeholder alignment: 10%

---

### Phase 1: Requirements & Contracts

**Purpose:** Define what success looks like before building.

**Scripts:**
- `phase1-functional-requirements.md` — User stories, acceptance criteria
- `phase1-scope-governance.md` — In/out of scope definitions, change process
- `phase1-api-contract-first.md` — OpenAPI specs, endpoint definitions
- `phase1-role-permission-matrix.md` — RBAC matrix, permission boundaries

**Output:** Requirements document, API specs, permission model

---

### Phase 2: Design & Architecture

**Purpose:** Design before code.

**Scripts:**
- `phase2-stack-selection.md` — Technology choices with trade-off analysis
- `phase2-data-model-er-diagram.md` — Entity relationships, database schema
- `phase2-state-machine-design.md` — State transitions, event flows
- `phase2-concurrency-idempotency.md` — Race conditions, idempotency keys

**Output:** Architecture diagrams, data models, state machines

---

### Phase 3: Foundation Setup

**Purpose:** Build the foundation that everything else rests on.

**Scripts:**
- `phase3-backend-foundations.md` — Core modules, dependency injection
- `phase3-data-foundations.md` — Database setup, migrations
- `phase3-observability-setup.md` — Logging, metrics, tracing
- `phase3-testing-harness.md` — Test infrastructure, fixtures
- `phase3-ci-cd-pipeline.md` — Build, test, deploy pipelines
- `phase3-agent-guardrails.md` — AI agent boundaries, safety checks

**Output:** Working foundation code, CI/CD pipelines

---

### Phase 4: Vertical Slice Build

**Purpose:** Build end-to-end functionality one slice at a time.

**Scripts:**
- `phase4-vertical-slice-build.md` — Full-stack feature implementation
- `phase4-ai-swarm-governance.md` — Multi-agent coordination
- `phase4-commit-standard.md` — Commit conventions, changelog generation

**Output:** Working features, integrated components

---

### Phase 5: Hardening & Validation

**Purpose:** Make it production-ready.

**Scripts:**
- `phase5-validation-hardening.md` — Input validation, sanitization
- `phase5-data-integrity.md` — Constraints, constraints, constraints
- `phase5-security-rbac.md` — Security audit, permission enforcement
- `phase5-concurrency-safety.md` — Locking, transactions, safety checks

**Output:** Hardened codebase, security audit report

---

### Phase 6: UI/UX Polish

**Purpose:** Make it usable and delightful.

**Scripts:**
- `phase6-ui-state-enforcement.md` — State management, error boundaries
- `phase6-ux-walkthroughs.md` — User journeys, friction points

**Output:** Polished UI/UX, accessibility compliance

---

### Phase 7: Release Preparation

**Purpose:** Prepare for production.

**Scripts:**
- `phase7-release-gate.md` — Go/no-go criteria
- `phase7-staging-verification.md` — Staging environment validation
- `phase7-production-launch.md` — Deployment checklist, rollback plan

**Output:** Production-ready release, deployment validated

---

### Phase 8: Post-Launch Operations

**Purpose:** Learn and improve.

**Scripts:**
- `phase8-post-launch-monitoring.md` — Monitoring, alerting, SLOs
- `phase8-debt-governance.md` — Technical debt tracking, triage
- `phase8-continuous-quality-loop.md` — Feedback integration, iteration

**Output:** Operational procedures, improvement backlog

---

## 4. Severity Enforcement Model

### Severity Levels

- **S0 (Critical):** Data loss, security breach, system down → STOP immediately
- **S1 (High):** Feature broken, significant user impact → Fix before proceeding
- **S2 (Medium):** Non-critical bug, workaround exists → Schedule fix
- **S3 (Low):** Cosmetic, nice-to-have → Backlog for future

### Stop Conditions

Stop and fix immediately if:
- Tests fail (S0)
- Security vulnerability found (S0)
- Type errors introduced (S1)
- Breaking change without migration (S1)

---

## 5. Swarm Orchestration

### One-Layer-Deep Spawn Rules

Agents can spawn sub-agents one level deep:
```
Master Orchestrator (You)
  → Layer 1: Architect, Developer, etc.
    → Layer 2: Specialized workers (max 3 per parent)
      → NO FURTHER SPAWNING
```

### Task Sharding

Break large tasks into sub-agent work packets:
- Clear input/output contracts
- Dependency ordering
- Parallel execution where possible

### Merge & Deduplication

- Sub-agent outputs merged by parent
- Deduplication before PROJECT_KB.md update
- Conflict resolution rules defined

---

## 6. Sacred Documents

Every phase updates these documents:

### PROJECT_KB.md
Living knowledge base:
- Patterns discovered
- Decisions made
- Issues resolved
- RL scores per iteration

### ARCHITECTURE.md
System design:
- Module boundaries
- Data flows
- Interface contracts
- Diagrams (Mermaid/PlantUML)

### RL_SCORES.md
Scoring history and rubrics

### CHANGELOG.md
Versioned changes per release

---

## 7. Ralph Loop Execution

### Execution Pattern

```bash
#!/bin/bash
ITERATION=0
MAX_ITERATIONS=5
RL_THRESHOLD=95

while [ $ITERATION -lt $MAX_ITERATIONS ]; do
    ITERATION=$((ITERATION + 1))
    
    # Fresh OpenCode session
    opencode run --agent "execute task" --session "ralph-$ITERATION"
    
    # Calculate RL score
    RL_SCORE=$(calculate_rl_score)
    
    # Persist to PROJECT_KB.md
    echo "Iteration $ITERATION: RL_SCORE=$RL_SCORE" >> PROJECT_KB.md
    
    if [ $RL_SCORE -ge $RL_THRESHOLD ]; then
        echo "STATUS: done"
        exit 0
    fi
done

echo "STATUS: failed - max iterations reached"
exit 1
```

### Fresh Context Per Iteration

- Each iteration spawns fresh agent session
- State persists only via:
  - Git commits
  - PROJECT_KB.md
  - Sacred documents
  - Progress files

---

## 8. Microsoft RL Scoring

### Scoring Rubric (Implementation Tasks)

| Criteria | Weight | Thresholds |
|----------|--------|------------|
| Completeness | 25% | 80=iteration, 90=PR, 95=release |
| Tests Pass | 20% | Must be green |
| Typecheck | 15% | Zero errors |
| Security | 20% | No vulns/exposures |
| Performance | 10% | Matches baseline |
| Maintainability | 10% | Clean code, SOLID |

### Formula

```
Raw Score = Σ(criterion_score × weight)
RL Score = Raw Score as percentage (0-100)
```

### Mandatory Reporting

```
RL_SCORE: 97
STATUS: done|loop|failed
EVIDENCE: <what was accomplished>
FAILED_CRITERIA: <if any>
```

---

## 9. Final Doctrine

### Non-Negotiable Rules

1. **All code changes via OpenCode CLI** — Never raw edits
2. **Ralph loops mandatory** — Fresh context per iteration
3. **RL ≥95 for done** — No exceptions
4. **Sacred documents updated** — Every phase
5. **Severity enforcement** — S0/S1 stop conditions
6. **One-layer spawn** — Swarm discipline
7. **Verification runs** — Every script, every time

### Success Definition

A successful build:
- All phases complete with RL ≥95
- Sacred documents current
- Tests passing
- Security audit clean
- Stakeholder sign-off

---

**END OF MERGED FRAMEWORK**

*This document serves as the authoritative reference for all build scripts and skills.*
