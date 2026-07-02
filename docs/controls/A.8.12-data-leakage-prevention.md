# A.8.12 – Data Leakage Prevention

## Control Objective

Detect and reduce unauthorised disclosure, transfer, or sharing of sensitive information through technical and procedural data leakage prevention controls.

## Why It Matters

Sensitive data can leave the organisation through email, collaboration tools, cloud storage, unmanaged devices, or misconfigured sharing. Auditors expect evidence that DLP controls are scoped, tested, tuned, reviewed, and aligned to the organisation's data classification and risk profile.

## Technical Implementation

### Microsoft 365

1. Define sensitive information types and data classes in scope, such as personal data, financial data, health data, credentials, and client confidential data.
2. Create Microsoft Purview DLP policies for Exchange, SharePoint, OneDrive, and Teams.
3. Start new policies in test or audit-only mode before enforcement.
4. Review DLP alerts, false positives, user overrides, and incident reports.
5. Align DLP policies with sensitivity labels and data classification guidance.

### Azure

1. Use Defender for Cloud and storage account configuration to monitor public exposure and insecure data stores.
2. Apply private endpoints, network restrictions, and logging for sensitive storage.
3. Use Key Vault and managed identities for secrets and connection strings.

### On-Premises

1. Define handling requirements for removable media, printing, local file shares, and email gateways.
2. Monitor approved channels for sensitive data movement where tooling exists.

## Verification Commands

```powershell
# Read-only: export Purview DLP policy summary after connecting to Security and Compliance PowerShell.
Connect-IPPSSession
Get-DlpCompliancePolicy | Select-Object Name, Mode, Enabled, WhenChanged
Get-DlpComplianceRule | Select-Object Name, Policy, Disabled, Mode
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| DLP policy export | CSV/JSON | Shows policy scope, mode, rules, and workloads. |
| DLP incident sample | PDF/Screenshot | Shows a safe test match or incident workflow. |
| False-positive review | XLSX/PDF | Shows tuning decisions and user override review. |
| Data classification mapping | PDF/XLSX | Shows DLP rules map to data classes and handling requirements. |

## Audit Questions

1. Which sensitive data types are covered by DLP?
2. Which workloads and endpoints are in scope?
3. Are policies in test, audit-only, or enforce mode?
4. How are DLP incidents reviewed and escalated?
5. How are false positives tuned without weakening control intent?
6. How are business-approved exceptions recorded?

## Common Gaps and False Compliance Patterns

- **DLP in test mode forever**: Policies detect but do not protect in-scope data where enforcement is required.
- **No incident review**: Alerts are generated but not triaged.
- **Over-broad exceptions**: Large groups or domains bypass DLP without risk acceptance.
- **No data classification link**: DLP rules do not map to approved data handling requirements.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | PR.DS-02 |
| Cyber Essentials | N/A |
| ISO 27001:2022 | Annex A 8.12 |

## Suggested Evidence File Naming

```text
2026-05-01_A.8.12_Purview_DLPPolicy-Export_DPO_v1.csv
2026-05-01_A.8.12_Purview_DLPIncidentSample_DPO_v1.pdf
```