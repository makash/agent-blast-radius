# Agent Blast Radius 0.3.2

Finds the deploy logins people actually have today, and stops flagging placeholders.

```sh
npx -y @kloudle/agent-blast-radius@0.3.2          # scan (free, offline)
npx -y @kloudle/agent-blast-radius@0.3.2 verify   # check which keys work (paid, optional)
```

## New

- **Current deploy-CLI logins.** blast now checks where today's CLIs keep their login:
  - `wrangler login`: `~/.config/.wrangler` on Linux, `~/Library/Preferences/.wrangler` on macOS
  - `vercel login`: `com.vercel.cli` in the system data folder
  - `netlify login`: `~/.config/netlify` on Linux, `~/Library/Preferences/netlify` on macOS
  - `supabase login`: `~/.supabase/access-token`

  Earlier versions looked only in the legacy folders, so these logins were often missed.
- **GitHub CLI logins in the OS keychain.** gh keeps its token in the keychain by default,
  so a file scan saw nothing. Yet any program running as you, including an agent, can
  print the token with `gh auth token`. blast now reports these logins as
  `github-cli-keychain-login` and explains how to log out or narrow the token.

## Fixed

- **Placeholders aren't secrets.** Values like `changeme`, `your-password-here`,
  `<your-key>` and `xxx` are no longer flagged. Generic matches in `.env.example`,
  `.env.sample`, `.env.template` and `.env.dist` files are ignored. A real typed key (for
  example `AKIA…`, `ghp_…` or a private key) in an example file is still reported.

Binaries are built with `CGO_ENABLED=0 -trimpath`. Check them against `SHA256SUMS`; the
npm launcher verifies its pinned checksum before running.
