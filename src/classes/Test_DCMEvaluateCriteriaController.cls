@isTest
private class Test_DCMEvaluateCriteriaController {

    static testMethod void myUnitTest() {
        
        PageReference pageRef = Page.DCMEvaluateCriteria;
        Test.setCurrentPage(pageRef);
        
        Account acc = new Account(Name = 'Account test');
        insert acc;        
        Opportunity opp = new Opportunity(Name = 'Test Opp', accountid = acc.id, stageName = 'Open', closeDate = system.today());
        insert opp;
        
        
        ApexPages.currentPage().getParameters().put('id', opp.id);
        DCMEvaluateCriteriaController dcmController = new DCMEvaluateCriteriaController();
        
		dcmController.newCriteria = 'Test Criteria';
		
		dcmController.addNewCriteria();
		
		dcmController.getOurVK();
		dcmController.getOurVW();
		dcmController.getOurVS();
		dcmController.getOurNV();
		dcmController.getCompetitorVK();
		dcmController.getCompetitorVW();
		dcmController.getCompetitorVS();
		dcmController.getCompetitorNV();         
		dcmController.getNotEvaluatedDCM();
		dcmController.criteriaToEvaluate = 'Test Criteria';
		dcmController.popCriteriaEvaluation();
		SCP_Criteria_DCM__c myMewEval = new SCP_Criteria_DCM__c(Criteria__c = 'Test Criteria', Our_Competitive_Standing__c = 'HIGH', Customer_Consideration__c = 'HIGH', Competitors_Competitive_Standing__c = 'HIGH');                 
        dcmController.newEval = myMewEval;
        dcmController.InsertEvaluation();
        dcmController.delid = myMewEval.id;
        dcmController.saveEvaluatedDCM();
        dcmController.DeleteEvaluation();
        
    }
}