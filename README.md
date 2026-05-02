# Kubernetes Infrastructure (Terraform)

## Purpose
Provisionar cluster EKS, VPC, node groups, HPA.

## Variables
- `aws_region`: us-east-1
- `cluster_name`: oficina-eks
- `node_instance_type`: t3.medium
- `desired_nodes`: 2

## Deploy
```bash
terraform init
terraform plan -var-file=envs/prod.tfvars
terraform apply -var-file=envs/prod.tfvars
```

## Cost Estimation
- EKS: $0.10/hour (~$73/mês)
- Nodes (2x t3.medium): ~$60/mês
- **Total**: ~$133/mês

## Links
- [DB Infrastructure](../fiap-tech-challenge-db-terraform)
- [App Deployment](../fiap-tech-challenge-app)
