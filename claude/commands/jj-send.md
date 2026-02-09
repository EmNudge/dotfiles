---
allowed-tools: Bash(jj *), Bash(git remote *), Bash(open *)
description: Push current jj changes to remote with auto-generated description and PR link
---

## Context

- Changes from trunk to current: !`jj diff -r 'trunk()..@' 2>/dev/null || echo "Not in a jj repo"`
- Commits to push: !`jj log -r 'trunk()..@' 2>/dev/null`
- Current revision info: !`jj log -r @ --no-graph 2>/dev/null`
- Existing bookmarks on @: !`jj bookmark list -r @ 2>/dev/null || echo "none"`
- GitHub remote: !`git remote get-url origin 2>/dev/null | sed 's/.*github.com[:/]\(.*\)\.git/\1/' | sed 's/.*github.com[:/]\(.*\)$/\1/'`
- Trunk branch name: !`jj log -r 'trunk()' --no-graph -T 'bookmarks' 2>/dev/null | head -1`
- Parent bookmark (if any): !`jj log -r '@-' --no-graph -T 'bookmarks' 2>/dev/null | head -1`

## Your task

Push the current changes to the remote.

1. If there are no commits between trunk and @ (empty diff), inform the user there's nothing to push and stop.

2. Analyze the diff and generate:
   - A concise, descriptive commit message (e.g., "add dark mode toggle", "fix authentication bug")
   - A kebab-case bookmark name based on the description (e.g., "add-dark-mode-toggle")

3. **IMPORTANT: Execute all jj/git commands in ONE bash call using &&** to prevent separation during conversation compaction. Combine describe, bookmark creation (if needed), and push into a single command:

   If NO bookmark exists on @:
   ```bash
   jj describe -m "<message>" && jj bookmark create <bookmark-name> && jj git push --bookmark <bookmark-name> --allow-empty-description --allow-new
   ```

   If a bookmark ALREADY exists on @:
   ```bash
   jj describe -m "<message>" && jj git push --bookmark <existing-bookmark> --allow-empty-description --allow-new
   ```

4. After successful push, open the GitHub PR creation page. Build the URL:
   ```
   https://github.com/OWNER/REPO/compare/BASE_BRANCH...HEAD_BRANCH?quick_pull=1&title=YOUR_TITLE&body=YOUR_BODY
   ```
   Where:
   - OWNER/REPO comes from the GitHub remote
   - BASE_BRANCH: Use the **parent bookmark** if one exists (i.e. `@-` has a bookmark). Only fall back to the trunk branch name if the parent has no bookmark. This ensures stacked PRs target their parent branch, not main.
   - HEAD_BRANCH is the bookmark name you pushed
   - YOUR_TITLE is the commit description (URL encoded)
   - YOUR_BODY is a brief summary of the changes (URL encoded). Do NOT include a "Test plan" section or Claude Code attribution (Co-Authored-By) in the body.

   Run: `open "URL"` (with quotes to handle special characters)

5. Report success and display the clickable PR link.

## Important

- Do NOT add Claude Code attribution (e.g., "Co-Authored-By: Claude" or "Generated with Claude Code") to commit messages or PR bodies.
- Do NOT include a "Test plan" section in PR bodies.
