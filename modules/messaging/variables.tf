variable "environment" {
  description = "The environment name (e.g., dev, prod)."
  type        = string
}

variable "cluster_endpoint" {
  description = "The EKS cluster API endpoint."
  type        = string
}

variable "cluster_ca_data" {
  description = "The base64 encoded certificate authority data of the EKS cluster."
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster (used for aws eks get-token auth)."
  type        = string
}

variable "service_namespaces" {
  description = "Kubernetes namespaces to create, one per business microservice."
  type        = list(string)
  default     = ["os-service", "billing-service", "execution-service"]
}

variable "messaging_namespace" {
  description = "Kubernetes namespace where the shared RabbitMQ instance is installed."
  type        = string
  default     = "messaging"
}

variable "rabbitmq_chart_version" {
  description = "Version of the Bitnami RabbitMQ Helm chart to install."
  type        = string
  default     = "12.6.4"
}

variable "rabbitmq_admin_user" {
  description = "Admin username for the shared RabbitMQ instance."
  type        = string
  default     = "oficina_admin"
}

variable "rabbitmq_admin_password" {
  description = "Admin password for the shared RabbitMQ instance. Must be supplied via -var, TF_VAR_rabbitmq_admin_password or CI secret — never committed in .tfvars."
  type        = string
  sensitive   = true
}
