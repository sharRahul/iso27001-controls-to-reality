# A.8.9 – Configuration Management

## Control Objective

Establish, document, implement, monitor, and review secure configurations for hardware, software, services, and networks, so systems run in a known hardened state and drift is detected and corrected.

## Why It Matters

Most exploited weaknesses are configuration weaknesses: default credentials, unnecessary services, disabled security features, and permissive sharing settings. Without a defined baseline there is no way to say a system is misconfigured, and without drift detection a system hardened once will quietly degrade. Auditors want the baseline, the enforcement mechanism, and the drift-handling evidence as a set.

## Technical Implementation

### Microsoft 365

1. Define the M365 tenant baseline (for example based on CIS Microsoft 365 Benchmark) covering Entra ID, Exchange, SharePoint, and Teams settings.
2. Enforce endpoint baselines with Intune security baselines and configuration profiles; apply CIS benchmark settings to Windows endpoints.
3. Track Microsoft Secure Score monthly and record accepted deviations with justification.
4. Control configuration changes to the tenant through the change management process (A.8.32) so baseline changes are approved and traceable.

### Azure

1. Assign Azure Policy initiatives (for example Microsoft cloud security benchmark) at management group scope so new subscriptions inherit the baseline automatically.
2. Enable Defender for Cloud recommendations and treat persistent non-compliance as either remediation work or a documented exception.
3. Deploy infrastructure through code (Bicep, Terraform, ARM) so configuration is versioned, reviewed, and reproducible.
4. Review the Azure Policy compliance report monthly and assign remediation with owners and dates.

### On-Premises

1. Maintain hardened build documents or golden images for server and workstation builds.
2. Apply CIS or vendor hardening baselines through Group Policy and document deviations.
3. Detect drift by re-scanning against the baseline (for example with SCAP tooling or configuration management tools) on a defined cadence.

## Verification Commands

```powershell
# Read-only: Azure Policy compliance summary (requires Az module)
Get-AzPolicyStateSummary | Select-Object -ExpandProperty Results

# Read-only: Intune configuration profiles
Connect-MgGraph -Scopes "DeviceManagementConfiguration.Read.All"
Get-MgDeviceManagementDeviceConfiguration -All | Select-Object DisplayName, LastModifiedDateTime
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Documented baseline | PDF/Repo link | The approved secure configuration standard per platform |
| Azure Policy compliance report | CSV/Screenshot | Compliance state against the assigned initiatives |
| Intune baseline and profile export | JSON/Screenshot | Enforced endpoint configuration |
| Secure Score trend | Screenshot | Monthly score with commentary on changes |
| Deviation and exception register | XLSX | Approved deviations from baseline with owner and expiry |
| Drift remediation records | Ticket | Evidence that detected drift was corrected or risk accepted |

## Audit Questions

1. What is the approved secure baseline for a Windows endpoint, and where is it enforced?
2. How would you detect if someone disabled a security setting on a production server?
3. Show me the current Azure Policy compliance position and the remediation plan for non-compliant resources.
4. Who approves a deviation from the baseline, and where is it recorded?
5. How do new systems inherit the baseline; is it automatic or manual?
6. When was the baseline last reviewed against the current benchmark version?

## Common Gaps and False Compliance Patterns

- **Baseline as aspiration**: A hardening document exists but nothing enforces it; sampled systems do not match it.
- **Policy assigned in audit mode**: Azure Policy assignments use audit effects with no remediation loop, so the compliance report is a wish list.
- **Exception decay**: Deviations approved once, years ago, with no expiry or re-review.
- **Drift invisible between builds**: Systems match the baseline on day one but nothing re-checks them afterwards.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | Protect: PR.PS-01 |
| Cyber Essentials | Secure Configuration |
| ISO 27001:2022 | Annex A 8.9; related A.8.32 |

## Suggested Evidence File Naming

```
2026-05-01_A.8.9_Azure_PolicyCompliance_ITMgr_v1.csv
2026-05-01_A.8.9_Intune_BaselineExport_ITMgr_v1.json
```
