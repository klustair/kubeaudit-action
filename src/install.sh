#!/usr/bin/env bash

set -o errexit

# Preinstalled versions of helm and kubeaudit
HELMV2_VER=2.17.0
echo "downloading helm ${HELMV2_VER}"
curl -sSL https://get.helm.sh/helm-v${HELMV2_VER}-linux-amd64.tar.gz | \
tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64
helm version --client

HELMV3_VER=3.7.2
echo "downloading helm ${HELMV3_VER}"
curl -sSL https://get.helm.sh/helm-v${HELMV3_VER}-linux-amd64.tar.gz | \
tar xz && mv linux-amd64/helm /usr/local/bin/helmv3 && rm -rf linux-amd64
helmv3 version

KUBEAUDIT_VER=0.16.0
echo "downloading kubeaudit ${KUBEAUDIT_VER}"
curl -sSL https://github.com/Shopify/kubeaudit/releases/download/${KUBEAUDIT_VER}/kubeaudit_${KUBEAUDIT_VER}_linux_amd64.tar.gz | \
tar xz && mv kubeaudit /usr/local/bin/kubeaudit
kubeaudit --help