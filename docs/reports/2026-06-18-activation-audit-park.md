# Activation Audit: Park - 2026-06-18

Issue: GH #10

Audit cursor: EV-2026-06-11-200224

Original audit event: 2026-06-11

## Scope

Activation pass for `meta-organvm/.github`, the organization profile and
community-health repository for meta-organvm.

## Evidence Reviewed

- `README.md` identifies the repository as organization profile and community
  health files.
- `profile/README.md` renders the public organization profile and system
  overview.
- `CLA.md`, `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, `SECURITY.md`, and
  `LICENSE` provide community-health policy documents.
- `workflow-templates/cla.yml` and `workflow-templates/cla.properties.json`
  provide a reusable CLA workflow template.
- `actions/system-check/action.yml` and
  `actions/system-check/scripts/run-checks.sh` provide an internal composite
  GitHub Action shell for ORGANVM system checks.
- `seed.yaml` declares infrastructure metadata for this repository.

## Activation Probes

| Probe | Finding |
| --- | --- |
| Live URL | Not documented as a repo-owned deployable surface. GitHub renders `profile/README.md` as the organization profile, but this repo does not ship a dedicated app or site URL. |
| Installable package | Not present. No package manifest or published package metadata is present in this repository. |
| Runnable release | Not present. No release artifact, app build target, or versioned runtime is present. |
| Documented exec path | Not documented for end users. The only executable path found is the internal GitHub Action helper script under `actions/system-check/scripts/`. |

## Verdict

Park.

This repository is useful as organization metadata and community-health
infrastructure, but it is not an activation candidate until it exposes a
ship-grade runtime surface.

Reactivate only if one of these surfaces is added and documented:

- A versioned GitHub Action release with usage examples and a local verification
  command.
- An installable package or CLI with published package metadata.
- A hosted profile/community portal with a live URL and release process.

## Evidence Level

Inspected-only.

## Verification

Passed:

- `CHECKS=seed,back-edges GITHUB_OUTPUT=/tmp/meta-organvm-github-system-check-core.out REPO_ROOT="$PWD" bash actions/system-check/scripts/run-checks.sh`
- `git diff --check`

Local limitation:

- Full `CHECKS=all` did not complete in this worktree because host-level
  `organvm` and `organvm-validate` commands are present but broken:
  `organvm-validate` points at a missing Python 3.11 interpreter, and `organvm`
  cannot import `organvm_engine`.
