cask "slk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.26.2-fjx.3"
  sha256 arm:   "c378c51e019792b4a7a833b6dd886202e01d2baf76443f996a74dbf412c378a3",
         intel: "b7c19a70f276ef05a7b697f98e75be91187852d4481f9146c68d11c4997ca5f6"

  url "https://github.com/Fjx-dylanZ/slk/releases/download/v#{version}/slk_#{version}_darwin_#{arch}.tar.gz"
  name "slk"
  desc "Keyboard-driven Slack TUI (fork build with pending upstream fixes)"
  homepage "https://github.com/Fjx-dylanZ/slk"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+-fjx\.\d+)$/i)
    strategy :github_latest
  end

  conflicts_with cask: "gammons/tap/slk"
  depends_on :macos

  binary "slk"

  # The binary is not notarized; macOS quarantines it on download and
  # Gatekeeper refuses to run it.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/slk"]
  end
end
