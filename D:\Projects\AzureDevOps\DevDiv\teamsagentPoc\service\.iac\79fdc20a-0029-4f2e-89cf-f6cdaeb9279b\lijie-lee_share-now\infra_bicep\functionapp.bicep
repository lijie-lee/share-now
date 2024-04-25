// The template to create a function app

param name string = 'fnapp-${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
param identityType string = 'SystemAssigned'
param functionAppPlanId string
param appSettings array = []
param storageAccountName string


resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' existing = { 
	name: storageAccountName
}

resource functionapp 'Microsoft.Web/sites@2022-09-01' = {
	name: name
	location: location
  	kind: 'functionapp'
	properties: {
		serverFarmId: functionAppPlanId
		siteConfig: {
			appSettings: concat(appSettings, [
				{
					name: 'FUNCTIONS_WORKER_RUNTIME'
					value: 'node'
				}
			
				{
					name: 'FUNCTIONS_EXTENSION_VERSION'
					value: '~4'
				}
			
				{
					name: 'WEBSITE_NODE_DEFAULT_VERSION'
					value: '~14'
				}
			
				{
					name: 'AzureWebJobsStorage'
					value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};AccountKey=${storageAccount.listKeys().keys[0].value};BlobEndpoint=${storageAccount.properties.primaryEndpoints.blob};TableEndpoint=${storageAccount.properties.primaryEndpoints.table};QueueEndpoint=${storageAccount.properties.primaryEndpoints.queue};FileEndpoint=${storageAccount.properties.primaryEndpoints.file};'
				}
			])
		}
	}
	identity: {
		type: identityType
	}
}


output id string = functionapp.id
output name string = functionapp.name
output identityPrincipalId string = functionapp.identity.principalId
output outboundIps string[] = split(functionapp.properties.outboundIpAddresses, ',')
output requestUrl string = functionapp.properties.defaultHostName