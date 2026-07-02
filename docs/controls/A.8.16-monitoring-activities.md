# A.8.16 – Monitoring Activities

## Control Objective

Monitor systems, networks, users, and applications to detect anomalous behaviour, security events, and potential information security incidents.

## Why It Matters

Logging alone is not enough; security teams must review events, generate alerts, triage anomalies, and improve detection coverage. Auditors expect evidence that monitoring is operational, assigned, tuned, and reviewed.

## Technical Implementation

### Microsoft 365

1. Use Defender XDR, Entra ID risk detections, Defender for Office 365, and Purview audit events as monitoring sources.
2. Review incidents and alerts daily or according to the SOC operating model.
3. Monitor privileged role changes, risky sign-ins, mailbox forwarding, OAuth consent, malware detections, and DLP incidents.
4. Record alert ownership, severity, decision, and closure reason.

### Azure

1. Send diagnostic logs and activity logs to Log Analytics or a SIEM.
2. Use Sentinel analytics rules, automation rules, and workbooks where in scope.
3. Monitor disabled logging, policy changes, public exposure, and privileged role changes.

### On-Premises

1. Forward endpoint, server, firewall, VPN, and identity logs to the SIEM where in scope.
2. Define minimum use cases and alert ownership for critical systems.

## Verification Commands

```powershell
# Read-only: collect recent Entra risk detections.
Connect-MgGraph -Scopes "IdentityRiskEvent.Read.All","AuditLog.Read.All"
Get-MgRiskDetection -Top 50 |
    Select-Object DetectedDateTime, RiskEventType, RiskLevel, RiskState, UserPrincipalName
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Alert rule export | JSON/CSV | Shows active monitoring rules and severity. |
| Incident queue sample | CSV/Screenshot | Shows alerts are generated and assigned. |
| SOC review log | PDF/XLSX | Shows recurring review and tuning activity. |
| Risk detection export | CSV | Shows monitored identity risk events. |

## Audit Questions

1. Which systems and events are monitored?
2. Who reviews alerts and how often?
3. How are high-severity alerts escalated?
4. How are false positives tuned?
5. How do you detect disabled or failing log sources?
6. How is monitoring coverage reviewed against current threats?

## Common Gaps and False Compliance Patterns

- **Logs collected but not monitored**: Events are stored but no alerting or review process exists.
- **Paused alert rules**: Rules exist but are disabled, suppressed, or unassigned.
- **No tuning records**: Alerts are repeatedly closed without improvement.
- **No data-source health monitoring**: The SOC does not know when a connector stops sending logs.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | DE.AE-02 |
| Cyber Essentials | N/A |
| ISO 27001:2022 | Annex A 8.16 |

## Suggested Evidence File Naming

```text
2026-05-01_A.8.16_Sentinel_AlertRules_SecOps_v1.json
2026-05-01_A.8.16_EntraID_RiskDetections_SecOps_v1.csv
```