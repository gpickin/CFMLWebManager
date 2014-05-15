component name="ApacheService" extends="model.Base" {
	
	property name="ServerService" inject="id:ServerService";
	property name="WebsiteService" inject="id:WebsiteService";
	
	function init() {
		return this;
	}
	
	public function buildConf( required numeric serverID ) {
		var webServer = ServerService.get( arguments.serverID );
		
		writeHosts( webServer );
		writeApacheHosts( webServer );
		writeApacheModules( webServer );
		
		return webServer;
		
	}
	
	private boolean function writeHosts( required struct webServer ) {
		//fileWrite( file=webServer.data.hostsFile, data="test 1 2 3" );
		return true;
	}
	
	private boolean function writeApacheModules( required struct webServer ) {
		var modules = ServerService.getServerModules( arguments.webServer.data.serverID );
		var configToWrite = '';
		var i = 1;
		
		if ( modules.messageType == RESULT_SUCCESS ) {
			for ( i; i lte modules.data.recordcount; i = (i + 1) ) {
				configToWrite = configToWrite & 'Include ' & modules.data['moduleFile'][i] & chr(13) & chr(10);
			}	
		}
		
		fileWrite( webServer.data.apacheModules, configToWrite );
		return true;
	}
	
	private boolean function writeApacheHosts( required struct webServer ) {
		var modules = ServerService.getServerVirtualHosts( arguments.webServer.data.serverID );
		var ServerAliases = '';
		var ServerMappings = '';
		var configToWrite = '';
		var i = 1;
		var j = 1;
		
		if ( modules.messageType == RESULT_SUCCESS ) {
			for ( i; i lte modules.data.recordcount; i = (i + 1) ) {
				configToWrite = configToWrite & '<VirtualHost *:80>' & chr(13) & chr(10);
				configToWrite = configToWrite & chr(9) & 'DocumentRoot "' & modules.data['path'][i] & '"' & chr(13) & chr(10);
				configToWrite = configToWrite & chr(9) & 'ServerName "' & modules.data['url'][i] & '"' & chr(13) & chr(10);
				
				ServerAliases = WebsiteService.getServerAliases( modules.data['websiteID'][i] );
				if ( ServerAliases.messageType == RESULT_SUCCESS ) {
					for ( j = 1; j lte ServerAliases.data.recordcount; j = (j + 1) ) {
						configToWrite = configToWrite & chr(9) & 'ServerAlias "' & ServerAliases.data['name'][j] & '"' & chr(13) & chr(10);
					}	
				}	
				
				ServerMappings = WebsiteService.getServerMappings( modules.data['websiteID'][i] );
				if ( ServerMappings.messageType == RESULT_SUCCESS ) {
					for ( j = 1; j lte ServerMappings.data.recordcount; j = (j + 1) ) {
						configToWrite = configToWrite & chr(9) & 'Alias "' & ServerMappings.data['name'][j] & '" "' & ServerMappings.data['path'][j] & '"' & chr(13) & chr(10);
					}	
				}
				
				if ( modules.data['connectionFile'][i] gt "" ) {
					configToWrite = configToWrite & chr(9) & 'Include "' & modules.data['connectionFile'][i] & '"' & chr(13) & chr(10);
				}
		 
				configToWrite = configToWrite & '</VirtualHost>' & chr(13) & chr(10) & chr(13) & chr(10);
	
			}	
		}
		
		fileWrite( webServer.data.apacheHosts, configToWrite );
		return true;
	}
	
		
	
	
}