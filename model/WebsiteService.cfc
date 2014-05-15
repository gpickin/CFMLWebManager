component  displayname="WebsiteService" hint="I am the Website Service" output="false" extends="model.Base" {
	
	property name="WebsiteDAO" inject="id:WebsiteDAO";
	
	public struct function getServerAliases( required numeric websiteID ){
		
		var result={};
		var q = WebsiteDAO.getServerAliases( websiteID=ARGUMENTS.websiteID );
		
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
	
	
	public struct function getServerMappings( required numeric websiteID ){
		
		var result={};
		var q = WebsiteDAO.getServerMappings( websiteID=ARGUMENTS.websiteID );
		
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