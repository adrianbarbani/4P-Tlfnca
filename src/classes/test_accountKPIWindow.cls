@isTest
private class test_accountKPIWindow {

    static testMethod void myUnitTest() {
        
        //testeo sin industria
        Region__c regionGlobal = new Region__C(name='Global');
        regionGlobal.Currency_Name__c ='asd';
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        regionLocal.Currency_Name__c ='asd';
        insert regionLocal;
        Account cuentaPadre =new Account();
        cuentaPadre.Name='testPadre';
        cuentaPadre.Region__c=regionGlobal.id;
        
        insert cuentaPadre;
        
        
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.Region__c=regionLocal.id;
        cuenta.parentId = cuentaPadre.id;
        
        insert cuenta;
        

        
        System.currentPagereference().getParameters().put('id',cuenta.id);
        
        accountKPIWindow p_Test = new accountKPIWindow();
        
        
        p_Test.getIndustry();
        
    }
    
    static testMethod void myUnitTest2() {
        //Con industria
        Region__c regionGlobal = new Region__C(name='Global');
        regionGlobal.Currency_Name__c ='asd';
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        regionLocal.Currency_Name__c ='asd';
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
        
        //Kpi global.
        
        KPI__c temp = new KPI__c();
        temp.Name__c = 'Number of Branches';
        temp.Unit__c = 'Units';
        temp.Region__c = regionGlobal.id;
        temp.Industry__c = 'All';
        insert temp;
        
        //Kpi local.
        
        temp = new KPI__c();
        temp.Name__c = 'Gold';
        temp.Unit__c = 'Pounds';
        temp.Region__c = regionLocal.id;
        temp.Industry__c = 'Banking';
        insert temp;
        
        System.currentPagereference().getParameters().put('id',cuenta.id);
        
        accountKPIWindow p_Test = new accountKPIWindow();
        
        //p_Test.getIndustry();
        p_Test.SaveChanges();
        p_Test.addKPI();
        p_Test.delid = temp.id;
        p_Test.deleteKPI();
        
        
        
    }
}