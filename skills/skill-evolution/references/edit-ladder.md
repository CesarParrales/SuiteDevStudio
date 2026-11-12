# Escalera de edición — editar skills sin engordarlas

Al consolidar un aprendizaje (Modo 1) o escribir una skill nueva, parar en el
**primer peldaño que resuelve el cambio**. El enemigo es el append reflejo: cada
lección convertida en párrafo nuevo hace la skill más cara de cargar y más fácil
de ignorar.

## Niveles — dónde vive cada hecho

Cada hecho en el nivel más bajo que llega al agente antes de necesitarlo:

| Nivel | Contiene | Se carga |
|-------|----------|----------|
| `description` (frontmatter) | un trigger por caso de uso | cada sesión |
| `SKILL.md` | lo que toda tarea de la skill necesita | cada uso |
| `references/` | lo que algunas tareas necesitan, tras una línea que dice cuándo leerlo | solo ese caso |
| `--help` / docs de la herramienta | flags, valores, ejemplos | cuando el agente elige el comando |
| Errores y tests de la herramienta | el nombre correcto, el fix, el siguiente paso | cuando una suposición falla |

## Los cinco peldaños

1. **Arréglalo debajo de la skill.** Un mensaje de error más claro, un flag, un
   check en el script o un test en la herramienta. La prosa es para juicios,
   no para lo que el código puede imponer.
2. **Que se gane su sitio.** Añadir una sección, paso o default solo con
   evidencia de que ayuda (entrada LEARNINGS con comando/error/versión, o un
   escenario RED que falló sin la línea). Si una sesión fresca lo hace bien sin
   la línea, no se añade nada.
3. **Edita, no anexes.** Cambiar la línea que ya cubre la idea; cada significado
   vive en un solo sitio. Dos párrafos sobre lo mismo = deuda.
4. **Elige su nivel** (tabla de arriba). El detalle de un caso va a `references/`,
   no al SKILL.md.
5. **Regla, no historia.** Una regla positiva bajo un nombre corto; el incidente
   que la motivó va al commit o al LEARNINGS, no al SKILL.md.

## Disciplina de tamaño

- Medir antes y después: `wc -l skills/<skill>/SKILL.md`. Anotar
  `antes→después` en el mensaje de commit cuando el cambio sea sustancial.
- Límite duro de la suite: 500 líneas por SKILL.md (gate del Modo 2).
- Si una skill creció >10 % desde su última dieta, la siguiente edición es una
  **dieta** (mover detalle a references, fusionar duplicados), no un añadido.
- Mantener 2-3 líneas de seguridad inline por área de riesgo (escrituras,
  datos que salen de la máquina, gasto): esas no se mueven a references.
- Si el código cambia un nombre o flag que una skill enseña, actualizar la
  skill en el mismo cambio.

---

Destilado de `/write-skill` de [gstack](https://github.com/garrytan/gstack)
(MIT, Garry Tan), adaptado a los gates y límites de Suite Dev Studio.

`last_updated: 2026-11-12` · `revisar_cada: 90 días`
