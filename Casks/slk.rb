cask "slk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.26.2-fjx.1"
  sha256 arm:   "0797634d68fe96cbd118ec763e44235653d2dcb5e132ec71e2f12d8d0947de3c",
         intel: "aa10c26e85215c11630e8f27e5b6f75a920274ebd6e4e7a986460cbdbc918ba5"

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
