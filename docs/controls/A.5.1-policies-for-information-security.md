# A.5.1 – Policies for Information Security

## Control Objective

Define, approve, publish, and maintain information security policies that set management direction for protecting information and supporting the ISMS.

## Why It Matters

Policies are the formal baseline for expected behaviour, technical standards, and control ownership. Auditors use them to confirm that security requirements are approved by leadership, communicated to relevant people, and reviewed on a defined cadence.

## Technical Implementation

### Microsoft 365

1. Store approved policies in a controlled SharePoint library with versioning, retention, and restricted edit rights.
2. Publish read-only versions to all employees through SharePoint, Teams, or Viva Engage.
3. Use Microsoft Forms, LMS exports, or HR systems to capture policy acknowledgement.
4. Protect policy documents with sensitivity labels where licensed.

### Azure

1. Store security standards for Azure services alongside the ISMS policy set.
2. Link cloud standards to Azure Policy initiatives and Defender for Cloud recommendations.
3. Keep policy exceptions in a tracked risk or exception register.

### On-Premises

1. Publish equivalent policies for endpoint use, network access, physical security, removable media, and backup handling.
2. Ensure Group Policy or endpoint management settings trace back to approved policy requirements.

## Verification Commands

```powershell
# Read-only: list SharePoint policy library metadata through Graph where permitted.
Connect-MgGraph -Scopes "Sites.Read.All"
Get-MgSite -Search "Information Security Policies"
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Approved information security policy | PDF | Shows board or senior management approval, owner, version, and review date. |
| Policy register | CSV/XLSX | Lists policy owner, version, review cadence, next review date, and publication location. |
| Staff acknowledgement report | CSV/PDF | Shows communication and acceptance by in-scope users. |
| Policy exception register | CSV/XLSX | Shows deviations are risk-assessed, approved, and time-bound. |

## Audit Questions

1. Who owns the information security policy suite?
2. When was the policy last approved and by whom?
3. How are employees and contractors made aware of the policy?
4. How are exceptions approved, tracked, and reviewed?
5. How do technical standards map back to the policy?
6. What triggers an out-of-cycle policy review?

## Common Gaps and False Compliance Patterns

- **Policy exists but is not approved**: Draft policy documents do not prove management direction.
- **No acknowledgement evidence**: A published document is weaker evidence than a published document plus acceptance records.
- **Policy not mapped to controls**: The policy says security is important but does not link to ownership, standards, or enforcement.
- **Review date expired**: An old policy may not reflect current services, risks, or legal obligations.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | GV.PO-01 |
| Cyber Essentials | N/A |
| ISO 27001:2022 | Annex A 5.1 and Clause 5.2 |

## Suggested Evidence File Naming

```text
2026-05-01_A.5.1_Process_InfoSecPolicy_CISO_v1.pdf
2026-05-01_A.5.1_Process_PolicyRegister_CISO_v1.xlsx
```