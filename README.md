# Agent Blast Radius

**What could an agent running as you reach?** Check local credential exposure,
generate a social-ready card, and get helpful text to copy—all on your machine.

## One command

```sh
npx -y agent-blast-radius@0.2.0
```

Requires Node.js 22+ on macOS or Linux, ARM64 or AMD64. Running this command
downloads and verifies the platform binary, then performs an **offline** check.
Installing the package by itself does not run install hooks, download a binary,
or scan.

By default, the check creates a **1080 × 1350 PNG** card and share text in the
current directory. PNG generation is built in: no image converter is needed.
The card is titled **“<username>'s agent blast radius”** using your system username.
Review the image and suggested text before posting to Instagram, LinkedIn, or X.

Account lookup uses the system account rather than inherited `USER` or `LOGNAME`.
If lookup fails or exceeds 250 ms, output is anonymous. On Linux, the account must
appear in a bounded `/etc/passwd` lookup. Unsupported font characters become
spaced `U+XXXX` labels in both PNG and SVG cards. The displayed owner is limited
to 60 Unicode characters including `...` when truncated; sharing text retains
the original sanitized username.

```sh
# Leave your username off the card
npx -y agent-blast-radius@0.2.0 --anonymous

# Print the check without creating the default card or share-text files
npx -y agent-blast-radius@0.2.0 --no-card

# See all options
npx -y agent-blast-radius@0.2.0 --help
```

Existing output files are not overwritten. PNG and text are created as separate
complete files with owner-only permissions. If text creation fails, such as when
its destination exists, the command reports failure and a completed PNG may
remain; existing text is preserved. The pair is not an all-or-nothing transaction.

You can also download a platform binary
and `SHA256SUMS` from [Releases](https://github.com/makash/agent-blast-radius/releases)
without npm. Verify its checksum against the release, make it executable, and run
it from a directory where you want the generated files saved.

This initial release is unsigned and is not notarized by Apple. Your operating
system may show a security warning or block execution. Checksums verify integrity
against the published release, not an independent signing identity.

## What the result means

The check reports local credential exposure and heuristic reachability; it does
**not** prove that a token works, that an account is compromised, or that a user
has administrator access. Results can be incomplete. Use only on systems and files
you own or are authorized to assess.

The scan does not contact credential providers, execute MCP server configurations,
upload findings, or send telemetry. The installer does contact npm/GitHub to obtain
the executable; those services can see the request and your IP, but no discovered
credentials are sent to them. The launcher checks its pinned SHA-256 on download
and on every cached run without downloading the binary again. `npx` itself may
still contact npm on later invocations; the scanner's checks remain offline.
These protections do not defend against a compromised publisher account or a
hostile process already controlling your own user account.

## Editions

- **Free, available in this release:** offline checks, PNG cards, and share text.
- **Pro, planned:** online checks only with explicit opt-in.
- **Pro Max, planned:** fleet-of-machines workflows.

A separate hosted Algorand challenge allowance of 10 checks per IP is planned.
The reset period and additional-check price are not yet set, and billing is not
enabled. The local offline executable does not enforce an IP quota or charge for
checks. Pro and Pro Max are not implemented in this release.

## Downloads-only repository

This public repository hosts release downloads and user documentation. Scanner
source is private. The software is proprietary, **not open source**; see
[LICENSE.txt](LICENSE.txt). Third-party components retain their own licenses; see
the notices supplied with each release.

[Report an issue](https://github.com/makash/agent-blast-radius/issues), but never
include credentials, private file contents, or unredacted reports in a public issue.
