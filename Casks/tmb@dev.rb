# Homebrew cask for tmb's dev channel. Rendered by scripts/package-managers.ts from a
# release: do not edit the rendered copy in the tap, edit this template.
cask "tmb@dev" do
  version "0.1.0-dev.57.gh109"

  on_macos do
    on_arm do
      sha256 "845636b29758c32914edf8a586c05edf130ebd777fc4d2bc53dd61904089607e"
      url "https://github.com/trustmybot/tmb-releases/releases/download/dev/tmb-darwin-arm64"
    end
    on_intel do
      sha256 "bf19c00e9d33cecca462060ddcc5f87dbfd2f03c3cca3cb1d1972e2b2eb44b2f"
      url "https://github.com/trustmybot/tmb-releases/releases/download/dev/tmb-darwin-x64"
    end
  end
  on_linux do
    on_arm do
      sha256 "0857730e2561b23740e973dec61c19391503e4b6b14eaf8ff293e58c5018e7b0"
      url "https://github.com/trustmybot/tmb-releases/releases/download/dev/tmb-linux-arm64"
    end
    on_intel do
      sha256 "2731cbc7d4470b85de0a5e2c6b3aefbf84f3b9c14047fca4a6f3a7207603f5db"
      url "https://github.com/trustmybot/tmb-releases/releases/download/dev/tmb-linux-x64"
    end
  end

  # A tmb program knows itself by its file's name, and a cask's binary is a symlink, which the
  # program does not see. So the file itself takes the program's name before it is linked, and
  # tmb-dev never takes itself for tmb (trustmybot/tmb#89, Part 2).
  preflight do
    Dir.glob("#{staged_path}/tmb-{darwin,linux}-*").each do |file|
      File.rename(file, "#{staged_path}/tmb-dev")
    end
  end
  binary "tmb-dev"

  name "tmb (dev)"
  desc "Harness for coding agents: a record, a code graph and an enforced workflow"
  homepage "https://github.com/trustmybot/tmb-releases"

  livecheck do
    skip "Updated by tmb's release workflow"
  end

  # tmb updates itself from its channel between sessions, so Homebrew leaves upgrades to it.
  auto_updates true

  caveats <<~EOS
    tmb-dev updates itself from the dev channel between sessions.
    Run `tmb-dev init` in a project, then start your agent program there.
  EOS
end
