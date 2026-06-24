# FB-3 en CI (sensor computacional)

Validar que artefactos de feedback para el agente cumplen el formato antes de publicarlos en PR o reenviarlos al chat.

## Script

Ruta en la skill instalada: `comprobacion-produccion/scripts/validate-fb3.sh`

```bash
chmod +x .cursor/skills/comprobacion-produccion/scripts/validate-fb3.sh
.cursor/skills/comprobacion-produccion/scripts/validate-fb3.sh --strict feedback/ci-failures.txt
```

## Fixture de ejemplo (válido)

Guardar como `feedback/ci-failures.txt` en el repo o generar en el job:

```text
Categoría: test
Ubicación: src/orders/orders.service.spec.ts:28
Esperado: create() lanza si quantity <= 0
Actual: el test pasa con quantity 0
Acción sugerida: añadir expect(...).rejects y validación en DTO
```

## GitHub Actions (fragmento)

```yaml
  validate-fb3:
    runs-on: ubuntu-latest
    if: hashFiles('feedback/ci-failures.txt') != ''
    steps:
      - uses: actions/checkout@v4
      - name: Validar formato FB-3
        run: |
          chmod +x .cursor/skills/comprobacion-produccion/scripts/validate-fb3.sh
          .cursor/skills/comprobacion-produccion/scripts/validate-fb3.sh --strict feedback/ci-failures.txt
```

Requisito: instalar skills en el repo (`install-local.sh --project .`) o copiar solo el script al pipeline.

## Cuándo usar en CI

- Jobs que reformatean salida de tests para el agente (Bot, review automático)
- PRs que adjuntan `feedback/*.txt` como artefacto de revisión
- No sustituye ejecutar tests — solo valida el **formato** del informe
