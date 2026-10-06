# Spec de trabajo (feature grande y bug crítico)

Protocolo adaptado de la mecánica de specs de [Kiro](https://kiro.dev/docs/specs/) (revisión 2026-10). No se instala Kiro ni se crea `.kiro/`. El flujo corto de la suite no cambia.

## Cuándo aplica

| Señal | Spec |
|-------|------|
| Scaffold o feature grande (>5 archivos, módulo nuevo) | Feature: requisitos → diseño → tareas |
| Bug en ruta crítica (auth, dinero, estados), regresión de un fix previo, o causa no obvia | Bug: actual / esperado / intacto |
| Un endpoint, un componente, typo, docs, fix localizado | Ninguno. Implementación acotada |

La fila de bug crítico gana sobre «implementación acotada» si coinciden las señales.

## Feature grande

Parar entre fases. No escribir código de producto en la fase 1 ni 2.

1. **Requisitos.** Historias con criterios Given/When/Then (plantilla en `testing-strategy/references/behaviour-harness.md`). Antes de diseñar, listar contradicciones, ambigüedades y huecos. Si un hueco bloquea el comportamiento, preguntar. No inventar el criterio.
2. **Diseño.** Una página: componentes, flujo de datos, errores y qué se testea. Sin tareas de implementación disfrazadas de diseño.
3. **Tareas.** Cada tarea tiene un resultado verificable y sus dependencias. Implementar en orden de dependencia. Dos tareas en paralelo solo si no comparten archivos.

Si el alcance cabe en implementación acotada, no abrir este spec.

## Bug crítico

Escribir esto antes del parche:

```markdown
### Actual
WHEN <condición> THEN el sistema <comportamiento incorrecto>

### Esperado
WHEN <condición> THEN el sistema SHALL <comportamiento correcto>

### Intacto
WHEN <condición> THEN el sistema SHALL CONTINUE TO <comportamiento que no debe cambiar>
```

El test que reproduce el defecto va antes del fix. «Intacto» necesita al menos un test que siga pasando.

Si el arreglo exige una capacidad nueva, el bug se queda en este spec y la capacidad va a un spec de feature. No mezclarlos.

## Spec vivo

El código del repo manda. El spec no regenera la implementación.

Si el comportamiento acordado cambia, el spec se actualiza en el mismo cambio que el código. Un spec viejo no se deja para otro PR.

Explorar (prototipo que se va a descartar) puede ir sin spec. Antes de que ese código entre a una rama de producto, lo descubierto pasa a este spec. El chat no cuenta como memoria.

## Verificación que no edita

Antes de declarar lista una feature grande o un bug crítico, una pasada distinta de la implementación:

1. Releer el pedido y el spec. El diff no sustituye el requisito.
2. Ejecutar los tests y el build que apliquen a ese diff.
3. Decir qué pasó y qué falta (criterio sin test, spec desactualizado, comando en rojo).
4. No corregir en esa pasada. Quien implementó aplica el informe después.

Plantilla de subagente Cursor (solo lectura): `templates/cursor/agents/verifier.md`. En un proyecto: `install-local.sh --project <ruta> --init-verifier`. Si el archivo no está instalado, la pasada se hace igual con estos cuatro pasos.

## Tests de propiedades (opt-in)

Solo cuando el criterio es una regla que debe cumplirse para muchos inputs (importes, permisos, transiciones de estado) y unos pocos ejemplos no cubren el espacio.

- Usar la librería que el proyecto ya tenga (`fast-check`, Hypothesis, plugin de Pest, etc.).
- Si no hay librería, no añadir una dependencia por este protocolo: dejar la propiedad escrita y cubrir los bordes con ejemplos del behaviour harness.
- El default sigue siendo el test de ejemplo (AC → RED → GREEN).

## Qué no copiar

IDE, CLI, créditos, carpeta `.kiro/`, ejecutor automático de oleadas y tests de propiedades en cada feature. El steering persistente ya está en `AGENTS.md`, `project-memory` y las skills.
