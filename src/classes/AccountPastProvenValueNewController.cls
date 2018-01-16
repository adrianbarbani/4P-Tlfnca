public with sharing class AccountPastProvenValueNewController {
	
	public Account account {get;set;}
	public Boolean canEdit {get;set;}
	public List<PastProvenValueNew__c> pastProvenValueNewList {get;set;}	
	public String toDel {get;set;}
	public List<ProvenValueWrapper> provenValueWrapperList {get;set;}
	public PastProvenValueNew__c newProvenValue {get;set;}	
	
	public AccountPastProvenValueNewController() {        
        if (Util.globalAccount==null) {
        	account = [SELECT id, Name, parentId, Industry, micro_industry__c, Region__c FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];    
        } else {
    		this.account = Util.globalAccount; 
    	}
    	
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);                
        init();        
    }

	private void init() {
	
		newProvenValue = new PastProvenValueNew__c(account__c = account.id);
		
		pastProvenValueNewList = new List<PastProvenValueNew__c>();
		
		provenValueWrapperList = new List<ProvenValueWrapper>();	
		if (account.parentId != null) {
			List<Id> accountIdList = new List<Id>();
			
			for (Account acc :[select id from account where (id = :account.parentId or parentId = :account.parentId) and id != :account.id]) {
				accountIdList.add(acc.id);				
			}
			
			for (PastProvenValueNew__c p :[SELECT id, name, account__c, Unique_Value__c, type__c, region__c, account__r.Name, LastModifiedDate, Title__c,
                                           	(SELECT name, Opportunity__c, Opportunity__r.Name FROM OpportunityPastProvenValueNew__r WHERE Opportunity__r.Account.id = :this.account.id), 
                                           	(SELECT name, Potential_New_Business__c, Potential_New_Business__r.Name, Potential_New_Business__r.Potential_New_Business__c  FROM Potential_New_Business_Past_Provent__r) 
                                           FROM PastProvenValueNew__c WHERE account__c IN :accountIdList]) {
				provenValueWrapperList.add(new ProvenValueWrapper(p,p.account__r.Name,false));
			}	
		}
		
		Region__c region = Util.getRegionFromAccount(account.Id, account.region__c);		
		/*
		List<Region__c> regionsList = [SELECT Id,Name, parent__c FROM Region__c WHERE id = :this.account.region__c];
        Region__c region = null;
        if (regionsList.size()>0) {
        	region = regionsList.get(0);
        } else {
        	region = [SELECT Id,Name, parent__c FROM Region__c WHERE name = 'Global'];
        }
        */
        
        //loadProvenValueRegion(region, account.industry, account.micro_industry__c);
		
		for (PastProvenValueNew__c p :[select id, name, account__c, Unique_Value__c, type__c, region__c, LastModifiedDate, Title__c,
                                       	(SELECT name, Opportunity__c, Opportunity__r.Name FROM OpportunityPastProvenValueNew__r WHERE Opportunity__r.Account.id = :this.account.id), 
                                       	(SELECT name, Potential_New_Business__c, Potential_New_Business__r.Name, Potential_New_Business__r.Potential_New_Business__c  FROM Potential_New_Business_Past_Provent__r) 
                                       FROM PastProvenValueNew__c WHERE account__c = :account.id]) {
			provenValueWrapperList.add(new ProvenValueWrapper(p,account.Name,true));
			pastProvenValueNewList.add(p);
		}
				
	}
	/*
	private void loadProvenValueRegion(Region__c region, String industry, String micro_industry) {
		for (PastProvenValueNew__c p :[select id, name, account__c, Unique_Value__c, type__c, industry__c, micro_industry__c, region__c, LastModifiedDate, Title__c, (SELECT name, Opportunity__c, Opportunity__r.Name FROM OpportunityPastProvenValueNew__r WHERE Opportunity__r.Account.id = :this.account.id), (SELECT name, Potential_New_Business__c, Potential_New_Business__r.Name, Potential_New_Business__r.Potential_New_Business__c  FROM Potential_New_Business_Past_Provent__r) from PastProvenValueNew__c where (industry__c = :industry or industry__c = 'All' or industry__c = 'Todos') and (micro_industry__c = :micro_industry or micro_industry__c = 'All' or micro_industry__c = 'Todos') and region__c = :region.id]) {
			provenValueWrapperList.add(new ProvenValueWrapper(p,region.Name+' ('+p.industry__c+' - '+ p.micro_industry__c +')',false));
		}
		
		if (region.Parent__c != null) {
			Region__c parent = [SELECT Id,Name, parent__c FROM Region__c WHERE id = :region.parent__c];
			loadProvenValueRegion(parent,industry,micro_industry);
		}
	}
	*/
	public PageReference add() {
		//newProvenValue.Unique_Value__c = Label.new_past_proven_value;		
		insert newProvenValue;
		init();
		return null;
	}
	
	public PageReference save() {
		boolean errors = false;
		
		for (PastProvenValueNew__c past :pastProvenValueNewList) {
			if (past.type__c == null) {
				errors = true;
				past.type__c.addError('Debe escribir un valor');
			}
		}
		
		if (!errors) { 
			upsert pastProvenValueNewList;
			init();
		}
		
		return null;		
	}
	
	public PageReference del() { 
		delete [select id from PastProvenValueNew__c where id = :toDel];			   	
    	init();
    	return null;
    }
    
    public PageReference ExportToExcel() { 
		save();   	
    	return Page.accountPastProvenValueNewExcel;
    }
    
    public String getExcelName() {
    	String name = account.Name + '-' + Organization.Name + ' ' + Label.account_past_proven_value + '.xls';
    	return name.replaceAll(' ', '_').replaceAll(',','');
    }
        
    public class ProvenValueWrapper {
    	public PastProvenValueNew__c provenValue {get;set;}
    	public String source {get;set;}
    	public Boolean canEdit {get;set;}
    
    	public ProvenValueWrapper(PastProvenValueNew__c p, String s, Boolean c) {
    		provenValue = p;
    		source = s.replace('Todos - Todos', 'Todos').replace('All - All', 'All');	
    		canEdit = c;
    	}
    		
    }
	
}