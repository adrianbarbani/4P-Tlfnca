@isTest
private class test_OpportunityEvaluations {

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
        
        System.currentPagereference().getParameters().put('id',opp.id);

        
        OpportunityEvaluations p = new OpportunityEvaluations();
        
        p.getFooterStyle();
        p.getNotEvaluated();
        //p.getParentNotEvaluated();
        
        p.contactIdToEvaluate = contacto.id;
        p.popContactEvaluation();
        p.newEval.Contact__c = contacto.id;
        p.popContactEvaluationFromX();
        
        p.InsertEvaluation();
        p.SaveChanges();
        p.copyRDM();
        
        p.delid = ca.Id;
        p.DeleteEvaluation();
        
        //Test to UserAction Class
        userActions ua = new userActions();
        ua.checkWrite(cuenta);
        ua.checkWrite(cuenta.id);
        
        //Test to Util Class        
        Util.transforma_miles(-10.10);
        Util.getCurrencyConverted(10.2,'EUR','USD');
        Util.getUserIsoCode();
        Util.getCompanyIsoCode();
        Util.getUserHierarchy(UserInfo.getUserId());
        
    }
}