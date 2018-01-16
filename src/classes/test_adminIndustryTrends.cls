@isTest
private class test_adminIndustryTrends {

    static testMethod void myUnitTest() {
		Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        insert regionLocal;

        Account cuentapapa=new Account();
        cuentapapa.Name='test';
        cuentapapa.Region__c=regionLocal.id;
        
        insert cuentapapa;
        
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.Region__c=regionLocal.id;
        cuenta.ParentId = cuentapapa.id;
        insert cuenta;
        
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test oppp';
        opp.StageName = 'Open';
        opp.CloseDate = system.today();
        opp.AccountId = cuenta.id;
        insert opp;
        
        Industry_Trend__c it = new Industry_Trend__c();
        it.Industry__c = 'Banking';
        it.Trend__c = 'test';
        it.Region__c = regionGlobal.id;
        insert it;
        
        Strategic_Initiative__c si = new Strategic_Initiative__c();
        si.Account__c = cuenta.id;
        insert si;        

        
        
        adminIndustryTrends p = new adminIndustryTrends();
        
        p.getRegions();
        p.getIndustries();
        p.regionId = regionLocal.id;
        p.industry = 'Banking';
        p.doUpdate();
        p.getHashIndustry();
        p.getTrends();
        p.newTrend.Trend__c = 'test';
        p.newTrend.Industry__c = 'test';
        p.InsertNewTrend();
        
        p.IdtoDel = it.id;
        System.currentPagereference().getParameters().put('IdtoDelete',it.id);

        p.del();
        
    }
    
    static testMethod void validationTypeInNewTrends(){
        
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        adminIndustryTrends controller = new adminIndustryTrends();
        
        controller.tempAccount.Industry = 'Comercio';
        controller.tempAccount.Micro_Industry__c = 'Centros comerciales';
        controller.regionId = regionGlobal.id; 
        
        controller.doUpdate();
        
        controller.InsertNewTrend();
        
        system.assert(controller.erroresDeCarga.size()>0);
    }
    
    static testMethod void validationRelatedTo(){
		
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Industry_Trend__c generalContextTrend = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                      Type__c = 'Contexto General');
        insert generalContextTrend;
        
        adminIndustryTrends controller = new adminIndustryTrends();
        
        controller.tempAccount.Industry = 'Comercio';
        controller.tempAccount.Micro_Industry__c = 'Centros comerciales';
        controller.regionId = regionGlobal.id; 
        
        controller.doUpdate();
        
        controller.newTrend.Type__c = 'Soluciones';
        controller.InsertNewTrend();
        
        system.assertEquals(1, controller.erroresDeCarga.size() );
        
        controller.newTrend.Type__c = 'Soluciones';
        controller.newTrend.RelatedTo__c = generalContextTrend.id;
        controller.InsertNewTrend();
        
        system.assertEquals(1, controller.erroresDeCarga.size() );
        
        controller.newTrend.Type__c = 'Oportunidad Sectorial';
        controller.newTrend.RelatedTo__c = generalContextTrend.id;
        controller.InsertNewTrend();
        
        system.assertEquals(1, controller.erroresDeCarga.size() );
        
        Industry_Trend__c oportunidadTrend = new Industry_Trend__c(type__c = 'Oportunidad Sectorial', Region__c = regionGlobal.id);
        insert oportunidadTrend;
        
        Industry_Trend__c solutionTrend = new Industry_Trend__c(type__c = 'Soluciones', Region__c = regionGlobal.id, RelatedTo__c = oportunidadTrend.id);
        insert solutionTrend;
        
        
        List <Industry_Trend__c> auxList = new List <Industry_Trend__c>();
        auxList.add(solutionTrend);
        auxList.add(oportunidadTrend);
        
        controller.trends = auxList;
        controller.save();
        controller.getSectors();
        controller.getHayErroresDeCarga();
        controller.cleanErrors();
    }
}