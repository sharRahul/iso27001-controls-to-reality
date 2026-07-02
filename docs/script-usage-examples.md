# Script Usage Examples

Use these examples from the repository root. All evidence scripts are intended for approved tenant contexts only. Do not commit real tenant exports back into this repository.

## Local repository validation

Validate the committed matrix and crosswalk:

```bash
python scripts/validate_repository.py
```

Validate and generate a local dashboard:

```bash
python scripts/validate_repository.py --dashboard-dir build/control-dashboard
```

Expected outputs:

```text
build/control-dashboard/control-status-dashboard.md
build/control-dashboard/control-status-dashboard.html
```

## Microsoft 365 evidence exporter

Install Microsoft Graph PowerShell if required:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

Run the read-only exporter:

```powershell
pwsh ./scripts/m365/Export-M365Iso27001Evidence.ps1 `
  -TenantId "contoso.onmicrosoft.com" `
  -OutputRoot ./evidence/m365
```

Useful parameters:

| Parameter | Use |
| --- | --- |
| `-TenantId` | Connect to a specific tenant ID or verified domain. |
| `-OutputRoot` | Choose the parent folder for timestamped evidence output. |
| `-SkipConnect` | Reuse an existing Microsoft Graph session. |
| `-RecentSignInLimit` | Limit the number of sign-in records exported. |
| `-RecentAuditLimit` | Limit the number of directory audit records exported. |

## Modular ISO evidence helper

Run one control in report-only mode:

```powershell
pwsh ./scripts/Get-ISO27001Evidence.ps1 -ControlID A.8.5 -ReportOnly
```

Write one control's output to an approved evidence folder:

```powershell
pwsh ./scripts/Get-ISO27001Evidence.ps1 `
  -ControlID A.8.15 `
  -OutputPath ./evidence/2026-05 `
  -Owner ITSecurity
```

Run all implemented helper functions:

```powershell
pwsh ./scripts/Get-ISO27001Evidence.ps1 `
  -All `
  -OutputPath ./evidence/2026-05 `
  -Owner ITSecurity
```

Run all helper functions without writing local files:

```powershell
pwsh ./scripts/Get-ISO27001Evidence.ps1 -All -ReportOnly
```

## Current helper coverage

| Control | Function | Notes |
| --- | --- | --- |
| A.5.15 | `Get-ConditionalAccess` | Reads Conditional Access policy state. |
| A.5.16 | `Get-PrivilegedRoles` | Reads active and eligible role assignments where available. |
| A.5.18 | `Get-AccessReviewStatus` | Reads access review definitions. |
| A.8.1 | `Get-DeviceComplianceStatus` | Reads Intune managed device compliance. |
| A.8.5 | `Get-MFAStatus` | Reads MFA registration status. |
| A.8.7 | `Get-AntiMalwareConfig` | Reads Exchange malware policies and Intune Defender-related profiles. |
| A.8.12 | `Get-DlpPolicyConfig` | Reads Purview DLP policy configuration. |
| A.8.15 | `Get-AuditLogStatus` | Reads Unified Audit Log status. |
| A.8.16 | `Get-RiskDetections` | Reads recent Entra ID risk detections. |

## Safe operating checklist

Before running evidence scripts:

1. Confirm the tenant and audit period.
2. Confirm the identity has only the required read permissions.
3. Confirm approval to collect tenant configuration and security metadata.
4. Use `-ReportOnly` first where available.
5. Store generated evidence in a protected location.
6. Redact sensitive values before sharing outside the organisation.
7. Record the command, operator, date, and output folder in the evidence index.

## Troubleshooting

| Symptom | Likely cause | Action |
| --- | --- | --- |
| Consent prompt asks for write permissions | Wrong command, module, or script version | Stop and investigate before consenting. |
| `Get-Mg*` command missing | Microsoft Graph submodule not installed or imported | Install `Microsoft.Graph` or the required submodule. |
| Exchange cmdlet missing | Exchange Online session not connected | Run `Connect-ExchangeOnline` with a suitable read role. |
| DLP cmdlet missing | Security and Compliance PowerShell session not connected | Run `Connect-IPPSSession` with a compliance reader role. |
| Empty export | Feature not configured, not licensed, or scope lacks data | Record the limitation and collect manual evidence if needed. |
| Access denied | Missing Graph scope or role | Check `docs/permissions-matrix.md` and reconnect with least privilege. |