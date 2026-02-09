---
allowed-tools: Bash(gh *), Bash(sleep *), Bash(jj *), Bash(git *)
description: Watch CI on a PR, wait for completion, then fix errors or exit on success
---

## Input

- PR identifier (number or URL): $ARGUMENTS
- Detect repo from remote: !`git remote get-url origin 2>/dev/null | sed 's/.*github.com[:/]\(.*\)\.git/\1/' | sed 's/.*github.com[:/]\(.*\)$/\1/'`

## Your task

Watch CI checks on the given PR until they all complete. If any check fails, diagnose and fix the errors. If all checks pass, report success and exit.

### Step 1: Resolve the PR

Parse `$ARGUMENTS` to get the PR number. It may be:
- A bare number like `123`
- A full URL like `https://github.com/owner/repo/pull/123`
- A `owner/repo#123` reference

Extract the repo and PR number. If only a number is given, use the detected repo from the git remote.

### Step 2: Poll CI status

Run a polling loop. On each iteration:

```bash
gh pr checks <PR_NUMBER> --repo <OWNER/REPO> 2>&1
```

Examine the output:
- If **any** check has status `fail`, proceed immediately to Step 3 (fix errors).
- If **all** checks have status `pass`, proceed to Step 4 (success).
- If checks are still `pending` / `in_progress` / `queued`, wait and poll again.

**Polling cadence:** Wait 30 seconds between polls. Print a brief status summary each cycle so the user sees progress (e.g. "3/5 checks passed, 2 pending..."). Do NOT flood output — keep it to one line per poll.

**Timeout:** After 30 minutes of polling with no resolution, warn the user and ask whether to keep waiting.

### Step 3: Fix errors

When a check fails:

1. Identify the failed check name and job.
2. Fetch the failure logs:
   ```bash
   gh run view <RUN_ID> --repo <OWNER/REPO> --log-failed
   ```
   If the run ID isn't directly available, list runs for the PR's head branch:
   ```bash
   gh run list --branch <BRANCH> --repo <OWNER/REPO> --limit 5
   ```
   then view the failed one.

3. Analyze the logs to determine the root cause (build error, test failure, lint issue, etc.).

4. Fix the code in the local working tree. Read the relevant files, make edits, and verify the fix locally if possible (e.g. run the failing test or build command).

5. After fixing, commit and push the changes:
   - Prefer `jj` if available: `jj commit -m "fix: ..." && jj git push`
   - Fall back to `git add/commit/push` otherwise.

6. After pushing, return to Step 2 to watch the new CI run.

### Step 4: Success

When all checks pass:
- Print a clear success message listing all passed checks.
- Exit. You're done.

### Important notes

- Never use `--json` flags with `gh pr checks` if they cause errors — fall back to plain text parsing.
- If `gh` is not authenticated or the repo is not found, tell the user immediately and stop.
- Keep the output concise during polling — the user just wants to see progress, not walls of text.
