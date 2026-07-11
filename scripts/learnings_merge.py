#!/usr/bin/env python3
"""Merge LEARNINGS.md (per skill) and HARNESS-FAILURES.md between skill trees."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

PENDIENTES = "## Pendientes"
CONSOLIDADAS = "## Consolidadas"
ENTRY_HEADING = re.compile(r"^### .+", re.MULTILINE)


def _read(path: Path) -> str:
    if not path.is_file():
        return ""
    return path.read_text(encoding="utf-8")


def _write(path: Path, content: str, dry_run: bool) -> None:
    if dry_run:
        return
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")


def _split_learnings(content: str) -> tuple[str, str, str]:
    """Return (before_pendientes, pendientes_body, consolidadas_body)."""
    if not content.strip():
        return "", "", ""

    idx_p = content.find(PENDIENTES)
    if idx_p == -1:
        return content, "", ""

    before = content[: idx_p + len(PENDIENTES)]
    rest = content[idx_p + len(PENDIENTES) :]

    idx_c = rest.find(CONSOLIDADAS)
    if idx_c == -1:
        return before, rest, ""

    pendientes_body = rest[:idx_c]
    consolidadas_body = rest[idx_c + len(CONSOLIDADAS) :]
    return before, pendientes_body, consolidadas_body


def _extract_entries(section_body: str) -> list[tuple[str, str]]:
    entries: list[tuple[str, str]] = []
    if not section_body.strip():
        return entries

    lines = section_body.splitlines()
    heading: str | None = None
    body_lines: list[str] = []

    for line in lines:
        if line.startswith("### "):
            if heading is not None:
                entries.append((heading, "\n".join(body_lines).strip()))
            heading = line.strip()
            body_lines = []
        elif heading is not None:
            body_lines.append(line)

    if heading is not None:
        entries.append((heading, "\n".join(body_lines).strip()))

    return entries


def _merge_section(
    target_body: str,
    source_body: str,
) -> tuple[str, list[str]]:
    target_entries = _extract_entries(target_body)
    source_entries = _extract_entries(source_body)
    headings = {h for h, _ in target_entries}
    added: list[str] = []

    for heading, body in source_entries:
        if heading in headings:
            continue
        block = heading
        if body:
            block += "\n" + body
        target_entries.append((heading, body))
        headings.add(heading)
        added.append(heading)

    if not target_entries:
        merged = target_body
    else:
        parts: list[str] = []
        for heading, body in target_entries:
            parts.append(heading)
            if body:
                parts.append(body)
            parts.append("")
        merged = "\n".join(parts).rstrip() + "\n"

    return merged, added


def merge_learnings_file(
    target: Path,
    source: Path,
    dry_run: bool = False,
) -> list[str]:
    """Merge entries from source LEARNINGS into target. Returns added headings."""
    src = _read(source)
    if not src.strip():
        return []

    tgt = _read(target)
    if not tgt.strip():
        _write(target, src, dry_run)
        return [h for h, _ in _extract_entries(_split_learnings(src)[1])] + [
            h for h, _ in _extract_entries(_split_learnings(src)[2])
        ]

    before, tgt_p, tgt_c = _split_learnings(tgt)
    _, src_p, src_c = _split_learnings(src)

    new_p, added_p = _merge_section(tgt_p, src_p)
    new_c, added_c = _merge_section(tgt_c, src_c)

    merged = before + "\n" + new_p
    if CONSOLIDADAS in tgt or src_c.strip():
        merged += "\n" + CONSOLIDADAS + "\n" + new_c
    merged = merged.rstrip() + "\n"

    if merged != tgt:
        _write(target, merged, dry_run)

    return added_p + added_c


def merge_harness_failures(
    target: Path,
    source: Path,
    dry_run: bool = False,
) -> list[str]:
    tgt = _read(target)
    src = _read(source)
    if not src.strip():
        return []

    idx = src.find("## Entradas")
    src_entries = src[idx:] if idx != -1 else src
    src_list = _extract_entries(src_entries)

    if not tgt.strip():
        _write(target, src, dry_run)
        return [h for h, _ in src_list]

    if "## Entradas" not in tgt:
        tgt += "\n\n## Entradas\n"
    before, _, _ = tgt.partition("## Entradas")
    entradas_body = tgt.split("## Entradas", 1)[1]
    existing = {h for h, _ in _extract_entries(entradas_body)}
    added: list[str] = []

    for heading, body in src_list:
        if heading in existing:
            continue
        entradas_body = entradas_body.rstrip() + "\n\n" + heading
        if body:
            entradas_body += "\n" + body
        entradas_body += "\n"
        existing.add(heading)
        added.append(heading)

    if added:
        merged = before + "## Entradas" + entradas_body
        _write(target, merged.rstrip() + "\n", dry_run)

    return added


def collect_tree(
    canonical: Path,
    source: Path,
    dry_run: bool,
) -> tuple[int, int]:
    """Merge all skills from source into canonical. Returns (skills_touched, entries_added)."""
    skills_touched = 0
    entries_added = 0

    if not source.is_dir():
        return 0, 0

    for skill_dir in sorted(canonical.iterdir()):
        if not skill_dir.is_dir() or not (skill_dir / "SKILL.md").is_file():
            continue
        name = skill_dir.name
        src_learnings = source / name / "LEARNINGS.md"
        if not src_learnings.is_file():
            continue
        tgt_learnings = skill_dir / "LEARNINGS.md"
        added = merge_learnings_file(tgt_learnings, src_learnings, dry_run)
        if added:
            skills_touched += 1
            entries_added += len(added)
            print(f"  ✓ {name}: +{len(added)} entrada(s)")

    src_hf = source / "HARNESS-FAILURES.md"
    tgt_hf = canonical / "HARNESS-FAILURES.md"
    if src_hf.is_file() and tgt_hf.is_file():
        added_hf = merge_harness_failures(tgt_hf, src_hf, dry_run)
        if added_hf:
            print(f"  ✓ HARNESS-FAILURES.md: +{len(added_hf)} entrada(s)")
            entries_added += len(added_hf)

    return skills_touched, entries_added


def main() -> int:
    parser = argparse.ArgumentParser(description="Merge suite LEARNINGS and HARNESS-FAILURES")
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_file = sub.add_parser("merge-file", help="Merge one LEARNINGS.md")
    p_file.add_argument("--target", type=Path, required=True)
    p_file.add_argument("--source", type=Path, required=True)
    p_file.add_argument("--dry-run", action="store_true")

    p_collect = sub.add_parser("collect", help="Harvest source tree into canonical skills/")
    p_collect.add_argument("--canonical", type=Path, required=True)
    p_collect.add_argument("--source", type=Path, required=True)
    p_collect.add_argument("--dry-run", action="store_true")

    p_hf = sub.add_parser("merge-hf", help="Merge HARNESS-FAILURES.md")
    p_hf.add_argument("--target", type=Path, required=True)
    p_hf.add_argument("--source", type=Path, required=True)
    p_hf.add_argument("--dry-run", action="store_true")

    args = parser.parse_args()

    if args.cmd == "merge-file":
        added = merge_learnings_file(args.target, args.source, args.dry_run)
        if args.dry_run:
            print(f"dry-run: añadiría {len(added)} entrada(s)")
        return 0

    if args.cmd == "collect":
        print(f"→ Origen: {args.source}")
        print(f"→ Canónico: {args.canonical}")
        touched, total = collect_tree(args.canonical, args.source, args.dry_run)
        label = "simulación" if args.dry_run else "recolectado"
        print(f"→ {label}: {total} entrada(s) en {touched} skill(s)")
        return 0

    if args.cmd == "merge-hf":
        added = merge_harness_failures(args.target, args.source, args.dry_run)
        if args.dry_run:
            print(f"dry-run: añadiría {len(added)} entrada(s)")
        return 0

    return 1


if __name__ == "__main__":
    sys.exit(main())
