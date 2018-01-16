public class accountStrategicContextWindow {

    public List<Strategic_Initiative__c>  localStrategicInitiatives { get; set; }

    public List<Strategic_Initiative__c>  globalStrategicInitiatives { get; set; }

    public List<Account> globalStrategicContext { get; set; }
    
    public List<String> globalBuyingCriteria {get;set;}
    
    public Account account {get;set;}
    
    public Strategic_Initiative__c newInitiative {get;set;}
    

    public String delid {
        get;
        set {
            delid = value;
        }
    }
    public Boolean canEdit {get;set;}

    
    public accountStrategicContextWindow(){
    	
    	if (Util.globalAccount==null) {
        	this.account = [SELECT name, id, parentId, Industry,Region__c, Buying_Criteria_Last_Update__c , Strategic_Context__c, Buying_Criteria__c, Strategic_Context_Last_Update__c FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        } else {
    		this.account = Util.globalAccount; 
    	}
        this.loadData();
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);

    }
    
    public void loadData(){
        
        newInitiative = new Strategic_Initiative__c();
        globalStrategicContext = new List<Account>();
        globalBuyingCriteria = new List<String>();
        globalStrategicInitiatives = new List<Strategic_Initiative__c>();
        localStrategicInitiatives = [SELECT Name, Strategic_Initiative__c, Strategic_Initiative_URL__c, LastModifiedDate, account__r.name, Title__c, (SELECT name, Opportunity__c, Opportunity__r.Name FROM Opportunities__r WHERE Opportunity__r.Account.id = :this.account.id) FROM Strategic_Initiative__c WHERE Account__C = :this.account.id order by name];
        if(account.parentId != null)
            getDataFromParents([SELECT Name, id, parentId, Industry,Region__c, Buying_Criteria_Last_Update__c,Strategic_Context__c, Buying_Criteria__c, Strategic_Context_Last_Update__c FROM Account WHERE Id = :this.account.parentId]);
    }
    
    public void getDataFromParents(Account a){
    
        if(a.parentId != null){
            getDataFromParents([SELECT name, id, parentId, Buying_Criteria_Last_Update__c,Industry,Region__c, Strategic_Context__c, Buying_Criteria__c, Strategic_Context_Last_Update__c FROM Account WHERE Id = :a.parentId]);
        }
        if(a.Strategic_Context__c!=null && a.Strategic_Context__c!='') {
            globalStrategicContext.add(a);
        }
            
        if(a.Buying_Criteria__c!=null && a.Buying_Criteria__c!='') {
            globalBuyingCriteria.add(a.Buying_Criteria__c);
        }
        
        List<Strategic_Initiative__c> temp = [SELECT name,Strategic_Initiative__c,Strategic_Initiative_URL__c, LastModifiedDate, account__r.name, Title__c, (SELECT name, Opportunity__c, Opportunity__r.name FROM Opportunities__r  WHERE Opportunity__r.Account.Id = :this.account.id) FROM Strategic_Initiative__c WHERE Account__C = :a.id order by Name];
        System.Debug( temp);
        System.Debug( globalStrategicInitiatives);
        
        if(temp != null) {
            globalStrategicInitiatives.addAll(temp);
        }        
    
    }
    

    public PageReference SaveChanges() {        
        Account oldAccount = [select id, Strategic_Context__c, Buying_Criteria__c from Account where id = :account.id];

        if (account.Strategic_Context__c != oldAccount.Strategic_Context__c) {
            account.Strategic_Context_Last_Update__c=System.now();
        }
        
        if (account.Buying_Criteria__c != oldAccount.Buying_Criteria__c) {
            account.Buying_Criteria_Last_Update__c=System.now();
        }

		update account;        
        /*
        Map<Id,Strategic_Initiative__c> localStrategicIniciativeMap = new Map<Id,Strategic_Initiative__c>();
        for (Strategic_Initiative__c si :localStrategicInitiatives) {
        	localStrategicIniciativeMap.put(si.id,si);
        }
        List<Strategic_Initiative__c> strategicIniciativeToUpdate = new List<Strategic_Initiative__c>();  
        for (Strategic_Initiative__c si :[SELECT name,Strategic_Initiative__c,Strategic_Initiative_URL__c, LastModifiedDate, account__r.name FROM Strategic_Initiative__c WHERE Account__C = :this.account.id]) {
			if (si.Strategic_Initiative__c != localStrategicIniciativeMap.get(si.id).Strategic_Initiative__c) {
				strategicIniciativeToUpdate.add(localStrategicIniciativeMap.get(si.id));
			}	        	
        }
        update strategicIniciativeToUpdate;
        */
        upsert localStrategicInitiatives;
        return null;
    }

    public void InsertIniciative() {
        
        newInitiative.account__c = account.id;
        insert newInitiative;
        loadData();

    }


    public void DeleteStrategicInitiatives() {

        Integer i = 0;
        
        for(Strategic_Initiative__c si : localStrategicInitiatives){
        
            if(si.id == this.delid){
                break;
            }
            else
                i++;
            
        }
        
        if(localStrategicInitiatives[i].id != null){
            List<OpportunityStrategicInitiative__c> osi=[select Id from OpportunityStrategicInitiative__c where Strategic_Initiative__c = :localStrategicInitiatives[i].id];
            delete osi;
            delete localStrategicInitiatives[i];    
        }
        
        localStrategicInitiatives.remove(i);
        
    }

	public void borra(){    
	    account.Strategic_Context_Last_Update__c=null;
	    account.Strategic_Context__c=null;
	    update account;
	}

	public void borra2(){
    	account.Buying_Criteria__c=null;
        account.Buying_Criteria_Last_Update__c = null;
	}
  
  	public PageReference ExportToExcel() {
    	return Page.accountStrategicContextWindowExcel;
    }
  
	public String getExcelName() {
		String name = account.Name + '-' + Label.Client_Context + '.xls';
		return name.replaceAll(' ', '_').replaceAll(',','');
	}

}