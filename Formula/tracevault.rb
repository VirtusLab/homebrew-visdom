class Tracevault < Formula
  desc "CLI tool for AI code tracing and attribution"
  homepage "https://github.com/VirtusLab/visdom-ai-tracing-cli"
  version "0.29.9"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.9/tracevault-v0.29.9-aarch64-apple-darwin.tar.gz"
      sha256 "c6c13f30640365d434d7912e61e1fc6f902f00de2d91ad6c1e5fe41de32239e0"
    end
    on_intel do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.9/tracevault-v0.29.9-x86_64-apple-darwin.tar.gz"
      sha256 "7bce86edf58163c2af03b02ef0be983b82349b3e7408687d2ae9848c75c7d1a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.9/tracevault-v0.29.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "85a0232c4e99f8e32c31b3729ab2597b2534f9c41c04bf880341a28221922ed1"
    end
    on_intel do
      url "https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/v0.29.9/tracevault-v0.29.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "49b7530398a83e6b75869ed39f61e085a4a27d1a203cd2b1b73b3ba9840a83de"
    end
  end

  def install
    bin.install "tracevault"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tracevault --version")
  end
end
