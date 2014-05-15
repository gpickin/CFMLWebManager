component displayname="TomcatService" hint="Tomcat Service" output="false" extends="model.Base" {
	
	property name="ServerService" inject="id:ServerService";
	
	function init() {
		return this;
	}
	
	public function buildConf( required numeric serverID ) {
		var webServer = ServerService.get( arguments.serverID );
		
		writeTomcatHosts( webServer );
		
		return webServer;
		
	}
	
	private boolean function writeTomcatHosts( required struct webServer ) {
		var modules = ServerService.getServerTomcatHosts( arguments.webServer.data.serverID );
		var configToWrite = '';
		var lastConfig = '';
		var i = 1;
		if ( modules.messageType == RESULT_SUCCESS ) {
			for ( i; i lte modules.data.recordcount; i = (i + 1) ) {
				if ( lastConfig gt '' and lastConfig neq modules.data['configFile'][i] ) {
					fileWrite( modules.data['configFile'][i], configToWrite );
					configToWrite = '';
				}
				configToWrite = configToWrite & '<Host name="' & modules.data['url'][i] & '" appBase="webapps">' & chr(13) & chr(10);
				configToWrite = configToWrite & chr(9) & '<Context path="" docBase="' & modules.data['path'][i] & '"></Context>' & chr(13) & chr(10);
				configToWrite = configToWrite & '</Host>' & chr(13) & chr(10);
				
			}	
		}
		
		fileWrite( modules.data['configFile'][i-1], configToWrite );
		return true;
	}
	
}