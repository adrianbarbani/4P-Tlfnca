public class OpportunityEvaluations {
    public String contactIdToEvaluate {
        get;
        // *** setter is NOT being called ***
        set {
            contactIdToEvaluate = value;
        }
    }

    public String delid {
        get;
        // *** setter is NOT being called ***
        set {
            delid = value;
        }
    }
    
    public Contact contactToEvaluate {get; set;}
    public Contact_Assessment__c newEval { get; set; }
    public Opportunity opportunity {get; set;}
    public List<Contact_Assessment__c> evaluated {get; set;}
    public Account account {get; set;}    
    public Boolean canEdit {get;set;}
    public List<Contact> contatsFromParents {get;set;}
    public List<Id> accountInheritanceIds;

	public Id objectId {get;set;} 
	public String objectAPIName {get;set;}

    public OpportunityEvaluations(){
    	
    	objectId = (Id) ApexPages.currentPage().getParameters().get('Id');
    	objectAPIName = objectId.getSObjectType().getDescribe().getName();
    	
    	if (objectAPIName == 'Opportunity') { 
        	this.opportunity = [SELECT name, id, accountId,Description FROM Opportunity WHERE Id = :objectId];
	        this.account = [SELECT name, id, parentId, Industry, Region__c, parent.name FROM Account WHERE Id = :opportunity.accountId];
	        this.evaluated = [SELECT Id, Attitudes__c, Authority__c, Contact__c, Contact__r.Name, Contact__r.Account.name , Focus__c, Generation__c, Influence__c, Our_Relationship__c, Competing_Company_Relationship__c, Buying_Cycle__c FROM Contact_Assessment__c WHERE Contact__r.active__c = true and Opportunity__c = :opportunity.Id ORDER BY id];
    	} else if (objectAPIName == 'Account') {
    		this.account = [SELECT name, id, parentId, Industry, Region__c, parent.name FROM Account WHERE Id = :objectId];
    		this.evaluated = [SELECT Id, Attitudes__c, Authority__c, Contact__c, Contact__r.Name, Contact__r.Account.name , Focus__c, Generation__c, Influence__c, Our_Relationship__c, Competing_Company_Relationship__c, Buying_Cycle__c FROM Contact_Assessment__c WHERE account__c = :account.Id and Contact__r.active__c = true ORDER BY id];
    	}
        this.newEval = new Contact_Assessment__c();
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);        
        if (this.account.parentId != null) {
          getContactsFromParent([select id, parentId from Account where id = :this.account.parentId]);
        }

    }
    
    public PageReference copyRDM() {
    	
    	if (objectAPIName == 'Opportunity') {
    		delete [SELECT Id, Attitudes__c, Authority__c, Contact__c, Contact__r.Name, Contact__r.Account.name , Focus__c, Generation__c, Influence__c, Our_Relationship__c, Competing_Company_Relationship__c, Buying_Cycle__c FROM Contact_Assessment__c WHERE Opportunity__c = :opportunity.Id];
    		
    		List<Contact_Assessment__c> newContactAssesments = new List<Contact_Assessment__c>();
    		for (Contact_Assessment__c contAssesment :[SELECT Id, Attitudes__c, Authority__c, Contact__c, Contact__r.Name, Contact__r.Account.name , Focus__c, Generation__c, Influence__c, Our_Relationship__c, Competing_Company_Relationship__c, Buying_Cycle__c FROM Contact_Assessment__c WHERE account__c = :opportunity.accountId]) {
    			Contact_Assessment__c newContAssesment = new Contact_Assessment__c();
    			newContAssesment.Attitudes__c = contAssesment.Attitudes__c;
    			newContAssesment.Authority__c = contAssesment.Authority__c;
    			newContAssesment.Contact__c = contAssesment.Contact__c;
    			newContAssesment.Focus__c = contAssesment.Focus__c;
    			newContAssesment.Generation__c = contAssesment.Generation__c;
    			newContAssesment.Influence__c = contAssesment.Influence__c;
    			newContAssesment.Our_Relationship__c = contAssesment.Our_Relationship__c;
    			newContAssesment.Competing_Company_Relationship__c = contAssesment.Competing_Company_Relationship__c;
    			newContAssesment.Buying_Cycle__c = contAssesment.Buying_Cycle__c;
    			newContAssesment.Opportunity__c = opportunity.id;
    			
    			newContactAssesments.add(newContAssesment);
    		}
    		
    		insert newContactAssesments;	
    	}
    	
    	return null;
    }    
    
    public String getFooterStyle(){
    
        if(this.newEval == null)
            return 'HiddenFooter';
        else
            return 'Footer';
    
    }


    public String getSoqlForNotEvaluatedContacts(){
    
        
        String ret = '' ;

        
        for(Contact_Assessment__c c : evaluated){
        
            ret = ret + ' AND Id != \'' + c.Contact__c +'\'';
            
        }
    
        return ret;
    }
    
    public List<Contact> getNotEvaluated() {
        //I look up each contact on this account and see if they are already evaluated, if they aren't I return them in a list.
 
 
        return  Database.query('SELECT  Id, Name   FROM Contact WHERE active__c = true and AccountId = \'' + account.id + '\'' + getSoqlForNotEvaluatedContacts());

 
    }

  public void getContactsFromParent(Account a) {    
    if (accountInheritanceIds == null) {
      accountInheritanceIds = new List<Id>();    
    }
    accountInheritanceIds.add(a.Id);
    if(a.parentId == null){      
	List<Id> evaluatedIdList = new List<Id>();
	for(Contact_Assessment__c c : evaluated){
		evaluatedIdList.add(c.Contact__c);
	}
      contatsFromParents = [Select Id, Name, Account.Name From Contact where  AccountId in :accountInheritanceIds and active__c = true and id not in :evaluatedIdList];
    } else {
      getContactsFromParent([Select Id, parentId FROM Account WHERE Id = :a.parentId]);      
    }
  }
  
  /*
    public List<Contact> getParentNotEvaluated() {
        //I look up each contact on this account and see if they are already evaluated, if they aren't I return them in a list.
        if(account.parentId != null)
            return  Database.query('SELECT  Id, Name   FROM Contact WHERE AccountId = \'' + account.parentId + '\'' + getSoqlForNotEvaluatedContacts());                
        else
            return null;

    }
    */

    public PageReference InsertEvaluation() {
        insert newEval;
        newEval = null;
        contactToEvaluate = null;
        contactidToEvaluate = null;
        if (objectAPIName == 'Opportunity') {
        	this.evaluated = [SELECT Id, Attitudes__c, Authority__c, Contact__c, Contact__r.Name, Contact__r.Account.name , Focus__c, Generation__c, Influence__c, Our_Relationship__c, Competing_Company_Relationship__c, Buying_Cycle__c FROM Contact_Assessment__c WHERE Opportunity__c = :opportunity.Id and Contact__r.active__c = true ORDER BY id];        
        } else if (objectAPIName == 'Account') {
        	this.evaluated = [SELECT Id, Attitudes__c, Authority__c, Contact__c, Contact__r.Name, Contact__r.Account.name , Focus__c, Generation__c, Influence__c, Our_Relationship__c, Competing_Company_Relationship__c, Buying_Cycle__c FROM Contact_Assessment__c WHERE Account__c = :account.Id and Contact__r.active__c = true ORDER BY id];
        }
        if (this.account.parentId != null) {
          getContactsFromParent([select id, parentId from Account where id = :this.account.parentId]);
        }
        
        return null;
    }


    public PageReference SaveChanges() {
        
        Boolean errors = false;
        
        for(Contact_Assessment__c c : evaluated){
        	if (c.Focus__c == null) {
        		errors = true;
        		c.Focus__c.addError('Debe escribir un valor');
        	}
        	if (c.Attitudes__c == null) {
        		errors = true;
        		c.Attitudes__c.addError('Debe escribir un valor');
        	}
        	if (c.Authority__c == null) {
        		errors = true;
        		c.Authority__c.addError('Debe escribir un valor');
        	}
        	if (c.Influence__c == null) {
        		errors = true;
        		c.Influence__c.addError('Debe escribir un valor');
        	}
        	if (c.Our_Relationship__c == null) {
        		errors = true;
        		c.Our_Relationship__c.addError('Debe escribir un valor');
        	}
        	if (c.Competing_Company_Relationship__c == null) {
        		errors = true;
        		c.Competing_Company_Relationship__c.addError('Debe escribir un valor');
        	}
        	if (c.Generation__c == null) {
        		errors = true;
        		c.Generation__c.addError('Debe escribir un valor');
        	}
        	if (c.Buying_Cycle__c == null) {
        		errors = true;
        		c.Buying_Cycle__c.addError('Debe escribir un valor');
        	}	
        } 
        
        if (!errors) {
        	update evaluated;
        }
        return null;
    }
    


    public PageReference popContactEvaluation() {
    	
        this.newEval = new Contact_Assessment__c();
        this.contactToEvaluate = [SELECT id, name, Account.Name FROM Contact WHERE id = :contactIdToEvaluate];
        this.newEval.Contact__c = contactToEvaluate.id;        
        if (objectAPIName == 'Opportunity') {
        	this.newEval.Opportunity__c = opportunity.id;        
        } else if (objectAPIName == 'Account') {
        	this.newEval.account__c = account.id;
        }
        
        return null;
    }
    
    public PageReference popContactEvaluationFromX() {
    
        this.contactToEvaluate = [SELECT id, name, Account.Name FROM Contact WHERE id = :newEval.Contact__c];
        if (objectAPIName == 'Opportunity') {
        	this.newEval.Opportunity__c = opportunity.id;        
        } else if (objectAPIName == 'Account') {
        	this.newEval.account__c = account.id;
        }
        return null;
    }
    
    public PageReference DeleteEvaluation() {
        System.debug('delid:' + this.delid);
        delete [SELECT id FROM Contact_Assessment__c WHERE id = :this.delid];
                
        if (objectAPIName == 'Opportunity') {
        	this.evaluated = [SELECT Id, Attitudes__c, Authority__c, Contact__c, Contact__r.Name, Contact__r.Account.name , Focus__c, Generation__c, Influence__c, Our_Relationship__c, Competing_Company_Relationship__c, Buying_Cycle__c FROM Contact_Assessment__c WHERE Opportunity__c = :opportunity.Id and Contact__r.active__c = true ORDER BY id];        
        } else if (objectAPIName == 'Account') {
        	this.evaluated = [SELECT Id, Attitudes__c, Authority__c, Contact__c, Contact__r.Name, Contact__r.Account.name , Focus__c, Generation__c, Influence__c, Our_Relationship__c, Competing_Company_Relationship__c, Buying_Cycle__c FROM Contact_Assessment__c WHERE Account__c = :account.Id and Contact__r.active__c = true ORDER BY id];
        }
        
        if (this.account.parentId != null) {
          getContactsFromParent([select id, parentId from Account where id = :this.account.parentId]);
        }
        
        return null;
    }


}