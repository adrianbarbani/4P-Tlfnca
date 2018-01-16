@isTest
private class test_SCPMenu {

    static testMethod void myUnitTest() {
    
        SCPMenu p_Test = new SCPMenu();        

    }
    
    static testMethod void myUnitTest2() {
    
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.industry = 'Banking';
        
        insert cuenta;
    
        System.currentPagereference().getParameters().put('id',cuenta.id);
        SCPMenu p_Test = new SCPMenu();        

    }
    
    static testMethod void myUnitTest3() {
    
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.industry = 'Banking';
        
        insert cuenta;
        
        Opportunity opp = new Opportunity(Name='test', StageName='Prospecting', CloseDate=system.today());
        opp.accountId = cuenta.id;
        insert opp;
    
        System.currentPagereference().getParameters().put('id',opp.id);
        SCPMenu p_Test = new SCPMenu();        

    }
    
    static testMethod void myUnitTest4() {
    
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.industry = 'Banking';
        
        insert cuenta;
        
        Contact c = new Contact();
        c.accountId = cuenta.id;
        c.LastName = 'test';
        insert c;
    
        System.currentPagereference().getParameters().put('id',c.id);
        SCPMenu p_Test = new SCPMenu();        

    }
}