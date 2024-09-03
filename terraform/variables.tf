variable "resources_prefix" {
  description = "Prefix for naming resources."
  type        = string
}

variable "location" {
  description = "The location where the resources will be created."
  type        = string
}

variable "dns" {
  description = "DNS prefix for the cluster resources"
  type        = string
  default     = var.resources_prefix
}

variable "kubernetes_version" {
  description = "Kubernetes version."
  type        = string
  default     = "1.30.3"
}

variable "system_node_pool_settings" {
  description = "Configuration for the system node pool."
  type = map(object({
    vm_size   = string
    min_count = number
    max_count = number
  }))
}

variable "model_training_node_pool_settings" {
  description = "Configuration for model training node pool."
  type = map(object({
    vm_size   = string
    min_count = number
    max_count = number
  }))
}

variable "model_serving_node_pool_settings" {
  description = "Configuration for model serving node pool."
  type = map(object({
    vm_size   = string
    min_count = number
    max_count = number
  }))
}
