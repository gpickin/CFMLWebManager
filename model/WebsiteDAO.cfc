<cfcomponent name="WebsiteDAO" displayname="csUser DAO" hint="I look after the coping station user data access" output="false">
	
	<!---<cfproperty name="dsn" inject="coldbox:setting:dsn">--->
	<cfset variables.dsn = 'virtmanager'>
	
	<cffunction name="init" returntype="any">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getServerAliases" returntype="query" output="false">
		<cfargument name="websiteID" required="true" type="string">
		
		<cfset var q = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
			select website_server_alias.name
			from website_server_alias
			WHERE FK_websiteID = <cfqueryparam value="#arguments.websiteID#" cfsqltype="cf_sql_integer">
			
		</cfquery>
		
		<cfreturn q>
		
	</cffunction> 
	
	<cffunction name="getServerMappings" returntype="query" output="false">
		<cfargument name="websiteID" required="true" type="string">
		
		<cfset var q = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
			select name, path
			from website_mapping
			WHERE FK_websiteID = <cfqueryparam value="#arguments.websiteID#" cfsqltype="cf_sql_integer">
			
		</cfquery>
		
		<cfreturn q>
		
	</cffunction>
	
	


</cfcomponent>	