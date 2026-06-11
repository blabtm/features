#!/bin/bash

VERSION="${VERSION:-"latest"}"
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

curl -LO https://github.com/redpanda-data/redpanda/releases/${VERSION}/download/rpk-linux-${ARCH}.zip
unzip rpk-linux-${ARCH}.zip -d /usr/local/bin
rm rpk-linux-${ARCH}.zip

echo "Done!"
