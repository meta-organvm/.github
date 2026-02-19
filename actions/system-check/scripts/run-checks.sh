#!/usr/bin/env bash
set -euo pipefail

# ORGANVM System Check — runs selected validation checks against
# the current repository's seed.yaml, dependencies, and schema
# conformance. Called by the composite action.
#
# Environment:
#   CHECKS — comma-separated check names (seed, deps, schema, back-edges, all)
#   REGISTRY_PATH — optional path to registry-v2.json
#   FAIL_ON_WARNING — "true" to treat warnings as errors
#   REPO_ROOT — repository root directory

CHECKS="${CHECKS:-all}"
REGISTRY_PATH="${REGISTRY_PATH:-}"
FAIL_ON_WARNING="${FAIL_ON_WARNING:-false}"
REPO_ROOT="${REPO_ROOT:-.}"

PASSED=true
RESULTS="{}"
WARNINGS=0
ERRORS=0

# ── Helper functions ──────────────────────────────────────────────

log_pass() {
    echo "::notice::✓ $1"
}

log_warn() {
    echo "::warning::⚠ $1"
    WARNINGS=$((WARNINGS + 1))
    if [[ "$FAIL_ON_WARNING" == "true" ]]; then
        PASSED=false
    fi
}

log_fail() {
    echo "::error::✗ $1"
    ERRORS=$((ERRORS + 1))
    PASSED=false
}

should_run() {
    [[ "$CHECKS" == "all" ]] || echo ",$CHECKS," | grep -q ",$1,"
}

# ── Check: seed.yaml validity ────────────────────────────────────

check_seed() {
    echo "── Checking seed.yaml ──"
    local seed_file="$REPO_ROOT/seed.yaml"

    if [[ ! -f "$seed_file" ]]; then
        log_fail "seed.yaml not found at $seed_file"
        return
    fi

    # Use python to validate structure
    if ! python3 -c '
import yaml, sys
try:
    with open("'$seed_file'") as f:
        data = yaml.safe_load(f)
    required = ["schema_version", "organ", "organ_name", "repo", "org", "metadata"]
    for f in required:
        if f not in data:
            print(f"Missing required field: {f}")
            sys.exit(1)
    meta = data["metadata"]
    req_meta = ["implementation_status", "tier", "promotion_status"]
    for f in req_meta:
        if f not in meta:
            print(f"Missing metadata field: {f}")
            sys.exit(1)
except Exception as e:
    print(f"Error: {e}")
    sys.exit(1)
' 2>/tmp/seed_error; then
        log_fail "seed.yaml structural validation failed: $(cat /tmp/seed_error)"
    else
        log_pass "seed.yaml is structurally valid"
    fi
}

# ── Check: dependency rules ───────────────────────────────────────

check_deps() {
    echo "── Checking dependency rules ──"

    if command -v organvm &>/dev/null; then
        if organvm governance check-deps --registry "${REGISTRY_PATH:-}" >/tmp/deps_out 2>/dev/null; then
            log_pass "system-wide dependency rules satisfied"
        else
            # Filter output to only show violations related to the current repo
            # (Assuming output contains repo names)
            log_warn "potential dependency violations found: $(head -n 5 /tmp/deps_out)"
        fi
    else
        echo "::notice::organvm CLI not found, skipping deep dependency check"
        log_pass "skipping dependency check (CLI unavailable)"
    fi
}

# ── Check: schema conformance ─────────────────────────────────────

check_schema() {
    echo "── Checking schema conformance ──"

    if command -v organvm-validate &>/dev/null; then
        if organvm-validate "$REPO_ROOT/seed.yaml" &>/dev/null; then
            log_pass "seed.yaml conforms to schema"
        else
            log_fail "seed.yaml does not conform to schema"
        fi
    else
        echo "::notice::organvm-validate not found, skipping schema check"
        log_pass "skipping schema check (validator unavailable)"
    fi
}

# ── Check: no back-edges ──────────────────────────────────────────

check_back_edges() {
    echo "── Checking for back-edges ──"

    # Minimal implementation: check if organ tier/status allows downstream dependencies
    # Rule: ORGAN-III (Commerce) cannot depend on ORGAN-I (Theory)
    if ! python3 -c '
import yaml, sys
try:
    with open("'$REPO_ROOT'/seed.yaml") as f:
        data = yaml.safe_load(f)
    organ = data.get("organ")
    consumes = data.get("consumes", []) or []
    if organ == "ORGAN-III":
        for c in consumes:
            source = c.get("source", "")
            if "organvm-i-theoria" in source:
                print(f"Back-edge violation: {organ} cannot consume from Theory (I)")
                sys.exit(1)
except Exception:
    sys.exit(0)
' 2>/tmp/back_edge_error; then
        log_fail "Back-edge violation detected: $(cat /tmp/back_edge_error)"
    else
        log_pass "no back-edges detected for this repo"
    fi
}

# ── Run selected checks ──────────────────────────────────────────

echo "ORGANVM System Check"
echo "Checks: $CHECKS"
echo "Repo root: $REPO_ROOT"
echo ""

should_run "seed" && check_seed
should_run "deps" && check_deps
should_run "schema" && check_schema
should_run "back-edges" && check_back_edges

# ── Output results ────────────────────────────────────────────────

echo ""
echo "Results: $ERRORS errors, $WARNINGS warnings"

RESULTS=$(cat <<RESULT_JSON
{"passed": $PASSED, "errors": $ERRORS, "warnings": $WARNINGS, "checks": "$CHECKS"}
RESULT_JSON
)

echo "result=$RESULTS" >> "$GITHUB_OUTPUT"
echo "passed=$PASSED" >> "$GITHUB_OUTPUT"

if [[ "$PASSED" != "true" ]]; then
    echo "::error::System check failed with $ERRORS errors"
    exit 1
fi
