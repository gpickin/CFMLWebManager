component  displayname="ServerService" hint="I am the Server Service" output="false" extends="model.Base" {
	
	property name="ServerDAO" inject="id:ServerDAO";
	
	
	public struct function get( required numeric serverID ){
		
		var result={};
		var q = ServerDAO.get( serverID=ARGUMENTS.serverID );
		
		if ( q.recordcount ){
			
			result.messageType = RESULT_SUCCESS;
			result.message = "";
			result.data = q;
		}
		else{
			result.messageType = RESULT_WARNING;
			result.message = "Server does not exist";
			result.data = "";
		}
		return result;
	}
	
	public struct function getServerModules( required numeric serverID ){
		
		var result={};
		var q = ServerDAO.getServerModules( serverID=ARGUMENTS.serverID );
		
		if ( q.recordcount ){
			
			result.messageType = RESULT_SUCCESS;
			result.message = "";
			result.data = q;
		}
		else{
			result.messageType = RESULT_WARNING;
			result.message = "Server does not exist";
			result.data = "";
		}
		return result;
	}
	
	public struct function getServerVirtualHosts( required numeric serverID ){
		
		var result={};
		var q = ServerDAO.getServerVirtualHosts( serverID=ARGUMENTS.serverID );
		
		if ( q.recordcount ){
			
			result.messageType = RESULT_SUCCESS;
			result.message = "";
			result.data = q;
		}
		else{
			result.messageType = RESULT_WARNING;
			result.message = "Server does not exist";
			result.data = "";
		}
		return result;
	}
	
	public struct function getServerTomcatHosts( required numeric serverID ){
		
		var result={};
		var q = ServerDAO.getServerTomcatHosts( serverID=ARGUMENTS.serverID );
		
		if ( q.recordcount ){
			
			result.messageType = RESULT_SUCCESS;
			result.message = "";
			result.data = q;
		}
		else{
			result.messageType = RESULT_WARNING;
			result.message = "Server does not exist";
			result.data = "";
		}
		return result;
	}
	
	
	
}