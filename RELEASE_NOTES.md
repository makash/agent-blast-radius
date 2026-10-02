# Agent Blast Radius 0.3.0

Runs everywhere your agent does, and can now tell you which of your credentials are
**live**, paid per check with your own wallet.

```sh
npx -y @kloudle/agent-blast-radius@0.3.0          # scan (free, offline) + card
npx -y @kloudle/agent-blast-radius@0.3.0 verify   # check which keys work (paid, optional)
```

## New

- **`blast verify`**: live verification of eligible findings (AWS profiles; OpenAI and
  Anthropic keys in the environment). blast creates a claim at abr.kloudle.dev that
  carries only class counts (for example `aws-sts-identity:2`), you or your agent pay
  $0.10 USDC per check on Algorand with your own wallet (x402), and blast fetches a
  signed manifest and runs the checks **on your machine**. Credential values, profile
  names, environment variable names, paths and scan output never leave it.
  - Pay from an agent's x402 wallet tool (e.g. GoPlausible's algorand-mcp) or in a
    browser with Pera, Defly or Lute at abr.kloudle.dev/pay.
  - `--wait` / `--open`, `--claim ID` to collect later (claim state survives restarts),
    `--list`, `--only`, `--max-checks`, `--json`.
  - Manifests are Ed25519-signed; blast pins the key, runs only `aws` and `node`
    verifiers, never a shell, and passes them a minimal environment.
  - Payments are final.
- **MCP tools** `blast_verify_quote`, `blast_claim_status`, `blast_collect`. The scan
  tools stay read-only and offline.
- **Install anywhere:** Claude Code and Codex plugin marketplace in this repository,
  MCP registry entry, Cursor and VS Code install links, Agent Skills, Cursor / Devin
  Desktop (Windsurf) / Cline rules, Homebrew tap, checksum-verifying `install.sh`, and
  a Claude Desktop extension (`.mcpb`).

## Fixed

- The npm launcher now runs on stock Debian/Ubuntu, where `$HOME` and `~/.cache` are
  group-writable for the user's own group (775), and honours `XDG_CACHE_HOME`.
- `--paid-verify` (which needed a pre-signed payment header the service never
  accepted) is replaced by `blast verify`.

## Unchanged

The scan is offline and read-only, reports redacted metadata only, and makes the same
1080 × 1350 card. Binaries are unsigned and not notarized; verify them against
`SHA256SUMS`. macOS and Linux, ARM64 and AMD64.
