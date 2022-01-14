# kubeaudit-action

![GitHub License MIT](https://img.shields.io/github/license/klustair/kubeaudit-action?style=flat-square)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/klustair/kubeaudit-action?style=flat-square)


Action to run [Kubeaudit](hhttps://github.com/Shopify/kubeaudit) on a helm chart repository.

Some parts of this action are based on https://github.com/stefanprodan/kube-tools. Have a look if you need a more general kubernetes-tools setup action. 

## Minimal configuration
```yaml
    steps:
    - uses: actions/checkout@v2
    - name: run kubeaudit
      uses: klustair/kubeaudit-action@v1.0
      with:
        path: 'charts'
        kubeauditCommands: 'image,rootfs,limits'
        helmVersion: '3'
```

## Full configuration
```yaml
    steps:
    - uses: actions/checkout@v2
    - name: run kubeaudit
      uses: klustair/kubeaudit-action@v1.0
        with:
            path: 'charts'
            kubeauditCommands: 'image,rootfs,limits'
            helmVersion: '3'
            kubeauditFormat: 'pretty'
            kubeauditMinseverity: 'medium'
            kubeauditIncludegenerated: 'true'
            kubeauditVersion: '0.16.0'
            helmV3Version: '3.7.2'

            
