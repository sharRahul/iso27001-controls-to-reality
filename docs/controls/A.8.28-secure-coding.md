# A.8.28 – Secure Coding

## Control Objective

Apply secure coding principles and development controls to reduce vulnerabilities introduced during software design, development, review, and deployment.

## Why It Matters

Software defects can expose data, enable privilege escalation, or create unauthorised access paths. Auditors expect evidence that secure development requirements are defined, code is reviewed, security testing is performed, and findings are tracked to closure.

## Technical Implementation

### Microsoft 365

1. Store development standards, secure coding guidelines, and review records in controlled collaboration spaces.
2. Protect repositories, design documents, and build artefacts with appropriate access controls.
3. Use Defender for Cloud Apps or audit logs where relevant for repository and collaboration monitoring.

### Azure

1. Use GitHub Advanced Security, Defender for DevOps, or equivalent tools for secret scanning, dependency scanning, and SAST.
2. Require pull request review before merge to protected branches.
3. Run security checks in CI/CD pipelines and block release for critical findings where policy requires.
4. Track vulnerabilities and remediation SLA in backlog or ITSM tooling.

### On-Premises

1. Apply equivalent secure development controls to internal repositories and build systems.
2. Restrict production deployment rights and separate developer, reviewer, and release roles.

## Verification Commands

```powershell
# No single tenant command proves secure coding.
# Use repository settings, branch protection, CI logs, SAST exports, dependency scan results, and remediation tickets.
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| Secure coding standard | PDF | Defines required coding and review practices. |
| Branch protection settings | Screenshot/JSON | Shows review and merge controls. |
| SAST/dependency scan report | CSV/PDF | Shows security checks and finding status. |
| Remediation tickets | CSV/PDF | Shows critical findings are tracked to closure. |

## Audit Questions

1. Which projects are in scope for secure coding requirements?
2. How are developers trained on secure coding?
3. What security checks run before merge or release?
4. How are secrets prevented from entering repositories?
5. How are critical vulnerabilities blocked or remediated?
6. How are third-party dependencies reviewed?

## Common Gaps and False Compliance Patterns

- **Scanning but no triage**: Findings exist but are not reviewed or assigned.
- **Critical findings allowed to release**: CI produces warnings but does not enforce policy.
- **No secret scanning**: Credentials can be committed without detection.
- **Branch protection bypassed**: Administrators can merge without review and no exception is recorded.

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | PR.PS-04 |
| Cyber Essentials | N/A |
| ISO 27001:2022 | Annex A 8.28 |

## Suggested Evidence File Naming

```text
2026-05-01_A.8.28_GitHub_SASTReport_DevLead_v1.csv
2026-05-01_A.8.28_GitHub_BranchProtection_DevLead_v1.json
```