@isTest
private class test_accountHistoricalBusinessWindow {
    
    static testMethod void myUnitTest() {
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
        

        System.currentPagereference().getParameters().put('id',cuenta.id);
        
        accountHistoricalBusinessWindow p_Test = new accountHistoricalBusinessWindow();
        //p_Test.getCurrencies();
        p_Test.SaveChanges();
        p_Test.SaveChanges();
        p_Test.getUserIsoCode();
        p_Test.getCompanyIsoCode();
        
        p_Test.thisyear.a__c = 1;
        p_Test.thisyear.b__c = 1;
        p_Test.thisyear.cc__c = 1;
        
        p_Test.lastyear.a__c = 1;
        p_Test.lastyear.b__c = 1;
        p_Test.lastyear.cc__c = 1;
        
        p_Test.last2year.a__c = 1;
        p_Test.last2year.b__c = 1;
        p_Test.last2year.cc__c = 1;
                
        p_Test.loadData();
        
        /*
        Outlok_Plan_Comercial__c opc = new Outlok_Plan_Comercial__c();
        opc.Previous_Fiscal_Year_Revenue__c = 100000;
        opc.Cuenta__c = cuenta.id;
        insert opc;        
        */
        p_Test.SaveChanges();
        /*
        if (Util.checkMultiCurrencyEnabled()) {
            opc.put('CurrencyIsoCode','EUR');
        }
        update opc;
        p_Test.SaveChanges();                
        */
        
                
    }
}