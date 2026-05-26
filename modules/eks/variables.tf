variable "environment" {
  description = "The environment name (e.g., dev, prod)."
  type        = string
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

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed."
  type        = string
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "instance_type" {
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
