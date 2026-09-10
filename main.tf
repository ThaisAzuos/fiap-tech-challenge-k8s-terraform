module "vpc" {
  source = "./modules/vpc"

  environment          = var.environment
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "eks_cluster" {
  source = "./modules/eks"

  environment          = var.environment
  cluster_name         = var.cluster_name
  eks_version          = var.eks_version
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  instance_type        = var.node_instance_type
  node_disk_size       = var.node_disk_size
  node_desired_size    = var.node_desired_size
  node_min_size        = var.node_min_size
  node_max_size        = var.node_max_size
  newrelic_license_key = var.newrelic_license_key
  kubernetes_namespace = var.kubernetes_namespace
}

module "hpa" {
  source = "./modules/hpa"

  environment               = var.environment
  cluster_endpoint          = module.eks_cluster.cluster_endpoint
  cluster_ca_data           = module.eks_cluster.cluster_certificate_authority_data
  cluster_name              = module.eks_cluster.cluster_name
  deployment_name           = "oficina-app"
  namespace                 = var.kubernetes_namespace
  min_replicas              = 2
  max_replicas              = 10
  cpu_utilization_target    = 70
  memory_utilization_target = 80

}

# --- Fase 4: namespaces por microsserviço + RabbitMQ compartilhado ---
# Ver docs/ADRs/ADR-001-namespaces-rabbitmq-mongodb.md e ADR-002-implementacao-messaging.md
module "messaging" {
  source = "./modules/messaging"

  environment             = var.environment
  cluster_endpoint        = module.eks_cluster.cluster_endpoint
  cluster_ca_data         = module.eks_cluster.cluster_certificate_authority_data
  cluster_name            = module.eks_cluster.cluster_name
  service_namespaces      = ["os-service", "billing-service", "execution-service"]
  rabbitmq_admin_password = var.rabbitmq_admin_password
}
