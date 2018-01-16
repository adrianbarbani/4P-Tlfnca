@isTest
private class test_owrap {

    static testMethod void myUnitTest() {
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.industry = 'Banking';        
        insert cuenta;
        
        Opportunity opp = new Opportunity(Name='test opportunity');
        opp.StageName = 'Open';
        opp.CloseDate = System.Today();
        opp.accountId = cuenta.Id;
        Owrap o = new Owrap(opp);       
        o.getFull_Contract_Value(); 
        o.getUnique_Charges();
        o.getMonthly_Charges();
        o.getEstimated_Year_End_Revenue();
        o.getUnsold_Pipeline();
        o.getWeighted_Estimated_Year_End_Revenue();
        o.getEstimated_FCV();
        o.getEstimated_FCV_Calculated();        
        o.getTotal_Forecasted_FCV();
        
        opp.Estimated_Year_End_Revenue__c = 10;
        opp.Full_Contract_Value__c = 10;
        opp.Unique_Charges__c = 10;
        opp.Monthly_Charges__c = 10;
        opp.Estimated_Year_End_Revenue__c = 10; 
        opp.Estimated_FCV__c = 10;
        opp.Estimated_FCV_Calculated__c = 10;
               
        if(Util.checkMultiCurrencyEnabled()){
            opp.put('CurrencyIsoCode','EUR');
        }
        
    opp.Probability = 10;
    insert opp;    
    
    Owrap o2 = new Owrap(opp);                
        o2.getFull_Contract_Value(); 
        o2.getUnique_Charges();
        o2.getMonthly_Charges();
        o2.getEstimated_Year_End_Revenue();
        o2.getUnsold_Pipeline();
        o2.getWeighted_Estimated_Year_End_Revenue();
        o2.getEstimated_FCV();
        o2.getEstimated_FCV_Calculated();        
        o2.getTotal_Forecasted_FCV();
                
    }
}