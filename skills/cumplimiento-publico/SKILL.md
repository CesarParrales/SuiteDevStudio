---
name: cumplimiento-publico
description: >
  Prepara y revisa lo que un sitio o app debe tener antes de publicarse:
  privacidad, términos, cookies, reembolsos si hay cobro, consentimientos,
  datos recopilados, terceros, texto alternativo y contraste, formularios
  usables con teclado, reseñas y afirmaciones, imágenes y ley local.
  Usar al empezar un proyecto, sobre un proyecto ya en curso, o antes de
  desplegar a producción. También cuando pidan políticas, aviso de cookies,
  consentimiento, claims, derechos de imagen o datos de la empresa.
---

# Cumplimiento público

Checklist de lo que el visitante y el cliente final ven. No es un dictamen
legal: el texto lo aprueba quien opera el sitio, con su abogado si el país
o el sector lo exigen. Esta skill no inventa que una cláusula vale en una
jurisdicción.

No cubre el contrato entre el estudio y el cliente (`propuestas-contratos`).
No reescribe WCAG (`ui-audit`) ni el borrado técnico de una cuenta
(`security-checklist`).

## Memoria

**Al iniciar:**

1. `.cursor/project-memory.md` — país del operador, si hay cobro, si ya hay políticas.
2. Páginas públicas del repo (`privacy`, `terms`, `cookies`, `refund`) si existen.
3. `LEARNINGS.md` de esta skill — solo `## Pendientes`.

**Al cerrar:** el inventario queda en `docs/cumplimiento-publico.md` del proyecto. La decisión de país y de si hay cobro va a project-memory.

## Cuándo

| Momento | Qué entregar |
|---|---|
| Inicio de cualquier proyecto con sitio o app pública | Inventario: qué documentos aplican y qué datos se van a guardar |
| Proyecto ya en curso | La misma tabla, marcada contra el repo o la URL |
| Antes de producción | Gate: nada en `Falta` de las filas que aplican |

Si el producto no tiene visitantes (script interno, librería), el gate es N/A y se dice en una línea.

## Protocolo

1. Clasificar el producto: sitio informativo, cuenta de usuario, cobro (tienda o suscripción), o solo herramienta interna.
2. Leer `references/documentos.md` para las páginas que apliquen.
3. Leer `references/datos-y-terceros.md` si hay formulario, cuenta, analytics o pago.
4. Leer `references/claims-y-medios.md` si hay marketing, reseñas, cifras o imágenes de stock.
5. El contraste, el texto alternativo, el teclado y el nombre del botón se comprueban con `ui-audit`. Esta skill solo exige el resultado en la tabla. El mínimo está en `references/acceso-publico.md`.
6. Escribir `docs/cumplimiento-publico.md` con la plantilla de abajo. Cada fila: `Hecho`, `Falta`, `N/A` o `Duda`.
7. Una fila `Falta` o `Duda` en privacidad, consentimiento, cobro, claims o imágenes bloquea el go-live. No se redacta la política entera dentro del código sin que el operador confirme los hechos (quién es, qué datos, qué país).

## Defaults

| Falta | Se asume |
|---|---|
| País | `Duda`. No se cita una ley concreta |
| Hay cobro | No, hasta ver checkout, precio o pasarela |
| Cookies de marketing | No se cargan hasta un sí explícito |
| Reseñas | No se publican si no hay fuente real en el repo o en el admin |

## Entregable

```markdown
# Cumplimiento público — [proyecto] — [fecha]

Producto: informativo | con cuenta | con cobro | interno
País del operador: [o Duda]
País de los usuarios, si se conoce: [o Duda]

| Tema | Estado | Acción |
|---|---|---|
| Política de privacidad | | |
| Términos y condiciones | | |
| Política de cookies | | |
| Reembolsos | | |
| Consentimiento de cookies y de formularios | | |
| Inventario de datos | | |
| Terceros | | |
| Texto alternativo y contraste | | |
| Formularios con teclado y botones claros | | |
| Reseñas, afirmaciones y datos de la empresa | | |
| Imágenes y ley local | | |

Hechos que el operador debe confirmar: ...
Bloquea producción: sí | no
```

## Skills relacionadas

- `software-project-analysis` — al abrir el proyecto, este inventario entra en el análisis
- `comprobacion-produccion` — el gate de release incluye esta tabla
- `ui-audit` — contraste, alternativa textual, teclado
- `security-checklist` — borrado y exportación de cuenta
- `propuestas-contratos` — contrato del estudio, no las páginas del sitio

## Aprendizaje continuo

Al cerrar, anota en `LEARNINGS.md` de esta skill cualquier hueco: fecha, contexto, hallazgo, cambio propuesto.
