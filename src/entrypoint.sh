#!/usr/bin/env bash

set -e
set -o pipefail

HELM_VER=${3}
if [[ "${HELM_VER}" != "" ]]; then
  curl -sL https://get.helm.sh/helm-v${HELM_VER}-linux-amd64.tar.gz | \
  tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64
fi

HELM3_VER=${4}
if [[ "${HELM3_VER}" != "" ]]; then
  curl -sL https://get.helm.sh/helm-v${HELM3_VER}-linux-amd64.tar.gz | \
  tar xz && mv linux-amd64/helm /usr/local/bin/helmv3 && rm -rf linux-amd64
fi

KUBEAUDIT_VER=${5}
if [[ "${HELM3_VER}" != "" ]]; then
  curl -sSL https://github.com/Shopify/kubeaudit/releases/download/${KUBEAUDIT_VER}/kubeaudit_${KUBEAUDIT_VER}_linux_amd64.tar.gz | \
  tar xz && mv kubeaudit /usr/local/bin/kubeaudit
fi

echo ">>> Executing command <<<"

bash -c "set -e;  set -o pipefail; helm template ${1} > manifest.yaml | kubeaudit ${2} -f manifest.yaml"