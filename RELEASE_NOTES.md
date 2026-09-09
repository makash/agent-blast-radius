# Agent Blast Radius 0.2.1

Patch release: generated captions now recommend the correct scoped command,
`npx -y @kloudle/agent-blast-radius@0.2.1`. Release verification now checks that
both saved and printed captions match the installed package name and version.
Existing v0.2.0 release files are unchanged.

One explicitly invoked command checks offline exposure, creates a social-ready
card, and prints a suggested caption:

```sh
npx -y @kloudle/agent-blast-radius@0.2.1
```

## Included

- Offline local credential exposure checks with redacted output.
- Built-in 1080 × 1350 PNG generation and suggested share text by default.
- A system-username card title; `--anonymous` removes the username.
- `--no-card` to suppress the default card and share-text files.
- Checksum-pinned npm launcher; installing alone does not download a binary or scan.
- macOS and Linux binaries for ARM64 and AMD64.

Package installation and the initial binary download need network access. A cached
launcher verifies and runs the binary locally, but `npx` itself may still contact
npm on later invocations. The scanner's checks are offline; no discovered
credentials or scan reports are uploaded. Scores are heuristic exposure estimates,
not proof of account access. Review generated cards and captions before sharing.

Account lookup ignores inherited `USER` and `LOGNAME` values and falls back to
anonymous output on failure or after 250 ms. Linux uses a bounded `/etc/passwd`
lookup. Unsupported font characters become spaced `U+XXXX` labels in PNG and SVG
cards, with a 60-character display limit including `...` when truncated. Sharing
text retains the original sanitized username.

Output files are never overwritten. PNG and caption files are created separately
with owner-only permissions. If caption creation fails, the command reports
failure and a completed PNG may remain; existing text is preserved.

## Not included

Online checks (future Pro), fleet management (future Pro Max), an enforced hosted
IP allowance, and billing are not implemented in this release. This is proprietary
software; scanner source is not included in this downloads-only repository.

## Verify direct downloads

Choose the binary matching your operating system and CPU. Download `SHA256SUMS`
alongside it and verify the binary's SHA-256 before executing it. The npm launcher
performs checksum verification automatically using the hashes shipped in its
version-specific manifest.

These initial binaries are unsigned and are not notarized by Apple. Operating
system warnings or execution blocks are possible. Checksums establish integrity
against the published manifest, not an independent signing identity.
