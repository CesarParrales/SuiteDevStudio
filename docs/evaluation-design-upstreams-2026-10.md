# Evaluación de skills de oficio visual → suite

**Fecha:** 2026-10-09 · **Decisión:** destilar tres reglas que faltaban. No instalar los paquetes.

## Emil Kowalski

[emilkowal.ski/skill](https://emilkowal.ski/skill) → repo [emilkowalski/skills](https://github.com/emilkowalski/skills) (MIT). Ocho skills de animación más Swift, Expo y prototipos.

La suite ya tiene duraciones y easing en `ui-web-modern/references/motion.md`. Lo que faltaba es la decisión previa: no animar lo que el usuario ve cientos de veces al día, y revisar con una tabla antes/después.

Quedó en `skills/ui-web-modern/references/motion-craft.md`.

## Taste Skill

[leonxlnx/taste-skill](https://github.com/leonxlnx/taste-skill) (MIT). La skill por defecto pasó a v2 experimental (lectura de brief, tres dials, mapa a un design system oficial). El archivo supera las mil líneas y declara que no cubre dashboards.

Se adoptan la lectura de una línea y los tres dials, solo para landing, portafolio y marketing: `skills/ui-web-modern/references/design-read.md`. No entran esqueletos GSAP, generación de imágenes ni las variantes visuales (soft, brutalista, minimalista): eso duplicaría `ui-web-modern` y `ui-admin-dashboard`.

## Impeccable

[impeccable.style](https://impeccable.style). Vocabulario de pulido, `DESIGN.md`, hooks y un detector de “slop”. El CLI es de su producto.

La suite ya guarda la dirección visual en `.cursor/project-memory.md` y audita con `ui-audit`. Se adoptan las señales concretas de interfaz genérica: `skills/ui-audit/references/ai-slop.md`. No se instalan CLI, hooks ni un segundo archivo de diseño.

## GPT-6 Astra · 10K Websites (2026-10-17)

[Barty-Bart/gpt-6-astra-10k-websites](https://github.com/Barty-Bart/gpt-6-astra-10k-websites). Dos prompts para landings cinemáticas con Higgsfield. Sin licencia clara.

Se destilan style tile, tabla Visual Story, ritmo en viewport heights y mobile compuesto: `skills/ui-web-modern/references/scroll-story.md`. No entran los prompts, Higgsfield ni el scrub de frames como default.

## Vigilancia

Las fuentes anteriores, más Agent Skills, Cloudflare, Kiro, Ponytail y prompt-master, quedan en `skills/skill-evolution/references/upstream-watch.md`. El Modo 8 de `skill-evolution` las revisa cuando vencen.
