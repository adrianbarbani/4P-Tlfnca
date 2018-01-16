public with sharing class accountUpsellingOpportunitiesWindowNew {
    
    public Account account { get; set; }
    public Date now {get; set;}
    public Boolean canEdit {get;set;}
    public List<Contract> ourContracts {get;set;}
    public List<Contract> competitorContracts {get;set;} 
    
    public accountUpsellingOpportunitiesWindowNew() {
        this.now = Date.today();
        this.account = [SELECT name, id, parentId, Industry, Region__c, Region__r.Currency__c, Region__r.Currency_Name__c FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        
        ourContracts = new List<Contract>();
        competitorContracts = new List<Contract>(); 
        
        for (Contract c :[select id, ContractNumber, description, StartDate, ContractTerm, EndDate, mrc__c, fcv__c, competitorName__c, isCompetitorContract__c from Contract where accountid = :account.id]) {
            if (!c.isCompetitorContract__c) {
                ourContracts.add(c);
            } else {
                competitorContracts.add(c);
            }               
        }       
        
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);
    }
    
    public PageReference SaveChanges() {
        update ourContracts;
        update competitorContracts;
        return null;
    }
}