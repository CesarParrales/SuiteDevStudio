# Evaluación security-audit-skill → Suite Dev

**Fecha:** 2026-10-06 · **Decisión:** tres reglas en `security-checklist`. No se instala el skill.

## Origen

[cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) (MIT). Auditoría en fases con cazadores aislados, ledger JSON, schema y validadores Node. Sirve para descubrir vulnerabilidades en un repo. No sustituye la guía de cómo construir auth, secrets y CORS.

## Qué ya cubría la suite

`security-checklist` (OWASP, auth, headers, informe) y `supply-chain-security` (dependencias, lockfile, incidentes).

## Qué se integró

| Regla | Dónde |
|-------|--------|
| Veredictos `confirmado` / `necesita_validacion` / `rechazado`. Severidad solo si hay frontera cruzada. Un CVE solo del CLI no bloquea. | `security-checklist/references/audit.md` |
| Quien encuentra no confirma, en auditoría del repo | mismo archivo + protocolo del `SKILL.md` |
| Ledger corto de superficies, no `coverage-ledger.json` | plantilla del informe |

## Qué no se integró

Los catálogos de ataque, los validadores `.cjs`, el sandbox de descriptores de archivo y la flota de subagentes. Sin ese sandbox, el propio skill de Cloudflare deja el hallazgo en validación pendiente. La suite no ejecuta el código del objetivo contra producción.
