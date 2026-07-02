# Manual Evidence Playbook

Some ISO 27001 controls cannot be evidenced safely or completely through Microsoft Graph. This playbook explains how to collect defensible manual evidence without pretending unsupported automation exists.

Use this alongside the per-control guides in `docs/controls/` and the evidence quality rules in `docs/evidence-collection-guide.md`.

## Manual evidence principles

1. Record who collected the evidence, when, from which source, and for which audit period.
2. Include the system, control ID, scope, owner, and conclusion.
3. Keep screenshots readable and include enough surrounding context to prove source and date.
4. Export structured data where possible, then use screenshots only for settings that cannot be exported.
5. Redact personal data, tenant identifiers, secrets, internal hostnames, and client names unless they are required for the audit.
6. Link every evidence item to a ticket, review record, risk, exception, or control owner sign-off where possible.

## Manual-only and partially manual controls

| Control | Why manual evidence is needed | Primary manual evidence |
| --- | --- | --- |
| A.5.1 Policies for information security | Management approval and publication cannot be proven through tenant configuration alone. | Approved policy, policy register, acknowledgement report. |
| A.5.2 Information security roles and responsibilities | Accountability depends on organisational role design and HR records. | RACI matrix, role descriptions, admin role review. |
| A.5.23 Information security for use of cloud services | Supplier assurance, shared responsibility, and service approval are governance artefacts. | Cloud service register, supplier review, shared responsibility matrix. |
| A.5.25 Assessment and decision on information security events | Tool alerts do not prove analyst decision quality. | Triage SOP, closed ticket samples, quality review. |
| A.5.28 Collection of evidence | Evidence handling relies on process, access control, and chain of custody. | Evidence SOP, chain-of-custody records, evidence store access review. |
| A.6.1 Screening | Screening evidence is held in HR systems and must be privacy-minimised. | Screening policy, completion report, supplier screening clause. |
| A.6.2 Terms and conditions of employment | Contractual obligations are HR/legal artefacts. | Employment security clauses, signed acknowledgements, contractor terms. |
| A.6.5 Responsibilities after termination or change of employment | Offboarding and movers require HR, ITSM, facilities, and IAM evidence. | Leaver checklist, account disable evidence, asset return record. |
| A.6.6 Confidentiality or non-disclosure agreements | NDA evidence is legal/HR/supplier-management evidence. | NDA template, signed register, supplier confidentiality clauses. |
| A.7.4 Physical security monitoring | Physical access and CCTV systems are outside Microsoft Graph. | Door access review, visitor logs, CCTV policy, incident records. |
| A.8.8 Management of technical vulnerabilities | Defender vulnerability data is exposed through Defender or vulnerability-management tooling, not Graph v1.0. | Vulnerability dashboard, remediation tickets, SLA ageing report. |
| A.8.23 Web filtering | Web-filtering configuration depends on Defender portal, DNS, proxy, firewall, or secure web gateway tooling. | Web filtering policy, blocked-event sample, bypass register. |
| A.8.24 Use of cryptography | Key, certificate, TLS, and algorithm evidence spans Azure Resource Manager, application platforms, and certificate inventory. | Key Vault export, certificate inventory, TLS configuration evidence. |
| A.8.32 Change management | CAB approvals and post-implementation reviews normally live in ITSM tooling. | Change log export, CAB minutes, emergency change review. |

## Evidence collection workflow

1. Confirm the control and audit period.
2. Identify the source system or process owner.
3. Collect the primary evidence using export, screenshot, or report.
4. Collect supporting evidence showing approval, review, remediation, or sign-off.
5. Save evidence using the repository naming convention.
6. Record the evidence reference in the SoA or control tracker.
7. Ask the control owner to confirm the evidence is accurate and complete.
8. Raise remediation items for gaps, expired reviews, missing approvals, or overdue exceptions.

## Screenshot standard

For screenshots, include:

- Browser or portal context where possible.
- Setting name and current value.
- Date of capture or audit-period note.
- Enough rows or columns to prove scope.
- Redaction of personal or sensitive information.

Do not rely on a cropped image that shows only a green tick or status banner without source context.

## Ticket and review sample standard

For tickets, CAB minutes, access reviews, or remediation records, capture:

- Ticket or review ID.
- Owner and approver.
- Opened, approved, implemented, and closed dates.
- Scope and affected system.
- Decision or conclusion.
- Linked risk, exception, or change reference.

## File naming note

The documentation examples use ISO dotted control IDs such as `A.8.15`. Some scripts generate filesystem-friendly names using hyphenated control IDs such as `A-8-15`. Either form is acceptable if the evidence index maps the file back to the exact ISO control ID.