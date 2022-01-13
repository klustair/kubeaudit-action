#!/usr/bin/env bash

set -o errexit

HELM_V2=2.17.0
echo "downloading helm ${HELM_V2}"
curl -sSL https://get.helm.sh/helm-v${HELM_V2}-linux-amd64.tar.gz | \
tar xz && mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64
helm version --client

HELM_V3=3.7.2
echo "downloading helm ${HELM_V3}"
curl -sSL https://get.helm.sh/helm-v${HELM_V3}-linux-amd64.tar.gz | \
tar xz && mv linux-amd64/helm /usr/local/bin/helmv3 && rm -rf linux-amd64
helmv3 version

KUBEAUDIT=0.16.0
echo "downloading kubeaudit ${KUBEAUDIT}"
curl -sSL https://github.com/Shopify/kubeaudit/releases/download/${KUBEAUDIT}/kubeaudit_${KUBEAUDIT}_linux_amd64.tar.gz | \
tar xz && mv kubeaudit /usr/local/bin/kubeaudit
kubeaudit --help