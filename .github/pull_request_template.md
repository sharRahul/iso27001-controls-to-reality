# Summary

<!-- What does this change and why? Reference the control IDs affected where relevant. -->

## Checklist

Please confirm before requesting review (see `CONTRIBUTING.md`):

- [ ] No sensitive data is included: no tenant IDs, user names, IPs, credentials, or real evidence exports. Placeholders such as `<tenant-id>` are used instead.
- [ ] New control mappings use ISO 27001:2022 control IDs and exist in `docs/control-mapping-matrix.csv` before being referenced by the crosswalk.
- [ ] Evidence examples are generic, anonymised, or synthetic.
- [ ] Any scripts are read-only against the tenant and safe to run in report-only mode by default.
- [ ] `python -m unittest discover -s tests` and `python scripts/validate_repository.py` pass locally.
- [ ] The README structure tree, `docs/IMPLEMENTATION_STATUS.md`, and `CHANGELOG.md` are updated if this change alters files, capability, or coverage.
