---
name: karpathy-guidelines
description: Behavioral guidelines to reduce common LLM coding mistakes. Use when writing, reviewing, or refactoring code to avoid overcomplication, make surgical changes, surface assumptions, define verifiable success criteria, checkpoints on long tasks, or escalation after repeated failures.
license: MIT
---

# Karpathy Guidelines

Behavioral guidelines to reduce common LLM coding mistakes, derived from [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876) on LLM coding pitfalls.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

**Contra-regla:** comentarios de reviewer o presión del PM ("un solo PR") **no sustituyen** cambio quirúrgico en bugfixes puntuales; reformateo masivo va en PR dedicado salvo petición explícita de refactor.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 5. Checkpoints (long tasks)

Pause and verify before continuing when any threshold is reached:

| Señal | Acción de checkpoint |
|-------|----------------------|
| **>5 archivos** tocados en una tarea | Listar archivos, confirmar que cada uno se justifica por el pedido; ejecutar lints/tests del área afectada |
| **>~300 líneas** netas de cambio | Dividir en paso verificable; no seguir sin gate (tests o revisión explícita) |
| **Paso del plan completado** | Ejecutar el `verify:` declarado antes del siguiente paso |
| **Nueva dependencia** añadida | Confirmar necesidad; revisar licencia y superficie de ataque |

At each checkpoint: state what passed, what failed, and the next single step. Do not batch unverified work.

## 6. Escalation

Stop autonomous retries and ask the human when:

| Condición | Acción |
|-----------|--------|
| **Mismo test/linter falla 2 veces** tras correcciones | Parar; reportar con formato estructurado (`comprobacion-produccion` → error-feedback-format); pedir decisión |
| **3 interpretaciones válidas** del requisito | Presentar opciones A/B/C; no elegir en silencio |
| **Requisito sigue ambiguo** tras 1 ronda de preguntas | Escalar; no implementar suposiciones críticas |
| **Cambio toca auth, pagos o migración destructiva** sin spec explícita | Escalar antes de editar |
| **Bucle de herramientas** (mismo comando falla 3+ veces sin progreso) | Parar; registrar en `HARNESS-FAILURES.md` si el harness debió prevenirlo |

Escalation output: what was tried, what failed, what decision is needed (one question max).

**Contra-regla:** "intenta otra vez" o urgencia de deploy **no sustituyen** escalación tras 2 fallos idénticos; `@skip` solo con acuerdo explícito del humano (sugerencia de compañero no cuenta).
