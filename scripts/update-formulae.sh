#!/usr/bin/env bash
# Writes Formula/tracevault.rb and Formula/visdom.rb for one release of
# VirtusLab/visdom-ai-tracing-cli. Both binaries ship in the same archives,
# named after `tracevault`'s version; `visdom` has a version of its own.
#
# Input (environment): TAG, VERSION, SHA_AARCH64_DARWIN, SHA_X86_64_DARWIN,
# SHA_X86_64_LINUX, SHA_AARCH64_LINUX, and VISDOM_VERSION. Without
# VISDOM_VERSION (a release workflow from before it was sent) the `visdom`
# formula is left as it is.
set -euo pipefail

fail() {
  echo "update-formulae: $1" >&2
  exit 1
}

version_re='^[0-9]+\.[0-9]+\.[0-9]+([-+][0-9A-Za-z.-]+)?$'
tag_re='^[0-9A-Za-z._-]+$'
sha_re='^[0-9a-f]{64}$'

[[ "${TAG:-}" =~ $tag_re ]] || fail "TAG is not a tag name: '${TAG:-}'"
[[ "${VERSION:-}" =~ $version_re ]] || fail "VERSION is not a version: '${VERSION:-}'"
for name in SHA_AARCH64_DARWIN SHA_X86_64_DARWIN SHA_X86_64_LINUX SHA_AARCH64_LINUX; do
  [[ "${!name:-}" =~ $sha_re ]] || fail "$name is not a SHA-256: '${!name:-}'"
done
if [[ -n "${VISDOM_VERSION:-}" ]]; then
  [[ "$VISDOM_VERSION" =~ $version_re ]] || fail "VISDOM_VERSION is not a version: '$VISDOM_VERSION'"
fi

base="https://github.com/VirtusLab/visdom-ai-tracing-cli/releases/download/${TAG}/tracevault-${TAG}"

# write_formula <class> <binary> <version> <description>
write_formula() {
  cat > "Formula/$2.rb" << FORMULA
class $1 < Formula
  desc "$4"
  homepage "https://github.com/VirtusLab/visdom-ai-tracing-cli"
  version "$3"
  license :cannot_represent

  on_macos do
    on_arm do
      url "${base}-aarch64-apple-darwin.tar.gz"
      sha256 "${SHA_AARCH64_DARWIN}"
    end
    on_intel do
      url "${base}-x86_64-apple-darwin.tar.gz"
      sha256 "${SHA_X86_64_DARWIN}"
    end
  end

  on_linux do
    on_arm do
      url "${base}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "${SHA_AARCH64_LINUX}"
    end
    on_intel do
      url "${base}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "${SHA_X86_64_LINUX}"
    end
  end

  def install
    bin.install "$2"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/$2 --version")
  end
end
FORMULA
}

cd "$(dirname "$0")/.."
write_formula Tracevault tracevault "$VERSION" "CLI tool for AI code tracing and attribution"
if [[ -n "${VISDOM_VERSION:-}" ]]; then
  write_formula Visdom visdom "$VISDOM_VERSION" "Developer CLI for the Visdom suite"
else
  echo "update-formulae: no VISDOM_VERSION; Formula/visdom.rb left as it is" >&2
fi
