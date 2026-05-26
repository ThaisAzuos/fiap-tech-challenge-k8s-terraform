variable "environment" {
  description = "The environment name (e.g., dev, prod)."
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster API server endpoint."
  type        = string
}

variable "cluster_ca_data" {
  description = "Base64-encoded certificate authority data for the EKS cluster."
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name used for AWS CLI authentication."
  type        = string
}

variable "deployment_name" {
  description = "Name of the Kubernetes Deployment to autoscale."
  type        = string
  default     = "oficina-app"
}

variable "namespace" {
  description = "Kubernetes namespace where the Deployment lives."
  type        = string
  default     = "default"
}

variable "min_replicas" {
  description = "Minimum number of pod replicas."
  type        = number
  default     = 2
}

variable "max_replicas" {
  description = "Maximum number of pod replicas."
  type        = number
  default     = 10
}

variable "cpu_utilization_target" {
  description = "Target average CPU utilization percentage that triggers scaling."
  type        = number
  default     = 70
}

variable "memory_utilization_target" {
  description = "Target average memory utilization percentage that triggers scaling."
  type        = number
  default     = 80
}
