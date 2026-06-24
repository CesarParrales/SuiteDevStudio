# Mapa de código — {{NOMBRE_PROYECTO}} (FF-2)

Dónde leer **antes de editar**. Sustituir placeholders y mantener &lt;80 líneas.

`last_updated: YYYY-MM-DD`

## Fuentes de verdad (orden)

| Prioridad | Archivo | Cuándo |
|-----------|---------|--------|
| 1 | PRD / alcance | Features, scope |
| 2 | `context.md` o este archivo | Stack, módulos, rutas clave |
| 3 | `AGENTS.md` | Convenciones operativas |
| 4 | `.cursor/project-memory.md` | Gates, log sesión, decisiones |
| 5 | `docs/architecture/` | ADRs, límites de módulos |

## Stack (snapshot)

| Capa | Tecnología | Ruta principal |
|------|------------|----------------|
| Backend | … | `app/` o `src/` |
| Frontend | … | `resources/js/` o `app/` |
| Tests | … | `tests/` |
| API | … | `routes/` o `src/modules/` |

## Árbol operativo (personalizar)

```
# Ejemplo Laravel — borrar comentario al personalizar
app/Http/Controllers/   # HTTP layer
app/Models/             # Eloquent
app/Services/           # lógica de negocio
tests/Feature/          # integración HTTP
tests/Unit/             # lógica aislada
```

## Por tipo de tarea → dónde leer primero

| Tarea | Leer antes de editar |
|-------|----------------------|
| Bug en endpoint | Controller + FormRequest + Feature test existente |
| Pantalla UI | Page/componente + test e2e o feature relacionado |
| Migración / modelo | Model + migration + policies + tests |
| Nuevo módulo | ADR o `harness-template` topología del stack |

## Harness (suite Dev Studio)

| Artefacto | Ruta |
|-----------|------|
| Skills | `.cursor/skills/` |
| Gate local | `bash scripts/harness-test.sh` |
| Topología | `.cursor/skills/harness-template/references/task-routing.md` |

## Mantenimiento

- Personalizar tras `--init-code-map` (sin `{{…}}` ni `YYYY-MM-DD`). Validar: `validate-code-map.sh`.
- Actualizar tras cambios de arquitectura o carpetas nuevas relevantes.
- No duplicar ADRs largos: enlazar `docs/architecture/`.
- El agente debe leer **solo** el área del diff + esta tabla, no todo el repo.
