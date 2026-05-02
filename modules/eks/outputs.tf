output "cluster_endpoint" {
  value = aws_eks_cluster.oficina.endpoint
}

output "cluster_arn" {
  value = aws_eks_cluster.oficina.arn
}

output "kubeconfig" {
  value = {
    cluster_name       = aws_eks_cluster.oficina.name
    endpoint           = aws_eks_cluster.oficina.endpoint
    certificate_authority_data = aws_eks_cluster.oficina.certificate_authority[0].data
  }
}

output "node_group_id" {
  value = aws_eks_node_group.workers.id
}
