# Script Readiness Matrix

Use this matrix before running repository scripts. Prefer least privilege, local dry runs, and redacted outputs.

| Script | Purpose | Current maturity | Operator notes |
| --- | --- | --- | --- |
| `scripts/validate_repository.py` | Validate repository CSV files and generate local dashboard files. | Working | Safe to run locally from the repository root. |
| `scripts/m365/Export-M365Iso27001Evidence.ps1` | Export selected Microsoft 365 control evidence to local files. | Partial | Run only in an approved tenant context and protect generated outputs. |
| `scripts/Get-ISO27001Evidence.ps1` | Collect selected Annex A evidence for A.5.15, A.5.16, A.5.18, A.8.1, A.8.5, A.8.7, A.8.12, A.8.15, and A.8.16. | Partial | All functions are read-only against the tenant. Use `-ReportOnly` before writing files. The A.5.18, A.8.1, A.8.12, and A.8.16 functions default to report-only and write files only when `-OutputPath` is supplied explicitly. |

## Operator checklist

1. Confirm the script purpose and expected outputs.
2. Confirm you are using the correct tenant, subscription, or local repository path.
3. Confirm you have approval to collect the evidence.
4. Use report-only or local validation mode where available.
5. Store generated outputs in a protected evidence folder.
6. Redact tenant, user, device, and client details before external sharing.
7. Record operator, date, command, scope, and evidence location.
8. Do not commit real evidence exports to this repository.

## Backlog

- Add per-script example commands.

## Completed

- Fixture-based validator tests live in `tests/` and run in CI.
- Minimum role and permission details are recorded in [`permissions-matrix.md`](permissions-matrix.md).
- Synthetic evidence examples live in [`examples/`](examples/).
