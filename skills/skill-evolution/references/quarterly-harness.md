# Cierre trimestral harness — checklist

Ejecutar vía `skill-evolution` **Modo 7** cada **8–12 semanas** o al etiquetar `harness-v*`.

## Automatizado (obligatorio)

```bash
bash scripts/harness-test.sh
skills/testing-skills-with-subagents/scripts/validate-release-red.sh
skills/harness-template/scripts/validate-meta-harness.sh
```

## Revisión humana (~30 min)

| Ítem | Acción |
|------|--------|
| `HARNESS-FAILURES.md` | Cerrar entradas con remediación aplicada |
| `LEARNINGS.md` disciplina | Consolidar pendientes >30 días |
| Escenarios RED | ≥1 RED+GREEN nuevo o re-verificación por skill editada |
| `MANIFIESTO.md` | Versión harness y madurez estimada |
| `~/.cursor/skills/` | `./install-local.sh` global |
| Proyectos activos | Recordar `--bootstrap --strict` |

## Entregable

1. Entrada en `docs/harness-release-log.md` (versión tag)
2. Archivo `docs/releases/harness-vX.Y.md` si hay tag
3. Informe Modo 5 (score /20 + top 3 gaps) — plantilla: `docs/harness-quarterly-YYYY-MM.md`

## Criterio de tag

Solo etiquetar `harness-vX.Y` cuando:

- `harness-test.sh` → exit 0
- Release log ≤90 días con RED **y** GREEN documentados
- Sin entradas críticas abiertas en HARNESS-FAILURES
