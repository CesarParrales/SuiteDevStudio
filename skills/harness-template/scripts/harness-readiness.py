#!/usr/bin/env python3
"""Harness readiness score (/20) — heurísticas sobre suite o proyecto.

Uso:
  python3 harness-readiness.py --suite ./skills
  python3 harness-readiness.py --project /ruta/repo
  python3 harness-readiness.py --suite ./skills --project /ruta/repo
"""
from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Literal

Status = Literal["hecho", "parcial", "falta"]

SCORE = {"hecho": 1.0, "parcial": 0.5, "falta": 0.0}


@dataclass
class Item:
    id: str
    dimension: str
    label: str
    status: Status
    note: str = ""


def exists(path: Path) -> bool:
    return path.exists()


def skill_installed(skills_dir: Path | None, name: str) -> bool:
    return skills_dir is not None and (skills_dir / name / "SKILL.md").is_file()


def all_skills_under_limit(skills_dir: Path | None, limit: int = 500) -> Status:
    if not skills_dir or not skills_dir.is_dir():
        return "falta"
    over = []
    for skill_md in skills_dir.glob("*/SKILL.md"):
        lines = len(skill_md.read_text(encoding="utf-8", errors="replace").splitlines())
        if lines > limit:
            over.append(skill_md.parent.name)
    if over:
        return "parcial" if len(over) < 3 else "falta"
    return "hecho"


def harness_failures_has_entries(path: Path | None) -> Status:
    if not path or not path.is_file():
        return "falta"
    text = path.read_text(encoding="utf-8", errors="replace")
    entries = len(re.findall(r"^### \d{4}-\d{2}-\d{2}", text, re.M))
    return "hecho" if entries >= 3 else ("parcial" if entries >= 1 else "falta")


def project_memory_has_session_log(pm: Path | None) -> Status:
    if not pm or not pm.is_file():
        return "falta"
    text = pm.read_text(encoding="utf-8", errors="replace")
    if "log de sesión" in text.lower() and re.search(r"### 20\d{2}-\d{2}-\d{2}", text):
        markers = ("YYYY-MM-DD", "*(fecha", "Backend: …", "<!-- Formato:")
        if any(m in text for m in markers):
            return "parcial"
        if re.search(r"(exit 0|→ exit)", text, re.I):
            return "hecho"
        return "parcial"
    return "parcial" if "log de sesión" in text.lower() else "falta"


def has_historical_decisions(suite_root: Path | None, pm: Path | None, project: Path | None = None) -> Status:
    if suite_root and (suite_root / "docs/harness-decisions.md").is_file():
        text = (suite_root / "docs/harness-decisions.md").read_text(encoding="utf-8", errors="replace")
        if len(re.findall(r"^## ADR-", text, re.M)) >= 2:
            return "hecho"
    if project and (project / "docs/architecture/README.md").is_file():
        text = (project / "docs/architecture/README.md").read_text(encoding="utf-8", errors="replace")
        if len(text.strip()) > 150 and "{{NOMBRE_PROYECTO}}" not in text:
            return "hecho"
        return "parcial"
    if pm and pm.is_file():
        text = pm.read_text(encoding="utf-8", errors="replace")
        if re.search(r"## Decisiones recientes", text) and re.search(r"### 20\d{2}-\d{2}-\d{2}", text):
            return "hecho"
    if suite_root and (suite_root / "docs").is_dir():
        return "parcial"
    return "falta"


def is_personalized_agents(path: Path) -> bool:
    if not path.is_file():
        return False
    text = path.read_text(encoding="utf-8", errors="replace")
    markers = (
        "YYYY-MM-DD",
        "{{",
        "# Ejemplo — sustituir",
        "Generado desde suite-dev-studio",
        "(rellenar)",
        "| … |",
    )
    if any(m in text for m in markers):
        return False
    return len(text.strip()) > 400


def has_ff1_agents(
    project: Path | None,
    suite_root: Path | None,
) -> tuple[Status, str]:
    if project and (project / "AGENTS.md").is_file():
        p = project / "AGENTS.md"
        if is_personalized_agents(p):
            return "hecho", "AGENTS.md personalizado"
        return "parcial", "AGENTS.md con placeholders"
    if suite_root and (suite_root / "templates/AGENTS.md").is_file():
        return "hecho", "templates/AGENTS.md (suite canónica)"
    return "falta", "sin AGENTS.md"


def is_personalized_code_map(path: Path) -> bool:
    if not path.is_file():
        return False
    text = path.read_text(encoding="utf-8", errors="replace")
    if len(text.strip()) < 200:
        return False
    markers = ("{{", "YYYY-MM-DD", "…", "# Ejemplo Laravel", "{{NOMBRE_PROYECTO}}")
    return not any(m in text for m in markers)


def has_code_context_ff2(
    project: Path | None,
    suite_root: Path | None,
    skills_dir: Path | None,
    agents: Path | None,
) -> tuple[Status, str]:
    if suite_root:
        codemap = suite_root / "docs/suite-code-map.md"
        manifesto = suite_root / "MANIFIESTO.md"
        routing = None
        if skills_dir:
            routing = skills_dir / "harness-template/references/task-routing.md"
        if codemap.is_file() and manifesto.is_file() and routing and routing.is_file():
            return "hecho", "docs/suite-code-map.md + task-routing"
        if manifesto.is_file():
            return "parcial", "MANIFIESTO sin suite-code-map"
    if project:
        codemap = project / "docs/code-map.md"
        if is_personalized_code_map(codemap):
            return "hecho", "docs/code-map.md personalizado"
        if codemap.is_file():
            return "parcial", "docs/code-map.md con placeholders"
        if (project / "context.md").is_file():
            return "hecho", "context.md"
        if agents and agents.is_file():
            text = agents.read_text(encoding="utf-8", errors="replace")
            if re.search(r"## Estructura del repo", text):
                if "# Ejemplo" not in text and "…" not in text.split("Estructura", 1)[-1][:200]:
                    return "hecho", "AGENTS.md mapa personalizado"
                return "parcial", "AGENTS.md con plantilla de estructura"
        pm = project / ".cursor/project-memory.md"
        if pm.is_file() and "## Fuentes de verdad" in pm.read_text(encoding="utf-8", errors="replace"):
            return "parcial", "project-memory fuentes"
    if skills_dir and skill_installed(skills_dir, "problem-solving-dev"):
        return "parcial", "problem-solving-dev instalada"
    return "falta", "sin mapa de código"


def has_syntax_gate(project: Path | None, suite_root: Path | None) -> Status:
    if suite_root and (suite_root / "scripts/harness-test.sh").is_file():
        return "hecho"
    if not project:
        return "parcial"
    pkg = project / "package.json"
    if pkg.is_file() and "lint" in pkg.read_text(encoding="utf-8", errors="replace"):
        return "hecho"
    if (project / "pint.json").is_file() or (project / "phpunit.xml").is_file():
        return "hecho"
    if (project / "scripts/harness-test.sh").is_file():
        return "parcial"
    return "parcial"


def has_vcs(project: Path | None, suite_root: Path | None) -> Status:
    if suite_root and (suite_root / ".git").exists():
        return "hecho"
    if project and (project / ".git").exists():
        return "hecho"
    if suite_root and (suite_root / "install-local.sh").is_file() and (suite_root / "MANIFIESTO.md").is_file():
        return "hecho"
    return "parcial"


def has_test_gate(project: Path | None, suite_root: Path | None) -> Status:
    if suite_root and (suite_root / "scripts/harness-test.sh").is_file():
        return "hecho"
    if project and (project / "scripts/harness-test.sh").is_file():
        return "hecho"
    if not project:
        return "falta"
    pm = project / ".cursor/project-memory.md"
    if pm.is_file():
        text = pm.read_text(encoding="utf-8", errors="replace")
        if re.search(r"(harness-test\.sh|pest|php artisan test|npm test|vitest)", text, re.I):
            if re.search(r"(exit 0|→ exit)", text, re.I):
                return "hecho"
            return "parcial"
    if (project / "composer.json").is_file() or (project / "package.json").is_file():
        return "parcial"
    return "falta"


def has_ci_harness(project: Path | None, suite_root: Path | None) -> Status:
    wf = None
    if project and (project / ".github/workflows/harness-validate.yml").is_file():
        wf = project / ".github/workflows/harness-validate.yml"
    elif suite_root and (suite_root / ".github/workflows/harness-validate.yml").is_file():
        wf = suite_root / ".github/workflows/harness-validate.yml"
    if wf and wf.is_file():
        text = wf.read_text(encoding="utf-8", errors="replace")
        if "harness-readiness" in text:
            return "hecho"
        return "parcial"
    if project and (project / ".github/workflows").is_dir():
        if list((project / ".github/workflows").glob("harness*.yml")):
            return "parcial"
    return "falta"


def evaluate(skills_dir: Path | None, project: Path | None, suite_root: Path | None) -> list[Item]:
    root = project or suite_root
    pm = root / ".cursor/project-memory.md" if root else None
    agents = None
    if project and (project / "AGENTS.md").is_file():
        agents = project / "AGENTS.md"
    elif suite_root and (suite_root / "templates/AGENTS.md").is_file():
        agents = suite_root / "templates/AGENTS.md"
    hf = None
    if skills_dir and (skills_dir / "HARNESS-FAILURES.md").is_file():
        hf = skills_dir / "HARNESS-FAILURES.md"
    elif suite_root and (suite_root / "skills/HARNESS-FAILURES.md").is_file():
        hf = suite_root / "skills/HARNESS-FAILURES.md"

    items: list[Item] = []

    # Feedforward
    ff1, ff1_note = has_ff1_agents(project, suite_root)
    items.append(Item("FF-1", "Feedforward", "Reglas antes del agente", ff1, ff1_note))

    ff2, ff2_note = has_code_context_ff2(project, suite_root, skills_dir, agents)
    items.append(Item("FF-2", "Feedforward", "Código relevante en contexto", ff2, ff2_note))

    ff3 = "hecho" if skill_installed(skills_dir, "harness-template") else "falta"
    items.append(Item("FF-3", "Feedforward", "Tipo de tarea → skills", ff3))

    ff4 = has_historical_decisions(suite_root, pm, project)
    items.append(Item("FF-4", "Feedforward", "Decisiones históricas", ff4))

    ff5 = all_skills_under_limit(skills_dir)
    items.append(Item("FF-5", "Feedforward", "Presupuesto de contexto", ff5))

    # Feedback
    items.append(Item("FB-1", "Feedback", "Syntax / types", has_syntax_gate(project, suite_root)))

    items.append(Item("FB-2", "Feedback", "Tests automáticos", has_test_gate(project, suite_root)))

    fb3 = "hecho" if skill_installed(skills_dir, "comprobacion-produccion") and skills_dir and (
        skills_dir / "comprobacion-produccion/scripts/validate-fb3.sh"
    ).is_file() else "falta"
    items.append(Item("FB-3", "Feedback", "Errores estructurados FB-3", fb3))

    fb4 = "hecho" if skill_installed(skills_dir, "karpathy-guidelines") else "falta"
    items.append(Item("FB-4", "Feedback", "Checkpoints", fb4))

    items.append(Item("FB-5", "Feedback", "Escalación", fb4))

    # Infrastructure
    in1 = has_vcs(project, suite_root)
    items.append(Item("IN-1", "Infrastructure", "Harness en VCS", in1))

    items.append(Item("IN-2", "Infrastructure", "Test del harness (CI)", has_ci_harness(project, suite_root)))

    items.append(Item("IN-3", "Infrastructure", "Log de sesión", project_memory_has_session_log(pm)))

    in4 = "hecho" if skill_installed(skills_dir, "vibe-coding-token-optimization") else "falta"
    items.append(Item("IN-4", "Infrastructure", "Coste observable", in4))

    in5 = "hecho" if skills_dir and (skills_dir / "harness-template/references/staging-isolation.md").is_file() else "falta"
    items.append(Item("IN-5", "Infrastructure", "Aislamiento riesgoso", in5))

    # Team
    items.append(Item("TR-1", "Team", "Checklist revisión agente", "hecho" if skill_installed(skills_dir, "comprobacion-produccion") else "falta"))
    items.append(Item("TR-2", "Team", "Catálogo de fallos", harness_failures_has_entries(hf)))
    items.append(Item("TR-3", "Team", "Revisiones periódicas", "hecho" if skill_installed(skills_dir, "skill-evolution") else "falta"))
    tr4 = "hecho" if skill_installed(skills_dir, "team-onboarding") and agents and agents.is_file() else (
        "parcial" if skill_installed(skills_dir, "team-onboarding") else "falta"
    )
    items.append(Item("TR-4", "Team", "Onboarding harness", tr4))

    tr5 = "parcial"
    if skills_dir:
        for learn in skills_dir.glob("*/LEARNINGS.md"):
            if "## Pendientes" in learn.read_text(encoding="utf-8", errors="replace"):
                tr5 = "hecho"
                break
    items.append(Item("TR-5", "Team", "Canal de mejora (LEARNINGS)", tr5))

    return items


def report(items: list[Item], label: str, min_score: float = 0.0) -> int:
    dims = ("Feedforward", "Feedback", "Infrastructure", "Team")
    print(f"# Harness readiness — {label}\n")
    print("| ID | Ítem | Estado | Nota |")
    print("|----|------|--------|------|")
    for it in items:
        print(f"| {it.id} | {it.label} | {it.status} | {it.note} |")

    print("\n| Dimensión | Score |")
    print("|-----------|-------|")
    total = 0.0
    for dim in dims:
        dim_items = [i for i in items if i.dimension == dim]
        score = sum(SCORE[i.status] for i in dim_items)
        total += score
        print(f"| {dim} | {score:.1f}/5 |")
    print(f"| **Total** | **{total:.1f}/20** |")

    gaps = sorted(
        [i for i in items if i.status != "hecho"],
        key=lambda x: SCORE[x.status],
    )[:3]
    print("\n## Top 3 gaps\n")
    for i, g in enumerate(gaps, 1):
        print(f"{i}. **{g.id}** {g.label} ({g.status}) — {g.note or 'ver readiness-checklist.md'}")

    if total >= 16:
        print("\n**Nivel:** maduro para trabajo diario con agentes.")
    elif total >= 12:
        print("\n**Nivel:** usable; priorizar gaps FB e IN.")
    else:
        print("\n**Nivel:** reforzar FF-1, FB-2, FB-3 antes de ampliar skills.")

    if min_score > 0 and total < min_score:
        print(f"\n**CI:** score {total:.1f} < umbral {min_score:.1f} — fallo.")
        return 1

    return 0 if total >= 12 else 1


def main() -> int:
    p = argparse.ArgumentParser(description="Harness readiness /20")
    p.add_argument("--suite", type=Path, help="Directorio skills/ de la suite")
    p.add_argument("--project", type=Path, help="Raíz del proyecto cliente")
    p.add_argument("--min-score", type=float, default=0.0, help="Exit 1 si score < umbral")
    p.add_argument("--ci", action="store_true", help="Modo CI: --min-score 16")
    args = p.parse_args()

    min_score = 16.0 if args.ci else args.min_score

    suite_dir = args.suite
    project = args.project
    suite_root = None
    if suite_dir:
        suite_root = suite_dir.parent if suite_dir.name == "skills" else suite_dir

    if not suite_dir and not project:
        p.error("Indica --suite y/o --project")

    label = project.name if project else (suite_dir.name if suite_dir else "suite")
    items = evaluate(suite_dir, project, suite_root)
    return report(items, label, min_score)


if __name__ == "__main__":
    sys.exit(main())
