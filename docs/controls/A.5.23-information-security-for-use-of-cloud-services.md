# A.5.23 – Information Security for Use of Cloud Services

## Control Objective

Define and operate security requirements for selecting, using, monitoring, and exiting cloud services within the ISMS scope.

## Why It Matters

Cloud services move security responsibilities across the organisation and supplier boundary. Auditors expect evidence that cloud use is governed, suppliers are assessed, shared responsibilities are understood, and cloud controls are monitored throughout the service lifecycle.

## Technical Implementation

### Microsoft 365

1. Record Microsoft 365 service ownership, data residency assumptions, licence tier, and support model.
2. Review Microsoft Service Trust Portal assurance reports and map them to supplier review evidence.
3. Configure tenant security baselines for identity, sharing, audit, DLP, retention, and administrator roles.
4. Review third-party apps, OAuth consent, connectors, and add-ins.

### Azure

1. Define landing zone standards for subscriptions, management groups, tagging, logging, identity, and networking.
2. Use Azure Policy and Defender for Cloud to monitor compliance with approved standards.
3. Record cloud supplier assessments, shared responsibility mapping, and exit considerations.
4. Review public exposure, privileged access, and data protection settings regularly.

### On-Premises

1. Maintain an inventory of cloud services integrated with on-premises identity, networks, backups, or data flows.
2. Document dependencies between cloud services and internal systems.

## Verification Commands

```powershell
# Read-only: export subscribed SKUs and verified domains.
Connect-MgGraph -Scopes "Organization.Read.All","Directory.Read.All"
Get-MgSubscribedSku | Select-Object SkuPartNumber, ConsumedUnits
Get-MgDomain | Select-Object Id, IsVerified, IsDefault
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Cloud service register | CSV/XLSX | Lists approved cloud services, owner, data type, supplier, and risk rating. |
| Shared responsibility matrix | PDF/XLSX | Shows which controls are operated by the provider and the organisation. |
| Supplier assurance review | PDF | Shows review of certifications, audit reports, and contractual obligations. |
| Cloud configuration baseline | CSV/JSON | Shows monitored settings for M365, Azure, or other cloud services. |

## Audit Questions

1. How are new cloud services approved before use?
2. Where is the shared responsibility model documented?
3. How are cloud supplier assurance reports reviewed?
4. How do you monitor cloud configuration drift?
5. What data types are stored in each cloud service?
6. What exit or data return requirements exist for critical cloud services?

## Common Gaps and False Compliance Patterns

- **Supplier certificate only**: Provider certifications are collected but tenant-side responsibilities are not implemented.
- **Shadow cloud services**: Services are used outside procurement, IT, or security review.
- **No exit planning**: Critical data cannot be exported or deleted in a controlled way.
- **No configuration monitoring**: Baselines exist but cloud settings are not reviewed after deployment.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | GV.SC-06 |
| Cyber Essentials | N/A |
| ISO 27001:2022 | Annex A 5.23 |

## Suggested Evidence File Naming

```text
2026-05-01_A.5.23_Process_CloudServiceRegister_CloudSec_v1.xlsx
2026-05-01_A.5.23_Process_SharedResponsibilityMatrix_CloudSec_v1.pdf
```