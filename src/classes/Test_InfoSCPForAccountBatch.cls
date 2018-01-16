@isTest
private class Test_InfoSCPForAccountBatch {
	
    /*
	@isTest static void test_accountWithoutData() {
		
		Account acct = new Account(Name = 'Test');
		insert acct;
		system.assertEquals(1, [select id from Account].size());

		system.assertEquals(0, [select id from Account_Data__c].size());

		Test.startTest();
		Database.executeBatch(new InfoSCPForAccountBatch());
		Test.stopTest();

		List<Account_Data__c> resultAccountData = [select id, account__c, competitors_Number__c, past_Activity__c, pnb_Amount__c, strategic_Initiative_Number__c, opportunities_With_RDM__c, opportunities_With_VD__c, account_Review__c
													from Account_Data__c];
		system.assertEquals(1, resultAccountData.size());

		Account_Data__c accountData = resultAccountData.get(0);

		system.assertEquals(acct.id,accountData.account__c);
		system.assertEquals(0,accountData.competitors_Number__c);
		system.assertEquals(null,accountData.past_Activity__c); 
		system.assertEquals(0,accountData.pnb_Amount__c);
		system.assertEquals(0,accountData.strategic_Initiative_Number__c);
		system.assertEquals(0,accountData.opportunities_With_RDM__c);
		system.assertEquals(0,accountData.opportunities_With_VD__c);
		system.assertEquals(null,accountData.Account_Review__c);

	}
	
	@isTest static void test_accountWithAllData() {

		Account acct = new Account(Name = 'Test');
		insert acct;
		system.assertEquals(1, [select id from Account].size());

		Opportunity opp = new Opportunity(Name = 'Test', accountId = acct.id, CloseDate = System.today(), StageName = 'Open');
		insert opp;
		system.assertEquals(1, [select id from Opportunity].size());

		Account_Competitor__c competitor = new Account_Competitor__c(Account__c = acct.id);
		insert competitor;
		system.assertEquals(1, [select id from Account_Competitor__c].size());

		PastActivity__c pastActivity = new PastActivity__c(Account__c = acct.id); 
		insert pastActivity;
		system.assertEquals(1, [select id from PastActivity__c].size());

		Potential_New_Business__c pnb = new Potential_New_Business__c(Account__c = acct.id, Estimated_FCV__c = 100);
		insert pnb;
		system.assertEquals(1, [select id from Potential_New_Business__c].size());

		Strategic_Initiative__c strategic = new Strategic_Initiative__c(Account__c = acct.id);
		insert strategic;
		system.assertEquals(1, [select id from Strategic_Initiative__c].size());

		Contact contact = new Contact(LastName = 'Test', FirstName = 'Contact', AccountId = acct.id);
		insert contact;
		system.assertEquals(1, [select id from Contact].size());
		
		Contact_Assessment__c contactAssessment = new Contact_Assessment__c(Contact__c = contact.id, Opportunity__c = opp.id);
		insert contactAssessment;
		system.assertEquals(1, [select id from Contact_Assessment__c].size());

		OpportunityStrategicInitiative__c oppStrategic = new OpportunityStrategicInitiative__c(Strategic_Initiative__c = strategic.id,Opportunity__c = opp.id);
		insert oppStrategic;
		system.assertEquals(1, [select id from OpportunityStrategicInitiative__c].size());

		Account_Review__c accountReview = new Account_Review__c(Account__c = acct.id);
		insert accountReview;
		system.assertEquals(1, [select id from Account_Review__c].size());		


		system.assertEquals(0, [select id from Account_Data__c].size());

		Test.startTest();
		Database.executeBatch(new InfoSCPForAccountBatch());
		Test.stopTest();

		List<Account_Data__c> resultAccountData = [select id, account__c, competitors_Last_update__c, strategic_Initiative_Last_Update__c, competitors_Number__c, past_Activity__c, pnb_Amount__c, strategic_Initiative_Number__c, opportunities_With_RDM__c, opportunities_With_VD__c, account_Review__c
													from Account_Data__c];
		system.assertEquals(1, resultAccountData.size());

		Account_Data__c accountData = resultAccountData.get(0);

		system.assertEquals(acct.id,accountData.account__c);
		system.assertEquals(1,accountData.competitors_Number__c);
		system.assertEquals(pastActivity.id,accountData.past_Activity__c); 
		system.assertEquals(100,accountData.pnb_Amount__c);
		system.assertEquals(1,accountData.strategic_Initiative_Number__c);
		//system.assertEquals(1,accountData.opportunities_With_RDM__c);
		system.assertEquals(1,accountData.opportunities_With_VD__c);
		DateTime silu = accountData.strategic_Initiative_Last_Update__c;		
		system.assertEquals(system.today(),date.newinstance(silu.year(),silu.month(),silu.day()));
		DateTime clu = accountData.competitors_Last_update__c;		
		system.assertEquals(system.today(),date.newinstance(clu.year(),clu.month(),clu.day()));
		system.assertEquals(accountReview.id,accountData.account_Review__c);		
	}


	@isTest static void test_manyData() {

		Integer maxData = 199;

		List<Account> accounts = new List<Account>();
		for (Integer i=0;i<maxData;i++) {
			accounts.add(new Account(Name = 'Test' + i));
		}
		insert accounts;

		List<Opportunity> opps = new List<Opportunity>();
		for (Integer i=0;i<maxData;i++) {
			opps.add(new Opportunity(Name = 'Test' + i, accountId = accounts[i].id, CloseDate = System.today(), StageName = 'Open'));
		}

		Test.startTest();
		Database.executeBatch(new InfoSCPForAccountBatch());
		Test.stopTest();

		system.assertEquals(maxData, [select id from Account_Data__c].size());
	}	

    	@isTest static void test_manyDataBatchAccountBatch() {

		Integer maxData = 199;

		List<Account> accounts = new List<Account>();
		for (Integer i=0;i<maxData;i++) {
			accounts.add(new Account(Name = 'Test' + i));
		}
		insert accounts;

		List<Opportunity> opps = new List<Opportunity>();
		for (Integer i=0;i<maxData;i++) {
			opps.add(new Opportunity(Name = 'Test' + i, accountId = accounts[i].id, CloseDate = System.today(), StageName = 'Open'));
		}

		Test.startTest();
		Database.executeBatch(new InfoSCPForAccountBatch());
		Test.stopTest();

		system.assertEquals(maxData, [select id from Account_Data__c].size());
	}	*/
}