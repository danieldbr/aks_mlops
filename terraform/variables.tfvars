resources_prefix   = "mlservices"
location           = "canadacentral"
kubernetes_version = "1.30.3"

system_node_pool_settings = {
  vm_size   = "Standard_B2s"
  min_count = 1
  max_count = 2
}

model_training_node_pool_settings = {
  vm_size   = "Standard_B2s"
  min_count = 1
  max_count = 2
}

model_serving_node_pool_settings = {
  vm_size   = "Standard_B2s"
  min_count = 1
  max_count = 2
}
