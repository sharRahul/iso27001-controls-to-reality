# Incident Response Policy Template

## 1. Purpose

Define how information security events and incidents are reported, assessed, escalated, contained, investigated, communicated, evidenced, and closed.

## 2. Scope

This policy applies to systems, services, users, suppliers, and information assets within the ISMS scope.

## 3. ISO 27001 control mapping

| Control | Relevance |
| --- | --- |
| A.5.24 Information security incident management planning and preparation | Requires incident management planning and readiness. |
| A.5.25 Assessment and decision on information security events | Requires consistent event triage and incident classification. |
| A.5.26 Response to information security incidents | Requires response activities. |
| A.5.27 Learning from information security incidents | Requires lessons learned and improvement. |
| A.5.28 Collection of evidence | Requires evidence preservation and handling. |
| A.8.15 Logging | Provides investigation evidence. |
| A.8.16 Monitoring activities | Supports detection and triage. |

## 4. Policy statements

1. Security events must be assessed against documented triage criteria.
2. Confirmed or suspected incidents must be recorded in the incident management system.
3. Incidents must be assigned a severity level and owner.
4. High-severity incidents must be escalated to senior management and relevant stakeholders.
5. Evidence must be collected, preserved, and protected from unauthorised modification.
6. Regulatory, contractual, customer, and data protection notification obligations must be assessed.
7. Incident communications must be approved by authorised personnel.
8. Lessons learned must be recorded and tracked through remediation actions.
9. Incident closure must include root cause, impact, corrective actions, and evidence references.

## 5. Severity model

| Severity | Example | Target response |
| --- | --- | --- |
| Critical | Active compromise of critical system or confirmed data exfiltration | Immediate escalation and incident command activation |
| High | Malware outbreak, privileged account compromise, major service impact | Same business day investigation and management notification |
| Medium | Suspicious activity requiring investigation but no confirmed compromise | Triage and containment according to SOC process |
| Low | Benign event, false positive, or minor policy breach | Record, review, and close with notes |

## 6. Minimum evidence

| Evidence | Owner | Frequency |
| --- | --- | --- |
| Incident response plan | SOC or security manager | Annual |
| Severity matrix and escalation contacts | SOC or security manager | Quarterly |
| Incident tickets and triage notes | SOC | Per incident |
| Tabletop exercise report | Security manager | Annual or semi-annual |
| Lessons learned tracker | Incident owner | Per incident |
| Evidence handling record | Incident owner | Per incident |

## 7. Review and approval

| Role | Name | Approval reference | Date |
| --- | --- | --- | --- |
| Policy owner | `<name>` | `<approval-ref>` | `<yyyy-mm-dd>` |
| Senior management approver | `<name>` | `<approval-ref>` | `<yyyy-mm-dd>` |
