#!/usr/bin/env python3
"""Validate repository data files and generate a lightweight control dashboard."""

from __future__ import annotations

import argparse
import csv
import html
import re
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable

REPO_ROOT = Path(__file__).resolve().parents[1]
MATRIX_PATH = REPO_ROOT / "docs" / "control-mapping-matrix.csv"
CROSSWALK_PATH = REPO_ROOT / "docs" / "crosswalks" / "iso27001-nist-csf2-cyber-essentials.csv"

REQUIRED_MATRIX_COLUMNS = [
    "Control_ID",
    "Control_Name",
    "Annex_A_Domain",
    "Technology_Area",
    "Control_Owner_Role",
    "Implementation_Status",
    "Technical_Implementation_Notes",
    "Evidence_Type",
    "Evidence_Naming_Example",
    "ISO_Clause_Reference",
    "Last_Reviewed_Date",
    "NIST_CSF_2_Mapping",
    "Cyber_Essentials_Mapping",
    "Notes",
]

REQUIRED_CROSSWALK_COLUMNS = [
    "ISO 27001 Control ID",
    "ISO 27001 Control Title",
    "NIST CSF 2.0 Function",
    "NIST CSF 2.0 Categories",
    "Cyber Essentials Theme",
    "Practical Evidence Example",
]

ALLOWED_STATUSES = {
    "Not Started",
    "Designed",
    "Implemented",
    "Evidenced",
    "Reviewed",
    "Exception",
}

CONTROL_ID_RE = re.compile(r"^A\.(5|6|7|8)\.\d{1,2}$")
DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")


def read_csv(path: Path) -> list[dict[str, str]]:
    if not path.exists():
        raise FileNotFoundError(f"Required file is missing: {path}")
    with path.open("r", encoding="utf-8-sig", newline="") as handle:
        return list(csv.DictReader(handle))


def require_columns(path: Path, rows: list[dict[str, str]], required: Iterable[str]) -> list[str]:
    errors: list[str] = []
    columns = set(rows[0].keys()) if rows else set()
    for column in required:
        if column not in columns:
            errors.append(f"{path}: missing required column '{column}'")
    return errors


def require_exact_columns(path: Path, rows: list[dict[str, str]], required: list[str]) -> list[str]:
    """Require the header row to match the expected schema exactly, including order."""
    errors: list[str] = []
    columns = list(rows[0].keys()) if rows else []
    if columns == required:
        return errors
    for column in required:
        if column not in columns:
            errors.append(f"{path}: missing required column '{column}'")
    for column in columns:
        if column not in required:
            errors.append(f"{path}: unexpected column '{column}'")
    if not errors:
        errors.append(
            f"{path}: column order does not match the expected schema "
            f"(expected: {','.join(required)})"
        )
    return errors


def validate_matrix(rows: list[dict[str, str]], path: Path = MATRIX_PATH) -> list[str]:
    errors: list[str] = []
    if not rows:
        return [f"{path}: no data rows found"]

    errors.extend(require_exact_columns(path, rows, REQUIRED_MATRIX_COLUMNS))

    seen_ids: set[str] = set()
    for index, row in enumerate(rows, start=2):
        control_id = row.get("Control_ID", "").strip()
        status = row.get("Implementation_Status", "").strip()
        title = row.get("Control_Name", "").strip()
        evidence_type = row.get("Evidence_Type", "").strip()
        evidence_name = row.get("Evidence_Naming_Example", "").strip()
        owner = row.get("Control_Owner_Role", "").strip()
        reviewed = row.get("Last_Reviewed_Date", "").strip()

        if not control_id:
            errors.append(f"{path}: row {index} has empty Control_ID")
            continue
        if not CONTROL_ID_RE.match(control_id):
            errors.append(f"{path}: row {index} has invalid ISO control ID '{control_id}'")
        if control_id in seen_ids:
            errors.append(f"{path}: duplicate Control_ID '{control_id}'")
        seen_ids.add(control_id)

        if not title:
            errors.append(f"{path}: row {index} has empty Control_Name")
        if not owner:
            errors.append(f"{path}: row {index} has empty Control_Owner_Role")
        if not evidence_type:
            errors.append(f"{path}: row {index} has empty Evidence_Type")
        if not evidence_name:
            errors.append(f"{path}: row {index} has empty Evidence_Naming_Example")
        if status not in ALLOWED_STATUSES:
            errors.append(
                f"{path}: row {index} has unsupported Implementation_Status '{status}'"
            )
        if reviewed and not DATE_RE.match(reviewed):
            errors.append(f"{path}: row {index} has invalid Last_Reviewed_Date '{reviewed}'")

    return errors


def validate_crosswalk(
    rows: list[dict[str, str]], matrix_ids: set[str], path: Path = CROSSWALK_PATH
) -> list[str]:
    errors: list[str] = []
    if not rows:
        return [f"{path}: no data rows found"]

    errors.extend(require_columns(path, rows, REQUIRED_CROSSWALK_COLUMNS))

    seen_ids: set[str] = set()
    for index, row in enumerate(rows, start=2):
        control_id = row.get("ISO 27001 Control ID", "").strip()
        if not CONTROL_ID_RE.match(control_id):
            errors.append(f"{CROSSWALK_PATH}: row {index} has invalid ISO control ID '{control_id}'")
        if control_id and control_id not in matrix_ids:
            errors.append(
                f"{CROSSWALK_PATH}: row {index} references '{control_id}' that is not present in the control matrix"
            )
        if control_id in seen_ids:
            errors.append(f"{CROSSWALK_PATH}: duplicate ISO 27001 Control ID '{control_id}'")
        seen_ids.add(control_id)
        if not row.get("Practical Evidence Example", "").strip():
            errors.append(f"{CROSSWALK_PATH}: row {index} has empty Practical Evidence Example")
    return errors


def control_domain(control_id: str) -> str:
    if control_id.startswith("A.5."):
        return "A.5 Organisational controls"
    if control_id.startswith("A.6."):
        return "A.6 People controls"
    if control_id.startswith("A.7."):
        return "A.7 Physical controls"
    if control_id.startswith("A.8."):
        return "A.8 Technological controls"
    return "Unknown"


def markdown_table(headers: list[str], rows: list[list[str]]) -> str:
    output = [
        "| " + " | ".join(headers) + " |",
        "| " + " | ".join(["---"] * len(headers)) + " |",
    ]
    for row in rows:
        output.append("| " + " | ".join(cell.replace("|", "\\|") for cell in row) + " |")
    return "\n".join(output)


def build_dashboard(matrix_rows: list[dict[str, str]], crosswalk_rows: list[dict[str, str]]) -> str:
    generated_at = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")
    status_counts = Counter(row["Implementation_Status"].strip() for row in matrix_rows)
    domain_counts = Counter(control_domain(row["Control_ID"].strip()) for row in matrix_rows)
    owner_counts = Counter(row["Control_Owner_Role"].strip() for row in matrix_rows)
    technology_counts = Counter(row["Technology_Area"].strip() for row in matrix_rows)

    return "\n".join(
        [
            "# ISO 27001 Controls to Reality - Status Dashboard",
            "",
            f"Generated: `{generated_at}`",
            "",
            "## Summary",
            "",
            markdown_table(
                ["Metric", "Value"],
                [
                    ["Control mappings", str(len(matrix_rows))],
                    ["Crosswalk rows", str(len(crosswalk_rows))],
                    ["Unique control owners", str(len(owner_counts))],
                    ["Technology areas", str(len(technology_counts))],
                ],
            ),
            "",
            "## Controls by implementation status",
            "",
            markdown_table(["Status", "Count"], [[status, str(count)] for status, count in sorted(status_counts.items())]),
            "",
            "## Controls by Annex A domain",
            "",
            markdown_table(["Domain", "Count"], [[domain, str(count)] for domain, count in sorted(domain_counts.items())]),
            "",
            "## Controls by technology area",
            "",
            markdown_table(["Technology area", "Mapped controls"], [[area, str(count)] for area, count in technology_counts.most_common()]),
            "",
            "## Control owner workload",
            "",
            markdown_table(["Control owner role", "Mapped controls"], [[owner, str(count)] for owner, count in owner_counts.most_common()]),
            "",
            "## Control register",
            "",
            markdown_table(
                ["Control ID", "Control name", "Owner", "Technology area", "Status", "Last reviewed"],
                [
                    [
                        row["Control_ID"],
                        row["Control_Name"],
                        row["Control_Owner_Role"],
                        row["Technology_Area"],
                        row["Implementation_Status"],
                        row["Last_Reviewed_Date"],
                    ]
                    for row in matrix_rows
                ],
            ),
            "",
        ]
    )


def write_html(markdown: str, output_path: Path) -> None:
    escaped = html.escape(markdown)
    title = "ISO 27001 Controls to Reality - Status Dashboard"
    document = f"""<!doctype html>
<html lang=\"en\">
<head>
  <meta charset=\"utf-8\">
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
  <title>{html.escape(title)}</title>
  <style>
    body {{ font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", sans-serif; margin: 2rem; line-height: 1.5; }}
    pre {{ white-space: pre-wrap; background: #f6f8fa; border: 1px solid #d0d7de; border-radius: 6px; padding: 1rem; }}
  </style>
</head>
<body>
  <pre>{escaped}</pre>
</body>
</html>
"""
    output_path.write_text(document, encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate ISO 27001 repository data files.")
    parser.add_argument(
        "--dashboard-dir",
        type=Path,
        default=None,
        help="Optional output directory for generated dashboard markdown and HTML.",
    )
    parser.add_argument(
        "--matrix",
        type=Path,
        default=MATRIX_PATH,
        help="Path to the control mapping matrix CSV. Defaults to the committed matrix.",
    )
    parser.add_argument(
        "--crosswalk",
        type=Path,
        default=CROSSWALK_PATH,
        help="Path to the crosswalk CSV. Defaults to the committed crosswalk.",
    )
    args = parser.parse_args()

    errors: list[str] = []
    matrix_rows = read_csv(args.matrix)
    crosswalk_rows = read_csv(args.crosswalk)

    errors.extend(validate_matrix(matrix_rows, args.matrix))
    matrix_ids = {row["Control_ID"].strip() for row in matrix_rows if row.get("Control_ID")}
    errors.extend(validate_crosswalk(crosswalk_rows, matrix_ids, args.crosswalk))

    if errors:
        print("Repository validation failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    print(f"Validated {len(matrix_rows)} control mappings.")
    print(f"Validated {len(crosswalk_rows)} crosswalk rows.")

    if args.dashboard_dir:
        args.dashboard_dir.mkdir(parents=True, exist_ok=True)
        dashboard_md = build_dashboard(matrix_rows, crosswalk_rows)
        md_path = args.dashboard_dir / "control-status-dashboard.md"
        html_path = args.dashboard_dir / "control-status-dashboard.html"
        md_path.write_text(dashboard_md, encoding="utf-8")
        write_html(dashboard_md, html_path)
        print(f"Wrote {md_path}")
        print(f"Wrote {html_path}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
