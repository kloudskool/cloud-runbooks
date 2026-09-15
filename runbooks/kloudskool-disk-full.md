# Runbook: Linux VM disk full

## Symptoms

Disk usage alert above 90%. Applications fail to write logs.

## Severity

Sev 2 if production logging stops; Sev 3 otherwise.

## Diagnosis

`df -h /` confirms usage. `du -xh / --max-depth=2 | sort -h | tail` finds the largest folders.

## Fix

Remove rotated logs older than the retention period. Expand the disk if usage is steady growth.

## Escalation

Platform on-call engineer.
