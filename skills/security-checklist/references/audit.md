# Auditoría de Seguridad — Workflow Completo

Workflow para auditar una aplicación existente de punta a punta y emitir un
informe accionable. Para secrets y variables de entorno ver `secrets-env.md`;
para detalle de cada vulnerabilidad ver `owasp.md`.

---

## Workflow de Auditoría

```
PASO 1 — Escanear el repo (automático)
  → npm audit --audit-level=high  /  composer audit
  → SAST (Semgrep) + escáner de secrets (gitleaks/trufflehog)
  → Listar CVEs. Exit != 0 no es Critical automático: veredicto en
    la sección Veredictos (CLI fuera del runtime no bloquea)

PASO 2 — Checklist por categoría OWASP (manual, ver abajo)
  → Recorrer cada categoría con el checklist manual
  → Apoyarse en owasp.md para el detalle de cada vulnerabilidad

PASO 3 — Clasificar hallazgos
  → Cada hallazgo recibe ID, severidad y evidencia (ver criterios abajo)

PASO 4 — Emitir el informe
  → Usar la plantilla con IDs del final de este archivo
  → Critical/High bloquean deploy; Medium/Low van al backlog con fecha
```

---

## Paso 1 — Herramientas de Escaneo

### Auditoría de dependencias (obligatoria, primera siempre)

```bash
# Node
npm audit --audit-level=high
# Exit != 0 → listar CVEs. Veredicto aparte: CLI fuera del runtime no bloquea.

# PHP
composer audit
composer audit --format=json | jq '.advisories'
# Exit != 0 → listar advisories. Veredicto aparte: CLI fuera del runtime no bloquea.
```

### Herramientas de Análisis Estático

```bash
# PHP
composer require --dev enlightn/enlightn
php artisan enlightn  # 100+ checks de seguridad para Laravel

# PHP Stan + security rules
composer require --dev phpstan/phpstan psalm/plugin-security
vendor/bin/phpstan analyse

# JavaScript/TypeScript
npm install --save-dev eslint-plugin-security
# .eslintrc
{
  "plugins": ["security"],
  "extends": ["plugin:security/recommended"]
}

# Semgrep — análisis estático multi-lenguaje
pip install semgrep
semgrep --config=p/php          # reglas para PHP
semgrep --config=p/javascript   # reglas para JS
semgrep --config=p/typescript

# SAST en CI
- name: Run SAST
  run: semgrep --config=p/php --error --json > semgrep-results.json
```

### Escaneo de secrets en el historial

```bash
trufflehog git file:///path/to/repo
gitleaks detect --source . --verbose
# Cualquier secret detectado = hallazgo Critical (rotar antes de limpiar historial)
```

### Dependency Scanning en CI

```yaml
# .github/workflows/security.yml
name: Security Scan

on:
  push:
    branches: [main]
  schedule:
    - cron: '0 8 * * 1'  # Lunes 8am — escaneo semanal

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: npm audit
        run: npm audit --audit-level=high

      - name: OWASP Dependency Check
        uses: dependency-check/Dependency-Check_Action@main
        with:
          project: 'myapp'
          path: '.'
          format: 'HTML'

      - name: Semgrep SAST
        uses: semgrep/semgrep-action@v1
        with:
          config: >-
            p/typescript
            p/react
            p/owasp-top-ten

      - name: Scan for leaked secrets
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
          base: ${{ github.event.repository.default_branch }}
          head: HEAD
```

---

## Paso 2 — Checklist de Auditoría Manual (por categoría OWASP)

```
Revisión de código centrada en seguridad:

Autenticación y Autorización (A01/A07):
□ ¿Cada endpoint verifica autenticación?
□ ¿Cada endpoint verifica que el usuario tiene acceso al recurso?
□ ¿Se verifica ownership de recursos (IDOR)?
□ ¿Los admin endpoints están separados y protegidos?

Manejo de Input (A03 — Injection):
□ ¿Se valida en el servidor (no solo en frontend)?
□ ¿Todos los parámetros pasan por validación tipada?
□ ¿Los uploads verifican tipo MIME y tamaño?
□ ¿Los campos de texto largo tienen límite?

Queries de BD (A03):
□ ¿No hay SQL concatenado?
□ ¿El ORM o prepared statements en todo?
□ ¿Las queries están limitadas (no devuelven millones de rows)?

Output y Logs (A03 XSS / A09 Logging):
□ ¿Los templates escapan output (XSS)?
□ ¿Los logs no incluyen passwords/tokens/PII?
□ ¿Los errores de producción son genéricos para el usuario?

Secretos (A02/A05):
□ ¿No hay hardcoded secrets en el código?
□ ¿El .gitignore es correcto?
□ ¿Las API keys tienen los mínimos permisos necesarios?

Dependencias (A06):
□ ¿`npm audit` o `composer audit` pasa sin problemas críticos?
□ ¿Las dependencias están actualizadas?
□ ¿No hay paquetes abandonados con CVEs conocidos?

Configuración (A05):
□ ¿Headers de seguridad configurados? (ver headers-cors.md)
□ ¿CORS restrictivo?
□ ¿Modo debug desactivado en producción?
```

---

## Veredictos, verificación y cobertura

Adaptado de [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) (MIT, revisión 2026-10). No se instala ese skill ni su flota de cazadores. Una pregunta puntual ("¿es seguro este endpoint?") usa estas reglas sin abrir un informe de seis fases.

### Tres veredictos

Antes de poner Critical/High/Medium/Low, cada candidato recibe un veredicto:

| Veredicto | Cuándo | Severidad |
|-----------|--------|-----------|
| `confirmado` | Hay traza en el código (archivo:línea) y un resultado acotado: qué principal, qué recurso y qué pasa | Sí. Solo estos bloquean el deploy |
| `necesita_validacion` | Falta un hecho concreto (¿el CVE llega al proceso que corre?, ¿el header se aplica en prod?) | No. Se escribe el hecho que falta |
| `rechazado` | La hipótesis no se sostiene en el código | No |

Un hueco de checklist sin fallo de frontera es nota de hardening, no hallazgo. Si la capa A ya impide el ataque, la ausencia de la capa B no es vulnerabilidad.

Un CVE de `npm audit` o `composer audit` con exit distinto de 0 se lista siempre. Es `confirmado` solo si el paquete está en el runtime de la app y el fallo cruza una frontera. Un CVE solo del CLI (el proceso de desarrollo, no el que sirve tráfico) queda en `necesita_validacion` o en hardening. No bloquea el cierre por sí solo.

No se ejecuta el código del objetivo contra producción, ni se instalan dependencias para "probar" el fallo. Si el hecho decisivo exige correr la app y no hay un entorno aislado, el veredicto es `necesita_validacion`.

### Quién encuentra no confirma

En una auditoría del repo (no en una pregunta de una pieza), una segunda pasada relee el pedido y el código citado e intenta tumbar cada `confirmado`. No edita y no aplica el arreglo. Si no puede repetir la traza, baja el veredicto a `necesita_validacion`.

### Ledger corto

Al cerrar, una tabla de superficies tocadas. Una pasada posterior no marca como cubierto lo que no está en la lista. Si el código de una fila cambió, esa fila se reabre.

```markdown
| Superficie | Qué se miró | Estado |
|------------|-------------|--------|
| Auth login | rate limit, mensajes | cubierto @ <commit> |
| Uploads | MIME y tamaño | no mirado |
```

## Auditoría recurrente (no solo cuando alguien la pide)

Una auditoría única caduca: entran dependencias nuevas, vence un certificado, aparece un CVE. Para proyectos en producción, dejar una pasada programada (CI con `schedule`, o la app de auditoría del estudio cuando exista):

| Cadencia | Qué | Dónde |
|----------|-----|-------|
| Cada push a main | `npm audit` / `composer audit`, secret scan, SAST | CI (ver Paso 1) |
| Semanal | dependencias + revisión pasiva de URL (TLS, cabeceras, exposición) | job programado / `dast-url-review.md` |
| Mensual | incidentes de supply chain (`supply-chain-security/references/incidents-current.md`), caducidad de certificados | job programado |
| Trimestral o tras cambio de infra | auditoría de servidor con acceso | `infra-server-audit.md` |

Cada corrida es aditiva: usa la cobertura previa para apuntar a lo que cambió, no repite a ciegas.

## Paso 3 — Clasificación de Hallazgos

La severidad de abajo aplica solo a veredicto `confirmado`.

```
CRITICAL — Explotable ahora, impacto total
  Ejemplos: SQLi confirmada, secret de producción en el repo, auth bypass,
            CVE crítico en dependencia con exploit público
  Acción: bloquear deploy, arreglar HOY, rotar credenciales si aplica

HIGH — Explotable con esfuerzo moderado, impacto alto
  Ejemplos: IDOR en recursos sensibles, XSS almacenado, CVE high en deps,
            falta de rate limiting en login
  Acción: bloquear deploy a producción, arreglar esta semana

MEDIUM — Requiere condiciones específicas o impacto parcial
  Ejemplos: CORS demasiado abierto, headers de seguridad ausentes,
            mensajes de error que filtran información
  Acción: backlog con fecha comprometida (≤ 1 sprint)

LOW — Defensa en profundidad, sin vector directo
  Ejemplos: versión de framework antigua sin CVE conocido aplicable,
            cookies sin atributos óptimos en rutas no sensibles
  Acción: backlog, agrupar en tarea de hardening

Si no hay frontera cruzada, no uses estas etiquetas: va a hardening
o a necesita_validacion.
```

---

## Paso 4 — Plantilla de Informe de Auditoría

```markdown
# Informe de Auditoría de Seguridad — <proyecto>

- Fecha: YYYY-MM-DD
- Alcance: <repos/módulos auditados>
- Comandos ejecutados: npm audit --audit-level=high (exit N),
  composer audit (exit N), semgrep, gitleaks

## Resumen
| Veredicto | Cantidad |
|---|---|
| confirmado Critical | n |
| confirmado High | n |
| confirmado Medium / Low | n |
| necesita_validacion | n |
| rechazado | n |
| hardening | n |

Deploy: <APTO | BLOQUEADO>. Bloquean solo los confirmados Critical o High.

## Cobertura
| Superficie | Qué se miró | Estado |
|---|---|---|
| ... | ... | cubierto @ commit / no mirado |

## Hallazgos

### [SEC-001] <título> — confirmado — CRITICAL
- Categoría OWASP: A0X
- Ubicación: <archivo:línea o endpoint>
- Frontera: <principal, recurso, resultado>
- Evidencia: <output del comando, snippet, CVE>
- Impacto: ...
- Remediación: ...

### [SEC-002] ...

## CVEs de dependencias (de npm audit / composer audit)
| CVE/Advisory | Paquete | Severidad | Fix disponible |
|---|---|---|---|
| ... | ... | ... | ... |
```
