data "aws_iam_role" "lab_role" {
  name = "LabRole"
}

resource "aws_eks_cluster" "oficina" {
  name     = var.cluster_name
  version  = var.eks_version
  role_arn = data.aws_iam_role.lab_role.arn

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = { Environment = var.environment }
}

resource "aws_eks_node_group" "workers" {
  cluster_name    = aws_eks_cluster.oficina.name
  node_group_name = "oficina-workers-${var.environment}"
  node_role_arn   = data.aws_iam_role.lab_role.arn
  subnet_ids      = var.private_subnet_ids
  instance_types  = [var.instance_type]
  disk_size       = var.node_disk_size

  scaling_config {
    desired_size = var.node_desired_size
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  tags = { Environment = var.environment }
}
