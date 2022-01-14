#!/usr/bin/env bash

set -e
set -o pipefail

PATH=${1}
KUBEAUDIT_COMMANDS=${2:-all}
HELM=${3:-3}
KUBEAUDIT_FORMAT=${4}
KUBEAUDIT_MINSEVERITY=${5}
KUBEAUDIT_INCLUDEGENEREATED=${6}
KUBEAUDIT_VER=${7}
HELMV2_VER=${8}
HELMV3_VER=${9}
IFS=","

if [[ "${HELMV2_VER}" != "" ]]; then
  curl -sL https://get.helm.sh/helm-v${HELMV2_VER}-linux-amd64.tar.gz | \
  tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64
fi

if [[ "${HELMV3_VER}" != "" ]]; then
  curl -sL https://get.helm.sh/helm-v${HELM_VER}-linux-amd64.tar.gz | \
  tar xz && mv linux-amd64/helmv3 /usr/local/bin/helm && rm -rf linux-amd64
fi

if [[ "${KUBEAUDIT_VER}" != "" ]]; then
  curl -sSL https://github.com/Shopify/kubeaudit/releases/download/${KUBEAUDIT_VER}/kubeaudit_${KUBEAUDIT_VER}_linux_amd64.tar.gz | \
  tar xz && mv kubeaudit /usr/local/bin/kubeaudit
fi


if [[ "${KUBEAUDIT_COMMANDS}" == "" ]]; then
  echo "No commands provided"
  exit 1
fi

if [[ "${PATH}" == "" ]]; then
  echo "No path provided"
  exit 1
fi

HELM_CMD=/usr/local/bin/helmv3
if [[ "${HELM}" == "2" ]]; then
  HELM_CMD=/usr/local/bin/helm
fi

if [[ "${KUBEAUDIT_FORMAT}" != "" ]]; then
  KUBEAUDIT_FORMAT="-p ${KUBEAUDIT_FORMAT}"
fi

if [[ "${KUBEAUDIT_MINSEVERITY}" != "" ]]; then
  KUBEAUDIT_MINSEVERITY="-m ${KUBEAUDIT_MINSEVERITY}"
fi

if [[ "${KUBEAUDIT_INCLUDEGENEREATED}" == "true" ]]; then
  KUBEAUDIT_INCLUDEGENEREATED="--includegenerated"
fi

${HELM_CMD} template ${PATH} > manifest.yaml

for command in ${KUBEAUDIT_COMMANDS}; do
  echo ">>> Executing kubeaudit command ${command}"
  /usr/local/bin/kubeaudit ${command} ${KUBEAUDIT_INCLUDEGENEREATED} ${KUBEAUDIT_FORMAT} ${KUBEAUDIT_MINSEVERITY} -f manifest.yaml
done
