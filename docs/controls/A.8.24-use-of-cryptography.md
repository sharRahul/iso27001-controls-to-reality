# A.8.24 – Use of Cryptography

## Control Objective

Define, implement, and review cryptographic controls to protect confidentiality, integrity, authenticity, and non-repudiation of information.

## Why It Matters

Weak cryptography, unmanaged keys, expired certificates, and insecure protocols can undermine otherwise strong controls. Auditors expect evidence that cryptographic standards are defined, keys and certificates are managed, and exceptions are approved.

## Technical Implementation

### Microsoft 365

1. Document Microsoft-managed encryption at rest and in transit for Microsoft 365 services.
2. Review sensitivity labels, encryption options, and customer key/BYOK decisions where applicable.
3. Ensure email encryption and secure sharing options align to data classification requirements.

### Azure

1. Use Azure Key Vault for keys, secrets, and certificates where applicable.
2. Restrict Key Vault access through RBAC or access policies, private endpoints, and logging.
3. Enforce TLS 1.2 or higher for App Services, APIs, storage, and public endpoints.
4. Rotate secrets and certificates before expiry and monitor failed rotation.
5. Review key usage, purge protection, soft delete, and backup requirements.

### On-Premises

1. Maintain a certificate inventory with owner, purpose, expiry, algorithm, and renewal date.
2. Disable obsolete protocols and cipher suites where technically possible.
3. Store recovery keys and encryption keys in approved protected locations.

## Verification Commands

```powershell
# Read-only: Azure Key Vault and App Service examples.
Connect-AzAccount
Get-AzKeyVault | Select-Object VaultName, ResourceGroupName, EnablePurgeProtection, EnableSoftDelete
Get-AzWebApp | Select-Object Name, ResourceGroup, HttpsOnly
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Cryptographic standard | PDF | Defines approved algorithms, key lengths, protocols, and review cadence. |
| Key Vault configuration export | JSON/CSV | Shows access, logging, soft delete, and purge protection. |
| Certificate inventory | CSV/XLSX | Shows ownership, expiry, algorithm, and renewal status. |
| TLS configuration evidence | CSV/Screenshot | Shows minimum TLS and HTTPS enforcement. |

## Audit Questions

1. Which cryptographic algorithms and protocols are approved?
2. How are keys, secrets, and certificates inventoried?
3. How is key access restricted and reviewed?
4. How are certificates renewed before expiry?
5. How are encryption exceptions approved?
6. How do you confirm obsolete protocols are disabled?

## Common Gaps and False Compliance Patterns

- **Encryption assumed by provider**: Cloud default encryption is cited without tenant-side key, certificate, or protocol review.
- **Unknown certificate owner**: Certificates expire because no owner is accountable.
- **Secrets in code**: Application secrets are stored in repositories or scripts instead of a managed vault.
- **Weak legacy protocol allowed**: TLS or cipher settings are not reviewed across public endpoints.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | PR.DS-01 |
| Cyber Essentials | Secure Configuration |
| ISO 27001:2022 | Annex A 8.24 |

## Suggested Evidence File Naming

```text
2026-05-01_A.8.24_Azure_KeyVault-AuditLog_CloudSec_v1.json
2026-05-01_A.8.24_Process_CertificateInventory_CloudSec_v1.xlsx
```