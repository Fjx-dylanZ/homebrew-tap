cask "slk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.26.2-fjx.4"
  sha256 arm:   "b93a4b57e0baa0f562c33f70c41bf7984ba8c7f2c3250f1c9e17ebfab86b7cf6",
         intel: "42aff1fc6fe94f24c616f361430d08734d9cb2e1bc370df1a57dad885cbb615d"

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
