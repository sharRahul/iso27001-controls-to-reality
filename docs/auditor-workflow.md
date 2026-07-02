# Auditor Workflow

This workflow helps control owners, GRC teams, and internal auditors move from the control register to a defensible evidence pack. It is designed to be used with `docs/control-mapping-matrix.csv`, `docs/evidence-collection-guide.md`, `docs/manual-evidence-playbook.md`, and the per-control guides in `docs/controls/`.

## Workflow overview

```text
Scope -> Control register -> Evidence request -> Evidence collection -> Quality review -> Gap log -> Remediation -> Auditor pack -> Post-audit improvements
```

## 1. Confirm audit scope

Before collecting evidence, confirm:

- Audit type: internal audit, external audit, client assurance, stage 1, stage 2, or surveillance.
- Audit period and evidence freshness expectation.
- ISMS scope, locations, systems, services, and excluded areas.
- Applicable Annex A controls and non-applicability justifications.
- Control owners and evidence owners.
- Evidence storage location and access restrictions.

## 2. Build the control request list

Use `docs/control-mapping-matrix.csv` as the control register.

For each applicable control, record:

| Field | Purpose |
| --- | --- |
| Control ID | ISO 27001 Annex A reference. |
| Control title | Plain-language control name. |
| Control owner | Person or role accountable for the control. |
| Evidence owner | Person or role that can collect the evidence. |
| Evidence type | Export, screenshot, policy, ticket, register, review record, or report. |
| Collection method | Scripted, manual, portal export, ITSM export, HR/legal record, supplier evidence, or facilities evidence. |
| Due date | When the evidence is needed. |
| Review status | Requested, received, rejected, accepted, or remediating. |

## 3. Collect evidence

Use this order:

1. Run repository validation locally to confirm the register and crosswalk are healthy.
2. Collect scripted Microsoft 365 evidence where the script covers the control.
3. Collect manual evidence for controls outside safe Microsoft Graph coverage.
4. Save evidence using the naming convention in the README.
5. Record source, date, operator, audit period, and control mapping.
6. Redact sensitive values before external sharing.

For scripted evidence examples, use `docs/script-usage-examples.md`.

For manual evidence, use `docs/manual-evidence-playbook.md`.

## 4. Review evidence quality

Reject or remediate evidence when:

- The control ID is missing or unclear.
- The evidence does not cover the audit period.
- The screenshot is too cropped to prove the source and setting.
- The export has no owner, date, or scope.
- The evidence shows design only, but the control is marked implemented or evidenced.
- The evidence contains sensitive data that should have been redacted.
- The evidence proves a setting exists but not that it was reviewed or operated.

Accept evidence when it is:

- Relevant to the control.
- Current for the audit period.
- Complete enough to prove the control objective.
- Traceable to a system, owner, date, and method.
- Protected and redacted appropriately.
- Linked to review, ticket, approval, or sign-off where required.

## 5. Build the auditor pack

Recommended auditor pack structure:

```text
auditor-pack/
├── 00-scope-and-method/
├── 01-statement-of-applicability/
├── 02-control-register/
├── 03-risk-register/
├── 04-policy-evidence/
├── 05-technical-evidence/
├── 06-manual-evidence/
├── 07-exceptions-and-risks/
├── 08-remediation-plan/
└── 09-audit-questions-and-responses/
```

Minimum pack contents:

- Approved Statement of Applicability.
- Control mapping matrix.
- Risk register or risk treatment plan.
- Policy register and key policies.
- Technical exports and screenshots.
- Manual evidence records.
- Exception register.
- Remediation tracker.
- Evidence index mapping files to controls.

## 6. Prepare for auditor questions

Use each per-control guide's audit questions section. For every sampled control, prepare:

| Question | Expected preparation |
| --- | --- |
| Who owns this control? | Named role, deputy, and governance forum. |
| How is the control operated? | Process, tool, cadence, and evidence source. |
| How do you know it is working? | Export, review record, test result, or ticket evidence. |
| What changed during the audit period? | Change records, release notes, review dates, or exception updates. |
| What are the gaps? | Known issues, risk acceptance, remediation owner, and due date. |

## 7. Track gaps and remediation

Every rejected evidence item or failed control should create a gap record.

| Field | Purpose |
| --- | --- |
| Gap ID | Unique tracker reference. |
| Control ID | Related Annex A control. |
| Finding | What is missing or weak. |
| Risk | Why it matters. |
| Owner | Accountable remediation owner. |
| Due date | Expected completion date. |
| Interim control | Compensating control or risk acceptance. |
| Status | Open, in progress, accepted, closed. |

## 8. Post-audit closeout

After the audit:

1. Update the control matrix status.
2. Update the risk register and exception register.
3. Add missing evidence examples or templates.
4. Improve per-control guides where auditor questions exposed gaps.
5. Record lessons learned for the next audit cycle.
6. Open repository issues for reusable documentation improvements.

## Common mistakes

- Treating a screenshot as sufficient without owner, date, scope, or context.
- Collecting evidence after the audit period without explaining why it still applies.
- Providing policy documents without evidence that the process operates.
- Claiming automation coverage for controls that require HR, ITSM, supplier, or facilities evidence.
- Sharing unredacted exports with external parties.
- Closing audit gaps without verifying remediation evidence.