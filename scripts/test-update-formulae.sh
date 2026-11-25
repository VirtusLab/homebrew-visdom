#!/usr/bin/env bash
# Tests scripts/update-formulae.sh on a copy, so the real formulae are untouched.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
mkdir -p "$work/scripts" "$work/Formula"
cp "$here/update-formulae.sh" "$work/scripts/"

a="$(printf 'a%.0s' {1..64})"
b="$(printf 'b%.0s' {1..64})"
c="$(printf 'c%.0s' {1..64})"
d="$(printf 'd%.0s' {1..64})"

run() {
  env -i PATH="$PATH" TAG=v0.29.7 VERSION=0.29.7 \
    SHA_AARCH64_DARWIN="$a" SHA_X86_64_DARWIN="$b" SHA_X86_64_LINUX="$c" SHA_AARCH64_LINUX="$d" \
    "$@" "$work/scripts/update-formulae.sh"
}

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

has() {
  grep -qF -- "$2" "$work/Formula/$1" || fail "$1 lacks: $2"
}

# Each formula carries its own version and installs its own binary from the same archives.
run VISDOM_VERSION=1.1.0
has tracevault.rb 'class Tracevault < Formula'
has tracevault.rb 'version "0.29.7"'
has tracevault.rb 'bin.install "tracevault"'
has visdom.rb 'class Visdom < Formula'
has visdom.rb 'version "1.1.0"'
has visdom.rb 'bin.install "visdom"'
has visdom.rb 'shell_output("#{bin}/visdom --version")'
for formula in tracevault.rb visdom.rb; do
  has "$formula" "releases/download/v0.29.7/tracevault-v0.29.7-aarch64-apple-darwin.tar.gz\"
      sha256 \"$a\""
  has "$formula" "tracevault-v0.29.7-x86_64-apple-darwin.tar.gz"
  has "$formula" "tracevault-v0.29.7-aarch64-unknown-linux-gnu.tar.gz"
  has "$formula" "tracevault-v0.29.7-x86_64-unknown-linux-gnu.tar.gz"
  for sha in "$a" "$b" "$c" "$d"; do has "$formula" "sha256 \"$sha\""; done
done

# A dispatch from before `visdom_version` updates tracevault and leaves visdom alone.
before="$(cat "$work/Formula/visdom.rb")"
run TAG=v0.29.8 VERSION=0.29.8 2>/dev/null
has tracevault.rb 'version "0.29.8"'
[ "$(cat "$work/Formula/visdom.rb")" = "$before" ] || fail "visdom.rb changed without VISDOM_VERSION"

# Malformed input fails before either formula is written.
snapshot() { cat "$work"/Formula/*.rb; }
before="$(snapshot)"
refused() {
  if run "$@" 2>/dev/null; then fail "accepted: $*"; fi
  [ "$(snapshot)" = "$before" ] || fail "formulae changed by refused input: $*"
}
refused TAG='v1; id'
refused TAG='v1"x'
refused VERSION='$(id)'
refused VERSION=
refused VISDOM_VERSION='1.1.0"; system("id")'
refused SHA_X86_64_LINUX=abc
refused SHA_AARCH64_DARWIN="${a}0"

echo "ok"
