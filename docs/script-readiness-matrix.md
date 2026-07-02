# Script Readiness Matrix

Use this matrix before running repository scripts. Prefer least privilege, local dry runs, and redacted outputs. See [`script-usage-examples.md`](script-usage-examples.md) for ready-to-run commands and troubleshooting notes.

| Script | Purpose | Current maturity | Operator notes |
| --- | --- | --- | --- |
| `scripts/validate_repository.py` | Validate repository CSV files and generate local dashboard files. | Working | Safe to run locally from the repository root. Does not need tenant access. |
| `scripts/m365/Export-M365Iso27001Evidence.ps1` | Export selected Microsoft 365 control evidence to local files. | Partial | Run only in an approved tenant context and protect generated outputs. Produces CSV/JSON exports and an evidence index. |
| `scripts/Get-ISO27001Evidence.ps1` | Collect selected Annex A evidence for A.5.15, A.5.16, A.5.18, A.8.1, A.8.5, A.8.7, A.8.12, A.8.15, and A.8.16. | Partial | All functions are read-only against the tenant. Use `-ReportOnly` before writing files. The A.5.18, A.8.1, A.8.12, and A.8.16 functions default to report-only and write files only when `-OutputPath` is supplied explicitly. |

## Example commands

### Validate repository data

```bash
python scripts/validate_repository.py
python scripts/validate_repository.py --dashboard-dir build/control-dashboard
```

### Export Microsoft 365 evidence

```powershell
pwsh ./scripts/m365/Export-M365Iso27001Evidence.ps1 `
  -TenantId "contoso.onmicrosoft.com" `
  -OutputRoot ./evidence/m365
```

### Run one ISO evidence helper in report-only mode

```powershell
pwsh ./scripts/Get-ISO27001Evidence.ps1 -ControlID A.8.5 -ReportOnly
```

### Run all ISO evidence helper functions to an approved evidence folder

```powershell
pwsh ./scripts/Get-ISO27001Evidence.ps1 `
  -All `
  -OutputPath ./evidence/2026-05 `
  -Owner ITSecurity
```

## Operator checklist

1. Confirm the script purpose and expected outputs.
2. Confirm you are using the correct tenant, subscription, or local repository path.
3. Confirm you have approval to collect the evidence.
4. Use report-only or local validation mode where available.
5. Store generated outputs in a protected evidence folder.
6. Redact tenant, user, device, and client details before external sharing.
7. Record operator, date, command, scope, and evidence location.
8. Do not commit real evidence exports to this repository.

## Current limitations

- Evidence helpers cover selected Microsoft 365 and Entra ID evidence only; they do not prove every Annex A control.
- Several controls remain manual by design because their evidence lives in HR, ITSM, physical security, vulnerability management, Defender, Azure Resource Manager, or supplier-management systems.
- Empty exports can be valid evidence of feature absence, licence limitation, or missing configuration only when the operator records context and control-owner conclusion.

## Completed

- Fixture-based validator tests live in `tests/` and run in CI.
- Minimum role and permission details are recorded in [`permissions-matrix.md`](permissions-matrix.md).
- Synthetic evidence examples live in [`examples/`](examples/).
- Per-script example commands and troubleshooting guidance are documented in [`script-usage-examples.md`](script-usage-examples.md).
- Manual evidence boundaries are documented in [`manual-evidence-playbook.md`](manual-evidence-playbook.md).