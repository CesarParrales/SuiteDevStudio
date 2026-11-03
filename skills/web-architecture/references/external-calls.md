# Llamadas externas y fallos lentos

Destilado 2026-11-03 desde la guía práctica de Elkis Dev (*Arquitectura de software*).
Complementa queues/jobs de `laravel-backend` y `node-backend`. Crédito: [elkisdm/devground/knowledge](https://github.com/elkisdm/devground/tree/main/knowledge).

Los servicios externos casi nunca se caen de golpe: **se ponen lentos**. Una llamada que espera 30 s es peor que una que falla en 1 s: ocupa workers y puede tumbar la app.

## Triada obligatoria

### 1. Toda llamada externa tiene tiempo límite

| Contexto | Orden de magnitud |
|----------|-------------------|
| Usuario esperando (request HTTP) | 1–5 s |
| Tarea de fondo / job | más alto, pero **finito** |
| Sin configurar | prohibido (muchas librerías esperan para siempre) |

### 2. Reintentos con espera creciente

- Pauta: 1 s → 2 s → 4 s; **máximo 3 intentos** si hay alguien esperando.
- Reintentar sin pausa contra un servicio caído lo hunde más.
- Solo reintentar si la operación es **idempotente** (o hay idempotency key).

### 3. Si puede tardar más de ~1 s, va a una cola

Correos, PDF, llamadas a IA, webhooks salientes pesados: la app **responde al instante** y un worker resuelve después, con reintentos y dead-letter.

Patrón de negocio: confirmar la acción del usuario **antes** del side-effect externo. Si el correo falla, la suscripción/pedido ya quedó; no se deshace por un fallo de afuera.

## Serverless vs servidor (es deploy, no arquitectura)

Puedes tener monolito en serverless o servicios en VPS. Elegir por tráfico:

| Forma | Conviene cuando | Cuidado |
|-------|-----------------|--------|
| Serverless (funciones) | Picos / tráfico esporádico; webhooks sueltos | Arranque en frío; caro con tráfico constante |
| Servidor / contenedores | Tráfico constante, latencia crítica, conexiones persistentes (chat) | Operación de máquinas/orquestación |
| Combinado (default sensato) | Núcleo en servidor; funciones para webhooks y tareas sueltas | Dos superficies de observabilidad |

Referencia citada en la guía origen: caso Prime Video 2023 (monitoreo de serverless → contenedores, ~90 % menos costo en esa parte). Úsalo como señal de costo, no como dogma.

## Perfil lectura/escritura por función

Antes de elegir motor o caché, por cada función importante anotar:

1. ¿Se lee mucho o se escribe mucho?
2. ¿Cuáles son las consultas que más se repiten?

Con eso se elige BD/caché/cola — no al revés. Para pagos, pedidos y lo que tiene que cuadrar: **Postgres** suele bastar al inicio.

## Checklist

- [ ] Timeout explícito en cada cliente HTTP/SDK externo
- [ ] Backoff + tope de reintentos + idempotencia
- [ ] Side-effects >1 s en cola (no en el request del usuario)
- [ ] Fallo externo no revierte lo ya confirmado al usuario (salvo compensación explícita)
- [ ] Deploy elegido con razón de tráfico, no de moda
