# Risk Register Template — ISO 27001:2022

> **Note:** This file is the narrative risk register guide with worked examples and scoring guidance. For a blank register you can import directly into Excel or a GRC tool, use [`docs/templates/risk-register-template.csv`](templates/risk-register-template.csv).

This template supports the information security risk assessment and treatment process required by ISO/IEC 27001:2022 clauses 6.1.2 and 6.1.3. It is pre-populated with five example risks relevant to Microsoft 365 and cloud-hybrid environments. Replace or supplement these examples with risks identified during your organisation's own risk assessment.

---

## Risk Register

| Risk_ID | Risk_Description | Threat_Actor | Threat_Scenario | Affected_Asset | Affected_Controls | Likelihood (1-5) | Impact (1-5) | Inherent_Risk_Score | Current_Controls | Residual_Likelihood | Residual_Impact | Residual_Risk_Score | Risk_Treatment | Risk_Owner | Treatment_Actions | Target_Completion_Date | Review_Date | Notes |
|---------|-----------------|--------------|-----------------|----------------|-------------------|-----------------|--------------|---------------------|-----------------|--------------------|-----------------|--------------------|----------------|------------|-------------------|----------------------|-------------|-------|
| RISK-001 | Ransomware encryption of M365 data and on-premises file shares resulting in prolonged business disruption and potential data loss | Organised Crime | Attacker gains initial access via phishing or RDP brute-force, deploys ransomware payload that encrypts SharePoint Online synced content, OneDrive files, and on-prem file shares; demands payment for decryption key | M365 SharePoint Online, OneDrive for Business, on-premises file servers, Exchange Online mailboxes | A.5.24, A.5.26, A.8.7, A.8.13, A.8.15, A.8.16 | 4 | 5 | 20 | Microsoft Defender for Endpoint deployed; M365 Backup enabled; immutable blob storage for on-prem backups; MFA enforced via Conditional Access; Defender XDR incident alerting active | 2 | 5 | 10 | Mitigate | Head of IT / CISO | 1. Enable SharePoint versioning and recycle bin retention to 180 days. 2. Implement privileged access workstations (PAWs) for admin accounts. 3. Complete tabletop exercise for ransomware scenario. 4. Validate backup restoration from immutable storage quarterly. | 2026-09-30 | 2026-11-01 | Residual risk accepted at board level pending completion of treatment actions. Review after tabletop exercise outcome. |
| RISK-002 | Phishing credential theft leading to M365 account compromise, enabling unauthorised access to email, Teams, and SharePoint data | External Attacker | Attacker sends convincing phishing email bypassing spam filters; user enters M365 credentials and MFA one-time passcode on adversary-in-the-middle (AiTM) proxy site (e.g. Evilginx2); attacker captures session cookie and gains persistent access | M365 Exchange Online mailboxes, Teams conversations, SharePoint sites, Entra ID user accounts | A.5.15, A.5.16, A.5.17, A.8.5, A.8.20, A.6.3 | 4 | 4 | 16 | MFA enforced for all users via Conditional Access; Microsoft Defender for Office 365 Plan 2 anti-phishing policies active; user security awareness training delivered annually | 2 | 4 | 8 | Mitigate | Information Security Manager | 1. Deploy phishing-resistant MFA (FIDO2 or Certificate-Based Authentication) for all privileged accounts by Q3 2026. 2. Enable Entra ID Conditional Access policy requiring compliant device for M365 access. 3. Configure Entra ID Identity Protection risk-based sign-in policies. 4. Increase phishing simulation frequency to quarterly. | 2026-08-31 | 2026-10-01 | AiTM attacks bypass traditional MFA. FIDO2 rollout is the primary mitigating action. Awareness training alone is insufficient. |
| RISK-003 | Insider data exfiltration via personal cloud storage or email, resulting in loss of confidential customer or commercial data | Malicious Insider | Disgruntled or departing employee uploads sensitive files to personal Google Drive, Dropbox, or sends bulk email to personal account before departure; data includes customer PII, contracts, or intellectual property | SharePoint Online document libraries, Exchange Online, on-premises file shares, CRM data | A.5.9, A.8.12, A.6.5, A.5.15, A.5.18 | 2 | 5 | 10 | Microsoft Purview Data Loss Prevention (DLP) policies deployed for email and SharePoint; Conditional Access blocks unmanaged devices; HR off-boarding process includes IT notification | 1 | 5 | 5 | Mitigate | Information Security Manager / HR Director | 1. Extend Purview DLP policies to cover Teams and OneDrive upload scenarios. 2. Implement Microsoft Purview Insider Risk Management with departing employee trigger policies. 3. Formalise and document the leaver process with IT notified at least 24 hours before departure where practicable. 4. Enable audit log alerting for bulk file downloads exceeding threshold. | 2026-07-31 | 2026-10-01 | UK GDPR applies to any PII exfiltration. ICO notification may be required within 72 hours of confirmed breach. Coordinate with DPO. |
| RISK-004 | Supply chain compromise through a third-party SaaS application with broad M365 OAuth permissions enabling lateral movement or data access | Nation-State / Advanced Persistent Threat | Third-party SaaS vendor is compromised; attacker leverages OAuth token granted to the vendor application (with Mail.ReadWrite or Files.ReadWrite.All permissions) to access organisation's M365 data without using user credentials; or vendor pushes malicious update to integrated application | M365 Exchange Online, SharePoint Online, Entra ID (OAuth application registrations), connected SaaS platforms | A.5.19, A.5.20, A.5.23, A.8.2, A.5.15 | 2 | 5 | 10 | Supplier security questionnaires completed annually; IT approval required before new SaaS tools are procured; Entra ID app registration governance policy in place | 2 | 4 | 8 | Mitigate | Head of IT / Procurement Lead | 1. Conduct a full audit of all Entra ID enterprise application registrations and OAuth consents; revoke unnecessary broad permissions within 60 days. 2. Implement Entra ID App Governance policies to alert on anomalous OAuth token activity. 3. Require contractual security clauses (ISO 27001 certification or equivalent) for all SaaS vendors with M365 integration. 4. Review and update supplier security assessment process to include OAuth scope review. | 2026-06-30 | 2026-09-01 | SolarWinds and similar incidents demonstrate this vector. Nation-state attribution is rare but impact is catastrophic. Treat as high-priority. |
| RISK-005 | Accidental data exposure via misconfigured SharePoint site or Team with anonymous access or broad external sharing enabled, resulting in unintended disclosure of sensitive information | Internal User Error | A site owner enables anonymous link sharing or sets an internal SharePoint site to "Anyone with the link"; sensitive documents including HR records or financial data become accessible without authentication to anyone who obtains the link, which is shared externally via email or social media | SharePoint Online sites, OneDrive for Business, M365 Teams-connected sites | A.5.15, A.8.2, A.8.9, A.8.12 | 3 | 3 | 9 | SharePoint tenant-level external sharing set to "Existing guests only"; DLP policy alerts on sharing of files labelled Confidential or above; Purview sensitivity labels deployed for email and SharePoint | 2 | 3 | 6 | Mitigate | IT Administrator / Information Security Manager | 1. Disable anonymous ("Anyone with the link") sharing at tenant level; restrict to authenticated external sharing only. 2. Deploy SharePoint site ownership review process quarterly. 3. Enable Microsoft Secure Score recommendation: restrict SharePoint external sharing. 4. Add site creation policy requiring site owner acknowledgement of sharing responsibilities. | 2026-06-30 | 2026-09-01 | Exposure via misconfiguration is frequently the cause of UK GDPR breach notifications. This risk has high probability of being missed without automated controls. |

---

## Scoring Guidance

### Likelihood Scale

| Score | Rating | Description |
|-------|--------|-------------|
| 1 | Rare | The event is unlikely to occur; may happen only in exceptional circumstances. Fewer than once every 5 years. |
| 2 | Unlikely | The event could occur but is not expected. May happen once every 3–5 years. |
| 3 | Possible | The event might occur at some point. May happen once every 1–3 years. |
| 4 | Likely | The event will probably occur in most circumstances. May happen once per year or more frequently. |
| 5 | Almost Certain | The event is expected to occur repeatedly. May happen multiple times per year. |

### Impact Scale

| Score | Rating | Description | Examples |
|-------|--------|-------------|----------|
| 1 | Negligible | Minimal or no business impact; no regulatory consequence; recoverable within hours. | Brief system unavailability; minor inconvenience. |
| 2 | Minor | Limited impact; recoverable within one business day; minimal financial or reputational effect. | Small data loss; localised disruption; low-value breach. |
| 3 | Moderate | Noticeable operational disruption; financial loss or reputational damage possible; may trigger regulatory reporting. | Departmental downtime; notifiable breach affecting small number of individuals. |
| 4 | Significant | Serious operational disruption; substantial financial loss or reputational damage; likely regulatory or legal consequence. | Multi-day outage; large-scale data breach; regulatory investigation. |
| 5 | Catastrophic | Organisation-wide or existential impact; severe financial loss; major legal or regulatory sanction; severe reputational damage. | Ransomware-induced business failure; ICO enforcement action; loss of major customers. |

### Inherent and Residual Risk Score

Risk Score = Likelihood × Impact

| Score Range | Risk Level | Recommended Action |
|-------------|------------|-------------------|
| 1–4 | Low | Monitor; review annually. |
| 5–9 | Medium | Treat or accept with documented justification; review six-monthly. |
| 10–15 | High | Treat as priority; assign treatment actions; review quarterly. |
| 16–25 | Critical | Immediate escalation; treatment plan required; senior management or board visibility. |

---

## Risk Treatment Guidance

ISO 27001:2022 clause 6.1.3 requires the organisation to select appropriate risk treatment options. The four treatment options are:

| Treatment Option | Description | When to Use |
|-----------------|-------------|-------------|
| **Mitigate** | Implement controls to reduce the likelihood or impact of the risk to an acceptable level. | Most common option. Use when controls are available, cost-effective, and proportionate to the risk. |
| **Accept** | Formally accept the risk without additional treatment, with documented justification and risk owner sign-off. | Use when residual risk falls within the organisation's risk appetite, or where treatment cost exceeds potential impact. |
| **Transfer** | Transfer the risk to a third party, typically through insurance (e.g. cyber insurance) or contractual liability clauses. | Use in conjunction with other treatment options; rarely eliminates risk entirely. |
| **Avoid** | Cease the activity or process that gives rise to the risk. | Use when risk cannot be reduced to an acceptable level and the activity is non-essential. |

All accepted risks above the organisation's stated risk appetite must be approved by the appropriate risk owner (senior management) and recorded in this register with a review date.

---

## How to Use This Template

### Initial Setup

1. **Define your risk appetite** before populating the register. Agree with senior management the maximum acceptable residual risk score (commonly 6–9 for medium, with high and critical requiring mandatory treatment).

2. **Conduct a risk assessment** in accordance with ISO 27001:2022 clause 6.1.2. Identify risks by considering threats, vulnerabilities, and potential impacts across your ISMS scope.

3. **Assign a unique Risk_ID** using a consistent scheme (e.g. RISK-001, RISK-002). Do not reuse IDs once a risk has been retired; instead, mark the risk as closed and retain the historical record.

### Populating the Register

4. **Complete all mandatory columns** for each identified risk. The minimum required fields are: Risk_ID, Risk_Description, Threat_Actor, Affected_Asset, Likelihood, Impact, Inherent_Risk_Score, Risk_Treatment, Risk_Owner, and Review_Date.

5. **Map to Affected_Controls** using ISO 27001:2022 Annex A control identifiers (e.g. A.8.7). This linkage supports the Statement of Applicability (SoA) and demonstrates that your control selection is risk-driven.

6. **Record Current_Controls** honestly. List only controls that are demonstrably implemented and producing evidence. Do not include controls that are designed but not yet operating.

7. **Calculate scores** as Likelihood × Impact. Inherent_Risk_Score reflects the risk before any controls are applied. Residual_Risk_Score reflects the risk after current controls are applied.

### Maintaining the Register

8. **Review the register at least annually**, or after any significant change (e.g. new system deployment, organisational restructure, security incident, or change in threat landscape).

9. **Review high and critical risks quarterly**. Any risk scoring 10 or above should have a named risk owner and documented treatment actions with target completion dates.

10. **Link treatment actions to your risk treatment plan (RTP)**. ISO 27001:2022 clause 6.1.3(e) requires a formal risk treatment plan with approval from risk owners.

11. **Retain previous versions** of the register to support audit evidence of ongoing risk management activity. Store completed registers in your ISMS evidence folder using the agreed evidence naming convention.

### Audit Preparation

12. **Auditors will expect to see**: evidence that the risk assessment methodology has been consistently applied; linkage between risks and Annex A controls in the SoA; documented risk owner approvals; and evidence that treatment actions have been completed or are being tracked.

13. **Do not delete closed risks**. Mark them with a closure date and retain them in the register or a separate archived register to demonstrate the historical risk management lifecycle.
