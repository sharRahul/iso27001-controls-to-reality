# A.5.9 – Inventory of Information and Other Associated Assets

## Control Objective

Maintain an accurate, owned, and regularly reviewed inventory of information and other associated assets, so the organisation knows what it must protect and who is responsible for protecting it.

## Why It Matters

Every other control depends on knowing what exists: you cannot patch, monitor, back up, or restrict access to an asset you have not recorded. Auditors treat an incomplete or stale asset register as a systemic weakness because it undermines the risk assessment and the Statement of Applicability. Cloud sprawl makes this worse; unrecorded tenants, subscriptions, and SaaS services are the most common gap.

## Technical Implementation

### Microsoft 365

1. Record the M365 tenant itself as an asset with a named owner, including tenant ID placeholder, licensing level, and the services in use.
2. Export the Entra ID device inventory (Entra admin centre, Devices, All devices) and reconcile it with the asset register at least quarterly.
3. Use Intune managed device exports as the authoritative source for user endpoint assets where Intune is deployed.
4. Record SharePoint sites or Teams that hold business-critical or classified data as information assets with owners and classifications.

### Azure

1. Record every subscription and management group in the register with a named owner and business purpose.
2. Use Azure Resource Graph to enumerate resources: tag resources with `owner`, `environment`, and `data-classification` tags and enforce tagging with Azure Policy.
3. Reconcile Azure resource exports against the register quarterly; investigate resources with no owner tag.

### On-Premises

1. Maintain servers, network devices, and appliances in the CMDB or asset register with owner, location, OS, and support status.
2. Reconcile Active Directory computer objects against the register; disable and investigate unknown objects.
3. Include unsupported or end-of-life systems explicitly; these feed the risk register rather than being hidden.

## Verification Commands

```powershell
# Read-only: export Entra ID devices for reconciliation
Connect-MgGraph -Scopes "Device.Read.All"
Get-MgDevice -All | Select-Object DisplayName, OperatingSystem, ApproximateLastSignInDateTime |
    Export-Csv "EntraDevices.csv" -NoTypeInformation

# Read-only: export Intune managed devices
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"
Get-MgDeviceManagementManagedDevice -All | Select-Object DeviceName, OperatingSystem, ComplianceState |
    Export-Csv "IntuneDevices.csv" -NoTypeInformation

# Read-only: enumerate Azure resources with tags (requires Az module)
Get-AzResource | Select-Object Name, ResourceType, ResourceGroupName, Tags |
    Export-Csv "AzureResources.csv" -NoTypeInformation
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Asset register export | CSV/XLSX | Full register showing asset, owner, classification, location, and review date |
| Reconciliation record | XLSX/Ticket | Evidence that directory and cloud exports were compared with the register and differences actioned |
| Quarterly review sign-off | PDF/Ticket | Named owner confirming the register was reviewed and is accurate |
| Tagging policy compliance report | CSV/Screenshot | Azure Policy compliance for mandatory owner and classification tags |

## Audit Questions

1. Who owns the asset register and how often is it reviewed?
2. How do new assets, including cloud subscriptions and SaaS services, get added to the register?
3. Show me the register entry for a critical system, including its owner and classification.
4. How do you detect assets that exist in the estate but not in the register?
5. How are disposed or decommissioned assets removed, and is disposal evidenced?
6. Are unsupported or end-of-life systems recorded, and where is their risk accepted?

## Common Gaps and False Compliance Patterns

- **Register exists, never reconciled**: The register was populated once and has drifted from reality; reconciliation evidence is missing.
- **Hardware only**: Information assets, data sets, SaaS services, and cloud tenants are absent because the register grew out of an IT hardware list.
- **No owners**: Assets are listed without a named owner, so review and classification obligations fall to nobody.
- **Shadow cloud**: Subscriptions or tenants created outside procurement never reach the register.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | Identify: ID.AM-01 |
| Cyber Essentials | N/A (supports Secure Configuration theme) |
| ISO 27001:2022 | Annex A 5.9 |

## Suggested Evidence File Naming

```
2026-05-01_A.5.9_Process_AssetRegister_ITMgr_v1.csv
2026-05-01_A.5.9_Azure_ResourceReconciliation_ITMgr_v1.xlsx
```
