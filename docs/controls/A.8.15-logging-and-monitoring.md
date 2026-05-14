# A.8.15 – Logging and Monitoring

## Control Objective

Produce, retain, and review event logs for information systems to support detection of anomalous activities and forensic investigation.

## Why It Matters

Without comprehensive logging, security incidents may go undetected or be impossible to reconstruct, undermining both operational resilience and compliance obligations. Regulators and auditors routinely request log evidence as a primary indicator of control maturity; absent logs are treated as absent controls.

## Technical Implementation

### Microsoft 365

1. Enable the Unified Audit Log (UAL) in the Microsoft Purview compliance portal under **Audit** → **Start recording user and admin activity**.
2. Confirm UAL is enabled via PowerShell: `Get-AdminAuditLogConfig | Select-Object UnifiedAuditLogIngestionEnabled`
3. Set audit log retention: E3 licences retain logs for 90 days; E5 or Purview Audit (Premium) extends this to one year or ten years with additional licences.
4. Enable mailbox auditing for all mailboxes: `Get-OrganizationConfig | Select-Object AuditDisabled` (should be `False`).
5. Configure Microsoft Sentinel or a third-party SIEM to ingest UAL data via the Microsoft 365 connector.
6. Define alert rules for high-risk events: admin consent grants, mail-forwarding rules, bulk downloads, MFA changes, and privileged role assignments.

### Azure

1. Enable **Diagnostic Settings** on all Azure resources and route logs to a Log Analytics Workspace and/or Storage Account.
2. Enable **Azure Activity Logs** at subscription level; export to the central Log Analytics Workspace.
3. Enable **Microsoft Defender for Cloud** and configure continuous export of security alerts to the SIEM.
4. Enable **Azure AD (Entra ID) audit logs and sign-in logs**; route to Log Analytics with at least 90-day retention (180+ days recommended).
5. Enable **Azure Monitor Alerts** for critical operations: subscription ownership changes, Key Vault access, network security group modifications.
6. Review and set retention policies per workspace under Log Analytics → Usage and Estimated Costs → Data Retention (minimum 90 days; 180 days recommended for audit periods).

### On-Premises

1. Enable Windows Event Forwarding (WEF) to a Windows Event Collector (WEC) server and forward to the SIEM.
2. Collect at minimum: Event IDs 4624, 4625, 4634, 4648, 4720, 4722, 4724, 4728, 4732, 4740, 4768, 4769, 4776 (authentication and account management).
3. Enable PowerShell Script Block Logging (Event ID 4104) via Group Policy.
4. Enable DNS audit logging and Sysmon on all servers and privileged endpoints.
5. Route network device (firewall, switch, VPN) syslog to the SIEM using UDP/TCP 514 or TLS syslog.
6. Define and document log retention policy: minimum 90 days online, 12 months total.

## Verification Commands

```powershell
# Confirm Unified Audit Log is enabled in M365
Connect-ExchangeOnline
Get-AdminAuditLogConfig | Select-Object UnifiedAuditLogIngestionEnabled

# List Diagnostic Settings configured on an Azure subscription (requires Az module)
Get-AzDiagnosticSetting -ResourceId "/subscriptions/<sub-id>"

# Check mailbox audit status
Get-OrganizationConfig | Select-Object AuditDisabled
```

## What Audit Evidence Looks Like

| Evidence Item | Format | Description |
|---|---|---|
| UAL enabled screenshot | PNG/PDF | Purview Audit page showing "Recording" status |
| Audit log configuration export | CSV/JSON | `Get-AdminAuditLogConfig` output |
| SIEM connector status | Screenshot | Sentinel Data Connectors blade showing M365 connector as Connected |
| Log retention policy | Screenshot/PDF | Log Analytics workspace retention settings |
| Sample alert rule | JSON export | Sentinel analytic rule or Defender alert policy |

## Common Gaps and False Compliance Patterns

- **UAL enabled but not collected**: The audit log is enabled in M365 but no SIEM or export process ingests the data. Evidence of "enabled" is not evidence of "monitored".
- **Retention shorter than audit period**: Logs retained for 90 days when the surveillance audit covers a 12-month period. Auditors will request evidence across the full period.
- **Mailbox auditing disabled at tenant level**: `AuditDisabled` set to `True` in `Get-OrganizationConfig`, meaning individual mailbox audit settings are ignored.
- **Alert fatigue suppression**: High-volume alert rules suppressed or disabled after initial noise, leaving genuine detections silent.
- **On-premises servers excluded from scope**: WEF/SIEM covers cloud workloads but on-premises servers and network devices have no log forwarding.

## Suggested Evidence File Naming

```
2026-05-01_A.8.15_M365-UAL_ConfigExport_ITSecurity_v1.csv
2026-05-01_A.8.15_Azure_DiagnosticSettings_CloudSec_v1.json
2026-05-01_A.8.15_Sentinel_ConnectorStatus_SOC_v1.png
```
