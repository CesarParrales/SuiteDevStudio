# Oficio de animación

Las duraciones y curvas base siguen en `motion.md`. Esta nota dice cuándo no animar.

Fuente: filosofía de Emil Kowalski ([emilkowalski/skills](https://github.com/emilkowalski/skills), MIT). Revisión 2026-10-09. No se instala ese paquete ni sus skills de Swift, Expo o prototipos.

## Frecuencia

| Veces que se ve | Decisión |
|---|---|
| Cientos al día (atajo, paleta de comandos) | Sin animación |
| Decenas al día (hover, recorrer una lista) | Acortar o quitar |
| Ocasional (modal, toast, cajón) | Duración de `motion.md` |
| Rara (onboarding, celebración) | Se puede añadir deleite |

Una acción iniciada por teclado no lleva animación de apertura o cierre.

## Propósito

Cada animación responde a una de estas razones: consistencia espacial, cambio de estado, explicación, feedback de pulsación, o evitar un salto brusco. Si la razón es solo que se ve bien y el usuario la verá a menudo, no se anima.

## Revisión

La revisión sale en una tabla `Antes | Después | Por qué`.

- Nombrar la propiedad. `transition: all` anima lo que no debía moverse.
- Una entrada no parte de `scale(0)`. Parte de algo cercano, con opacidad, para no aparecer de la nada.
- Entrada y salida usan ease-out. ease-in se siente lento al inicio.
- El botón tiene estado `:active` (un scale leve, cerca de 0.97).
- Un popover escala desde su disparador. Un modal sigue centrado.
