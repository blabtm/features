#!/bin/bash

VERSION="${VERSION:-"0.16.1"}"
ARCH="$(uname -m)"

set -e

if [[ "$(id -u)" -ne 0 ]]; then
    echo "Script must be run as root."
    exit 1
fi

if [[ "$(uname -s)" != "Linux" ]]; then
    echo "Unsupported OS."
    exit 1
fi

case "${ARCH}" in
"x86_64")
  ARCH="amd64"
  ;;
"arm64" | "aarch64")
  ARCH="arm64"
  ;;
*)
  echo "Unsupported architecture."
  exit 1
  ;;
esac

curl -LO https://github.com/cue-lang/cue/releases/download/v${VERSION}/cue_v${VERSION}_linux_${ARCH}.tar.gz
sudo tar -xf cue_v${VERSION}_linux_${ARCH}.tar.gz -C /usr/local/bin
rm cue_v${VERSION}_linux_${ARCH}.tar.gz

cue completion bash | sudo tee /etc/bash_completion.d/cue

echo "Done!"
