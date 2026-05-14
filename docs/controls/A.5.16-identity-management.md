# A.5.16 – Identity Management

## Control Objective

Manage the full lifecycle of digital identities — creation, modification, review, suspension, and deletion — to ensure only authorised individuals hold active identities with appropriate access.

## Why It Matters

Orphaned accounts, stale service identities, and poorly governed guest access are among the most consistently identified findings in ISO 27001 audits; they represent persistent access pathways that circumvent joiner-mover-leaver controls. Effective identity lifecycle management underpins every access and authentication control in Annex A.

## Technical Implementation

### Microsoft 365

1. Integrate Microsoft Entra ID with the HR system (e.g., Workday, SAP SuccessFactors) using Entra ID inbound provisioning to automate account creation and attribute population.
2. Define and enforce a joiner-mover-leaver (JML) process: accounts must be created before day one, modified within one business day of a role change, and disabled within four hours of a confirmed leaver event.
3. Configure Lifecycle Workflows in Entra ID (requires Entra ID Governance licence) to automate pre-hire, day-one, and leaver tasks.
4. Implement Entra ID access reviews for all privileged roles, group memberships, and application assignments; schedule quarterly for privileged access, annually for standard access.
5. Enforce a guest account review process: all external (B2B) guest accounts must have a business sponsor, a defined expiry, and be reviewed quarterly.
6. Disable or convert shared mailboxes to prevent interactive sign-in; shared accounts must never be used for interactive authentication.

### Azure

1. Use Entra ID as the sole identity provider for Azure; do not create local VM accounts or SQL authentication accounts where Entra ID integration is available.
2. Apply PIM to all Azure resource roles; require approval for Owner and Contributor at subscription scope.
3. Audit service principal (application) registrations quarterly: remove unused applications, rotate credentials, and enforce expiry on client secrets.
4. Use Entra ID Workload Identity Federation for CI/CD pipelines to eliminate stored credentials in pipeline variables or source control.
5. Export and review all Entra ID role assignments monthly: `Get-MgDirectoryRole` and `Get-MgRoleManagementDirectoryRoleAssignment`.

### On-Premises

1. Disable Active Directory accounts on the day of leaver notification; do not delete accounts for a minimum of 30 days to allow mailbox and OneDrive data recovery.
2. Move disabled accounts to a dedicated "Disabled Users" OU and remove all group memberships on disablement.
3. Audit service accounts quarterly: document each service account, its purpose, owner, password rotation date, and the systems it authenticates to.
4. Implement LAPS for local administrator accounts on all workstations and servers to prevent lateral movement via shared passwords.
5. Review and remove stale accounts: accounts inactive for more than 90 days should be investigated and disabled or documented.

## Verification Commands

```powershell
# Export all Entra ID privileged role assignments
Connect-MgGraph -Scopes "RoleManagement.Read.Directory","Directory.Read.All"
Get-MgRoleManagementDirectoryRoleAssignment -All |
    Select-Object PrincipalId, RoleDefinitionId, DirectoryScopeId |
    Export-Csv "EntraID-PrivilegedRoles.csv" -NoTypeInformation

# Find stale AD accounts (inactive >90 days)
$cutoff = (Get-Date).AddDays(-90)
Search-ADAccount -AccountInactive -DateTime $cutoff -UsersOnly |
    Select-Object Name, SamAccountName, LastLogonDate, Enabled |
    Export-Csv "Stale-ADAccounts.csv" -NoTypeInformation

# Export Entra ID guest accounts
Get-MgUser -Filter "UserType eq 'Guest'" -All |
    Select-Object DisplayName, UserPrincipalName, CreatedDateTime, AccountEnabled |
    Export-Csv "EntraID-GuestAccounts.csv" -NoTypeInformation
```

## What Audit Evidence Looks Like

| Evidence Item | Format | Description |
|---|---|---|
| Privileged role assignment export | CSV | All Entra ID and Azure roles with assignment type (active/eligible) |
| Leaver process evidence | Screenshot/Ticket | Helpdesk ticket showing account disabled within SLA on confirmed leaver |
| Access review results | PDF/Screenshot | Completed quarterly access review with certification decisions |
| Stale account report | CSV | Accounts inactive >90 days with disposition (disabled/documented) |
| Guest account register | CSV | All B2B guest accounts with sponsor, purpose, and review date |
| Service account register | XLSX | Inventory of service accounts with owner, rotation date, and system |

## Common Gaps and False Compliance Patterns

- **JML process documented but not enforced**: Policy states accounts are disabled on the day of leaving, but evidence shows a lag of days or weeks between leaver date and account disablement.
- **Privileged role assignments outside PIM**: Permanent (non-PIM) role assignments for privileged roles alongside PIM-managed assignments, effectively bypassing the governance model.
- **Guest accounts without expiry or sponsor**: Hundreds of guest accounts accumulated with no owner, no expiry, and no review history.
- **Service accounts shared across teams**: A single service account used by multiple applications and teams, making rotation disruptive and ownership unclear.
- **Identity management in policy only**: The organisation has an identity management policy but no technical controls, access reviews, or lifecycle workflows to operationalise it.

## Suggested Evidence File Naming

```
2026-05-01_A.5.16_EntraID_PrivilegedRoles_IAMOwner_v1.csv
2026-05-01_A.5.16_EntraID_GuestAccounts_IAMOwner_v1.csv
2026-05-01_A.5.16_AD_StaleAccounts_ITAdmin_v1.csv
```
