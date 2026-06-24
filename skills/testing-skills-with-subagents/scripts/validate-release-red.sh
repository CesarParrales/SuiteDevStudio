#!/usr/bin/env bash
# Valida que exista entrada RED/GREEN reciente en harness-release-log.md
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
LOG="$ROOT/docs/harness-release-log.md"
SCENARIOS="$ROOT/skills/testing-skills-with-subagents/references/scenarios-discipline.md"

[ -f "$LOG" ] || { echo "Falta $LOG"; exit 1; }

# Última entrada con fecha
latest=$(grep -oE '### 20[0-9]{2}-[0-9]{2}-[0-9]{2}' "$LOG" | tail -1 | sed 's/### //')
[ -n "$latest" ] || { echo "Sin entradas fechadas en release log"; exit 1; }

# Antigüedad ≤ 90 días (python portable)
python3 - <<PY
from datetime import date, datetime
latest = datetime.strptime("$latest", "%Y-%m-%d").date()
age = (date.today() - latest).days
if age > 90:
    raise SystemExit(f"Última entrada RED release hace {age} días (>90)")
print(f"Release log: última entrada {latest} ({age} días)")
PY

# RED y GREEN documentados en última entrada fechada
block=$(awk '/^### 20[0-9]{2}-[0-9]{2}-[0-9]{2}/{last=NR} last{buf=buf $0 "\n"} END{print buf}' "$LOG")
scenario=$(echo "$block" | grep -E 'Escenario:' | head -1 | sed -E 's/.*Escenario:\*\* //; s/^- //; s/\*\*//g; s/^[[:space:]]*//; s/[[:space:]]*\(.*$//')
echo "$block" | grep -qE '\*\*RED:\*\*' || { echo "Falta **RED:** en última entrada"; exit 1; }
echo "$block" | grep -qE '\*\*GREEN:\*\*' || { echo "Falta **GREEN:** en última entrada"; exit 1; }

[ -n "$scenario" ] || { echo "No se pudo parsear escenario del log"; exit 1; }
if ! grep -q "### $scenario" "$SCENARIOS"; then
  echo "Escenario no encontrado en scenarios-discipline: '$scenario'"
  exit 1
fi

echo "Release RED log: OK ($scenario)"
