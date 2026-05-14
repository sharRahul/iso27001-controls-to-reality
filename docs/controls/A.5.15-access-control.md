# A.5.15 – Access Control

## Control Objective

Restrict access to information and associated assets to authorised individuals based on business requirements and the principle of least privilege.

## Why It Matters

Uncontrolled access is the root cause of a significant proportion of data breaches, both from external actors exploiting over-privileged accounts and from insider threats accessing information beyond their job function. Demonstrating a mature access control model is a foundational audit expectation and underpins almost every other security control.

## Technical Implementation

### Microsoft 365

1. Define role-based access control (RBAC) for all M365 services: Exchange, SharePoint, Teams, and the compliance portal.
2. Apply the principle of least privilege: assign users the minimum M365 admin role required (e.g., Exchange Administrator rather than Global Administrator).
3. Configure Conditional Access policies in Microsoft Entra ID to enforce access requirements by user, device, location, and risk.
4. Implement access reviews in Microsoft Entra ID Governance (requires P2 licence) for privileged roles, guest accounts, and group membership.
5. Restrict external sharing in SharePoint and OneDrive to approved domains only; disable anonymous (Anyone) links for sensitive sites.
6. Apply sensitivity labels to enforce encryption and access restrictions on documents and emails.
7. Review and restrict guest user permissions in Entra ID: ensure guests cannot enumerate the directory or access all Teams/Groups by default.

### Azure

1. Use Azure RBAC to assign roles at the appropriate scope (management group → subscription → resource group → resource); avoid broad subscription-level Owner assignments.
2. Enable just-in-time (JIT) VM access through Microsoft Defender for Cloud to remove persistent RDP/SSH exposure.
3. Use Azure Managed Identities instead of service accounts with stored credentials for workload-to-service authentication.
4. Enable Privileged Identity Management (PIM) for all Azure resource roles; require approval and justification for activation.
5. Review Azure RBAC assignments quarterly: `Get-AzRoleAssignment` or export from the Access Control (IAM) blade.
6. Enforce resource locks on critical resources (production key vaults, storage accounts) to prevent accidental deletion.

### On-Premises

1. Apply the principle of least privilege to Active Directory group membership; remove users from Domain Admins and Enterprise Admins when not required.
2. Implement tiered administration (Tier 0: AD/DC, Tier 1: Server, Tier 2: Workstation) and enforce using Group Policy and Protected Users security group.
3. Use separate admin accounts for privileged tasks; standard user accounts must not have local administrator rights.
4. Perform quarterly access reviews for privileged groups (Domain Admins, Enterprise Admins, Schema Admins, local Administrators on servers).
5. Configure and audit NTFS permissions on file shares; remove legacy "Everyone" and "Authenticated Users" permissions.
6. Implement LAPS (Local Administrator Password Solution) to randomise local administrator passwords on all workstations and servers.

## Verification Commands

```powershell
# Export Conditional Access policies (requires Microsoft.Graph module)
Connect-MgGraph -Scopes "Policy.Read.All"
Get-MgIdentityConditionalAccessPolicy | Select-Object DisplayName, State | Export-Csv "CA-Policies.csv" -NoTypeInformation

# Export Azure RBAC assignments at subscription scope
Get-AzRoleAssignment | Select-Object DisplayName, RoleDefinitionName, Scope | Export-Csv "Azure-RBAC.csv" -NoTypeInformation

# List members of Domain Admins
Get-ADGroupMember -Identity "Domain Admins" -Recursive | Select-Object Name, SamAccountName
```

## What Audit Evidence Looks Like

| Evidence Item | Format | Description |
|---|---|---|
| Conditional Access policy list | CSV/Screenshot | List of policies with state (Enabled/Report-only/Disabled) |
| Azure RBAC export | CSV | All role assignments across subscription scope |
| PIM role assignment report | CSV/Screenshot | Active and eligible role assignments |
| Access review results | PDF/Screenshot | Completed Entra ID Governance access review with approval decisions |
| SharePoint external sharing settings | Screenshot | Tenant-level and site-level sharing configuration |

## Common Gaps and False Compliance Patterns

- **Policy exists, not enforced**: Conditional Access policies in Report-only mode are not enforcing access control; this is a common finding after pilots that were never activated.
- **Break-glass accounts excluded from all policies**: Necessary but must be documented, monitored, and the accounts must have long complex passwords and MFA alternatives.
- **Ownership without least privilege**: Users assigned broad roles (e.g., Global Admin, Owner) for convenience rather than necessity.
- **Access reviews completed but not actioned**: Review results show stale access but removal tickets were never raised.
- **Guest proliferation**: External guest accounts accumulate over time with no removal process after project completion.

## Suggested Evidence File Naming

```
2026-05-01_A.5.15_EntraID_CAPolicy-Export_IAMOwner_v1.csv
2026-05-01_A.5.15_Azure_RBACAssignments_CloudSec_v1.csv
2026-05-01_A.5.15_EntraID_AccessReview_IAMOwner_v1.pdf
```
