class Tracevault < Formula
  desc "CLI tool for AI code tracing and attribution"
  homepage "https://github.com/VirtusLab/visdom-ai-tracing-cli"
  version "0.29.7"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.7/tracevault-v0.29.7-aarch64-apple-darwin.tar.gz"
      sha256 "3346a8711cf00be57498508fddd3462bdce14cf666a15246acd2a3eb95e56e73"
    end
    on_intel do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.7/tracevault-v0.29.7-x86_64-apple-darwin.tar.gz"
      sha256 "ed12b2b64143e49a781d3375a2f2776b51105436822745288b3f3f7ff56f8e8f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.7/tracevault-v0.29.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "abf6bc67cb4d81eda5e50a563be6059f6ad61b94f01907c63d927144cdb5ae5f"
    end
    on_intel do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.7/tracevault-v0.29.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3d3f4a02db76790b4bca482d64454d8d20e4dcd3ecbfd07422b40f7fd4dd579c"
    end
  end

  def install
    bin.install "tracevault"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tracevault --version")
  end
end
