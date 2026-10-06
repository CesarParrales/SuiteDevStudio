# Revisión de URL en vivo (DAST)

Dar una URL y revisar sus vulnerabilidades contra la app corriendo. Requiere la puerta de autorización y las RoE de [pentest-methodology.md](pentest-methodology.md): el dominio debe estar en el alcance escrito. Un dominio de cliente sin autorización no se escanea.

## Pasivo (seguro, sin tocar el servidor con intención)

- **TLS:** `sslyze <host>` / `testssl.sh`. Protocolos viejos, cifrados débiles, caducidad del certificado, cadena incompleta.
- **Cabeceras:** HSTS, CSP, `X-Content-Type-Options`, `X-Frame-Options`/`frame-ancestors`, `Referrer-Policy`. Cookies con `Secure`, `HttpOnly`, `SameSite`.
- **Exposición:** `/.git`, `/.env`, listados de directorio, `/actuator`, `/phpinfo`, paneles de admin sin proteger, mensajes de error con stack trace, versiones en banners.
- **Tecnología y superficie:** rutas, subdominios, APIs publicadas, `robots.txt`, sitemap.

## Activo (dentro de la ventana y la intensidad pactadas)

- **Autenticación y sesión:** fuerza bruta con rate limit, fijación de sesión, expiración de token, flujo de reset de password, `state` en OAuth (CSRF).
- **Autorización / IDOR:** cambiar identificadores de recurso entre usuarios; acceso a endpoints de admin con cuenta normal.
- **Inyección:** SQLi, NoSQLi, inyección de comandos, SSTI, en parámetros, cabeceras y cuerpo. XSS reflejado y almacenado.
- **Carga de archivos:** tipo MIME real (no solo `Content-Type`), tamaño, ruta de guardado, ejecución.
- **Lógica de negocio:** saltarse pasos, precios/cantidades negativas, condiciones de carrera en pagos o stock.
- **Rate limit y recursos:** límites por IP y por cuenta, sin llegar a tumbar el servicio (prohibido por RoE).

## Herramientas

OWASP ZAP (baseline passivo o escaneo autenticado), Burp Suite, `nuclei` con plantillas, `ffuf` para contenido (con cuidado de intensidad). Automatizar el barrido; el juicio senior va en lógica de negocio y en encadenar hallazgos.

## Producción vs staging

Si existe staging con paridad, el escaneo activo va ahí primero. En producción: solo pasivo salvo autorización explícita para activo, ventana fuera de pico, y nada que degrade el servicio. Un escaneo activo mal calibrado contra prod es un incidente, no una auditoría.

## Salida

Veredictos de `audit.md`. Cada confirmado con la petición exacta que lo reproduce (método, URL, cabeceras, cuerpo), el principal afectado y el impacto. Nunca se adjuntan datos reales de usuarios obtenidos en la prueba.
