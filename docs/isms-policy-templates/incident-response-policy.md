# Incident Response Policy

**Document Reference:** ISMS-POL-003
**Version:** 1.0
**Status:** Template
**Review Cycle:** Annual
**Policy Owner:** [Information Security Manager]
**Date:** [YYYY-MM-DD]

---

## 1. Purpose

This policy establishes [ORGANISATION NAME]'s requirements and approach for detecting, reporting, managing, and learning from information security incidents. It defines responsibilities, severity classifications, escalation paths, evidence handling obligations, and regulatory notification requirements to ensure that incidents are handled consistently, efficiently, and in compliance with applicable UK legislation.

This policy supports [ORGANISATION NAME]'s Information Security Management System (ISMS) and is aligned with ISO/IEC 27001:2022 Annex A controls.

---

## 2. Scope

This policy applies to:

- All permanent employees, contractors, temporary staff, and volunteers of [ORGANISATION NAME].
- All third parties engaged by [ORGANISATION NAME] who may be involved in, or made aware of, an information security incident affecting [ORGANISATION NAME] systems or data.
- All information security incidents, events, and near misses affecting [ORGANISATION NAME]'s information systems, data, physical premises, or personnel, regardless of where they originate or where systems are hosted.

---

## 3. Definitions

| Term | Definition |
|------|------------|
| Information Security Event | Any identified occurrence of a system, service, or network state that indicates a possible breach of information security policy, failure of controls, or a previously unknown situation that may be security-relevant. Not all events constitute incidents. |
| Information Security Incident | A single or series of unwanted or unexpected information security events that have a significant probability of compromising business operations or threatening information security. An incident is confirmed when an event is assessed to have had, or to be likely to have, an adverse impact. |
| Near Miss | An event that could have resulted in an incident but did not, due to favourable conditions, chance, or existing controls. Near misses must be reported and recorded as they provide valuable intelligence for improving controls. |
| Severity Level | A classification applied to a confirmed incident that determines the response timeline, escalation path, and resource allocation required. Severity is assessed at the point of triage and may be revised as more information becomes available. |
| Major Incident | An incident classified at Severity Level P1 (Critical) or P2 (High) that requires coordinated senior management involvement, formal incident command, and potentially external notification to regulators, customers, or law enforcement. |

---

## 4. Severity Classification

| Level | Name | Description | Example | Response Time |
|-------|------|-------------|---------|---------------|
| P1 | Critical | Severe or ongoing compromise of business operations, critical systems, or large volumes of sensitive data. Existential or regulatory risk. Business continuity may be invoked. | Ransomware encryption of production systems; active data exfiltration of customer PII; complete M365 tenant compromise; prolonged critical service outage caused by a security event. | Immediate — within 1 hour of detection. Incident commander assigned within 2 hours. |
| P2 | High | Significant but contained compromise. Sensitive data may have been accessed or disclosed. Material operational disruption. Regulatory notification likely required. | Confirmed account compromise with evidence of data access; phishing attack with credential theft affecting multiple accounts; malware infection on business-critical system; unauthorised privileged access to production systems. | Within 4 hours of detection. Incident lead assigned. Senior management notified. |
| P3 | Medium | Limited or suspected compromise. Single system or account affected. No confirmed data loss. Operational impact is contained. | Single account compromise with no evidence of data access; suspected phishing with no credential theft; malware detected and quarantined before execution; minor policy violation with potential security impact. | Within 24 hours. IT Security team leads response. Information Security Manager informed. |
| P4 | Low | Minor event with negligible operational or security impact. No confirmed compromise. Primarily a process, policy, or configuration issue. | Lost unencrypted USB drive with no sensitive data; failed login attempt with no indication of targeted attack; minor policy violation (e.g. software installed without approval); suspected phishing email that was not acted upon. | Within 5 business days. Logged, assessed, and closed by IT Security team. |

---

## 5. Policy Statements

### 5.1 Reporting Obligations

5.1.1 All users, regardless of role or seniority, are required to report any suspected or actual information security event, incident, or near miss to the IT Security team or Information Security Manager as soon as possible and no later than two hours after the suspicion arises.

5.1.2 Users must not attempt to investigate, contain, or remediate a suspected incident themselves. Incident handling is the responsibility of the designated IT Security team and Incident Response function.

5.1.3 Users must not discuss suspected incidents externally (including on social media or with clients) without explicit authorisation from the Information Security Manager or a member of the senior leadership team.

5.1.4 [ORGANISATION NAME] will not penalise any staff member who reports a suspected incident in good faith, including where the user has unintentionally contributed to the incident. A culture of open and timely reporting is essential to effective incident response.

5.1.5 Reporting channels must be clearly communicated to all staff and must remain accessible even during an incident (e.g. if email systems are compromised, a telephone reporting number and an out-of-band communication method must be available).

### 5.2 Triage and Classification

5.2.1 Upon receipt of an incident report, the IT Security team must conduct an initial triage within the timeframe specified for the relevant severity level. Triage must determine: whether the event constitutes a confirmed incident; the likely scope and impact; the preliminary severity classification; and any immediate containment actions required.

5.2.2 Severity classification must be assigned at the point of triage and recorded in the incident log. Classification may be escalated or de-escalated as the investigation progresses. Any change in severity must be documented with the reason and timestamp.

5.2.3 If an incident potentially involves personal data, the Data Protection Officer (DPO) must be notified immediately so that UK GDPR obligations can be assessed without delay.

### 5.3 Escalation Paths

5.3.1 P1 (Critical) incidents: The IT Security team must immediately notify the Information Security Manager, the relevant member of the senior leadership team, and the Data Protection Officer (if personal data may be involved). An incident commander must be assigned within two hours. The Chief Executive Officer or equivalent must be briefed within four hours.

5.3.2 P2 (High) incidents: The Information Security Manager must be notified within four hours. Senior management must be informed. External legal counsel, cyber insurance, and specialist incident response support must be engaged if required.

5.3.3 P3 (Medium) incidents: The Information Security Manager must be informed. Escalation to senior management is at the Information Security Manager's discretion based on impact assessment.

5.3.4 P4 (Low) incidents: Handled by the IT Security team. The Information Security Manager must be informed via the incident log.

5.3.5 Where an incident involves suspected criminal activity (e.g. ransomware deployment, insider theft, or fraud), the Information Security Manager must assess whether to notify the National Cyber Security Centre (NCSC), Action Fraud, or the police, in conjunction with senior management and legal counsel.

### 5.4 Evidence Preservation

5.4.1 Evidence preservation must begin as early as possible in the incident lifecycle and must not be delayed pending full classification or escalation. The destruction or alteration of potential evidence — whether accidental or deliberate — may impede the investigation and create legal liability.

5.4.2 All relevant logs, system states, device images, email records, and other digital artefacts must be captured and stored securely as soon as technically practicable. Evidence must be handled in a manner that preserves its integrity for potential legal proceedings.

5.4.3 Incident responders must maintain a contemporaneous record of all investigative actions taken, including timestamps, the person performing each action, and the rationale. This record forms part of the incident evidence package.

5.4.4 Affected systems or devices must not be rebuilt, wiped, or disposed of without explicit authorisation from the Information Security Manager, and only after forensic preservation or investigation requirements have been satisfied.

5.4.5 Evidence must be retained for a minimum of three years following incident closure, or longer if subject to legal hold, regulatory investigation, or ongoing litigation.

### 5.5 Communication — Internal and External

5.5.1 All external communications regarding an incident (to clients, suppliers, media, regulators, or the public) must be authorised by the Information Security Manager and a member of the senior leadership team, and must be reviewed by legal counsel where appropriate.

5.5.2 Staff must be informed of incidents on a need-to-know basis. Internal communications must be factual, avoid speculation, and be coordinated by the incident commander or Information Security Manager.

5.5.3 Where a personal data breach has occurred or is suspected, the Information Security Manager must notify the Information Commissioner's Office (ICO) within 72 hours of the organisation becoming aware of the breach, in accordance with UK GDPR Article 33. If notification is not possible within 72 hours, the ICO must be informed of the reasons for the delay alongside the notification.

5.5.4 Where a personal data breach is likely to result in a high risk to the rights and freedoms of affected individuals, those individuals must also be notified without undue delay, in accordance with UK GDPR Article 34.

5.5.5 Where [ORGANISATION NAME] is a data processor and the incident affects personal data processed on behalf of a controller, the relevant controller must be notified without undue delay in accordance with contractual obligations and UK GDPR Article 33(2).

5.5.6 Cyber insurance providers must be notified of P1 and P2 incidents within the timeframe specified in the insurance policy terms. Failure to notify insurers promptly may invalidate coverage.

### 5.6 Post-Incident Review

5.6.1 A formal post-incident review (PIR) is mandatory for all P1 (Critical) and P2 (High) incidents. The PIR must be completed within five business days of the incident being closed.

5.6.2 The PIR must be facilitated by the Information Security Manager and must include representatives from all teams involved in the incident response. The purpose of the PIR is to understand the root cause, assess the effectiveness of the response, and identify improvements — not to assign blame.

5.6.3 P3 (Medium) incidents should be subject to a lightweight review. This may be incorporated into the monthly IT Security team meeting rather than a dedicated session.

5.6.4 The PIR report must document: a timeline of the incident; root cause analysis; an assessment of the effectiveness of detection and response; identified gaps in controls, processes, or capabilities; and a list of improvement actions with owners and target dates.

5.6.5 PIR reports and supporting evidence must be retained as ISMS evidence for a minimum of three years.

### 5.7 Lessons Learned

5.7.1 Improvement actions identified during PIRs must be tracked to completion. Responsibility for each action must be assigned to a named individual.

5.7.2 Recurring or systemic issues identified across multiple incidents must be escalated to the ISMS risk register and addressed as part of the continual improvement programme.

5.7.3 Lessons learned from significant incidents must be incorporated into security awareness training, technical controls, and incident response procedures in a timely manner.

5.7.4 Anonymised lessons learned may be shared with peer organisations or industry bodies where doing so supports the wider information security community, subject to approval by the Information Security Manager.

---

## 6. Incident Response Phases

The following phases define the structured approach [ORGANISATION NAME] takes to managing information security incidents. All phases must be documented in the incident record.

| Phase | Description |
|-------|-------------|
| **Preparation** | Maintaining the capability to respond to incidents before they occur. This includes: defining and testing the incident response procedure; maintaining an up-to-date contact list (internal and external); ensuring logging and monitoring tools are operational; training the incident response team; and running tabletop exercises at least annually. |
| **Detection** | Identifying that an incident has occurred or is in progress. Detection may occur via automated alerting (SIEM, EDR, MDR), user reports, third-party notification, or external intelligence. All detections must be logged with the source, time, and initial details. |
| **Containment** | Taking immediate action to limit the spread and impact of the incident. Short-term containment (e.g. isolating an affected device or blocking a malicious IP) must be balanced against the need to preserve evidence. Long-term containment establishes a stable and secure environment for eradication and recovery. |
| **Eradication** | Removing the cause of the incident from the environment. This may include: removing malware; closing exploited vulnerabilities; revoking compromised credentials; and removing unauthorised access. Eradication must be confirmed before recovery begins. |
| **Recovery** | Restoring affected systems and services to normal operation in a controlled and verified manner. Recovery must include validation that the eradication actions were effective and that the restored systems are not re-infected or re-compromised. The timing and pace of recovery must be agreed by the incident commander. |
| **Lessons Learned** | Conducting a post-incident review (PIR) to identify root causes, assess response effectiveness, and define improvement actions. This phase is mandatory for P1 and P2 incidents and must be completed within five business days of incident closure. Outputs feed into the ISMS continual improvement process. |

---

## 7. Responsibilities

| Role | Responsibilities |
|------|-----------------|
| All Staff and Contractors | Report suspected or actual incidents promptly (within 2 hours). Do not attempt to investigate or contain incidents independently. Cooperate with the incident response team. Preserve evidence where instructed. |
| Information Security Manager | Own this policy. Coordinate incident response. Authorise external communications. Assess UK GDPR notification obligations. Oversee PIR process. Report P1/P2 incidents to senior management. |
| IT Security Team | Receive and triage incident reports. Perform technical investigation and containment. Collect and preserve evidence. Implement eradication and recovery actions. Maintain the incident log. |
| Data Protection Officer (DPO) | Assess personal data breach implications. Advise on ICO notification obligations. Support drafting of ICO and data subject notifications. |
| Senior Leadership Team | Provide incident command for P1 incidents. Authorise major decisions (e.g. system shutdown, external notifications). Approve media statements. Engage legal and insurance advisors as required. |
| Line Managers | Ensure team members report incidents promptly. Support the incident response team in gathering information. Maintain business continuity for their function during the incident. |
| Legal Counsel | Advise on legal obligations and liability. Review external communications. Advise on law enforcement engagement. Apply legal holds as appropriate. |

---

## 8. Related Controls

This policy supports the following ISO/IEC 27001:2022 Annex A controls:

| Control ID | Control Name |
|------------|-------------|
| A.5.24 | Information security incident management planning and preparation |
| A.5.25 | Assessment and decision on information security events |
| A.5.26 | Response to information security incidents |
| A.5.28 | Collection of evidence |
| A.8.15 | Logging |
| A.8.16 | Monitoring activities |

---

## 9. Related Documents

- ISMS-POL-001: Acceptable Use Policy
- ISMS-POL-002: Access Control Policy
- Information Security Risk Register
- Statement of Applicability
- Business Continuity Plan
- Data Protection Policy
- Data Breach Response Procedure
- UK GDPR Article 33 (Personal Data Breach Notification to the ICO)
- UK GDPR Article 34 (Personal Data Breach Notification to Data Subjects)
- NCSC Incident Management Guidance

---

## 10. Version History

| Version | Date | Author | Change Description |
|---------|------|--------|--------------------|
| 1.0 | [YYYY-MM-DD] | [Author Name] | Initial version. |
