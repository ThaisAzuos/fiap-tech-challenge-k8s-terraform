# ADR 002 — Implementação de Namespaces e RabbitMQ via Terraform + Helm

**Status:** Aceita
**Data:** 2026-07-11
**Fase:** Tech Challenge Fase 4 — FIAP SOAT

---

## Contexto

A ADR-001 deste repositório definiu que namespaces por serviço e RabbitMQ seriam adicionados ao cluster EKS já existente. Esta ADR registra a implementação concreta e corrige um ponto que ficou ambíguo na ADR-001: onde vive o MongoDB de cada serviço.

## Decisão

1. Criado o módulo `modules/messaging/`, com:
   - Um `kubernetes_namespace` por microsserviço de negócio: `os-service`, `billing-service`, `execution-service`.
   - Um namespace de plataforma `messaging`, onde é instalado o Helm release do RabbitMQ (chart Bitnami, réplica única, com persistência de 2Gi — dimensionamento mínimo compatível com o ambiente AWS Academy).
   - Provider `helm` configurado com o mesmo mecanismo de autenticação já usado pelo provider `kubernetes` nos demais módulos (`aws eks get-token`).
2. **Correção em relação à ADR-001**: o MongoDB de cada serviço (Billing e Execution) **não** é provisionado por este repositório. Cada um desses serviços traz seu próprio Helm release de MongoDB dentro do seu próprio repositório (`fiap-tech-challenge-billing-service`, `fiap-tech-challenge-execution-service`), aplicado ao namespace correspondente já criado aqui. Isso está mais alinhado ao requisito do desafio de que cada microsserviço tenha "seu próprio repositório, infraestrutura e banco de dados".
3. A senha de administrador do RabbitMQ (`rabbitmq_admin_password`) é uma variável sensível, sem valor padrão, fornecida via `TF_VAR_rabbitmq_admin_password` ou secret de CI — nunca commitada em `.tfvars`.

## Alternativas consideradas

- **Manter o MongoDB neste repositório** (conforme redação original da ADR-001): reavaliado e revertido nesta ADR, pois centralizar os bancos NoSQL aqui misturaria a infraestrutura de dados de serviços de negócio diferentes em um único repositório de infraestrutura, indo na direção oposta à independência de repositório/infra/banco exigida pelo desafio.

## Consequências

- Para aplicar: `terraform apply -var-file=envs/dev.tfvars -var="rabbitmq_admin_password=<segredo>"` (ou equivalente na pipeline de CI/CD).
- Os 3 namespaces e o RabbitMQ precisam existir **antes** que os manifestos de cada microsserviço de negócio sejam aplicados (dependência de ordem entre repositórios/pipelines).
- Credenciais do RabbitMQ devem ser distribuídas aos 3 serviços consumidores via `Secret` do Kubernetes em cada namespace (fora do escopo deste Terraform; ver manifestos de cada serviço).
