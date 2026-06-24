#!/usr/bin/env bash
# Valida que .cursor/project-memory.md esté personalizado (IN-3 + gates).
# Uso: validate-project-memory.sh [ruta]
set -euo pipefail

FILE="${1:-.cursor/project-memory.md}"
STRICT="${VALIDATE_PROJECT_MEMORY_STRICT:-false}"

if [ ! -f "$FILE" ]; then
  if [ "$STRICT" = true ]; then
    echo "Falta $FILE (usa --init-memory o --bootstrap)"
    exit 1
  fi
  echo "project-memory: omitido (no existe)"
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

check 'last_updated: YYYY-MM-DD' 'last_updated plantilla'
check '\*\(fecha \+ comando' 'gates sin verificación registrada'
check '\*\(PRD' 'PRD placeholder'
check 'Backend: …' 'stack sin rellenar'
check 'Frontend: …' 'stack sin rellenar'
check 'Tests: …' 'stack sin rellenar'
check '^<!-- Formato:' 'bloque comentario de plantilla'

if ! grep -qE '### 20[0-9]{2}-[0-9]{2}-[0-9]{2}' "$FILE"; then
  echo "Sin entradas en Log de sesión (### YYYY-MM-DD)"
  failed=1
fi

if ! grep -qE '(exit 0|→ exit)' "$FILE"; then
  echo "Gates locales sin resultado exit 0 documentado"
  failed=1
fi

lines=$(wc -l < "$FILE" | tr -d ' ')
if [ "$lines" -lt 35 ]; then
  echo "project-memory demasiado corto ($lines líneas)"
  failed=1
fi

if [ "$failed" -eq 0 ]; then
  echo "project-memory: OK — personalizado ($FILE)"
fi
exit $failed
