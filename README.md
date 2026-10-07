# Agent Blast Radius

**What could an agent running as you reach?** `blast` scans the places a coding agent
running as you can read — cloud profiles, dotfiles, project `.env` files, CI configs,
MCP servers — and tells you what is exposed, scores it, and draws a card you can share.
Offline, read-only, never prints a secret value. Optionally, `blast verify` checks which
of those credentials are actually **live**, paid per check with your own wallet.

```sh
npx -y @kloudle/agent-blast-radius@0.3.1          # scan + share card (free, offline)
npx -y @kloudle/agent-blast-radius@0.3.1 verify   # which keys work? (paid, optional)
```

More at **[abr.kloudle.dev](https://abr.kloudle.dev)** · step-by-step guides for every agent: [abr.kloudle.dev/install](https://abr.kloudle.dev/install) · agent payments: [abr.kloudle.dev/agent-payments](https://abr.kloudle.dev/agent-payments)

## Install it where your agent runs

| Where | How |
|---|---|
| Any terminal | `npx -y @kloudle/agent-blast-radius@0.3.1` · `brew install makash/tap/blast` · `curl -fsSL https://abr.kloudle.dev/install.sh \| sh` |
| Claude Code | `/plugin marketplace add makash/agent-blast-radius` then `/plugin install agent-blast-radius@kloudle` |
| Codex (CLI and app) | `codex plugin marketplace add makash/agent-blast-radius` then `codex plugin add agent-blast-radius@kloudle` |
| Claude Desktop | Download [`agent-blast-radius-0.3.1.mcpb`](https://github.com/makash/agent-blast-radius/releases/download/v0.3.1/agent-blast-radius-0.3.1.mcpb) and open it |
| Cursor | [Add to Cursor](https://abr.kloudle.dev/install/cursor/add) · [guide](https://abr.kloudle.dev/install/cursor) |
| VS Code | [Install in VS Code](https://abr.kloudle.dev/install/vscode/add) · [guide](https://abr.kloudle.dev/install/vscode) |
| Devin Desktop (Windsurf), Cline, Zed, any MCP client | `{"mcpServers":{"blast":{"command":"npx","args":["-y","@kloudle/agent-blast-radius@0.3.1","mcp"]}}}` |
| Agent Skills | `npx skills add makash/agent-blast-radius` |
| Rules files | [Cursor](rules/cursor/blast.mdc) · [Devin Desktop / Windsurf](rules/devin/blast.md) · [Cline](rules/cline/blast.md) |

Release binaries and `SHA256SUMS` are on [Releases](https://github.com/makash/agent-blast-radius/releases):
macOS and Linux, ARM64 and AMD64. They are not code-signed or notarized; verify the
checksum. The npm launcher and `install.sh` verify it for you. Node.js 22+ for `npx`.

## The scan

- Reports credential types, locations, SHA-256 fingerprints, local scope hints and
  configured MCP reachability. **Never values.**
- Makes no network calls, executes no MCP servers, uploads nothing, no telemetry.
- Writes a 1080 × 1350 PNG card and share text by default (`--anonymous` drops your
  username, `--no-card` skips files). Existing files are never overwritten.
- Scores are exposure estimates, not proof that a credential works or was compromised.

As an MCP server (`blast mcp`) it offers `blast_radius`, `explain_credential` and
`blast_card` (read-only, offline) plus the verify tools below.

## Which ones are live? `blast verify`

The scan can't tell a dead key from a live one. `blast verify`:

1. counts eligible findings (AWS profiles; `OPENAI_API_KEY` / `ANTHROPIC_API_KEY` in
   the environment) and creates a claim at abr.kloudle.dev with **class counts only**,
   e.g. `aws-sts-identity:2`;
2. prints the price — **$0.10 USDC per check on Algorand** — a code, and two ways to pay
   with your own wallet: your agent's x402 wallet tool (e.g. GoPlausible's
   `algorand-mcp`), or a browser link where you approve in Pera, Defly or Lute;
3. once paid, fetches an **Ed25519-signed** manifest, runs the checks on your machine
   (`aws sts get-caller-identity`, provider model-list probes) with a minimal
   environment, and reports each finding as live, rejected or error.

```sh
blast verify --open            # open the pay page and wait
blast verify --claim <id>      # collect later (claims survive restarts for 30 days)
blast verify --list            # unfinished claims on this machine
```

MCP: `blast_verify_quote` → pay → `blast_collect`. Payments are final.
Need a wallet? [abr.kloudle.dev/wallet](https://abr.kloudle.dev/wallet).

**Never sent:** credential values, profile names, environment variable names, file
paths, scan output. See [abr.kloudle.dev/privacy](https://abr.kloudle.dev/privacy).

## License

Proprietary — see [LICENSE.txt](LICENSE.txt). Free to use for checks on machines and
accounts you own or are authorized to assess. Third-party notices:
[THIRD_PARTY_NOTICES.txt](THIRD_PARTY_NOTICES.txt). Scanner source is private; this
repository distributes binaries, the npm launcher's metadata, plugins, skills and rules.
