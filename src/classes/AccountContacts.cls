public class AccountContacts {

    public Account account {get;set;}
    public Boolean canEdit {get;set;}
    public List<Contact> contactList {get;set;}

    public AccountContacts(ApexPages.StandardController controller) {        
        this.account = [SELECT name, id, parentId FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);
    }

	public AccountContacts() {
        if (Util.globalAccount==null) {
        	this.account = [SELECT name, id, parentId FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        } else {
    		this.account = Util.globalAccount; 
    	}
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);
    }


    public List<ExtendedContactDetails> getContacts(){
    
        List<ExtendedContactDetails> ret = new List<ExtendedContactDetails>();
        
        contactList = [SELECT Id, Name, Title, ReportsToId,Closest_Account_Team_Member__r.name  FROM Contact WHERE active__c = true and AccountId = :ApexPages.currentPage().getParameters().get('Id')];
        
        List<Contact_Influence__c> ci = [SELECT Contact_Influenced__c,Contact_Influences__c FROM Contact_Influence__c WHERE Contact_Influenced__c IN (SELECT id FROM Contact WHERE active__c = true and AccountId = :ApexPages.currentPage().getParameters().get('Id'))];      
		
		Map<Id, Contact> contactMap = new Map<Id, Contact>();
		
		for (Contact c :contactList) {
			contactMap.put(c.id,c);
		} 
				
        for( Contact c: contactList ){
            ret.add( new ExtendedContactDetails(c,ci,contactList,contactMap));
        }
    
        return ret;
    
    }
    /*
    public List<Contact> getParentContacts(){
    
        return [SELECT name, id FROM Contact WHERE active__c = true and AccountId = :account.parentid];
    
    }
    */
    public PageReference goToNewContact (){
        string pageReturn = Page.accountOrganizationChartWindow.getUrl() + '?id='+account.Id;
        PageReference pageRef = new PageReference('/003/e?retURL=%2F' + pageReturn + '&accid='+account.Id + '&saveURL=%2F' + pageReturn);
        return pageRef;
    }
	
	public PageReference goToOrg() {		
        //save();
        return new PageReference(Page.accountOrganizationChart.getUrl()  + '?id='+account.Id);
	}
	
	public PageReference save() {
		update contactList;
		return null;
	}
	
 	public String getExcelName() {
    	String name = account.Name + '-' + Label.Influence_Org + '.xls';
    	return name.replaceAll(' ', '_').replaceAll(',','');
    } 
    
    public PageReference ExportToExcel() {      
        return Page.accountOrganizationChartWindowExcel;
    }
    
}