terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.0.0"
    }
  }
}

provider aws {
  region = "eu-west-1"
}

provider helm {
  kubernetes {
    cluster_ca_certificate = base64decode(element(concat(data.aws_eks_cluster.cluster[*].certificate_authority.0.data, tolist([])), 0))
    host                   = element(concat(data.aws_eks_cluster.cluster[*].endpoint, tolist([])), 0)
    token                  = element(concat(data.aws_eks_cluster_auth.cluster[*].token, tolist([])), 0)
  }
}
