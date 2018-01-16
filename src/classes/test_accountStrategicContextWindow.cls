@isTest
private class test_accountStrategicContextWindow {

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
        
        insert cuenta;
        
        Strategic_Initiative__c newInitiative = new Strategic_Initiative__c();

        newInitiative.account__c = cuenta.id;
        insert newInitiative;
        
        System.currentPagereference().getParameters().put('id',cuenta.id);
        
        accountStrategicContextWindow p_Test = new accountStrategicContextWindow();
        
        p_Test.loadData();
        
        p_Test.SaveChanges();    
        
        p_Test.InsertIniciative();     
        

        
        p_Test.delid = newInitiative.Id;
        p_Test.DeleteStrategicInitiatives();
 
    p_Test.borra();
    p_Test.borra2();
    }
}