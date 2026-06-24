# Suite Dev Studio — Skills de Desarrollo
Generado: 2026-05-31 · Optimizado: 2026-06-11 (v2) · Memoria: 2026-06-11 (v2.1) · Recursos UX: 2026-06-12 · Harness: 2026-06-24 (v3.4)
Total: 38 skills (33 de dominio + 4 meta/proceso + 1 integración opt-in)

## Capa 1 — Negocio / Cliente
  propuestas-contratos     → Propuestas, contratos, scope, scope creep, CRs
  project-pricing          → Modelos de cobro, estimación, tarifas, comunicar precio
  software-project-analysis → Análisis técnico antes de arrancar
  sprint-planning          → Gestión ágil, backlog, estimación, retrospectivas

## Capa 2 — Arquitectura Técnica
  web-architecture         → Patrones, decisiones estructurales, escalabilidad
  database-design          → Modelado, migraciones, índices, performance
  api-design               → REST/GraphQL, versionado, seguridad, documentación
  laravel-backend          → Laravel (versión actual del proyecto o última estable), Eloquent, Filament, Octane, Horizon
  node-backend             → NestJS, Express, BullMQ, WebSockets, testing
  nextjs-fullstack         → App Router, RSC, SSR/SSG/ISR, deploy Vercel
  react-patterns           → Hooks, estado global, performance, formularios, testing
  mobile-flutter           → Flutter/Dart, Riverpod, GoRouter, stores, deploy
  mobile-react-native      → Expo, React Navigation, offline, push, EAS Build
  devops-base              → Docker, CI/CD, GitHub Actions, secrets, deploy

## Capa 3 — Calidad / Proceso / Seguridad
  testing-strategy         → Pirámide de tests, unitarios, integración, E2E;
                             behaviour harness (AC, fixtures aprobados)
  comprobacion-produccion  → Gates pre/post prod, feedback FB-3, validate-fb3.sh
  karpathy-guidelines      → Cambios quirúrgicos, checkpoints, escalación
  vibe-coding-token-optimization → Output conciso, reglas observables
  security-checklist       → OWASP, auth segura, secrets, CORS, CSP, auditoría
  supply-chain-security    → Seguridad del toolchain npm/Composer + incidentes activos
  performance-web          → Core Web Vitals, caché, bundle, lazy loading
  git-workflow             → Branching, commits convencionales, PR, code review
  problem-solving-dev      → Resolución con repos, docs oficiales, GitHub issues
  monitoring-observability → Logs, métricas, alertas, Sentry, Grafana, on-call
  team-onboarding          → Dev nuevo → primer PR en 5 días hábiles

## Capa 4 — Diseño / UX
  ux-discovery             → Research, arquetipos, mapas de empatía, journeys
  ux-architecture          → IA, sitemaps Mermaid, wireframes, flujos de pantallas
  ui-web-modern            → Tipografía, color, grid, micro-interacciones;
                             recursos free: references/learning-sources.md
  ui-audit                 → Inconsistencias, WCAG, heurísticas de Nielsen;
                             principios UX free: references/ux-principles-free.md
  design-system            → Tokens, componentes, documentación, governance
  atomic-design            → Átomos → Moléculas → Organismos → Templates → Páginas
  ui-admin-dashboard       → Data tables, formularios complejos, KPIs, frameworks
  ui-mobile-native         → iOS HIG, Material 3, gestos, navegación, RN/Flutter

## Actualización
  prompt-engineer          → Modelos razonadores + agentes de desarrollo
                             (lista de modelos en data/ con last_updated)

## Meta
  skill-evolution          → Mantenimiento: LEARNINGS, integridad, frescura,
                             Modo 4 HARNESS-FAILURES, Modo 5 readiness /20
  docs/suite-code-map.md     → Mapa FF-2 (dónde leer antes de editar)
  scripts/harness-test.sh  → Gate FB-2 suite (FB-3 + integridad + RED + readiness ≥16)
  install-local.sh           → --init-harness-test → scripts/harness-test.sh en cliente
  harness-template/scripts/  → harness-test-project.sh, harness-readiness.*
  templates/code-map.md      → Mapa FF-2 clientes (--init-code-map → docs/code-map.md)
  docs/harness-release.md    → Checklist oleada + Modo 6 skill-evolution
  docs/harness-release-log.md → Registro RED/GREEN por release (CI ≤90 días)
  templates/docs/architecture/ → FF-4 clientes (--init-architecture)
  templates/docs/architecture/adr/ → 000-template.md (--init-architecture)
  install-local.sh --bootstrap → todos los --init-* en un comando
  validate-project-memory.sh   → IN-3 personalizado (proyectos cliente)
  install-local.sh --bootstrap --strict → gate plantillas personalizadas
  docs/releases/harness-v3.4.md  → Notas release tag harness-v3.4
  scripts/tag-harness-release.sh → Valida gates + comando git tag
  skill-evolution Modo 7        → Cierre trimestral (quarterly-harness.md)
  docs/harness-quarterly-2026-06.md → Informe Modo 7 trimestral
  vibe-coding VC-RED-01/02 → Gate 5/5 skills disciplina completado
  Madurez harness estimada: ~100% (tag harness-v3.4 aplicado localmente)
  templates/AGENTS.md      → Mapa ~100 líneas para repos (--init-agents)
  testing-skills-with-subagents → RED/GREEN de skills de disciplina (subagentes)
  HARNESS-FAILURES.md      → Catálogo global de fallos del agente (raíz skills/)

## Integración opt-in
  graphify-integration     → Grafo de conocimiento del codebase (Graphify).
                             Solo si project-memory tiene Graphify enabled o el
                             usuario lo pide. Sin alwaysApply en reglas Cursor.

## Estándar v2 (optimización 2026-06-11)
Cada skill cumple:
  - Frontmatter portable: solo name + description (Cursor, Claude Code y otros IDEs)
  - Protocolo de ejecución con pasos numerados y gates verificables (comandos shell)
  - Defaults si falta contexto: el agente asume y declara en vez de preguntar
  - Entregable con plantilla de output estándar
  - Skills relacionadas en el cuerpo (solo skills existentes)
  - Aprendizaje continuo: LEARNINGS.md por skill, consolidado por skill-evolution
  - Visuales portables: Mermaid, tablas markdown, ASCII (sin tools de runtime)
  - SKILL.md < 500 líneas con disclosure progresivo hacia references/

## Política de versiones del stack
  Usar **últimas versiones estables** de lenguajes, frameworks y paquetes.
  Precedencia: composer.json / package.json → project-memory / PRD → greenfield latest stable.
  Reference portable: `laravel-backend/references/stack-versions.md`
  Origen repo: `docs/stack-policy.md`
  No fijar Laravel 11 u otras majors viejas en defaults; el proyecto (ej. Laravel 13) manda.

## Sistema de memoria (L0–L3)
  L0 — Sesión: contexto del chat; no persistir salvo petición
  L1 — Skill: SKILL.md + references/ bajo demanda
  L2 — Proyecto: `.cursor/project-memory.md` (plantilla en templates/)
  L3 — Aprendizaje: LEARNINGS.md por skill → consolidado por skill-evolution
  Harness — HARNESS-FAILURES.md (raíz skills/) → steering loop (skill-evolution Modo 4)

  Skills con `## Memoria` + `## Validación` (Fase A): **33/33 skills de dominio** (capas Negocio, Backend, Calidad, Front, Diseño).
  Meta (`skill-evolution`) y opt-in (`graphify-integration`) usan protocolo propio.

## Sistema de aprendizaje
  1. Al usar una skill, el agente registra gaps/correcciones/mejoras en su LEARNINGS.md
  2. skill-evolution consolida las entradas pendientes en los SKILL.md (con aprobación)
  3. skill-evolution audita integridad (enlaces, frontmatter, límites de líneas)
  4. Datos con caducidad aislados con last_updated + revisar_cada; skill-evolution
     lista los vencidos y los actualiza vía web

## Notas
  Datos time-sensitive aislados en archivos dedicados:
    - supply-chain-security/references/incidents-current.md (last_updated: 2026-05,
      revisar cada 30 días): laravel-lang 22-23 may 2026, Shai-Hulud, CVE-2026-40261
    - prompt-engineer/data/routing-suites-models.md (modelos razonadores)
    - ui-web-modern/references/trends-watch.md (last_updated: 2026-06, cada 90 días)
    - ui-web-modern/references/learning-sources.md (last_updated: 2026-06, cada 90 días):
      catálogo recursos UX/UI gratuitos (literal vs inspiración); tendencias ≠ verdades
    - ui-audit/references/ux-principles-free.md (last_updated: 2026-06, cada 90 días):
      checklist auditoría subset gratuito uxuiprinciples.com
  Reporte: docs/evolution-report-2026-06-12.md
