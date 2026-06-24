# Meta-harness — checklist de cierre (suite ~99%)

Usar al cerrar oleadas, antes de tag `harness-v*`, o en **Modo 7** trimestral. Complementa `scripts/harness-test.sh`.

`last_updated: 2026-06-24` (oleada 14 / v3.4)

## Automatizado (CI / local)

```bash
bash scripts/harness-test.sh
bash skills/harness-template/scripts/validate-meta-harness.sh
```

## Artefactos obligatorios

| Ítem | Ruta | Verificación |
|------|------|--------------|
| Gate suite | `scripts/harness-test.sh` | exit 0 |
| Bootstrap | `install-local.sh --bootstrap` + `--strict` tras personalizar |
| Validadores FF | `validate-agents.sh`, `validate-code-map.sh`, `validate-project-memory.sh` | existen + ejecutables |
| Release notes | `docs/releases/harness-v3.4.md` | existe |
| Tag helper | `scripts/tag-harness-release.sh` | exit 0 con versión |
| Modo 7 | `skill-evolution/references/quarterly-harness.md` | existe |
| Release RED | `docs/harness-release-log.md` | ≤90 días (`validate-release-red.sh`) |
| Escenarios | `scenarios-discipline.md` | ≥14 RED (`validate-red-scenarios.sh`) |
| Readiness | score ≥16/20 | `--ci` en CI |
| Memoria suite | `.cursor/project-memory.md` | `validate-project-memory.sh` |

## Manual (5 min)

- [ ] `MANIFIESTO.md` versión harness alineada con última oleada
- [ ] `~/.cursor/skills/` sincronizado (`install-local.sh` global)
- [ ] `bash scripts/tag-harness-release.sh v3.4` → exit 0 antes de `git tag`
- [ ] 1 escenario RED+GREEN registrado en release-log (Modo 6) o cierre trimestral (Modo 7)
- [ ] Variantes ciegas RED (`HT-RED-05+`) revisadas si RED→B sin skill
- [ ] Plantillas cliente sin drift (`templates/` vs docs)

## Proyecto cliente (post `--bootstrap`)

1. Personalizar `AGENTS.md`, `docs/code-map.md`, `.cursor/project-memory.md`
2. `bash scripts/harness-test.sh` → exit 0
3. Readiness proyecto ≥16/20

## Madurez

| Nivel | Criterio |
|-------|----------|
| ~96% | harness-test + bootstrap + validadores FF |
| ~98% | + meta-checklist manual + release RED vigente |
| ~99% | + `docs/releases/harness-v*.md` + `tag-harness-release.sh` + Modo 7 |
| 100% | + 5/5 skills disciplina con RED/GREEN verificados (oleada 19) |
