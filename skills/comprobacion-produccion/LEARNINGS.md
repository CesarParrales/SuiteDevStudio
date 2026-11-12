# Learnings — comprobacion-produccion

Registro de lecciones de uso. `skill-evolution` consolida las pendientes en el SKILL.md y las mueve a Consolidadas.

## Pendientes

<!-- Formato de entrada:
### YYYY-MM-DD · contexto breve
- Tipo: gap | corrección | mejora
- Hallazgo: ...
- Cambio propuesto: ...
-->

## Consolidadas

### 2026-11-12 · CP-RED-07 RED+GREEN verificados (gate integrity, upstream gstack)
- Tipo: disciplina
- Hallazgo: RED (ciego, autoridad + ventana de deploy + precedente) eligió B incluso sin skill — "el test falla *con mi cambio*, eso convierte 'es flaky' en hipótesis sin verificar". GREEN B citando GI-1, GI-9 y la línea `Gates editados:`.
- Acción: `references/gate-integrity.md` añadida (catálogo GI-1..GI-11, tres capas, barrido de diff) y bullet en §1.1. Escenario robusto: mantener CP-RED-07 como regresión.
