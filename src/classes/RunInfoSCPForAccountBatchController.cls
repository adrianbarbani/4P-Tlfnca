public with sharing class RunInfoSCPForAccountBatchController {

    public String msg {get;set;}

    public RunInfoSCPForAccountBatchController() {        
    }

    public void runBatch() {
        try {
            Database.executeBatch(new DeleteAccountDataBatch());            
        } Catch (Exception e) {
            ApexPages.addMessages(e);
        }
    }
}