# Strict Mode Auto-Trigger Specification v4.2

**Purpose**: Define automatic switching from FAST to STRICT mode based on task content and file paths.

**Rule**: No manual mode selection. Detection is deterministic and exhaustive.

---

## TRIGGER CATEGORIES

### A. KEYWORD TRIGGERS

**CRITICAL** (Always → V3)
```yaml
- edit
- modify
- refactor
- fix
- patch
- update
- change
- replace
```

**EXECUTION** (Always → V3)
```yaml
- run
- execute
- install
- uninstall
- setup
- configure
```

**DEPLOYMENT** (Always → V3)
```yaml
- deploy
- release
- publish
- ship
- rollout
- promote
```

**GIT** (Always → V3)
```yaml
- git commit
- git push
- git merge
- pull request
- rebase
- revert
- reset
```

**WORKFLOW** (Always → V3)
```yaml
- workflow
- yaml
- yml
- antfarm
- opencode
- agent
- cron
- schedule
```

**DATABASE** (Always → V3)
```yaml
- schema
- database
- db
- migration
- migrate
- rollback
- seed
- populate
```

**AUTH** (Always → V3)
```yaml
- auth
- authentication
- authorization
- rbac
- permission
- role
- token
- secret
- credential
- login
- logout
- session
```

**SECURITY** (Always → V3)
```yaml
- security
- vulnerability
- exploit
- cve
- patch
- harden
- encrypt
- decrypt
- hash
- salt
```

**BUILD/DEV** (→ V2 minimum, V3 if config files)
```yaml
- lint
- tests
- test
- build
- compile
- bundle
- transpile
- ci
- cd
- pipeline
- github action
```

**PATH/STRUCTURE** (→ V2 minimum)
```yaml
- paths
- bootstrap
- directory
- folder
- structure
- organize
- move
- rename
- delete
- remove
- clean up
```

**ENVIRONMENT** (Always → V3)
```yaml
- production
- prod
- staging
- development
- dev
- local
- environment
- env
- dotenv
```

### B. FILE PATH TRIGGERS

**WORKFLOW FILES** (→ V3)
```regex
- workflows/.*\.yml$
- workflows/.*\.yaml$
- \.github/workflows/.*
```

**AGENT FILES** (→ V3)
```regex
- agents/.*bootstrap.*
- agents/.*instructions.*
- agents/.*\.md$
- agents/.*\.yml$
```

**TOOL FILES** (→ V3)
```regex
- tools/.*$
- scripts/.*$
```

**CONFIG FILES** (→ V3)
```regex
- package\.json$
- tsconfig.*\.json$
- next\.config\..*
- jsconfig.*\.json$
- .*config\.json$
- \.env.*
- \.gitignore$
```

**INFRA FILES** (→ V3)
```regex
- Dockerfile.*
- docker-compose.*\.yml$
- infra/.*
- deployment/.*
- terraform/.*
- kubernetes/.*
- k8s/.*
```

**MIGRATION FILES** (→ V3)
```regex
- .*migration.*
- migrate/.*
- migrations/.*
- \d{4}_\d{2}_\d{2}_.*
```

**SECURITY FILES** (→ V3)
```regex
- SECURITY\.md$
- .*secret.*
- .*key.*\.pem$
- .*\.key$
- \.htpasswd$
```

### C. RISK OVERRIDE TRIGGERS

**Production Risk** (Always → V3 + BLOCK on S0/S1)
```yaml
conditions:
  - environment: production
  - file: contains "prod" or "production"
  - task: mentions "live", "production", "customer-facing"
action: V3 + artifact required + rollback mandatory
```

**Data Risk** (Always → V3)
```yaml
conditions:
  - task: mentions "database", "schema", "migration"
  - file: ends with .sql, .prisma, .migration
action: V3 + dry-run first + backup mandatory
```

**Auth Risk** (Always → V3 + security verification)
```yaml
conditions:
  - task: mentions "auth", "login", "permission"
  - file: contains "auth", "session", "token"
action: V3 + security scan + manual review gate
```

**Breaking Change Risk** (Always → V3)
```yaml
conditions:
  - task: mentions "breaking", "breaking change", "API change"
  - file: public API surface
action: V3 + compatibility check + migration guide required
```

---

## DETECTION ALGORITHM

```python
def detect_mode(task_text: str, files: List[str]) -> Tuple[Mode, VLevel, List[str]]:
    triggers = []
    
    # Check keywords
    for keyword in KEYWORD_TRIGGERS:
        if keyword in task_text.lower():
            triggers.append(f"keyword:{keyword}")
    
    # Check file paths
    for pattern in FILE_TRIGGERS:
        if any(re.match(pattern, f) for f in files):
            triggers.append(f"file:{pattern}")
    
    # Check risk overrides
    for override in RISK_OVERRIDES:
        if override.matches(task_text, files):
            triggers.append(f"risk:{override.name}")
    
    # Determine mode
    if not triggers:
        return (FAST, V1, [])
    
    # STRICT mode
    if any("risk:" in t for t in triggers):
        return (STRICT, V3, triggers)
    
    if any(f in str(files) for f in V3_REQUIRED_FILES):
        return (STRICT, V3, triggers)
    
    if any(k in CRITICAL_KEYWORDS for k in triggers):
        return (STRICT, V3, triggers)
    
    return (STRICT, V2, triggers)
```

---

## VERIFICATION LEVEL MAPPING

| Trigger Category | V Level | Artifact Required |
|------------------|---------|-------------------|
| Development/conversation | V1 | No |
| Documentation review | V2 | No |
| Config change, non-critical | V2 | Yes |
| Code change, workflow, auth, security | V3 | Yes |
| Production deployment | V3 | Yes + rollback |
| Database migration | V3 | Yes + dry-run |

---

## OUTPUT FORMAT

```json
{
  "mode": "FAST|STRICT",
  "verification_level": "V1|V2|V3",
  "triggers": {
    "keywords": ["edit", "workflow"],
    "files": ["workflows/feature.yml"],
    "risk": ["production"]
  },
  "reason": "STRICT triggered by: keyword 'edit', file 'workflows/feature.yml'"
}
```

---

## EXAMPLES

**Example 1: Brainstorm**
```
Task: "Brainstorm landing page headlines"
Files: []
Result: FAST, V1
Triggers: []
```

**Example 2: Edit Workflow**
```
Task: "Edit the feature-dev workflow to add a new step"
Files: ["workflows/feature-dev/workflow.yml"]
Result: STRICT, V3
Triggers: ["keyword:edit", "keyword:workflow", "file:workflows/.*"]
```

**Example 3: Database Migration**
```
Task: "Create migration to add users table"
Files: ["migrations/20260222_add_users.sql"]
Result: STRICT, V3
Triggers: ["keyword:migration", "risk:data"]
```

**Example 4: Documentation Update**
```
Task: "Update README with new instructions"
Files: ["README.md"]
Result: STRICT, V2
Triggers: ["keyword:update", "file:README.md"]
```

---

## VERSION HISTORY

- 4.2: Added COST-AWARE mode, hash caching
- 4.1: Expanded file triggers, added risk overrides
- 4.0: Initial specification

**Last Updated**: 2026-02-22
