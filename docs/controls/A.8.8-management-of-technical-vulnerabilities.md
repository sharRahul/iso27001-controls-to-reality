# A.8.8 – Management of Technical Vulnerabilities

## Control Objective

Identify, assess, prioritise, remediate, and track technical vulnerabilities across in-scope systems within defined risk-based timeframes.

## Why It Matters

Unpatched or unremediated vulnerabilities are a common route to compromise. Auditors expect evidence that vulnerabilities are discovered regularly, risk-ranked, assigned to owners, remediated within SLA, and formally accepted when remediation is delayed.

## Technical Implementation

### Microsoft 365

1. Review Microsoft Defender Vulnerability Management or Defender for Endpoint exposure data where licensed.
2. Track endpoint software inventory, missing updates, exposed devices, and remediation recommendations.
3. Record remediation ownership and due dates in ITSM or vulnerability management tooling.
4. Monitor exceptions for approved compensating controls and expiry dates.

### Azure

1. Enable Defender for Cloud vulnerability recommendations for virtual machines, containers, and cloud resources where in scope.
2. Review Azure Update Manager, container image scanning, and dependency scanning findings.
3. Map critical findings to tickets and risk decisions.

### On-Premises

1. Run authenticated vulnerability scans for servers, network devices, and endpoints.
2. Review patch compliance and unsupported software reports.
3. Validate remediation through rescan or endpoint telemetry.

## Verification Commands

```powershell
# Microsoft Graph v1.0 does not expose all Defender vulnerability management evidence safely.
# Use Defender portal exports, Defender API evidence, scanner reports, or ITSM remediation exports.
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Vulnerability dashboard export | CSV/PDF | Shows open vulnerabilities, severity, affected assets, and exposure. |
| Remediation ticket sample | PDF/CSV | Shows owner, due date, action, closure, and validation evidence. |
| SLA performance report | CSV/XLSX | Shows ageing, overdue items, and SLA compliance. |
| Exception register | CSV/XLSX | Shows approved risk acceptance with expiry and compensating controls. |

## Audit Questions

1. Which assets are covered by vulnerability scanning or exposure management?
2. How are vulnerabilities prioritised?
3. What remediation SLAs apply to critical, high, medium, and low findings?
4. How is remediation validated?
5. How are exceptions approved and reviewed?
6. How are unsupported systems identified and risk-managed?

## Common Gaps and False Compliance Patterns

- **Scanning without remediation**: Findings are generated but not tracked to closure.
- **Only endpoints covered**: Cloud, network, applications, and third-party services are missed.
- **No ageing view**: The team cannot show which vulnerabilities breach SLA.
- **Permanent exceptions**: Accepted risks have no expiry date or compensating control.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | ID.RA-01 |
| Cyber Essentials | Security update management |
| ISO 27001:2022 | Annex A 8.8 |

## Suggested Evidence File Naming

```text
2026-05-01_A.8.8_MDE_VulnerabilityDashboard_VulnMgr_v1.csv
2026-05-01_A.8.8_ITSM_RemediationTickets_VulnMgr_v1.xlsx
```