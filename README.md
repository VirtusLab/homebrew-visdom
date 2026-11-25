# Visdom Homebrew tap

```sh
brew install VirtusLab/visdom/visdom       # the `visdom` CLI
brew install VirtusLab/visdom/tracevault   # the `tracevault` binary, while something still calls it
```

Both come from the release archives of
[VirtusLab/visdom-ai-tracing-cli](https://github.com/VirtusLab/visdom-ai-tracing-cli). Its release
workflow sends an `update-formula` event here, and `.github/workflows/update-formula.yml` rewrites
both formulae with `scripts/update-formulae.sh`; do not edit `Formula/*.rb` by hand.

This repository was `homebrew-visdom-ai-tracing` before; the tap `VirtusLab/visdom-ai-tracing`
still resolves to it.
