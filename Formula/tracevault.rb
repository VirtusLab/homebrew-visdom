class Tracevault < Formula
  desc "CLI tool for AI code tracing and attribution"
  homepage "https://github.com/VirtusLab/visdom-ai-tracing-cli"
  version "0.29.8"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.8/tracevault-v0.29.8-aarch64-apple-darwin.tar.gz"
      sha256 "bb9dec198180947936c9502dbe4bd4764a1de4dd90dc8e256b8167a7d080213c"
    end
    on_intel do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.8/tracevault-v0.29.8-x86_64-apple-darwin.tar.gz"
      sha256 "74d43ca423c763192f498db99ef85ed7a8d35397b68b5361a8c5c5557f95a4e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.8/tracevault-v0.29.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2680fd35b064c504b0f03824a3b3071eb98be3f49c209b2fe32504c0499b4a2e"
    end
    on_intel do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.8/tracevault-v0.29.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8a0a0bb19c77eee2e882a7f9c6592353109859458a8b69b771944c4687a6efcd"
    end
  end

  def install
    bin.install "tracevault"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tracevault --version")
  end
end
