# Plataforma de auditoría y monitoreo — Requisitos

**Fecha:** 2026-10-06 · **Estado:** fase 1 (requisitos) para aprobar · Protocolo: `skills/harness-template/references/work-spec.md`

Herramienta del estudio que opera sobre tres tipos de objetivo: **propios**, **de cliente** (servicio contratado) y **research** (investigación propia autorizada). Dos capacidades en un producto:

- **A. Monitoreo** continuo de accesos y servidores, vía **agente residente** en cada host (no depende de una sesión SSH puntual ni de un chat abierto).
- **B. Auditoría activa** autorizada: acceso a un servidor y auditarlo; una URL y revisarla de punta a punta. Hacking ético senior.

La metodología vive en las skills (`security-checklist`: `pentest-methodology.md`, `infra-server-audit.md`, `dast-url-review.md`). La app las operacionaliza: agenda, ejecuta, guarda evidencia y reporta.

## Historias

### Autorización (la base de todo)
- **AC-01** Como operador, no puedo lanzar un escaneo **activo** sin un registro de autorización aprobado (dueño, alcance de hosts/dominios/rutas, ventana, RoE). WHEN falta cualquiera THEN el sistema SHALL bloquear el escaneo activo y permitir solo revisión pasiva/código.
- **AC-02** El alcance es una allowlist. WHEN un objetivo no está en el alcance aprobado THEN el sistema SHALL rechazar el target, incluso si el operador lo fuerza.
- **AC-03** Cada objetivo tiene un **tipo** que fija el requisito de autorización:
  - **propio** → preaprobación del estudio; igual registra alcance y ventana.
  - **cliente** → **contrato de pentest** firmado vinculado a la autorización antes de cualquier acción activa (AC-45).
  - **research** → autorización propia documentada del dueño del sistema; sin ella, solo fuentes pasivas/públicas.
- **AC-04** El tipo de objetivo no relaja los límites técnicos (ventana, intensidad, corte); solo cambia el documento de autorización exigido.

### Monitoreo (A)
- **AC-10** Registrar e inventariar servidores y apps por objetivo (host, tipo propio/cliente/research, entorno, responsable, endpoint `/health`).
- **AC-11** **Agente residente** por host: reporta accesos (SSH fallidos/exitosos, llaves nuevas), logins de admin de la app, y señales de salud, al panel sin sesión interactiva. WHEN el agente pierde contacto THEN el sistema SHALL alertar (un agente caído puede ser un servidor caído o manipulado).
- **AC-11b** El agente es de **solo telemetría** por defecto: lee y reporta, no ejecuta escaneos activos salvo que un job autorizado se lo ordene. Canal autenticado y cifrado; el host no expone credenciales al panel.
- **AC-12** Vigilancia pasiva continua por URL: caducidad de TLS, cabeceras, uptime, exposición de rutas sensibles.
- **AC-13** Panel con estado por proyecto y una cola de hallazgos abiertos por severidad y veredicto.

### Auditoría de servidor (B, con acceso)
- **AC-20** Con credenciales SSH autorizadas y efímeras, ejecutar el barrido de `infra-server-audit.md` (acceso, red, SO, Docker, archivos, backups, logs) y guardar evidencia.
- **AC-21** Las credenciales del objetivo nunca se persisten en claro ni en el repo; se usan en la corrida y se descartan.

### Auditoría de URL (B, DAST)
- **AC-30** Pasivo siempre disponible sobre dominios en alcance (TLS, cabeceras, exposición).
- **AC-31** Activo (auth, IDOR, inyección, carga, lógica, rate limit) solo dentro de ventana e intensidad de las RoE; staging antes que producción.
- **AC-32** Prohibido degradar el servicio: límites de intensidad y corte automático si el objetivo responde con errores/latencia anómala.

### Hallazgos y reporte (transversal)
- **AC-40** Tres veredictos: `confirmado`, `necesita_validacion`, `rechazado`. Severidad solo en confirmados con frontera cruzada.
- **AC-41** Validación adversarial: quien ejecutó el hallazgo no lo confirma; una segunda pasada/rol lo revisa.
- **AC-42** Corridas aditivas: cada auditoría usa la cobertura previa para apuntar a lo cambiado.
- **AC-43** Informe exportable (MD/PDF) con evidencia reproducible y PoC acotada; sin datos reales de usuarios.
- **AC-44** Auditoría programada por proyecto (push, semanal, mensual, trimestral) según la cadencia de `audit.md`.
- **AC-45** **Contrato de pentest** para objetivos de cliente: documento firmado (alcance, ventana, RoE, responsables, periodo) vinculado a la autorización. No excluye el análisis por cuenta propia sobre objetivos propios/research, que usa su propio documento de autorización.
- **AC-46** **Retención de evidencia** por política y por tipo de objetivo: periodo configurable, cifrada en reposo, con borrado al vencer y registro de quién la consultó. La evidencia respalda el informe cuando se necesite y el cumplimiento del contrato.

## No funcionales
- **NF-01** Sandbox/aislamiento para el motor de escaneo (red controlada, sin credenciales ambientales, límites de recursos).
- **NF-02** RBAC: operador, revisor, lector. Toda acción activa queda en bitácora inmutable.
- **NF-03** Cifrado en reposo de evidencia y de cualquier secreto temporal.
- **NF-04** Multiplataforma de objetivos; el motor orquesta herramientas existentes (nmap, nuclei, ZAP, sslyze, lynis, trivy, gitleaks), no las reimplementa.

## Decisiones resueltas (antes huecos)
1. **Objetivos:** propios, de cliente (con contrato) y research (con autorización propia). No solo infraestructura del estudio. → AC-03, AC-45.
2. **Monitoreo:** agente residente por host, de solo telemetría por defecto; no depende de SSH puntual ni de un chat abierto. → AC-11, AC-11b.
3. **Cumplimiento:** contrato de pentest para servicio a cliente (no excluyente del análisis propio) + retención de evidencia por política, cifrada, con borrado al vencer. → AC-45, AC-46.

## Fuera de alcance (v1)
Escaneo de objetivos sin autorización/contrato del tipo que corresponda. Explotación más allá de la PoC. Respuesta a incidentes automatizada (el agente alerta y, como mucho, aísla bajo orden explícita; no remedia solo).
