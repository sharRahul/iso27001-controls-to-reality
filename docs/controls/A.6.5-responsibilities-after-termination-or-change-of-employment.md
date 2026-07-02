# A.6.5 – Responsibilities After Termination or Change of Employment

## Control Objective

Ensure information security responsibilities and access rights are updated, removed, or reaffirmed when people leave or change role.

## Why It Matters

Leavers and movers are a common source of excessive or orphaned access. Auditors expect evidence that access is revoked promptly, assets are returned, continuing obligations are communicated, and role changes trigger access review.

## Technical Implementation

### Microsoft 365

1. Disable or delete leaver accounts according to the retention and mailbox handover process.
2. Revoke active sessions and remove group, licence, mailbox delegation, and application access.
3. Review OneDrive, SharePoint, Teams ownership, and mailbox forwarding rules before closure.
4. Use lifecycle workflows or HR-driven provisioning where licensed.

### Azure

1. Remove Azure RBAC assignments and PIM eligibility for leavers and movers.
2. Rotate shared secrets or keys known by departing privileged users.
3. Transfer ownership of subscriptions, resource groups, app registrations, and automation accounts.

### On-Premises

1. Disable AD accounts, VPN access, local administrator accounts, and physical access cards.
2. Collect devices, tokens, badges, and removable media.
3. Record asset return and access removal timestamps.

## Verification Commands

```powershell
# Read-only: sample disabled users and recent sign-in state.
Connect-MgGraph -Scopes "User.Read.All","AuditLog.Read.All"
Get-MgUser -All -Property DisplayName,UserPrincipalName,AccountEnabled |
    Where-Object { -not $_.AccountEnabled } |
    Select-Object DisplayName, UserPrincipalName, AccountEnabled
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Leaver checklist | PDF/XLSX | Shows HR, IT, facilities, and manager tasks completed. |
| Account disable evidence | CSV/Screenshot | Shows access removed within the defined SLA. |
| Asset return record | PDF/CSV | Shows devices, badges, and tokens returned or risk-assessed. |
| Mover access review | CSV/PDF | Shows old role access removed after role change. |

## Audit Questions

1. How quickly must access be removed after termination?
2. How are role changes identified and reviewed?
3. How are shared secrets and privileged credentials handled for leavers?
4. How do you confirm assets are returned?
5. How are continuing confidentiality obligations communicated?
6. How are failed or delayed offboarding actions escalated?

## Common Gaps and False Compliance Patterns

- **Account disabled but sessions active**: Tokens and sessions are not revoked.
- **Mover access ignored**: Employees keep old role access after changing teams.
- **Shared credentials unchanged**: Departing administrators still know shared secrets.
- **Asset return separate from access removal**: IT cannot prove the full offboarding process completed.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | PR.AA-02 |
| Cyber Essentials | User Access Control |
| ISO 27001:2022 | Annex A 6.5 |

## Suggested Evidence File Naming

```text
2026-05-01_A.6.5_Process_LeaverChecklist_HRMgr_v1.pdf
2026-05-01_A.6.5_EntraID_AccountDisableEvidence_IAMOwner_v1.csv
```