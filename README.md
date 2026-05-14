# ISO 27001 Controls to Reality

Practical implementation guidance for translating ISO/IEC 27001:2022 Annex A controls into technical actions, evidence, and audit-ready operating routines across Microsoft 365, Azure, Windows, and typical corporate environments.

## Why this exists

Many ISO 27001 resources explain what the control expects, but not how a security team can prove the control is working. This repository bridges that gap by mapping governance requirements to technical implementation patterns, administrator tasks, evidence examples, and audit preparation artefacts.

Use this repository when you need to:

- Convert high-level Annex A control language into real implementation actions.
- Build a reusable evidence pack for internal audit, external audit, client assurance, or certification readiness.
- Align security operations, Microsoft 365 hardening, Azure monitoring, endpoint controls, and policy governance to ISO 27001 outcomes.
- Create a repeatable control-owner workflow for evidence collection and remediation tracking.

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
├── docs/
│   ├── control-mapping-matrix.csv
│   ├── evidence-collection-guide.md
│   ├── statement-of-applicability-template.md
│   ├── audit-readiness-checklist.md
│   ├── risk-register-template.md
│   ├── framework-crosswalk.md
│   ├── controls/
│   │   ├── A.5.15-access-control.md
│   │   ├── A.5.16-identity-management.md
│   │   ├── A.8.5-secure-authentication.md
│   │   ├── A.8.7-protection-against-malware.md
│   │   └── A.8.15-logging-and-monitoring.md
│   └── isms-policy-templates/
│       ├── acceptable-use-policy.md
│       ├── access-control-policy.md
│       └── incident-response-policy.md
└── scripts/
    └── Get-ISO27001Evidence.ps1
```

## Quick start

1. Start with [`docs/control-mapping-matrix.csv`](docs/control-mapping-matrix.csv). Filter by control owner, technology area, or implementation status to prioritise your workload.
2. Use [`docs/evidence-collection-guide.md`](docs/evidence-collection-guide.md) to collect screenshots, exports, logs, policy documents, and ticket references.
3. Copy [`docs/statement-of-applicability-template.md`](docs/statement-of-applicability-template.md) into your ISMS evidence folder and complete the applicability and justification fields.
4. Run through [`docs/audit-readiness-checklist.md`](docs/audit-readiness-checklist.md) before internal audit, stage 1, stage 2, or surveillance audit activity.
5. Use [`docs/risk-register-template.md`](docs/risk-register-template.md) to document, score, and track information security risks. The template includes five pre-populated example risks for M365 and cloud-hybrid environments.
6. Refer to the per-control guides in [`docs/controls/`](docs/controls/) for detailed implementation notes, evidence checklists, and audit questions for individual Annex A controls.
7. Adapt the policy templates in [`docs/isms-policy-templates/`](docs/isms-policy-templates/) — covering acceptable use, access control, and incident response — to your organisation's context. Each template references the relevant Annex A controls and is ready for document control.
8. Run [`scripts/Get-ISO27001Evidence.ps1`](scripts/Get-ISO27001Evidence.ps1) in your Microsoft 365 or Azure environment to automate collection of common technical evidence artefacts.
9. Use [`docs/framework-crosswalk.md`](docs/framework-crosswalk.md) if you are aligning ISO 27001 with NIST CSF 2.0 or Cyber Essentials to identify shared evidence opportunities and avoid duplicated effort.

## Suggested evidence naming convention

```text
YYYY-MM-DD_CONTROL-ID_SYSTEM_EVIDENCE-TYPE_OWNER_VERSION.ext
```

Example:

```text
2026-05-13_A.8.15_M365-AuditLogs_ConfigExport_ITSecurity_v1.pdf
```

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
