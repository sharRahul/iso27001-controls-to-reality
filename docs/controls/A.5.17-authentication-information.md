# A.5.17 – Authentication Information

## Control Objective

Ensure that authentication information (passwords, secrets, keys, and recovery data) is generated, allocated, stored, and managed so it cannot be easily guessed, intercepted, or reused by unauthorised parties.

## Why It Matters

Compromised credentials remain the most common initial access vector. Weak password policy, unmanaged service principal secrets, and insecure secret storage all convert a single phishing email or leaked file into tenant-wide compromise. Auditors look for lifecycle management of authentication information, not just a password policy document.

## Technical Implementation

### Microsoft 365

1. Deploy Entra ID Password Protection with the global banned password list and a custom banned list containing organisation-specific terms.
2. Enable self-service password reset (SSPR) with a minimum of two verification methods; review SSPR registration reports monthly.
3. Disable periodic forced password expiry for users covered by MFA, in line with NCSC guidance, and document the decision.
4. Set first-use credentials to require change at first sign-in, and deliver them out of band from the account name.
5. Track service principal and app registration secrets in a secrets register; alert on credentials approaching expiry and prefer certificates or managed identities over client secrets.

### Azure

1. Store application secrets, keys, and connection strings in Azure Key Vault, never in code, pipelines, or configuration files.
2. Use managed identities for Azure workloads so no credential exists to manage.
3. Enable Key Vault logging and restrict access with RBAC; review access quarterly.

### On-Premises

1. Deploy the Entra ID Password Protection agent to domain controllers so the banned password list applies to on-premises changes.
2. Use LAPS to randomise and escrow local administrator passwords.
3. Remove credentials stored in scripts, scheduled tasks, and Group Policy Preferences; replace with managed service accounts (gMSA) where possible.

## Verification Commands

```powershell
# Read-only: SSPR and authentication methods registration report
Connect-MgGraph -Scopes "Reports.Read.All"
Get-MgReportAuthenticationMethodUserRegistrationDetail -All |
    Select-Object UserPrincipalName, IsSsprRegistered, IsMfaRegistered |
    Export-Csv "SSPR-Registration.csv" -NoTypeInformation

# Read-only: app registrations with expiring or long-lived secrets
Connect-MgGraph -Scopes "Application.Read.All"
Get-MgApplication -All | ForEach-Object {
    foreach ($cred in $_.PasswordCredentials) {
        [pscustomobject]@{ App = $_.DisplayName; SecretEnd = $cred.EndDateTime }
    }
} | Export-Csv "AppSecretExpiry.csv" -NoTypeInformation
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Password Protection configuration | Screenshot/JSON | Banned password list mode (Enforced, not Audit) and custom list in place |
| SSPR registration report | CSV | Registration coverage for in-scope users |
| Secrets register extract | XLSX | Service principal and application secrets with owner and expiry |
| Key Vault access review | CSV/PDF | Quarterly review of who and what can read secrets |
| First-use credential procedure | PDF | Documented process for issuing initial credentials out of band |

## Audit Questions

1. What prevents users from choosing weak or previously breached passwords?
2. How are initial credentials issued to new joiners, and are they forced to change at first use?
3. Where are application and service account secrets stored, and who can read them?
4. How do you know when a service principal secret is about to expire, and who rotates it?
5. Does the banned password policy apply to on-premises password changes as well as cloud?
6. What is your position on password expiry, and is it documented and risk assessed?

## Common Gaps and False Compliance Patterns

- **Audit mode forever**: Entra ID Password Protection deployed in Audit mode and never switched to Enforced.
- **Cloud-only enforcement**: The banned password list applies in Entra ID but not to Active Directory changes because the DC agent was never deployed.
- **Secrets in pipelines**: A strong password policy for humans while client secrets sit in plain text in CI/CD variables and scripts.
- **Orphan secrets**: App registration secrets with multi-year expiry and no recorded owner.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | Protect: PR.AA-01 |
| Cyber Essentials | User Access Control |
| ISO 27001:2022 | Annex A 5.17 |

## Suggested Evidence File Naming

```
2026-05-01_A.5.17_EntraID_PasswordProtection_IAMOwner_v1.png
2026-05-01_A.5.17_EntraID_SSPR-Registration_IAMOwner_v1.csv
2026-05-01_A.5.17_Process_SecretsRegister_IAMOwner_v1.xlsx
```
