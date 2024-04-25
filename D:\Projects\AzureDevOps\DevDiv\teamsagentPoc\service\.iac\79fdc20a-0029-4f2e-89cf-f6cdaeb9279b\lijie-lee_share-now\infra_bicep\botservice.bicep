// TODO: support connection to bot service
// The template to create a bot service with Microsoft Teams channel

param name string = 'bot-${uniqueString(resourceGroup().id)}'
param sku string = 'F0'
param botAadAppClientId string
param botAppDomain string = 'example.com'


// Create the bot service
resource botService 'Microsoft.BotService/botServices@2021-03-01' = {
	kind: 'azurebot'
	location: 'global'
	name: name
	properties: {
		displayName: name
		endpoint: 'https://${botAppDomain}/api/messages'
		msaAppId: botAadAppClientId
	}
	sku: {
		name: sku
	}
}

// Create the Microsoft Teams channel
resource botServiceMsTeamsChannel 'Microsoft.BotService/botServices/channels@2021-03-01' = {
	parent: botService
	location: 'global'
	name: 'MsTeamsChannel'
	properties: {
		channelName: 'MsTeamsChannel'
	}
}


output id string = botService.id
output endpoint string = botService.properties.endpoint