resource "azurerm_resource_group" "node_resource_group" {
  name     = "{var.resources_prefix}-rg"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "{var.resources_prefix}-cluster"
  location            = var.location
  resource_group_name = azurerm_resource_group.node_resource_group.name
  dns_prefix          = azurerm_resource_group.node_resource_group.location
  kubernetes_version  = var.kubernetes_version

  sku_tier = free

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
  }

  default_node_pool {
    name                 = "systempool"
    vm_size              = var.system_node_pool_settings.size
    auto_scaling_enabled = true
    node_count           = 1
    min_count            = var.system_node_pool_settings.min_count
    max_count            = var.system_node_pool_settings.max_count
    os_disk_type         = "Ephemeral"
    kubelet_disk_type    = "OS"

    zones                        = [1, 2, 3]
    only_critical_addons_enabled = true
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"
    network_dataplane   = "azure"
    load_balancer_sku   = "Standard"

    load_balancer_profile {
      managed_outbound_ips {
        count = 1
      }
    }

    pod_cidr       = "10.244.0.0/16"
    service_cidr   = "10.0.0.0/16"
    dns_service_ip = "10.0.0.10"
    outbound_type  = "loadBalancer"

    pod_cidrs     = ["10.244.0.0/16"]
    service_cidrs = ["10.0.0.0/16"]
  }

  identity {
    type = SystemAssigned
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "model_training_node_pool" {
  name                  = "trainingpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = var.model_training_node_pool_settings.size
  node_count            = 1
  min_count             = var.model_training_node_pool_settings.min_count
  max_count             = var.model_training_node_pool_settings.max_count
    
  node_labels = {
    "mlops_role" = "training"
  }
  
  node_taints = [
    "mlops_role=training:NoSchedule"
  ]
}

resource "azurerm_kubernetes_cluster_node_pool" "model_serving_node_pool" {
  name                  = "servingpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = var.model_serving_node_pool_settings.size
  node_count            = 1
  min_count             = var.model_serving_node_pool_settings.min_count
  max_count             = var.model_serving_node_pool_settings.max_count

  node_labels = {
    "mlops_role" = "serving"
  }
  
  node_taints = [
    "mlops_role=serving:NoSchedule"
  ]
}
