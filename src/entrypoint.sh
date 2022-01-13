#!/usr/bin/env bash

set -e
set -o pipefail

KUBEAUDIT_COMMANDS=${1:-all}
PATH=${2}
HELM_VER${3}
KUBEAUDIT_VER=${4}
KUBEAUDIT_INCLUDEGENEREATED=${5}
KUBEAUDIT_FORMAT=${6}
KUBEAUDIT_MINSEVERITY=${7}

if [[ "${HELM_VER}" != "" ]]; then
  curl -sL https://get.helm.sh/helm-v${HELM_VER}-linux-amd64.tar.gz | \
  tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64
fi

if [[ "${KUBEAUDIT_VER}" != "" ]]; then
  curl -sSL https://github.com/Shopify/kubeaudit/releases/download/${KUBEAUDIT_VER}/kubeaudit_${KUBEAUDIT_VER}_linux_amd64.tar.gz | \
  tar xz && mv kubeaudit /usr/local/bin/kubeaudit
fi

echo ">>> Executing command <<<"
if [[ "${PATH}" == "" ]]; then
  echo "No path provided"
  exit 1
fi

if [[ "${COMMANDS}" == "" ]]; then
  echo "No commands provided"
  exit 1
fi

if [[ "${KUBEAUDIT_INCLUDEGENEREATED}" != "" ]]; then
  KUBEAUDIT_INCLUDEGENEREATED="--includegenerated"
fi

if [[ "${KUBEAUDIT_FORMAT}" != "" ]]; then
  KUBEAUDIT_FORMAT="--format ${KUBEAUDIT_FORMAT}"
fi

if [[ "${KUBEAUDIT_MINSEVERITY}" != "" ]]; then
  KUBEAUDIT_MINSEVERITY="--minseverity ${KUBEAUDIT_MINSEVERITY}"
fi

bash -c "
set -e;
set -o pipefail; 
helm template ${PATH} > manifest.yaml
kubeaudit ${KUBEAUDIT_COMMANDS} ${KUBEAUDIT_INCLUDEGENEREATED} ${KUBEAUDIT_FORMAT} ${KUBEAUDIT_MINSEVERITY} -f manifest.yaml
"