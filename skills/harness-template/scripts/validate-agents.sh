#!/usr/bin/env bash
# Valida que AGENTS.md esté personalizado (sin placeholders de plantilla).
# Uso: validate-agents.sh [ruta/AGENTS.md]
set -euo pipefail

FILE="${1:-AGENTS.md}"
STRICT="${VALIDATE_AGENTS_STRICT:-false}"

if [ ! -f "$FILE" ]; then
  if [ "$STRICT" = true ]; then
    echo "Falta $FILE (usa --init-agents)"
    exit 1
  fi
  echo "AGENTS.md: omitido (no existe)"
  exit 0
fi

failed=0
check() {
  local pat="$1"
  local msg="$2"
  if grep -qE "$pat" "$FILE"; then
    echo "Placeholder detectado: $msg"
    failed=1
  fi
}

check 'YYYY-MM-DD' 'fecha plantilla YYYY-MM-DD'
check '\{\{' 'marcadores {{…}}'
check '# Ejemplo — sustituir' 'árbol de ejemplo sin personalizar'
check 'Generado desde suite-dev-studio' 'pie de plantilla sin quitar'
check '\(rellenar\)' 'sección Stack (rellenar)'
check '\| … \|' 'celdas … en tabla Stack'

lines=$(wc -l < "$FILE" | tr -d ' ')
if [ "$lines" -lt 40 ]; then
  echo "AGENTS.md demasiado corto ($lines líneas; mínimo 40)"
  failed=1
fi

if [ "$failed" -eq 0 ]; then
  echo "AGENTS.md: OK — personalizado ($FILE)"
fi
exit $failed
