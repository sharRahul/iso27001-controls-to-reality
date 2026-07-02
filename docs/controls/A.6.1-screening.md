# A.6.1 – Screening

## Control Objective

Perform appropriate background verification for personnel before employment or engagement, proportionate to role, legal requirements, and information security risk.

## Why It Matters

People with privileged access, sensitive data access, or trusted operational roles can create significant security and compliance risk. Auditors expect screening requirements to be defined, applied consistently, and evidenced without exposing unnecessary personal data.

## Technical Implementation

### Microsoft 365

1. Store screening completion status in HR or onboarding systems, not in public collaboration spaces.
2. Use Entra ID joiner workflows only after required HR pre-employment checks are complete.
3. Restrict access to screening records to HR and authorised security/legal reviewers.

### Azure

1. Require enhanced screening for cloud administrators and subscription owners where legally permitted.
2. Link privileged cloud access approval to completion of required screening.

### On-Premises

1. Apply role-based screening for system administrators, facilities staff, service desk, and contractors.
2. Confirm third-party suppliers apply equivalent screening where contractually required.

## Verification Commands

```powershell
# No tenant command can prove screening completion safely.
# Use HR exports with only the minimum metadata needed for audit evidence.
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Screening policy | PDF | Defines screening types, timing, role categories, and legal/privacy requirements. |
| Completion report | CSV/PDF | Shows screening completed for sampled staff without exposing detailed background data. |
| Supplier screening clause | PDF | Shows third-party screening obligations where relevant. |
| Exception record | PDF/XLSX | Shows approved deviations and compensating controls. |

## Audit Questions

1. Which roles require screening before access is granted?
2. How do screening requirements differ for privileged or sensitive roles?
3. How is screening evidence protected?
4. How are contractors and third parties covered?
5. What happens when screening cannot be completed before start date?
6. How are exceptions approved?

## Common Gaps and False Compliance Patterns

- **Screening after access**: Accounts are created and granted access before checks are complete.
- **No contractor coverage**: Employees are screened but contractors and suppliers are not.
- **Overexposed HR data**: Detailed personal screening results are shared unnecessarily.
- **No role-based model**: All roles are treated the same despite different risk levels.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | GV.PO-02 |
| Cyber Essentials | N/A |
| ISO 27001:2022 | Annex A 6.1 |

## Suggested Evidence File Naming

```text
2026-05-01_A.6.1_Process_ScreeningPolicy_HRMgr_v1.pdf
2026-05-01_A.6.1_Process_ScreeningCompletionReport_HRMgr_v1.csv
```