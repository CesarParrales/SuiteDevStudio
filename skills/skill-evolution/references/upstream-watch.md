# Vigilancia de skills externas

Registro de fuentes de terceros que ya alimentan la suite. No se instalan como skills hermanas. Se destila lo que falta y se deja el crédito.

`last_updated: 2026-11-03`
`revisar_cada: 60 días` para las de oficio visual. El resto, 90 días, salvo que la fila diga otra cosa.

## Cómo revisar una fila

1. Abrir la URL. Leer el README o el changelog desde `last_reviewed`.
2. Comparar con la columna Adoptado. Anotar solo una regla nueva que la suite no tenga y que no contradiga un gate existente.
3. Proponer el cambio. No editar el SKILL hasta aprobación (igual que el Modo 1).
4. Si no hay cambio útil, igual actualizar `last_reviewed` de esa fila a la fecha de la revisión.

## Registro

| Fuente | last_reviewed | Cada | Adoptado | No se trae |
|---|---|---|---|---|
| [emilkowalski/skills](https://github.com/emilkowalski/skills) (MIT) | 2026-10-09 | 60 días | `ui-web-modern/references/motion-craft.md` | Paquete completo, Swift, Expo, prototipos |
| [Leonxlnx/taste-skill](https://github.com/leonxlnx/taste-skill) v2 experimental (MIT) | 2026-10-09 | 60 días | `ui-web-modern/references/design-read.md` | GSAP, skills de imagen, variantes brutalista/soft |
| [Impeccable](https://impeccable.style) | 2026-10-09 | 60 días | `ui-audit/references/ai-slop.md` | CLI, hooks, detector, `DESIGN.md` paralelo a project-memory |
| [gpt-6-astra-10k-websites](https://github.com/Barty-Bart/gpt-6-astra-10k-websites) (sin licencia clara) | 2026-10-17 | 60 días | `ui-web-modern/references/scroll-story.md` | Prompts enteros, Higgsfield MCP, secuencias de frames como default |
| [agentskills.io](https://agentskills.io/specification) | 2026-10-09 | 90 días | El formato ya es el de la suite (`name`, `description`, `references/`) | `allowed-tools`; `compatibility` solo si una skill lo exige |
| [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) (MIT) | 2026-10-01 | 90 días | `security-checklist/references/audit.md` | Flota de cazadores |
| [Kiro specs](https://kiro.dev/docs/specs/) | 2026-10-01 | 90 días | `harness-template/references/work-spec.md` | Instalar Kiro o `.kiro/` |
| [Ponytail](https://github.com/DietrichGebert/ponytail) (MIT) | 2026-06-24 | 90 días | `vibe-coding-token-optimization/references/decision-ladder.md` | `alwaysApply` fijo |
| prompt-master, citado como v1.6.0 en `prompt-engineer/references/04-credit-killing-patterns.md` | 2026-06-01 | 90 días | Patrones de crédito en esa reference | Copiar el paquete |
| [El Rincón de Isma](https://www.elrincondeisma.com/blog/tres-errores-ia-laravel) | 2026-10-21 | 90 días | `laravel-backend/references/vibe-fallos.md` | Equipo de 10 agentes, homelab, kit de VPS |
| [Elkis Dev — Arquitectura de software](https://github.com/elkisdm/devground/tree/main/knowledge) (guía PDF práctica) | 2026-11-03 | 90 días | `web-architecture/references/config-placement.md`, `external-calls.md`; plano 3.0 en `software-project-analysis/references/phases.md` | Stack fijo Next/Supabase/Resend/Railway; metáfora sola; knowledge base entera |

Ponytail y prompt-master superan su cadencia en esta primera carga del registro. La próxima pasada del Modo 8 empieza por esas dos filas.
