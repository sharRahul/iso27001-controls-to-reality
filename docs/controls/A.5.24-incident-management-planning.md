# A.5.24 – Information Security Incident Management Planning and Preparation

## Control Objective

Plan and prepare for managing information security incidents by defining processes, roles, responsibilities, and communication paths before an incident occurs.

## Why It Matters

Incident cost is decided in the first hours, and improvisation is expensive. An organisation that has not defined severity levels, escalation paths, and evidence handling before an incident will make slower, riskier decisions under pressure and may miss regulatory notification deadlines such as the UK GDPR 72-hour window. Auditors expect proof of preparation: a tested plan, not just a written one.

## Technical Implementation

### Process and Documentation

1. Adopt and adapt the incident response policy template in [`docs/isms-policy-templates/incident-response-policy.md`](../isms-policy-templates/incident-response-policy.md), including the P1 to P4 severity model.
2. Write playbooks for the highest-likelihood scenarios: ransomware, business email compromise, account compromise, and data breach.
3. Store the plan and playbooks somewhere reachable when primary systems are down (offline copy or separate tenant).
4. Define the incident roster: incident commander, deputies, communications lead, legal contact, and out-of-hours cover.
5. Run at least one tabletop exercise per year against a realistic scenario and record findings and improvement actions.

### Microsoft 365

1. Configure Defender XDR incident notifications so P1/P2-equivalent alerts reach the on-call channel, not just the portal.
2. Grant the incident response team least-privilege roles needed during response (for example Security Reader routinely, with PIM-eligible Security Operator for containment actions).
3. Verify audit log retention meets the investigation window your plan assumes.

### Azure

1. Ensure diagnostic logs for critical resources flow to a Log Analytics workspace the responders can query.
2. Pre-stage break-glass access procedures for responders in case Conditional Access or identity services are the impacted system.

## Verification Commands

```powershell
# Read-only: confirm Defender XDR/Sentinel incidents are flowing (requires SecurityIncident.Read.All)
Connect-MgGraph -Scopes "SecurityIncident.Read.All"
Get-MgSecurityIncident -Top 20 | Select-Object DisplayName, Severity, Status, CreatedDateTime
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Incident response plan | PDF | Approved plan with version history and owner |
| Severity matrix and contact roster | PDF/XLSX | Current escalation contacts including out-of-hours cover |
| Playbooks | PDF | Scenario playbooks for ransomware, BEC, account compromise, data breach |
| Tabletop exercise report | PDF | Scenario, attendees, decisions, findings, and improvement actions with owners |
| Improvement action tracker | XLSX/Ticket | Evidence that exercise and incident findings were actioned |

## Audit Questions

1. Walk me through what happens in the first hour after a suspected ransomware detection.
2. Who is the incident commander, and who deputises when they are unavailable?
3. When did you last test the plan, and what changed as a result?
4. How would responders access the plan if your document management system were encrypted?
5. How do you decide whether an incident is notifiable to the ICO or affected customers?
6. Show me the improvement actions from your last exercise or real incident and their status.

## Common Gaps and False Compliance Patterns

- **Plan without a test**: A polished document that has never been exercised; the first test is a real incident.
- **Stale roster**: Escalation contacts include leavers or old phone numbers, discovered only during an incident.
- **Plan locked inside the blast radius**: The only copy of the plan lives in the system the ransomware scenario takes offline.
- **Findings without owners**: Tabletop reports exist but improvement actions have no owner or due date, so nothing changes.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | Respond: RS.MA-01, RS.CO |
| Cyber Essentials | N/A (supports Malware Protection theme) |
| ISO 27001:2022 | Annex A 5.24; related A.5.25, A.5.26, A.5.27, A.5.28 |

## Suggested Evidence File Naming

```
2026-05-01_A.5.24_Process_IRPlan_SecOps_v1.pdf
2026-05-01_A.5.24_Process_TabletopReport_SecOps_v1.pdf
```
