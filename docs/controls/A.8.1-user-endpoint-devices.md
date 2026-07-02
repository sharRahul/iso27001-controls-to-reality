# A.8.1 – User Endpoint Devices

## Control Objective

Protect information stored on, processed by, and accessible from user endpoint devices by enforcing a security baseline covering encryption, screen lock, supported operating systems, endpoint protection, and compliance monitoring.

## Why It Matters

Endpoints are where credentials are phished, malware executes, and unencrypted data walks out of the building. A fleet with unknown compliance state cannot support any claim about data protection. Auditors will sample devices and expect the baseline to be enforced by policy and measured continuously, not asserted.

## Technical Implementation

### Microsoft 365

1. Enrol corporate devices in Intune and define compliance policies requiring encryption, a supported OS version, screen lock, and Defender health.
2. Enforce BitLocker (Windows) and FileVault (macOS) through Intune configuration profiles, with recovery keys escrowed to Entra ID or Intune.
3. Onboard endpoints to Microsoft Defender for Endpoint and treat onboarding coverage as a tracked metric.
4. Use Conditional Access to require device compliance for access to corporate data, so non-compliant devices are excluded automatically.
5. Define the BYOD position explicitly: either block unmanaged devices or apply app protection policies (MAM) with documented scope.
6. Review the non-compliant device report at an agreed cadence and evidence the follow-up.

### Azure

1. Treat persistent virtual desktops (for example Azure Virtual Desktop) as endpoints: same baseline, same compliance policy, same EDR onboarding.

### On-Premises

1. For devices not yet in Intune, enforce the equivalent baseline via Group Policy (encryption, screen lock, local admin restriction) and record them as an exception with a migration date.
2. Randomise local administrator passwords with LAPS.

## Verification Commands

```powershell
# Read-only: Intune device compliance export
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"
Get-MgDeviceManagementManagedDevice -All |
    Select-Object DeviceName, OperatingSystem, OSVersion, ComplianceState, IsEncrypted, LastSyncDateTime |
    Export-Csv "DeviceCompliance.csv" -NoTypeInformation

# Or use the repository helper (read-only, report-only by default)
./scripts/Get-ISO27001Evidence.ps1 -ControlID A.8.1 -ReportOnly
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Intune compliance policy export | JSON/Screenshot | The baseline requirements as enforced, not as documented |
| Device compliance report | CSV | Per-device compliance state, encryption, OS version, last sync |
| Defender for Endpoint onboarding report | CSV/Screenshot | Coverage of endpoints onboarded to EDR |
| Conditional Access policy requiring compliant device | JSON/Screenshot | Proof non-compliant devices cannot reach corporate data |
| Non-compliance follow-up records | Ticket | Evidence that non-compliant devices are chased and resolved |

## Audit Questions

1. What is your endpoint baseline, and where is it enforced rather than documented?
2. What percentage of the fleet is compliant right now, and how do you know?
3. What happens when a device falls out of compliance; can it still access corporate data?
4. How are BYOD and unmanaged devices handled?
5. Where are encryption recovery keys stored, and who can access them?
6. Show me the last time a non-compliant device was detected and what happened next.

## Common Gaps and False Compliance Patterns

- **Compliance policy without consequence**: Devices marked non-compliant retain full access because no Conditional Access policy uses the compliance signal.
- **Grace periods hiding reality**: Long compliance grace periods make the dashboard green while devices are unencrypted for weeks.
- **BYOD blind spot**: Policies cover corporate devices while personal devices sync mail and files unmanaged.
- **EDR gaps at the edge**: Defender onboarding is near-complete for laptops but servers, VDI, and loan devices are missed.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | Protect: PR.PS-01, PR.DS |
| Cyber Essentials | Secure Configuration |
| ISO 27001:2022 | Annex A 8.1 |

## Suggested Evidence File Naming

```
2026-05-01_A.8.1_Intune_DeviceCompliance_EndpointSec_v1.csv
2026-05-01_A.8.1_MDE_OnboardingReport_EndpointSec_v1.csv
```
