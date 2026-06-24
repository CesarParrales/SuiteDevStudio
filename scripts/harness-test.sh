#!/usr/bin/env bash
# Gate FB-2 suite-dev-studio — validaciones del harness (sin app PHP/Node).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "→ FB-3 fixture"
chmod +x skills/comprobacion-produccion/scripts/validate-fb3.sh
skills/comprobacion-produccion/scripts/validate-fb3.sh --strict \
  skills/comprobacion-produccion/scripts/fixtures/fb3-valid.txt

echo "→ SKILL.md ≤500 líneas"
over=$(wc -l skills/*/SKILL.md | awk '$2 ~ /SKILL\.md$/ && $1 > 500 {print $2, $1}')
if [ -n "$over" ]; then
  echo "SKILL.md excede 500 líneas:"
  echo "$over"
  exit 1
fi

echo "→ Referencias markdown locales"
failed=0
for d in skills/*/; do
  [ "$(basename "$d")" = "skill-evolution" ] && continue
  while IFS= read -r ref; do
    [ -z "$ref" ] && continue
    [ -f "$d$ref" ] || { echo "ROTO: $d → $ref"; failed=1; }
  done < <(grep -oE '\((references/[a-zA-Z0-9_-]+\.md)\)' "$d/SKILL.md" 2>/dev/null | tr -d '()' | sort -u)
  while IFS= read -r ref; do
    [ -z "$ref" ] && continue
    [ -f "$d$ref" ] || { echo "ROTO: $d → $ref"; failed=1; }
  done < <(grep -oE '\((templates/[a-zA-Z0-9_-]+\.md)\)' "$d/SKILL.md" 2>/dev/null | tr -d '()' | sort -u)
done
[ "$failed" -eq 0 ] || exit 1

echo "→ Plantillas harness"
for t in laravel-api-module nextjs-saas-page flutter-feature node-api-nest laravel-filament-resource react-native-screen inertia-spa-page; do
  f="skills/harness-template/templates/${t}.md"
  [ -f "$f" ] || { echo "Falta $f"; exit 1; }
done
[ -f templates/AGENTS.md ] || { echo "Falta templates/AGENTS.md"; exit 1; }
[ -f skills/HARNESS-FAILURES.md ] || { echo "Falta skills/HARNESS-FAILURES.md"; exit 1; }

echo "→ Escenarios RED (estructura)"
chmod +x skills/testing-skills-with-subagents/scripts/validate-red-scenarios.sh
skills/testing-skills-with-subagents/scripts/validate-red-scenarios.sh

echo "→ Release RED log (≤90 días)"
chmod +x skills/testing-skills-with-subagents/scripts/validate-release-red.sh
skills/testing-skills-with-subagents/scripts/validate-release-red.sh

echo "→ Meta-harness (~98%)"
chmod +x skills/harness-template/scripts/validate-meta-harness.sh
skills/harness-template/scripts/validate-meta-harness.sh

echo "→ Readiness /20 (umbral CI 16)"
chmod +x skills/harness-template/scripts/harness-readiness.sh
skills/harness-template/scripts/harness-readiness.sh --suite ./skills --project . --ci

echo "✓ harness-test.sh OK"
