public class accountOverallRelationshipWindow {

    public Account account { get; set; }

    public Account_Competitor__c newCompetitor {get;set;}
    
    public List<Account_Competitor__c> newCompetitors { get; set; }
    
    public Integer year {get;set;}
    
    public String delid {
        get;
        set {
            delid = value;
        }
    }    
    
    public Boolean canEdit {get;set;}

    
    public accountOverallRelationshipWindow(){
        init();
    }
    
    private void init() {
    	this.account = [SELECT name, id, parentId, Industry, Region__c,
            Brand_Strengths__c, Brand_Weakness__c, Brand_Opportunities__c, Brand_Threats__c,
            Products_Services_Strengths__c, Products_Services_Weakness__c, Products_Services_Opportunities__c, Products_Services_Threats__c,
            People_Strengths__c, People_Weakness__c, People_Opportunities__c, People_Threats__c,
            Other_Strengths__c, Other_Weakness__c, Other_Opportunities__c, Other_Threats__c,
            CSAT_Unit__c, CSAT_Current_Year__c, CSAT_Last_Year__c, CSAT_Second_To_Last_Year__c
            FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
    
      	newCompetitors = new List<Account_Competitor__c>([SELECT Id, Name, Fact__c, LastModifiedDate FROM Account_Competitor__c where Account__c = :account.Id order by createdDate]);
		
		//InsertCompetitor();
		newCompetitor = new Account_Competitor__c(Account__c = account.id);
		
        Date today = Date.today();
        
        //this.year = today.year() -1;
        this.year = today.year();
        
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);
    }
    
    public PageReference SaveChanges() {
        List<Account_Competitor__c> lista_ac=new List<Account_Competitor__c>();
        List<Account_Competitor__c> lista_ac2=new List<Account_Competitor__c>();
        for(Account_Competitor__c ac:newCompetitors){
          if((((ac.Name!='' && ac.Name!=null) || (ac.Fact__c!='' && ac.Fact__c!=null)) && ac.id==null) || ac.id!=null)
            lista_ac.add(ac);
        }
        upsert lista_ac;
        update account;
        
        newCompetitors = new List<Account_Competitor__c>([SELECT Id, Name, Fact__c, LastModifiedDate FROM Account_Competitor__c where Account__c = :account.Id order by createdDate]);
        //InsertCompetitor();
        
        return null;
    }
    
    public void DeleteCompetitor() {
      List<Account_Competitor__c> lista_ac=new List<Account_Competitor__c>();
      for(Account_Competitor__c ac:newCompetitors){
        if(ac.Id!=null && ac.Id==delid){
          delete ac;
        }else{
          lista_ac.add(ac);
        }
      }
      newCompetitors=lista_ac;
    }
    
  	public PageReference add() {
  		insert newCompetitor;
  		init();
  		return null; 
  	}
  
  
    public void InsertCompetitor() {
        newCompetitors.add(new Account_Competitor__c(Account__c = account.id));
    }
  

}