# Implementation Status

This document separates working repository capability from planned or partially covered areas. It is intended to prevent documentation drift and help contributors understand where to add value.

## Current working capabilities

| Area | Status | Notes |
| --- | --- | --- |
| Control mapping matrix | Working | `docs/control-mapping-matrix.csv` is the source of truth for mapped controls, owners, evidence examples, and implementation status. |
| Framework crosswalk | Working | `docs/crosswalks/iso27001-nist-csf2-cyber-essentials.csv` maps selected ISO 27001 controls to NIST CSF 2.0 and Cyber Essentials themes. |
| Matrix and crosswalk validation | Working | `scripts/validate_repository.py` validates the committed CSV schema, status values, duplicate IDs, date format, and crosswalk references. |
| Dashboard generation | Working | The validator can generate Markdown and HTML dashboard files under a supplied output directory. |
| Validator tests | Working | `tests/test_validate_repository.py` runs fixture-based tests in CI via `python -m unittest`. |
| Microsoft 365 evidence export | Partial | `scripts/m365/Export-M365Iso27001Evidence.ps1` exports selected read-only evidence for MFA registration, Conditional Access, privileged roles, sign-ins, and audit events. |
| Modular evidence helper | Partial | `scripts/Get-ISO27001Evidence.ps1` covers a limited set of controls and should be treated as a starter evidence helper. |
| Per-control guides | Working | Detailed Markdown guides exist for all 31 mapped controls, authored against the `docs/controls/_TEMPLATE.md` structure. |
| Permissions matrix | Working | `docs/permissions-matrix.md` maps each script and function to its minimum Graph scopes and Entra roles. |
| Synthetic evidence examples | Working | `docs/examples/` contains synthetic exporter outputs so users can see expected results without running anything. |
| Policy and register templates | Working | Templates are present for SoA, risk register, policies, evidence collection, and audit readiness. |
| Manual evidence guidance | Working | `docs/manual-evidence-playbook.md` explains how to evidence controls that cannot be proven safely through Microsoft Graph. |
| Script usage examples | Working | `docs/script-usage-examples.md` provides ready-to-run examples and troubleshooting notes. |
| Auditor workflow | Working | `docs/auditor-workflow.md` covers audit scope, evidence requests, quality review, auditor packs, gap logs, remediation, and post-audit closeout. |

## Control guide coverage

| Control ID | Matrix status | Per-control guide | Automation coverage |
| --- | --- | --- | --- |
| A.5.1 | Reviewed | Present | Manual evidence |
| A.5.2 | Reviewed | Present | Manual evidence |
| A.5.9 | Implemented | Present | Manual evidence |
| A.5.15 | Evidenced | Present | Partial M365 evidence export |
| A.5.16 | Implemented | Present | Partial M365 evidence export |
| A.5.17 | Implemented | Present | Manual evidence |
| A.5.18 | Designed | Present | Partial script export via `Get-ISO27001Evidence.ps1` |
| A.5.23 | Designed | Present | Manual evidence |
| A.5.24 | Implemented | Present | Manual evidence |
| A.5.25 | Designed | Present | Manual evidence |
| A.5.28 | Designed | Present | Manual evidence |
| A.6.1 | Reviewed | Present | Manual evidence |
| A.6.2 | Reviewed | Present | Manual evidence |
| A.6.3 | Evidenced | Present | Manual evidence |
| A.6.5 | Implemented | Present | Manual evidence |
| A.6.6 | Designed | Present | Manual evidence |
| A.7.4 | Designed | Present | Manual evidence |
| A.8.1 | Implemented | Present | Partial script export via `Get-ISO27001Evidence.ps1` |
| A.8.2 | Implemented | Present | Partial M365 evidence export |
| A.8.5 | Evidenced | Present | Partial M365 evidence export |
| A.8.7 | Evidenced | Present | Partial M365 evidence export |
| A.8.8 | Designed | Present | Manual evidence |
| A.8.9 | Implemented | Present | Manual evidence |
| A.8.12 | Implemented | Present | Partial script export via `Get-ISO27001Evidence.ps1` |
| A.8.15 | Evidenced | Present | Partial M365 evidence export |
| A.8.16 | Implemented | Present | Partial M365 evidence export plus risk detection export via `Get-ISO27001Evidence.ps1` |
| A.8.20 | Implemented | Present | Manual evidence |
| A.8.23 | Designed | Present | Manual evidence |
| A.8.24 | Implemented | Present | Manual evidence |
| A.8.28 | Designed | Present | Manual evidence |
| A.8.32 | Reviewed | Present | Manual evidence |

## Controls that remain manual-only

The following controls stay manual because no safe read-only Microsoft Graph source exists for their evidence. They are listed here deliberately rather than claiming automation coverage that does not exist.

| Control ID | Why it stays manual |
| --- | --- |
| A.5.1 | Policy approval, publication, acknowledgement, and exception evidence live in governance, HR, or document-management systems. |
| A.5.2 | Responsibility assignment and RACI evidence live in organisational records and role descriptions. |
| A.5.23 | Cloud service approval, supplier assurance, and shared responsibility evidence are governance artefacts. |
| A.5.25 | Event assessment quality requires ticket and analyst decision evidence, not just alert data. |
| A.5.28 | Evidence handling, chain of custody, and controlled evidence store access are process artefacts. |
| A.6.1 | Screening records live in HR systems and must be privacy-minimised. |
| A.6.2 | Employment and contractor terms live in HR/legal systems. |
| A.6.5 | Leaver, mover, asset return, and access removal evidence spans HR, IAM, ITSM, and facilities. |
| A.6.6 | NDA evidence lives in HR, legal, or supplier-management systems. |
| A.7.4 | Physical access, visitor, and CCTV evidence lives in facilities systems. |
| A.8.8 | Defender vulnerability management data is exposed through the Defender for Endpoint API or vulnerability tooling, not Microsoft Graph v1.0. |
| A.8.20 | Network diagrams, firewall rulesets, and segmentation reviews live in network and Azure Resource Manager evidence sources. |
| A.8.23 | Defender web content filtering, proxy, DNS, firewall, or secure web gateway evidence is not consistently exposed through Microsoft Graph v1.0. |
| A.8.24 | Key Vault, TLS, certificate, and cryptographic standard evidence lives behind Azure Resource Manager, application platforms, and process records. |
| A.8.32 | Change records, CAB approvals, and post-implementation reviews live in the ITSM tool. |

See [`manual-evidence-playbook.md`](manual-evidence-playbook.md) for collection guidance.

## Priority backlog

1. Add validator checks for per-control guide coverage so future matrix additions cannot miss a guide.
2. Extend dashboard generation to include guide coverage and automation coverage summaries.
3. Add optional non-Graph evidence adapters only where they can remain read-only and safe, such as Azure Resource Manager exports for Key Vault and network configuration.
4. Add more synthetic example outputs for manual evidence indexes, access review results, vulnerability remediation, and change samples.

## Completed backlog items

- Fixture-based validator tests run in CI (`tests/`), so schema drift is caught before merge.
- Read-only evidence automation expanded to A.5.18, A.8.1, A.8.12, and A.8.16 via `Get-ISO27001Evidence.ps1`.
- Per-control guide template added (`docs/controls/_TEMPLATE.md`).
- Per-control guides authored for all 31 mapped controls.
- Synthetic evidence examples added under `docs/examples/`.
- Permissions matrix added at `docs/permissions-matrix.md`.
- Script usage examples added at `docs/script-usage-examples.md`.
- Manual evidence boundaries added at `docs/manual-evidence-playbook.md`.
- Auditor workflow added at `docs/auditor-workflow.md`.

## Contributor rule

When adding a control to the crosswalk, also add it to `docs/control-mapping-matrix.csv` and create or update the matching guide under `docs/controls/`. The CI validator treats the matrix as the authoritative control register and fails crosswalk references that do not exist in the matrix.