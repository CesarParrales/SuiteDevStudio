# Behaviour Harness — Criterios de aceptación y fixtures aprobados

Cierra la brecha del **behaviour harness** (Fowler): no confiar solo en tests generados por el agente. Los humanos fijan criterios verificables y fixtures de referencia antes o junto a la implementación.

## Flujo obligatorio para features con lógica de negocio

```
1. Criterios de aceptación (Given/When/Then) → acordados o escritos por el agente, validados por humano si el riesgo es alto
2. RED: test que falla (unit o feature) derivado de los criterios
3. Implementación mínima
4. GREEN: suite relevante exit 0
5. Post-impl: comprobacion-produccion §0
```

No marcar feature como hecha con solo tests escritos después del código si la política del proyecto es test-first.

## Criterios de aceptación (plantilla)

```markdown
## [FEAT-XX] <nombre>

### AC-01 <título>
- **Given** <estado inicial>
- **When** <acción>
- **Then** <resultado observable>
- **Test:** `tests/.../XTest.php` → `it('...')` / `test('...')`

### AC-02 ...
```

Cada AC debe mapear a **al menos un test** con nombre legible. Si no hay test, el AC no está cubierto.

## Approved fixtures (patrón)

Para datos de prueba que definen el contrato del dominio:

1. **Fixture aprobado** vive en `tests/Fixtures/` o factories con estados nombrados (`User::factory()->admin()`).
2. El agente **no inventa** estructuras JSON de API en tests sin alinear con el fixture o el FormRequest real.
3. Cambios al fixture pasan por el mismo review que el código de producción.
4. En integración/E2E, preferir factories + estados sobre datos hardcodeados frágiles.

### Ejemplo Laravel (Pest)

```php
// tests/Fixtures/orders.php — datos de referencia aprobados
return [
    'valid_order' => ['product_id' => 1, 'quantity' => 2],
    'invalid_quantity' => ['product_id' => 1, 'quantity' => 0],
];

// tests/Feature/OrderTest.php
it('rejects zero quantity', function () {
    $payload = require __DIR__ . '/../Fixtures/orders.php';
    $this->postJson('/api/v1/orders', $payload['invalid_quantity'])
        ->assertUnprocessable();
});
```

### Ejemplo JS (Vitest)

```ts
// tests/fixtures/order.ts
export const validOrder = { productId: '1', quantity: 2 };
export const invalidQuantity = { productId: '1', quantity: 0 };
```

## Qué no sustituye el behaviour harness

| Enfoque | Límite |
|---------|--------|
| Solo cobertura de líneas | Tests vacíos o que no assertan comportamiento |
| Solo tests generados por el agente | Pueden codificar bugs o suposiciones incorrectas |
| Solo E2E | Lento; no reemplaza unit en edge cases |

Combinar: **AC explícitos** + **fixtures aprobados** + **mutation score** en lógica crítica (ver SKILL.md § Métricas).

## Integración con harness templates

Al usar `harness-template` (ej. `laravel-api-module`), el paso 1 del flujo es escribir AC + RED antes del scaffold.

## Escalación

- AC ambiguo tras 1 aclaración → escalar (`karpathy-guidelines` §6).
- Test pasa pero AC no cubierto → gap; añadir test antes de cerrar.
- Mismo AC falla 2 veces en CI → feedback estructurado + escalar.
