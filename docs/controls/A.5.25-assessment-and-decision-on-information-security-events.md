# A.5.25 – Assessment and Decision on Information Security Events

## Control Objective

Ensure security events are assessed consistently and a decision is made on whether they should be classified as incidents requiring escalation or response.

## Why It Matters

Detection only has value when alerts are triaged, classified, and acted on consistently. Auditors expect evidence that analysts follow defined criteria, record decisions, preserve relevant evidence, and escalate events that meet incident thresholds.

## Technical Implementation

### Microsoft 365

1. Use Microsoft Defender XDR incidents and alerts as a triage source for identity, email, endpoint, and cloud signals.
2. Define severity and classification criteria for true positive, benign positive, false positive, and informational events.
3. Record analyst decision, evidence reviewed, containment decision, and escalation outcome in an incident/ticket system.
4. Review closed incidents for quality and tuning opportunities.

### Azure

1. Use Microsoft Sentinel incidents or another SIEM queue for event assessment.
2. Configure alert rules with clear severity and entity mapping.
3. Route high-severity incidents to the correct response owners.

### On-Premises

1. Feed firewall, endpoint, VPN, identity, and server logs into the SOC process where in scope.
2. Define manual escalation routes for systems that do not create SIEM alerts.

## Verification Commands

```powershell
# Read-only: sample recent directory audit events for assessment evidence.
Connect-MgGraph -Scopes "AuditLog.Read.All"
Get-MgAuditLogDirectoryAudit -Top 20 |
    Select-Object ActivityDateTime, ActivityDisplayName, Category, Result
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Triage SOP | PDF | Defines event classification and decision criteria. |
| Sample closed alert tickets | PDF/CSV | Shows analyst decisions and escalation rationale. |
| SIEM or Defender incident export | CSV/JSON | Shows alert source, severity, owner, status, and closure reason. |
| Quality review record | PDF/XLSX | Shows periodic review of triage decisions and tuning actions. |

## Audit Questions

1. How do analysts decide whether an event is an incident?
2. Which event sources are covered by the triage process?
3. How are false positives documented and tuned?
4. What evidence must be preserved before closure?
5. Who can downgrade or close a high-severity event?
6. How are repeated events escalated or converted into problem records?

## Common Gaps and False Compliance Patterns

- **Alert queue exists but no decision trail**: Alerts are closed without evidence or rationale.
- **Severity is tool-defined only**: Business context and asset criticality are not considered.
- **No escalation threshold**: Analysts rely on judgement without documented criteria.
- **No tuning feedback loop**: Repeated false positives are closed repeatedly but not improved.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | DE.AE-01 |
| Cyber Essentials | Malware Protection |
| ISO 27001:2022 | Annex A 5.25 |

## Suggested Evidence File Naming

```text
2026-05-01_A.5.25_SOC_TriageSOP_SecOps_v1.pdf
2026-05-01_A.5.25_SOC_ClosedAlertSample_SecOps_v1.csv
```