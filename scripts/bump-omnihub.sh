#!/bin/bash
# Points Casks/omnihub.rb at an OmniHub release (the latest by default):
#   scripts/bump-omnihub.sh [version]
# Downloads the release's dmg, checks it is there and takes its SHA-256.
set -euo pipefail
cd "$(dirname "$0")/.."

repo="qhr992/OmniHub"
version="${1:-}"
if [[ -z "$version" ]]; then
  version="$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest" \
    | sed -n 's/.*"tag_name": *"v\{0,1\}\([^"]*\)".*/\1/p' | head -1)"
fi
version="${version#v}"
[[ "$version" =~ ^[0-9]+(\.[0-9]+)*$ ]] || { echo "not a version: '$version'" >&2; exit 1; }

url="https://github.com/$repo/releases/download/v$version/OmniHub-$version.dmg"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
curl -fsSL -o "$tmp/OmniHub.dmg" "$url" || { echo "no dmg at $url" >&2; exit 1; }
sha="$(shasum -a 256 "$tmp/OmniHub.dmg" | cut -d' ' -f1)"

cask="Casks/omnihub.rb"
sed -i '' -E "s/^  version \".*\"/  version \"$version\"/; s/^  sha256 \".*\"/  sha256 \"$sha\"/" "$cask"
echo "omnihub $version  $sha"
