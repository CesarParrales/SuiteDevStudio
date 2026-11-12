## Pendientes

_(ninguno)_

## Consolidadas

### 2026-06-24 · TS-RED-01/02 GREEN verificados (oleada 18)
- **Tipo:** disciplina
- **Hallazgo:** RED A con presión PM/lead; GREEN B con criterio MVP + pirámide
- **Acción:** contra-reglas MVP y CI en SKILL.md

### 2026-11-12 · TS-RED-03 RED falló con C, REFACTOR, GREEN B (test audit, upstream gstack)
- **Tipo:** disciplina
- **Hallazgo:** RED (ciego, orden pública del CTO + plazo) eligió C — mover tests de pagos/migraciones a nightly: "la suite baja a 5 minutos hoy y 'técnicamente' no se borra nada". Loophole: sacar del gate de merge sin evidencia.
- **Acción:** contra-regla "nightly no es borrar" en `references/test-audit.md` (sacar un test del gate sin tarjeta = retirarlo; velocidad primero con paralelización/sharding). GREEN B citándola textualmente.
