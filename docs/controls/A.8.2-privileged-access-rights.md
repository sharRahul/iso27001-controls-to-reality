# A.8.2 Privileged Access Rights

## Control objective

Ensure privileged access is authorised, restricted, monitored, reviewed, and removed when no longer required.

## Practical implementation scope

Include:

- Microsoft Entra ID privileged roles.
- Azure subscription and resource privileged roles.
- Microsoft 365 administrative roles.
- Local administrator access on servers and endpoints.
- Security tooling administrator roles.
- Emergency access and break-glass accounts.

## Implementation steps

### 1. Define privileged access rules

Document rules covering:

- Who can approve privileged access.
- Which roles require privileged access management.
- Whether privileged access is standing or just-in-time.
- MFA and phishing-resistant authentication requirements.
- Separate administrative accounts.
- Session logging and change ticket linkage.
- Review frequency and removal SLAs.

### 2. Implement least privilege

Recommended controls:

- Use Microsoft Entra Privileged Identity Management where licensed.
- Replace standing global administrator access with eligible role assignments.
- Require approval and justification for sensitive activations.
- Maintain at least two emergency accounts, but monitor and review them.
- Restrict local admin rights through endpoint management or LAPS.
- Review privileged service principals and app registrations.

### 3. Review privileged roles

At minimum, review:

- Global Administrator.
- Privileged Role Administrator.
- Conditional Access Administrator.
- Exchange Administrator.
- SharePoint Administrator.
- Security Administrator.
- Billing Administrator.
- Azure Owner and User Access Administrator.
- Privileged service principals and automation identities.

## Evidence examples

| Evidence item | Source | Supports |
| --- | --- | --- |
| Privileged role assignment export | Microsoft Graph / Entra admin centre | A.8.2 |
| PIM configuration screenshot or export | Entra admin centre | A.8.2 |
| Privileged access review results | Entra access reviews or GRC tool | A.8.2, A.5.18 |
| Break-glass account review ticket | ITSM or access review record | A.8.2, A.8.5 |
| Local admin policy export | Intune, GPO, LAPS, endpoint management | A.8.2 |

## Audit questions

- Who approves privileged access?
- Which privileged roles are permanently assigned and why?
- Is privileged access reviewed monthly or quarterly?
- Are privileged activations linked to tickets or business justification?
- Are emergency accounts monitored and reviewed?
- Are service principals and automation identities included in the review?

## Common gaps

- Global Administrator is permanently assigned to too many users.
- Access reviews include users but exclude service principals.
- PIM exists but roles are still assigned as permanent active roles.
- Emergency accounts are created but not monitored.
- Local administrator access is managed outside the central access review process.

## Suggested evidence names

```text
YYYY-MM-DD_A.8.2_Entra_PrivilegedRoleAssignments_Identity_v1.csv
YYYY-MM-DD_A.8.2_Entra_PIMConfiguration_Identity_v1.pdf
YYYY-MM-DD_A.8.2_AccessReview_PrivilegedRoles_Identity_v1.csv
```

## Automation support

Use `scripts/m365/Export-M365Iso27001Evidence.ps1` to export privileged directory role assignments and evidence index entries mapped to A.8.2.
