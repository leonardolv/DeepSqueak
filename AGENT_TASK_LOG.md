# Agent Task Log - Continuous Improvement
Shared continuity file for automated maintenance runs. Multiple agents may work this file; always append, never overwrite another agent's entries. Agent should roll over to a new file weekly.
## Summary (update every run)
- 2026-10-06: Added CSV export column header row in csv_Callback.m to prevent silent truncation of first calls on merged export, and added empty-input structured table schema handling to merge_boxes.m with unit tests in TestMergeBoxes.m.
## Needs human
## In Progress
## Completed
- [2026-10-06T01:10:00Z] [Antigravity] Fix CSV export column header omission and merged-export truncation; add structured empty table return in merge_boxes.
  - Root cause: Functions/Import and Export/csv_Callback.m built callboxes cell table without a column header row. When export_Calls.m wrote tables with 'WriteVariableNames',0 or merged multiple files by slicing t(2:end,:) under the assumption of a header row, the first call of each subsequent file was silently dropped, and exported CSVs lacked header descriptions. Separately, Functions/merge_boxes.m returned an untyped 0-column table on empty input or cutoff filter instead of preserving the expected {'Box', 'Score', 'Type', 'Accept'} table variable schema.
  - Solution: Added header row [{'Start Time (s)'} {'End Time (s)'} {'Low Freq (Hz)'} {'High Freq (Hz)'} {'Label'}] to csv_Callback.m. Updated merge_boxes.m to return a typed empty table with {Box, Score, Type, Accept} variables when input is empty or when all calls fall below cutoff.
  - Files changed: Functions/Import and Export/csv_Callback.m, Functions/merge_boxes.m, Tests/TestMergeBoxes.m.
  - Next steps: Expand automated test coverage for import and export callbacks.
## Backlog
## Decisions and reasons
- Retain 'WriteVariableNames',0 compatibility in export_Calls.m while supplying explicit row 1 headers in csv_Callback.m matching the pattern in excel_Callback.m.
## Known bugs
## Ideas
