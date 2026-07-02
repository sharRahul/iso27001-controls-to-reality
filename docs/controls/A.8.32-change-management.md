# A.8.32 – Change Management

## Control Objective

Control changes to information processing facilities, systems, applications, configurations, and services so they are authorised, tested, implemented, reviewed, and traceable.

## Why It Matters

Unauthorised or poorly controlled changes can create outages, weaken security, or remove evidence of accountability. Auditors expect a change process with approval, risk assessment, testing, rollback, emergency handling, and post-implementation review.

## Technical Implementation

### Microsoft 365

1. Record changes to Conditional Access, Exchange, SharePoint, Teams, Purview, Intune, and Defender policies through ITSM or change records.
2. Preserve admin audit logs and configuration exports for significant tenant changes.
3. Require approval before enforcing policies that affect access, data protection, or mail flow.
4. Review emergency changes after implementation.

### Azure

1. Use change records for Azure Policy, RBAC, networking, Key Vault, logging, and production resource changes.
2. Capture deployment logs, pipeline approvals, pull requests, and rollback plans.
3. Monitor Azure Activity Logs for out-of-process changes.

### On-Premises

1. Apply change approval to firewall rules, server builds, endpoint baselines, backups, and identity changes.
2. Use maintenance windows and rollback plans for high-risk changes.
3. Retain CAB minutes and emergency change reviews.

## Verification Commands

```powershell
# Read-only: sample recent directory audit events for change evidence.
Connect-MgGraph -Scopes "AuditLog.Read.All"
Get-MgAuditLogDirectoryAudit -Top 50 |
    Select-Object ActivityDateTime, ActivityDisplayName, InitiatedBy, Result
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Change management procedure | PDF | Defines standard, normal, emergency, and retrospective change handling. |
| Change log export | CSV/XLSX | Shows change owner, approval, risk, implementation date, and status. |
| CAB minutes | PDF | Shows review and approval for significant changes. |
| Post-implementation review | PDF/ITSM export | Shows outcome, issues, rollback decision, and lessons learned. |

## Audit Questions

1. Which changes require formal approval?
2. How are security risks assessed before implementation?
3. How are emergency changes approved and reviewed afterwards?
4. How are rollback plans documented?
5. How do you detect changes made outside the process?
6. How are failed changes reviewed and improved?

## Common Gaps and False Compliance Patterns

- **Ticket exists but no approval**: A change record was opened but not authorised.
- **Emergency changes never reviewed**: Urgent changes bypass process without retrospective approval.
- **No rollback evidence**: Plans are assumed but not documented or tested.
- **Tool-only evidence**: Audit logs show a change happened but not why it was approved.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | PR.PS-03 |
| Cyber Essentials | N/A |
| ISO 27001:2022 | Annex A 8.32 |

## Suggested Evidence File Naming

```text
2026-05-01_A.8.32_Process_ChangeLog_ITMgr_v1.csv
2026-05-01_A.8.32_Process_CABMinutes_ITMgr_v1.pdf
```