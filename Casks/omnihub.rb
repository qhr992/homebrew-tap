cask "omnihub" do
  version "1.10.0"
  sha256 "3cca866335365ac8bd52442614fceb61723e0528e261f83f12159ed2cd42ae41"

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
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/OmniHub.app"]
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
