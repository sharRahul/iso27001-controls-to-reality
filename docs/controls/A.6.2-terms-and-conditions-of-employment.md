# A.6.2 – Terms and Conditions of Employment

## Control Objective

Ensure employment and contractor terms clearly define information security responsibilities before access to information assets is granted.

## Why It Matters

Security obligations must be enforceable through employment or contractual terms, not just informal guidance. Auditors expect evidence that employees and contractors understand confidentiality, acceptable use, data protection, and post-employment obligations.

## Technical Implementation

### Microsoft 365

1. Make acceptable use and information security policies available during onboarding.
2. Capture policy acknowledgement before enabling normal productivity access where practical.
3. Retain signed acknowledgements in HR or an approved document management system.

### Azure

1. Require privileged cloud users to accept administrator responsibilities before role assignment.
2. Link access approval tickets to evidence of employment or contractor security obligations.

### On-Premises

1. Include confidentiality, acceptable use, asset handling, remote working, and monitoring clauses in employment or contractor documents.
2. Confirm leavers are reminded of continuing confidentiality obligations.

## Verification Commands

```powershell
# No tenant command proves employment terms.
# Use HR or contract management evidence with personal data minimised.
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Employment security clause template | PDF | Shows mandatory security responsibilities in employment terms. |
| Contractor agreement template | PDF | Shows equivalent obligations for non-employees. |
| Signed acknowledgement sample | PDF | Shows staff accepted policies and obligations. |
| Onboarding checklist | CSV/PDF | Shows security terms are completed before access is granted. |

## Audit Questions

1. Which information security responsibilities are included in employment terms?
2. Are contractors and temporary workers covered?
3. How is acknowledgement captured and retained?
4. How are staff informed of policy changes after employment starts?
5. What continuing obligations remain after termination?
6. How are exceptions handled when contractual terms cannot be amended?

## Common Gaps and False Compliance Patterns

- **Employee-only coverage**: Contractors and suppliers are missed.
- **Policy link but no acceptance**: Staff are told where policies live but no acknowledgement is recorded.
- **Old contract templates**: Terms do not reflect current remote working, cloud, and data protection expectations.
- **No post-employment reminder**: Leavers are not reminded of confidentiality obligations.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | GV.PO-02 |
| Cyber Essentials | N/A |
| ISO 27001:2022 | Annex A 6.2 |

## Suggested Evidence File Naming

```text
2026-05-01_A.6.2_Process_EmploymentTerms_HRMgr_v1.pdf
2026-05-01_A.6.2_Process_PolicyAcknowledgement_HRMgr_v1.csv
```