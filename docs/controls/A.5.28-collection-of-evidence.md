# A.5.28 – Collection of Evidence

## Control Objective

Define how information security evidence is identified, collected, preserved, protected, and used for investigations, audits, and legal or regulatory requirements.

## Why It Matters

Evidence that is incomplete, altered, inaccessible, or collected without process may not support an investigation or audit conclusion. Auditors expect evidence handling to protect integrity, confidentiality, chain of custody, and retention requirements.

## Technical Implementation

### Microsoft 365

1. Use Microsoft Purview audit, eDiscovery, Defender XDR, and mailbox/file audit records as approved evidence sources.
2. Restrict access to investigation exports and audit evidence folders.
3. Record export time, operator, search criteria, case reference, and storage location.
4. Redact personal data or third-party data before external sharing.

### Azure

1. Use Log Analytics, Sentinel, Activity Logs, and Defender for Cloud exports for cloud evidence.
2. Store exported evidence in access-controlled storage with retention and immutability where appropriate.
3. Record hashes for sensitive exports used in investigations.

### On-Premises

1. Preserve endpoint, server, firewall, VPN, and physical access logs using documented procedures.
2. Use approved forensic collection tooling where an investigation may become disciplinary or legal.
3. Maintain chain-of-custody records for physical devices and digital exports.

## Verification Commands

```powershell
# Read-only: sample audit log availability.
Connect-MgGraph -Scopes "AuditLog.Read.All"
Get-MgAuditLogDirectoryAudit -Top 5 | Select-Object ActivityDateTime, ActivityDisplayName, Id
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Evidence handling SOP | PDF | Defines collection, preservation, access control, and retention steps. |
| Chain-of-custody template | PDF/XLSX | Shows how evidence movement and access are recorded. |
| Controlled evidence store access review | CSV/PDF | Shows evidence repositories are restricted and reviewed. |
| Sample evidence collection record | PDF | Shows operator, date, source, scope, hash, and ticket reference. |

## Audit Questions

1. Who is authorised to collect security evidence?
2. How do you preserve integrity and chain of custody?
3. Where is investigation evidence stored and who can access it?
4. How are privacy and redaction requirements handled?
5. How long is evidence retained?
6. How do you prove evidence has not been altered?

## Common Gaps and False Compliance Patterns

- **Screenshots without context**: Evidence lacks date, scope, owner, or source system.
- **Open evidence folders**: Sensitive exports are stored where many users can access them.
- **No chain of custody**: Investigation evidence is passed between teams without tracking.
- **No redaction process**: Personal or client data is shared unnecessarily.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | RS.AN-03 |
| Cyber Essentials | Security update management |
| ISO 27001:2022 | Annex A 5.28 |

## Suggested Evidence File Naming

```text
2026-05-01_A.5.28_Process_EvidenceHandlingSOP_SecOps_v1.pdf
2026-05-01_A.5.28_Process_ChainOfCustodyTemplate_SecOps_v1.xlsx
```