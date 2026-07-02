# Synthetic Evidence Examples

These files show what the repository evidence exporters produce, so you can see the expected shape of the output without connecting to a tenant. Every value is synthetic: the tenant, users, IP addresses, and identifiers are invented and follow the placeholder conventions in `CONTRIBUTING.md`. Do not treat these files as real evidence and do not commit real exports to this repository.

| File | Produced by | Control | What it shows |
| --- | --- | --- | --- |
| `A.8.5_MFARegistrationDetails.sample.csv` | `Export-M365Iso27001Evidence.ps1` | A.8.5 | Per-user MFA registration and capability posture |
| `A.8.15_RecentSignIns.sample.csv` | `Export-M365Iso27001Evidence.ps1` | A.8.15 / A.8.16 | Recent sign-in event sample for logging and monitoring evidence |
| `M365_Evidence_Index.sample.csv` | `Export-M365Iso27001Evidence.ps1` | All exported | The index file that labels each export with its ISO 27001 control ID |

When you collect real evidence: store it in a protected evidence folder outside this repository, apply the evidence naming convention from the README, and redact tenant and user identifiers before sharing outside the organisation.
