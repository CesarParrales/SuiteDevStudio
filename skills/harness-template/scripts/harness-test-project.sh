#!/usr/bin/env bash
# Gate harness en proyecto cliente (Laravel, Next, Flutter, etc.).
# Instalar con: install-local.sh --project . --init-harness-test
#
# No sustituye tests de aplicación en CI; complementa jobs test-php/test-node.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
SKILLS="$ROOT/.cursor/skills"

echo "→ Skills mínimas"
for s in comprobacion-produccion karpathy-guidelines harness-template; do
  [ -f "$SKILLS/$s/SKILL.md" ] || { echo "Falta $SKILLS/$s"; exit 1; }
done
[ -f "$SKILLS/comprobacion-produccion/scripts/validate-fb3.sh" ] || exit 1

if [ -f feedback/ci-failures.txt ]; then
  echo "→ FB-3 feedback/ci-failures.txt"
  chmod +x "$SKILLS/comprobacion-produccion/scripts/validate-fb3.sh"
  "$SKILLS/comprobacion-produccion/scripts/validate-fb3.sh" --strict feedback/ci-failures.txt
else
  echo "→ FB-3 omitido (sin feedback/ci-failures.txt)"
fi

echo "→ AGENTS.md + project-memory"
[ -f AGENTS.md ] || { echo "Falta AGENTS.md (usa --init-agents o --bootstrap)"; exit 1; }
[ -f .cursor/project-memory.md ] || { echo "Falta .cursor/project-memory.md (usa --init-memory)"; exit 1; }

chmod +x "$SKILLS/harness-template/scripts/validate-agents.sh"
"$SKILLS/harness-template/scripts/validate-agents.sh" AGENTS.md

chmod +x "$SKILLS/harness-template/scripts/validate-project-memory.sh"
"$SKILLS/harness-template/scripts/validate-project-memory.sh" .cursor/project-memory.md

if [ -f docs/code-map.md ]; then
  echo "→ FF-2 docs/code-map.md personalizado"
  chmod +x "$SKILLS/harness-template/scripts/validate-code-map.sh"
  "$SKILLS/harness-template/scripts/validate-code-map.sh" docs/code-map.md
else
  echo "Advertencia: sin docs/code-map.md (recomendado: --init-code-map)"
fi

echo "→ Readiness /20 (umbral CI 16)"
chmod +x "$SKILLS/harness-template/scripts/harness-readiness.sh"
"$SKILLS/harness-template/scripts/harness-readiness.sh" --suite "$SKILLS" --project . --ci

echo "✓ harness-test.sh OK (proyecto)"
