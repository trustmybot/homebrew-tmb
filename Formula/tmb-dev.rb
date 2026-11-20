# Homebrew formula for tmb's dev channel. Rendered by scripts/package-managers.ts from a
# release: do not edit the rendered copy in the tap, edit this template.
# A formula, not a cask: Homebrew quarantines what a cask downloads, and macOS then refuses a
# binary that is not notarized. A formula's download is not quarantined.
class TmbDev < Formula
  desc "Harness for coding agents: a record, a code graph and an enforced workflow"
  homepage "https://github.com/trustmybot/tmb-releases"
  version "0.1.0-dev.57.gh109"

  on_macos do
    on_arm do
      url "https://github.com/trustmybot/tmb-releases/releases/download/dev/tmb-darwin-arm64"
      sha256 "845636b29758c32914edf8a586c05edf130ebd777fc4d2bc53dd61904089607e"
    end
    on_intel do
      url "https://github.com/trustmybot/tmb-releases/releases/download/dev/tmb-darwin-x64"
      sha256 "bf19c00e9d33cecca462060ddcc5f87dbfd2f03c3cca3cb1d1972e2b2eb44b2f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/trustmybot/tmb-releases/releases/download/dev/tmb-linux-arm64"
      sha256 "0857730e2561b23740e973dec61c19391503e4b6b14eaf8ff293e58c5018e7b0"
    end
    on_intel do
      url "https://github.com/trustmybot/tmb-releases/releases/download/dev/tmb-linux-x64"
      sha256 "2731cbc7d4470b85de0a5e2c6b3aefbf84f3b9c14047fca4a6f3a7207603f5db"
    end
  end

  livecheck do
    skip "Updated by tmb's release workflow"
  end

  # A tmb program knows itself by its file's name, so the file is installed under the program's
  # name, and tmb-dev never takes itself for another channel (trustmybot/tmb#89, Part 2).
  def install
    bin.install Dir["tmb-{darwin,linux}-*"].first => "tmb-dev"
  end

  def caveats
    <<~EOS
      tmb-dev updates itself from the dev channel between sessions.
      Run `tmb-dev init` in a project, then start your agent program there.
    EOS
  end

  test do
    assert_match "dev channel", shell_output("#{bin}/tmb-dev --version")
  end
end
