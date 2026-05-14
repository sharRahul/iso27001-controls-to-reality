# Access Control Policy Template

## 1. Purpose

Define how access to information systems, applications, data, and administrative functions is requested, approved, provisioned, reviewed, changed, and removed.

## 2. Scope

This policy applies to all employees, contractors, administrators, service accounts, third parties, cloud services, endpoints, and applications within the ISMS scope.

## 3. ISO 27001 control mapping

| Control | Relevance |
| --- | --- |
| A.5.15 Access control | Defines the access control rules and business need principles. |
| A.5.16 Identity management | Supports identity lifecycle governance. |
| A.5.17 Authentication information | Protects credentials and authentication secrets. |
| A.5.18 Access rights | Requires provisioning, review, change, and removal of access rights. |
| A.8.2 Privileged access rights | Requires stricter governance for administrative access. |
| A.8.5 Secure authentication | Requires strong authentication proportionate to risk. |

## 4. Policy statements

1. Access must be granted only where there is a documented business need.
2. Access must be approved by an authorised owner before provisioning.
3. Access must follow least privilege and role-based access control where possible.
4. Privileged access must use separate administrative accounts or equivalent controls.
5. Privileged access must be protected by MFA and reviewed more frequently than standard user access.
6. Shared accounts must be avoided. Where unavoidable, they must have an owner, purpose, approval, monitoring, and expiry date.
7. Service accounts must have documented ownership, least privilege, credential rotation, and monitoring.
8. Leaver access must be removed within the organisation's defined SLA.
9. Mover access must be changed when a user changes role, team, or responsibility.
10. Exceptions must be risk accepted, time-bound, and reviewed before expiry.

## 5. Minimum evidence

| Evidence | Owner | Frequency |
| --- | --- | --- |
| Access request and approval samples | System owner | Quarterly |
| Joiner mover leaver ticket samples | HR and IT operations | Quarterly |
| Privileged role assignment export | Identity owner | Monthly |
| Access review completion report | Control owner | Quarterly |
| MFA and Conditional Access export | Identity owner | Monthly |
| Exception register | Risk owner | Monthly |

## 6. Review and approval

| Role | Name | Approval reference | Date |
| --- | --- | --- | --- |
| Policy owner | `<name>` | `<approval-ref>` | `<yyyy-mm-dd>` |
| Senior management approver | `<name>` | `<approval-ref>` | `<yyyy-mm-dd>` |
