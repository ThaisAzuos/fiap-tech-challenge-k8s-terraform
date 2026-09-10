output "vpc_id" {
  description = "The ID of the VPC created."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "A list of public subnet IDs created."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "A list of private subnet IDs created."
  value       = module.vpc.private_subnet_ids
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = module.eks_cluster.cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster."
  value       = module.eks_cluster.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with your cluster."
  value       = module.eks_cluster.cluster_certificate_authority_data
}

# --- Fase 4: mensageria ---
output "service_namespaces" {
  description = "Namespaces criados para os microsserviços de negócio."
  value       = module.messaging.service_namespaces
}

output "rabbitmq_internal_host" {
  description = "Hostname interno do RabbitMQ compartilhado, para uso pelos microsserviços."
  value       = module.messaging.rabbitmq_internal_host
}
