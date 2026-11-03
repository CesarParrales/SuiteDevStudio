# Learnings — skill-evolution

Registro de lecciones de uso. `skill-evolution` consolida las pendientes en el SKILL.md y las mueve a Consolidadas.

## Pendientes

<!-- Formato de entrada:
### YYYY-MM-DD · contexto breve
- Tipo: gap | corrección | mejora
- Hallazgo: ...
- Cambio propuesto: ...
-->

## Consolidadas

### 2026-11-03 · Guía Elkis Dev arquitectura
- **Tipo:** mejora
- **Hallazgo:** PDF práctico aportaba config-placement y resiliencia de llamadas; el stack fijo no
- **Acción:** → aplicado en web-architecture refs + plano F3; fila en `references/upstream-watch.md`

### 2026-10-17 · Historia visual desde 10K websites
- **Tipo:** mejora
- **Hallazgo:** el repo de prompts cinemáticos aportaba storyboard y mobile compuesto que no estaban en la suite; el pipeline Higgsfield no aportaba
- **Acción:** → aplicado 2026-10-17 en `ui-web-modern/references/scroll-story.md` y fila en `references/upstream-watch.md`

### 2026-10-09 · Vigilancia de oficio visual
- **Tipo:** mejora
- **Hallazgo:** Emil Kowalski, taste-skill v2 e Impeccable aportan reglas que la suite no tenía, y las fuentes ya citadas no tenían fecha de revisión
- **Acción:** → aplicado 2026-10-09 en `references/upstream-watch.md`, `ui-web-modern/references/motion-craft.md`, `ui-web-modern/references/design-read.md`, `ui-audit/references/ai-slop.md`

### 2026-07-10 · Captura errores repetidos (oleada 21+)
- **Tipo:** mejora
- **Hallazgo:** iteraciones múltiples sin registrar fallos; mismos errores en sesión
- **Acción:** regla global alwaysApply; disparadores 2+ error / 3+ iteraciones → HARNESS-FAILURES
- **Tipo:** mejora
- **Hallazgo:** LEARNINGS en global no volvían al canónico; install pisaba capturas de campo
- **Acción:** collect-learnings.sh, preserve en install-local, regla suite-learnings-capture.mdc
