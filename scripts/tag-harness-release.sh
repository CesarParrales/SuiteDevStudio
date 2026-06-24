#!/usr/bin/env bash
# Valida gates y muestra comando para tag harness-v* (no crea tag automáticamente).
# Uso: tag-harness-release.sh [versión]   ej. tag-harness-release.sh v3.4
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

VER="${1:-}"
if [ -z "$VER" ]; then
  VER=$(grep -oE 'Harness: [0-9-]+ \(v[0-9.]+\)' MANIFIESTO.md | tail -1 | grep -oE 'v[0-9.]+' || echo "vX.Y")
fi
[[ "$VER" == v* ]] || VER="v${VER}"
TAG="harness-${VER}"
RELEASE="docs/releases/${TAG}.md"

echo "→ Validando gates para $TAG"
bash scripts/harness-test.sh

if [ ! -f "$RELEASE" ]; then
  echo "Advertencia: no existe $RELEASE"
fi

chmod +x skills/testing-skills-with-subagents/scripts/validate-release-red.sh
skills/testing-skills-with-subagents/scripts/validate-release-red.sh

echo ""
echo "Listo para tag. Ejecutar manualmente:"
echo "  git tag -a $TAG -m \"Harness suite $VER\""
echo "  git push origin $TAG"
