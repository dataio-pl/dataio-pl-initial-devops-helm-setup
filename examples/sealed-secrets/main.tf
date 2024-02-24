locals {
  cluster_name = "eks-cluster"
}

#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster
# Retrieve information about an EKS Cluster
#
data "aws_eks_cluster" "cluster" {
  name = local.cluster_name
}

#
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth
# Get an authentication token to communicate with an EKS cluster
#
data "aws_eks_cluster_auth" "cluster" {
  name = local.cluster_name
}

module "helm_release_sealed-secrets" {
  source = "../../module"

  enabled = true

  name             = "sealed-secrets"
  description      = "The application for sealing the secrets"
  create_namespace = false # it will be created by the Helm Chart
  namespace        = "utils"
  repository       = "https://bitnami-labs.github.io/sealed-secrets"
  chart            = "sealed-secrets"
  chart_version    = "2.14.2"
  chart_values     = [<<EOF
fullnameOverride: sealed-secrets-controller
image:
  registry: docker.io
  repository: bitnami/sealed-secrets-controller
  tag: v0.25.0
ingress:
  enabled: false
EOF
]
}