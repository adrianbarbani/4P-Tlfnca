global class SetOpportunityToAccountDataBatch implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select id, opportunities_With_VD__c, opportunities_With_RDM__c, account__c from Account_Data__c';	
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<sObject> scope) {    
        List<Account_Data__c> accsData = (List<Account_Data__c>)scope;
        
        List<Id> cuentasABuscar = new List<Id>();
        for(Account_Data__c infoCuenta :accsData){
            cuentasABuscar.add(infoCuenta.account__c);
        }
        
        List <Opportunity> oportunidades = [select id, accountId,
                                            (select id from IndustryTrends__r),
                                            (select id from OpportunityPastProvenValueNew__r),
                                            (select id from StrategicInitiatives__r),
                                            (select id from ContactsAssessments__r)
                                            from Opportunity WHERE accountId IN: cuentasABuscar];
        system.debug(oportunidades);
        
        Map <Id, Integer> VDPorCuenta = new Map<Id, Integer>();
        Map <Id, Integer> RDMPorCuenta = new Map<Id, Integer>();
        
        for(Opportunity Opp : oportunidades){
            
            if (!Opp.IndustryTrends__r.isEmpty() || !Opp.OpportunityPastProvenValueNew__r.isEmpty() || !Opp.StrategicInitiatives__r.isEmpty()) {
                Integer valorVD = VDPorCuenta.get(Opp.accountId);
                if(valorVD != null){
                    VDPorCuenta.put(Opp.accountId, valorVD+1);
                }else{
                    VDPorCuenta.put(Opp.accountId, 1);  
                }
            }
            if ( !(Opp.ContactsAssessments__r.isEmpty()) ) {
                Integer valorRDM = RDMPorCuenta.get(Opp.accountId);
                if(valorRDM != null){
                    RDMPorCuenta.put(Opp.accountId, valorRDM+1);
                }else{
                    RDMPorCuenta.put(Opp.accountId, 1);  
                }
            }
        }
        
        for(Account_Data__c cuenta: accsData){
			
            Integer VD = VDPorCuenta.get(cuenta.account__c);
            if(VD != null){
                cuenta.opportunities_With_VD__c = VD;
            }
            
            Integer RDM = RDMPorCuenta.get(cuenta.account__c);
            if(RDM != null){
                cuenta.opportunities_With_RDM__c = RDM;
            }
        }
        
        update accsData;
    }
    
    global void finish(Database.BatchableContext BC) {
    }
}