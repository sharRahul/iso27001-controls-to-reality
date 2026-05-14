# A.8.5 – Secure Authentication

## Control Objective

Enforce strong, phishing-resistant authentication mechanisms to protect access to systems and data from unauthorised use of credentials.

## Why It Matters

Compromised credentials are the single most common initial access vector in cyber attacks; multi-factor authentication alone blocks over 99% of automated credential-stuffing attacks. Demonstrating that all privileged and user-facing access requires strong authentication is a minimum expectation for any ISO 27001 audit and is directly assessed under Cyber Essentials.

## Technical Implementation

### Microsoft 365

1. Enable Security Defaults in Entra ID (suitable for organisations without Entra ID P1/P2 licences) or replace with Conditional Access policies for granular control.
2. Require MFA for all users via Conditional Access: create a policy targeting "All users" and "All cloud apps" with "Require multi-factor authentication" as the grant control.
3. Require MFA for all administrators: create a separate policy with no exclusions except break-glass accounts.
4. Disable legacy authentication protocols (Basic Auth) that bypass MFA: create a Conditional Access policy blocking "Exchange ActiveSync clients" and "Other clients".
5. Enable Microsoft Entra ID Password Protection to block common passwords and organisation-specific banned terms.
6. Enable Entra ID Identity Protection and configure risk-based Conditional Access: sign-in risk ≥ Medium → require MFA re-authentication; user risk ≥ High → require password change.
7. Enforce phishing-resistant MFA (FIDO2 security keys or Windows Hello for Business) for all Tier 0 and Tier 1 administrators.
8. Register and monitor break-glass (emergency access) accounts: store credentials in a physical safe, alert on any sign-in via Sentinel/Defender.

### Azure

1. Ensure all Azure Portal and ARM access requires MFA through Entra ID Conditional Access (applies automatically when Entra ID is the identity provider).
2. Enable PIM for Azure roles; configure MFA challenge on role activation even within a valid session.
3. Use Azure Managed Identities for workload authentication; avoid storing service principal secrets in code or configuration files.
4. Rotate service principal client secrets on a defined schedule (maximum 12 months); use certificates in preference to secrets.
5. Enable Entra ID Workload Identity Federation where supported to eliminate stored secrets for CI/CD pipelines.

### On-Premises

1. Enforce a password policy via Group Policy: minimum 14 characters, complexity enabled, maximum age 365 days (or use long passphrases with no maximum age per NCSC guidance).
2. Deploy Windows Hello for Business for domain-joined workstations as a phishing-resistant alternative to passwords.
3. Use Protected Users security group for all Tier 0 accounts to prevent credential caching and delegation.
4. Disable NTLM authentication where possible; enforce Kerberos; audit NTLM usage via Event ID 4776.
5. Deploy Microsoft Entra ID Connect Health and monitor for password hash synchronisation errors.

## Verification Commands

```powershell
# Export MFA registration report (requires Microsoft.Graph module)
Connect-MgGraph -Scopes "Reports.Read.All","UserAuthenticationMethod.Read.All"
Get-MgReportAuthenticationMethodUserRegistrationDetail |
    Select-Object UserPrincipalName, IsMfaRegistered, IsPasswordlessCapable, DefaultMfaMethod |
    Export-Csv "MFA-Registration.csv" -NoTypeInformation

# List Conditional Access policies blocking legacy auth
Get-MgIdentityConditionalAccessPolicy |
    Where-Object { $_.Conditions.ClientAppTypes -contains "exchangeActiveSync" -or
                   $_.Conditions.ClientAppTypes -contains "other" } |
    Select-Object DisplayName, State

# Check if Security Defaults are enabled
(Get-MgPolicyIdentitySecurityDefaultEnforcementPolicy).IsEnabled
```

## What Audit Evidence Looks Like

| Evidence Item | Format | Description |
|---|---|---|
| MFA registration report | CSV | Per-user MFA registration status showing % enrolled |
| Conditional Access policy export | CSV/JSON | Policies enforcing MFA and blocking legacy auth |
| Legacy auth sign-in report | CSV/Screenshot | Sign-in log filtered to legacy auth protocols (should be zero or blocked) |
| Break-glass account monitoring alert | Screenshot | Sentinel/Defender alert rule showing break-glass account sign-in alerting |
| Password protection settings | Screenshot | Entra ID → Security → Authentication Methods → Password Protection |

## Common Gaps and False Compliance Patterns

- **MFA required but not enforced**: Per-user MFA "enabled" state in the old MFA portal does not enforce MFA; it allows users to complete a grace period. Only Conditional Access or Security Defaults enforces MFA.
- **Exclusions that swallow the rule**: Conditional Access policies with broad exclusions (entire security groups, all service accounts) that make enforcement nominal.
- **Legacy auth blocked in report-only mode**: Policy was never switched from Report-only to On; legacy auth continues unchallenged.
- **Break-glass accounts unmonitored**: Emergency access accounts exist but no alert fires on use, so misuse goes undetected.
- **Service principals with non-expiring secrets**: Application registrations with client secrets set to "Never" expiry and no rotation process.

## Suggested Evidence File Naming

```
2026-05-01_A.8.5_EntraID_MFA-RegistrationReport_IAMOwner_v1.csv
2026-05-01_A.8.5_EntraID_CAPolicy-LegacyAuthBlock_IAMOwner_v1.json
2026-05-01_A.8.5_EntraID_PasswordProtection_IAMOwner_v1.png
```
