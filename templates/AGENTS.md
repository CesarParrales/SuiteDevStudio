# AGENTS.md — Mapa para agentes de código

Documento **corto** (~100 líneas): convenciones operativas. El detalle vive en `context.md`, `docs/` y `.cursor/project-memory.md`.

`last_updated: YYYY-MM-DD`

## Fuentes de verdad (orden)

1. PRD / alcance del producto
2. `docs/code-map.md` o `context.md` (mapa FF-2)
3. `.cursor/project-memory.md` (gates, decisiones recientes)
4. Este archivo (convenciones y comandos)
5. `docs/architecture/README.md` — ADRs y límites (`--init-architecture`)

Ante conflicto: PRD > ADR > código existente hasta que se documente el cambio.

## Stack (rellenar)

| Capa | Tecnología | Notas |
|------|------------|-------|
| Backend | … | … |
| Frontend | … | … |
| BD | … | … |
| Tests | … | … |

## Comandos obligatorios antes de cerrar tareas

```bash
# Adaptar — deben coincidir con project-memory.md
# php artisan test   / vendor/bin/pest
# npm run build && npm test
# flutter analyze && flutter test
```

No declarar "listo" sin ejecutar los gates aplicables al diff.

## Estructura del repo (mapa)

```
# Ejemplo — sustituir por el árbol real
src/          # o app/, lib/
tests/        # o test/, Modules/*/tests
docs/         # ADRs, arquitectura
```

Enlaces:

- Mapa FF-2: `docs/code-map.md`
- Arquitectura: `docs/architecture/README.md`
- API: `docs/api/` o OpenAPI en …

## Convenciones de código

- **Idioma:** comentarios y commits en … (es/en)
- **Estilo:** seguir linter del proyecto; no reformatear archivos no tocados
- **Tests:** test-first en lógica de negocio; ver `testing-strategy` en la suite
- **Seguridad:** sin secretos en repo; validar inputs en boundaries

## Harness del estudio (suite Dev Studio)

| Necesidad | Skill / artefacto |
|-----------|-------------------|
| Feature grande | `harness-template` + topología del stack |
| Cierre de tarea | `comprobacion-produccion` |
| Cambios quirúrgicos | `karpathy-guidelines` |
| Código mínimo / menos deps | `vibe-coding-token-optimization` (escalera en `decision-ladder.md`) |
| Fallos de CI reformateados | FB-3 → `comprobacion-produccion/scripts/validate-fb3.sh` |

Topologías: `laravel-api-module`, `nextjs-saas-page`, `flutter-feature`, `node-api-nest`, `laravel-filament-resource`, `react-native-screen`, `inertia-spa-page`.

Madurez harness: `bash scripts/harness-test.sh` (o `bash .cursor/skills/harness-template/scripts/harness-readiness.sh --suite .cursor/skills --project . --ci`)

## Lo que NO hacer

- No añadir dependencias sin justificar en el PR/commit
- No saltar tests "por urgencia"
- No mezclar refactor amplio con fix puntual
- No inventar rutas, env vars o nombres de módulos — leer el repo primero
- No instalar librerías si stdlib/plataforma nativa basta (`vibe-coding-token-optimization`)

## Regla Cursor opcional (código mínimo)

Tras `install-local.sh --project . --init-minimal-rule` → `.cursor/rules/minimal-code.mdc` (activar manualmente en Cursor; no `alwaysApply` por defecto).

## Escalación humana

Parar y preguntar si: auth/pagos/migraciones destructivas sin spec; mismo test falla 2 veces; requisito ambiguo tras 1 aclaración.

---

*Generado desde suite-dev-studio `templates/AGENTS.md`. Personalizar y acortar si crece >120 líneas.*
