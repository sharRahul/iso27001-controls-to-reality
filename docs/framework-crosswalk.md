# Framework Crosswalk: ISO 27001:2022 → NIST CSF 2.0 → Cyber Essentials

UK organisations pursuing ISO/IEC 27001:2022 certification alongside Cyber Essentials or Cyber Essentials Plus certification can use this crosswalk to avoid duplicating effort when implementing and evidencing controls. Cyber Essentials covers a focused subset of technical controls that map primarily to the Technological Controls (A.8.x) domain of ISO 27001:2022 Annex A, meaning evidence gathered for Cyber Essentials can directly support the ISO 27001 audit and vice versa. NIST CSF 2.0 provides a complementary risk management and operational framework commonly used by organisations with US-connected operations or supply chains, and its subcategories align closely with ISO 27001 Annex A requirements, enabling shared evidence and governance artefacts across all three frameworks.

---

## Control Mapping Table

| Control_ID | Control_Name | NIST_CSF_2.0_Subcategory | NIST_Function | Cyber_Essentials_Theme | CE_Applicable | Notes |
|------------|-------------|--------------------------|---------------|------------------------|---------------|-------|
| A.5.1 | Policies for information security | GV.PO-01 | Govern | N/A | No | ISO 27001 clause 5.2 and Annex A A.5.1 require documented information security policies. NIST CSF maps this to the Govern function. Cyber Essentials does not require formal ISMS policies. |
| A.5.2 | Information security roles and responsibilities | GV.RR-01 | Govern | N/A | No | NIST CSF GV.RR-01 covers roles and responsibilities for cybersecurity risk. Not assessed under Cyber Essentials. |
| A.5.9 | Inventory of information and other associated assets | ID.AM-01, ID.AM-02 | Identify | Secure Configuration | Partial | NIST CSF ID.AM covers asset inventory. Cyber Essentials requires organisations to know what devices and software are in scope; a formal asset inventory supports this. |
| A.5.15 | Access control | PR.AA-01, PR.AA-05 | Protect | User Access Control | Yes | Cyber Essentials User Access Control theme directly maps to access control requirements. NIST CSF PR.AA-01 covers identity and access management. |
| A.5.16 | Identity management | PR.AA-01, PR.AA-02 | Protect | User Access Control | Yes | Identity lifecycle management (joiner-mover-leaver) is assessed under Cyber Essentials User Access Control. NIST CSF PR.AA-02 covers identity federation and authentication. |
| A.5.17 | Authentication information | PR.AA-03, PR.AA-04 | Protect | User Access Control | Yes | Cyber Essentials requires strong password policies and MFA for administrative accounts. NIST CSF PR.AA-03 covers authentication. |
| A.5.23 | Information security for use of cloud services | GV.SC-06, PR.IR-02 | Govern / Protect | Secure Configuration | Partial | NIST CSF GV.SC-06 addresses supply chain risk management for cloud services. Cyber Essentials requires secure configuration of cloud services in scope; boundaries must be defined. |
| A.5.24 | Information security incident management planning and preparation | RS.MA-01 | Respond | N/A | No | Incident response planning is required by ISO 27001 and mapped to NIST CSF Respond function. Not assessed under Cyber Essentials. |
| A.6.1 | Screening | GV.RR-02 | Govern | N/A | No | Personnel screening is an organisational control. Not assessed under Cyber Essentials. NIST CSF GV.RR-02 covers workforce roles and responsibilities. |
| A.6.2 | Terms and conditions of employment | GV.RR-03 | Govern | N/A | No | Employment terms covering information security obligations. Not assessed under Cyber Essentials. |
| A.6.3 | Information security awareness, education, and training | PR.AT-01 | Protect | N/A | No | NIST CSF PR.AT-01 requires awareness training for all users. Cyber Essentials does not formally assess training but recommends it. |
| A.6.5 | Responsibilities after termination or change of employment | PR.AA-05 | Protect | User Access Control | Partial | Leaver access revocation is partially covered under Cyber Essentials User Access Control. NIST CSF PR.AA-05 addresses access management including revocation. |
| A.8.2 | Privileged access rights | PR.AA-05, PR.AA-06 | Protect | User Access Control | Yes | Cyber Essentials explicitly requires restriction of administrative privileges. NIST CSF PR.AA-05 and PR.AA-06 address privileged access management. |
| A.8.5 | Secure authentication | PR.AA-03, PR.AA-04 | Protect | User Access Control | Yes | Cyber Essentials requires MFA for administrative accounts and assesses password complexity controls. NIST CSF PR.AA-03 covers authentication. |
| A.8.7 | Protection against malware | DE.CM-09, PR.PS-02 | Detect / Protect | Malware Protection | Yes | Cyber Essentials Malware Protection theme directly maps to A.8.7. NIST CSF DE.CM-09 covers monitoring for malware. |
| A.8.9 | Configuration management | PR.PS-01 | Protect | Secure Configuration | Yes | Cyber Essentials Secure Configuration theme directly maps to A.8.9. NIST CSF PR.PS-01 covers configuration management for platforms and systems. |
| A.8.12 | Data leakage prevention | PR.DS-01, PR.DS-02 | Protect | N/A | No | Data loss prevention is an ISO 27001 and NIST CSF control. Not assessed under Cyber Essentials. NIST CSF PR.DS-01 covers data-at-rest protection. |
| A.8.15 | Logging | DE.AE-03, DE.CM-01 | Detect | N/A | No | NIST CSF DE.CM-01 covers log collection and analysis. Not assessed under Cyber Essentials, though Cyber Essentials Plus assessors may check for monitoring capability. |
| A.8.16 | Monitoring activities | DE.CM-01, DE.CM-06 | Detect | N/A | No | NIST CSF DE.CM-06 covers monitoring of external service providers. Not assessed under Cyber Essentials. |
| A.8.20 | Networks security | PR.IR-01, PR.IR-02 | Protect | Firewalls | Yes | Cyber Essentials Firewalls theme directly maps to A.8.20 network security controls. NIST CSF PR.IR-01 covers network integrity protection. |
| A.8.24 | Use of cryptography | PR.DS-01, PR.DS-02 | Protect | N/A | No | NIST CSF PR.DS-01 and PR.DS-02 cover data-at-rest and data-in-transit encryption. Not assessed under Cyber Essentials, though encrypted connections are implied by boundary firewall requirements. |
| A.8.28 | Secure coding | PR.PS-04 | Protect | N/A | No | NIST CSF PR.PS-04 covers software development security practices. Not assessed under Cyber Essentials. |
| A.8.32 | Change management | PR.PS-03 | Protect | N/A | No | NIST CSF PR.PS-03 covers change management for hardware and software. Not formally assessed under Cyber Essentials. |

---

## Using ISO 27001 and Cyber Essentials Together

Pursuing both certifications simultaneously is achievable and efficient when approached correctly. The following guidance helps avoid duplicated effort:

- **Define the Cyber Essentials boundary first.** Cyber Essentials applies to all devices that can connect to the internet and access organisational data. Map this boundary to your ISO 27001 ISMS scope early. Where the boundaries align, a single evidence set can satisfy both schemes.
- **Reuse technical evidence.** Evidence gathered for Cyber Essentials — such as firewall configuration exports, patch compliance reports, MFA policy screenshots, and anti-malware deployment screenshots — can directly support ISO 27001 control evidence for the relevant Annex A controls (A.8.20, A.8.9, A.8.7, A.8.5). Use the ISO 27001 evidence naming convention from the outset so artefacts are immediately usable for both purposes.
- **Complete Cyber Essentials before the ISO 27001 Stage 2 audit.** Achieving Cyber Essentials certification prior to your Stage 2 audit demonstrates that baseline technical controls are independently verified. Auditors will recognise this as evidence of implemented controls for the Cyber Essentials-mapped Annex A requirements.
- **Align review cycles.** Cyber Essentials certification is annual. Align your ISO 27001 surveillance audit and Cyber Essentials renewal to the same quarter where practicable, so that control evidence is refreshed once and serves both purposes.
- **Address the ISO 27001 controls that Cyber Essentials does not cover.** Cyber Essentials is intentionally focused on technical hygiene. ISO 27001 additionally requires: policies and procedures; risk assessment and treatment; supplier management; human resources security; physical security; and business continuity. Do not assume that Cyber Essentials certification satisfies the broader ISO 27001 requirements — plan resource accordingly.
- **Use the crosswalk table above during gap analysis.** For each Annex A control marked CE_Applicable = Yes, check whether your Cyber Essentials preparation has already generated suitable evidence. For controls marked No or Partial, plan separate ISO 27001 implementation and evidence activities.

---

## NIST CSF 2.0 Function Key

NIST CSF 2.0 organises cybersecurity activities into six high-level Functions. Each Function encompasses Categories and Subcategories that describe specific cybersecurity outcomes. The Functions are:

| Function | Code | Description |
|----------|------|-------------|
| **Govern** | GV | Establishes and monitors the organisation's cybersecurity risk management strategy, expectations, and policy. New in CSF 2.0, the Govern function encompasses leadership, roles, policies, and supply chain risk management activities that cut across all other functions. |
| **Identify** | ID | Develops organisational understanding of cybersecurity risk to systems, people, assets, data, and capabilities. Covers asset management, risk assessment, and improvement activities. |
| **Protect** | PR | Develops and implements appropriate safeguards to ensure delivery of critical services and protect assets. Covers identity management, access control, awareness training, data security, platform security, and technology infrastructure resilience. |
| **Detect** | DE | Develops and implements appropriate activities to identify the occurrence of a cybersecurity event. Covers continuous monitoring, adverse event analysis, and detection processes. |
| **Respond** | RS | Develops and implements appropriate activities to take action regarding a detected cybersecurity incident. Covers incident management, analysis, mitigation, and communication. |
| **Recover** | RC | Develops and implements appropriate activities to maintain plans for resilience and to restore any capabilities or services that were impaired due to a cybersecurity incident. Covers recovery planning, improvements, and communications. |
