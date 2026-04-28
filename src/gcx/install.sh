#!/bin/sh

VERSION="${VERSION:-"0.2.10"}"
ARCH="$(uname -m)"

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e "Script must be run as root."
    exit 1
fi

if [ "$(uname -s)" -ne "Linux" ]; then
    echo -e "Unsupported OS."
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

curl -LO https://github.com/grafana/gcx/releases/download/v${VERSION}/gcx_${VERSION}_linux_${ARCH}.tar.gz
sudo tar -xf gcx_${VERSION}_linux_${ARCH}.tar.gz -C /usr/local/bin
rm gcx_${VERSION}_linux_${ARCH}.tar.gz

gcx completion bash | sudo tee /etc/bash_completion.d/gcx

echo "Done!"
