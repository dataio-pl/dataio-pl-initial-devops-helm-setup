# initial-devops-helm-setup

> deploy initial Helm Charts onto Kubernetes cluster

## Description

The module will give us the possibility to deploy any Helm Chart onto AWS EKS cluster.

As an example we may take [Grafana v10.3.1][grafana] on the cluster which has Helm Chart in [grafana/helm-charts][grafana-helm]

```hcl
module "grafana" {
  source = "/path/to/the/resource"

  enabled       = true

  name          = "grafana"
  description   = "An application for monitoring"
  namespace     = "utils"
  repository    = "https://grafana.github.io/helm-charts"
  chart         = "grafana/grafana"
  chart_version = "7.3.0"
  chart_values  = [<<EOF
image:
  repository: grafana/grafana
  tag: 10.3.1
  pullPolicy: IfNotPresent
EOF
}
```

[grafana]: https://grafana.com/
[grafana-helm]: https://github.com/grafana/helm-charts/tree/main/charts/grafana
