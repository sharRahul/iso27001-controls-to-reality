# Evidence Collection Guide

This guide explains how to collect evidence that proves ISO 27001 control implementation in a practical environment.

## Evidence quality criteria

Good evidence should be:

- Relevant: directly supports the control objective.
- Current: collected within the audit period or review cycle.
- Complete: includes the configuration, owner, date, scope, and result.
- Traceable: links to tickets, approvals, risks, exceptions, or change records.
- Repeatable: another administrator could collect the same evidence using the same steps.
- Protected: stored in a controlled location with appropriate access permissions.

## Evidence types

| Evidence type | Examples | Use when |
| --- | --- | --- |
| Configuration export | Conditional Access export, Defender policy export, firewall rules | Proving a technical setting exists |
| Screenshot | Admin portal policy page, alert rule page, retention page | A system cannot export structured configuration |
| Log entry | Sign-in event, alert, audit log, SIEM incident | Proving control operation |
| Ticket | Change approval, remediation ticket, risk acceptance | Proving governance and workflow |
| Report | Vulnerability scan, endpoint compliance, access review | Proving monitoring or periodic review |
| Policy or procedure | Approved policy, SOP, playbook | Proving management direction and repeatability |
| Meeting or review record | CAB minutes, access review approval, tabletop report | Proving oversight and accountability |

## Minimum evidence metadata

Every evidence item should capture:

- Control ID
- Control title
- Evidence owner
- System or process name
- Date collected
- Collection method
- Audit period covered
- Result or conclusion
- Linked ticket, risk, or exception reference
- Reviewer and review date

## Recommended folder structure

```text
evidence/
├── A.5-organisational-controls/
├── A.6-people-controls/
├── A.7-physical-controls/
└── A.8-technological-controls/
```

## Collection workflow

1. Confirm the ISMS scope and whether the control is applicable.
2. Identify the system owner and evidence owner.
3. Collect the primary evidence from the source system.
4. Capture supporting evidence such as ticket approval, exception approval, or review sign-off.
5. Save the evidence using the naming convention in the README.
6. Record the evidence reference in the SoA or control tracker.
7. Ask the control owner to review and confirm accuracy.
8. Track gaps as remediation actions with owners and dates.

## Example: A.8.15 Logging

| Field | Example |
| --- | --- |
| Control | A.8.15 Logging |
| Objective | Logs are generated, retained, and available for monitoring and investigation. |
| Technical evidence | Microsoft Purview audit settings, Sentinel connector status, log retention settings, sample security event. |
| Governance evidence | Logging standard, SIEM monitoring procedure, ticket approving retention configuration. |
| Review question | Are critical systems sending logs to a monitored location, and is retention aligned to policy? |
| Common gap | Logs exist locally but are not centralised, monitored, or retained for the required period. |

## Example: A.8.5 Secure authentication

| Field | Example |
| --- | --- |
| Control | A.8.5 Secure authentication |
| Objective | Authentication mechanisms are strong enough for the risk profile. |
| Technical evidence | Conditional Access policy export, MFA registration report, legacy authentication sign-in logs. |
| Governance evidence | Access control policy, privileged access procedure, break-glass account review. |
| Review question | Are all users and privileged roles protected by MFA or an approved compensating control? |
| Common gap | Break-glass accounts are excluded from MFA but not monitored or reviewed. |

## Evidence review questions

For each control, ask:

- Does the evidence prove design, implementation, and operation?
- Is the evidence in scope for the audited environment?
- Can the evidence be reproduced?
- Is the evidence recent enough?
- Are exceptions documented and approved?
- Are remediation actions tracked to completion?

## Evidence redaction rules

Before storing or sharing evidence, redact:

- User personal data not needed for the audit.
- Tenant IDs, subscription IDs, and internal hostnames where not required.
- Public IP addresses if they are not necessary.
- Secrets, tokens, certificates, passwords, and recovery keys.
- Client names or third-party data where disclosure is not approved.

## Auditor pack preparation

For each audit cycle, prepare:

- Updated SoA.
- Control mapping matrix.
- Evidence index.
- Exception register.
- Risk treatment plan references.
- Internal audit findings and closure evidence.
- Management review evidence.

## Important note

Evidence requirements depend on ISMS scope, audit period, certification body expectations, contractual obligations, and regulatory context. Treat this guide as a practical starting point and tailor it to your organisation.
