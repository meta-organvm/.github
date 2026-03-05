# README Standards

Canonical README policy for all ORGANVM repositories across all organs.

## Scope

This file is the source of truth for:

- README structure and depth by tier
- Organ-specific required sections
- Minimum quality rubric used for audits
- Minimum community-health and root-hygiene requirements tied to README quality

Derived from the system corpus standards:

- `organvm-corpvs-testamentvm/docs/standards/10-repository-standards.md`
- `organvm-corpvs-testamentvm/docs/planning/01-readme-audit-framework.md`
- `organvm-corpvs-testamentvm/docs/planning/03-per-organ-readme-templates.md`

## Universal README Model

Every README should follow progressive disclosure:

1. Hero: title, key badges, one-line hook, quick navigation
2. Value: problem statement / purpose
3. Action: setup, usage, examples
4. Context: cross-references, contributing, license, author

## Tier Requirements

| Tier | Target | Minimum |
|------|--------|---------|
| Flagship | 3,000+ words | 12+ sections, complete 4-layer model |
| Standard | 1,000+ words | 8+ sections, complete 4-layer model |
| Stub | 200+ words | title, purpose, status, parent links |
| Archive | 50+ words | archive notice + redirect |

## Organ-Specific Required Sections

### ORGAN-I (Theory)
- Problem Statement
- Core Concepts
- Related Work
- Installation or Usage
- Examples
- Downstream Implementation
- Validation
- Roadmap
- Cross-References

### ORGAN-II (Art)
- Artistic Purpose
- Conceptual Approach
- Technical Overview
- Installation
- Working Examples or Demos
- Theory Implemented
- Portfolio or Exhibition Context
- Contributing

### ORGAN-III (Commerce)
- Product Overview
- Value Proposition
- Business Model
- Technical Architecture
- Getting Started
- Case Study
- Metrics and Proof
- Support and Governance

### ORGAN-IV (Orchestration)
- Orchestration Purpose
- Registry Overview
- Governance Rules
- How It Works
- Key Concepts (promotion/dependency/validation)
- Concrete Example Flow
- Contributing to Governance

### ORGAN-V (Public Process)
- Publication Purpose
- Publishing Guidelines
- Structure/Frontmatter Requirements
- Index or Corpus Navigation
- Subscription/Distribution
- Contributing
- Archive

### ORGAN-VI (Community)
- Community Purpose
- Participation Model
- Community Guidelines
- Archive Structure
- Access Model
- Contributing

### ORGAN-VII (Marketing)
- Distribution Strategy
- Audience Target
- Content Types
- Metrics
- Channels
- Publishing Calendar
- Templates or Playbooks

## README Quality Rubric (0-100)

### Existence and Accessibility (0-20)
- README exists in root
- clear title + one-line description
- table of contents/navigation
- readable formatting

### Content Completeness (0-40)
- explicit problem statement
- complete setup/install instructions
- two or more working examples (where applicable)
- dependencies documented
- contributing guidance present

### Accuracy and Currency (0-20)
- links valid
- examples run
- docs match implementation
- freshness timestamp or clear status

### Portfolio Relevance (0-20)
- why repo exists is explicit
- connection to larger system is explicit
- features/value proposition clear
- evidence or impact signals present

## Root Hygiene and Community Files

At minimum, each active repo should include:

- `README.md`
- `LICENSE`
- `.gitignore`
- `.github/CONTRIBUTING.md` (or org-level fallback)
- `.github/SECURITY.md` (or org-level fallback)
- `.github/CODE_OF_CONDUCT.md` (or org-level fallback)

Flagship and Standard repos should also include:

- pull request template
- issue templates for bug and feature/documentation requests

## Local Overlay Policy

Each organ may keep an overlay standards file in its `.github` repository:

- path: `README_STANDARDS.md`
- purpose: local additions and stricter checks
- requirement: must link back to this canonical policy
- rule: overlay cannot weaken canonical requirements

## Enforcement

Each organ superproject should provide a local audit script:

- recommended path: `tools/audit_platform_standards.sh`

Each audit should check, at minimum:

1. required standards files exist
2. README has minimum section structure for its tier/profile
3. local overlay links to this canonical policy

Any exception must be tracked via issue with owner + due date.
