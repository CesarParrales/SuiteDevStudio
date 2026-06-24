# Next.js SaaS Page — Harness Template

Bundle feedforward + feedback para una **página o feature SaaS** en Next.js (App Router): landing, dashboard, settings, onboarding.

## Cuándo usar

- Nueva ruta/pantalla en app SaaS existente
- Feature con UI + datos + auth (dashboard, billing, settings)
- El usuario pide "página Next.js", "feature SaaS", "pantalla en el dashboard"

## Skills a activar (en orden)

| Orden | Skill | Rol en el harness |
|-------|-------|---------------------|
| 1 | `harness-template` | Este bundle |
| 2 | `nextjs-fullstack` | App Router, RSC, Server Actions, auth |
| 3 | `react-patterns` | Estado, hooks, composición cliente |
| 4 | `karpathy-guidelines` | Checkpoints, escalación |
| 5 | `testing-strategy` | AC + behaviour harness; Vitest/Playwright |
| 6 | `comprobacion-produccion` | Post-implementación + FB-3 |

Opcional: `web-interface-guidelines` (revisión UI), `performance-web` (Core Web Vitals), `security-checklist` (auth/rutas sensibles), `emil-design-eng` (motion — si está instalada fuera de la suite).

## Archivos de proyecto (feedforward)

| Archivo | Contenido mínimo |
|---------|------------------|
| `.cursor/project-memory.md` | Next.js version, `npm run build`, `npm test` |
| `AGENTS.md` | Convenciones RSC vs client, estructura `app/` |
| `design-system/MASTER.md` o tokens | Si existe — respetar; si no, generar con `ui-ux-pro-max` si está disponible |

## Definition of Done (verificable)

```bash
# 1. Build sin errores
npm run build

# 2. Lint / tipos (si existen en package.json)
npm run lint
npx tsc --noEmit

# 3. Tests relevantes
npm test
# o: npx vitest run
# E2E crítico (si existe): npx playwright test <spec>

# 4. Ruta accesible (dev o preview)
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/<ruta>
# Auth: ruta protegida sin sesión → 307/401 según middleware
```

Gate: build exit 0; tests acordados en el Test Plan exit 0; revisión UI con `web-interface-guidelines` si hay componentes nuevos.

## Flujo recomendado

1. **AC** (Given/When/Then) → `testing-strategy/references/behaviour-harness.md`
2. **Server vs Client** → árbol en `nextjs-fullstack` (`references/server-client.md`); `'use client'` solo en hojas interactivas
3. **RED:** test de componente o E2E mínimo que falla
4. **Implementar** ruta + componentes + fetch/Server Action
5. **GREEN** + `npm run build`
6. **Checkpoint** si >5 archivos o >300 líneas (`karpathy-guidelines` §5)
7. **Post-impl:** `comprobacion-produccion` §0

## Sensores

| Sensor | Tipo | Cuándo |
|--------|------|--------|
| `npm run build` | Computacional | Tras cada ruta nueva o cambio de data fetching |
| `npm test` / Vitest | Computacional | Tras lógica o componentes con comportamiento |
| `web-interface-guidelines` | Inferencial | Tras UI nueva |
| Lighthouse / CWV | Computacional | Features públicas (opcional `performance-web`) |

## Anti-patrones

- `'use client'` en layout o página entera sin necesidad
- Fetch en Client Component cuando basta Server Component
- Tests solo de snapshot sin assert de comportamiento
- Ignorar `loading.tsx` / `error.tsx` en rutas con async data

## Escalación

- Auth/billing sin spec → escalar antes de implementar
- Build falla 2 veces por el mismo error → FB-3 + escalar (`karpathy-guidelines` §6)
