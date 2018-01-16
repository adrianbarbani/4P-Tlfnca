@isTest
private class test_ExtendedEvaluation {

    static testMethod void myUnitTest() {
      
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.industry = 'Banking';
        
        insert cuenta;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Open';
        opp.CloseDate = System.Today();
        opp.accountId = cuenta.id;
        insert opp;
        

        Contact contacto = new Contact();
        contacto.LastName = 'test';
        contacto.AccountId = cuenta.id;
        insert contacto;
        
        Contact contacto2 = new Contact();
        contacto2.LastName = 'test';
        contacto2.AccountId = cuenta.id;
        contacto2.ReportsToId = contacto.id;
        insert contacto2;
        
        Contact_Influence__c ci = new Contact_Influence__c();
        ci.Contact_Influenced__c = contacto.id;
        ci.Contact_Influences__c = contacto2.id;
        insert ci;
        
        
        Contact_Assessment__c ca = new Contact_Assessment__c();
        ca.Contact__c = contacto.id;
        ca.Opportunity__c = opp.id;
        insert ca;
        
        ca = new Contact_Assessment__c();
        ca.Contact__c = contacto2.id;
        ca.Opportunity__c = opp.id;
        ca.Focus__c = 'End User';
        ca.Influence__c = 'Negative';
        ca.Attitudes__c = 'Negative';
        ca.Authority__c = 'Positive';
        ca.Buying_Cycle__c = 'Assessments of Alternatives';
        ca.Our_Relationship__c = 'Positive';
        ca.Competing_Company_Relationship__c = 'Positive';
        insert ca;
        
        //ExtendedEvaluation ee = new ExtendedEvaluation(ca);
        
        //ee.getAcciones();
        
        System.currentPagereference().getParameters().put('id',ca.id);
        
        
        ExtendedEvaluation ee = new ExtendedEvaluation();
        ExtendedEvaluation ee1 = new ExtendedEvaluation(null,null,null,null);
        ExtendedEvaluation ee2 = new ExtendedEvaluation(null,null,null);        
        
        ee.getContactEval();
        ee.getContactInfluenced();
        ee.getContactInfluences();
        ee.getActionsFocus();
        ee.getActionsAttitudes();
        ee.getRelationship();
        ee.getAcciones();
        
    }
}