public with sharing class BigDealButtonsController {

	public Opportunity opp {get;set;}
    public Boolean isBigDealAdmin {get;set;}
    public Boolean isLightning {get;set;}    
    public String url {get;set;}
    private Id oppId;    

    public BigDealButtonsController(ApexPages.StandardController stdController) {
        oppId = stdController.getRecord().id;
        init();

        isBigDealAdmin = false;
        List<PermissionSetAssignment> psaList = [SELECT PermissionSetId, PermissionSet.Name FROM PermissionSetAssignment WHERE AssigneeId= :UserInfo.getUserId() AND PermissionSet.Name = 'Big_Deal_Admin'];
        if (psaList.size() > 0) {
            isBigDealAdmin = true;
        }

        url = ApexPages.currentPage().getUrl();
        if (url.contains('lightning')) {
            isLightning = true;
        } else {
            isLightning = false;
        }
        
    }

    private void init() {
        this.opp = [select id, bigDeals__c, Manual_Big_Deal__c from Opportunity where id = :oppId];
    }

    public void check() {
        opp.manual_Big_Deal__c = true;
        update opp;
        init();
        system.debug(opp);
    }

    public void uncheck() {
        opp.manual_Big_Deal__c = false;
        update opp;
        init();
        system.debug(opp);
    }

    public PageReference gotoSurvey() {
        return new PageReference(Page.opportunityBigDeal + '?id=' + opp.id);
    }
}