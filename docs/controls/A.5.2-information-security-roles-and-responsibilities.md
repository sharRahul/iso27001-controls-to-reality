# A.5.2 – Information Security Roles and Responsibilities

## Control Objective

Assign and communicate information security roles, responsibilities, authorities, and accountability so the ISMS operates consistently.

## Why It Matters

Controls fail when nobody is clearly accountable for operating, reviewing, or improving them. Auditors expect a traceable ownership model that connects policies, risks, systems, and evidence to named roles or accountable functions.

## Technical Implementation

### Microsoft 365

1. Map Microsoft 365 administrative roles to security responsibilities and least-privilege role groups.
2. Use Entra ID groups for role assignment where possible and review membership regularly.
3. Document owners for Conditional Access, Purview, Defender, Exchange, SharePoint, Teams, and Intune.
4. Keep emergency access account ownership separate from normal administrator operations.

### Azure

1. Map Azure RBAC roles to cloud security responsibilities.
2. Use management groups, subscriptions, and resource groups to define scope boundaries.
3. Assign owner, contributor, security reader, and monitoring responsibilities through documented groups.

### On-Premises

1. Map Active Directory, network, endpoint, backup, and physical security responsibilities to named owners.
2. Define deputies for critical operational roles.
3. Ensure privileged access procedures reference the same role model.

## Verification Commands

```powershell
# Read-only: export Entra directory roles and members.
Connect-MgGraph -Scopes "Directory.Read.All","RoleManagement.Read.Directory"
Get-MgDirectoryRole -All | Select-Object DisplayName, Id
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Security RACI matrix | XLSX/PDF | Shows accountable, responsible, consulted, and informed parties for key controls. |
| Role assignment export | CSV/JSON | Shows actual administrative roles and group memberships. |
| Job description or role profile extract | PDF | Shows security duties are embedded into relevant roles. |
| Deputy and escalation list | PDF/CSV | Shows continuity for critical security functions. |

## Audit Questions

1. Who is accountable for each Annex A control in scope?
2. How are security responsibilities communicated to staff and suppliers?
3. How are administrative duties separated from approval duties?
4. Who reviews privileged role assignments?
5. What happens when a control owner leaves or changes role?
6. Are deputies assigned for critical activities?

## Common Gaps and False Compliance Patterns

- **Generic owner only**: “IT” is listed as owner without an accountable role or decision maker.
- **No deputy model**: Security operations depend on one person being available.
- **Responsibilities not tied to access**: Users have admin rights but no documented duty.
- **RACI not reviewed**: The matrix no longer matches actual teams or systems.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | GV.RR-01 |
| Cyber Essentials | N/A |
| ISO 27001:2022 | Annex A 5.2 and Clause 5.3 |

## Suggested Evidence File Naming

```text
2026-05-01_A.5.2_Process_RACIMatrix_CISO_v1.xlsx
2026-05-01_A.5.2_EntraID_AdminRoleExport_IAMOwner_v1.csv
```