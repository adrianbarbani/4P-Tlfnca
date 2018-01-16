@isTest
private class test_AccountOpportunities { 
    
    static testMethod void myUnitTest() {
        
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        insert regionLocal;
        
        Account cuenta=new Account();
        cuenta.region__c = regionLocal.id;
        cuenta.Name='test';
        
        insert cuenta;
        
        Opportunity opp = new Opportunity(Name = 'Test Opp', accountId = cuenta.id, StageName = 'Prospect', CloseDate = System.Today());
        
        opp.full_contract_value__c = 1000;
        opp.Estimated_Year_End_Revenue__c = 1000;        
        opp.Estimated_FCV__c = 1000;
        opp.Estimated_FCV_Calculated__c = 1000;
        
        insert opp;
        
        Opportunity opp2 = new Opportunity(Name = 'Test Opp2', accountId = cuenta.id, StageName = 'Prospect', CloseDate = System.Today());
        
        opp2.amount = 1000;
                
        insert opp2;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(cuenta);
        
        AccountOpportunities p = new AccountOpportunities(controller);
        p.getFields();
        p.getOperators();
        p.filterLogic = '';
        p.field = 'Name';
		p.operator = '%val%';
		p.value = 'Test';
		
		p.field1 = 'Name';
		p.operator1 = 'val%';
		p.value1 = 'Test';
		
		p.field2 = 'Name';
		p.operator2 = '%val';
		p.value2 = 'Test';
		
		p.field3 = 'Name';
		p.operator3 = '=';
		p.value3 = 'Test';
		

		p.field4 = 'Amount';
		p.operator4 = '!=';
		p.value4 = '2';
        
        p.setFilter();
        
        p.field = 'Name';
		p.operator = '%val%';
		p.value = 'Test';
		
		p.field1 = 'Name';
		p.operator1 = 'val%';
		p.value1 = 'Test';
		
		p.field2 = 'Name';
		p.operator2 = '%val';
		p.value2 = 'Test';
		
		p.field3 = 'Name';
		p.operator3 = '=';
		p.value3 = 'Test';
		
		p.field4 = 'Amount';
		p.operator4 = '!=';
		p.value4 = 'to fail';
		
		p.setFilter();
		
		p.field = 'Name';
		p.operator = '%val%';
		p.value = 'Test';
		
		p.field1 = 'Name';
		p.operator1 = 'val%';
		p.value1 = 'Test';
		
		p.field2 = 'Name';
		p.operator2 = '%val';
		p.value2 = 'Test';
		
		p.field3 = 'Name';
		p.operator3 = '>';
		p.value3 = 'to fail';
		
		p.field4 = 'Amount';
		p.operator4 = '%val';
		p.value4 = 'to fail';
		
		p.filterLogic = 'to fail';
		
		p.setFilter();
    }

}