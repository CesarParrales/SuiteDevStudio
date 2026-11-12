# Auditoría de valor de tests (test audit)

Barrido del repo para encontrar tests que **cuestan más de lo que protegen**, con
evidencia por candidato. Optimiza confianza, no cantidad de borrado: pocos
candidatos bien evidenciados valen más que una lista especulativa, y "ninguno"
es un resultado válido.

**Modo:** descubrimiento e informe son de solo lectura. Solo se edita un lote
aprobado explícitamente por el usuario. Un lote por frontera de código (owner),
un PR por lote.

## La barra de valor (para tests nuevos y existentes)

Un test se escribe o se conserva solo con las cuatro respuestas; si falta
alguna, extender un test existente o descartar:

1. ¿Qué comportamiento observable, invariante o contrato independiente protege?
2. ¿Qué regresión creíble lo haría fallar?
3. ¿Por qué la cobertura existente no detecta ya esa regresión? (preferir añadir
   una fila a un test tabular o fixture compartido antes que un casi-duplicado)
4. ¿Necesita un seam de producción (export, flag, wrapper) que ningún caller real
   usa? Si sí, testear en la frontera real.

Un test que se rompe con un refactor que preserva comportamiento asserta
implementación: reescribirlo en la frontera dueña, salvo que el output exacto
sea el contrato declarado (goldens, formatos de wire).

## Pre-filtro mecánico

Shortlist antes de leer nada con el modelo (ajustar patrones al stack):

```bash
FILES=$(git ls-files | grep -E '(^|/)(tests?|spec|__tests__)/|\.(test|spec)\.[jt]sx?$|Test\.php$|_test\.(go|py)$')
# Sin aserciones (sondas de cobertura)
echo "$FILES" | xargs grep -L -E 'expect|assert|should|->toBe|refute' 2>/dev/null | sed 's/^/SIN_ASERCION:/'
# Greps de fuente presentados como test (leen el .ts/.php y buscan strings)
echo "$FILES" | xargs grep -l -E 'file_get_contents\([^)]*\.(php|ts|js)|readFileSync\([^)]*\.(ts|js)|toContain\(.(import|export|function)' 2>/dev/null | sed 's/^/GREP_FUENTE:/'
# Casi-duplicados por checksum normalizado
printf '%s\n' $FILES | while read -r f; do printf '%s %s\n' "$(tr -d '[:space:]' < "$f" | cksum | cut -d' ' -f1)" "$f"; done | sort | awk '$1==p{print "DUPLICADO:", pf, $2} {p=$1; pf=$2}'
```

Una línea del shortlist es una pista, no un veredicto: un grep de fuente puede
ser el contrato declarado que la barra de retención conserva.

## Catálogo de bajo valor

- Sondas sin aserciones (solo suben cobertura).
- Auto-comparaciones e identidades (`expect(x).toEqual(x)`).
- Fixtures, inventarios o listas de exports copiados y comparados consigo mismos.
- Greps de fuente/imports/strings que no son contrato declarado.
- Tests de predicados privados duplicados en una frontera real.
- Invocaciones duplicadas del mismo contrato.
- Replays por-caller de los tests de un helper compartido.
- Tests cuyo único propósito es mantener vivo un export/global solo-test.
- Código de producción cuyos únicos callers son tests.

## Barra de retención

Conservar el test que hace cumplir de forma independiente un contrato de API
pública, protocolo, config, migración, storage, seguridad, default, output
generado, paquete o arquitectura. **Lento o estático no es motivo de borrado.**
Nunca retirar nada alcanzable desde el entrypoint del paquete
(`package.json` exports/main, re-exports de index, rutas registradas).

**Contra-regla "nightly no es borrar":** sacar un test del gate de merge (moverlo
a nightly, skip "temporal", filtro de suite) sin tarjeta de evidencia es la misma
decisión que retirarlo — el contrato deja de proteger los merges. Para pagos,
migraciones, auth y storage, la tarjeta y el lote aprobado van **antes** de
moverlos; la velocidad se recupera primero con paralelización, sharding o BD
prelevantada (ver § Velocidad del SKILL.md), que no degradan el gate.

## Tarjeta de evidencia (obligatoria antes de tocar nada)

Por candidato a retirar, completa o el candidato no está listo:

| Campo | Contenido |
|-------|-----------|
| `test` | Ruta y nombre |
| `detecta` | Qué regresión detectaba (o por qué ninguna) |
| `callers_no_test` | Resultado del grep de callers fuera de tests (comando incluido) |
| `prueba_mas_fuerte` | Qué test/gate existente cubre lo mismo mejor |
| `historia` | `git log --follow --format='%h %s' -- <test>` — por qué existe |
| `desbloquea` | Exports/wrappers solo-test que se pueden borrar con él |
| `validacion` | Comando de la suite que debe pasar tras el retiro |

Veredictos: `retirar` · `reescribir` (en la frontera dueña) · `extender`
(plegarlo en una tabla/fixture existente) · `retener` (con el contrato que guarda).

## Aplicar un lote aprobado

1. Solo las ediciones aprobadas. Borrar también los exports/wrappers solo-test
   que el lote desbloquea, sin dejar alias.
2. Código de producción se retira solo si typecheck/build del repo pasan sin él
   (worktree aparte); el grep solo no basta.
3. Correr los tests del owner y vecinos con el runner del repo.
4. Reportar LOC de producción y de test por separado.

---

Destilado de `/test-audit` de [gstack](https://github.com/garrytan/gstack)
(MIT, Garry Tan), adaptado al protocolo y stacks de Suite Dev Studio.

`last_updated: 2026-11-12` · `revisar_cada: 90 días`
