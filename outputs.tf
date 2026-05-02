output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "kubeconfig" {
  value = module.eks.kubeconfig
}

output "node_group_id" {
  value = module.eks.node_group_id
}
