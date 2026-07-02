# A.8.20 – Networks Security

## Control Objective

Secure network services, traffic flows, connectivity, and segmentation to protect information systems from unauthorised access or exposure.

## Why It Matters

Network controls reduce attack paths between users, workloads, cloud services, and sensitive environments. Auditors expect evidence that network boundaries are defined, firewall rules are justified, segmentation is reviewed, and insecure access paths are removed.

## Technical Implementation

### Microsoft 365

1. Review trusted locations, Conditional Access network conditions, and named locations.
2. Restrict administrative access from approved locations where this fits the risk model.
3. Monitor sign-ins from unfamiliar networks and anonymising services.

### Azure

1. Use NSGs, Azure Firewall, route tables, private endpoints, and service endpoints to restrict traffic.
2. Apply hub-and-spoke or equivalent segmentation for production, management, and shared services.
3. Log firewall, NSG flow, DNS, and diagnostic events to a monitored workspace.
4. Review public IP exposure and inbound management ports.

### On-Premises

1. Maintain approved firewall rules with owner, purpose, source, destination, port, and review date.
2. Segment user, server, management, guest, and production networks.
3. Remove legacy any/any rules and document exceptions.

## Verification Commands

```powershell
# Read-only: Azure examples.
Connect-AzAccount
Get-AzNetworkSecurityGroup | Select-Object Name, ResourceGroupName, Location
Get-AzPublicIpAddress | Select-Object Name, ResourceGroupName, IpAddress, PublicIpAllocationMethod
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Network architecture diagram | PDF/PNG | Shows boundaries, zones, and key traffic flows. |
| Firewall or NSG ruleset export | CSV/JSON | Shows approved rules and exposed services. |
| Ruleset review record | PDF/XLSX | Shows owner review and remediation of risky rules. |
| Public exposure report | CSV/PDF | Shows internet-facing assets and management port review. |

## Audit Questions

1. How are network zones defined and documented?
2. How are firewall and NSG rules approved?
3. How often are network rules reviewed?
4. How do you detect unauthorised public exposure?
5. Are management services restricted to trusted networks?
6. How are network exceptions risk-assessed?

## Common Gaps and False Compliance Patterns

- **Diagram does not match reality**: Architecture diagrams are not updated after cloud or network changes.
- **Rules without owners**: Firewall entries exist but nobody can justify them.
- **Any/any exceptions**: Broad rules remain because they are difficult to untangle.
- **No logging**: Network controls exist but denied/allowed traffic is not reviewed.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | PR.IR-01 |
| Cyber Essentials | Firewalls |
| ISO 27001:2022 | Annex A 8.20 |

## Suggested Evidence File Naming

```text
2026-05-01_A.8.20_Azure_NSGRuleset_NetSec_v1.csv
2026-05-01_A.8.20_Network_FirewallReview_NetSec_v1.xlsx
```