# Script Readiness Matrix

Use this matrix before running repository scripts. Prefer least privilege, local dry runs, and redacted outputs.

| Script | Purpose | Current maturity | Operator notes |
| --- | --- | --- | --- |
| `scripts/validate_repository.py` | Validate repository CSV files and generate local dashboard files. | Working | Safe to run locally from the repository root. |
| `scripts/m365/Export-M365Iso27001Evidence.ps1` | Export selected Microsoft 365 control evidence to local files. | Partial | Run only in an approved tenant context and protect generated outputs. |
| `scripts/Get-ISO27001Evidence.ps1` | Collect selected Annex A evidence for a limited set of controls. | Partial | Treat as a starter helper; use `-ReportOnly` before writing files. |

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
- Add minimum role and permission details.
- Add synthetic evidence examples.
- Add tests for validator fixture files.
