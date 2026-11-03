# Datos, consentimiento y terceros

## Inventario

Una fila por dato, antes de diseñar el formulario o la tabla.

| Dato | Para qué | Dónde se guarda | Tercero que lo ve | Cuánto tiempo |
|---|---|---|---|---|
| | | | | |

Si el dato no tiene un para qué, no se pide. El borrado y la exportación de una cuenta, si existen, siguen el patrón de `security-checklist` (`references/secrets-env.md`, sección de privacidad).

## Cookies y formularios

- Las cookies necesarias pueden cargarse solas.
- Medición y marketing no cargan hasta un sí. Rechazar está al mismo nivel que aceptar. Nada viene marcado.
- El formulario dice, al lado, para qué se usan esos campos y enlaza la privacidad.
- No se condiciona el alta a aceptar marketing.

## Terceros

Un tercero es quien recibe datos o ejecuta código: pasarela, correo, mapas, analítica, chat, pixel, fuente externa, CDN con cookie.

Antes de cargar el script:

- Está en el inventario y en la página de privacidad o de cookies.
- Se sabe qué instrucción tiene: solo el fin que el operador declaró (cobrar, enviar un correo, medir).
- Sus condiciones de uso están anotadas (enlace y fecha de lectura), porque el producto tiene que poder cumplirlas.
- Si el operador no autorizó ese tercero, no se añade en el código.
