# A.8.23 – Web Filtering

## Control Objective

Restrict access to malicious, inappropriate, or unauthorised web resources according to business risk and acceptable use requirements.

## Why It Matters

Web access is a common path for malware delivery, phishing, credential theft, and data exposure. Auditors expect evidence that filtering is configured, reviewed, bypasses are controlled, and blocked events can be investigated.

## Technical Implementation

### Microsoft 365

1. Use Defender for Endpoint web content filtering where licensed and suitable.
2. Monitor web protection events, network protection, SmartScreen, and browser security settings.
3. Use Conditional Access and Defender signals to respond to risky sign-ins or unsafe access patterns.

### Azure

1. Route relevant outbound traffic through approved firewall, proxy, or secure web gateway controls.
2. Log DNS, firewall, proxy, or web gateway events to a monitored location.
3. Restrict management access and prevent direct unmanaged internet egress from sensitive workloads.

### On-Premises

1. Apply DNS filtering, proxy filtering, secure web gateway, or firewall URL categories.
2. Define blocked categories, allowed exceptions, and bypass approval workflow.
3. Review blocked-event samples and approved bypasses regularly.

## Verification Commands

```powershell
# Microsoft Graph v1.0 does not expose all web filtering configuration safely.
# Use Defender portal exports, secure web gateway exports, DNS-filtering reports, or firewall/proxy logs.
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Web filtering policy export | CSV/PDF | Shows categories, scope, actions, and exclusions. |
| Blocked event sample | CSV/Screenshot | Shows the control operates for malicious or disallowed destinations. |
| Bypass approval register | CSV/XLSX | Shows exceptions are approved, justified, and time-bound. |
| Review record | PDF/XLSX | Shows categories and exclusions are reviewed periodically. |

## Audit Questions

1. Which users, devices, and networks are covered by web filtering?
2. Which categories are blocked and why?
3. How are malicious URLs and phishing sites blocked?
4. How are bypass requests approved and expired?
5. How are blocked events monitored?
6. How is unmanaged or off-network browsing handled?

## Common Gaps and False Compliance Patterns

- **Filtering only on office network**: Remote or mobile devices bypass controls.
- **Permanent bypasses**: Exceptions never expire or receive owner review.
- **No event review**: Blocks occur but nobody monitors repeat attempts or malware categories.
- **Unclear category rationale**: Categories are blocked without business or risk justification.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | PR.PS-01 |
| Cyber Essentials | Malware Protection |
| ISO 27001:2022 | Annex A 8.23 |

## Suggested Evidence File Naming

```text
2026-05-01_A.8.23_Network_WebFilteringPolicy_NetSec_v1.pdf
2026-05-01_A.8.23_Network_BlockedEventSample_NetSec_v1.csv
```