public class EditContact {

    private ApexPages.StandardController controller;
    private Contact contact;
    private List<Contact> ContactInfluenced;
    private List<Contact> ContactInfluences;
    public String IdtoDel {get; set;}
    public Contact_Influence__c CIs {get; set;}
    public Contact_Influence__c CId {get; set;}
    
   
    

    public EditContact(ApexPages.StandardController controller) {
        this.controller = controller;
        this.contact =  [SELECT name, id, accountid FROM Contact WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];

        load(this.contact.id);
        this.CIs = new Contact_Influence__c();
        this.CIs.Contact_Influenced__c = this.contact.id;
        this.CId = new Contact_Influence__c();
        this.CId.Contact_Influences__c = this.contact.id;

    }

    public Contact getcontact(){
        return contact;
    }

    private Boolean load(String id){

        ContactInfluenced = new List<Contact>();
            
        for( Contact_Influence__c ci: [ SELECT Contact_Influenced__c, Contact_Influences__c FROM Contact_Influence__c 
                                      WHERE Contact_Influences__c = :id]){
                                      
           ContactInfluenced.add([SELECT Id, Name  FROM Contact WHERE Id = :ci.Contact_Influenced__c]);
                                      
        }
        
        ContactInfluences = new List<Contact>();
            
        for( Contact_Influence__c ci: [ SELECT Contact_Influenced__c, Contact_Influences__c FROM Contact_Influence__c 
                                      WHERE Contact_Influenced__c = :id]){
                                      
           ContactInfluences.add([SELECT Id, Name  FROM Contact WHERE Id = :ci.Contact_Influences__c]);
                                      
        }
        
        return true; //Why this? no clue why null isn't available
    }

    public List<Contact> getContactInfluenced(){
        return ContactInfluenced;
    }
    public List<Contact> getContactInfluences(){
        return ContactInfluences;
    }

    public PageReference delCId(){
    
        this.IdtoDel = Apexpages.currentPage().getParameters().get('IdtoDelete');  
    
        Contact_Influence__c toDel= [ SELECT id FROM Contact_Influence__c 
                                     WHERE Contact_Influences__c = :this.contact.id AND Contact_Influenced__c = :IdtoDel limit 1];
        
        delete toDel;
        
        load(this.contact.id);
        

        
        return null;    
    }


    public PageReference delCIs(){
    

        this.IdtoDel = Apexpages.currentPage().getParameters().get('IdtoDelete');  
    
        Contact_Influence__c toDel= [ SELECT id FROM Contact_Influence__c 
                                     WHERE Contact_Influenced__c = :this.contact.id AND Contact_Influences__c = :IdtoDel  limit 1];
        
        delete toDel;
        
        load(this.contact.id);
        
        return null;       
    }

    public PageReference InsertCIs(){
        if(this.CIs.Contact_Influences__c == null) {
            return null;
        }

        system.debug('InsertCIs');
        system.debug('InsertCIs2 '+this.CIs.Contact_Influences__c+'---'+this.contact.Id);
        Contact targetContact = [SELECT name, id, accountid FROM Contact WHERE Id = :this.CIs.Contact_Influences__c];
        Boolean noErrors = true;
        if(targetContact.Id==this.contact.Id) {
            contact.addError(Label.SCP_noMismoContacto);
            noErrors = false;
        }
        
        if(targetContact.AccountId!=this.contact.AccountId) {
            contact.addError(Label.Influence_Same_Account);
            noErrors = false;
        }
        
        if(noErrors){
            
                insert this.CIs;
            
                this.CIs = null;        
                this.CIs = new Contact_Influence__c();
                this.CIs.Contact_Influenced__c = this.contact.id;
                
                load(this.contact.id);
        }        
        return null;
    }
    
    public PageReference InsertCId(){
        if(this.CId.Contact_Influenced__c == null) {
            return null;
        }
        
        system.debug('InsertCId');
        system.debug('InsertCId2 '+this.CId.Contact_Influenced__c+'---'+this.contact.Id);

        Contact targetContact = [SELECT name, id, accountid FROM Contact WHERE Id = :this.CId.Contact_Influenced__c];

        Boolean noErrors = true;
        if(targetContact.Id==this.contact.Id) {
            contact.addError(Label.SCP_noMismoContacto);
            noErrors = false;
        }
        
        if(targetContact.AccountId!=this.contact.AccountId) {
            contact.addError(Label.Influence_Same_Account);
            noErrors = false;
        }
        
        if(noErrors){
            insert this.CId;
        
            this.CId = null;        
            this.CId = new Contact_Influence__c();
            this.CId.Contact_Influences__c = this.contact.id;
        
            load(this.contact.id);
        
        }
        
        return null;
    }
   
    public PageReference saveAndRedirect() {
        //update contact;
        PageReference GoToPage = new PageReference('/apex/accountOrganizationChartWindow?id='+this.contact.accountid);
        GoToPage.setRedirect(true);
        return GoToPage;
    }
}