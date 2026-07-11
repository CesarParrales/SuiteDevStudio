#!/usr/bin/env bash
# Recolecta LEARNINGS y HARNESS-FAILURES desde ~/.cursor/skills/ (u otra fuente)
# hacia el repo canónico skills/. Ejecutar antes de skill-evolution Modo 1.
#
# Uso:
#   ./scripts/collect-learnings.sh                    → global → canónico
#   ./scripts/collect-learnings.sh --dry-run          → simular
#   ./scripts/collect-learnings.sh --source /ruta/.cursor/skills
#   ./scripts/collect-learnings.sh --source-global --source-project /ruta/proyecto
#
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CANONICAL="$ROOT/skills"
GLOBAL_DIR="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}"
PROJECT_DIR=""
DRY_RUN=false
USE_GLOBAL=true

usage() {
  sed -n '2,9p' "$0" | sed 's/^# \?//'
  exit "${1:-0}"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source)
      [[ $# -ge 2 ]] || { echo "Error: --source requiere ruta" >&2; exit 1; }
      GLOBAL_DIR="$(cd "$2" && pwd)"
      USE_GLOBAL=false
      shift 2
      ;;
    --source-global)
      USE_GLOBAL=true
      shift
      ;;
    --source-project)
      [[ $# -ge 2 ]] || { echo "Error: --source-project requiere ruta" >&2; exit 1; }
      PROJECT_DIR="$(cd "$2" && pwd)"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    -h|--help)
      usage 0
      ;;
    *)
      echo "Opción desconocida: $1" >&2
      usage 1
      ;;
  esac
done

PY="$ROOT/scripts/learnings_merge.py"
[[ -x "$PY" ]] || chmod +x "$PY" 2>/dev/null || true

dry_flag=()
[[ "$DRY_RUN" == true ]] && dry_flag=(--dry-run)

total=0

if [[ "$USE_GLOBAL" == true ]]; then
  if [[ -d "$GLOBAL_DIR" ]]; then
    echo "→ Recolectando desde editor global ($GLOBAL_DIR)"
    python3 "$PY" collect --canonical "$CANONICAL" --source "$GLOBAL_DIR" "${dry_flag[@]}"
  else
    echo "Advertencia: no existe $GLOBAL_DIR (omitido)" >&2
  fi
fi

if [[ -n "$PROJECT_DIR" ]]; then
  PROJ_SKILLS="$PROJECT_DIR/.cursor/skills"
  if [[ -d "$PROJ_SKILLS" ]]; then
    echo ""
    echo "→ Recolectando desde proyecto ($PROJ_SKILLS)"
    python3 "$PY" collect --canonical "$CANONICAL" --source "$PROJ_SKILLS" "${dry_flag[@]}"
  else
    echo "Advertencia: no existe $PROJ_SKILLS (omitido)" >&2
  fi
fi

echo ""
echo "Listo. Siguiente paso: skill-evolution Modo 1 (consolidar) → ./install-local.sh"
