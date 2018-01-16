@isTest
private class test_deleteContactInfluences {

    static testMethod void myUnitTest() {
        
        Contact c = new Contact(LastName = 'test');
        
        insert c;
        
        delete c;
        
    }
}