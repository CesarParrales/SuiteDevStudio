#!/usr/bin/env bash
# Valida estructura de scenarios-discipline.md (sin subagentes).
# Uso: validate-red-scenarios.sh [ruta/scenarios-discipline.md]
set -euo pipefail

FILE="${1:-}"
if [ -z "$FILE" ]; then
  DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  FILE="$DIR/references/scenarios-discipline.md"
fi

[ -f "$FILE" ] || { echo "No existe: $FILE"; exit 1; }

failed=0
ids=$(grep -oE '^### (CP|KG|TS|VC|HT)-RED-[0-9]+' "$FILE" | awk '{print $2}' | sort)
dupes=$(echo "$ids" | uniq -d)
if [ -n "$dupes" ]; then
  echo "IDs duplicados: $dupes"
  failed=1
fi

count=$(echo "$ids" | grep -c . || true)
min=15
if [ "$count" -lt "$min" ]; then
  echo "Escenarios RED: $count (mínimo $min)"
  failed=1
fi

while IFS= read -r id; do
  [ -z "$id" ] && continue
  if ! awk -v id="### $id" '
    $0 ~ id { found=1; next }
    found && /^\*\*GREEN esperado:\*\*/ { green=1; exit }
    found && /^### / { exit }
    END { exit green ? 0 : 1 }
  ' "$FILE"; then
    echo "Falta **GREEN esperado:** tras $id"
    failed=1
  fi
done <<< "$ids"

for prefix in CP KG TS VC HT; do
  n=$(echo "$ids" | grep -c "^${prefix}-" || true)
  if [ "$n" -lt 1 ]; then
    echo "Sin escenarios para prefijo $prefix"
    failed=1
  fi
done

if [ "$failed" -eq 0 ]; then
  echo "RED scenarios: OK — $count escenarios, IDs únicos, GREEN definido"
fi
exit $failed
