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

module "helm_release_alb-controller" {
  source = "../../module"

  enabled          = true

  name             = "aws-load-balancer-controller"
  description      = "AWS Load Balancer controller Helm chart for Kubernetes"
  namespace        = "utils"
  create_namespace = false
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  chart_version    = "1.7.1"
  chart_values     = [<<EOF
replicaCount: 1
image:
  repository: public.ecr.aws/eks/aws-load-balancer-controller
  tag: v2.7.0
  pullPolicy: IfNotPresent
region: eu-central-1
vpcId: vpc-1234a1ab12a1a1234
clusterName: mvp-eks
serviceAccount:
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::123456789012:role/AmazonEKSLoadBalancerControllerRole
enableShield: false
enableWaf: false
enableWafv2: false
logLevel: info
watchNamespace:
EOF
]
}