# Contributing

Thank you for helping improve **ISO 27001 Controls to Reality**. This repository is intended to be practical, evidence-led, and useful for real audit preparation.

## Contribution principles

All contributions should be:

- Practical: explain how a control can be implemented, evidenced, or reviewed.
- Traceable: include the control ID, source system, owner role, and evidence type where relevant.
- Vendor-aware but not vendor-locked: Microsoft 365, Azure, Windows, and common enterprise tooling are welcome, but guidance should still explain the control objective.
- Audit-friendly: write in a way that a control owner, internal auditor, or external auditor can follow.
- Safe: do not include client names, tenant IDs, secrets, private screenshots, internal IP addresses, or live production evidence.

## How to contribute a control mapping

When adding or updating a control mapping, include:

1. ISO 27001:2022 Annex A control ID.
2. Control title.
3. Implementation objective.
4. Example technical action.
5. Evidence artefact.
6. Evidence owner.
7. Review frequency.
8. Related framework mapping, where known.
9. Notes on limitations or assumptions.

Use `docs/control-mapping-matrix.csv` as the source format.

## How to contribute evidence guidance

Evidence guidance should answer:

- What proves the control is implemented?
- Where does the evidence come from?
- Who owns the evidence?
- How often should it be refreshed?
- What would an auditor reasonably ask next?
- What common gaps or false comfort should be avoided?

## Pull request checklist

Before opening a pull request, confirm that:

- [ ] No sensitive data is included.
- [ ] New control mappings use ISO 27001:2022 control IDs.
- [ ] Evidence examples are generic, anonymised, or synthetic.
- [ ] Any scripts are safe to run in read-only mode by default.
- [ ] Markdown tables render correctly.
- [ ] The changelog is updated when guidance, mappings, or templates change.

## Style guide

- Use UK English where possible.
- Prefer short implementation steps over vague policy language.
- Use `Control ID -> Implementation -> Evidence -> Owner -> Frequency` as the default flow.
- Avoid claiming that a configuration guarantees compliance. Use terms like "supports", "helps evidence", or "contributes to".

## Security and privacy

Do not submit real audit packs, client screenshots, production exports, credentials, tenant identifiers, or personally identifiable information. Replace sensitive values with placeholders such as `<tenant-id>`, `<control-owner>`, or `<system-name>`.
