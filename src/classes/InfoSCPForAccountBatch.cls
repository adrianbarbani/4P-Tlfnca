global class InfoSCPForAccountBatch implements Database.Batchable<sObject>, Database.Stateful {
	
	global Map<Id,Account_Data__c> accountDataMap; 

	global InfoSCPForAccountBatch() {}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		
		accountDataMap = new Map<Id,Account_Data__c>();				

		delete [select id from Account_Data__c];

		For (Account a :[select id,
								(select id, lastModifiedDate from StrategicInitiatives__r order by lastModifiedDate desc),
								(select id, convertCurrency(Estimated_FCV__c) from GAP_Potential_New_Business__r),
								(select id, lastModifiedDate from Account_Competitors__r order by lastModifiedDate desc),
								(select id from Past_Activitys__r order by year__c desc Limit 1),
								(select id from Accounts_Reviews__r order by lastModifiedDate desc Limit 1)
								from account]) {

			Account_Data__c accountData = new Account_Data__c();
			accountData.account__c = a.id;
			accountData.competitors_Number__c = a.account_Competitors__r.size();
			if (!a.account_Competitors__r.isEmpty()) {
				accountData.competitors_Last_update__c = a.account_Competitors__r.get(0).lastModifiedDate;
			}
			if (!a.Past_Activitys__r.isEmpty()) {
				accountData.past_Activity__c = a.Past_Activitys__r.get(0).id;
			}
			accountData.pnb_Amount__c = 0;
			for (Potential_New_Business__c pnb :a.GAP_Potential_New_Business__r) {
				if (pnb.Estimated_FCV__c != null) {
				    accountData.pnb_Amount__c += pnb.Estimated_FCV__c;
				}
			}

			accountData.strategic_Initiative_Number__c = a.StrategicInitiatives__r.size();
			if (!a.StrategicInitiatives__r.isEmpty()) {
				accountData.Strategic_Initiative_Last_Update__c = a.StrategicInitiatives__r.get(0).lastModifiedDate;
			}
			accountData.opportunities_With_RDM__c = 0;
			accountData.opportunities_With_VD__c = 0;
                                    
			if (!a.Accounts_Reviews__r.isEmpty()) {
				accountData.Account_Review__c = a.Accounts_Reviews__r.get(0).id;
			}
			
      		if(util.checkMultiCurrencyEnabled()){
                   accountData.CurrencyIsoCode__c = Util.getCompanyIsoCode();
                
            } else {
              accountData.CurrencyIsoCode__c = '$';  
            }
                                    
			accountDataMap.put(a.id,accountData);
			
		}
        
		String query = 'select id, accountId, ' +
						'(select id from IndustryTrends__r), ' +
						'(select id from OpportunityPastProvenValueNew__r), ' +
						'(select id from StrategicInitiatives__r), ' +
						'(select id from ContactsAssessments__r) ' +
						'from Opportunity';	

		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		
        for(Sobject s : scope) {
			Opportunity opp = (Opportunity)s;

			Account_Data__c accountData = accountDataMap.get(opp.accountId);
			if (!opp.IndustryTrends__r.isEmpty() || !opp.OpportunityPastProvenValueNew__r.isEmpty() || !opp.StrategicInitiatives__r.isEmpty()) {
				accountData.opportunities_With_VD__c++;
			}
			if (!opp.ContactsAssessments__r.isEmpty()) {
				accountData.opportunities_With_RDM__c++;
			}
		}
	}
	
	global void finish(Database.BatchableContext BC) {
		upsert accountDataMap.values();
	}
	
}