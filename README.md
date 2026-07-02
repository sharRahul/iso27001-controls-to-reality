# ISO 27001 Controls to Reality

Practical implementation guidance for translating ISO/IEC 27001:2022 Annex A controls into technical actions, evidence, and audit-ready operating routines across Microsoft 365, Azure, Windows, and typical corporate environments.

## Why this exists

Many ISO 27001 resources explain what the control expects, but not how a security team can prove the control is working. This repository bridges that gap by mapping governance requirements to technical implementation patterns, administrator tasks, evidence examples, audit preparation artefacts, cross-framework mappings, and lightweight evidence automation.

Use this repository when you need to:

- Convert high-level Annex A control language into real implementation actions.
- Build a reusable evidence pack for audits, assurance reviews, or certification readiness.
- Align security operations, Microsoft 365 hardening, Azure monitoring, endpoint controls, and policy governance to ISO 27001 outcomes.
- Create a repeatable control-owner workflow for evidence collection and remediation tracking.
- Cross-map ISO 27001 controls to NIST CSF 2.0 and Cyber Essentials themes.

## Who this is for

- Information security and GRC teams
- Security consultants
- Internal auditors
- IT administrators responsible for ISO 27001 control implementation
- Small and medium organisations building an ISMS for the first time

## Suggested GitHub Topics

To improve discoverability, apply the following topics to this repository via the GitHub repository settings:

`iso27001` `iso-27001-2022` `grc` `information-security` `microsoft-365` `azure-security` `annex-a` `isms` `audit-readiness` `compliance`

## Repository structure

```text
.
├── README.md
├── CONTRIBUTING.md
├── CHANGELOG.md
├── LICENSE
├── requirements.txt
├── .gitignore
├── .github/
│   ├── pull_request_template.md
│   ├── ISSUE_TEMPLATE/
│   └── workflows/
│       └── validate-and-dashboard.yml
├── docs/
│   ├── IMPLEMENTATION_STATUS.md
│   ├── auditor-workflow.md
│   ├── control-mapping-matrix.csv
│   ├── evidence-collection-guide.md
│   ├── manual-evidence-playbook.md
│   ├── script-readiness-matrix.md
│   ├── script-usage-examples.md
│   ├── statement-of-applicability-template.md
│   ├── audit-readiness-checklist.md
│   ├── risk-register-template.md
│   ├── framework-crosswalk.md
│   ├── permissions-matrix.md
│   ├── controls/
│   ├── crosswalks/
│   ├── dashboard/
│   ├── examples/
│   ├── isms-policy-templates/
│   ├── policies/
│   └── templates/
├── scripts/
│   ├── Get-ISO27001Evidence.ps1
│   ├── validate_repository.py
│   └── m365/
│       └── Export-M365Iso27001Evidence.ps1
└── tests/
    ├── test_validate_repository.py
    └── fixtures/
```

## Quick start

1. Start with [`docs/IMPLEMENTATION_STATUS.md`](docs/IMPLEMENTATION_STATUS.md) to understand which controls, guides, and evidence automations are complete, partial, or manual.
2. Review [`docs/control-mapping-matrix.csv`](docs/control-mapping-matrix.csv). Filter by control owner, technology area, implementation status, related framework mapping, or evidence example to prioritise your workload.
3. Use [`docs/evidence-collection-guide.md`](docs/evidence-collection-guide.md) to collect screenshots, exports, logs, policy documents, and ticket references.
4. Use [`docs/manual-evidence-playbook.md`](docs/manual-evidence-playbook.md) for controls whose evidence lives outside Microsoft Graph or requires HR, ITSM, supplier, facilities, vulnerability, or change-management evidence.
5. Use [`docs/auditor-workflow.md`](docs/auditor-workflow.md) to plan audit scope, evidence requests, quality review, auditor packs, and post-audit remediation.
6. Refer to the per-control guides in [`docs/controls/`](docs/controls/) for detailed implementation notes, evidence checklists, and audit questions for individual Annex A controls.
7. Copy [`docs/statement-of-applicability-template.md`](docs/statement-of-applicability-template.md) into your ISMS evidence folder and complete the applicability and justification fields.
8. Use [`docs/risk-register-template.md`](docs/risk-register-template.md) or [`docs/templates/risk-register-template.csv`](docs/templates/risk-register-template.csv) to document, score, and track information security risks.
9. Adapt the policy templates in [`docs/isms-policy-templates/`](docs/isms-policy-templates/) to your organisation's context.
10. Run through [`docs/audit-readiness-checklist.md`](docs/audit-readiness-checklist.md) before audit activity.
11. Use [`docs/framework-crosswalk.md`](docs/framework-crosswalk.md) or [`docs/crosswalks/iso27001-nist-csf2-cyber-essentials.csv`](docs/crosswalks/iso27001-nist-csf2-cyber-essentials.csv) if you are aligning ISO 27001 with NIST CSF 2.0 or Cyber Essentials.

## Automation

### Validate the matrix and generate a dashboard

Run the local validator from the repository root:

```bash
python scripts/validate_repository.py --dashboard-dir build/control-dashboard
```

This checks:

- Exact header schema, including column order, for the committed control matrix.
- Required CSV columns for the crosswalk schema.
- ISO 27001 Annex A control ID format.
- Duplicate control IDs.
- Supported implementation status values.
- Crosswalk rows that reference controls not present in the main matrix.

It also generates:

- `build/control-dashboard/control-status-dashboard.md`
- `build/control-dashboard/control-status-dashboard.html`

A committed sample of the dashboard output lives in [`docs/dashboard/`](docs/dashboard/) so you can see the result without running anything. No third-party Python packages are needed; see [`requirements.txt`](requirements.txt). CI pins Python 3.12.

The GitHub Actions workflow [`validate-and-dashboard.yml`](.github/workflows/validate-and-dashboard.yml) is the single CI validation path. It runs the validator test suite (`python -m unittest discover -s tests`) and `scripts/validate_repository.py` on push, pull request, and manual dispatch, publishes the generated dashboard to the job summary, and uploads it as a workflow artifact.

Before running scripts, check [`docs/script-readiness-matrix.md`](docs/script-readiness-matrix.md), [`docs/script-usage-examples.md`](docs/script-usage-examples.md), and [`docs/permissions-matrix.md`](docs/permissions-matrix.md). Synthetic example outputs live in [`docs/examples/`](docs/examples/).

### Export Microsoft 365 evidence

Use the read-only Microsoft Graph PowerShell exporter to collect mapped evidence for MFA registration, Conditional Access policies, privileged role assignments, sign-in logs, and directory audit events:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
./scripts/m365/Export-M365Iso27001Evidence.ps1 -TenantId "<tenant-id-or-domain>" -OutputRoot ./evidence
```

The script writes CSV/JSON outputs and an `M365_Evidence_Index.csv` file that labels each export with the relevant ISO 27001 control ID. Store exports securely and redact tenant or user details before sharing.

## Suggested evidence naming convention

```text
YYYY-MM-DD_CONTROL-ID_SYSTEM_EVIDENCE-TYPE_OWNER_VERSION.ext
```

Example:

```text
2026-05-13_A.8.15_M365-AuditLogs_ConfigExport_ITSecurity_v1.pdf
```

Documentation examples use dotted ISO control IDs such as `A.8.15`. Some scripts generate filesystem-friendly names using hyphenated IDs such as `A-8-15`; keep an evidence index that maps either form back to the exact ISO control ID.

## Implementation status model

| Status | Meaning |
| --- | --- |
| Not Started | No implementation evidence exists yet. |
| Designed | Control approach is documented but not fully implemented. |
| Implemented | Technical control or process is live. |
| Evidenced | Evidence has been collected and mapped to the control. |
| Reviewed | Control owner or auditor has reviewed the evidence. |
| Exception | Risk acceptance, compensating control, or remediation plan is required. |

## Audit-readiness principles

- Every control must have an owner.
- Every applicable control must have evidence.
- Every non-applicable control must have a business justification.
- Every exception must have a risk owner, expiry date, and remediation path.
- Evidence must be recent enough to support the audit period being reviewed.

## Contributing

Contributions are welcome. Please read [`CONTRIBUTING.md`](CONTRIBUTING.md) before adding new control mappings, evidence examples, scripts, or templates.

## License

This repository is licensed under the MIT License. See [`LICENSE`](LICENSE) for details.

## Disclaimer

This repository is a practical implementation aid and does not replace formal legal, certification, or accredited audit advice. Validate all controls, evidence requirements, and risk decisions against your organisation's ISMS scope, regulatory obligations, contractual requirements, and auditor expectations.