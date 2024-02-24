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

module "helm_release-argocd" {
  source = "../../module"

  enabled          = true

  name             = "argocd"
  description      = "The application for keeping the Pods up and running"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  chart_version    = "6.1.0"
  chart_values     = [<<EOF
global:
  image:
    repository: quay.io/argoproj/argocd
    tag: "v2.10.1"
    imagePullPolicy: Always
configs:
  cm:
    create: true
    url: https://argocd.dev.example.com
    admin.enabled: 'true'
  secret:
    createSecret: true
    annotations:
      sealedsecrets.bitnami.com/managed: "true"
server:
  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: alb
      alb.ingress.kubernetes.io/backend-protocol: HTTPS
      alb.ingress.kubernetes.io/group.name: utils-services
      # put this rule somewhere at the end
      alb.ingress.kubernetes.io/group.order: '100'
      alb.ingress.kubernetes.io/scheme: internet-facing
      alb.ingress.kubernetes.io/target-type: ip
      alb.ingress.kubernetes.io/listen-ports: |
        [{
          "HTTP": 80
        }, {
          "HTTPS": 443
        }]
      alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:eu-west-1:123456789012:certificate/d6e6679b-786d-418b-8ccd-b474ab503e61
      alb.ingress.kubernetes.io/ssl-policy: ELBSecurityPolicy-TLS-1-2-Ext-2018-06
      alb.ingress.kubernetes.io/ssl-redirect: '443'
    hosts:
      - argocd.dev.example.com
    tls:
      - hosts:
        - argocd.dev.example.com
    https: true
  metrics:
    enabled: true
applicationSet:
  enabled: true
repoServer:
  metrics:
    enabled: true
extraObjects:
  -
    apiVersion: bitnami.com/v1alpha1
    kind: SealedSecret
    metadata:
      name: argocd-gitops-repository
      namespace: argocd
    spec:
      encryptedData:
        name: <sealed-secret_value>
        sshPrivateKey: <sealed-secret_value>
        type: <sealed-secret_value>
        url: <sealed-secret_value>
      template:
        metadata:
          annotations:
            sealedsecrets.bitnami.com/managed: "true"
          labels:
            app.kubernetes.io/name: argocd-gitops-repository
            app.kubernetes.io/part-of: argocd
            argocd.argoproj.io/secret-type: repository
          name: argocd-gitops-repository
          namespace: argocd
        type: Opaque
EOF
]
}
