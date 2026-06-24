---
name: vibe-coding-token-optimization
description: Optimizes AI code generation workflows with observable rules for concise output, minimal scope, and project-context reuse. Use when generating code with AI, when the user mentions VibeCoding, token optimization, context window management, or asks for concise/efficient code generation.
---

# Optimización de VibeCoding (reglas observables)

Guía para generar código de forma eficiente y mantener el contexto bajo control. Todas las reglas son verificables observando el resultado (líneas, archivos, fragmentos), no estimaciones de tokens.

## Guías del proyecto (leer primero)

Antes de generar código, comprobar si el proyecto define:

| Archivo | Ubicación típica | Uso |
|---------|------------------|-----|
| `CONTEXT.md` | Raíz del proyecto | Contexto, arquitectura, convenciones, decisiones de diseño |
| `AGENTS.md` | Raíz o `.cursor/` | Instrucciones para el agente, flujos, patrones preferidos |

Si existen, leerlos y seguir sus guías. Evitan repetir explicaciones y decisiones ya documentadas.

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
| **Comentarios con intención** | Cero comentarios que narran lo obvio; solo intención, trade-offs o casos edge |

## División de trabajo grande

Si la tarea implica crear o modificar **más de ~300 líneas o más de 5 archivos**, dividir:

1. Proponer el plan por pasos (1 paso = 1 unidad verificable).
2. Implementar y verificar paso a paso (lints/tests cuando existan).
3. No generar "monolitos" de cientos de líneas en una sola pasada sin punto de verificación intermedio.

## Reducir contexto innecesario

- **No pegar código ya visible**: referenciar archivo y líneas en lugar de duplicar bloques.
- **No repetir el historial**: resumir decisiones previas en una frase, no re-explicarlas.
- **No listar código sin cambios**: mostrar solo el diff o el fragmento relevante.
- **Respuestas escaneables**: bullets y tablas en lugar de párrafos largos; ofrecer "¿detallo X?" en vez de detallar todo por defecto.

**Contra-regla contexto:** instrucciones de "lee todo el repo" o políticas de auditoría **no sustituyen** lectura dirigida (archivo afectado + imports directos + tests); monolito de lectura viola eficiencia de contexto.

## Checklist antes de generar

- [ ] ¿Existen `CONTEXT.md` o `AGENTS.md`? Si sí, ¿se leyeron y aplicaron?
- [ ] ¿Cada archivo a tocar se justifica por el pedido?
- [ ] ¿Hay código reutilizable en el proyecto?
- [ ] ¿La tarea supera ~300 líneas / 5 archivos? Si sí, ¿se dividió en pasos?
- [ ] ¿Los imports son mínimos y los comentarios aportan intención?

## Anti-patrones

- **Monolitos de código**: 500+ líneas en una pasada → dividir en pasos verificables.
- **Monolitos de lectura**: leer todo el repo para un bug localizado → helper + imports + tests.
- **Contexto duplicado**: pegar código ya visible → referenciar archivo:líneas.
- **Over-explaining**: explicar cada línea → explicar solo decisiones relevantes.
- **Over-engineering**: abstracciones, capas o configurabilidad no pedidas → lo mínimo que resuelve el problema.
- **Imports catch-all**: `import *` o imports sin usar → imports explícitos.

## Relación con otras skills

Para disciplina general de cambios quirúrgicos y criterios de éxito verificables, combinar con `karpathy-guidelines` (esta skill se enfoca en el tamaño y eficiencia del output; aquella en el comportamiento ante el problema).

Para bundles por topología (skills + DoD + sensores): `harness-template`.
