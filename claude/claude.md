# Global Claude Code Instructions

## Version Control

Prefer JJ (Jujutsu) over git where possible. Always try JJ commands first before falling back to git.

- Use `jj` commands for version control operations when available
- Only fall back to `git` if JJ is not installed or if a specific git-only feature is required
- For commits, prefer `jj commit` or `jj describe` over `git commit`
- For status, prefer `jj status` or `jj st` over `git status`
- For diffs, prefer `jj diff` over `git diff`
- For history, prefer `jj log` over `git log`

## File Deletion

Use `trash` CLI instead of `rm` for deleting files.

## GitHub CLI

Prefer `gh api` over high-level `gh` subcommands for fetching issue/PR data.

- Use `gh api repos/{owner}/{repo}/issues/{number}` over `gh issue view {number} --repo {owner}/{repo}`
- Use `gh api repos/{owner}/{repo}/pulls/{number}` over `gh pr view {number} --repo {owner}/{repo}`
- The API approach provides more consistent JSON output and avoids formatting quirks

## TypeScript Type Checking

Prefer the project's own typecheck script over `npx tsc`.

- Check `package.json` for a `typecheck` or `type-check` script first
- Use `npm run typecheck` or the project's equivalent command
- Only fall back to `npx tsc --noEmit` if no project-specific command exists
- Project scripts often include additional flags and configuration specific to the codebase
