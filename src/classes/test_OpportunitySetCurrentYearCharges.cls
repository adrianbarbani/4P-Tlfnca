@isTest
private class test_OpportunitySetCurrentYearCharges {
    static testMethod void testCalculateYearCharges() {
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.industry = 'Banking';        
        insert cuenta;
                
        Date billingStartDate = FiscalPeriodUtils.getFiscalYearEndDate().addDays(-300);
        Opportunity testOpp = new Opportunity(Name='UnitTest Opportunity', Estimated_Billing_Start_Date__c=billingStartDate, Monthly_Charges__c=100000, Unique_Charges__c=500000, StageName = 'Open', CloseDate = System.Today(), AccountId = cuenta.Id);
        insert testOpp;
        Opportunity verifyOpp = [select Estimated_Year_End_Revenue__c from Opportunity where Id = :testOpp.Id];
        System.assertEquals(1500000, verifyOpp.Estimated_Year_End_Revenue__c);
        billingStartDate = FiscalPeriodUtils.getFiscalYearEndDate().addDays(-150);
        testOpp.Estimated_Billing_Start_Date__c = billingStartDate;
        update testOpp;
        verifyOpp = [select Estimated_Year_End_Revenue__c from Opportunity where Id = :testOpp.Id];
        System.assertEquals(1000000, verifyOpp.Estimated_Year_End_Revenue__c);
    } 
}