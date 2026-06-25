# Revisión anti sobre-ingeniería (diff)

Checklist rápida sobre el **diff actual** (no audit de repo completo). Inspirado en prácticas de revisión “lazy senior”; integrado con gates de la suite.

## Cuándo usar

- PR > ~150 líneas netas o >3 archivos nuevos
- El usuario pide “revisar si hay bloat”
- Antes de merge tras feature grande (`harness-template` DoD)

## Checklist

| # | Pregunta | Si sí → acción |
|---|----------|----------------|
| 1 | ¿Nueva dependencia para algo que stdlib/plataforma ya hace? | Eliminar dep; usar nativo |
| 2 | ¿Archivo nuevo duplica util existente? | Consolidar o importar |
| 3 | ¿Abstracción con una sola implementación no pedida? | Inline hasta que haya 2º uso real |
| 4 | ¿Wrapper solo para “consistencia”? | Llamar API directa si el repo no exige capa |
| 5 | ¿Tests añadidos según `testing-strategy`? | Si no → añadir unit mínimo en lógica core |
| 6 | ¿Se saltó validación/seguridad por “simplicidad”? | Restaurar boundary checks |
| 7 | ¿Comentarios `minimal:` con techo sin ticket/LEARNING? | Documentar o resolver |

## Salida al usuario

```markdown
## Revisión minimal (diff)

**Eliminar o simplificar:**
- [archivo:líneas] — motivo

**Mantener (justificado):**
- …

**Tests / gates pendientes:**
- …
```

Máximo 15 ítems. Código primero; prosa breve.
