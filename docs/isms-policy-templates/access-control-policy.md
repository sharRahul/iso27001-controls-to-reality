# Access Control Policy

**Document Reference:** ISMS-POL-002
**Version:** 1.0
**Status:** Template
**Review Cycle:** Annual
**Policy Owner:** [Information Security Manager]
**Date:** [YYYY-MM-DD]

---

## 1. Purpose

This policy establishes the requirements for controlling access to [ORGANISATION NAME]'s information systems, applications, data, and infrastructure. It defines how access is provisioned, maintained, reviewed, and revoked to ensure that users are granted only the access necessary for their role and that access is withdrawn promptly when no longer required.

This policy supports [ORGANISATION NAME]'s Information Security Management System (ISMS) and is aligned with ISO/IEC 27001:2022 Annex A controls.

---

## 2. Scope

This policy applies to:

- All permanent employees, contractors, temporary staff, and volunteers of [ORGANISATION NAME].
- All third parties granted access to [ORGANISATION NAME] systems or data, including suppliers, partners, and managed service providers.
- All information systems, applications, platforms, and data repositories owned, leased, or managed by [ORGANISATION NAME], including cloud-hosted services and Microsoft 365 tenants.
- All privileged, standard, service, and shared accounts used to access [ORGANISATION NAME] systems.

---

## 3. Definitions

| Term | Definition |
|------|------------|
| Least Privilege | The principle that a user, process, or system component should be granted only the minimum level of access rights necessary to perform its authorised function, and no more. |
| Need to Know | The principle that access to information should be restricted to individuals who require it to perform their specific job duties, regardless of their overall security clearance or role seniority. |
| Privileged Access | Access rights that grant elevated capabilities beyond those of a standard user, including administrative rights over systems, databases, network infrastructure, cloud tenants, or security tooling. |
| Service Account | A non-interactive account used by an application, automated process, or service to access systems or resources, rather than by a human user. |
| Joiner-Mover-Leaver (JML) | The lifecycle management process governing how access rights are provisioned when an individual joins the organisation (Joiner), changes role (Mover), or departs (Leaver). |

---

## 4. Policy Statements

### 4.1 Access Provisioning

4.1.1 All access to [ORGANISATION NAME] information systems must be formally requested, approved, and provisioned in accordance with a defined access request process. Verbal or informal requests for access are not acceptable.

4.1.2 Access must be granted based on the user's confirmed job role and responsibilities. The principle of least privilege must be applied: users must be granted only the minimum access required to perform their duties.

4.1.3 The need-to-know principle must be applied when determining access to sensitive or classified information. Role or seniority alone does not justify access to information if the individual has no operational requirement for it.

4.1.4 Access requests must be approved by the user's line manager or an appropriately authorised business owner before provisioning. IT must not provision access without documented approval.

4.1.5 All access provisioning must be recorded in the access management system or IT service management (ITSM) tool with the approver, date, justification, and access rights granted.

4.1.6 Default access profiles may be created for common roles (e.g. Finance Analyst, Sales Executive) to streamline provisioning. Role profiles must be reviewed and approved by the relevant business owner at least annually.

### 4.2 Privileged Access

4.2.1 Privileged access (including global administrator, domain administrator, tenant administrator, and equivalent roles across all platforms) must be granted only where there is a clear operational requirement. Privileged accounts must be separate from the individual's standard user account.

4.2.2 Privileged users must use their standard user account for all general day-to-day tasks (email, web browsing, productivity applications). Privileged accounts must be used solely for administrative tasks.

4.2.3 Multi-factor authentication (MFA) is mandatory for all privileged accounts without exception. Phishing-resistant MFA (FIDO2 security keys or certificate-based authentication) is required for all global administrator and equivalent accounts.

4.2.4 Where technically feasible, Privileged Identity Management (PIM) or equivalent just-in-time (JIT) access controls must be used, so that privileged roles are activated only when required and for a limited duration (maximum 8 hours per session unless approved otherwise).

4.2.5 Privileged account activity must be logged, and logs must be retained for a minimum of 12 months. Privileged session activity must be subject to periodic review.

4.2.6 The number of privileged accounts must be minimised. A named individual must be the owner of each privileged account. Shared privileged accounts are prohibited.

4.2.7 Emergency access ("break-glass") accounts must be defined, documented, secured with strong credentials stored in a sealed physical envelope or equivalent offline mechanism, and their use must trigger immediate notification to the Information Security Manager. Break-glass account activity must be reviewed after every use.

### 4.3 Shared and Service Accounts

4.3.1 Shared accounts (accounts used interactively by more than one named individual) are prohibited. Every individual accessing [ORGANISATION NAME] systems must have a unique, personally attributed account to ensure accountability and audit trail integrity.

4.3.2 Service accounts must not be used for interactive logon by human users. Where a service account requires elevated permissions, this must be approved by the Information Security Manager and documented in the service account register.

4.3.3 All service accounts must be registered in the service account register, which records the account name, purpose, owning system or application, responsible technical owner, access rights, and last review date.

4.3.4 Service account passwords or credentials must be rotated at least annually, or immediately following the departure of any individual with knowledge of the credentials. Where possible, managed identities, workload identity federation, or equivalent credential-free authentication mechanisms must be used in preference to password-based service accounts.

4.3.5 Service accounts must be assigned only the minimum permissions required for the application or process they support. Service accounts must not be assigned global administrator or equivalent roles unless there is no technically viable alternative, and any such exception requires Information Security Manager approval.

### 4.4 Periodic Access Reviews

4.4.1 Access rights must be reviewed on a regular basis to ensure that they remain appropriate for the user's current role and that access granted to former roles or projects has been removed.

4.4.2 Privileged access rights must be reviewed quarterly. The review must confirm that each privileged account remains assigned to a named, active individual with a legitimate ongoing need for privileged access.

4.4.3 Standard user access rights must be reviewed at least annually. Reviews must be carried out by the relevant system owner or business owner, with oversight from the Information Security Manager.

4.4.4 Access reviews must be documented. Any access identified as inappropriate, excessive, or no longer required must be revoked promptly and no later than five business days after the review finding.

4.4.5 Access review outputs must be retained as ISMS evidence for a minimum of three years.

### 4.5 Leaver Process

4.5.1 When a user leaves [ORGANISATION NAME], whether through resignation, redundancy, contract expiry, or any other reason, their accounts must be disabled within four hours of their confirmed departure time or the confirmed end of their last working day, whichever is sooner.

4.5.2 HR must notify IT of confirmed leavers as soon as a departure date is known, and no later than the working day before the departure date where practicable.

4.5.3 Upon departure, the following actions must be completed without delay: disable all active directory, Entra ID, and application accounts; revoke active sessions and tokens; remove MFA registrations; transfer data and mailbox ownership to an authorised colleague or manager; and retrieve any [ORGANISATION NAME]-issued devices, removable media, and physical access tokens.

4.5.4 Leaver accounts must not be deleted until a minimum data retention period of 90 days has elapsed, to allow for investigation, data recovery, or legal hold requirements. After the retention period, accounts must be deleted and data disposed of in accordance with the Data Retention Policy.

4.5.5 Contractor and temporary staff accounts must be provisioned with a defined expiry date matching their contract end date. Expiry dates must be extended only via a formal re-approval process.

### 4.6 Remote Access Requirements

4.6.1 Remote access to [ORGANISATION NAME] systems must only be permitted via approved and secured methods, including corporate VPN or equivalent approved remote access technology, or via cloud services governed by Conditional Access policies enforcing device compliance and MFA.

4.6.2 MFA is mandatory for all remote access without exception, regardless of the user's role or the sensitivity of the systems being accessed.

4.6.3 Remote access from unmanaged or personally owned devices is only permitted where the device meets minimum security requirements defined by IT, and where a Conditional Access policy or equivalent enforces these requirements before access is granted.

4.6.4 Remote access sessions must not be left unattended without screen locking. Idle sessions must be automatically terminated after a maximum of 30 minutes of inactivity.

### 4.7 Third-Party Access

4.7.1 Third parties requiring access to [ORGANISATION NAME] systems must be granted only the minimum access necessary for the specific task or service being performed. Broad or standing access rights for third parties are not permitted without documented justification and Information Security Manager approval.

4.7.2 Third-party access must be time-limited, with a defined start and end date. Access must not be granted on an indefinite basis.

4.7.3 All third-party access must be subject to a formal access review at least every six months, or upon contract renewal, whichever is sooner. Access that is no longer required must be revoked promptly.

4.7.4 Third parties must not be permitted to sub-delegate their access rights to other individuals or organisations without prior written approval from [ORGANISATION NAME].

4.7.5 Third-party accounts must be clearly identifiable in the directory (e.g. by naming convention or account type attribute) to distinguish them from internal staff accounts.

4.7.6 Remote access by third-party suppliers must be monitored. Where technically feasible, third-party privileged access sessions must be recorded or audited.

---

## 5. Responsibilities

| Role | Responsibilities |
|------|-----------------|
| All Staff and Contractors | Use only the access rights assigned to them. Report suspected unauthorised access, credential compromise, or access control weaknesses to the IT Security team. Do not share credentials or access rights with any other person. |
| Information Security Manager | Own and maintain this policy. Approve privileged access requests, service account registrations, and exceptions. Oversee access review programme. |
| IT Department | Implement and operate technical access controls (Entra ID, Active Directory, Conditional Access, PIM). Provision, modify, and revoke access in accordance with approved requests. Maintain the service account register. Carry out leaver access revocation. |
| Line Managers | Approve access requests for their direct reports. Notify IT and HR of leavers or role changes promptly. Participate in access reviews for their teams. |
| System and Application Owners | Define appropriate access roles and permissions for their systems. Conduct periodic access reviews. Approve access to systems within their ownership. |
| HR Department | Notify IT of joiners, movers, and leavers in a timely manner. Maintain accurate records of employment status, role, and contract dates. |

---

## 6. Exceptions Process

Requests for exceptions to any provision of this policy must be submitted to the Information Security Manager with a written business justification. Exceptions will be assessed via a risk assessment and must be approved by the Information Security Manager and, for high-risk exceptions, by senior management.

All approved exceptions must be documented with: a description of the exception; the risk assessment outcome; the approver; an expiry date (maximum 12 months); and any compensating controls in place. Exceptions are recorded in the ISMS risk register and reviewed at their expiry date.

Exceptions must not be granted verbally. Unapproved exceptions constitute a policy violation.

---

## 7. Related Controls

This policy supports the following ISO/IEC 27001:2022 Annex A controls:

| Control ID | Control Name |
|------------|-------------|
| A.5.15 | Access control |
| A.5.16 | Identity management |
| A.5.17 | Authentication information |
| A.5.18 | Access rights |
| A.6.1 | Screening |
| A.6.5 | Responsibilities after termination or change of employment |
| A.8.2 | Privileged access rights |
| A.8.5 | Secure authentication |

---

## 8. Related Documents

- ISMS-POL-001: Acceptable Use Policy
- ISMS-POL-003: Incident Response Policy
- Information Security Risk Register
- Statement of Applicability
- Data Retention Policy
- HR Onboarding and Offboarding Procedure
- Supplier Security Assessment Process

---

## 9. Version History

| Version | Date | Author | Change Description |
|---------|------|--------|--------------------|
| 1.0 | [YYYY-MM-DD] | [Author Name] | Initial version. |
