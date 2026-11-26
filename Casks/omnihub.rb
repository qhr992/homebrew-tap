cask "omnihub" do
  version "1.11.0"
  sha256 "906348daaba5fd02f34c124ba9bcf7610d6c8fdebe886b6fb0a5495f6723905a"

  url "https://github.com/qhr992/OmniHub/releases/download/v#{version}/OmniHub-#{version}.dmg"
  name "OmniHub"
  desc "Menu bar toolkit: screenshots, pins, clipboard history, now playing and terminal"
  homepage "https://github.com/qhr992/OmniHub"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "OmniHub.app"

  # Releases are signed with a self-signed certificate and not notarised,
  # so Gatekeeper would refuse the first launch of a quarantined copy.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/OmniHub.app"]
  end

  uninstall quit: "com.local.omnihub"

  zap trash: [
    "~/.omnihub",
    "~/Library/Application Support/OmniHub",
    "~/Library/Caches/com.local.omnihub",
    "~/Library/HTTPStorages/com.local.omnihub",
    "~/Library/Preferences/com.local.omnihub.plist",
  ]

  caveats <<~EOS
    Passwords saved in the Terminal vault stay in the login Keychain
    (service com.local.omnihub.vault); remove them in Keychain Access.
  EOS
end
