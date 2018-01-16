@isTest
private class Test_AccountCustomReport {

    static testMethod void myUnitTest() {
        Account myAccount=new Account(Name = 'Test');
        insert myAccount;
        
        PageReference pageRef = Page.AccountCustomReport;
        Test.setCurrentPage(pageRef);       
        System.currentPagereference().getParameters().put('id',myAccount.id);
        
        AccountCustomReportController acr = new AccountCustomReportController();
        acr.save();
        AccountCustomReportController acr2 = new AccountCustomReportController();
        acr2.ExportToWord();
        acr2.getWordName();
    }
}