# Namespaces por microsserviço de negócio + RabbitMQ compartilhado (Fase 4)
# Ver docs/ADRs/ADR-001-namespaces-rabbitmq-mongodb.md e ADR-002-implementacao-messaging.md

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
  }
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_ca_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    }
  }
}

# Um namespace por microsserviço de negócio (OS Service, Billing Service, Execution Service).
# Cada serviço aplica seus próprios manifestos de Deployment/Service dentro do seu namespace,
# a partir do seu próprio repositório e pipeline de CI/CD.
resource "kubernetes_namespace" "service" {
  for_each = toset(var.service_namespaces)

  metadata {
    name = each.value
    labels = {
      environment    = var.environment
      "tech-challenge/fase" = "4"
      "tech-challenge/tipo" = "microsservico"
    }
  }
}

# Namespace de plataforma para componentes compartilhados (mensageria).
resource "kubernetes_namespace" "messaging" {
  metadata {
    name = var.messaging_namespace
    labels = {
      environment    = var.environment
      "tech-challenge/fase" = "4"
      "tech-challenge/tipo" = "plataforma"
    }
  }
}

# RabbitMQ compartilhado pelos 3 microsserviços de negócio (ver ADR-006 em fiap-tech-challenge-app).
# Réplica única por simplicidade e custo (AWS Academy) — não é um requisito de alta disponibilidade do desafio.
resource "helm_release" "rabbitmq" {
  name       = "rabbitmq"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "rabbitmq"
  version    = var.rabbitmq_chart_version
  namespace  = kubernetes_namespace.messaging.metadata[0].name

  set {
    name  = "auth.username"
    value = var.rabbitmq_admin_user
  }

  set_sensitive {
    name  = "auth.password"
    value = var.rabbitmq_admin_password
  }

  set {
    name  = "replicaCount"
    value = "1"
  }

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "persistence.size"
    value = "2Gi"
  }

  # Habilita o plugin de management (UI web + API), útil para depurar filas/exchanges
  # durante o desenvolvimento e a gravação do vídeo de demonstração.
  set {
    name  = "metrics.enabled"
    value = "false"
  }
}
