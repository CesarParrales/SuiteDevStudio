# Historia visual y mobile compuesto

Para landings y sitios de marca con una historia en scroll. No aplica a paneles, tablas ni flujos de producto densos. La lectura del brief y los dials siguen en `design-read.md`. Las duraciones y el “cuándo no animar” siguen en `motion.md` y `motion-craft.md`.

Fuente de ideas: [Barty-Bart/gpt-6-astra-10k-websites](https://github.com/Barty-Bart/gpt-6-astra-10k-websites) (revisión 2026-10-17). Sin licencia clara en el repo: no se copian los prompts. No se adopta Higgsfield, ni secuencias de frames, ni un scrub cinemático como default.

## Cuándo usar esto

Solo si el brief pide una historia visual (producto que se revela, recorrido del oficio, marca con atmósfera) o si el dial de motion en `design-read.md` queda alto y el usuario no lo rechazó. Si no, un layout estático con motion ligero basta.

## Style tile antes del sitio

Una muestra editable (HTML/CSS o la página de tokens del proyecto) con:

- Logo o marca acordada (no redibujar un logo del cliente).
- Paleta, tipografía de título y de cuerpo, botón, enlace.
- Un card o bloque de servicio.
- Dirección de imagen (foto real, ilustración, tono).

No es un brandbook. Debe usar los mismos tokens que luego tendrá el sitio.

## Tabla Visual Story

Antes de generar assets pesados o de pinnear un hero, presentar esta tabla:

| Escena | Historia visual | Copy del sitio |
|---|---|---|
| 01 — Apertura | Sujeto y acción inicial; hueco para el copy | Titular, apoyo, acción primaria |
| 02 — Desarrollo | Continúa desde la escena anterior | Bloque de oferta o servicio |
| 03 — Cierre | Revelación o destino | Resultado, dato útil, acción final |

Tres escenas suelen bastar. Añadir filas solo si la historia lo pide. Tras la tabla, una frase sobre cómo el scroll introduce, sostiene y retira el copy. El ritmo se mide en **alturas de viewport**, no en segundos del vídeo.

Si hay un beat de transición sin texto, la celda de copy puede decir: “Sin copy — manda el motion”.

No inventar reseñas, premios, direcciones ni cifras. Eso también lo bloquea `cumplimiento-publico`.

## Scroll usable

- El scroll nativo sigue funcionando hacia abajo y hacia arriba. Sin hijacking.
- El copy y los botones viven en HTML legible, no quemados en la imagen o el vídeo.
- Si la historia es larga, hay forma visible de saltarla.
- Con `prefers-reduced-motion: reduce`, un fotograma compuesto y el flujo normal de la página. Entender el negocio no depende de ver la animación.

Un scrub de secuencia de frames o un clip largo **no** es el default. Solo si el proyecto lo pide y hay presupuesto de performance (`performance-web`).

## Mobile compuesto

Mobile no es el desktop encogido.

| Regla | Detalle |
|---|---|
| Apertura | Nav de marca + un titular corto + una acción primaria. Sin párrafos que compitan con el visual |
| Nav | Fija, fuera del bloque pinneado; contraste suficiente; áreas táctiles ≥ 44×44; menú con teclado, foco y Escape |
| Composición | Texto en el espacio negativo; sujeto, titular y CTA sin solaparse ni taparse con la nav |
| Assets | Si hay animación pesada, versión portrait aparte. Cada viewport pide solo su secuencia; no precargar las dos |
| Ritmo | Timing propio del pulgar: acortar pausas muertas; mantener holds breves al abrir y al revelar el producto |
| Tras el cambio | Revisar de nuevo el desktop |

## Entrega mínima

En el Design Brief o en `docs/`: style tile (o enlace a tokens), tabla Visual Story si hubo historia, y nota de qué se asumió. Si se generaron imágenes, anotar procedencia (propia, cliente, licencia) para `cumplimiento-publico`.
