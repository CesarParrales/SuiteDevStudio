# Aislamiento para cambios riesgosos (IN-5)

Cuando el cambio toca **auth, pagos, migraciones destructivas o refactors grandes**, no experimentar en el working tree principal sin red de seguridad.

## Cuándo aislar

| Señal | Aislamiento recomendado |
|-------|-------------------------|
| Refactor >10 archivos | Rama git dedicada |
| Probar skill nueva o escenario RED | Subagente `readonly: true` o directorio desechable |
| Migración con downtime potencial | Staging + backup documentado |
| Comparar 2 enfoques de implementación | Git worktree o `best-of-n-runner` (Cursor) |

## Git worktree (rápido)

```bash
git worktree add ../proyecto-harness-exp -b harness/exp-<tema>
cd ../proyecto-harness-exp
# trabajar; al terminar: merge o descartar
git worktree remove ../proyecto-harness-exp
```

## Subagente aislado (Cursor)

- `Task` con `readonly: true` para revisiones y baseline RED de skills
- Prompt sin incluir la skill bajo prueba en fase RED
- No compartir subagente entre escenarios de presión

## Staging del harness (suite)

Antes de `install-local.sh` global tras editar muchas skills:

1. `skill-evolution` Modo 2 — integridad
2. Si editaste skill de **disciplina** → `testing-skills-with-subagents` RED/GREEN
3. Instalar en proyecto de prueba: `./install-local.sh --no-global --project /ruta/sandbox`
4. Solo entonces → `./install-local.sh` global

## Rollback

- Suite: `git checkout` en suite-dev-studio + reinstalar
- Proyecto: rama/commit documentado en `project-memory.md` → Decisiones
