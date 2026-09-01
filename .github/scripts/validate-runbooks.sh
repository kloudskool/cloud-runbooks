#!/usr/bin/env bash
# Every runbook changed in the pull request must contain every "## " heading of the template on the base branch.
set -uo pipefail
BASE="$1"
git show "origin/$BASE:runbooks/TEMPLATE.md" | grep '^## ' > /tmp/headings
fail=0
for f in $(git diff --name-only --diff-filter=AM "origin/$BASE...HEAD" -- 'runbooks/*.md'); do
  [ "$f" = "runbooks/TEMPLATE.md" ] && { echo "NOT YET  Don't change the template: copy it to a new file"; fail=1; continue; }
  case "$(basename "$f")" in *[A-Z]*) echo "NOT YET  $f: file names are lower case"; fail=1;; esac
  while IFS= read -r h; do
    grep -qxF "$h" "$f" || { echo "NOT YET  $f is missing the heading: $h  (is your branch up to date with upstream/$BASE?)"; fail=1; }
  done < /tmp/headings
done
[ "$fail" -eq 0 ] && echo "PASS     Every runbook has every template heading"
exit $fail
