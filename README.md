# RWX Skills

Skills for working with [RWX](https://www.rwx.com).

<!-- prettier-ignore -->
> [!IMPORTANT]
> This repository is under active development.

## Installation

This skill also requires that the
[RWX CLI](https://www.rwx.com/docs/rwx/getting-started) is installed and
authenticated.

### Claude Code

In Claude Code, run:

```
/plugin marketplace add rwx-cloud/skills
```

Then, install the RWX skill:

```
/plugin install rwx
```

### Universal (npx)

```
npx skills add rwx-cloud/skills
```

## Skills

### `/rwx`

Generates or modifies an RWX CI/CD config. Analyzes project structure, selects
appropriate packages, and produces an optimized config with DAG parallelism,
content-based caching, and RWX packages. If an existing `.rwx/*.yml` config is
present, modifies it in place.

```
/rwx CI pipeline with tests and deploy
```

The skill will:

1. Analyze project structure and any existing `.rwx/*.yml` configs
2. Fetch the latest RWX reference documentation
3. Generate (or update) an optimized config at `.rwx/<name>.yml`
4. Validate via `rwx lint` and fix any errors
5. Summarize the DAG shape, packages used, and next steps

### Migration Skills

#### `/migrate-from-gha`

Migrates a GitHub Actions workflow to RWX.

```
/migrate-from-gha .github/workflows/ci.yml
```

#### `/review-gha-migration`

Reviews a generated RWX config against the original GitHub Actions workflow.

```
/review-gha-migration .rwx/ci.yml
```

## Architecture

- **Skills** (`skills/*/SKILL.md`) — Agent-neutral procedural playbooks. Each
  skill includes `curl` commands for fetching the latest reference documentation
  directly.
- **CLI Validation** — `rwx lint <file>` provides validation for all agents via
  the command line.

## Agent Config

| File                              | Agent(s)        | Purpose                             |
| --------------------------------- | --------------- | ----------------------------------- |
| `AGENTS.md`                       | Codex, OpenCode | Vendor-neutral agent instructions   |
| `.claude-plugin/plugin.json`      | Claude Code     | Plugin discovery                    |
| `.claude/settings.local.json`     | Claude Code     | Permissions                         |
| `.github/copilot-instructions.md` | GitHub Copilot  | Agent instructions                  |
| `marketplace.json`                | Universal       | Skill registry for `npx skills add` |

## Requirements

- [RWX CLI](https://www.rwx.com/docs/rwx/getting-started/installing-the-cli)
  (`rwx` on PATH)

## License

MIT
