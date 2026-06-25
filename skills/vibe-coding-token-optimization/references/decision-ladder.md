# Escalera de decisión — código mínimo verificable

Aplicar **después** de leer el código y el flujo que toca el cambio (`karpathy-guidelines` §1). La escalera acorta la **solución**, no la **comprensión**.

## Peldaños (parar en el primero que aplique)

| # | Pregunta | Acción |
|---|----------|--------|
| 1 | ¿Hace falta construirlo? | YAGNI — omitir; decirlo en una línea |
| 2 | ¿Ya existe en el repo? | Reutilizar helper, util, patrón o componente **en el repositorio actual** |
| 3 | ¿La stdlib del lenguaje lo resuelve? | Usar stdlib |
| 4 | ¿La plataforma nativa lo cubre? | HTML/CSS/API del runtime antes que librería |
| 5 | ¿Una dependencia **ya instalada en este proyecto** (`package.json` / `composer.json`)? | Usarla; no añadir paquete nuevo |
| 6 | ¿Basta una línea o función mínima? | Implementar eso |
| 7 | Solo entonces | Mínimo código con tests según `testing-strategy` |

## Ejemplos (anti sobre-ingeniería)

| Pedido | Evitar | Preferir |
|--------|--------|----------|
| Date picker | `flatpickr` + wrapper + CSS | `<input type="date">` si el producto lo permite |
| Validar email | Clase `EmailValidator` 80 líneas | Regex/stdlib del lenguaje o validación del framework |
| Cache API | Clase `ResponseCache` custom | `@lru_cache` / cache del framework si basta |
| Bug en helper | Parche solo en un caller | Grep callers; arreglar función compartida una vez |

## Lo que **no** está en la mesa de recortes

Alineado con harness y disciplina de la suite:

- Validación en **trust boundaries** (`security-checklist`)
- Manejo de errores que **evita pérdida de datos**
- **Tests** exigidos por tipo de proyecto (`testing-strategy` — MVP: unit en core; no “cero tests”)
- **Definition of Done** de `harness-template` al cerrar scaffolding
- **Accesibilidad** básica cuando hay UI (`ui-audit`, `ui-mobile-native`)
- Lo **pedido explícitamente** por el usuario o el PRD

**Contra-regla:** la escalera **no** sustituye `comprobacion-produccion` §0 ni gates de merge.

**Contra-regla social:** "copien del repo pasado" o convención de otro proyecto **no cuenta** como peldaño 2 ni 5 — leer manifests **del repo actual** antes de instalar.

## Deuda documentada (opcional)

Si eliges un atajo con techo conocido:

```text
// minimal: lock global; por-cuenta si throughput > X
```

Registrar en `LEARNINGS.md` de la skill si el atajo afecta mantenimiento.

## Modos de intensidad (opt-in)

| Modo | Comportamiento |
|------|----------------|
| **lite** | Implementar lo pedido; nombrar alternativa más simple en una línea |
| **full** (default skill) | Escalera aplicada; salida concisa |
| **off** | Solo reglas de contexto/token; sin presión extra de minimalismo |

En Cursor: regla opcional `templates/cursor/minimal-code.mdc` (`alwaysApply: false`).

## Revisión de diff

Antes de cerrar un PR grande, usar checklist en [diff-review.md](diff-review.md).
