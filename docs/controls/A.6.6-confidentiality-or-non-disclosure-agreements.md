# A.6.6 – Confidentiality or Non-Disclosure Agreements

## Control Objective

Use confidentiality or non-disclosure agreements to protect information before, during, and after employment, contracting, or supplier engagement.

## Why It Matters

Confidentiality controls support legal enforceability and reduce ambiguity around how sensitive information must be handled. Auditors expect agreements to be appropriate for the information shared, reviewed periodically, and retained as evidence.

## Technical Implementation

### Microsoft 365

1. Store NDA templates and signed records in a restricted HR, legal, or supplier-management library.
2. Use sensitivity labels to protect templates and signed agreements where licensed.
3. Link supplier NDA status to onboarding or procurement approval records.

### Azure

1. Require NDAs for third parties with access to Azure subscriptions, support channels, repositories, or operational data.
2. Record access approval evidence alongside the relevant confidentiality agreement.

### On-Premises

1. Require confidentiality terms for staff, contractors, visitors, and suppliers where information exposure exists.
2. Review agreements when legal, regulatory, client, or service-scope requirements change.

## Verification Commands

```powershell
# No technical command proves NDA suitability.
# Use HR, legal, or supplier-management exports with sensitive details redacted.
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| NDA template | PDF | Shows confidentiality terms and review date. |
| Signed NDA register | CSV/XLSX | Shows who has signed and which version applies. |
| Supplier confidentiality clause sample | PDF | Shows third-party obligations. |
| Review record | PDF | Shows legal/security review of templates and clauses. |

## Audit Questions

1. Which roles, suppliers, and visitors require confidentiality agreements?
2. Who owns and reviews NDA templates?
3. How are signed agreements retained and protected?
4. What happens when a supplier refuses the standard terms?
5. Are confidentiality obligations still valid after termination?
6. How are agreements updated when data handling requirements change?

## Common Gaps and False Compliance Patterns

- **Agreement exists but scope is unclear**: The NDA does not cover the information actually shared.
- **Supplier clauses not reviewed**: Supplier confidentiality terms are accepted without security/legal review.
- **No signed register**: Templates exist but completed agreements cannot be found.
- **Expired or outdated terms**: Agreements pre-date current cloud, remote working, or data protection requirements.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | GV.RR-01 |
| Cyber Essentials | User Access Control |
| ISO 27001:2022 | Annex A 6.6 |

## Suggested Evidence File Naming

```text
2026-05-01_A.6.6_Process_NDARegister_HRMgr_v1.xlsx
2026-05-01_A.6.6_Process_NDATemplateReview_Legal_v1.pdf
```