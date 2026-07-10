output "service_namespaces" {
  description = "Namespaces criados, um por microsserviço de negócio."
  value       = [for ns in kubernetes_namespace.service : ns.metadata[0].name]
}

output "messaging_namespace" {
  description = "Namespace onde o RabbitMQ compartilhado foi instalado."
  value       = kubernetes_namespace.messaging.metadata[0].name
}

output "rabbitmq_release_name" {
  description = "Nome do Helm release do RabbitMQ."
  value       = helm_release.rabbitmq.name
}

output "rabbitmq_internal_host" {
  description = "Hostname interno (DNS do cluster) do RabbitMQ, para uso pelos microsserviços via Spring AMQP."
  value       = "rabbitmq.${kubernetes_namespace.messaging.metadata[0].name}.svc.cluster.local"
}
