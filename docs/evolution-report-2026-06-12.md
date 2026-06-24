# Reporte de evolución — 2026-06-12

Ampliación de recursos UX/UI gratuitos (uso literal + inspiración) integrada en skills, canvas y memoria de proyecto.

## Cambio aplicado

| Área | Archivo | Qué |
|------|---------|-----|
| Catálogo central | `ui-web-modern/references/learning-sources.md` | 10 fuentes free, flujo punta a punta, literal vs inspiración |
| Auditoría UX | `ui-audit/references/ux-principles-free.md` | Checklist UXF-01…09 (subset gratuito uxuiprinciples) |
| Inspiración | `ui-web-modern/references/inspiration.md` | Hubs FormiUX, KIT UX UI, 21st.dev |
| Tendencias | `ui-web-modern/references/trends-watch.md` | Radar Acceseo 2026 + 21st.dev / UX Pilot free |
| Prototipado | `ux-architecture/references/prototyping.md` | Herramientas free opcionales |
| Skills | `ui-web-modern`, `ui-audit`, `atomic-design`, `team-onboarding` | Índices y protocolo |
| Canvas | `canvases/auditoria-suite-dev-skills.canvas.tsx` | Pestaña Recursos + sync metadata |
| Memoria | `templates/project-memory.md`, SocialToolsDev L2 | Punteros recursos UX |
| Manifiesto | `MANIFIESTO.md` | Nota learning-sources + revisión 90d |

## Regla operativa

```
Principios free (uxuiprinciples)     → checklist literal en ui-audit
21st.dev / FormiUX / iconos / color  → literal con adaptación de tokens
MotionSites / Acceseo / UX Pilot     → inspiración o prototipo → gate ui-audit
Tendencias                           → NO son verdades; revisar trends-watch cada 90d
```

## Sincronización (12 jun 2026)

| Destino | learning-sources.md | ux-principles-free.md | SKILL.md ui-web-modern / ui-audit |
|---------|---------------------|----------------------|-----------------------------------|
| `suite-dev-studio/skills/` | ✓ origen | ✓ origen | ✓ |
| `~/.cursor/skills/` | ✓ | ✓ | ✓ |
| `SocialToolsDev/.cursor/skills/` | ✓ | ✓ | ✓ |

Comando: `./install-local.sh` + `./install-local.sh --no-global --project /ruta/SocialToolsDev`

## Frescura

| Archivo | last_updated | revisar_cada | Acción |
|---------|--------------|--------------|--------|
| `learning-sources.md` | 2026-06 | 90 días | Verificar tiers free y URLs |
| `trends-watch.md` | 2026-06 | 90 días | Filtrar moda vs principio |
| `ux-principles-free.md` | 2026-06 | 90 días | Confirmar subset gratuito uxuiprinciples |

## Pendientes

- Registrar gaps en LEARNINGS.md tras uso real en SocialToolsDev (URLs rotas, tiers cambiados).
- Próxima consolidación: skill-evolution Modo 1 cuando haya entradas pendientes.

## Referencia anterior

Post-Fase A y triple sync: `docs/evolution-report-2026-06-11.md`
