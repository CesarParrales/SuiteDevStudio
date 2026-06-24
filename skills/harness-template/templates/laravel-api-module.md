# Laravel API Module — Harness Template

Bundle de feedforward + feedback para un **nuevo módulo API** en Laravel 11+ con `nwidart/laravel-modules`.

## Cuándo usar

- Scaffolding de módulo nuevo con endpoints REST
- Migración de feature monolítica a módulo
- El usuario pide "módulo Laravel API" sin especificar skills

## Skills a activar (en orden)

| Orden | Skill | Rol en el harness |
|-------|-------|---------------------|
| 1 | `harness-template` | Este bundle |
| 2 | `laravel-backend` | Estructura Laravel, Eloquent, API, testing |
| 3 | `laravel-modular` *(opcional)* | Solo si el repo usa `nwidart/laravel-modules` |
| 4 | `karpathy-guidelines` | Cambios quirúrgicos, checkpoints, escalación |
| 5 | `testing-strategy` | Plan de tests + `references/behaviour-harness.md` |
| 6 | `comprobacion-produccion` | Revisión post-implementación |

Opcional según alcance: `api-design`, `security-checklist`.

## Archivos de proyecto (feedforward)

Crear o actualizar en el repo:

| Archivo | Contenido mínimo |
|---------|------------------|
| `.cursor/project-memory.md` | Stack, comando de tests (`vendor/bin/pest`), gates verificados |
| `AGENTS.md` (~100 líneas) | Mapa: convenciones, comandos, enlaces a `docs/` |
| `docs/architecture/modules.md` | Límites del módulo, eventos vs acceso directo a modelos |

Plantilla L2: `skill-evolution/templates/project-memory.md`.

## Definition of Done (verificable)

```bash
# 1. Módulo existe y rutas cargan
php artisan module:list | grep -i <NombreModulo>
php artisan route:list --path=api/v1/<prefijo>

# 2. Migraciones del módulo
php artisan module:migrate <NombreModulo>

# 3. Tests del módulo (Pest preferido)
vendor/bin/pest Modules/<NombreModulo>/tests
# o: php artisan test --filter=Modules\\\\<NombreModulo>

# 4. Límites arquitectónicos (si hay deptrac.yaml)
./vendor/bin/deptrac analyse
```

Gate: todos los comandos anteriores aplicables deben exit 0 antes de "listo para merge".

## Sensores (feedback)

| Sensor | Tipo | Cuándo |
|--------|------|--------|
| Pest/PHPUnit | Computacional | Tras cada endpoint o servicio nuevo |
| `php artisan route:list` | Computacional | Tras registrar rutas |
| Deptrac | Computacional | Si el proyecto lo usa |
| `comprobacion-produccion` §0 | Inferencial | Al cerrar la tarea |
| Errores estructurados | FB-3 | Si falla test/lint → `error-feedback-format.md` |

## Flujo recomendado

1. **Spec:** criterios de aceptación en formato Given/When/Then (ver `testing-strategy` behaviour-harness).
2. **RED:** test Feature que falla (`vendor/bin/pest`).
3. **Scaffold:** `php artisan module:make <NombreModulo>` + controlador, request, migración.
4. **GREEN:** implementar hasta tests verdes.
5. **Checkpoint:** si >5 archivos o >300 líneas → pausa (`karpathy-guidelines` §5).
6. **Post-impl:** `comprobacion-produccion` §0.
7. **Fallo repetido:** entrada en `HARNESS-FAILURES.md`.

## Anti-patrones del módulo

- Acceso directo a `Modules\Otro\app\Models\*` → usar eventos o contratos (`laravel-modular` §6).
- Módulo por cada modelo Eloquent → un módulo = un dominio de negocio.
- Feature sin test Feature → no cerrar sin al menos happy path + validación 422.

## Escalación

- Mismo test falla 2 veces → parar (`karpathy-guidelines` §6).
- Dependencia circular entre módulos → escalar; extraer `Shared` o usar eventos.
