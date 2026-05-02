resource "aws_eks_cluster" "oficina" {
  name            = "oficina-eks-${var.environment}"
  version         = "1.28"
  role_arn        = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
  ]

  tags = {
    Environment = var.environment
  }
}

resource "aws_eks_node_group" "workers" {
  cluster_name    = aws_eks_cluster.oficina.name
  node_group_name = "oficina-workers-${var.environment}"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 2
  }

  instance_types = ["t3.medium"]

  tags = {
    Environment = var.environment
  }
}
