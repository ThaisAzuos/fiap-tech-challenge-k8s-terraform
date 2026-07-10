aws_region = "us-east-1"
environment = "dev"
cluster_name = "oficina-eks-dev"
node_instance_type = "t3.medium"
desired_nodes = 2

# Fase 4: NAO adicionar rabbitmq_admin_password aqui.
# Forneca via: export TF_VAR_rabbitmq_admin_password="<segredo>"
# ou como secret na pipeline de CI/CD.
