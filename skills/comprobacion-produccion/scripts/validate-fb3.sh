#!/usr/bin/env bash
# Valida bloques de feedback estructurado FB-3 (comprobacion-produccion).
#
# Uso:
#   ./validate-fb3.sh informe.txt
#   ./validate-fb3.sh --strict informe.txt
#   cat informe.txt | ./validate-fb3.sh
set -euo pipefail

STRICT=false
FILE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --strict) STRICT=true; shift ;;
    -h|--help)
      echo "Uso: validate-fb3.sh [--strict] [archivo]"
      exit 0
      ;;
    *) FILE="$1"; shift ;;
  esac
done

if [[ -n "$FILE" ]]; then
  [[ -f "$FILE" ]] || { echo "Error: no existe $FILE" >&2; exit 1; }
  CONTENT=$(<"$FILE")
else
  CONTENT=$(cat)
fi

[[ -n "${CONTENT// }" ]] || { echo "Error: entrada vacía" >&2; exit 1; }

export FB3_CONTENT="$CONTENT"
export FB3_STRICT="$STRICT"

python3 <<'PY'
import os, re, sys

strict = os.environ.get("FB3_STRICT") == "true"
text = os.environ.get("FB3_CONTENT", "").strip()
blocks = [b.strip() for b in re.split(r"\n\s*\n", text) if b.strip()]

if not blocks:
    print("Error: sin bloques (separa hallazgos con línea en blanco)", file=sys.stderr)
    sys.exit(1)

required = ["Categoría:", "Ubicación:", "Esperado:", "Actual:", "Acción sugerida:"]
valid_cats = {"sintaxis", "tipos", "test", "seguridad", "arquitectura", "runtime", "config"}
errors = 0

for i, block in enumerate(blocks, 1):
    for field in required:
        if field not in block:
            print(f"Bloque {i}: falta '{field}'", file=sys.stderr)
            errors += 1
    m = re.search(r"^Categoría:\s*(\S+)", block, re.M)
    if strict and m and m.group(1) not in valid_cats:
        print(f"Bloque {i}: categoría inválida '{m.group(1)}'", file=sys.stderr)
        errors += 1
    loc = re.search(r"^Ubicación:\s*(.+)$", block, re.M)
    if loc and not re.search(r":\d+", loc.group(1)):
        print(f"Bloque {i}: ubicación debe incluir :línea", file=sys.stderr)
        errors += 1

if errors:
    print(f"FB-3: {errors} error(es) en {len(blocks)} bloque(s)", file=sys.stderr)
    sys.exit(1)

print(f"FB-3: OK — {len(blocks)} bloque(s) válido(s)")
PY
