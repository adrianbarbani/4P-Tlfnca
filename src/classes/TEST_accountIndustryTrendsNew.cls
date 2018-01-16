@isTest
public class TEST_accountIndustryTrendsNew {
    public static testMethod void initiallyTheAccountData_AndTheTrendTypesShouldBeLoaded () {
        Account anAccount = Build.anAccount().withName('John Pepeson inc.').Build();
        insert anAccount;
        
        test.setCurrentPageReference(new PageReference('Page.Certa_SCP.accountIndustryTrends')); 
		System.currentPageReference().getParameters().put('Id', anAccount.Id);
        
        accountIndustryTrendsNew controller = new accountIndustryTrendsNew();
        
        System.assertEquals(anAccount.Id, controller.account.Id);
        
        List<Schema.PicklistEntry> TypePicklist = Industry_Trend__c.Type__c.getDescribe().getPicklistValues();
        Set<string> Types = new Set<string>();
        for(Schema.PicklistEntry aType : TypePicklist) {
            Types.add(aType.getLabel());
        }
        
        for (integer i = 0; i < controller.trendsWrapperList.size(); i++) {
            System.assert(Types.contains(controller.trendsWrapperList[i].type));
        }
        System.assert(Types.contains(controller.SolutionsLabel));
    }
    
    public static testMethod void theIndustryTrend_AccountRelationshipShouldBeCreatedForSolutionsThatDoesntHaveOneForTheAccount() {
        string anIndustry = 'some industry';
        string aMicroIndustry = 'some micro industry';
        Region__c aRegion = Build.aRegion().withName('Robonia').withParent(null).build();
        insert aRegion;
        Account anAccount = Build.anAccount().withName('John Pepeson inc.').withIndustry(anIndustry).withMicroIndustry(aMicroIndustry).withRegion(aRegion.Id).Build();
        insert anAccount;
        Industry_Trend__c aSolution = Build.anIndustryTrend().withTrend('someTrend').withTitle('some title').withRegion(aRegion.Id).withType('Soluciones').withSubSector(anIndustry).withIndustry(aMicroIndustry).build();
        insert aSolution;
        
        test.setCurrentPageReference(new PageReference('Page.Certa_SCP.accountIndustryTrends')); 
		System.currentPageReference().getParameters().put('Id', anAccount.Id);
        
        accountIndustryTrendsNew controller = new accountIndustryTrendsNew();
        
        System.assertEquals(1, controller.Solutions.size());
        System.assertEquals(aSolution.Id, controller.Solutions[0].trend.Id);
        System.assertEquals(null, controller.Solutions[0].Status.Id);
        System.assertEquals(anAccount.Id, controller.Solutions[0].Status.Account__c);
        System.assertEquals(aSolution.Id, controller.Solutions[0].Status.Industry_Trend__c);
    }
    
    public static testMethod void theIndustryTrend_AccountRelationshipShouldBeLoadedForSolutions() {
	    string anIndustry = 'some industry';
        string aMicroIndustry = 'some micro industry';
        Region__c aRegion = Build.aRegion().withName('Robonia').withParent(null).build();
        insert aRegion;
        Account anAccount = Build.anAccount().withName('John Pepeson inc.').withIndustry(anIndustry).withMicroIndustry(aMicroIndustry).withRegion(aRegion.Id).Build();
        insert anAccount;
        Industry_Trend__c aSolution = Build.anIndustryTrend().withTrend('someTrend').withTitle('some title').withRegion(aRegion.Id).withType('Soluciones').withSubSector(anIndustry).withIndustry(aMicroIndustry).build();
        insert aSolution;
        Account_Industry_trend__c anAccountIndustryTrendRelation = Build.anAccountIndustryTrend().withAccount(anAccount.Id).withIndustryTrend(aSolution.Id).withStatus('some status').build();
        insert anAccountIndustryTrendRelation;
        
        test.setCurrentPageReference(new PageReference('Page.Certa_SCP.accountIndustryTrends')); 
		System.currentPageReference().getParameters().put('Id', anAccount.Id);
        
        accountIndustryTrendsNew controller = new accountIndustryTrendsNew();
		
		System.assert(controller.Solutions.size() > 0);        
        System.assertEquals(anAccountIndustryTrendRelation.Id, controller.Solutions[0].Status.Id);
    }
    
    public static testMethod void itShouldBePosibleToSaveChangesToTheIndustryTrend_AccountRelationship() {
        string anIndustry = 'some industry';
        string aMicroIndustry = 'some micro industry';
        Region__c aRegion = Build.aRegion().withName('Robonia').withParent(null).build();
        insert aRegion;
        Account anAccount = Build.anAccount().withName('John Pepeson inc.').withIndustry(anIndustry).withMicroIndustry(aMicroIndustry).withRegion(aRegion.Id).Build();
        insert anAccount;
        Industry_Trend__c aSolution = Build.anIndustryTrend().withTrend('someTrend').withTitle('some title').withRegion(aRegion.Id).withType('Soluciones').withSubSector(anIndustry).withIndustry(aMicroIndustry).build();
        insert aSolution;
        
        test.setCurrentPageReference(new PageReference('Page.Certa_SCP.accountIndustryTrends')); 
		System.currentPageReference().getParameters().put('Id', anAccount.Id);
        
        accountIndustryTrendsNew controller = new accountIndustryTrendsNew();
        string someStatus = 'Linking';
        controller.Solutions[0].Status.Current_state__c = someStatus;
        controller.save();
        
        List<Account_Industry_trend__c> relations = [SELECT Id, Current_state__c FROM Account_Industry_trend__c WHERE Account__c = :anAccount.Id AND Industry_trend__c = :aSolution.Id];
        System.assertEquals(1, relations.size());
        System.assertEquals(controller.Solutions[0].Status.Id, relations[0].Id);
        System.assertEquals(someStatus, relations[0].Current_state__c);
    }
    
    public static testMethod void allIndustryTrendsShouldBeLoadedUnderTheAppropiateWrapper() {
        string anIndustry = 'some industry';
        string aMicroIndustry = 'some micro industry';
        Region__c aRegion = Build.aRegion().withName('Robonia').withParent(null).build();
        insert aRegion;
        Account anAccount = Build.anAccount().withName('John Pepeson inc.').withIndustry(anIndustry).withMicroIndustry(aMicroIndustry).withRegion(aRegion.Id).Build();
        insert anAccount;
        
        List<Schema.PicklistEntry> TypePicklist = Industry_Trend__c.Type__c.getDescribe().getPicklistValues();
        List<string> Types = new List<string>();
        for(Schema.PicklistEntry aType : TypePicklist) {
            Types.add(aType.getLabel());
        }
        
        List<Industry_Trend__c> Trends = new List<Industry_Trend__c>();
        for(integer i = 0; i < Types.size(); i++) {
            Trends.add(Build.anIndustryTrend().withTrend('someTrend').withTitle('some title').withRegion(aRegion.Id).withType(Types[i]).withSubSector(anIndustry).withIndustry(aMicroIndustry).build());
        }
        insert Trends;
        
        test.setCurrentPageReference(new PageReference('Page.Certa_SCP.accountIndustryTrends')); 
		System.currentPageReference().getParameters().put('Id', anAccount.Id);
        
        accountIndustryTrendsNew controller = new accountIndustryTrendsNew();
        
        for(integer i = 0; i < controller.trendsWrapperList.size(); i++) {
            System.assertEquals(1, controller.trendsWrapperList[i].Trends.size());
        }
    }
    
    //should load solutions and all other Industry_trend__c
    
    public static testMethod void unWrapperNecesidadNoAgregaDosVecesLaMismaOportunidad (){
        
        AccountIndustryTrendsNew.NecesidadWrapper necesidadWpp = new AccountIndustryTrendsNew.NecesidadWrapper('necesidad1', 'unId');
        AccountIndustryTrendsNew.OportunidadWrapper OportunidadWrapper = new AccountIndustryTrendsNew.OportunidadWrapper('oportunidad1', 'otroId');
        
        necesidadWpp.agregarOportunidad(OportunidadWrapper);
        necesidadWpp.agregarOportunidad(OportunidadWrapper);
        
        system.assertEquals(1, necesidadWpp.oportunidades.size());
    }
}