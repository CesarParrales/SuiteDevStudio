# Evaluación vibe coding 2026 → integración Suite Dev

**Fecha:** 2026-10-06 · **Decisión:** tres ajustes. No se sustituye el harness.

## Qué ya cubría la suite

Mapa corto `AGENTS.md`, skills bajo demanda, spec de feature grande y bug crítico, escalera de código mínimo, cierre con tests.

## Qué se integró

| Práctica 2026 | Dónde |
|---------------|--------|
| Spec conservador: el código manda y el spec se actualiza en el mismo cambio | `harness-template/references/work-spec.md` § Spec vivo |
| Explorar sin spec solo si el prototipo se descarta; antes de producción, fijar el spec | `vibe-coding-token-optimization` § Explorar y después fijar |
| Quien verifica no edita | `work-spec.md` § Verificación + `templates/cursor/agents/verifier.md` |

Instalar el subagente en un proyecto: `./install-local.sh --project <ruta> --init-verifier`.

## Qué no se integró

`AGENTS.md` anidado por paquete (monorepos grandes), sustituir MCP por CLI, y un hook que lance toda la suite de tests en cada parada.
