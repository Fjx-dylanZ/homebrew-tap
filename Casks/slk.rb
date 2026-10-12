cask "slk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.26.0-fjx.2"
  sha256 arm:   "2db9d746a92f38c06261e639da2fd308afb2f3070116c5663c9eeb919461fdfb",
         intel: "12b1d666499947a44ec5145389bd0fd1440477bf366770ec9b8f5a1aacc2c720"

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
