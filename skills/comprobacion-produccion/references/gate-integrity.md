# Integridad de gates — catálogo de relajaciones

Un *gate* es cualquier control que convierte un fallo en señal visible: un test,
un umbral de CI, un linter, un snapshot, un timeout. Este catálogo cubre el
patrón inverso: el cambio que **silencia el fallo en lugar de corregir la causa**.

## Las tres capas (la decisión es humana)

1. **Inventariar** — listar todo hunk del diff que toca un test, config de CI,
   runner, lint, snapshot o umbral. Inventario, nunca hallazgo.
2. **Leer** — para cada hunk inventariado que relaja algo, una sola pregunta:
   *¿esta relajación silencia el fallo que el gate debía detectar, o está
   justificada por una medición o decisión visible en este diff?*
3. **Hallazgo** — el hunk que no supera la pregunta. **Un hallazgo = una
   decisión humana explícita** (restaurar el gate, mantener con justificación
   escrita, o dejar abierto para revisión). El agente inventaría y lee; nunca
   decide solo mantener un gate debilitado.

Regla de salida: el PR o informe lleva una línea `Gates editados:` con cada
relajación mantenida y su motivo. Sin esa línea, un gate debilitado viaja
invisible dentro de un diff verde.

## Catálogo

| ID | Patrón | Señales en el diff |
|----|--------|--------------------|
| GI-1 | Test eliminado o desactivado en lugar de arreglar el código | `test(`/`it(`/`def test_` borrados; `.skip`, `.only`, `xit`, `xdescribe`, `@pytest.mark.skip`, `#[ignore]`, `@Disabled` añadidos |
| GI-2 | Prueba inflada: un mock/stub presentado como verificación real ("validado contra producción" cuando respondió un stub) | sin señal mecánica — leer la prosa del cierre y nombrar el tipo de evidencia real |
| GI-3 | Snapshot/golden regenerado sin cambio en el test que lo posee | `*.snap`, `*.golden`, `__snapshots__/` cambian y su test dueño no tiene hunk |
| GI-4 | Placeholder entregado como terminado | `todo!()`, `NotImplementedError`, `throw new Error("not implemented")` en código de producto |
| GI-5 | Test tautológico: no puede fallar (asserta su propio setup, espeja la implementación, no rechaza nada) | sin señal mecánica — leerlo junto a los hunks tagueados |
| GI-6 | Código de producto que husmea el entorno de test | `process.env.CI`, `NODE_ENV === 'test'`, `APP_ENV === 'testing'` en rutas de producto |
| GI-7 | Pragma de supresión en lugar de satisfacer el checker | `eslint-disable`, `@ts-ignore`, `# noqa`, `#[allow(`, `@SuppressWarnings` |
| GI-8 | Bypass del pipeline | `[skip ci]`, `continue-on-error: true`, `allow_failure: true`, `--no-verify` |
| GI-9 | Valor del gate relajado: timeout/retry/tolerancia **suben**, umbral/cobertura **bajan**, assert exacto → cota (`toBe(3)` → `toBeGreaterThan(0)`) | comparar dirección del cambio numérico dentro del hunk |
| GI-10 | Excepción tragada | `catch {}`, `except: pass`, `rescue nil` añadidos en código de producto |
| GI-11 | Verde sin ejecución: exit 0 con 0 tests corridos ("No tests found", `0 passed`, selección vacía tras un filtro) | leer la línea resumen del runner, no solo el exit code; reportar `tests ejecutados: N` |

## Barrido mecánico del diff

Contra la base del PR (ajustar `main` si procede):

```bash
BASE=$(git merge-base HEAD origin/main)
git diff "$BASE" -- '*test*' '*spec*' '.github/' '*.snap' \
  | grep -nE '^\+.*(\.skip|\.only|xit\(|xdescribe|pytest\.mark\.skip|@Disabled)' \
  ; git diff "$BASE" | grep -nE '^\+.*(eslint-disable|@ts-ignore|ts-expect-error|# noqa|#\[allow\(|nolint|SuppressWarnings)' \
  ; git diff "$BASE" | grep -nE '^\+.*(\[skip ci\]|continue-on-error: true|allow_failure: true|--no-verify)' \
  ; git diff "$BASE" | grep -nE '^\+.*(catch \{\}|catch \(e\) \{\}|except: pass|rescue nil)' \
  ; git diff "$BASE" --stat | grep -E '\.(snap|golden)'
```

El grep **taguea, no juzga**: un test borrado junto a su código fuente borrado es
inventario, no hallazgo. GI-2, GI-5 y GI-9 no tienen grep fiable — se leen.

## Contra-reglas (racionalizaciones conocidas)

| Excusa | Contra-regla |
|--------|--------------|
| "El test es flaky, lo skipeo y sigo" | Skip = GI-1. Arreglar o abrir hallazgo con dueño; nunca skip silencioso en el mismo PR que lo descubre. |
| "Subo el timeout, en CI va lento" | GI-9 exige medición citada en el diff o commit. Sin medición → hallazgo. |
| "El snapshot nuevo se ve bien" | Aceptar output ≠ testearlo (GI-3). El test dueño debe cambiar o el humano aprueba explícitamente. |
| "Nunca bajes un umbral, subas un retry ni skipees un caso para conseguir un pass" | Medir primero, arreglar después; el gate se mueve solo con evidencia. |

---

Destilado de `/review` Gate Integrity y `/ship` de [gstack](https://github.com/garrytan/gstack)
(MIT, Garry Tan). Ids y redacción propios de Suite Dev Studio; la táctica
"el nombre del patrón es el disuasorio" se conserva.

`last_updated: 2026-11-12` · `revisar_cada: 90 días`
