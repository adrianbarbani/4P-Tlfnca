@isTest
private class test_adminKPI {

    static testMethod void myUnitTest() {
    
    Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        insert regionLocal;

        Account cuentapapa=new Account();
        cuentapapa.Name='test';
        cuentapapa.Region__c=regionLocal.id;
        
        insert cuentapapa;
      
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.Region__c=regionLocal.id;
        cuenta.ParentId = cuentapapa.id;
        insert cuenta;
        
        
        adminKPI p = new adminKPI();
        p.checkStandardKPIs();
        p.getRegions();
        p.getIndustries();
        p.regionId = regionLocal.id;
        p.industry = 'Banking';
        p.doUpdate();
        p.getKPI();
        p.InsertNewKPI();
        
         KPI__c newKPI = new KPI__c();
        newKPI.Region__c = regionLocal.id;
        newKPI.Industry__c = 'Banking';
        insert newKPI;
        
        System.currentPagereference().getParameters().put('IdtoDelete',newKPI.id);
        
        p.del();
        
        p.getHashIndustry();
        
        
    }
}