# Implementation Status

This document separates working repository capability from planned or partially covered areas. It is intended to prevent documentation drift and help contributors understand where to add value.

## Current working capabilities

| Area | Status | Notes |
| --- | --- | --- |
| Control mapping matrix | Working | `docs/control-mapping-matrix.csv` is the source of truth for mapped controls, owners, evidence examples, and implementation status. |
| Framework crosswalk | Working | `docs/crosswalks/iso27001-nist-csf2-cyber-essentials.csv` maps selected ISO 27001 controls to NIST CSF 2.0 and Cyber Essentials themes. |
| Matrix and crosswalk validation | Working | `scripts/validate_repository.py` validates the committed CSV schema, status values, duplicate IDs, date format, and crosswalk references. |
| Dashboard generation | Working | The validator can generate Markdown and HTML dashboard files under a supplied output directory. |
| Validator tests | Working | `tests/test_validate_repository.py` runs fixture-based tests (valid and deliberately broken CSVs) in CI via `python -m unittest`. |
| Microsoft 365 evidence export | Partial | `scripts/m365/Export-M365Iso27001Evidence.ps1` exports selected read-only evidence for MFA registration, Conditional Access, privileged roles, sign-ins, and audit events. |
| Modular evidence helper | Partial | `scripts/Get-ISO27001Evidence.ps1` covers a limited set of controls and should be treated as a starter evidence helper. |
| Per-control guides | Partial | Detailed Markdown guides exist for 12 of 31 mapped controls, authored against `docs/controls/_TEMPLATE.md`. |
| Permissions matrix | Working | `docs/permissions-matrix.md` maps each script and function to its minimum Graph scopes and Entra roles. |
| Synthetic evidence examples | Working | `docs/examples/` contains synthetic exporter outputs so users can see expected results without running anything. |
| Policy and register templates | Working | Templates are present for SoA, risk register, policies, evidence collection, and audit readiness. |

## Control guide coverage

| Control ID | Matrix status | Per-control guide | Automation coverage |
| --- | --- | --- | --- |
| A.5.1 | Reviewed | Missing | Manual evidence |
| A.5.2 | Reviewed | Missing | Manual evidence |
| A.5.9 | Implemented | Present | Manual evidence |
| A.5.15 | Evidenced | Present | Partial M365 evidence export |
| A.5.16 | Implemented | Present | Partial M365 evidence export |
| A.5.17 | Implemented | Present | Manual evidence |
| A.5.18 | Designed | Missing | Partial script export (access review definitions via `Get-ISO27001Evidence.ps1`) |
| A.5.23 | Designed | Missing | Manual evidence |
| A.5.24 | Implemented | Present | Manual evidence |
| A.5.25 | Designed | Missing | Manual evidence |
| A.5.28 | Designed | Missing | Manual evidence |
| A.6.1 | Reviewed | Missing | Manual evidence |
| A.6.2 | Reviewed | Missing | Manual evidence |
| A.6.3 | Evidenced | Present | Manual evidence |
| A.6.5 | Implemented | Missing | Manual evidence |
| A.6.6 | Designed | Missing | Manual evidence |
| A.7.4 | Designed | Missing | Manual evidence |
| A.8.1 | Implemented | Present | Partial script export (Intune device compliance via `Get-ISO27001Evidence.ps1`) |
| A.8.2 | Implemented | Present | Partial M365 evidence export |
| A.8.5 | Evidenced | Present | Partial M365 evidence export |
| A.8.7 | Evidenced | Present | Partial M365 evidence export |
| A.8.8 | Designed | Missing | Manual evidence (no safe read-only Graph source, see note below) |
| A.8.9 | Implemented | Present | Manual evidence |
| A.8.12 | Implemented | Missing | Partial script export (Purview DLP policies via `Get-ISO27001Evidence.ps1`) |
| A.8.15 | Evidenced | Present | Partial M365 evidence export |
| A.8.16 | Implemented | Missing | Partial M365 evidence export plus risk detection export (`Get-ISO27001Evidence.ps1`) |
| A.8.20 | Implemented | Missing | Manual evidence |
| A.8.23 | Designed | Missing | Manual evidence (no safe read-only Graph source, see note below) |
| A.8.24 | Implemented | Missing | Manual evidence (no safe read-only Graph source, see note below) |
| A.8.28 | Designed | Missing | Manual evidence |
| A.8.32 | Reviewed | Missing | Manual evidence (evidence lives in the ITSM tool, see note below) |

## Controls that remain manual-only

The following controls stay manual because no safe read-only Microsoft Graph source exists for their evidence. They are listed here deliberately rather than claiming automation coverage that does not exist.

| Control ID | Why it stays manual |
| --- | --- |
| A.8.8 | Defender vulnerability management data is exposed through the Defender for Endpoint API, not Microsoft Graph v1.0. Export the vulnerability dashboard and remediation tickets manually. |
| A.8.23 | Defender web content filtering configuration is managed in the Defender portal and is not exposed through Microsoft Graph v1.0. Export the policy configuration and a blocked-event sample manually. |
| A.8.24 | Key Vault configuration, TLS settings, and key rotation evidence live behind Azure Resource Manager, not Microsoft Graph. Export Key Vault audit logs and TLS configuration manually or with Az PowerShell. |
| A.8.32 | Change records, CAB approvals, and post-implementation reviews live in the ITSM tool (for example ServiceNow). Export the change log and CAB minutes from that system. |

## Priority backlog

1. Add per-control guides for the remaining 19 mapped controls without one, prioritising those marked Implemented or Evidenced. Use `docs/controls/_TEMPLATE.md`.

## Completed backlog items

- Fixture-based validator tests run in CI (`tests/`), so schema drift is caught before merge.
- Read-only evidence automation expanded to A.5.18, A.8.1, A.8.12, and A.8.16 via `Get-ISO27001Evidence.ps1`. A.8.8, A.8.23, A.8.24, and A.8.32 remain manual by design (see the manual-only table above).
- Per-control guide template added (`docs/controls/_TEMPLATE.md`) and guides authored for A.5.9, A.5.17, A.5.24, A.8.1, and A.8.9.
- Synthetic evidence examples added under `docs/examples/`.
- Permissions matrix added at `docs/permissions-matrix.md`.

## Contributor rule

When adding a control to the crosswalk, also add it to `docs/control-mapping-matrix.csv`. The CI validator treats the matrix as the authoritative control register and fails crosswalk references that do not exist in the matrix.
