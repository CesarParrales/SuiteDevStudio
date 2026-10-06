# Auditoría de servidor / infraestructura (con acceso)

Cuando hay acceso SSH autorizado a un host (VPS, droplet, bare metal) y hay que auditarlo. La puerta de autorización y las RoE de [pentest-methodology.md](pentest-methodology.md) aplican antes de conectarse. Esto audita el sistema donde corre la app, no la app (eso es `owasp.md` / `audit.md`).

## Qué revisar

### Acceso y cuentas
- Usuarios con shell, llaves SSH autorizadas por usuario, llaves huérfanas.
- `PermitRootLogin`, `PasswordAuthentication` (debería ser `no`), puerto SSH, `AllowUsers`.
- `sudo` sin password, membresías de grupos privilegiados.
- `ssh-audit <host>` para algoritmos débiles.

### Red expuesta
- Puertos a la escucha: `ss -tulpn`. Cada puerto abierto debe justificarse.
- Firewall activo (`ufw status` / `nftables` / security groups del proveedor) y coherente con los puertos.
- Servicios que no deberían estar públicos (BD, Redis, panel de métricas).

### Sistema operativo
- Parches pendientes: `apt list --upgradable` / `dnf updates`. CVEs del kernel.
- Actualizaciones de seguridad automáticas (`unattended-upgrades`).
- Hora sincronizada (NTP) — importante para logs y certificados.

### Docker / contenedores
- Socket de Docker expuesto (`/var/run/docker.sock` montado en un contenedor = root del host).
- Contenedores como root, `--privileged`, capacidades de más.
- Imágenes con CVEs: `trivy image <img>`. Base desactualizada.
- Secretos en variables de entorno de `docker inspect`.

### Archivos y permisos
- `.env`, llaves privadas, `*.pem`, backups: dueño y permisos (`600`/`640`, no `777`).
- Permisos world-writable en rutas de la app: `find /ruta -perm -0002`.
- Secretos en el historial de shell, en `/tmp`, en logs.

### Cron y tareas
- `crontab -l` por usuario, `/etc/cron*`. Tareas que descargan y ejecutan desde internet.

### Backups (el más olvidado)
- ¿Existe backup de BD y de archivos subidos? ¿Cifrado?
- **¿Restaura?** Un backup que nunca se restauró no es un backup. Probar en un entorno aparte.
- ¿Está fuera del mismo servidor? (Un ransomware o un `rm` se lleva ambos si están juntos.)

### Logs y detección
- `auth.log` / `journalctl` por accesos fallidos y fuerza bruta.
- `fail2ban` u equivalente activo.
- Logs enviados fuera del host (si el servidor cae o lo comprometen, los logs locales no sirven).

## Herramienta base

`lynis audit system` da un barrido inicial con score. Es el punto de partida, no el informe: sus "sugerencias" se filtran por frontera real antes de volverse hallazgo (ver veredictos en `audit.md`).

## Salida

Veredictos de `audit.md` + tabla de cobertura por superficie (acceso, red, SO, Docker, archivos, backups, logs). Un hallazgo bloquea si es `confirmado` y cruza una frontera: p. ej. Redis sin password accesible desde internet = Critical; falta de `unattended-upgrades` = hardening, no vulnerabilidad.
