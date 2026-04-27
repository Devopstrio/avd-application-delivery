# Devopstrio AVD Application Delivery
# Enterprise Infrastructure as Code (Terraform)

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Base Networking for AVD (Subnet should have enough IPs for session hosts)
resource "azurerm_resource_group" "avd_rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.avd_rg.name
  location            = azurerm_resource_group.avd_rg.location
  vnet_cidr           = "10.10.0.0/16"
  avd_subnet_cidr     = "10.10.1.0/24"
}

# 2. AVD Control Plane (Workspace & Host Pool)
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "avd-workspace-global"
  location            = azurerm_resource_group.avd_rg.location
  resource_group_name = azurerm_resource_group.avd_rg.name
  friendly_name       = "Devopstrio Digital Workspace"
  description         = "Central hub for all virtual applications and desktops."
}

resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  name                = "avd-pool-standard"
  location            = azurerm_resource_group.avd_rg.location
  resource_group_name = azurerm_resource_group.avd_rg.name
  
  type                             = "Pooled"
  load_balancer_type               = "BreadthFirst"
  maximum_sessions_allowed         = 12
  validate_environment             = false
  start_vm_on_connect              = true
  custom_rdp_properties            = "audiocapturemode:i:1;videocapturemode:i:1;drivestoredirect:s:*;usbdevicestoredirect:s:*;compresstips:i:1;"
}

# 3. Application Group (Desktop)
resource "azurerm_virtual_desktop_application_group" "desktopappgroup" {
  name                = "avd-appgroup-desktop"
  location            = azurerm_resource_group.avd_rg.location
  resource_group_name = azurerm_resource_group.avd_rg.name
  
  type          = "Desktop"
  host_pool_id  = azurerm_virtual_desktop_host_pool.hostpool.id
  friendly_name = "Full Desktop Experience"
}

# 4. Associate App Group with Workspace
resource "azurerm_virtual_desktop_workspace_application_group_association" "workspaceremoteapp" {
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.desktopappgroup.id
}

# 5. Azure Compute Gallery for Golden Images
resource "azurerm_shared_image_gallery" "gallery" {
  name                = "sig_avd_images"
  resource_group_name = azurerm_resource_group.avd_rg.name
  location            = azurerm_resource_group.avd_rg.location
  description         = "Golden images for AVD session hosts."
}

# Outputs
output "workspace_url" {
  value = "https://client.wvd.microsoft.com/arm/webclient/index.html"
}

output "hostpool_id" {
  value = azurerm_virtual_desktop_host_pool.hostpool.id
}
