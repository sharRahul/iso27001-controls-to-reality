# Statement of Applicability Template

> Template for documenting ISO 27001:2022 Annex A control applicability, implementation status, justification, evidence, and ownership.

## Document control

| Field | Value |
| --- | --- |
| Organisation | `<organisation-name>` |
| ISMS scope | `<scope-summary>` |
| Version | `0.1` |
| Owner | `<isms-owner>` |
| Approved by | `<approver>` |
| Approval date | `<yyyy-mm-dd>` |
| Review cycle | `<annual / semi-annual / other>` |
| Next review date | `<yyyy-mm-dd>` |

## Applicability definitions

| Value | Meaning |
| --- | --- |
| Applicable | The control is relevant to the ISMS scope and requires implementation or treatment. |
| Not Applicable | The control is not relevant to the ISMS scope and has a documented justification. |
| Partially Applicable | The control applies only to a defined business unit, system, location, supplier, or process. |

## Implementation status definitions

| Status | Meaning |
| --- | --- |
| Not Started | No design or implementation exists. |
| Designed | Approach is documented but not fully implemented. |
| Implemented | Control is operating. |
| Evidenced | Evidence has been collected. |
| Reviewed | Evidence has been reviewed and accepted. |
| Exception | A risk acceptance, compensating control, or remediation action is required. |

## Statement of Applicability register

| Control ID | Control title | Applicability | Justification | Implementation summary | Evidence reference | Control owner | Review frequency | Status | Risk or exception reference |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A.5.1 | Policies for information security | Applicable | Security policies are required for ISMS governance. | Approved policy set with owner and review cycle. | `<evidence-link>` | `<owner>` | Annual | Designed | `<risk/ref>` |
| A.5.9 | Inventory of information and other associated assets | Applicable | Asset inventory is required to manage risk and ownership. | CMDB or asset register with ownership and periodic review. | `<evidence-link>` | `<owner>` | Quarterly | Designed | `<risk/ref>` |
| A.5.15 | Access control | Applicable | Access must be restricted based on business need. | RBAC, least privilege, joiner/mover/leaver workflow. | `<evidence-link>` | `<owner>` | Quarterly | Designed | `<risk/ref>` |
| A.5.23 | Information security for use of cloud services | Applicable | Cloud services are used within the ISMS scope. | Cloud service register, shared responsibility review, security baseline. | `<evidence-link>` | `<owner>` | Semi-annual | Designed | `<risk/ref>` |
| A.5.24 | Information security incident management planning and preparation | Applicable | Incident management is required to respond to security events. | IR plan, severity model, escalation matrix, tabletop exercise. | `<evidence-link>` | `<owner>` | Semi-annual | Designed | `<risk/ref>` |
| A.6.3 | Information security awareness, education and training | Applicable | Users need awareness of information security responsibilities. | Annual security awareness and role-based training. | `<evidence-link>` | `<owner>` | Annual | Designed | `<risk/ref>` |
| A.7.4 | Physical security monitoring | Partially Applicable | Applies where physical offices or secure rooms are in scope. | Access logs, visitor process, facilities review. | `<evidence-link>` | `<owner>` | Quarterly | Designed | `<risk/ref>` |
| A.8.1 | User endpoint devices | Applicable | Endpoints access organisational information. | Endpoint baseline, encryption, EDR, compliance monitoring. | `<evidence-link>` | `<owner>` | Monthly | Designed | `<risk/ref>` |
| A.8.2 | Privileged access rights | Applicable | Privileged accounts present elevated risk. | PIM, separate admin accounts, MFA, access reviews. | `<evidence-link>` | `<owner>` | Monthly | Designed | `<risk/ref>` |
| A.8.5 | Secure authentication | Applicable | Strong authentication is required to protect systems and data. | MFA, Conditional Access, legacy authentication blocking. | `<evidence-link>` | `<owner>` | Monthly | Designed | `<risk/ref>` |
| A.8.7 | Protection against malware | Applicable | Endpoint and email malware risk is in scope. | Defender AV/EDR, ASR rules, alerting, response process. | `<evidence-link>` | `<owner>` | Monthly | Designed | `<risk/ref>` |
| A.8.8 | Management of technical vulnerabilities | Applicable | Vulnerabilities must be identified and remediated. | Vulnerability scanning, patch SLAs, exception tracking. | `<evidence-link>` | `<owner>` | Monthly | Designed | `<risk/ref>` |
| A.8.12 | Data leakage prevention | Applicable | Sensitive information requires protection against leakage. | DLP policies, sensitivity labels, incident review. | `<evidence-link>` | `<owner>` | Quarterly | Designed | `<risk/ref>` |
| A.8.15 | Logging | Applicable | Logs are required for detection, investigation, and evidence. | Audit logs enabled and centralised into SIEM or log platform. | `<evidence-link>` | `<owner>` | Monthly | Designed | `<risk/ref>` |
| A.8.16 | Monitoring activities | Applicable | Security events require monitoring and response. | SIEM rules, alerts, triage queue, SOC process. | `<evidence-link>` | `<owner>` | Monthly | Designed | `<risk/ref>` |
| A.8.24 | Use of cryptography | Applicable | Encryption is required for confidentiality and integrity. | Disk encryption, TLS configuration, key management. | `<evidence-link>` | `<owner>` | Annual | Designed | `<risk/ref>` |
| A.8.28 | Secure coding | Partially Applicable | Applies if software development is within ISMS scope. | Secure SDLC, code review, SAST, dependency scanning. | `<evidence-link>` | `<owner>` | Quarterly | Designed | `<risk/ref>` |
| A.8.32 | Change management | Applicable | Changes must be controlled to reduce security and availability risk. | Change workflow, approvals, testing, emergency change review. | `<evidence-link>` | `<owner>` | Monthly | Designed | `<risk/ref>` |

## Non-applicable control justification log

| Control ID | Reason not applicable | Approved by | Approval date | Next review date |
| --- | --- | --- | --- | --- |
| `<control-id>` | `<business justification>` | `<approver>` | `<yyyy-mm-dd>` | `<yyyy-mm-dd>` |

## Exception log

| Control ID | Exception summary | Risk owner | Compensating control | Expiry date | Remediation plan | Status |
| --- | --- | --- | --- | --- | --- | --- |
| `<control-id>` | `<exception>` | `<owner>` | `<control>` | `<yyyy-mm-dd>` | `<ticket/ref>` | `<open/closed>` |

## Approval

| Role | Name | Signature / approval reference | Date |
| --- | --- | --- | --- |
| ISMS owner | `<name>` | `<approval-ref>` | `<yyyy-mm-dd>` |
| Senior management approver | `<name>` | `<approval-ref>` | `<yyyy-mm-dd>` |
