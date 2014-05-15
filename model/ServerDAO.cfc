<cfcomponent name="ServerDAO" displayname="csUser DAO" hint="I look after the coping station user data access" output="false">
	
	<!---<cfproperty name="dsn" inject="coldbox:setting:dsn">--->
	<cfset variables.dsn = 'virtmanager'>
	
	<cffunction name="init" returntype="any">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="get" returntype="query" output="false" description="Gets a user with specified criteria">
		<cfargument name="serverID" required="true" type="string">
		
		<cfset var q = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
			SELECT
				serverID,
				name,
				os,
				hostsFile,
				apacheHosts,
				apacheModules
			FROM  server
			WHERE serverID = <cfqueryparam value="#arguments.serverID#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfreturn q>
		
	</cffunction> 
	
	
	<cffunction name="getServerModules" returntype="query" output="false">
		<cfargument name="serverID" required="true" type="string">
		
		<cfset var q = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
			select moduleFile 
			from server
			inner join instance on instance.FK_serverID = server.serverID
			inner join website on website.FK_instanceID = instance.instanceID
			inner join engine on engine.engineID = instance.FK_engineID 
			WHERE serverID = <cfqueryparam value="#arguments.serverID#" cfsqltype="cf_sql_integer">
			and moduleFile is not null
			group by moduleFile
		</cfquery>
		
		<cfreturn q>
		
	</cffunction> 
	
	<cffunction name="getServerVirtualHosts" returntype="query" output="false">
		<cfargument name="serverID" required="true" type="string">
		
		<cfset var q = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
			select website.websiteID,
			website.url,
			website.path,
			instance.connectionFile 
			from server
			inner join instance on instance.FK_serverID = server.serverID
			inner join website on website.FK_instanceID = instance.instanceID 
			WHERE serverID = <cfqueryparam value="#arguments.serverID#" cfsqltype="cf_sql_integer">
		</cfquery>
		
		<cfreturn q>
		
	</cffunction>
	
	<cffunction name="getServerTomcatHosts" returntype="query" output="false">
		<cfargument name="serverID" required="true" type="string">
		
		<cfset var q = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
			select website.websiteID,
			website.url,
			website.path,
			instance.configFile 
			from server
			inner join instance on instance.FK_serverID = server.serverID
			inner join website on website.FK_instanceID = instance.instanceID 
			WHERE serverID = <cfqueryparam value="#arguments.serverID#" cfsqltype="cf_sql_integer">
			and instance.configFile is not null
			order by instance.configFile
		</cfquery>
		
		<cfreturn q>
		
	</cffunction>
	
	


</cfcomponent>	