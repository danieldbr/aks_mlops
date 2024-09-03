# AKS Cluster for MLOps
Use case of AKS delivering scalable infrastructure for machine learning tasks.

## Scenario
MLOps process needs to deploy containers for:
1. Model training restricted to internal network.
2. Model serving accessible over the internet.

## AKS Architecture
#### Control Plane
- Single cluster
- Private cluster (Azure Private Link service)
- 3 availability zones

#### Node Pools
- 3 node pools provided by VMSS 
  - 1 system node pool (taint with `CriticalAddonsOnly=true:NoSchedule`)
  - 1 user node pool for model training (taint for model training)
  - 1 user node pool for model serving (taint for model serving)

#### Network
- Azure CNI Overlay

#### Security Features
- 2 custom namespaces
  - `model-training`
  - `model-serving`
- Network Policies
- Azure Key Vault
- Microsoft Entra ID authentication with Azure RBAC
 - `Azure Kubernetes Service RBAC Cluster Admin`
 - (role for CI/CD)

#### Deployments
- 2 deployments
  - `model-training-deployment`
  - `model-serving-deployment`

#### Autoscale
- VPA
- HPA
- Cluster autoscaler

#### Configuration Management
- Terraform 

#### CICD
- GitHub Actions
  - Terraform
  - Kubernetes Manifests

#### Components to be defined
- Subnets
- Ingress
- Egress
- Monitoring
- Updates
- Backup
