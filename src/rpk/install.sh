#!/bin/sh

VERSION="${VERSION:-"latest"}"
ARCH="$(uname -m)"

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e "Script must be run as root."
    exit 1
fi

if [ "${ARCH}" = "x86_64" ]; then
  ARCH="amd64"
elif [[ "${ARCH}" = "arm64" || "${ARCH}" = "aarch64" ]]; then
  ARCH="arm64"
else
  echo -e "Unsupported architecture."
  exit 1
fi

curl -LO https://github.com/redpanda-data/redpanda/releases/${VERSION}/download/rpk-linux-${ARCH}.zip
unzip rpk-linux-${ARCH}.zip -d /usr/local/bin
rm rpk-linux-${ARCH}.zip

echo "Done!"
