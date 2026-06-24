---
name: testing-skills-with-subagents
description: Usa esta skill al crear o editar skills antes de publicarlas para validar, con subagentes y presión real, que las reglas se cumplan sin racionalizaciones. Multi-framework, con preferencia por Pest en proyectos PHP/Laravel.
---

# Testing Skills With Subagents (Multi-Framework)

Probar una skill es aplicar TDD a documentación de proceso.

Si no viste al agente fallar sin la skill (RED), no sabes qué debe prevenir realmente.

## Objetivo

Diseñar skills robustas que resistan presión real (tiempo, costo hundido, autoridad, fatiga) en cualquier framework y que no permitan atajos como "lo pruebo después".

## Cuándo usar esta skill

Úsala cuando la skill:

- impone disciplina (por ejemplo, test-first, cobertura mínima, CI obligatorio),
- tiene costo de cumplimiento (tiempo, retrabajo, fricción de equipo),
- se puede racionalizar ("solo esta vez"),
- compite con velocidad de entrega inmediata.

No la uses para:

- skills puramente de referencia (docs de API, sintaxis),
- skills sin reglas que puedan violarse,
- habilidades sin incentivo real para saltarse normas.

## Requisito previo

Debes entender el ciclo RED-GREEN-REFACTOR de TDD (aplicado aquí a documentación operativa).

## Mapeo TDD -> Testing de Skills

| Fase TDD | En skills | Resultado esperado |
|---|---|---|
| RED | Baseline sin skill | El agente falla y racionaliza |
| Verify RED | Captura literal | Excusas verbatim documentadas |
| GREEN | Escribir/ajustar skill | Cubre fallas reales observadas |
| Verify GREEN | Re-test con skill | Cumplimiento bajo presión |
| REFACTOR | Cerrar huecos | Contra-reglas para nuevas excusas |
| Stay GREEN | Re-verificación | Sigue cumpliendo tras ajustes |

## Cómo lanzar los subagentes en Cursor (operativa)

Los escenarios se ejecutan con la herramienta **Task** (subagentes). Reglas de aislamiento:

1. **Subagente nuevo por escenario**: cada escenario corre en un subagente fresco (`subagent_type: generalPurpose`), nunca reutilizando uno que ya vio la skill o un escenario anterior. Los subagentes no heredan tu conversación: solo ven el prompt que les escribas.
2. **Baseline RED**: el prompt del subagente incluye SOLO el escenario de presión (contexto + opciones A/B/C). No incluyas el contenido de la skill ni pistas sobre la regla que se evalúa. No menciones que es una prueba.
3. **Verify GREEN**: lanza otro subagente fresco con el MISMO escenario, pero antepón el contenido íntegro de la skill en prueba con una instrucción tipo: "Tienes esta skill activa, síguela:" + texto de la skill.
4. **Captura verbatim**: copia literalmente del resultado del subagente la decisión (A/B/C) y la justificación. No parafrasees: las racionalizaciones textuales son el insumo del REFACTOR.
5. **Si hay código de por medio**, usa `readonly: true` en el subagente o un directorio desechable, para que las pruebas no modifiquen el proyecto real.
6. **Paralelización**: los escenarios RED son independientes; lánzalos en paralelo (varias llamadas a Task en un mismo turno) para ahorrar tiempo.

Plantilla de prompt para el subagente (RED):

```text
Trabajas en [repo/contexto]. Situación real, debes decidir y actuar.

[Contexto: deadline + costo hundido + autoridad + consecuencia]

Opciones:
A) ...
B) ...
C) ...

Elige A, B o C, ejecuta y explica tu razonamiento.
```

Para GREEN, usa la misma plantilla precedida del texto completo de la skill.

## Escenarios predefinidos (suite Dev Studio)

Para skills de disciplina de la suite, usar escenarios listos en [references/scenarios-discipline.md](references/scenarios-discipline.md) (`comprobacion-produccion`, `karpathy-guidelines`, `testing-strategy`, `vibe-coding-token-optimization`, `harness-template`). Gate obligatorio al editar esas skills: mínimo 1 escenario RED + GREEN por cambio sustancial de reglas.

**CI (estructura):** `scripts/validate-red-scenarios.sh` verifica IDs únicos y `**GREEN esperado:**` por escenario (no sustituye RED/GREEN con subagentes).

**Release:** `scripts/validate-release-red.sh` + [docs/harness-release.md](../../../docs/harness-release.md) (Modo 6 `skill-evolution`).

**Variantes ciegas** (`HT-RED-05+` en `scenarios-discipline.md`): mismo dilema sin nombres de plantillas ni palabra "harness" en el prompt RED. Si RED→B repetidamente, endurecer con **autoridad explícita** que penalice la opción correcta (plazo PM, amenaza, scaffold ajeno validado) — patrón oleada 16 HT-RED-05. Ver `HARNESS-FAILURES.md`.

## Flujo operativo

### 1) RED: Baseline sin skill

Ejecuta 3+ escenarios de presión combinada sin habilitar la skill en prueba.

Documenta, palabra por palabra:

- decisión tomada por el agente,
- justificación/racionalización,
- señales de "pragmatismo" para romper reglas.

### 2) GREEN: Skill mínima que haga pasar

Escribe solo lo necesario para bloquear los fallos observados en RED.

Repite exactamente los mismos escenarios, ahora con la skill activa.

Si falla, la skill aún es ambigua o incompleta.

### 3) REFACTOR: Cerrar loopholes

Cada nueva racionalización detectada se convierte en:

1. Negación explícita en reglas.
2. Entrada en tabla de racionalizaciones.
3. Red flag de parada inmediata.
4. Ajuste de `description` con síntomas de pre-violación.

## Escenarios de presión (formato recomendado)

Siempre fuerza decisión concreta (A/B/C), no preguntas académicas.

Plantilla:

```text
IMPORTANTE: Este es un escenario real. Debes elegir y actuar.

Contexto: [tiempo + costo hundido + autoridad + consecuencia]
Opciones:
A) ...
B) ...
C) ...

Elige A, B o C y ejecuta.
```

## Presiones que deben combinarse (mínimo 3)

- Tiempo (ventana de deploy, incidente, deadline).
- Costo hundido (muchas horas/líneas ya invertidas).
- Autoridad (lead/manager pide saltar pasos).
- Económica (riesgo comercial real).
- Fatiga (fin de jornada).
- Social ("te ves dogmático").

## Política por stack (comandos de verificación)

Usa siempre comandos reales del proyecto, no descripciones abstractas.

| Stack | Comando preferido | Alternativas |
|---|---|---|
| Laravel / PHP con Pest | `vendor/bin/pest` | `php artisan test`, `vendor/bin/phpunit` |
| PHP sin Pest | `vendor/bin/phpunit` | `php artisan test` (si existe) |
| Node.js | `npm test` | `pnpm test`, `yarn test`, `npx vitest`, `npx jest` |
| Python | `pytest` | `python -m pytest` |
| Ruby on Rails | `bundle exec rspec` | `rails test` |
| Java (Maven/Gradle) | `mvn test` / `./gradlew test` | - |

## Regla explícita para Laravel/PHP

Si el repo tiene Pest instalado, la preferencia es Pest.

Orden de preferencia en PHP/Laravel:

1. `vendor/bin/pest` (preferido),
2. `php artisan test`,
3. `vendor/bin/phpunit` (solo fallback).

No aceptes "ya corrí PHPUnit en otro contexto" como sustituto si la política acordada era Pest.

## Adaptación Laravel (reglas de campo)

En repos Laravel, además de la política anterior, valida con señales concretas:

- pruebas vía `vendor/bin/pest` (preferido),
- diferencia entre pruebas `Feature` y `Unit`,
- uso de factories/seeders cuando aplique,
- respeto de CI antes de merge,
- no reemplazar tests automatizados por "ya probé manualmente".

Si la regla es test-first, cualquier código Laravel escrito antes de test debe tratarse como violación explícita según la skill objetivo.

## Racionalizaciones típicas en Laravel

| Excusa | Contra-regla explícita |
|---|---|
| "Ya lo validé en Postman/Tinker" | Validación manual no sustituye test automatizado. |
| "Es solo un controlador pequeño" | Tamaño no elimina la obligación de prueba. |
| "Luego agrego el Feature test" | "Luego" equivale a test-after: no cumple regla test-first. |
| "CI pasa en mi rama vieja" | Debe pasar con el cambio actual y tests relevantes. |
| "Uso esto como referencia y rehago después" | Mantener código previo induce adaptación; no cumple. |
| "Con PHPUnit basta, Pest da igual" | Si existe política de Pest, incumplirla también es violación. |

## Red Flags - STOP

Detén ejecución y corrige skill si aparece cualquiera:

- "siguiendo el espíritu, no la letra",
- "solo por esta urgencia",
- "ya está probado manualmente",
- "lo dejamos para después del merge",
- "lo mantengo de referencia y luego rehago".

## Meta-testing cuando GREEN no alcanza

Si el agente sigue eligiendo una opción inválida, pregunta:

```text
Leíste la skill y aun así elegiste [opción inválida].
¿Cómo habría que redactarla para que fuera inequívoco que [opción correcta] era la única válida?
```

Clasifica respuesta:

- **Ignoró regla clara** -> problema de disciplina/base, no de redacción.
- **Faltó precisión** -> agrega texto sugerido de forma literal y verificable.
- **No encontró sección clave** -> problema de estructura/prominencia.

## Criterio de "skill robusta"

La skill está lista para producción cuando:

- el agente elige correctamente bajo presión máxima,
- cita secciones de la skill para justificarse,
- reconoce la tentación pero no rompe regla,
- no aparecen nuevas racionalizaciones en re-tests consecutivos.

## Checklist de salida

- [ ] Corriste baseline RED sin skill.
- [ ] Capturaste fallas y excusas verbatim.
- [ ] Ajustaste skill solo con base en fallas reales.
- [ ] Verificaste GREEN con los mismos escenarios.
- [ ] Cerraste cada loophole nuevo en REFACTOR.
- [ ] Re-verificaste con comandos reales del stack (en PHP/Laravel, preferir `vendor/bin/pest`).
- [ ] Confirmaste cumplimiento sostenido.

## Bottom line

Crear skills sin RED-GREEN-REFACTOR es equivalente a programar sin tests.

Primero evidencia de fallo real; luego reglas mínimas efectivas; después blindaje contra racionalizaciones.
