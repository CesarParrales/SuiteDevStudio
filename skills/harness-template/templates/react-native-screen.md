# React Native Screen — Harness Template

Bundle feedforward + feedback para una **pantalla nueva** en app Expo (Expo Router, TypeScript).

## Cuándo usar

- Nueva ruta en `app/` o `src/app/`
- Pantalla con navegación, fetch API y estados loading/error/empty
- El usuario pide "pantalla RN", "screen Expo", "ruta en la app"

## Skills a activar (en orden)

| Orden | Skill | Rol |
|-------|-------|-----|
| 1 | `harness-template` | Este bundle |
| 2 | `mobile-react-native` | Expo Router, state/API, UI nativa |
| 3 | `react-patterns` | Hooks, composición, estado local |
| 4 | `karpathy-guidelines` | Checkpoints, escalación |
| 5 | `testing-strategy` | Testing Library / Jest |
| 6 | `comprobacion-produccion` | Post-implementación |

Opcional: `ui-mobile-native` (HIG/Material), `performance-web` (listas largas — patrones aplicables).

## Archivos feedforward

| Archivo | Contenido |
|---------|-----------|
| `.cursor/project-memory.md` | `EXPO_PUBLIC_API_URL`, `npm test`, perfil EAS |
| `AGENTS.md` | Estructura `app/`, convenciones de screens |
| `eas.json` | Perfiles si afecta build |

## Definition of Done

```bash
npx expo-doctor
npm run type-check    # si existe en package.json
npm test              # componentes/hooks con lógica
# Manual: navegar a la ruta en simulador o dev build
```

Gate: doctor sin issues bloqueantes; tests de la screen/hook en verde; estados loading, error y empty implementados si hay fetch async.

## Flujo recomendado

1. **AC** — flujo de usuario y estados de UI
2. **Ruta** — archivo en `app/<grupo>/<screen>.tsx` (`mobile-react-native` → navigation)
3. **RED:** test de hook o componente que falla
4. **Screen** — layout + fetch (`references/state-api.md`)
5. **Estados** — loading / error / empty / success
6. **GREEN** + type-check
7. **Checkpoint** >5 archivos
8. **Post-impl:** `comprobacion-produccion` §0

## Anti-patrones

- Fetch en cada render sin cache (usar React Query / patrón del proyecto)
- Pantalla sin `SafeAreaView` o equivalente
- Hardcode de API URL (usar `EXPO_PUBLIC_*`)
- Navegación imperativa cuando basta Expo Router declarativo

## Escalación

- Módulo nativo nuevo no documentado → evaluar dev build antes de implementar
- Mismo test falla 2 veces → escalación
