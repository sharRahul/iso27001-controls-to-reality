# Committed Sample Dashboard

`control-status-dashboard.md` and `control-status-dashboard.html` are committed samples of the validator's dashboard output, generated from the committed control matrix and crosswalk, so the output is visible without a local run. CI also regenerates and uploads the dashboard as a workflow artifact on every push.

Regenerate after changing the matrix or crosswalk:

```bash
python scripts/validate_repository.py --dashboard-dir docs/dashboard
```
