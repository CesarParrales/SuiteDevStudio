#!/usr/bin/env bash
# Meta-validación suite-dev-studio (~98% harness).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$ROOT"

failed=0
req() {
  local path="$1"
  if [ ! -e "$path" ]; then
    echo "Falta: $path"
    failed=1
  fi
}

req install-local.sh
req docs/releases/harness-v3.4.md
req docs/harness-quarterly-2026-06.md
req docs/evaluation-ponytail.md
req templates/cursor/minimal-code.mdc
req skills/vibe-coding-token-optimization/references/decision-ladder.md
req scripts/tag-harness-release.sh
req skills/skill-evolution/references/quarterly-harness.md
req docs/harness-release-log.md
req docs/harness-decisions.md
req docs/suite-code-map.md
req scripts/harness-test.sh
req templates/code-map.md
req templates/docs/architecture/README.md
req templates/docs/architecture/adr/000-template.md

for s in validate-agents.sh validate-code-map.sh validate-project-memory.sh; do
  req "skills/harness-template/scripts/$s"
  [ -x "skills/harness-template/scripts/$s" ] || { echo "No ejecutable: $s"; failed=1; }
done

if ! grep -q -- '--bootstrap' install-local.sh || ! grep -q -- '--strict' install-local.sh; then
  echo "install-local.sh sin --bootstrap o --strict"
  failed=1
fi

if ! grep -q -- '--init-minimal-rule' install-local.sh; then
  echo "install-local.sh sin --init-minimal-rule"
  failed=1
fi

if ! grep -q 'v3\.' MANIFIESTO.md 2>/dev/null; then
  echo "MANIFIESTO sin versión harness v3.x documentada"
  failed=1
fi

chmod +x skills/harness-template/scripts/validate-project-memory.sh 2>/dev/null || true
if [ -f .cursor/project-memory.md ]; then
  skills/harness-template/scripts/validate-project-memory.sh .cursor/project-memory.md || failed=1
fi

if [ "$failed" -eq 0 ]; then
  echo "meta-harness: OK (~98% artefactos)"
fi
exit $failed
