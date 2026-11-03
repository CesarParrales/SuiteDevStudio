# Learnings — laravel-backend

Registro de lecciones de uso. `skill-evolution` consolida las pendientes en el SKILL.md y las mueve a Consolidadas.

## Pendientes

<!-- Formato de entrada:
### YYYY-MM-DD · contexto breve
- Tipo: gap | corrección | mejora
- Hallazgo: ...
- Cambio propuesto: ...
-->

## Consolidadas

### 2026-10-21 · Fallos tardíos del código generado
- **Tipo:** mejora
- **Hallazgo:** N+1 en accessors, validación en el controlador y escrituras sin transacción pasan el merge y fallan después
- **Acción:** → aplicado 2026-10-21 en `references/vibe-fallos.md`
