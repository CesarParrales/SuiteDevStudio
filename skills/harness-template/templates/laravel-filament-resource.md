# Laravel Filament Resource — Harness Template

Bundle feedforward + feedback para un **Filament Resource** (CRUD admin) en Laravel con panel Filament v3+.

## Cuándo usar

- Nuevo recurso admin para un modelo Eloquent
- CRUD con formulario, tabla, filtros y policies
- El usuario pide "Filament resource", "admin de X", "panel para modelo Y"

## Skills a activar (en orden)

| Orden | Skill | Rol |
|-------|-------|-----|
| 1 | `harness-template` | Este bundle |
| 2 | `laravel-backend` | Eloquent, policies, Pest (`references/filament.md`) |
| 3 | `ui-admin-dashboard` | Tablas, formularios complejos, KPIs |
| 4 | `karpathy-guidelines` | Checkpoints, escalación |
| 5 | `testing-strategy` | Feature tests + behaviour harness |
| 6 | `comprobacion-produccion` | Post-implementación |

Opcional: `security-checklist` (policies, mass assignment), `web-interface-guidelines` (accesibilidad en forms).

## Archivos feedforward

| Archivo | Contenido |
|---------|-----------|
| `.cursor/project-memory.md` | `php artisan test`, panel Filament path |
| `AGENTS.md` | Convenciones admin del proyecto |
| Modelo + migración | Antes o junto al Resource |

## Definition of Done

```bash
php artisan make:filament-resource <Model> --generate   # o manual según convención del repo
php artisan migrate
vendor/bin/pest --filter=<Model>   # o php artisan test
php artisan route:list --path=admin   # resource registrado
./vendor/bin/pint --test              # si el proyecto usa Pint
```

Gate manual: crear/editar/eliminar desde el panel en staging o `php artisan serve` con usuario admin; policy deniega acciones no autorizadas.

## Flujo recomendado

1. **AC** — permisos por rol, campos del form, columnas de tabla
2. **Model + migration** si no existe
3. **Policy** — `viewAny`, `create`, `update`, `delete`
4. **RED:** Feature test de API o Livewire/Filament test si el proyecto los usa
5. **Resource** — Form schema, Table columns, filters (`laravel-backend` → `references/filament.md`)
6. **GREEN** + Pest
7. **Post-impl:** `comprobacion-produccion` §0

## Anti-patrones

- Lógica de negocio pesada en el Resource (usar Action/Service)
- `$guarded = []` en el modelo
- Resource sin policy en datos sensibles
- N+1 en tabla sin `->with()` o eager load por defecto

## Escalación

- Campos PII sin criterio de visibilidad → escalar
- Mismo test/policy falla 2 veces → FB-3 + escalación
