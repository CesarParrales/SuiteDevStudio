# Plataforma de auditoría y monitoreo — Tareas

**Fecha:** 2026-10-06 · **Estado:** borrador, ejecutar solo tras aprobar requisitos y diseño. Orden por dependencia (no empezar una ola sin la anterior).

## Ola 0 — Fundaciones (bloquea todo)
- [ ] T0.1 Crear repo dedicado + bootstrap del harness (`install-local.sh --project <repo> --bootstrap`).
- [ ] T0.2 Modelo de datos núcleo: `targets` (con tipo), `authorizations`, `contracts`, `scan_jobs`, `findings`, `audit_log` (AC-01, AC-03, AC-40).
- [ ] T0.3 RBAC (operador/revisor/lector) + bitácora inmutable (NF-02).
- [ ] T0.4 Puerta de autorización por tipo: propio=preaprobación, cliente=contrato firmado, research=autorización del dueño; allowlist de alcance (AC-01..AC-04, AC-45).

## Ola 1 — Monitoreo pasivo (valor temprano, sin capacidad ofensiva)
- [ ] T1.1 Inventario de objetivos (tipo, entorno, responsable) + `/health` (AC-10).
- [ ] T1.2 Agente residente (Go): telemetría saliente cifrada de accesos/llaves/admin/salud; alta y clave por host; alerta si pierde contacto (AC-11, AC-11b).
- [ ] T1.3 Vigilancia pasiva por URL: TLS, cabeceras, uptime, exposición (AC-12).
- [ ] T1.4 Panel: estado por proyecto + cola de hallazgos por veredicto/severidad (AC-13).
- [ ] T1.5 Auditoría programada pasiva (push/semanal/mensual) (AC-44).

## Ola 2 — Motor de escaneo aislado
- [ ] T2.1 Worker Python en contenedor sandbox: red controlada, sin credenciales ambientales, límites de recursos (NF-01).
- [ ] T2.2 Cola panel↔worker; el worker revalida el alcance y rechaza targets fuera de job (AC-02).
- [ ] T2.3 Normalizador de hallazgos → 3 veredictos + evidencia cifrada (AC-40, NF-03).

## Ola 3 — Auditoría de URL (DAST)
- [ ] T3.1 Pasivo integral orquestando sslyze/cabeceras/exposición (AC-30).
- [ ] T3.2 Activo con ZAP/nuclei dentro de ventana+intensidad; corte si el objetivo se degrada (AC-31, AC-32).

## Ola 4 — Auditoría de servidor (SSH)
- [ ] T4.1 Credencial SSH efímera inyectada al worker, nunca persistida (AC-21).
- [ ] T4.2 Barrido de `infra-server-audit.md` (acceso, red, SO, Docker, archivos, backups, logs) con evidencia (AC-20).

## Ola 5 — Accesos y validación
- [ ] T5.1 Monitoreo de accesos (SSH/admin) + alertas de patrón anómalo (AC-11).
- [ ] T5.2 Validación adversarial: segundo rol confirma; cobertura aditiva entre corridas (AC-41, AC-42).

## Ola 6 — Reporte, retención y cierre
- [ ] T6.1 Informe exportable MD/PDF con PoC acotada, sin datos reales (AC-43).
- [ ] T6.2 Almacén de evidencia cifrado: política de retención por tipo, borrado al vencer, registro de consultas (AC-46).
- [ ] T6.3 Auto-auditoría de la plataforma con las skills antes del primer release.

## Gate por ola
Cada ola cierra con la pasada que no edita de `work-spec.md` y el DoD de la topología (Laravel/worker). Nada ofensivo (olas 3-4) se habilita sin la ola 0 completa.
