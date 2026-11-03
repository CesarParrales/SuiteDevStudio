# Dónde vive cada valor configurable

Destilado 2026-11-03 desde la guía práctica de Elkis Dev (*Arquitectura de software*).
No se adopta su stack de ejemplo. Crédito: [elkisdm/devground/knowledge](https://github.com/elkisdm/devground/tree/main/knowledge).

La pregunta útil no es «¿lo quiero cambiar sin deploy?». Es **quién puede cambiarlo** y **cuánto daño hace si cambia mal**.

## Matriz

| Dónde vive | Qué guarda | Ejemplos | Pasa por deploy |
|------------|------------|----------|-----------------|
| **Código** | Cómo funciona el sistema | Reglas de negocio, mapeo a un proveedor, invariantes | Sí |
| **Variables de entorno** | Con qué infraestructura corre | Claves API, URL de BD, proveedor de pagos activo | Sí (y rotación de secretos) |
| **Feature flags** | Qué función está encendida y para quién | Pantalla nueva al 10 %, kill switch | No (con plan de retirada) |
| **Base de datos (config operativa)** | Cómo opera el negocio hoy | Precios, horarios, límites, textos de mensajes | No |
| **Datos de dominio** | Lo que pasó | Usuarios, pedidos, pagos, historial | N/A |

## Reglas

1. Lo que más daño puede hacer (cambiar proveedor de pagos, modelo de auth, límites de seguridad) **pasa por deploy**, nunca por un botón improvisado.
2. Lo que cambia seguido y hace poco daño (copy, horarios, cupos) va en **BD o CMS**, no en código.
3. Los **secretos nunca van en el código** ni en el historial git. Si se filtran, se rotan; borrar el commit no basta.
4. Contenido editorial (guías, posts) no es estructura: si hoy exige deploy, anotar el ADR para moverlo a BD/CMS.
5. Cada valor no obvio se documenta en un ADR corto o en project-memory: contexto, decisión, descartado, costo de revertir.

## Checklist al diseñar

- [ ] Lista de valores configurables del MVP con columna «dónde vive»
- [ ] Ningún secreto en repo
- [ ] Flags con dueño, estado inicial en prod y plan de apagado
- [ ] Cambios de alto impacto obligan deploy + revisión
