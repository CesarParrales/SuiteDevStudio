# Flutter Feature — Harness Template

Bundle feedforward + feedback para una **feature nueva** en app Flutter (feature-first, Riverpod, GoRouter).

## Cuándo usar

- Nueva pantalla/flujo en app existente (`lib/features/<nombre>/`)
- Feature con dominio, providers, UI y llamadas API
- El usuario pide "feature Flutter", "pantalla en la app", "módulo Riverpod"

## Skills a activar (en orden)

| Orden | Skill | Rol |
|-------|-------|-----|
| 1 | `harness-template` | Este bundle |
| 2 | `mobile-flutter` | Arquitectura feature-first, Riverpod, GoRouter |
| 3 | `karpathy-guidelines` | Checkpoints, escalación |
| 4 | `testing-strategy` | Unit/widget tests + behaviour harness |
| 5 | `comprobacion-produccion` | Post-implementación |

Opcional: `ui-mobile-native` (HIG/Material), `api-design` (contratos API).

## Archivos feedforward

| Archivo | Contenido |
|---------|-----------|
| `.cursor/project-memory.md` | `flutter analyze`, `flutter test`, flavor activo |
| `AGENTS.md` | Mapa del repo (plantilla: `suite-dev-studio/templates/AGENTS.md`) |
| `lib/features/` | Una carpeta por feature; no mezclar dominios |

## Definition of Done

```bash
flutter analyze          # 0 issues
flutter test             # exit 0
flutter test test/features/<feature>/   # si tests aislados por feature
# Opcional CI:
dart format --set-exit-if-changed lib test
```

Gate: analyze limpio; tests de la feature en verde; ruta registrada en GoRouter si aplica.

## Flujo recomendado

1. **AC** → `testing-strategy/references/behaviour-harness.md`
2. **Estructura** → `lib/features/<x>/{data,domain,presentation}/` (`mobile-flutter`)
3. **RED:** test de provider o widget que falla
4. **Implementar** modelos (Freezed) → repository → provider → screen
5. **Registrar ruta** en GoRouter
6. **GREEN** + `flutter analyze`
7. **Checkpoint** >5 archivos / >300 líneas
8. **Post-impl:** `comprobacion-produccion` §0

## Anti-patrones

- Lógica de negocio en widgets
- `setState` donde basta Riverpod
- API calls directas desde `build()`
- Feature sin test de provider en lógica no trivial

## Escalación

- Cambios en contrato API sin spec → escalar
- Mismo test falla 2 veces → FB-3 + `karpathy-guidelines` §6
