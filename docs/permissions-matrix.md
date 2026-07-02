# Permissions Matrix for Evidence Scripts

This matrix records the minimum Microsoft Graph scopes and Entra roles needed to run each repository script. Request the least privilege that covers the functions you intend to run: if you only need one control's evidence, connect with only that function's scopes. All scopes listed are read-only; no script in this repository requests write permissions.

## `scripts/validate_repository.py`

Runs locally against committed CSV files. No tenant access, no Graph scopes, no Entra roles.

## `scripts/m365/Export-M365Iso27001Evidence.ps1`

| Requirement | Value |
| --- | --- |
| Graph scopes | `AuditLog.Read.All`, `Directory.Read.All`, `Policy.Read.All`, `Reports.Read.All`, `RoleManagement.Read.Directory` |
| Minimum Entra role | Security Reader (Global Reader also works; do not use Global Administrator for evidence collection) |
| Licensing notes | Sign-in log access requires Entra ID P1 or above |

## `scripts/Get-ISO27001Evidence.ps1`

| Function | Control | Graph scopes (delegated, read-only) | Minimum role | Notes |
| --- | --- | --- | --- | --- |
| `Get-MFAStatus` | A.8.5 | `Reports.Read.All`, `UserAuthenticationMethod.Read.All` | Reports Reader or Security Reader | |
| `Get-ConditionalAccess` | A.5.15 | `Policy.Read.All` | Security Reader | |
| `Get-AuditLogStatus` | A.8.15 | None (Exchange Online PowerShell) | View-Only Organization Management (Exchange role group) or Global Reader | Uses `Get-AdminAuditLogConfig` and `Get-OrganizationConfig` |
| `Get-PrivilegedRoles` | A.5.16 | `RoleManagement.Read.Directory`, `Directory.Read.All` | Security Reader | PIM-eligible assignments require Entra ID P2 |
| `Get-AntiMalwareConfig` | A.8.7 | `DeviceManagementConfiguration.Read.All` plus Exchange Online PowerShell | Intune Read Only Operator plus View-Only Organization Management | |
| `Get-AccessReviewStatus` | A.5.18 | `AccessReview.Read.All` | Security Reader | Requires Entra ID P2 or Entra ID Governance |
| `Get-DeviceComplianceStatus` | A.8.1 | `DeviceManagementManagedDevices.Read.All` | Intune Read Only Operator | |
| `Get-DlpPolicyConfig` | A.8.12 | None (Security and Compliance PowerShell via `Connect-IPPSSession`) | View-Only Organization Management (compliance role group) or Global Reader | Read-only `Get-DlpCompliancePolicy` only |
| `Get-RiskDetections` | A.8.16 | `IdentityRiskEvent.Read.All` | Security Reader | Requires Entra ID P2 |

## Operator guidance

1. Prefer delegated (interactive) sign-in with a least-privilege reader role over app-only credentials for ad hoc evidence collection.
2. If an app registration is used for scheduled collection, grant only the application permissions equivalent to the scopes above and record the app in the asset and secrets registers.
3. Consent prompts should only ever show read scopes. If a consent prompt requests a write scope, stop and investigate before continuing.
4. Record which identity ran a collection, when, and with what scopes, alongside the evidence output.
