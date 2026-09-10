variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "eks_version" {
  description = "The Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.28"
}

variable "node_instance_type" {
  description = "The instance type for the EKS worker nodes."
  type        = string
  default     = "t3.medium"
}

variable "node_disk_size" {
  description = "The disk size for the EKS worker nodes."
  type        = number
  default     = 20
}

variable "node_desired_size" {
  description = "The desired number of worker nodes."
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "The minimum number of worker nodes."
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "The maximum number of worker nodes."
  type        = number
  default     = 10
}

variable "newrelic_license_key" {
  description = "New Relic License Key for Infrastructure Agent."
  type        = string
  sensitive   = true
}

variable "kubernetes_namespace" {
  description = "The Kubernetes namespace where New Relic DaemonSet will be deployed."
  type        = string
  default     = "default"
}

# --- Fase 4: mensageria ---
variable "rabbitmq_admin_password" {
  description = "Admin password for the shared RabbitMQ instance (Fase 4). Supply via TF_VAR_rabbitmq_admin_password or CI secret — never commit a value in .tfvars."
  type        = string
  sensitive   = true
}
