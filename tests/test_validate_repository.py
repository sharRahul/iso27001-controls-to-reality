"""Fixture-based tests for scripts/validate_repository.py.

The validator is exercised as a subprocess, exactly as CI and operators run
it, so the tests cover argument parsing, exit codes, and error reporting as
well as the validation logic itself. All fixtures contain synthetic data
only.
"""

from __future__ import annotations

import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
SCRIPT = REPO_ROOT / "scripts" / "validate_repository.py"
FIXTURES = Path(__file__).resolve().parent / "fixtures"

VALID_MATRIX = FIXTURES / "valid-matrix.csv"
VALID_CROSSWALK = FIXTURES / "valid-crosswalk.csv"


def run_validator(*args: str) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [sys.executable, str(SCRIPT), *args],
        capture_output=True,
        text=True,
        check=False,
    )


class ValidFixtureTests(unittest.TestCase):
    def test_valid_fixtures_exit_zero(self) -> None:
        result = run_validator(
            "--matrix", str(VALID_MATRIX), "--crosswalk", str(VALID_CROSSWALK)
        )
        self.assertEqual(result.returncode, 0, msg=result.stdout + result.stderr)
        self.assertIn("Validated 3 control mappings.", result.stdout)
        self.assertIn("Validated 2 crosswalk rows.", result.stdout)

    def test_committed_repository_data_is_valid(self) -> None:
        result = run_validator()
        self.assertEqual(result.returncode, 0, msg=result.stdout + result.stderr)

    def test_dashboard_files_are_generated(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            result = run_validator(
                "--matrix", str(VALID_MATRIX),
                "--crosswalk", str(VALID_CROSSWALK),
                "--dashboard-dir", tmp,
            )
            self.assertEqual(result.returncode, 0, msg=result.stdout + result.stderr)
            markdown = Path(tmp) / "control-status-dashboard.md"
            html = Path(tmp) / "control-status-dashboard.html"
            self.assertTrue(markdown.is_file())
            self.assertTrue(html.is_file())
            self.assertIn("Status Dashboard", markdown.read_text(encoding="utf-8"))


class BrokenFixtureTests(unittest.TestCase):
    def assert_fails_with(self, matrix: Path, crosswalk: Path, expected: str) -> None:
        result = run_validator("--matrix", str(matrix), "--crosswalk", str(crosswalk))
        self.assertEqual(result.returncode, 1, msg=result.stdout + result.stderr)
        self.assertIn("Repository validation failed:", result.stdout)
        self.assertIn(expected, result.stdout)

    def test_missing_column_is_reported(self) -> None:
        self.assert_fails_with(
            FIXTURES / "matrix-missing-column.csv",
            VALID_CROSSWALK,
            "missing required column 'Evidence_Type'",
        )

    def test_unexpected_column_is_reported(self) -> None:
        self.assert_fails_with(
            FIXTURES / "matrix-unexpected-column.csv",
            VALID_CROSSWALK,
            "unexpected column 'Extra_Column'",
        )

    def test_invalid_status_is_reported(self) -> None:
        self.assert_fails_with(
            FIXTURES / "matrix-invalid-status.csv",
            VALID_CROSSWALK,
            "unsupported Implementation_Status 'In Progress'",
        )

    def test_duplicate_control_id_is_reported(self) -> None:
        self.assert_fails_with(
            FIXTURES / "matrix-duplicate-id.csv",
            VALID_CROSSWALK,
            "duplicate Control_ID 'A.5.15'",
        )

    def test_crosswalk_reference_to_missing_control_is_reported(self) -> None:
        self.assert_fails_with(
            VALID_MATRIX,
            FIXTURES / "crosswalk-unknown-control.csv",
            "references 'A.8.99' that is not present in the control matrix",
        )

    def test_missing_file_is_reported(self) -> None:
        result = run_validator(
            "--matrix", str(FIXTURES / "does-not-exist.csv"),
            "--crosswalk", str(VALID_CROSSWALK),
        )
        self.assertNotEqual(result.returncode, 0)


if __name__ == "__main__":
    unittest.main()
