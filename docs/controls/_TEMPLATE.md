# A.X.Y – Control Title

Use this template for every per-control guide in `docs/controls/`. Keep the section order. Delete guidance text in brackets before committing. Use UK English, synthetic values only, and the repository evidence naming convention.

## Control Objective

[One or two sentences stating the intent of the control in plain language: what outcome the control exists to achieve, not how it is implemented.]

## Why It Matters

[Two to four sentences on the practical risk the control addresses and why an auditor cares. Explain the consequence of the control failing, not just the requirement.]

## Technical Implementation

### Microsoft 365

1. [Numbered, specific actions an administrator can take. Name the admin centre, blade, or policy involved.]

### Azure

1. [Numbered actions. Omit this subsection if not applicable and say why.]

### On-Premises

1. [Numbered actions. Omit this subsection if not applicable and say why.]

## Verification Commands

```powershell
# [Read-only commands an operator can run to verify the control state.
# Never include commands that change configuration.]
```

## Evidence Checklist

| Evidence Item | Format | Description |
|---|---|---|
| [What to collect] | [CSV / JSON / PDF / Screenshot] | [What it shows and why it supports the control] |

## Audit Questions

[Five to eight questions an internal or external auditor is likely to ask. Phrase them as the auditor would, so a control owner can rehearse answers.]

1. [Question]
2. [Question]

## Common Gaps and False Compliance Patterns

- **[Short gap name]**: [Why this state looks compliant but is not.]

## Framework Mappings

| Framework | Mapping |
|---|---|
| NIST CSF 2.0 | [Function and category, for example PR.AA-05] |
| Cyber Essentials | [Theme or N/A] |
| ISO 27001:2022 | [Annex A reference and any related clause] |

## Suggested Evidence File Naming

```
YYYY-MM-DD_A.X.Y_SYSTEM_EVIDENCE-TYPE_OWNER_v1.ext
```
