# Fallos de vibe coding que no explotan el día del merge

Revisión extra cuando el código lo escribió un agente. La sintaxis puede estar bien y los tests del happy path pasar. Estos cuatro fallan semanas después.

Fuente: [Tres errores que la IA repite en Laravel](https://www.elrincondeisma.com/blog/tres-errores-ia-laravel), Isma, 18 ago 2026, más la regla de no migrar sin revisión. No se copia su equipo de agentes.

El detalle de Eloquent sigue en `eloquent.md`. El de jobs y `afterCommit` sigue en `queues-events.md`.

## Antes del merge

| Señal | Qué hacer |
|---|---|
| Un accessor lee una relación (`$this->user->name`) | La query que lista el modelo lleva `with`, o el modelo declara `$with`. Si no, el accessor no entra |
| `$request->validate()` dentro del controlador | Pasar a un `FormRequest`. Las reglas van en array, no en string con pipes: un regex o una coma rompe el pipe |
| Dos escrituras de negocio seguidas (crear pedido y descontar stock) | Van dentro de `DB::transaction()`. Si la segunda falla, la primera no se queda a medias |
| El agente añadió una migración | No se ejecuta en producción hasta que una persona mire el esquema real: columna obligatoria sin default, drop, índice en tabla grande. Una base vacía de test no basta |

`Model::preventLazyLoading()` en staging caza el primer caso cuando alguien recorre la lista. No sustituye el `with` en el código.

## Dónde mirar

No buscar errores de sintaxis. Buscar la consulta escondida, la regla duplicada (controlador, comando, job, otra versión de la API) y la escritura sin transacción.

Si el agente no tiene las convenciones del repo, estos tres primeros se repiten. El contexto del proyecto (modelos, Actions, FormRequests existentes) va antes del prompt.
