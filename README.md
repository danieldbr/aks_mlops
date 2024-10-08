# AKS Cluster for MLOps
Use case of AKS delivering scalable infrastructure for machine learning tasks.

## Scenario
The MLOps process needs to deploy containers for:
1. Model training restricted to the internal network.
2. Model serving accessible over the internet.

## AKS Architecture
#### Control Plane
- Single cluster.
- Private cluster (Azure Private Link service).
- 3 availability zones.

#### Node Pools
4 VMSS node pools:
  - 1 system node pool (tainted with `CriticalAddonsOnly=true:NoSchedule`) in 3 availability zones.
  - 1 user node pool for GitHub self-hosted runners in 1 availability zone.
  - 1 user node pool for model training in 1 availability zone.
  - 1 user node pool for model serving in 3 availability zones.

#### Network
- Azure CNI Overlay.

#### Security Features
- Namespaces.
- Network policies.
- Azure Key Vault.
- Microsoft Entra ID authentication with Azure RBAC.

#### Deployments
- 3 deployments.

#### Autoscale
- VPA.
- HPA.
- Cluster autoscaler.

#### Configuration Management
- Terraform.

#### CICD
- GitHub Actions.
  - Terraform.
  - Kubernetes Manifests.

#### Components to be defined
- Subnets.
- Ingress.
- Egress.
- Monitoring.
- Updates.
