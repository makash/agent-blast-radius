# Agent Blast Radius 0.3.1

Clearer results on busy machines, and a list of every place each secret lives, so you
know what to update when you rotate.

```sh
npx -y @kloudle/agent-blast-radius@0.3.1          # scan (free, offline)
npx -y @kloudle/agent-blast-radius@0.3.1 verify   # check which keys work (paid, optional)
```

## New

- **Same secret in several places.** The scan groups findings that share the same secret
  bytes and lists every location, for example one GitHub token in nine `.env` and CI
  files. It appears in the table, in `--explain`, and as `reuse` in the JSON and MCP
  output. Rotate once, update everywhere listed.
- **After `blast verify`:** live keys get "rotate these first", and rejected keys get
  "delete them from disk".
- `--anon` works as an alias for `--anonymous`.

## Fixed

- **Certificate bundles no longer flood the report.** Public PEM blocks (certificates,
  public keys, CSRs) are skipped, as are Python virtualenv and `site-packages` folders.
  One `certifi/cacert.pem` used to produce 1,000 "generic secret" findings.
- **Capped scans keep their locations.** Hitting the observation limit used to replace
  every location, profile and MCP server name with `[redacted-incomplete-inventory]`.
  Dropped values are now still registered for redaction, so the report stays useful.
  Generic matches have their own budget so they can't crowd out typed credentials.
- **Score:** generic matches count for at most 8 in the breadth bonus, so a noisy file of
  unverifiable strings can't reach 100/100 on volume alone. Typed credentials count
  fully, as before. See SCORING.md.
- **Agent-friendly output:** the table shows at most 25 rows per group (`--json` still
  lists everything). When output isn't a terminal (agents, pipes), blast prints the share
  text but doesn't write card files into the working directory. Use `--card` for the
  image.

Binaries are built with `CGO_ENABLED=0 -trimpath`. Check them against `SHA256SUMS`; the
npm launcher verifies its pinned checksum before running.
