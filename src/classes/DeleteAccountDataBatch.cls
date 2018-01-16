global class DeleteAccountDataBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        String query = 'select id from Account_Data__c';        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {    
        
        List<Account_Data__c> accountData = (List<Account_Data__c>)scope;
        delete accountData;
    }
    
    global void finish(Database.BatchableContext BC) {
        
        Database.executeBatch(new CreateAccountDataBatch());
    }
}