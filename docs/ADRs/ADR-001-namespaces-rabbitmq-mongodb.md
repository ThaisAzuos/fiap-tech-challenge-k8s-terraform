# ADR 001 — Namespaces por Serviço e Componentes de Plataforma (RabbitMQ, MongoDB) na Fase 4

**Status:** Aceita
**Data:** 2026-07-10
**Fase:** Tech Challenge Fase 4 — FIAP SOAT

---

## Contexto

Na Fase 3, este repositório provisionava um único cluster EKS para hospedar o monólito `fiap-tech-challenge-app`. Na Fase 4, a decomposição em microsserviços (ver ADR-005 em `fiap-tech-challenge-app`) exige isolar os três serviços de negócio, além de introduzir mensageria (RabbitMQ, ADR-006) e bancos NoSQL (MongoDB, ADR-008) para os novos serviços — mantendo tudo no mesmo cluster já existente, para não introduzir uma nova conta/infraestrutura AWS sob prazo apertado.

## Decisão

- Criar um **namespace Kubernetes por microsserviço de negócio**: `os-service`, `billing-service`, `execution-service`.
- Instalar **RabbitMQ** via Helm (chart Bitnami) em um namespace de plataforma (`messaging`), compartilhado pelos três serviços.
- Instalar **duas instâncias de MongoDB** via Helm (chart Bitnami), uma no namespace `billing-service` e outra no namespace `execution-service`, cada uma com seu próprio PVC e credenciais — nenhum MongoDB é compartilhado entre serviços.
- Cada microsserviço de negócio traz seus próprios manifestos de `Deployment`/`Service`/`ConfigMap`/`Secret` dentro do seu próprio repositório; este repositório permanece responsável apenas pela infraestrutura de cluster compartilhada (VPC, EKS, ingress, RBAC, HPA) e pelos componentes de plataforma (RabbitMQ, MongoDB) descritos acima.

## Alternativas consideradas

- **Um cluster EKS por microsserviço**: rejeitada; custo e tempo de provisionamento incompatíveis com o prazo de uma semana, sem benefício real para os objetivos do desafio.
- **RabbitMQ/MongoDB gerenciados fora do cluster (Amazon MQ, Atlas/DocumentDB)**: rejeitada por adicionar novas contas, credenciais e custos gerenciados sob prazo apertado; o Helm no cluster já existente é mais rápido de subir e operar.

## Consequências

- O cluster passa a hospedar mais cargas de trabalho (3 serviços de negócio + RabbitMQ + 2 MongoDB), exigindo atenção a *requests/limits* de recursos e ao HPA já configurado na Fase 3.
- A separação por namespace garante isolamento lógico e facilita aplicar RBAC por serviço, mas o cluster em si continua compartilhado — não é isolamento de infraestrutura física, apenas lógico.
- Credenciais de acesso ao RabbitMQ e a cada MongoDB devem ser geridas via `Secret` no namespace do respectivo serviço consumidor.
