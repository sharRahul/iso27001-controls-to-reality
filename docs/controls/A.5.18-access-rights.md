# A.5.18 – Access Rights

## Control Objective

Ensure user and privileged access rights are provisioned, reviewed, adjusted, and removed according to business need and least-privilege principles.

## Why It Matters

Access rights drift over time as users change roles, join projects, or leave the organisation. Auditors expect evidence that access reviews are performed, exceptions are approved, and remediation actions are completed rather than merely identified.

## Technical Implementation

### Microsoft 365

1. Use Entra ID access reviews for groups, applications, guests, and privileged access where licensed.
2. Review privileged roles separately through PIM and directory role assignment exports.
3. Use lifecycle workflows or joiner-mover-leaver tickets to trigger access changes.
4. Review guest access and inactive accounts at least quarterly.
5. Track access review decisions, reviewer identity, completion date, and remediation actions.

### Azure

1. Review Azure RBAC assignments at management group, subscription, resource group, and critical resource scope.
2. Use PIM for eligible assignments and time-bound access.
3. Remove standing owner/contributor access unless justified.

### On-Premises

1. Review Active Directory privileged groups, file share permissions, VPN groups, and application admin groups.
2. Compare HR mover/leaver records against access removal evidence.
3. Record access changes through ITSM tickets.

## Verification Commands

```powershell
# Read-only: list access review definitions.
Connect-MgGraph -Scopes "AccessReview.Read.All","Directory.Read.All"
Get-MgIdentityGovernanceAccessReviewDefinition -All |
    Select-Object DisplayName, Status, CreatedDateTime, LastModifiedDateTime, Id

# Read-only: list directory role assignments.
Get-MgRoleManagementDirectoryRoleAssignment -All |
    Select-Object PrincipalId, RoleDefinitionId, DirectoryScopeId, Id
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Access review definition export | CSV/JSON | Shows review scope, recurrence, reviewers, and status. |
| Completed access review results | CSV/PDF | Shows reviewer decisions and completion date. |
| Remediation ticket evidence | PDF/CSV | Shows removed or adjusted access was actioned. |
| Privileged role review | CSV/PDF | Shows privileged access was reviewed separately. |

## Audit Questions

1. Which systems and roles are included in periodic access reviews?
2. How are reviewers selected and trained?
3. How are denied or adjusted access decisions remediated?
4. How do you confirm leavers and movers no longer retain inappropriate access?
5. Are privileged and guest accounts reviewed more frequently?
6. How are access review exceptions approved and tracked?

## Common Gaps and False Compliance Patterns

- **Review performed but no remediation**: Reviewers identify excessive access but nothing is removed.
- **Only privileged access reviewed**: Standard users, guests, and application access are missed.
- **Reviewer conflict**: Users approve their own access or managers approve access they do not understand.
- **No evidence of completion**: Meeting notes exist but no decision export or ticket trail.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | PR.AA-05 |
| Cyber Essentials | User Access Control |
| ISO 27001:2022 | Annex A 5.18 |

## Suggested Evidence File Naming

```text
2026-05-01_A.5.18_EntraID_AccessReviewDefinitions_IAMOwner_v1.csv
2026-05-01_A.5.18_ITSM_AccessReviewRemediation_IAMOwner_v1.pdf
```