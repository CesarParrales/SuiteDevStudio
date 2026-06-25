---
name: vibe-coding-token-optimization
description: >
  Optimizes AI code generation with observable rules for concise output, minimal scope,
  and the decision ladder (YAGNI, reuse, stdlib, native platform before new deps).
  Use when generating code, minimizing tokens/context, VibeCoding, over-engineering
  review, or when the user asks for the simplest solution that still passes harness tests.
---

# Optimización de VibeCoding (reglas observables)

Guía para generar código de forma eficiente y mantener el contexto bajo control. Todas las reglas son verificables observando el resultado (líneas, archivos, fragmentos), no estimaciones de tokens.

**Escalera de decisión (código mínimo):** [references/decision-ladder.md](references/decision-ladder.md)  
**Revisión anti-bloat en diff:** [references/diff-review.md](references/diff-review.md)

## Guías del proyecto (leer primero)

Antes de generar código, comprobar si el proyecto define:

| Archivo | Ubicación típica | Uso |
|---------|------------------|-----|
| `CONTEXT.md` | Raíz del proyecto | Contexto, arquitectura, convenciones, decisiones de diseño |
| `AGENTS.md` | Raíz o `.cursor/` | Instrucciones para el agente, flujos, patrones preferidos |
| `.cursor/rules/minimal-code.mdc` | Proyecto | Regla Cursor opt-in (escalera resumida) |

Si existen, leerlos y seguir sus guías. Evitan repetir explicaciones y decisiones ya documentadas.

## Escalera de decisión (resumen)

**Después** de leer el código afectado, parar en el primer peldaño válido:

1. YAGNI → 2. Reutilizar repo → 3. Stdlib → 4. Nativo plataforma → 5. Dep instalada → 6. Una línea → 7. Mínimo + tests (`testing-strategy`)

**No recortar:** boundaries, seguridad, accesibilidad, tests/DoD del harness, lo pedido explícitamente. Detalle en `decision-ladder.md`.

**Contra-regla social:** "copien del repo pasado" no cuenta como reuse ni dep instalada — solo manifests del **repo actual**.

**Bugfix:** grep callers; arreglar función compartida (causa raíz), no solo el path del ticket.

## Reglas observables al generar código

Cada regla tiene una verificación concreta:

| Regla | Verificación |
|-------|--------------|
| **Alcance mínimo** | Cada archivo tocado se justifica por el pedido del usuario; cero archivos "de paso" |
| **Reutilizar antes de crear** | Buscar en el proyecto código similar antes de escribir nuevo; si existe, importar |
| **Fragmentos sobre archivos completos** | Al mostrar cambios, citar solo las líneas modificadas, no el archivo entero |
| **Cambios incrementales** | Preferir editar sobre reescribir; una reescritura completa requiere justificación explícita |
| **Sin secciones vacías** | Cero placeholders, TODOs especulativos o estructuras "por si acaso" |
| **Checkpoints en tareas largas** | Si >5 archivos o >~300 líneas → pausar y verificar (`karpathy-guidelines` §5) |
| **Escalación** | Mismo fallo 2 veces → parar y pedir decisión (`karpathy-guidelines` §6) |
| **Imports mínimos** | Solo imports usados; nada de `import *` ni imports en bloque |
| **Comentarios con intención** | Cero comentarios que narran lo obvio; `minimal:` solo para atajos con techo conocido |

## División de trabajo grande

Si la tarea implica crear o modificar **más de ~300 líneas o más de 5 archivos**, dividir:

1. Proponer el plan por pasos (1 paso = 1 unidad verificable).
2. Implementar y verificar paso a paso (lints/tests cuando existan).
3. No generar "monolitos" de cientos de líneas en una sola pasada sin punto de verificación intermedio.

## Reducir contexto innecesario

- **No pegar código ya visible**: referenciar archivo y líneas en lugar de duplicar bloques.
- **No repetir el historial**: resumir decisiones previas en una frase, no re-explicarlas.
- **No listar código sin cambios**: mostrar solo el diff o el fragmento relevante.
- **Respuestas escaneables**: bullets y tablas; ofrecer "¿detallo X?" en vez de detallar todo por defecto.
- **Código primero**: tras implementar, ≤3 líneas (qué se omitió, cuándo añadirlo). Explicación larga solo si el usuario la pidió.

**Contra-regla contexto:** "lee todo el repo" o auditoría **no sustituyen** lectura dirigida (archivo + imports + tests).

## Checklist antes de generar

- [ ] ¿Existen `CONTEXT.md` o `AGENTS.md`? Si sí, ¿se leyeron y aplicaron?
- [ ] ¿Se aplicó la escalera de decisión (`decision-ladder.md`)?
- [ ] ¿Cada archivo a tocar se justifica por el pedido?
- [ ] ¿Hay código reutilizable en el proyecto?
- [ ] ¿La tarea supera ~300 líneas / 5 archivos? Si sí, ¿se dividió en pasos?
- [ ] ¿Tests alineados con `testing-strategy` (no cero tests en lógica core)?

## Anti-patrones

- **Monolitos de código**: 500+ líneas en una pasada → dividir en pasos verificables.
- **Monolitos de lectura**: leer todo el repo para un bug localizado → helper + imports + tests.
- **Librería nueva para lo nativo**: date picker lib cuando basta `<input type="date">` → escalera peldaño 4.
- **Contexto duplicado**: pegar código ya visible → referenciar archivo:líneas.
- **Over-explaining**: explicar cada línea → solo decisiones relevantes.
- **Over-engineering**: abstracciones no pedidas → escalera + `diff-review.md`.
- **Imports catch-all**: `import *` o imports sin usar → imports explícitos.

## Relación con otras skills

| Skill | Rol |
|-------|-----|
| `karpathy-guidelines` | Quirúrgico, checkpoints, escalación |
| `testing-strategy` | Tests no negociables en lógica core |
| `harness-template` | DoD y plantillas por topología |
| `comprobacion-produccion` | Gates pre/post merge |

Origen de la escalera: evaluación [docs/evaluation-ponytail.md](../../../docs/evaluation-ponytail.md) (ideas adaptadas, no plugin externo).
