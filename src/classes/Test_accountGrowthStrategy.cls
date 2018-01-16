@isTest
private class Test_accountGrowthStrategy {

    static testMethod void myUnitTest() {
        
        /* Create Region */
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionRegional = new Region__C(name='Regional', parent__c = regionGlobal.id);
        insert regionRegional;
        
        Region__c regionLocal = new Region__C(name='Local', parent__c = regionRegional.id);
        insert regionLocal;
        
        /* Create Account */
        String accountName = 'Account Test';
        Account acctGrandparent = new Account(Name=accountName, Region__c = regionRegional.id);
        insert acctGrandparent;
        
        Account acctParent = new Account(Name=accountName, Region__c = regionRegional.id, parentId = acctGrandparent.id);
        insert acctParent;
                
        Account acctWithoutRegion = new Account(Name=accountName);
        insert acctWithoutRegion;
        
        Account acct = new Account(Name=accountName, Region__c = regionLocal.id, parentId = acctParent.id);
        insert acct;
        
        List<Account> acctResult = [select id from Account where name = :accountName];
        system.Assert(acctResult.size()>0, 'Error to create Account: ' + acct);
        
        Strategic_Initiative__c strategic = new Strategic_Initiative__c();
        insert strategic;
        
        /* Set Page and Create Controller*/
        System.currentPagereference().getParameters().put('id',acctWithoutRegion.id);
        AccountGrowthStrategyController agsc = new AccountGrowthStrategyController();
        
        System.currentPagereference().getParameters().put('id',acct.id);
        AccountGrowthStrategyController controller = new AccountGrowthStrategyController();
        
    }
    
    static testMethod void myUnitTest2() {
        
        Region__c regionLocal = new Region__C(name='Local');
        insert regionLocal;
        
        Account acct = new Account(Name='Test', Region__c = regionLocal.id);
        insert acct;
        
        System.currentPagereference().getParameters().put('id',acct.id);
        AccountGrowthStrategyController controller = new AccountGrowthStrategyController();
        
        controller.save();
        controller.add();
        //controller.toDel = controller.PotentialNewBusinessList.get(0).id;
        //controller.del();
        
        controller.add();
        controller.pnbid = controller.PotentialNewBusinessList.get(0).id;
        
        Industry_Trend__c it = new Industry_Trend__c();
        it.Industry__c = 'Banking';
        it.Trend__c = 'test';
        it.Region__c = regionLocal.id;
        insert it;
        
        controller.trendid = it.id;
        controller.linkTrend();
        controller.unLinkTrend();
        
        Strategic_Initiative__c si = new Strategic_Initiative__c();
        si.Account__c = acct.id;
        insert si;
        
        controller.iniciativeid = si.id;
        controller.linkIniciative();
        controller.unLinkIniciative();  
                
    }
    
    static testMethod void myUnitTest3() {
        
        Region__c regionLocal = new Region__C(name='Local');
        insert regionLocal;
        
        Account acct = new Account(Name='Test', Region__c = regionLocal.id);
        insert acct;
        
        System.currentPagereference().getParameters().put('id',acct.id);
        AccountGrowthStrategyController controller = new AccountGrowthStrategyController();
        
        controller.save();
        controller.add();
        //controller.toDel = controller.PotentialNewBusinessList.get(0).id;
        //controller.del();
        
        controller.add();
        controller.pnbid = controller.PotentialNewBusinessList.get(0).id;
        
        PastProvenValueNew__c ppv = new PastProvenValueNew__c(account__c = acct.id);
        insert ppv; 
                        
        controller.pastProventValueid = ppv.id;
        controller.linkPastProventValue();
        controller.unLinkPastProventValue();
        
        controller.ExportToExcel();
        controller.getExcelName();
                                
    }
    
    static testMethod void traeLasSolucionesYGeneraUnWrapperParaSuNecesidadYOportunidad(){
        
        Account myAccount = new Account(Name = 'Test');
        insert myAccount;
        
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        // need
        Industry_Trend__c need = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                             Type__c= 'Principales necesidades');
        insert need;

        Industry_Trend__c myOpportunity = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                      Type__c = 'Oportunidad Sectorial',
                                                                                      RelatedTo__c = need.id);
        insert myOpportunity;
        
        Industry_Trend__c solution = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                 Type__c= 'Soluciones',
                                                                                 RelatedTo__c = myOpportunity.id);
        insert solution;
        
        ApexPages.currentPage().getParameters().put('id', myAccount.id);
        AccountGrowthStrategyController controller = new AccountGrowthStrategyController();
        
        system.assertEquals(1, controller.necesidadesWpp.size());
    }
    
    /*
    static testMethod void traeLaCantidadDeRenglonesDeAcuerdoAlaCantidadDeOportunidadesAsociadas(){
        
        AccountGrowthStrategyController.SolutionWrapper sol1 = new AccountGrowthStrategyController.SolutionWrapper();
        AccountGrowthStrategyController.SolutionWrapper sol2 = new AccountGrowthStrategyController.SolutionWrapper();
        
        AccountGrowthStrategyController.OportunidadWrapper oppWpp = new AccountGrowthStrategyController.OportunidadWrapper('opp1', 'id1');
        oppWpp.soluciones.add(sol1);
        oppWpp.soluciones.add(sol2);
        
        system.assertEquals(1, oppWpp.getCantidadDeRenglones());
    }*/
}