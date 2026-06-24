# Capacidades de la suite — Mobile y análisis de datos

**Versión evaluada:** harness v3.4 · **Fecha:** 2026-06-24

Respuestas operativas sobre qué puede resolver la suite **hoy** sin stacks adicionales. Roadmap de lenguajes: [roadmap-v4-languages.md](roadmap-v4-languages.md).

---

## Mobile — ¿escala media?

### Definición usada aquí

**App móvil de escala media:** ~10–30 pantallas, varios módulos/feature, auth, API REST/GraphQL, push, offline parcial, 2–3 flavors (dev/staging/prod), CI, publicación en stores, equipo 2–5 devs, sin requisitos extremos de módulos nativos custom profundos.

### Veredicto

| Tipo de proyecto | ¿Lo resuelve v3.4? | Nivel |
|------------------|-------------------|-------|
| **Flutter — app producto escala media** | **Sí** | Alto |
| **React Native (Expo dev build) — escala media** | **Sí** | Alto |
| **Mobile nativo Swift/Kotlin only** | Parcial | Bajo |
| **Super-app / 50+ pantallas / equipos 10+** | Parcial | Medio |

### Qué cubre hoy (evidencia en repo)

| Capacidad | Flutter | React Native |
|-----------|---------|--------------|
| Arquitectura feature-first | `mobile-flutter` + `architecture.md` | Expo Router + `state-api.md` |
| Estado + API | Riverpod, Dio, Freezed | React Query, Zustand, offline |
| Navegación | GoRouter | Expo Router |
| Flavors / perfiles | dev/staging/prod | EAS development/preview/production |
| Push | Firebase + local notifications | expo-notifications |
| Tests + gates | `flutter analyze`, `flutter test` | expo-doctor, type-check, tests |
| Harness scaffold | `flutter-feature` template | `react-native-screen` template |
| UX nativa | `ui-mobile-native` (HIG/Material) | `ui-mobile-native` + `ui-native.md` |
| Calidad release | `comprobacion-produccion`, harness | idem |

### Límites honestos (escala media → grande)

| Gap | Impacto | Workaround actual |
|-----|---------|-------------------|
| Sin skill Swift/Kotlin nativo | Apps 100% nativas débiles | `ui-mobile-native` solo guidelines |
| E2E mobile (Detox/Maestro) no profundizado | Menos gate E2E automatizado | `testing-strategy` E2E genérico |
| Analytics (Amplitude, Firebase Analytics) | Sin protocolo dedicado | `monitoring-observability` general |
| Módulos nativos muy custom (RN) | Requiere experiencia fuera de skill | Dev build documentado, no exhaustivo |
| Monorepo mobile + web | No hay plantilla unificada | `harness-template` por topología |

### Conclusión mobile

**Sí:** para proyectos **cross-platform Flutter o Expo/RN de escala media**, la suite actual es **suficiente** para guiar arquitectura, features, tests, deploy y harness del agente.

**No al mismo nivel:** apps **nativas puras** o **enterprise mobile** con compliance/nativos profundos — ahí v4 debería añadir skills nativas o ampliar E2E/observabilidad mobile.

---

## Análisis de datos — ¿necesitamos Python?

### Tipos de proyecto “datos”

| Tipo | Ejemplos | ¿v3.4 suficiente? |
|------|----------|-------------------|
| **A. Producto con dashboards** | SaaS con gráficos, KPIs en web/mobile | **Sí** (Next/Laravel + API) |
| **B. ETL / pipelines batch** | Ingesta, limpieza, warehouse | **No** — falta Python/data-engineering |
| **C. Análisis exploratorio** | Jupyter, pandas, notebooks | **No** — sin skill Python |
| **D. ML / IA en producción** | entrenamiento, inferencia, features | **No** — Python casi obligatorio |
| **E. BI embebido** | Metabase, Looker, Power BI | **Parcial** — integración sí, modelado BI no |

### Qué hay hoy relacionado con datos

| Artefacto | Cobertura |
|-----------|-----------|
| `software-project-analysis` | Recomienda FastAPI/Python para ML/IA (texto, no skill) |
| `database-design` | Modelado SQL, índices — no notebooks |
| `nextjs-fullstack` / `laravel-backend` | APIs que **sirven** datos a UI |
| `testing-strategy` | Menciona `pytest` en tabla, sin `unit-python.md` |
| Skill Python | **No existe** |

### Veredicto datos

| Pregunta | Respuesta |
|----------|-----------|
| ¿Necesitamos Python para **proyectos de análisis de datos** (B, C, D)? | **Sí** — la suite v3.4 **no** cubre el workflow pandas/Jupyter/ML |
| ¿Necesitamos Python para **mostrar analytics en una app web/mobile** (A)? | **No obligatorio** — Laravel/Next + charting bastan |
| ¿Cuándo planificar Python en v4? | Cuando haya **≥1 proyecto/año** en ETL, notebooks o ML |

### Recomendación v4 (datos)

Prioridad **P0** no solo `fastapi-backend` sino evaluar skill dedicada:

- **`data-analysis-python`** — pandas, Jupyter, visualización, calidad de datos; **o**
- **`fastapi-backend`** + references de ML si el foco es servir modelos, no exploración

Separar **API Python** de **análisis exploratorio** evita mezclar protocolos de notebook con REST.

---

## Matriz resumen

| Necesidad del estudio | v3.4 | v4 recomendado |
|-----------------------|------|----------------|
| App Flutter/RN escala media | ✅ | Mantenimiento |
| App nativa iOS/Android only | ⚠️ | Swift/Kotlin skills |
| Dashboard SaaS con métricas | ✅ | — |
| ETL / notebooks / ML | ❌ | Python P0 |
| Microservicios Go | ❌ | Go P1 |

---

## Siguiente paso sugerido

1. Si el pipeline comercial incluye **datos** → abrir RFC v4.0 con **FastAPI + data-analysis-python**.
2. Si solo **mobile media** → **no bloquea v4**; invertir en LEARNINGS mobile reales y opcional E2E Maestro en `testing-strategy`.

Ver [roadmap-v4-languages.md](roadmap-v4-languages.md).
