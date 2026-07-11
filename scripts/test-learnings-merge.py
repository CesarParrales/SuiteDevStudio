#!/usr/bin/env python3
"""Fixture tests for learnings_merge.py (run by harness-test.sh)."""

import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from learnings_merge import (  # noqa: E402
    list_pending,
    merge_harness_failures,
    merge_learnings_file,
)

TEMPLATE = """# Learnings — demo

## Pendientes

<!-- Formato de entrada:
### YYYY-MM-DD · contexto breve
- Tipo: gap | corrección | mejora
-->

## Consolidadas

(ninguna aún)
"""

WITH_ENTRY = TEMPLATE.replace(
    "-->\n",
    "-->\n\n### 2026-07-10 · caso real\n- Tipo: gap\n- Hallazgo: x\n",
)


def main() -> int:
    td = Path(tempfile.mkdtemp())

    # 1. Merge añade entrada nueva sin duplicar plantilla
    t = td / "t.md"
    s = td / "s.md"
    t.write_text(TEMPLATE)
    s.write_text(WITH_ENTRY)
    added = merge_learnings_file(t, s)
    assert added == ["### 2026-07-10 · caso real"], added
    out = t.read_text()
    assert out.count("### 2026-07-10 · caso real") == 1
    assert "<!-- Formato de entrada:" in out, "plantilla comentada perdida"

    # 2. Re-merge es idempotente
    assert merge_learnings_file(t, s) == []

    # 3. Plantilla comentada no cuenta como entrada (pending)
    skills = td / "skills"
    (skills / "demo-a").mkdir(parents=True)
    (skills / "demo-b").mkdir()
    (skills / "demo-a" / "LEARNINGS.md").write_text(TEMPLATE)
    (skills / "demo-b" / "LEARNINGS.md").write_text(WITH_ENTRY)
    pending = list_pending(skills)
    assert "demo-a" not in pending, "falso positivo por comentario"
    assert pending.get("demo-b") == ["### 2026-07-10 · caso real"], pending

    # 4. HARNESS-FAILURES merge sin duplicados
    hf_t = td / "hf_t.md"
    hf_s = td / "hf_s.md"
    hf_t.write_text("# Catálogo\n\n## Entradas\n\n### 2026-06-24 — fallo A\n- x\n")
    hf_s.write_text(
        "# Catálogo\n\n## Entradas\n\n### 2026-06-24 — fallo A\n- x\n\n### 2026-07-10 — fallo B\n- y\n"
    )
    added_hf = merge_harness_failures(hf_t, hf_s)
    assert added_hf == ["### 2026-07-10 — fallo B"], added_hf
    assert hf_t.read_text().count("fallo A") == 1

    print("learnings-merge tests: OK (4/4)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
