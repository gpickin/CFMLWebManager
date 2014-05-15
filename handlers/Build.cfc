component  displayname="Build Controller" output="false"
{
	
	property name="ApacheService" inject="id:ApacheService";
	property name="TomcatService" inject="id:TomcatService";
	
	function index(event,rc,prc){
		
	}
	
	function buildConf(event,rc,prc){
	
		prc.result = ApacheService.buildConf( 1 );
		prc.result2 = TomcatService.buildConf( 1 );
		
	}
	
}