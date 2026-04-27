// Devopstrio AVD Application Delivery
// Enterprise Bicep Infrastructure Templates

targetScope = 'subscription'

param location string = 'uksouth'
param prefix string = 'avd-prd'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${prefix}-platform'
  location: location
}

// 1. AVD Hub & Workspace
module avdCore './modules/avd-platform.bicep' = {
  scope: rg
  name: 'avdCoreDeployment'
  params: {
    location: location
    workspaceName: 'vdws-${prefix}-main'
    hostPoolName: 'vdpool-${prefix}-pooled'
    appGroupName: 'vdag-${prefix}-desktop'
  }
}

// 2. Storage for FSLogix Profiles (Azure Files Premium)
module storage './modules/storage.bicep' = {
  scope: rg
  name: 'fslogixStorage'
  params: {
    location: location
    storageAccountName: 'st${prefix}profiles'
    fileShareName: 'profiles'
  }
}

// 3. Automated Image Gallery
module gallery './modules/gallery.bicep' = {
  scope: rg
  name: 'computeGallery'
  params: {
    location: location
    galleryName: 'gal_${prefix}_images'
  }
}

output workspaceResourceId string = avdCore.outputs.workspaceId
output storageEndpoint string = storage.outputs.fileEndpoint
