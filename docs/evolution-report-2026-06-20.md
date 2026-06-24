# Reporte de evolución — 2026-06-20

Corrección del script de auditoría de integridad y auditoría completa de la suite (33 skills).

## Cambio aplicado

| Archivo | Qué |
|---------|-----|
| `skills/skill-evolution/SKILL.md` | Script de auditoría reescrito: detecta 3 patrones de enlace (mismo nivel + cruzados con `../` + cruzados sin `../`), elimina falsos positivos que reportaban enlaces cruzados válidos como rotos |

## Auditoría completa — 2026-06-20

| Chequeo | Resultado |
|---------|-----------|
| Enlaces rotos a references | **0** — todos los enlaces (mismo nivel y cruzados) son válidos |
| Frontmatter no portable | **0** |
| Herramientas de runtime específico | **0** |
| SKILL.md > 500 líneas | **0** — todas dentro del límite |

### Detalle de enlaces corregido

El script anterior solo detectaba `references/<file>.md` (mismo nivel). Los enlaces cruzados entre skills usaban:
- `../laravel-backend/references/stack-versions.md` (devops-base, nextjs-fullstack, software-project-analysis)
- `ui-web-modern/references/learning-sources.md` (atomic-design, team-onboarding, ui-audit)

El script corregido ahora valida los 3 patrones:
- **1a.** Mismo nivel: `references/<file>.md`
- **1b.** Cruzados con `../`: `../<skill>/references/...`
- **1c.** Cruzados sin `../`: `<skill>/references/...` (validado contra la suite completa)

## Frescura

Archivos con `last_updated` (revisar según caduca):

| Archivo | last_updated | revisar_cada |
|---------|--------------|--------------|
| `supply-chain-security/references/incidents-current.md` | **2026-05** | 30 días ⚠️ |
| `ui-web-modern/references/learning-sources.md` | **2026-06** | 90 días |
| `ui-web-modern/references/trends-watch.md` | **2026-06** | 90 días |

**⚠️ Prioridad**: `supply-chain-security/references/incidents-current.md` (CVE-2026-40261, Shai-Hulud, laravel-lang may 2026).

## Integridad de la suite

- **33 skills** verificadas (31 de dominio + 1 meta + 1 opt-in)
- **LEARNINGS.md**: 33 archivos (uno por skill)
- **References**: 108 archivos en total
- **Templates**: 2 (project-memory.md, memoria-section.md)
- **Docs**: 3 (2 evolution reports + stack-policy.md)

## Pendientes

- `supply-chain-security/references/incidents-current.md` vence pronto — actualizar.
- Siguiente consolidación: skill-evolution Modo 1 cuando haya entradas en LEARNINGS.md.
- Verificar `install-local.sh --project <repo> --init-memory` tras cambios de suite.

## Referencia anterior

`docs/evolution-report-2026-06-12.md`