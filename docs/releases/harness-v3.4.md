# Release harness v3.4 — Suite Dev Studio

**Fecha:** 2026-06-24  
**Tag sugerido:** `harness-v3.4`  
**Madurez:** ~100% (automatizado 20/20)

## Resumen

Oleadas 1–17: harness operativo para suite y proyectos cliente. Modo 7 trimestral ejecutado oleada 17. Variantes RED ciegas verificadas. Primera disciplina fuera de harness-template/comprobacion en release log (`karpathy-guidelines`).

## Highlights

| Área | Entregable |
|------|------------|
| Feedforward | `--bootstrap --strict`, validadores FF/IN |
| Feedback | FB-3 CI, contra-reglas PM/social/reviewer |
| Infrastructure | 7 jobs CI, `meta-harness`, `harness-test.sh` |
| Team | Modo 5–7 `skill-evolution`, `harness-quarterly-2026-06.md` |
| Disciplina | 19 escenarios RED; HT-RED-05/06 ciegos; KG-RED-01/03 |

## Comandos clave

```bash
bash scripts/harness-test.sh
bash scripts/tag-harness-release.sh v3.4
./install-local.sh --project . --bootstrap --strict
```

## RED/GREEN destacados

| Oleada | Escenario | RED | GREEN |
|--------|-----------|-----|-------|
| 13–14 | HT-RED-04 | A social | B |
| 15–16 | HT-RED-05/06 ciegos | A | B |
| 17 | KG-RED-01/03 | B / C | A / B |

## Crear tag (manual)

```bash
cd suite-dev-studio
bash scripts/tag-harness-release.sh v3.4
git tag -a harness-v3.4 -m "Harness suite v3.4 — Modo 7, disciplina karpathy, variantes ciegas"
git push origin harness-v3.4
```

## Próximo trimestre

- Mantenimiento Modo 7; re-verificar escenarios si skills de disciplina cambian
- Tag `harness-v3.4` manual cuando maintainer autorice
