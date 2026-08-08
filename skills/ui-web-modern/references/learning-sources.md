# Learning Sources — recursos gratuitos (uso literal e inspiración)

```
last_updated: 2026-08
revisar_cada: 90 días
```

> **Caducidad:** URLs, tiers freemium y modas visuales cambian. Contrastar fecha
> de `last_updated` antes de recomendar. Las **tendencias no son verdades** —
> usar como radar o mood board, no como spec. Principios con evidencia → gates
> de validación; estética de prompt libraries → solo inspiración acotada.

---

## Cómo usar este archivo

```
USO LITERAL (copiar/adaptar con gates):
→ Componentes con código (21st.dev, shadcn)
→ Herramientas de contraste, iconos SVG, fuentes open source
→ Checklist de principios UX gratuitos (uxuiprinciples.com)
→ Plantillas docentes KIT UX UI (Figma, patrones base)

USO INSPIRACIÓN (extraer principio, no copiar pixel):
→ Prompts de heroes/landings (MotionSites free tier)
→ Catálogos premium curados (HorizonX Explore — mood board; código solo con licencia)
→ Templates de motion / carruseles showcase (Animos — ritmo y loop; no código producto)
→ Artículos de tendencias (Acceseo, Awwwards, Dribbble)
→ Generadores IA con créditos free (UX Pilot — validar con ui-audit después)

REGLA: literal sin auditoría = deuda técnica. Inspiración sin criterio = moda.
```

---

## Principios UX — evidencia (gratis)

**Fuente:** [uxuiprinciples.com/es/principles](https://uxuiprinciples.com/es/principles)

Principios con acceso grativo al jun 2026 (citas + prompts IA incluidos):

| Principio | Uso literal | Uso inspiración | Skill |
|-----------|-------------|-----------------|-------|
| Carga cognitiva | Limitar ítems visibles por pantalla | Simplificar nav/forms antes de “embellecer” | ui-audit, ux-architecture |
| Consistencia y estándares | Checklist de patrones repetidos | Alinear con design system existente | design-system, ui-audit |
| Ley de Jakob | No reinventar patrones dominantes | Benchmark vs productos que el usuario ya usa | ux-discovery |
| Ley de Hick | Reducir opciones por decisión | Menús cortos, CTAs primario/secundario | ux-architecture |
| Divulgación progresiva | Ocultar avanzado bajo “Más opciones” | Onboarding por capas | ux-architecture |
| Ley de Fitts | Targets ≥44px, CTAs grandes en mobile | Hero CTA placement | ui-mobile-native |
| Flujo conversacional | Turnos claros en chat/voz | Copy de asistentes IA | prompt-engineer |
| Transparencia IA | Mostrar límites y fuente de sugerencias | UI de features con IA | ui-web-modern |
| Bienestar inclusivo | Reducir estrés, no dark patterns | Tono y densidad de alertas | ux-discovery |

Gate sugerido en auditoría: validar al menos **3 principios gratuitos** relevantes
al flujo auditado → ver `ui-audit/references/ux-principles-free.md`.

El catálogo completo (185+) tiene tier de pago; no asumir acceso salvo que el
equipo lo tenga.

---

## Hub herramientas en español (gratis)

**Fuente índice:** [formiux.com/herramientas](https://formiux.com/herramientas/)

No duplicar toda la lista aquí — FormiUX cura enlaces. Subconjunto **100% free**
más usado en la suite:

```
DISEÑO UI (free tier / open source):
  Figma               → figma.com (free starter)
  PenPot              → penpot.app (open source)

COLORES + ACCESIBILIDAD (free):
  Coolors             → coolors.co
  Color Hunt          → colorhunt.co
  Leonardo            → leonardocolor.io
  Color Tool          → material.io/resources/color
  Colour Contrast     → colourcontrast.cc
  Color Hub           → colorhub.vercel.app
  Palett              → palett.es

ICONOS (free, SVG):
  Heroicons           → heroicons.com
  Feather Icons       → feathericons.com
  Tabler Icons        → tabler.io/icons
  Lucide              → lucide.dev
  Google Material Symbols → fonts.google.com/icons
  Flowbite Icons      → flowbite.com/icons

ILUSTRACIONES (free tier):
  unDraw              → undraw.co
  Storyset            → storyset.com
  Blush               → blush.design
  DrawKit             → drawkit.com (free pack)

TIPOGRAFÍAS (free):
  Google Fonts        → fonts.google.com
  Fontshare           → fontshare.com

RESEARCH / USABILIDAD (free tier o freemium útil):
  GTmetrix            → gtmetrix.com (límites free)
  Wayback Machine     → web.archive.org

USER FLOWS (free tier):
  FigJam              → figma.com/figjam
  Miro                → miro.com (free plan)

OPTIMIZACIÓN IMÁGENES (free):
  TinyPNG             → tinypng.com
  Squosh              → squoosh.app

PLUGINS FIGMA (free):
  Autoflow, Lorem Ipsum, Unsplash, Split Shape — ver listado FormiUX
```

**Recursos docentes ES:** [kituxui.com](https://kituxui.com) — UX flows, UI base,
accesibilidad intro. Copiar/adaptar en Figma para workshops (`team-onboarding`).

---

## Componentes — uso literal en código

**21st.dev (community, gratis)** — [21st.dev/community/components](https://21st.dev/community/components)

```
CUÁNDO: acelerar moléculas/organismos React en producto web.
CATEGORÍAS ÚTILES:
  → Buttons, Cards, Forms, Tables, Sidebars (admin)
  → Heroes, Pricing, Testimonials (marketing — inspiración + adaptar tokens)

REGLAS:
  → Una familia visual por proyecto (no mezclar 5 autores)
  → Revisar focus, contraste, bundle size antes de merge
  → Adaptar a tokens del design system — no pegar estilos crudos

COMPLEMENTO ATEMPORAL (ya en trends-watch):
  shadcn/ui, Tremor, Radix — preferir si el proyecto ya los usa
```

---

## Inspiración visual — tier free

**MotionSites** — [motionsites.ai](https://motionsites.ai)

```
GRATIS: subset de prompts marcados "Copy" (heroes, landings, SaaS, agency).
PREMIUM: ignorar salvo licencia explícita del cliente.

USO: mood board + estructura de hero (headline, CTA, social proof).
NO USO: glass/3D/cinematic pesado en app producto sin medir performance-web.

Etiqueta en brief: [INSPIRACIÓN · MotionSites · revisar 90d]
```

**UX Pilot** — [uxpilot.ai/es/ai-ui-generator](https://uxpilot.ai/es/ai-ui-generator)

```
FREEMIUM: créditos limitados; prototipos rápidos wireframe/alta fidelidad.
USO: explorar 2-3 variantes de flujo en fase ux-architecture EXPRESS.
GATE OBLIGATORIO: ui-audit + web-interface-guidelines antes de implementar.
No dependencia en CI/CD.
```

**Acceseo tendencias 2026** — [acceseo.com/tendencias-ux-ui-2026.html](https://www.acceseo.com/tendencias-ux-ui-2026.html)

```
Radar editorial — desglosar cada punto en moda vs principio:
  MODA (contexto marketing): Make it big, Y2K, realismo digital exagerado
  PRINCIPIO: diseño sin barreras, sostenibilidad digital (peso/WPO)
  DIRECCIÓN LARGO PLAZO: screen-free — no default para web clásica

Detalle filtrado → trends-watch.md § Radar editorial 2026
```

**HorizonX** — [horizonx.so/explore](https://horizonx.so/explore) · sitio [horizonx.so](https://horizonx.so)

```
QUÉ ES (jul 2026):
  Biblioteca premium in-house de UI kits, landings, componentes, assets Figma
  y demos Code / WebGL / GSAP — orientada a “vibecoding” y ship rápido.
  Explore: ~88+ piezas curadas (Featured / Most viewed / Newest).
  Categorías útiles: UI/UX · Code · Vibe coding · Assets · Branding.

TIER:
  Explorar catálogo → sin paywall de lectura (mood board).
  Descargar Figma/código → suscripción ($24.99–$99.99/mo Starter/Pro/Max)
    o compra unitaria; licencia comercial incluida en plan.
  NO es free-tier de componentes como 21st.dev community.

USO INSPIRACIÓN (default de la suite — sin licencia):
  → Mood board de heroes cinematográficos, product storytelling, dark SaaS
  → Extraer principios: jerarquía tipográfica editorial, ritmo de scroll,
    contraste dark, mockups de producto, pricing sections
  → Etiqueta en brief: [INSPIRACIÓN · HorizonX Explore · revisar 90d]

USO LITERAL (solo si el equipo tiene licencia activa):
  → Adaptar tokens del design system; una familia visual por proyecto
  → Gate obligatorio: ui-audit + performance-web (WebGL/GSAP/3D pesan)
  → No pegar glow/purple/glass pesado en app producto densa sin medir

NO USO / CUIDADOS:
  → No tratar piezas como productos en producción (muchas son conceptos)
  → No default de motion cinematográfico en dashboards/admin
  → Evitar sesgos visuales cluster (purple glow, glass multi-layer) —
    ver reglas de diseño del agente / color.md
  → No inventar “gratis con código” — si no hay licencia, solo inspiración

CUÁNDO ELEGIR HORIZONX vs 21st.dev vs MotionSites vs Animos:
  HorizonX Explore  → mood board premium landings / brand / motion
  21st.dev          → componentes React community (literal + tokens)
  MotionSites       → prompts de heroes (free "Copy")
  Animos            → patrones de carrusel/showcase + export MP4/WebM marketing
```

**Animos** — [animos.app](https://animos.app)

```
QUÉ ES (ago 2026):
  Editor no-code en el navegador: ~25 templates de motion looping para
  showcase de diseños (UI mockups, apps, product shots). Workflow:
  pick template → drop images/videos → tweak → export MP4/WebM.
  Procesamiento local en el cliente (assets no suben a su nube según FAQ).
  Ratios: 16:9, 4:3, 1:1, 4:5, 9:16. Export hasta 8K (HD+ suele ser Pro).

TIER (verificar en sitio):
  Templates + export 720p → free (sin cuenta, según FAQ del producto).
  HD–8K → Pro (suscripción o tokens según región).
  NO es librería de carrusel React (no Embla/Swiper/código drop-in).

USO INSPIRACIÓN (default):
  → Referencia de PATRONES de carrusel / slider / card stack / coverflow-like
  → Extraer: ritmo de loop, profundidad 3D/tilt, spacing entre slides,
    sombra, duración del ciclo, sensación “seamless”
  → Etiqueta: [INSPIRACIÓN · Animos · carrusel/showcase · revisar 90d]

USO EXPORT (marketing / launch / portafolio — permitido):
  → Generar clips cortos looping para redes, release notes, landing demos
  → WebM transparente cuando el stack lo permita (landing, no admin denso)
  → Gate performance-web si el clip va embebido en producto web

NO USO:
  → No sustituir implementación de carrusel en producto (usar Embla/Swiper
    o patrón del design system + motion.md + a11y)
  → No tomar estética 3D pesada como default en dashboards/SaaS densos
  → No asumir licencia de footage de terceros dentro del template

CARRUSELES EN CÓDIGO (si hay que implementar, no Animos):
  → Embla Carousel / Swiper / Radix según stack del proyecto
  → Gates: teclado, focus, prefers-reduced-motion, touch, aria-roledescription
  → Inspiración de ritmo → Animos; implementación → código + ui-audit
```

---

## Mapa fuente → skill → modo de uso

| Fuente | Gratis | Skill | Modo |
|--------|--------|-------|------|
| UX/UI Principles (subset) | Sí | ui-audit, ux-* | Literal (checklist) |
| FormiUX índice | Sí | ui-web-modern | Literal (herramientas) |
| KIT UX UI | Sí | team-onboarding | Literal (plantillas) |
| 21st.dev community | Sí | atomic-design, react-patterns | Literal + adaptar tokens |
| HorizonX Explore | Browse sí / assets de pago | ui-web-modern, ui-audit | Inspiración; literal solo con licencia |
| Animos | Templates + 720p free; HD Pro | ui-web-modern, motion | Inspiración carrusel + export clips |
| MotionSites Copy | Parcial | ui-web-modern | Solo inspiración |
| UX Pilot | Freemium | ux-architecture | Prototipo → auditar |
| Acceseo 2026 | Sí (artículo) | trends-watch | Solo radar |

---

## Flujo recomendado (gratis de punta a punta)

```
1. Contexto     → ux-discovery + project-memory
2. Principios   → uxuiprinciples (3+ checks gratuitos)
3. Referentes   → Mobbin/Pageflows (inspiration.md) + productos Tier 1 (trends-watch)
                  + HorizonX Explore (mood board landings/brand; no código sin licencia)
                  + Animos (patrones carrusel/showcase + export marketing)
4. Prototipo    → wireframes ASCII/Mermaid O UX Pilot free (opcional)
5. Componentes  → 21st.dev / shadcn → atomic-design
                  (HorizonX Code/Figma solo con licencia + adaptar tokens)
                  Carrusel en producto → librería del stack (no Animos)
6. Validación   → ui-audit + performance-web (GTmetrix/Squosh si aplica)
7. Cierre       → LEARNINGS.md si alguna URL falló o el tier cambió
```
