cask "slk" do
  arch arm: "arm64", intel: "x86_64"

  version "0.26.0-fjx.1"
  sha256 arm:   "dde32e6e10f529842e4ee9f224ee47fd4532676ec8ce1a49850f662ce1ec1c29",
         intel: "d52cdef9bc5734be942ddb1f5032f2fdf8886de6ec1b2dd14f37eecf3ae65991"

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
