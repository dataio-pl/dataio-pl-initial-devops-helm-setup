#
# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
# A Release is an instance of a chart running in a Kubernetes cluster
#
resource "helm_release" "this" {
  count = var.enabled ? 1 : 0

  name             = var.name
  description      = var.description
  create_namespace = var.create_namespace
  namespace        = var.namespace
  repository       = var.repository
  chart            = var.chart
  version          = var.chart_version
  atomic           = var.atomic
  wait             = var.wait

  values = var.chart_values

  dynamic "set" {
    for_each = length(keys(var.set)) == 0 ? [] : [var.set]

    content {
      name  = lookup(set.values, "name", null)
      value = lookup(set.values, "value", null)
      type  = lookup(set.values, "type", "auto")
    }
  }

  dynamic "set_sensitive" {
    for_each = length(keys(var.set_sensitive)) == 0 ? [] : [var.set_sensitive]

    content {
      name  = lookup(set_sensitive.values, "name", null)
      value = lookup(set_sensitive.values, "value", null)
      type  = lookup(set_sensitive.values, "type", "auto")
    }
  }
}
