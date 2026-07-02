# A.7.4 – Physical Security Monitoring

## Control Objective

Monitor physical access to in-scope offices, secure rooms, and information-processing locations to detect and investigate unauthorised access.

## Why It Matters

Physical access can bypass many technical controls. Auditors expect evidence that entry points, visitor access, secure areas, and physical security events are logged, reviewed, and retained according to risk.

## Technical Implementation

### Microsoft 365

1. Store visitor logs, access reviews, and CCTV policy documents in a controlled evidence library.
2. Use Teams or ITSM workflows for reporting physical security incidents.
3. Restrict physical security evidence because it may contain personal data.

### Azure

1. For Azure-hosted services, rely on supplier assurance reports for Microsoft datacentre physical controls.
2. Retain Service Trust Portal evidence for cloud datacentre control reliance.

### On-Premises

1. Use badge access, visitor logs, CCTV, door alarms, or guard logs for in-scope locations.
2. Review access logs for secure rooms and sensitive areas on a defined cadence.
3. Revoke physical access when staff leave or change role.
4. Record physical security incidents and remediation actions.

## Verification Commands

```powershell
# No Microsoft Graph command proves physical access monitoring.
# Use facilities access-control exports, visitor logs, CCTV review records, and supplier assurance evidence.
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Door access review | CSV/PDF | Shows access to in-scope locations was reviewed. |
| Visitor log sample | CSV/PDF | Shows visitor identity, sponsor, time in/out, and access scope. |
| CCTV or physical monitoring policy | PDF | Shows monitoring purpose, retention, access control, and review cadence. |
| Physical incident record | PDF/CSV | Shows investigation and remediation of physical access events. |

## Audit Questions

1. Which physical locations are included in ISMS scope?
2. How is physical access granted, reviewed, and removed?
3. How are visitors approved, escorted, and logged?
4. How long are CCTV and access logs retained?
5. Who can access physical monitoring records?
6. How are physical security incidents escalated?

## Common Gaps and False Compliance Patterns

- **Cloud controls assumed for offices**: Microsoft datacentre assurance does not cover local office or secure-room access.
- **Visitor logs incomplete**: Visitors are recorded on arrival but not signed out or sponsored.
- **Access not removed**: Leavers retain badges or door access after termination.
- **Monitoring without review**: Logs exist but are never checked unless an incident happens.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | PR.PS-01 |
| Cyber Essentials | Secure Configuration |
| ISO 27001:2022 | Annex A 7.4 |

## Suggested Evidence File Naming

```text
2026-05-01_A.7.4_Facilities_AccessReview_Facilities_v1.csv
2026-05-01_A.7.4_Facilities_VisitorLog_Facilities_v1.pdf
```