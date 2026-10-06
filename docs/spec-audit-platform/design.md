# Plataforma de auditoría y monitoreo — Diseño

**Fecha:** 2026-10-06 · **Estado:** propuesta, requiere aprobación antes de tareas. Depende de `requirements.md`.

## Repo (recomendación)

**Repo nuevo dedicado**, no dentro de `suite-dev-studio` ni de un proyecto de cliente.

Motivo: es herramienta con credenciales de terceros y capacidad ofensiva. Aislarla del código de clientes reduce el radio de impacto, permite RBAC y bitácora propios, y evita que una dependencia de la plataforma entre a repos de producto. La suite guía; la plataforma opera.

## Stack (recomendación)

Híbrido, porque panel y motor tienen necesidades distintas:

| Componente | Tecnología | Por qué |
|-----------|------------|---------|
| Panel + API + reportes | **Laravel + Filament** | Alineado con el estudio; RBAC, colas, scheduler y CRUD de admin ya resueltos en Filament |
| Motor de escaneo | **Workers Python** en contenedor aislado | El ecosistema de seguridad (ZAP, nuclei, sslyze, lynis, trivy, nmap) se orquesta mejor desde Python; corre sandboxed |
| Agente residente | **Binario Go** por host | Un solo binario estático, sin runtime; bajo consumo; conexión saliente autenticada al panel (el host no abre puerto entrante) |
| Cola entre ambos | **Redis + colas Laravel / mensajes** | El panel encola un job con alcance; el worker ejecuta aislado y devuelve evidencia |
| Evidencia | **Object storage cifrado** (S3/R2 o disco cifrado) | Separado de la BD; retención y borrado por política (AC-46) |

Alternativas consideradas: todo Laravel (más simple, pero el motor de escaneo sufre sin el tooling Python); Node/Nest + Python (válido, pero duplica el stack de panel que ya dominamos en Laravel/Filament). **Decisión abierta** para tu visto bueno.

## Arquitectura

```
Agente (Go, por host) ──telemetría saliente, cifrada──┐
   accesos SSH, llaves, admin, salud                   │
                                                        ▼
Operador → Panel (Laravel/Filament) ◀──────────── estado + alertas
             │  Autorización: tipo (propio/cliente/research) + doc exigido
             │    cliente → contrato firmado · research → autorización dueño
             │  crea Autorización (alcance allowlist, ventana, RoE)
             │  encola Job(target ∈ alcance)
             ▼
         Cola (Redis)
             ▼
   Worker de escaneo (Python, contenedor aislado, red controlada)
     - pasivo: sslyze, cabeceras, exposición
     - activo (si RoE lo permite): ZAP/nuclei (URL) · lynis/ssh-audit/trivy (host)
       vía SSH efímero o a través del agente bajo orden del job
     - límites de recursos + corte si el objetivo se degrada
             │  evidencia cifrada + candidatos
             ▼
   Normalizador de hallazgos → 3 veredictos
             ▼
   Validación adversarial (segundo rol/pasada)
             ▼
   Panel: cola de hallazgos, informe exportable, cobertura aditiva
             ▼
   Almacén de evidencia cifrado — retención por tipo, borrado al vencer (AC-46)
```

## Puntos de control de seguridad (del propio producto)

- La allowlist de alcance se evalúa en el panel **y** en el worker; el worker rechaza cualquier target fuera de su job.
- Credenciales SSH/tokens del objetivo: inyectadas al worker por el job, en memoria, nunca escritas a disco ni log; descartadas al terminar.
- El worker no tiene red hacia internet salvo el alcance; sin credenciales ambientales; límites de CPU/mem/tiempo.
- Bitácora inmutable de toda acción activa (quién, qué objetivo, cuándo, qué autorización).
- La plataforma se audita a sí misma con las mismas skills antes de cada release.

## Modelo de datos (núcleo)

`projects`, `targets` (host/url, **tipo** propio/cliente/research, entorno), `authorizations` (dueño, alcance, ventana, RoE, **doc**: contrato|autorización, estado), `contracts` (cliente, alcance, periodo, firmantes, archivo), `scan_jobs` (target, tipo, estado, autorización), `agents` (host, estado, última señal, clave), `access_events` (del agente), `findings` (veredicto, severidad, frontera, evidencia_ref, validado_por), `coverage` (superficie, estado, commit/fecha), `evidence` (ref cifrada, política_retención, vence_en, consultas), `audit_log`.

## Riesgos

| Riesgo | Mitigación |
|--------|-----------|
| Uso fuera de alcance (legal) | Allowlist doble + autorización obligatoria + bitácora |
| Escaneo tumba producción | Intensidad limitada, ventana, corte automático, staging primero |
| Fuga de evidencia/credenciales | Cifrado en reposo, secretos efímeros, RBAC, retención con borrado al vencer |
| Agente comprometido = pivote al host | Solo telemetría por defecto; salida autenticada sin puerto entrante; acción activa solo bajo job autorizado; binario firmado y actualizable |
| Objetivo de cliente sin base legal | Contrato firmado vinculado a la autorización antes de cualquier acción activa (AC-45) |
| La plataforma como objetivo | Aislada, auto-auditada, sin acceso a repos de cliente |
