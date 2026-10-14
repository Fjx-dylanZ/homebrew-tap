cask "slk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.26.2-fjx.2"
  sha256 arm:   "a2c1f18d894034e1a225ef0f7a114acfb99bb0ded23551b3c75b4a30c069960c",
         intel: "d6a93f23425f620992c470890800f207fdfce3183569e4ac97342b535eb21c03"

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
