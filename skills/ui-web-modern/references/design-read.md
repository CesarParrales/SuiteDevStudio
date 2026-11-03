# Lectura del brief

Aplica a landing, portafolio y rediseño de marketing. Un panel operativo usa `ui-admin-dashboard`, no estos dials.

Fuente: taste-skill v2, aún experimental ([Leonxlnx/taste-skill](https://github.com/leonxlnx/taste-skill), MIT). Revisión 2026-10-09. No se copian esqueletos de GSAP ni las skills de generación de imágenes.

## Antes de maquetar

Una línea, en voz alta: tipo de página, audiencia, lenguaje visual, y hacia qué base se inclina.

Si esa lectura puede ir por dos caminos distintos, una sola pregunta. Si el contexto ya lo decide, no se pregunta.

No partir de estos defaults de modelo: gradiente púrpura, hero centrado sobre una malla oscura, tres tarjetas iguales, vidrio en toda la página, Inter como única familia.

## Tres dials (1–10)

Declararlos en la respuesta antes del código.

| Dial | 1 | 10 |
|---|---|---|
| Varianza | Simetría estricta | Composición irregular |
| Motion | Casi estático | Scroll y física |
| Densidad | Mucho aire | Mucha información |

| Señal del brief | Varianza | Motion | Densidad |
|---|---|---|---|
| Calmo, editorial, tipo Linear | 5–6 | 3–4 | 2–3 |
| Consumo premium | 7–8 | 5–7 | 3–4 |
| Agencia, experimental | 9–10 | 8–10 | 3–4 |
| Sector público o muy regulado | 3–4 | 2–3 | 4–5 |
| Rediseño que conserva la marca | La de hoy | +1 | La de hoy |

## Sistema, no imitación

Si el brief nombra un sistema con paquete oficial (Fluent, Material, Carbon, Polaris, Primer, GOV.UK, USWDS), se usa ese paquete. Un sistema por proyecto. Una estética sin paquete oficial (editorial, brutalista, vidrio) se construye con CSS y se etiqueta como aproximación.

## Si pide historia visual

Cuando el brief pide recorrido en scroll, atmósfera de marca o un producto que se revela, pasar a `scroll-story.md`: style tile, tabla Escena | Historia visual | Copy, y mobile compuesto. Si no pide eso, no abrir un hero cinemático por defecto.
