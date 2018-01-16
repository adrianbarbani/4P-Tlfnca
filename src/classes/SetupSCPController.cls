public with sharing class SetupSCPController {

	public Config__c setupSCP {get;set;}
	
	public SetupSCPController() {
		setupSCP =  Config__c.getOrgDefaults();		
	}
	
	public PageReference save() {
		upsert setupSCP;
		return null;		
	}

}