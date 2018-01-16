public with sharing class AdminProvenValueController {
    
    public List<PastProvenValueNew__c> ProvenValueList {get;set;}
    public String regionId { get; set;}
    public String industry { get; set; }
    public String micro_industry { get; set; }
    public String IdtoDelete {get; set;}
    public PastProvenValueNew__c newPruvenValue {get;set;}
    public Boolean canEdit {get;set;}
    public Account tempAccount{get;set;}
    
    public AdminProvenValueController() {
        init();
    }
    
    private void init() {
        newPruvenValue = new PastProvenValueNew__c();
        ProvenValueList = new List<PastProvenValueNew__c>();
        tempAccount = new Account();
    }
    
    public List<SelectOption> getRegions(){
        List<SelectOption> options = new List<SelectOption>();

    
        List<Region__c> temp =  [SELECT Name,Id From Region__c ORDER BY name ASC];
        
       for( Region__c c : temp) {
          options.add(new SelectOption(c.Id,c.Name));
       }  
       return options;
        
    }
    
    public List<SelectOption> getIndustries(){
      List<SelectOption> options = new List<SelectOption>();
            
       Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       options.add(new SelectOption('All', 'All'));       
       return options;
    }
    
    public List<SelectOption> getMicro_Industries(){
      List<SelectOption> options = new List<SelectOption>();
            
       Schema.DescribeFieldResult fieldResult = Account.Micro_Industry__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple) {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }
       options.add(new SelectOption('All', 'All'));       
       return options;
    }
    
    public List<SelectOption> getProvenValueTypes() {
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption(Label.Industry_Offering,Label.Industry_Offering));
        options.add(new SelectOption(Label.Industry_Success_Stories,Label.Industry_Success_Stories));
        options.add(new SelectOption(Label.Industry_Competitive_Differenciators,Label.Industry_Competitive_Differenciators));
        
        return options;
    }
    
    public PageReference save(){
    	Update ProvenValueList;
    	return null;
    }
    
    public void doUpdate() {
        
        if (tempAccount.Industry == 'Todos') {
        	tempAccount.Micro_Industry__c = 'Todos';
        } else if ( tempAccount.Industry == 'All') {
        	tempAccount.Micro_Industry__c = 'All';
        }
       	        
        newPruvenValue.region__c = regionId;
        //newPruvenValue.Industry__c = industry;
        newPruvenValue.Industry__c = tempAccount.Industry;
        newPruvenValue.Micro_Industry__c = tempAccount.micro_industry__c;
        canEdit = false;
        
        List<Region__Share> tempedit = [select Id from Region__Share WHERE (AccessLevel = 'Edit' OR AccessLevel = 'All') AND ParentId =:regionId AND UserOrGroupId =:UserInfo.getUserId()];
        
        if(tempedit.size() > 0)
            canEdit = true;
        else
            canEdit = false;
        
        if (regionId == null || regionId == '' || tempAccount.Industry == null || tempAccount.Industry == '' || tempAccount.Micro_Industry__c == null || tempAccount.Micro_Industry__c == '') {
            canEdit = false;
        }
        
        ProvenValueList = [select id, Unique_Value__c, Type__c from PastProvenValueNew__c where region__c = :regionId and industry__c = :tempAccount.industry and micro_industry__c = :tempAccount.micro_industry__c];
    }
    
    public PageReference InsertNew() {        
        if (newPruvenValue.Type__c != null && newPruvenValue.Unique_Value__c != null) {
            insert newPruvenValue;
            newPruvenValue = new PastProvenValueNew__c();           
            doUpdate();
        }
        return null;
    }
    
    public PageReference del(){
        
        List<PastProvenValueNew__c> provenValue = [select id from PastProvenValueNew__c where id = :IdtoDelete];
        delete provenValue;
        doUpdate();
        return null;
    }
}