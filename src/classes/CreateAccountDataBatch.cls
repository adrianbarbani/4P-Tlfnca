global class CreateAccountDataBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
                
        String query = 'select id,'+
                    '(select id, lastModifiedDate from StrategicInitiatives__r order by lastModifiedDate desc),'+
                    '(select id, Estimated_FCV__c from GAP_Potential_New_Business__r),'+
                    '(select id, lastModifiedDate from Account_Competitors__r order by lastModifiedDate desc),'+
                    '(select id from Past_Activitys__r order by year__c desc Limit 1),'+
                    '(select id from Accounts_Reviews__r order by lastModifiedDate desc Limit 1)'+
                    'from account where type != \'Prospect\' AND BI_segment__c = \'Empresas\' ';	

		return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {    
        List<Account> accs = (List<Account>)scope;
        
        List<Account_Data__c> accountDataAInsertar = new List<Account_Data__c>();
        for(Account cuenta: accs){

            Account_Data__c accountData = new Account_Data__c();
			accountData.account__c = cuenta.id;
			accountData.competitors_Number__c = cuenta.account_Competitors__r.size();
			
            if (!cuenta.account_Competitors__r.isEmpty()) {
				accountData.competitors_Last_update__c = cuenta.account_Competitors__r.get(0).lastModifiedDate;
			}
			
            if (!cuenta.Past_Activitys__r.isEmpty()) {
				accountData.past_Activity__c = cuenta.Past_Activitys__r.get(0).id;
			}
			
            accountData.pnb_Amount__c = 0;
            for (Potential_New_Business__c pnb :cuenta.GAP_Potential_New_Business__r) {
				if (pnb.Estimated_FCV__c != null) {
				    accountData.pnb_Amount__c += pnb.Estimated_FCV__c;
				}
			}

			accountData.strategic_Initiative_Number__c = cuenta.StrategicInitiatives__r.size();
			if (!cuenta.StrategicInitiatives__r.isEmpty()) {
				accountData.Strategic_Initiative_Last_Update__c = cuenta.StrategicInitiatives__r.get(0).lastModifiedDate;
			}
			accountData.opportunities_With_RDM__c = 0;
			accountData.opportunities_With_VD__c = 0;
                                    
			if (!cuenta.Accounts_Reviews__r.isEmpty()) {
				accountData.Account_Review__c = cuenta.Accounts_Reviews__r.get(0).id;
			}
			
      		if(util.checkMultiCurrencyEnabled()){
                   accountData.CurrencyIsoCode__c = Util.getCompanyIsoCode();
                
            } else {
              accountData.CurrencyIsoCode__c = '$';  
            }
                                    
			accountDataAInsertar.add(accountData);

        }
        
        insert accountDataAInsertar;
    }
    
    global void finish(Database.BatchableContext BC) {
        Database.executeBatch(new SetOpportunityToAccountDataBatch());
    }
}