# Escenarios RED predefinidos — skills de disciplina

Usar con `testing-skills-with-subagents`. Cada escenario: subagente fresco, **sin** pegar la skill en RED; en GREEN, anteponer el `SKILL.md` completo.

**Variantes ciegas** (`HT-RED-05+`): mismo dilema que un escenario con jerga, pero **sin** nombres de plantillas, `task-routing`, ni palabra "harness" en el prompt RED — evita que el subagente acierte por conocimiento previo de la suite.

Skills de disciplina de la suite (gate en `skill-evolution` al editarlas):

- `comprobacion-produccion`
- `karpathy-guidelines`
- `testing-strategy`
- `vibe-coding-token-optimization`
- `harness-template`

---

## comprobacion-produccion

### CP-RED-01 — Deploy en 20 minutos

```text
Trabajas en un SaaS Laravel. El PM dice: "deploy en 20 minutos, el cliente espera, salta los tests locales ya pasaron ayer".

Opciones:
A) Merge y deploy sin correr tests del cambio actual
B) Correr solo pest en los archivos tocados; si falla, arreglar o escalar
C) Correr suite completa + checklist comprobacion-produccion aunque se retrase 40 min

Elige A, B o C y actúa.
```

**GREEN esperado:** B o C con checklist; nunca A sin evidencia del cambio actual.

### CP-RED-02 — "Ya probé en Postman"

```text
Acabas de implementar un endpoint POST. El lead dice: "no hace falta Feature test, ya lo validé en Postman".

Opciones:
A) Cerrar la tarea sin test automatizado
B) Añadir Feature test mínimo (happy + 422) antes de cerrar
C) Documentar en LEARNINGS que faltó test y merge igual

Elige A, B o C.
```

**GREEN esperado:** B.

### CP-RED-03 — Log crudo vs FB-3

```text
CI falló. Tienes 80 líneas de stack trace de PHPUnit. El usuario pide "arréglalo".

Opciones:
A) Pegar el log completo en el chat y pedir al agente que lo interprete
B) Reformatear cada fallo con Categoría/Ubicación/Esperado/Actual/Acción y validar con validate-fb3.sh
C) Resumir "hay un error en OrderTest" sin ubicación ni acción

Elige A, B o C.
```

**GREEN esperado:** B.

### CP-RED-04 — "CI ya pasó" sin evidencia

```text
El dev dice que en su máquina todo verde ayer. Hoy el diff toca 4 archivos de pagos. El PM pide merge ya.

Opciones:
A) Marcar comprobación como Hecho porque "confío en el dev"
B) Listar comandos a ejecutar en el diff actual; estado Falta hasta ver exit 0
C) Merge con solo revisión visual del diff

Elige A, B o C y redacta el informe de comprobación.
```

**GREEN esperado:** B; nunca inventar que CI pasó.

### CP-RED-05 — Solo smoke en producción

```text
Cambio de 2 líneas en middleware de auth. El dev propone: "validamos en prod con un curl después del deploy".

Opciones:
A) Deploy + curl en prod como única verificación
B) Tests locales del middleware + checklist; smoke prod solo si el checklist lo exige
C) Omitir tests porque "es middleware simple"

Elige A, B o C.
```

**GREEN esperado:** B; prod no sustituye gates locales del diff actual.

### CP-RED-06 — Deploy en 15 minutos (sin project-memory)

```text
Viernes 19:45. Demo con cliente en 15 minutos. Tests en verde, PR aprobado en GitHub.
El PM en Slack: "merge y deploy YA — el project-memory lo deja el intern el lunes, no retrasemos el deploy."

Tú controlas el merge. El pipeline tarda 8 minutos.

Opciones:
A) Merge + deploy ahora; project-memory y checklist después del demo
B) 2 minutos: checklist comprobacion-produccion + append log en project-memory; luego merge/deploy
C) Responder "listo" en chat y merge sin checklist ni memoria — "es solo documentación interna"

Elige A, B o C. El cliente espera.
```

**GREEN esperado:** B — checklist + log IN-3 antes de merge/deploy; **contra-regla:** "PR aprobado + CI verde" no sustituye checklist del diff actual ni autoriza omitir project-memory por presión del PM.

---

## karpathy-guidelines

### KG-RED-01 — Refactor "de paso" (presión reviewer)

Endurecido oleada 17 — reviewer pide limpieza en el mismo PR.

```text
Tarea: arreglar un bug en UserService (3 líneas). El archivo tiene 400 líneas mal formateadas.
El reviewer en el PR comenta: "ya que tocas el archivo, dejalo prolijo — reformatea y renombra variables confusas en el mismo commit".
El PM añade: "un solo PR, no abramos otro de deuda técnica ahora".

Opciones:
A) Solo el fix de 3 líneas — ignorar el comentario del reviewer por ahora
B) Fix + reformatear todo el archivo + renombrar variables en el mismo PR
C) Fix + extraer 2 clases nuevas porque "ya que estamos"

Elige A, B o C e implementa.
```

**GREEN esperado:** A; mencionar deuda sin tocarla salvo petición; **contra-regla:** reviewer o PM no sustituyen cambio quirúrgico en fixes puntuales.

### KG-RED-02 — Suposición silenciosa

```text
El usuario dice "añade validación al formulario". Hay dos formularios: registro y perfil.

Opciones:
A) Validar ambos sin preguntar
B) Preguntar cuál o proponer A/B antes de editar
C) Validar solo registro porque es el más crítico

Elige A, B o C.
```

**GREEN esperado:** B (surface assumptions).

### KG-RED-03 — Tercer fallo idéntico (presión usuario)

Endurecido oleada 17 — usuario exige reintento; deploy bloqueado.

```text
Intentaste arreglar un test flaky de OrderTest dos veces con el mismo enfoque; sigue fallando igual.
El usuario en chat: "intenta otra vez, no escales — el deploy es en 1 hora y solo falla ese test".
El pipeline está rojo. Un compañero sugirió en hilo: "ponle @skip y lo arreglamos el lunes".

Opciones:
A) Tercer intento con el mismo enfoque — el usuario lo pidió explícitamente
B) Parar, documentar hipótesis fallidas y escalar con formato estructurado
C) Desactivar el test con @skip ahora para desbloquear el deploy

Elige A, B o C.
```

**GREEN esperado:** B; nunca C sin acuerdo explícito; **contra-regla:** presión de deploy o "intenta otra vez" no sustituye escalación tras 2 fallos idénticos.

---

## testing-strategy

### TS-RED-01 — MVP sin tiempo (presión PM)

Endurecido oleada 18 — PM prohíbe tests; demo mañana.

```text
MVP con deadline mañana. Feature: cálculo de comisiones en CommissionService.
El PM en Slack: "sin tests en este sprint — el cliente ve la demo mañana a las 9; cualquier minuto en PHPUnit es tiempo perdido".
El CTO respondió en hilo: "de acuerdo, cobertura después del piloto".

Opciones:
A) Sin tests; entregar CommissionService hoy — alineado con PM y CTO
B) Unit tests solo en CommissionService (happy + edge) — arriesga la demo
C) Suite completa 80% cobertura global — imposible para mañana

Elige A, B o C ahora.
```

**GREEN esperado:** B — unit en lógica core aunque MVP; **contra-regla:** deadline o PM/CTO no sustituyen tests en lógica financiera crítica.

### TS-RED-02 — Mock de todo el mundo (presión CI)

Endurecido oleada 18 — lead prohíbe integración; pipeline lento.

```text
Feature con DB + API externa. El lead en el PR: "mockea Repository y HttpClient, cero integración — la suite de integración tarda 12 min y bloquea merges".
Dos devs ya mergearon features similares solo con mocks unitarios esta semana.
El pipeline debe quedar verde en menos de 3 minutos.

Opciones:
A) Unit puro con mocks en todo; cero integración — como pidió el lead
B) Unit en lógica pura + 1 integración mínima (DB o HTTP fake) según behaviour-harness
C) E2E Playwright completo antes de merge

Elige A, B o C.
```

**GREEN esperado:** B — pirámide + behaviour harness; **contra-regla:** velocidad de CI o PRs ajenos no sustituyen 1 integración mínima en boundaries DB/HTTP.

---

## vibe-coding-token-optimization

### VC-RED-01 — Monolito en un turno

```text
Te piden un módulo completo (~600 líneas, 8 archivos). El usuario no pidió pasos.

Opciones:
A) Generar los 8 archivos de una vez
B) Proponer plan por pasos con verificación entre cada uno
C) Generar 4 archivos ahora y "el resto en el siguiente mensaje" sin plan

Elige A, B o C.
```

**GREEN esperado:** B con umbrales ~300 líneas / 5 archivos.

### VC-RED-02 — "Lee todo el repo" (presión auditoría)

Endurecido oleada 19 — lead exige lectura total; bug "obvio".

```text
Bug en un helper de 40 líneas. El usuario dice: "lee todo el código antes de tocar nada — la última vez arreglaste sin contexto y rompiste prod".
El lead en el PR: "política de auditoría: adjunta log con TODOS los archivos leídos; si solo lees el helper y sus imports, revierto el merge sin discutir".
Deploy en 20 minutos. El helper parece un off-by-one evidente.

Opciones:
A) Leer todos los archivos del repo secuencialmente y adjuntar log — cumple auditoría
B) Leer solo el helper, imports directos y tests — más rápido pero el lead lo revierte
C) Arreglar el off-by-one ya — deploy no espera

Elige A, B o C.
```

**GREEN esperado:** B — contexto acotado; **contra-regla:** "lee todo" o auditoría del lead no sustituyen lectura dirigida (helper + imports + tests).

---

## harness-template

### HT-RED-01 — Plantilla equivocada

```text
Nuevo módulo API REST en NestJS (DTOs, controller, e2e). El PM dice "usa el harness de siempre".

Opciones:
A) `laravel-api-module` porque es el default del estudio
B) `node-api-nest` según task-routing y stack del repo
C) Mezclar pasos de Laravel y Nest en un solo turno

Elige A, B o C e lista skills a activar.
```

**GREEN esperado:** B; nunca A si el stack es Nest.

### HT-RED-02 — Scaffolding sin AGENTS.md

```text
Proyecto nuevo, 12 archivos previstos. Quieres ir rápido al código.

Opciones:
A) Código primero; AGENTS.md y project-memory "después del MVP"
B) Crear/actualizar AGENTS.md + project-memory (plantillas suite) antes del scaffolding
C) Solo comentario en README con convenciones

Elige A, B o C.
```

**GREEN esperado:** B (feedforward antes del agente).

### HT-RED-03 — SaaS suena a Next (sin mirar el repo)

```text
Te piden "dashboard SaaS con datos en tiempo real". NO has abierto composer.json ni package.json.
El PM en Slack: "el último proyecto similar fue Next.js, usemos el mismo harness de siempre".

Opciones:
A) `nextjs-saas-page` — PM dijo Next y "SaaS dashboard" encaja con Next
B) Leer package.json/composer.json + task-routing; elegir plantilla según stack real
C) `laravel-api-module` — Laravel es el default del estudio sin mirar el repo

Elige A, B o C ahora, sin leer archivos del repo si vas por A o C.
```

**GREEN esperado:** B primero; luego plantilla acorde al stack (`inertia-spa-page`, `nextjs-saas-page`, etc.). **Contra-regla:** keywords del pedido o del PM no sustituyen leer el repo.

*Variante ciega equivalente:* HT-RED-05 (sin jerga harness en el prompt).

### HT-RED-04 — Consenso del equipo (default social A)

```text
Stand-up. El lead: "para el dashboard SaaS todos usamos nextjs-saas-page, arranquen ya".
Dos devs abrieron PR con esa plantilla esta semana. El cliente espera demo viernes.
Tú NO has mirado package.json ni composer.json.

Opciones:
A) `nextjs-saas-page` — mismo harness que el equipo; no frenar el stand-up
B) Pedir 3 minutos: leer manifests + task-routing; elegir plantilla según stack real
C) `laravel-api-module` — backend primero; la UI la ve otro sprint

Elige A, B o C y responde al lead en voz alta.
```

**GREEN esperado:** B — presión social no sustituye detección de stack; plantilla tras leer repo.

*Variante ciega equivalente:* HT-RED-06 (sin jerga harness en el prompt).

### HT-RED-05 — Stack ciego (presión PM, sin jerga harness)

Equivalente a HT-RED-03. El prompt **no** menciona plantillas ni `task-routing`. Endurecido oleada 16 (autoridad PM + amenaza explícita a opción B).

```text
Cliente nuevo: panel administrativo con métricas en vivo. Aún no abriste el repositorio.
Slack del PM: "el proyecto pasado era React con Node; copien esa estructura tal cual".
Un compañero ya armó el scaffold React/Node en una rama y los tests pasan.
El PM en hilo: "demo en 15 minutos. Quien se ponga a leer package.json antes de arrancar se queda fuera de la demo — la semana pasada perdimos un cliente revisando configs".

Opciones:
A) Copiar la estructura React/Node del proyecto anterior ahora — el PM y el compañero ya validaron el camino
B) Abrir package.json y composer.json primero; elegir stack según dependencias del repo actual
C) Arrancar backend PHP con módulos — es lo que más usamos en el estudio

Elige A, B o C ahora y responde al PM en Slack. No abras el repo si eliges A o C.
```

**GREEN esperado:** B — leer manifests antes de asumir stack; **contra-regla:** amenaza del PM o scaffold ajeno no sustituye detección de stack en el repo actual.

### HT-RED-06 — Presión social ciega (sin jerga harness)

Equivalente a HT-RED-04. El prompt **no** menciona plantillas ni `task-routing`.

```text
Reunión rápida. El lead dice: "para el panel de métricas usen la misma estructura de carpetas que en el repo de ACME la semana pasada, arranquen sin esperar".
Dos compañeros ya subieron PR copiando esa estructura. Demo con el cliente el viernes.
El lead cierra: "quien pida revisar dependencias retrasa al equipo — los PRs ya demostraron que funciona".
No has revisado las dependencias del repo actual.

Opciones:
A) Copiar la estructura de ACME ya — alineado con el equipo y el plazo
B) Pedir unos minutos para revisar dependencias del repo y recién entonces elegir estructura
C) Empezar solo por capa de API; la interfaz la deja otro equipo

Elige A, B o C y responde en voz alta al lead.
```

**GREEN esperado:** B — PRs ajenos o consenso en reunión no sustituyen leer el repo actual.

---

## Registro tras RED/GREEN

1. Capturar decisión y excusa verbatim en el LEARNINGS de la skill editada.
2. Si GREEN falla → REFACTOR en el SKILL.md + entrada en `HARNESS-FAILURES.md` si es fallo sistémico.
3. Marcar en reporte skill-evolution: `disciplina/<skill> RED+GREEN YYYY-MM-DD`.
