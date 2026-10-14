cask "slk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.26.2-fjx.5"
  sha256 arm:   "5eba8b5c11293fb87f92918219bd7fb94f106b4f34ce0f55dd68c31a5c590736",
         intel: "587b16f61e083c55badb20578b9e5f9fc0cf22ddd971ad4857b1bf8c9c9b6334"

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
