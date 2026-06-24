# Inertia SPA Page — Harness Template

Bundle feedforward + feedback para una **página Inertia** (Laravel backend + Vue 3 o React en `resources/js/Pages/`).

## Cuándo usar

- Nueva pantalla en app Laravel + Inertia (dashboard, formulario, listado)
- Controller que devuelve `Inertia::render()` + componente de página
- El usuario pide "página Inertia", "vista Vue/React en Laravel", "screen del admin SPA"

## Skills a activar (en orden)

| Orden | Skill | Rol |
|-------|-------|-----|
| 1 | `harness-template` | Este bundle |
| 2 | `laravel-backend` | Controller, FormRequest, policies, Pest |
| 3 | `react-patterns` o stack frontend del repo | Componentes, hooks, forms (Vue: convenciones del repo) |
| 4 | `atomic-design` | Átomos/moléculas en `resources/js/Components/` |
| 5 | `karpathy-guidelines` | Checkpoints, escalación |
| 6 | `testing-strategy` | Feature test Inertia + behaviour harness |
| 7 | `comprobacion-produccion` | Post-implementación |

Opcional: `performance-web` (LCP, bundles), `web-interface-guidelines`, `ui-audit`.

## Detectar frontend

```bash
grep -E '"@inertiajs/vue3"|"@inertiajs/react"' package.json
ls resources/js/Pages 2>/dev/null
```

Vue 3 → páginas en `Pages/**/*.vue`; React → `Pages/**/*.tsx`.

## Archivos feedforward

| Archivo | Contenido |
|---------|-----------|
| `.cursor/project-memory.md` | `npm run build`, `vendor/bin/pest`, stack Inertia |
| `AGENTS.md` | Estructura `Pages/`, convención de layouts |
| `HandleInertiaRequests` | Props compartidas — no duplicar en cada página |

## Definition of Done

```bash
# Backend
php artisan route:list --path=<ruta>
vendor/bin/pest --filter=<PageTest>
./vendor/bin/pint --test    # si aplica

# Frontend
npm run build
npm run lint                # si existe
npm test                    # Vitest/Jest de componentes si aplica
```

Gate: Feature test que asserta `Inertia::render` con props clave (o `assertInertia` en Pest plugin); build frontend sin errores; estados loading/error en UI si hay async.

## Flujo recomendado

1. **AC** — props del servidor, acciones del usuario, permisos
2. **RED:** Pest `get('/ruta')->assertInertia(fn ($page) => ...)` que falla
3. **Ruta + Controller** — `Inertia::render('Pages/...', [...])`
4. **FormRequest** si hay mutación
5. **Página** — layout + componentes (`atomic-design`)
6. **GREEN** — Pest + `npm run build`
7. **Post-impl:** `comprobacion-produccion` §0

## Anti-patrones

- Props gigantes sin API Resource / DTO
- Lógica de negocio en el componente Vue/React (mantener en Action/Service)
- `router.visit` para datos que deberían venir del servidor en primera carga
- Olvidar `authorize()` en el controller

## Escalación

- Cambio de contrato de props compartidas globales → escalar
- Auth/roles en la página sin policy → escalar antes de merge
