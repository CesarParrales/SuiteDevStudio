# Enrutamiento por tipo de tarea (FF-3)

Antes de actuar, **clasificar la tarea** y activar solo el bundle de skills y herramientas que corresponde. Evita mezclar flujos (ej. revisar UI con skills de backend) o usar herramientas de edición en tareas de solo lectura.

## Matriz de enrutamiento

| Tipo de tarea | Señales en el pedido | Skills prioritarias | Sensores al cerrar |
|---------------|----------------------|---------------------|-------------------|
| **Scaffold / feature grande** | "nuevo módulo", "crear feature", >5 archivos | `harness-template` → topología + bundle | DoD de la plantilla |
| **Implementación acotada** | fix, un endpoint, un componente | Dominio (`laravel-backend`, `nextjs-fullstack`, …) + `karpathy-guidelines` | `comprobacion-produccion` §0 |
| **Tests** | "añadir tests", TDD, cobertura | `testing-strategy` + behaviour harness | `npm test` / `vendor/bin/pest` exit 0 |
| **Revisión UI** | review UI, accesibilidad, PR frontend | `web-interface-guidelines` o `ui-audit` | Formato `archivo:línea` |
| **Revisión pre-prod / release** | merge, deploy, go-live | `comprobacion-produccion` §1–2 | Tabla Hecho/Falta |
| **Diseño / UX** | wireframe, flujo, research | `ux-discovery`, `ux-architecture`, `ui-ux-pro-max` | AC escritos |
| **Editar skill de disciplina** | cambiar reglas, gates, anti-patrones | `skill-evolution` + `testing-skills-with-subagents` | RED/GREEN obligatorio |
| **Mantenimiento suite** | consolidar, auditar, frescura | `skill-evolution` Modo 1–3 | Modo 2 gate vacío |
| **Fallo repetido del agente** | mismo error 2+ veces | `karpathy-guidelines` §6 + `skill-evolution` Modo 4 | Entrada en `HARNESS-FAILURES.md` |

## Topologías (harness-template)

| Pedido / stack detectado | Plantilla |
|--------------------------|-----------|
| Laravel API | `templates/laravel-api-module.md` |
| Next.js SaaS / App Router | `templates/nextjs-saas-page.md` |
| Flutter feature / pantalla | `templates/flutter-feature.md` |
| NestJS módulo API | `templates/node-api-nest.md` |
| Filament admin resource | `templates/laravel-filament-resource.md` |
| Expo / RN screen | `templates/react-native-screen.md` |
| Laravel + Inertia página | `templates/inertia-spa-page.md` |

Si no hay plantilla: dominio + `karpathy-guidelines` + `comprobacion-produccion` §0.

## Detección automática de stack (antes de elegir skills)

```bash
# Laravel
test -f composer.json && grep -q laravel/framework composer.json && echo laravel

# Next.js
test -f package.json && grep -q '"next"' package.json && echo nextjs

# Flutter / RN
test -f pubspec.yaml && echo flutter
test -f package.json && grep -q expo package.json && echo react-native
```

## Permisos y herramientas (acotar superficie)

| Tipo | Edición | Ejecución shell | Subagentes |
|------|---------|-----------------|------------|
| Revisión / auditoría | No (salvo fix pedido) | Solo lectura, tests | `readonly: true` |
| Implementación | Sí | Tests, build, migrate | Normal |
| Test de skills (RED) | No incluir skill en prompt | Aislado | `readonly: true`, subagente fresco |
| Cambio riesgoso (auth, prod) | Tras spec | Staging/worktree si aplica | Ver `staging-isolation.md` |

## Salida al usuario

Si el tipo de tarea es ambiguo, declarar en una línea: **"Tipo: X → activo skills: A, B, C"** antes de ejecutar.
