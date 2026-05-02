module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source = "./modules/eks"
}

module "hpa" {
  source = "./modules/hpa"
}

module "rbac" {
  source = "./modules/rbac"
}
