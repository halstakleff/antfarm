# Prompt Pattern Library

**Extraction Method**: Structural abstraction only. No verbatim copying.

---

## Pattern Catalog

### PATTERN-001: Role-Based Agent Framing

**Category**: Agent Architecture

**Structural Description**
- Agent identity defined at top of prompt
- Role clarity with specific responsibilities
- Capabilities enumerated explicitly
- Constraints listed as guardrails
- Tool access declared upfront

**Input Schema**
```yaml
agent_name: string
capabilities: array
tools: array
constraints: array
context_files: array
```

**Output Schema**
```yaml
agent_config:
  role: string
  tools_enabled: array
  file_access: array
  response_format: string
```

**Reasoning Separation Model**
- Planning phase before execution
- Analysis separate from implementation
- Confidence scoring on outputs

**Constraints**
- Must not execute destructive commands without confirmation
- Must validate schema before returning
- Must log all tool invocations

**Token Efficiency Strategy**
- Reference constraints by ID rather than full text
- Use abbreviated role descriptors
- Group tool descriptions

**Example Invocation**
```yaml
use_pattern: role-based-agent
input:
  agent_name: "Code Reviewer"
  capabilities: ["analyze", "suggest", "explain"]
  tools: ["read", "edit", "exec"]
  constraints: ["no_destructive", "validate_schema"]
```

**RL Scoring Weight**: 15%

---

### PATTERN-002: Tool Invocation with Validation

**Category**: Tool Orchestration

**Structural Description**
- Tool declared before invocation
- Parameters validated against schema
- Execution confirmation required
- Results parsed and structured
- Error handling with fallbacks

**Input Schema**
```yaml
tool_name: string
parameters: object
validation_rules: array
confirmation_level: enum[auto, approval, confirm]
```

**Output Schema**
```yaml
tool_result:
  success: boolean
  output: any
  error: string|null
  metadata:
    execution_time: number
    token_cost: number
```

**Reasoning Separation Model**
- Pre-execution analysis: "Should I run this?"
- Post-execution: "What did I learn?"
- Structured logging

**Constraints**
- All parameters must validate
- Destructive tools require approval
- Output must match schema

**Token Efficiency Strategy**
- Parameter summary, not full values
- Result excerpts in logging
- Reference previous outputs by ID

**Example Invocation**
```yaml
use_pattern: tool-invocation
input:
  tool_name: "code_edit"
  parameters:
    file: "src/main.ts"
    changes: "refactor"
  validation_rules: ["syntax_check", "type_check"]
  confirmation_level: "approval"
```

**RL Scoring Weight**: 15%

---

### PATTERN-003: Contextual File Analysis

**Category**: Context Management

**Structural Description**
- File tree analysis before reading
- Selective file loading based on task
- Chunking for large files
- Cross-reference detection
- Change tracking

**Input Schema**
```yaml
file_paths: array
task_context: string
max_depth: number
chunk_size: number
```

**Output Schema**
```yaml
file_analysis:
  files_read: array
  summaries: array
  cross_references: array
  relevant_sections: array
```

**Reasoning Separation Model**
- Relevance scoring before reading
- Summary generation post-analysis
- Change impact assessment

**Constraints**
- Respect max_depth
- Do not exceed chunk_size
- Handle missing files gracefully

**Token Efficiency Strategy**
- Tree-first, content-second
- Summarize early
- Cache references

**Example Invocation**
```yaml
use_pattern: file-analysis
input:
  file_paths: ["src/", "config/"]
  task_context: "refactor authentication"
  max_depth: 3
  chunk_size: 5000
```

**RL Scoring Weight**: 10%

---

### PATTERN-004: Multi-Step Reasoning Chain

**Category**: Reasoning Architecture

**Structural Description**
- Problem decomposition
- Sequential step generation
- Each step validates against constraints
- Final synthesis with confidence
- Rollback capability

**Input Schema**
```yaml
task: string
complexity: enum[simple, medium, complex]
max_steps: number
validation_gate: boolean
```

**Output Schema**
```yaml
reasoning_chain:
  steps: array
  final_synthesis: string
  confidence: number
  rollbacks: array
```

**Reasoning Separation Model**
- Plan → Execute → Validate → Synthesize
- Explicit confidence at each step
- Separate analysis from action

**Constraints**
- Max steps enforced
- Validation gates respected
- Confidence threshold: ≥0.8

**Token Efficiency Strategy**
- Step compression (summarize previous)
- Reference not repeat
- Synthesis over description

**Example Invocation**
```yaml
use_pattern: reasoning-chain
input:
  task: "implement feature"
  complexity: "complex"
  max_steps: 5
  validation_gate: true
```

**RL Scoring Weight**: 15%

---

### PATTERN-005: Structured JSON Response

**Category**: Output Formatting

**Structural Description**
- JSON wrapper mandatory
- Typed fields
- Schema validation
- Error handling within structure
- Metadata enrichment

**Input Schema**
```yaml
response_type: enum[object, array, string]
required_fields: array
optional_fields: array
schema_validation: boolean
```

**Output Schema**
```json
{
  "analysis": "concise reasoning",
  "structured_output": {},
  "confidence": 0.95,
  "metadata": {
    "timestamp": "",
    "tokens_used": 0
  }
}
```

**Reasoning Separation Model**
- Thinking in analysis field
- Action in structured_output
- Quality in confidence score

**Constraints**
- Required fields must be present
- Types must match schema
- Confidence 0-1 range

**Token Efficiency Strategy**
- Concise analysis (<50 tokens)
- Omit null optional fields
- Compact metadata

**Example Invocation**
```yaml
use_pattern: json-response
input:
  response_type: "object"
  required_fields: ["status", "output"]
  schema_validation: true
```

**RL Scoring Weight**: 10%

---

### PATTERN-006: Chain-of-Thought Containment

**Category**: Reasoning Control

**Structural Description**
- Reasoning contained to internal fields
- Final output clean
- Confidence scoring per thought
- Thought pruning for irrelevance
- Context window management

**Input Schema**
```yaml
task: string
allow_visible_reasoning: boolean
prune_threshold: number
max_thoughts: number
```

**Output Schema**
```yaml
cot_output:
  visible_output: string
  internal_reasoning: array
  confidence: number
  pruned_count: number
```

**Reasoning Separation Model**
- Internal: full reasoning chain
- External: synthesized result only
- Confidence: aggregate of thoughts

**Constraints**
- Thoughts pruned below threshold
- Max thoughts enforced
- External output clean

**Token Efficiency Strategy**
- Summarize thoughts before output
- Prune early and often
- Reference via ID

**Example Invocation**
```yaml
use_pattern: cot-containment
input:
  task: "debug error"
  allow_visible_reasoning: false
  prune_threshold: 0.5
  max_thoughts: 10
```

**RL Scoring Weight**: 10%

---

### PATTERN-007: Variable Slot Templating

**Category**: Prompt Engineering

**Structural Description**
- Template with {{variable}} slots
- Type validation on fill
- Conditional blocks
- Loop structures
- Fallback values

**Input Schema**
```yaml
template_id: string
variables: object
conditionals: array
fallbacks: object
```

**Output Schema**
```yaml
rendered_prompt: string
filled_slots: array
missing_slots: array
validation: object
```

**Reasoning Separation Model**
- Template validation
- Variable substitution
- Final validation

**Constraints**
- All required slots filled
- Types match schema
- No injection vulnerabilities

**Token Efficiency Strategy**
- Condense templates
- Short variable names
- Remove optional whitespace

**Example Invocation**
```yaml
use_pattern: slot-templating
input:
  template_id: "code-generation"
  variables:
    language: "typescript"
    task: "API endpoint"
```

**RL Scoring Weight**: 10%

---

### PATTERN-008: Constrained Output Generation

**Category**: Output Control

**Structural Description**
- Output format specified upfront
- Forbidden patterns listed
- Required elements checklist
- Length constraints
- Style guidelines

**Input Schema**
```yaml
format: string
forbidden: array
required: array
max_length: number
style: object
```

**Output Schema**
```yaml
generated_output: string
constraint_check:
  forbidden_found: array
  required_present: array
  length: number
  style_compliant: boolean
```

**Reasoning Separation Model**
- Pre-generation: plan
- Post-generation: validate
- Iterate if constraints violated

**Constraints**
- Length limit enforced
- No forbidden patterns
- All required elements

**Token Efficiency Strategy**
- Shorter outputs preferred
- Abbreviate where allowed
- Structured over narrative

**Example Invocation**
```yaml
use_pattern: constrained-output
input:
  format: "bullet_list"
  forbidden: ["filler_words", "hedge_phrases"]
  required: ["metric", "benefit", "proof"]
  max_length: 500
```

**RL Scoring Weight**: 10%

---

### PATTERN-009: Hierarchical Instruction Following

**Category**: Instruction Architecture

**Structural Description**
- Instructions at multiple levels
- Priority ordering
- Override rules
- Scope boundaries
- Inheritance model

**Input Schema**
```yaml
instructions: array
priorities: array
scope: string
overrides: array
```

**Output Schema**
```yaml
instruction_tree:
  level_1: array
  level_2: array
  level_3: array
  conflicts: array
  resolution: string
```

**Reasoning Separation Model**
- Parse hierarchy
- Detect conflicts
- Resolve priorities
- Execute in order

**Constraints**
- Priority order respected
- Scope boundaries enforced
- Conflicts logged

**Token Efficiency Strategy**
- Reference instruction IDs
- Abbreviate known patterns
- Summary over repetition

**Example Invocation**
```yaml
use_pattern: hierarchical-instruction
input:
  instructions: ["no_destructive", "use_opencode", "rl_95"]
  priorities: ["safety", "quality", "speed"]
  scope: "task"
```

**RL Scoring Weight**: 10%

---

### PATTERN-010: Iterative Refinement Loop

**Category**: Quality Assurance

**Structural Description**
- Initial generation
- Criteria-based evaluation
- Improvement suggestions
- Regeneration with feedback
- Convergence detection

**Input Schema**
```yaml
initial_task: string
evaluation_criteria: array
max_iterations: number
convergence_threshold: number
```

**Output Schema**
```yaml
refinement_result:
  iterations: array
  final_output: string
  scores: array
  convergence: boolean
```

**Reasoning Separation Model**
- Generate → Evaluate → Improve
- Separate critique from creation
- Track score progression

**Constraints**
- Max iterations enforced
- Convergence required
- Score threshold: ≥95

**Token Efficiency Strategy**
- Summarize iterations
- Reference previous versions
- Cache evaluations

**Example Invocation**
```yaml
use_pattern: refinement-loop
input:
  initial_task: "write hero section"
  evaluation_criteria: ["clarity", "conversion", "rl_score"]
  max_iterations: 3
  convergence_threshold: 95
```

**RL Scoring Weight**: 15%

---

## RL Scoring Integration

### Pattern Scoring Matrix
| Criterion | Weight |
|-----------|--------|
| Pattern Compliance | 15% |
| Output Schema Validity | 10% |
| Constraint Adherence | 10% |
| Token Efficiency | 5% |
| SEO Score | 20% |
| AIEO Score | 20% |
| Conversion Rate | 15% |
| Writing Quality | 5% |
| **TOTAL** | **100%** |

### Threshold
**RL ≥95 required** for all pattern-based scripts.

### Failure Mode
If RL < 95:
1. Trigger refinement loop
2. Rewrite with stricter pattern adherence
3. Re-validate schema
4. Re-score
5. Repeat until RL ≥95
