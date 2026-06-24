# Formato de feedback estructurado para el agente (FB-3)

Cuando un test, linter o typecheck falle, **no reenviar logs crudos**. Reformatear cada hallazgo para que el agente pueda autocorregir en un solo paso (sensor optimizado para LLM).

## Plantilla por hallazgo

```text
Categoría: [sintaxis|tipos|test|seguridad|arquitectura|runtime|config]
Ubicación: ruta/archivo:línea
Esperado: <comportamiento o regla violada>
Actual: <qué ocurrió, 1-2 frases>
Acción sugerida: <cambio concreto, no "revisar el código">
```

## Ejemplos

### Test fallido

```text
Categoría: test
Ubicación: tests/Feature/OrderTest.php:42
Esperado: POST /api/orders con quantity=0 devuelve 422
Actual: devuelve 201 y crea la orden
Acción sugerida: añadir validación `quantity` min:1 en StoreOrderRequest y assert 422 en el test
```

### Linter / tipos

```text
Categoría: tipos
Ubicación: src/services/kpi.ts:18
Esperado: retorno tipado como `KpiResult[]`
Actual: `any` implícito en el map
Acción sugerida: tipar el callback del map o añadir tipo de retorno explícito a `computeKpis`
```

### Seguridad

```text
Categoría: seguridad
Ubicación: routes/api.php:34
Esperado: ruta mutante con auth:sanctum
Actual: Route::post sin middleware de autenticación
Acción sugerida: agrupar bajo middleware auth:sanctum o documentar por qué es pública
```

## Reglas de uso

1. **Un hallazgo = un bloque**; si hay 5 errores, 5 bloques (no un dump de 200 líneas).
2. **Acción sugerida** debe ser ejecutable sin reinterpretar el log.
3. Si el mismo hallazgo reaparece tras 2 intentos de corrección → **escalar** (ver `karpathy-guidelines` §6 Escalación).
4. Tras corregir, volver a ejecutar el mismo comando y reportar solo lo que siga fallando.
5. **Validar formato** antes de pegar al agente o adjuntar a informe:

```bash
# Desde la skill instalada (ruta puede variar):
bash skills/comprobacion-produccion/scripts/validate-fb3.sh informe-fb3.txt
bash skills/comprobacion-produccion/scripts/validate-fb3.sh --strict informe-fb3.txt
```

En CI (opcional): fallar el job si el artefacto de feedback no pasa el script.

## Comandos típicos por stack

| Stack | Comando | Qué capturar |
|-------|---------|--------------|
| Laravel + Pest | `vendor/bin/pest --compact` | nombre del test, assertion, línea |
| Laravel | `php artisan test` | idem |
| Node/Vitest | `npm test` / `npx vitest run` | archivo, test name, diff |
| TypeScript | `npx tsc --noEmit` | archivo, código de error TS |
| ESLint | `npm run lint` | regla, archivo, línea |
