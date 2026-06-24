# Arquitectura — {{NOMBRE_PROYECTO}}

Índice ligero de decisiones y límites. ADRs detallados en `docs/architecture/adr/`.

`last_updated: YYYY-MM-DD`

## Vista general

| Capa | Ubicación | Responsabilidad |
|------|-----------|-----------------|
| HTTP / API | … | Controllers, routes, middleware |
| Dominio | … | Services, actions, policies |
| Datos | … | Models, migrations, repositories |
| UI | … | Pages, components |
| Tests | … | Feature, unit, e2e |

## Límites de módulos

```
# Personalizar — ejemplo Laravel modular
Modules/
  Billing/     # pagos, facturas — no importar Models de Auth directamente
  Auth/        # usuarios, sesiones
```

Regla: **comunicación entre módulos** vía interfaces/events documentados, no imports cruzados de implementación.

## ADRs

| ID | Título | Estado |
|----|--------|--------|
| ADR-001 | … | propuesto / aceptado |

Nuevos ADRs: `docs/architecture/adr/NNN-titulo.md` — plantilla: `adr/000-template.md` (o `web-architecture/references/adr-template.md` en la suite).

## Integraciones externas

| Sistema | Uso | Secretos |
|---------|-----|----------|
| … | … | `.env` solo |

## Enlaces

- Mapa FF-2: `docs/code-map.md`
- Memoria operativa: `.cursor/project-memory.md`
- Convenciones: `AGENTS.md`
