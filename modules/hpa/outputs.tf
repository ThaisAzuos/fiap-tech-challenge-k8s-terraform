output "hpa_name" {
  description = "The name of the HorizontalPodAutoscaler resource."
  value       = kubernetes_horizontal_pod_autoscaler_v2.app.metadata[0].name
}
