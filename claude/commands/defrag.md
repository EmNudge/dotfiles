---
description: Analyze project for redundancies, disorganization, and performance pitfalls, then fix them
---

## Your task

Perform a comprehensive codebase cleanup ("defragmentation"). Work through each phase systematically.

### Phase 1: Analysis

Scan the codebase to identify:

- **Redundancies**: duplicate code, unused imports, dead code, copy-pasted logic
- **Disorganization**: inconsistent naming, scattered related files, poor module boundaries, tangled dependencies
- **Performance pitfalls**: inefficient algorithms, unnecessary allocations, N+1 patterns, slow code paths

### Phase 2: Simplify

- Remove redundant and dead code
- Consolidate duplicates into shared utilities
- Delete unused imports and dependencies
- Flatten unnecessary abstractions

### Phase 3: Organize

- Group related functionality into coherent modules
- Establish clear module boundaries
- Enforce consistent naming conventions
- Untangle circular or messy dependencies

### Phase 4: Optimize

- Fix identified performance issues
- Improve algorithmic complexity where possible
- Reduce unnecessary allocations and copying
- Eliminate redundant computations

### Phase 5: Documentation

- Keep READMEs concise: overview, quick start, and links only
- Move in-depth docs to `docs/` folder or wrap in `<details>` tags
- Remove outdated or redundant documentation
- Delete documentation that duplicates code comments

### Phase 6: Testing & Tooling

- Ensure tests are comprehensive with good edge case coverage
- Create helper scripts/tools to validate tasks more easily
- **Critical**: If benchmarks and tests exist, unify their imports so benchmarks measure the exact same code paths that tests validate
- Remove flaky or redundant tests

### Output

After making changes, provide:

1. Summary of all changes made with brief rationale for each
2. Any items requiring manual review or follow-up
3. Suggestions for further improvements you couldn't automate
