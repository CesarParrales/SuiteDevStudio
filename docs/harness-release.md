# Release harness — Suite Dev Studio

Checklist al cerrar una **oleada** o versión harness del MANIFIESTO (v3.x).

## Antes de merge

1. `bash scripts/harness-test.sh` → exit 0
2. **1 escenario RED + GREEN** (subagente fresco, `testing-skills-with-subagents`)
3. Entrada en [harness-release-log.md](harness-release-log.md)
4. Si fallo sistémico → `skills/HARNESS-FAILURES.md` + skill-evolution Modo 4
5. Sincronizar `~/.cursor/skills/` si aplica

## Cómo ejecutar RED/GREEN

1. Elegir escenario en `skills/testing-skills-with-subagents/references/scenarios-discipline.md` (preferir uno nuevo o no ejecutado en 90 días).
2. **RED:** subagente `generalPurpose`, solo el texto del escenario (sin skill).
3. Capturar decisión A/B/C y justificación **verbatim**.
4. **GREEN:** subagente nuevo, mismo escenario + SKILL.md completo antepuesto.
5. Registrar en `harness-release-log.md`.

## Plantilla de entrada (log)

```markdown
### YYYY-MM-DD · vX.Y oleada N
- **Escenario:** XX-RED-NN
- **Skill:** nombre-skill
- **RED:** A|B|C — <justificación verbatim breve>
- **GREEN:** A|B|C — <cumple skill>
- **Ejecutor:** …
- **Artefactos:** …
```

## Validación CI

`skills/testing-skills-with-subagents/scripts/validate-release-red.sh` comprueba:

- Log con entrada en los últimos **90 días**
- ID de escenario válido (`CP-RED-NN`, etc.)
- Campos RED y GREEN documentados

## Modo skill-evolution

Usar **Modo 6 — Release harness** al cerrar oleadas; **Modo 7 — Cierre trimestral** cada 8–12 semanas o antes de tag `harness-v*` (ver `skill-evolution/SKILL.md` y `references/quarterly-harness.md`).
