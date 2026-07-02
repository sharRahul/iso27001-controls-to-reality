# Changelog

All notable changes to this repository will be documented in this file.

The format follows the spirit of [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this repository uses date-based entries until formal semantic versioning is introduced.

## [Unreleased]

### Removed

- Redundant `validate-controls.yml` workflow. Its checks (exact CSV header schema, implementation status values, duplicate control IDs, status summary) are now covered by `scripts/validate_repository.py` and the `validate-and-dashboard.yml` workflow, which is the single CI validation path.

### Added

- Fixture-based validator tests under `tests/` (standard library `unittest`), covering valid data, a missing column, an unexpected column, an invalid implementation status, a duplicate control ID, and a crosswalk row referencing a control absent from the matrix. The tests run in CI before validation.
- `--matrix` and `--crosswalk` arguments on `scripts/validate_repository.py` so the validator can be pointed at fixture files; defaults are unchanged.
- Audit-ready documentation stack.
- Control mapping matrix for practical ISO 27001:2022 Annex A implementation tracking.
- Evidence collection guide for control owners and auditors.
- Statement of Applicability template.
- Audit readiness checklist.
- Contribution guidance and MIT licence.
- ISO 27001 to NIST CSF 2.0 and Cyber Essentials crosswalk CSV.
- Per-control implementation guides for A.8.2 privileged access rights and A.6.3 security awareness training.
- Risk register CSV template with starter example risks.
- Access control and incident response policy templates under `docs/policies/`.
- Read-only Microsoft 365 / Entra evidence export script with ISO control-labelled evidence index.
- Python validation and dashboard generator for the control matrix and crosswalk.
- GitHub Actions workflow that validates repository data and uploads a generated Markdown/HTML control dashboard.

### Changed

- Consolidated policy templates: `docs/isms-policy-templates/` is now the canonical policy template directory. The overlapping files under `docs/policies/` were converted to pointer notes after their unique minimum evidence tables and the A.5.27 mapping were merged into the canonical templates.
- Clarified that `docs/risk-register-template.md` is the narrative risk register guide and `docs/templates/risk-register-template.csv` is the importable CSV register.
- Added `docs/script-readiness-matrix.md` and the templates directory README to the README repository structure tree so the tree matches the files on disk.
- Expanded README into a professional project storefront with quick start guidance and repository structure.
- Updated README automation guidance for local validation, generated dashboards, and Microsoft 365 evidence exports.

## [2025-12-10]

### Added

- Initial repository README describing the purpose of translating ISO 27001 controls into practical implementation examples.
