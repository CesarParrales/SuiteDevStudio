# CI del harness — Suite Dev Studio

El repositorio **suite-dev-studio** valida el harness en cada PR/push que toque `skills/` o `templates/`.

## Workflow

Archivo: [`.github/workflows/harness-validate.yml`](../.github/workflows/harness-validate.yml)

| Job | Qué valida |
|-----|------------|
| `validate-fb3` | Fixture FB-3 con `validate-fb3.sh --strict` |
| `skill-integrity` | SKILL.md ≤500 líneas, referencias rotas, frontmatter portable |
| `harness-templates` | 7 plantillas + `AGENTS.md` + `HARNESS-FAILURES.md` |
| `harness-readiness` | Score /20 ≥16 (`--ci`) sobre suite + `.cursor/project-memory.md` |
| `red-scenarios` | Estructura de `scenarios-discipline.md` (IDs + GREEN) |
| `release-red` | `validate-release-red.sh` — log ≤90 días |
| `meta-harness` | `validate-meta-harness.sh` — artefactos ~98% |

**Local (todo en uno):** `bash scripts/harness-test.sh`

## Reutilizar en un proyecto cliente

1. Instalar skills y artefactos opcionales:

```bash
/path/to/suite-dev-studio/install-local.sh --project . --bootstrap
# Tras personalizar plantillas:
/path/to/suite-dev-studio/install-local.sh --project . --bootstrap --strict
```

Esto copia `templates/github/harness-validate-project.yml` → `.github/workflows/harness-validate.yml` si no existe.

2. O copiar manualmente [templates/github/harness-validate-project.yml](../templates/github/harness-validate-project.yml).

3. Generar `feedback/ci-failures.txt` en formato FB-3 cuando un bot reformatee fallos de tests.

## FF-2 code-map (cliente)

Si existe `docs/code-map.md`:

```bash
bash .cursor/skills/harness-template/scripts/validate-code-map.sh docs/code-map.md
```

Modo estricto (falla si falta archivo): `VALIDATE_CODE_MAP_STRICT=true`

## FF-1 AGENTS.md (cliente)

```bash
bash .cursor/skills/harness-template/scripts/validate-agents.sh AGENTS.md
```

Tras `--bootstrap`, personalizar `AGENTS.md`, `docs/code-map.md` y `.cursor/project-memory.md` antes de `scripts/harness-test.sh`.

## Meta-harness (~98%)

```bash
bash skills/harness-template/scripts/validate-meta-harness.sh
```

Ver [harness-meta-checklist.md](../harness-meta-checklist.md).

## Readiness /20 (Modo 5)

```bash
# Suite
bash skills/harness-template/scripts/harness-readiness.sh --suite ./skills

# Proyecto
bash .cursor/skills/harness-template/scripts/harness-readiness.sh --project .
```

## Ejecutar localmente (antes de PR)

```bash
bash scripts/harness-test.sh
```

O por partes:

```bash
chmod +x skills/comprobacion-produccion/scripts/validate-fb3.sh
skills/comprobacion-produccion/scripts/validate-fb3.sh --strict \
  skills/comprobacion-produccion/scripts/fixtures/fb3-valid.txt

# Integridad (desde raíz suite-dev-studio)
wc -l skills/*/SKILL.md | awk '$1 > 500'

# Enlaces markdown locales rotos (mismo criterio que CI)
for d in skills/*/; do
  [ "$(basename "$d")" = "skill-evolution" ] && continue
  grep -oE '\((references/[a-zA-Z0-9_-]+\.md)\)' "$d/SKILL.md" 2>/dev/null | tr -d '()' | while read -r ref; do
    [ -f "$d$ref" ] || echo "ROTO: $d → $ref"
  done
done
bash skills/harness-template/scripts/harness-readiness.sh --suite ./skills --project . --ci
```

## Umbral CI

- `--ci` → falla si score &lt; **16/20**
- `--min-score N` → umbral personalizado

## Añadir una plantilla nueva

1. Crear `skills/harness-template/templates/<id>.md`
2. Registrar en `harness-template/SKILL.md` y `task-routing.md`
3. Añadir `<id>` al job `harness-templates` en el workflow
4. `skill-evolution` Modo 4 si hubo fallo que motivó la plantilla
