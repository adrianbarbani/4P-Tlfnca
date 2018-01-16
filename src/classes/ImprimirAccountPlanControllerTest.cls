@isTest
private class ImprimirAccountPlanControllerTest {

    static testMethod void myUnitTest() {
        Account myAccount=new Account(Name = 'Test');
        insert myAccount;
        
        PageReference pageRef = Page.ImprimirAccountPlan;
        Test.setCurrentPage(pageRef);       
        System.currentPagereference().getParameters().put('id',myAccount.id);
        
        ImprimirAccountPlanController acr = new ImprimirAccountPlanController();
        acr.save();
        ImprimirAccountPlanController acr2 = new ImprimirAccountPlanController();
        acr2.ExportToWord();
        acr2.getWordName();
    }
}