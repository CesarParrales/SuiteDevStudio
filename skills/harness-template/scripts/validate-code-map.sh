#!/usr/bin/env bash
# Valida que docs/code-map.md esté personalizado (sin placeholders de plantilla).
# Uso: validate-code-map.sh [ruta/code-map.md]
# Exit 0 si OK o archivo ausente (--strict falla si falta).
set -euo pipefail

FILE="${1:-docs/code-map.md}"
STRICT="${VALIDATE_CODE_MAP_STRICT:-false}"

if [ ! -f "$FILE" ]; then
  if [ "$STRICT" = true ]; then
    echo "Falta $FILE (usa --init-code-map)"
    exit 1
  fi
  echo "code-map: omitido (no existe)"
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

check '\{\{' 'marcadores {{…}}'
check 'YYYY-MM-DD' 'fecha plantilla YYYY-MM-DD'
check '…' 'elipsis … de ejemplo'
check '# Ejemplo Laravel' 'bloque ejemplo sin personalizar'
check '\{\{NOMBRE_PROYECTO\}\}' 'NOMBRE_PROYECTO'

lines=$(wc -l < "$FILE" | tr -d ' ')
if [ "$lines" -lt 25 ]; then
  echo "code-map demasiado corto ($lines líneas; mínimo 25)"
  failed=1
fi

if [ "$failed" -eq 0 ]; then
  echo "code-map: OK — personalizado ($FILE)"
fi
exit $failed
