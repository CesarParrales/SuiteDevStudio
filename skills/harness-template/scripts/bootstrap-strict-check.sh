#!/usr/bin/env bash
# Post-bootstrap --strict: exige plantillas personalizadas (falla con placeholders).
# Uso: bootstrap-strict-check.sh /ruta/proyecto
set -euo pipefail

ROOT="${1:?Indica raíz del proyecto}"
cd "$ROOT"
SKILLS="$ROOT/.cursor/skills"

[ -d "$SKILLS/harness-template/scripts" ] || {
  echo "STRICT: instala skills primero (install-local.sh --project .)"
  exit 1
}

chmod +x "$SKILLS/harness-template/scripts/"validate-*.sh 2>/dev/null || true

failed=0
run() {
  if ! "$@"; then failed=1; fi
}

echo "→ STRICT post-bootstrap"

[ -f AGENTS.md ] || { echo "Falta AGENTS.md"; exit 1; }
[ -f .cursor/project-memory.md ] || { echo "Falta .cursor/project-memory.md"; exit 1; }
[ -f docs/code-map.md ] || { echo "Falta docs/code-map.md"; exit 1; }

run "$SKILLS/harness-template/scripts/validate-agents.sh" AGENTS.md
run "$SKILLS/harness-template/scripts/validate-code-map.sh" docs/code-map.md
run "$SKILLS/harness-template/scripts/validate-project-memory.sh" .cursor/project-memory.md

if [ "$failed" -ne 0 ]; then
  echo ""
  echo "STRICT: personaliza AGENTS.md, docs/code-map.md y .cursor/project-memory.md"
  echo "Luego: bash scripts/harness-test.sh"
  exit 1
fi

echo "STRICT: plantillas personalizadas OK"
