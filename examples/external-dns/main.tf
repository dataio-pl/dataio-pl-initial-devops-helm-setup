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

module "helm_release_external-dns" {
  source = "../../module"

  enabled          = true

  name             = "external-dns"
  description      = "Configure external DNS settings"
  namespace        = "utils"
  create_namespace = false
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "external-dns"
  chart_version    = "6.32.1"
  chart_values     = [<<EOF
annotationFilter: alb.ingress.kubernetes.io/scheme=internet-facing
domainFilters:
  - example.com
serviceAccount:
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::123456789012:role/AWSExternalDnsIAMRole
image:
  registry: docker.io
  repository: bitnami/external-dns
  tag: 0.14.0
  pullPolicy: Always
replicas: 1
logLevel: info
interval: 1m
provider: aws
policy: upsert-only
aws:
  region: eu-central-1
  zoneType: public
registry: txt
txtOwnerId: example-com
metrics:
  enabled: true
resources:
  requests:
    cpu: 15m
    memory: 105M
  limits:
    cpu: 15m
    memory: 105M
EOF
]
}