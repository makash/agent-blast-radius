#!/bin/sh
# Agent Blast Radius installer: downloads the blast binary for this machine from the
# GitHub release, verifies it against the release SHA256SUMS, and installs it to
# ~/.local/bin (or $BLAST_INSTALL_DIR). No sudo. macOS and Linux, amd64 and arm64.
#
#   curl -fsSL https://abr.kloudle.dev/install.sh | sh
#   BLAST_VERSION=0.3.1 BLAST_INSTALL_DIR=/usr/local/bin sh install.sh
set -eu

main() {
  repo="makash/agent-blast-radius"
  version="${BLAST_VERSION:-0.3.1}"
  dir="${BLAST_INSTALL_DIR:-$HOME/.local/bin}"
  os=$(uname -s | tr '[:upper:]' '[:lower:]')
  case "$os" in darwin|linux) ;; *) echo "blast: unsupported OS: $os (macOS and Linux only)" >&2; exit 1 ;; esac
  case "$(uname -m)" in
    x86_64|amd64) arch=amd64 ;;
    arm64|aarch64) arch=arm64 ;;
    *) echo "blast: unsupported CPU: $(uname -m)" >&2; exit 1 ;;
  esac
  asset="blast-$os-$arch"
  base="https://github.com/$repo/releases/download/v$version"
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT INT TERM

  echo "Downloading blast $version for $os/$arch…"
  curl -fsSL --proto '=https' --tlsv1.2 -o "$tmp/$asset" "$base/$asset"
  curl -fsSL --proto '=https' --tlsv1.2 -o "$tmp/SHA256SUMS" "$base/SHA256SUMS"
  expected=$(awk -v f="$asset" '$2 == f { print $1 }' "$tmp/SHA256SUMS")
  [ -n "$expected" ] || { echo "blast: no checksum for $asset in the release" >&2; exit 1; }
  if command -v sha256sum >/dev/null 2>&1; then
    actual=$(sha256sum "$tmp/$asset" | awk '{print $1}')
  else
    actual=$(shasum -a 256 "$tmp/$asset" | awk '{print $1}')
  fi
  [ "$expected" = "$actual" ] || { echo "blast: checksum mismatch; nothing was installed" >&2; exit 1; }

  mkdir -p "$dir"
  install -m 0755 "$tmp/$asset" "$dir/blast"
  echo "Installed $dir/blast ($("$dir/blast" --version))"
  case ":$PATH:" in *":$dir:"*) ;; *) echo "Add $dir to your PATH to run 'blast' from anywhere." ;; esac
  echo "Run: blast        (scan, offline)   ·   blast verify   (check which keys are live)"
}

main "$@"
