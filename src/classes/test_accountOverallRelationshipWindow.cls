@isTest
private class test_accountOverallRelationshipWindow {

    static testMethod void myUnitTest() {
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        insert regionLocal;
        
        Account cuentaPadre =new Account();
        cuentaPadre.Name='testPadre';
        cuentaPadre.Region__c=regionGlobal.id;
      
      insert cuentaPadre;
      
      
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.Region__c=regionLocal.id;
        cuenta.parentId = cuentaPadre.id;
        cuenta.industry = 'Banking';
        
        insert cuenta;
        
        System.currentPagereference().getParameters().put('id',cuenta.id);
        
    accountOverallRelationshipWindow p_Test = new accountOverallRelationshipWindow();    
    p_Test.SaveChanges();
    
    Account_Competitor__c newCompetitor = new Account_Competitor__c();
    newCompetitor.Account__c = cuenta.id;
    insert newCompetitor;
    
    p_Test.delid = newCompetitor.id;
    
    p_Test.DeleteCompetitor();
    /*
    p_Test.newCompetitor.Name = 'Test';
    p_Test.newCompetitor.Fact__c = 'Fact';
    p_Test.InsertCompetitor();
    */
    
  }
}