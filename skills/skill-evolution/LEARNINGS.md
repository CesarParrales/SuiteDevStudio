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

### 2026-07-10 · Captura errores repetidos (oleada 21+)
- **Tipo:** mejora
- **Hallazgo:** iteraciones múltiples sin registrar fallos; mismos errores en sesión
- **Acción:** regla global alwaysApply; disparadores 2+ error / 3+ iteraciones → HARNESS-FAILURES
- **Tipo:** mejora
- **Hallazgo:** LEARNINGS en global no volvían al canónico; install pisaba capturas de campo
- **Acción:** collect-learnings.sh, preserve en install-local, regla suite-learnings-capture.mdc
