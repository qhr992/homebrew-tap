# homebrew-tap

Homebrew casks for [qhr992](https://github.com/qhr992)'s apps.

## OmniHub

A macOS menu bar toolkit: screenshots, pins, clipboard history, now playing, an agenda, a terminal with SSH and system monitoring. Needs macOS 14 or later.

```bash
brew install --cask qhr992/tap/omnihub
```

or

```bash
brew tap qhr992/tap
brew install --cask omnihub
```

OmniHub updates itself, so `brew upgrade` leaves it alone unless you add `--greedy`. Releases are self-signed and not notarised; the cask clears the download's quarantine flag so the first launch is not blocked.

Remove it with `brew uninstall --cask omnihub`, or `brew uninstall --zap --cask omnihub` to remove its data and settings too.

## Updating the cask

After an OmniHub release:

```bash
scripts/bump-omnihub.sh          # the latest release
scripts/bump-omnihub.sh 1.8.6    # or a given version
```

It downloads the release's dmg, takes its SHA-256 and writes both into `Casks/omnihub.rb`; then commit and push.
