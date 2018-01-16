@isTest
private class Test_AdminProvenValueController {

    static testMethod void myUnitTest() {
        
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        insert regionLocal;
        
        AdminProvenValueController controller = new AdminProvenValueController();        
        
        controller.newPruvenValue.Type__c = controller.getProvenValueTypes().get(0).getValue();
        controller.newPruvenValue.Unique_Value__c = 'Test'; 
        controller.regionId = controller.getRegions().get(0).getValue();
        controller.industry = controller.getIndustries().get(0).getValue();
        
        controller.InsertNew();
        
        controller.IdtoDelete = controller.newPruvenValue.id;
        controller.del();
        
    }

}