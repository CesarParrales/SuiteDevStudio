#!/usr/bin/env bash
# Instala (o actualiza) la suite como copias físicas en ~/.cursor/skills/ y/o en un proyecto.
#
# Uso:
#   ./install-local.sh                          → global (~/.cursor/skills/)
#   ./install-local.sh --project /ruta/proyecto → .cursor/skills/ del proyecto
#   ./install-local.sh --no-global --project /ruta → solo proyecto (sin tocar ~/.cursor/skills/)
#   ./install-local.sh --global --project /ruta → ambos destinos
#   ./install-local.sh --skills atomic-design,laravel-backend --project /ruta
#   ./install-local.sh --project /ruta --init-memory   → copia templates/project-memory.md si no existe
#   ./install-local.sh --project /ruta --init-agents     → copia templates/AGENTS.md en la raíz del proyecto si no existe
#   ./install-local.sh --project /ruta --init-github     → copia templates/github/harness-validate-project.yml si no existe
#   ./install-local.sh --project /ruta --init-harness-test → copia harness-test-project.sh → scripts/harness-test.sh
#   ./install-local.sh --project /ruta --init-code-map   → copia templates/code-map.md → docs/code-map.md
#   ./install-local.sh --project /ruta --init-architecture → copia templates/docs/architecture/ → docs/architecture/
#   ./install-local.sh --project /ruta --init-minimal-rule → copia templates/cursor/minimal-code.mdc → .cursor/rules/
#   ./install-local.sh --init-learnings-rule → copia regla → .cursor/rules/ del proyecto
#   ./install-local.sh --init-learnings-rule-global → regla en ~/.cursor/rules/ (captura errores repetidos)
#   ./install-local.sh --project /ruta --bootstrap → todos los --init-* anteriores (requiere --project)
#   ./install-local.sh --project /ruta --bootstrap --strict → bootstrap + valida plantillas personalizadas (exit 1 si placeholders)
#
# LEARNINGS: al instalar, se preservan entradas ## Pendientes del destino que aún no estén
# en la copia canónica (evita perder aprendizajes escritos en ~/.cursor/skills/ durante uso).
# Flujo recomendado: collect-learnings.sh → skill-evolution → install-local.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SUITE="$SCRIPT_DIR/skills"
GLOBAL_DIR="${CURSOR_SKILLS_DIR:-$HOME/.cursor/skills}"
LEARNINGS_MERGE="$SCRIPT_DIR/scripts/learnings_merge.py"

INSTALL_GLOBAL=true
PROJECT_DIR=""
SKILL_FILTER=""
INIT_MEMORY=false
INIT_AGENTS=false
INIT_GITHUB=false
INIT_HARNESS_TEST=false
INIT_CODE_MAP=false
INIT_ARCHITECTURE=false
INIT_MINIMAL_RULE=false
INIT_LEARNINGS_RULE=false
INIT_LEARNINGS_RULE_GLOBAL=false
BOOTSTRAP_STRICT=false

usage() {
  sed -n '2,12p' "$0" | sed 's/^# \?//'
  exit "${1:-0}"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project)
      [[ $# -ge 2 ]] || { echo "Error: --project requiere una ruta" >&2; exit 1; }
      PROJECT_DIR="$(cd "$2" && pwd)"
      shift 2
      ;;
    --global)
      INSTALL_GLOBAL=true
      shift
      ;;
    --no-global)
      INSTALL_GLOBAL=false
      shift
      ;;
    --skills)
      [[ $# -ge 2 ]] || { echo "Error: --skills requiere lista separada por comas" >&2; exit 1; }
      SKILL_FILTER="$2"
      shift 2
      ;;
    --init-memory)
      INIT_MEMORY=true
      shift
      ;;
    --init-agents)
      INIT_AGENTS=true
      shift
      ;;
    --init-github)
      INIT_GITHUB=true
      shift
      ;;
    --init-harness-test)
      INIT_HARNESS_TEST=true
      shift
      ;;
    --init-code-map)
      INIT_CODE_MAP=true
      shift
      ;;
    --init-architecture)
      INIT_ARCHITECTURE=true
      shift
      ;;
    --init-minimal-rule)
      INIT_MINIMAL_RULE=true
      shift
      ;;
    --init-learnings-rule)
      INIT_LEARNINGS_RULE=true
      shift
      ;;
    --init-learnings-rule-global)
      INIT_LEARNINGS_RULE_GLOBAL=true
      shift
      ;;
    --bootstrap)
      INIT_MEMORY=true
      INIT_AGENTS=true
      INIT_GITHUB=true
      INIT_HARNESS_TEST=true
      INIT_CODE_MAP=true
      INIT_ARCHITECTURE=true
      shift
      ;;
    --strict)
      BOOTSTRAP_STRICT=true
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

if [[ "$INIT_MEMORY" == true || "$INIT_AGENTS" == true || "$INIT_GITHUB" == true || "$INIT_HARNESS_TEST" == true || "$INIT_CODE_MAP" == true || "$INIT_ARCHITECTURE" == true || "$INIT_MINIMAL_RULE" == true || "$INIT_LEARNINGS_RULE" == true ]]; then
  if [[ -z "$PROJECT_DIR" ]]; then
    echo "Error: flags --init-* y --bootstrap requieren --project /ruta" >&2
    exit 1
  fi
fi

if [[ "$INSTALL_GLOBAL" == false && -z "$PROJECT_DIR" ]]; then
  echo "Error: indica --global, --project, o ambos" >&2
  exit 1
fi

if [[ -n "$PROJECT_DIR" && "$INSTALL_GLOBAL" == false ]]; then
  INSTALL_GLOBAL=false
fi

if [[ ! -d "$SUITE" ]]; then
  echo "Error: no se encontró $SUITE" >&2
  exit 1
fi

should_install() {
  local name="$1"
  if [[ -z "$SKILL_FILTER" ]]; then
    return 0
  fi
  local IFS=','
  for s in $SKILL_FILTER; do
    s="${s// /}"
    [[ "$s" == "$name" ]] && return 0
  done
  return 1
}

preserve_learnings() {
  local target_file="$1"
  local previous_file="$2"
  [[ -f "$previous_file" ]] || return 0
  [[ -f "$LEARNINGS_MERGE" ]] || return 0
  python3 "$LEARNINGS_MERGE" merge-file --target "$target_file" --source "$previous_file" 2>/dev/null || true
}

preserve_harness_failures() {
  local target_file="$1"
  local previous_file="$2"
  [[ -f "$previous_file" ]] || return 0
  [[ -f "$LEARNINGS_MERGE" ]] || return 0
  python3 "$LEARNINGS_MERGE" merge-hf --target "$target_file" --source "$previous_file" 2>/dev/null || true
}

install_to() {
  local target="$1"
  local label="$2"
  local count=0

  mkdir -p "$target"
  echo ""
  echo "→ $label ($target)"

  for skill in "$SUITE"/*/; do
    [[ -f "$skill/SKILL.md" ]] || continue
    local name
    name="$(basename "$skill")"
    should_install "$name" || continue

    local dest="$target/$name"
    local prev_learnings=""
    if [[ -f "$dest/LEARNINGS.md" ]]; then
      prev_learnings="$(mktemp)"
      cp "$dest/LEARNINGS.md" "$prev_learnings"
    fi

    if [[ -L "$dest" ]]; then
      rm "$dest"
    elif [[ -d "$dest" ]]; then
      rm -rf "$dest"
    fi

    cp -R "$skill" "$dest"

    if [[ -n "$prev_learnings" ]]; then
      preserve_learnings "$dest/LEARNINGS.md" "$prev_learnings"
      rm -f "$prev_learnings"
    fi

    count=$((count + 1))
    echo "  ✓ $name"
  done

  # Artefactos en la raíz de skills/ (fuera de carpetas con SKILL.md)
  if [[ -f "$SUITE/HARNESS-FAILURES.md" ]]; then
    local prev_hf=""
    if [[ -f "$target/HARNESS-FAILURES.md" ]]; then
      prev_hf="$(mktemp)"
      cp "$target/HARNESS-FAILURES.md" "$prev_hf"
    fi
    cp "$SUITE/HARNESS-FAILURES.md" "$target/HARNESS-FAILURES.md"
    if [[ -n "$prev_hf" ]]; then
      preserve_harness_failures "$target/HARNESS-FAILURES.md" "$prev_hf"
      rm -f "$prev_hf"
    fi
    echo "  ✓ HARNESS-FAILURES.md"
  fi

  echo "  Instaladas: $count skills"
}

if [[ "$INSTALL_GLOBAL" == true ]]; then
  install_to "$GLOBAL_DIR" "Instalación global"
fi

if [[ -n "$PROJECT_DIR" ]]; then
  install_to "$PROJECT_DIR/.cursor/skills" "Instalación en proyecto"

  if [[ "$INIT_MEMORY" == true ]]; then
    MEMORY_TEMPLATE="$SCRIPT_DIR/templates/project-memory.md"
    MEMORY_DEST="$PROJECT_DIR/.cursor/project-memory.md"
    if [[ -f "$MEMORY_TEMPLATE" ]]; then
      if [[ -f "$MEMORY_DEST" ]]; then
        echo ""
        echo "→ project-memory: ya existe ($MEMORY_DEST), no se sobrescribe"
      else
        mkdir -p "$PROJECT_DIR/.cursor"
        cp "$MEMORY_TEMPLATE" "$MEMORY_DEST"
        echo ""
        echo "→ project-memory: creado desde plantilla ($MEMORY_DEST)"
      fi
    else
      echo "Advertencia: no se encontró $MEMORY_TEMPLATE" >&2
    fi
  fi

  if [[ "$INIT_AGENTS" == true ]]; then
    AGENTS_TEMPLATE="$SCRIPT_DIR/templates/AGENTS.md"
    AGENTS_DEST="$PROJECT_DIR/AGENTS.md"
    if [[ -f "$AGENTS_TEMPLATE" ]]; then
      if [[ -f "$AGENTS_DEST" ]]; then
        echo ""
        echo "→ AGENTS.md: ya existe ($AGENTS_DEST), no se sobrescribe"
      else
        cp "$AGENTS_TEMPLATE" "$AGENTS_DEST"
        echo ""
        echo "→ AGENTS.md: creado desde plantilla ($AGENTS_DEST)"
      fi
    else
      echo "Advertencia: no se encontró $AGENTS_TEMPLATE" >&2
    fi
  fi

  if [[ "$INIT_GITHUB" == true ]]; then
    GITHUB_TEMPLATE="$SCRIPT_DIR/templates/github/harness-validate-project.yml"
    GITHUB_DEST="$PROJECT_DIR/.github/workflows/harness-validate.yml"
    if [[ -f "$GITHUB_TEMPLATE" ]]; then
      if [[ -f "$GITHUB_DEST" ]]; then
        echo ""
        echo "→ harness CI: ya existe ($GITHUB_DEST), no se sobrescribe"
      else
        mkdir -p "$PROJECT_DIR/.github/workflows"
        cp "$GITHUB_TEMPLATE" "$GITHUB_DEST"
        echo ""
        echo "→ harness CI: creado ($GITHUB_DEST)"
      fi
    else
      echo "Advertencia: no se encontró $GITHUB_TEMPLATE" >&2
    fi
  fi

  if [[ "$INIT_HARNESS_TEST" == true ]]; then
    HARNESS_TEST_SRC="$SCRIPT_DIR/skills/harness-template/scripts/harness-test-project.sh"
    HARNESS_TEST_DEST="$PROJECT_DIR/scripts/harness-test.sh"
    if [[ -f "$HARNESS_TEST_SRC" ]]; then
      if [[ -f "$HARNESS_TEST_DEST" ]]; then
        echo ""
        echo "→ harness-test: ya existe ($HARNESS_TEST_DEST), no se sobrescribe"
      else
        mkdir -p "$PROJECT_DIR/scripts"
        cp "$HARNESS_TEST_SRC" "$HARNESS_TEST_DEST"
        chmod +x "$HARNESS_TEST_DEST"
        echo ""
        echo "→ harness-test: creado ($HARNESS_TEST_DEST)"
      fi
    else
      echo "Advertencia: no se encontró $HARNESS_TEST_SRC" >&2
    fi
  fi

  if [[ "$INIT_CODE_MAP" == true ]]; then
    CODEMAP_TEMPLATE="$SCRIPT_DIR/templates/code-map.md"
    CODEMAP_DEST="$PROJECT_DIR/docs/code-map.md"
    if [[ -f "$CODEMAP_TEMPLATE" ]]; then
      if [[ -f "$CODEMAP_DEST" ]]; then
        echo ""
        echo "→ code-map: ya existe ($CODEMAP_DEST), no se sobrescribe"
      else
        mkdir -p "$PROJECT_DIR/docs"
        cp "$CODEMAP_TEMPLATE" "$CODEMAP_DEST"
        echo ""
        echo "→ code-map: creado ($CODEMAP_DEST)"
      fi
    else
      echo "Advertencia: no se encontró $CODEMAP_TEMPLATE" >&2
    fi
  fi

  if [[ "$INIT_ARCHITECTURE" == true ]]; then
    ARCH_SRC="$SCRIPT_DIR/templates/docs/architecture"
    ARCH_DEST="$PROJECT_DIR/docs/architecture"
    if [[ -d "$ARCH_SRC" ]]; then
      if [[ -f "$ARCH_DEST/README.md" ]]; then
        echo ""
        echo "→ architecture: ya existe ($ARCH_DEST/README.md), no se sobrescribe"
      else
        mkdir -p "$ARCH_DEST"
        cp -R "$ARCH_SRC/"* "$ARCH_DEST/"
        echo ""
        echo "→ architecture: creado ($ARCH_DEST/README.md)"
      fi
    else
      echo "Advertencia: no se encontró $ARCH_SRC" >&2
    fi
  fi

  if [[ "$INIT_MINIMAL_RULE" == true ]]; then
    RULE_TEMPLATE="$SCRIPT_DIR/templates/cursor/minimal-code.mdc"
    RULE_DEST="$PROJECT_DIR/.cursor/rules/minimal-code.mdc"
    if [[ -f "$RULE_TEMPLATE" ]]; then
      if [[ -f "$RULE_DEST" ]]; then
        echo ""
        echo "→ minimal-code rule: ya existe ($RULE_DEST), no se sobrescribe"
      else
        mkdir -p "$PROJECT_DIR/.cursor/rules"
        cp "$RULE_TEMPLATE" "$RULE_DEST"
        echo ""
        echo "→ minimal-code rule: creada ($RULE_DEST) — activar manualmente en Cursor"
      fi
    else
      echo "Advertencia: no se encontró $RULE_TEMPLATE" >&2
    fi
  fi

  if [[ "$INIT_LEARNINGS_RULE" == true ]]; then
    RULE_TEMPLATE="$SCRIPT_DIR/templates/cursor/suite-learnings-capture.mdc"
    RULE_DEST="$PROJECT_DIR/.cursor/rules/suite-learnings-capture.mdc"
    if [[ -f "$RULE_TEMPLATE" ]]; then
      if [[ -f "$RULE_DEST" ]]; then
        echo ""
        echo "→ suite-learnings-capture rule: ya existe ($RULE_DEST), no se sobrescribe"
      else
        mkdir -p "$PROJECT_DIR/.cursor/rules"
        cp "$RULE_TEMPLATE" "$RULE_DEST"
        echo ""
        echo "→ suite-learnings-capture rule: creada ($RULE_DEST) — opt-in, activar en Cursor"
      fi
    else
      echo "Advertencia: no se encontró $RULE_TEMPLATE" >&2
    fi
  fi

  if [[ "$BOOTSTRAP_STRICT" == true ]]; then
    STRICT_SCRIPT="$SCRIPT_DIR/skills/harness-template/scripts/bootstrap-strict-check.sh"
    if [[ -f "$STRICT_SCRIPT" ]]; then
      echo ""
      chmod +x "$STRICT_SCRIPT"
      "$STRICT_SCRIPT" "$PROJECT_DIR" || exit 1
    else
      echo "Advertencia: no se encontró $STRICT_SCRIPT" >&2
    fi
  fi
fi

if [[ "$INIT_LEARNINGS_RULE_GLOBAL" == true ]]; then
  RULE_TEMPLATE="$SCRIPT_DIR/templates/cursor/suite-learnings-capture.mdc"
  RULE_DEST="$HOME/.cursor/rules/suite-learnings-capture.mdc"
  if [[ -f "$RULE_TEMPLATE" ]]; then
    mkdir -p "$HOME/.cursor/rules"
    cp "$RULE_TEMPLATE" "$RULE_DEST"
    echo ""
    echo "→ suite-learnings-capture: instalada global ($RULE_DEST) — alwaysApply activo"
  else
    echo "Advertencia: no se encontró $RULE_TEMPLATE" >&2
  fi
fi

echo ""
if [[ -n "$PROJECT_DIR" ]] && [[ "$INIT_AGENTS" == true || "$INIT_CODE_MAP" == true ]]; then
  if [[ "$BOOTSTRAP_STRICT" != true ]]; then
    echo "Post-bootstrap: personaliza AGENTS.md, docs/code-map.md y .cursor/project-memory.md."
    echo "  O ejecuta: install-local.sh --project . --bootstrap --strict (tras personalizar)"
  fi
fi
echo "Listo. Tras editar skills: collect-learnings.sh → skill-evolution → install-local.sh"
