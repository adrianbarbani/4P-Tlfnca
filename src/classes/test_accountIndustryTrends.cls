@isTest
private class test_accountIndustryTrends {

    static testMethod void myUnitTest() {
        
        
        Region__c regionGlobal = new Region__C(name='Global');
        regionGlobal.Currency_Name__c ='asd';        
        insert regionGlobal;
                
        Account cuenta=new Account();
        cuenta.Name='test';        
        
        insert cuenta;
        
        System.currentPagereference().getParameters().put('id',cuenta.id);
        
        accountIndustryTrends p_Test = new accountIndustryTrends();
        
        p_Test.loadData();
        p_Test.getIndustry();
        p_Test.account.Micro_Industry__c = 'asd';        
        p_Test.getIndustry();
        
        p_Test.ExportToExcel();
        p_Test.getExcelName();
        
        
    }
    
    static testMethod void myUnitTest2() {
        
        Integer driversCount = 0;
                      
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        insert regionLocal;
		
        Account cuentaAbuelo=new Account();
        cuentaAbuelo.Name='test';
        cuentaAbuelo.Region__c=regionLocal.id;
        cuentaAbuelo.Strategic_Context__c = 'Test Cuenta Abuelo';
        insert cuentaAbuelo;
                
        Account cuentapapa=new Account();
        cuentapapa.Name='test';
        cuentapapa.Region__c=regionLocal.id;
        cuentapapa.ParentId = cuentaAbuelo.id;
        cuentapapa.Strategic_Context__c = 'Test Cuenta Padre';
        insert cuentapapa;        
        
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.Region__c=regionLocal.id;
        cuenta.ParentId = cuentapapa.id;
        cuenta.Strategic_Context__c = 'Test Cuenta';
        cuenta.Sector__c = 'sector';
        cuenta.Industry = 'industry';
        cuenta.Micro_Industry__c = 'Micro_Industry';
        insert cuenta;		        
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test oppp';
        opp.StageName = 'Open';
        opp.CloseDate = system.today();
        opp.AccountId = cuenta.id;
        insert opp;
        
        Industry_Trend__c it = new Industry_Trend__c();
        it.Trend__c = 'test';
        it.Region__c = regionGlobal.id;
        it.Sector__c = cuenta.Sector__c;
        it.Sub_Sector__c = cuenta.Industry;
        it.Industry__c = cuenta.Micro_Industry__c;
        it.type__c = 'Soluciones';
        
        insert it;
        driversCount++;
        
        Strategic_Initiative__c si = new Strategic_Initiative__c();
        si.Account__c = cuenta.id;
        insert si;        
		driversCount++;
		
		Strategic_Initiative__c si2 = new Strategic_Initiative__c();
        si2.Account__c = cuentapapa.id;
        insert si2;
        driversCount++;
        
        PastProvenValueNew__c ppv = new PastProvenValueNew__c(account__c = cuenta.id);
        insert ppv;
        driversCount++;       
        
        System.currentPagereference().getParameters().put('id',cuenta.id);        
        accountIndustryTrends p_Test = new accountIndustryTrends();
        
        /*
        Integer trends = 0;
		for (ExtendedRegion region :p_Test.Regions) {
			trends += region.Trends.size();
		}
        */
        
        Integer totalDrivers = p_Test.localStrategicInitiatives.size() + p_Test.globalStrategicInitiatives.size() + p_Test.provenValueWrapperList.size() + p_Test.solutions.size(); 
		
		system.assertEquals(driversCount, totalDrivers);
		
		system.assert(p_Test.opportunities.size()==1);
		
		p_Test.oppid = opp.id;
		
		p_Test.trendid = it.id;
		p_Test.linkTrend();		
		List<OportunityIndustryTrend__c> oppItResult = [select id from OportunityIndustryTrend__c where opportunity__c = :opp.id];
		system.assert(oppItResult.size()==1);               
        p_Test.trendid = oppItResult.get(0).id;
        p_Test.unLinkTrend();
        List<OportunityIndustryTrend__c> oppItResult2 = [select id from OportunityIndustryTrend__c where opportunity__c = :opp.id];
		system.assert(oppItResult2.size()==0);        
    }

    static testMethod void myUnitTest3() {
        
        Integer driversCount = 0;
                      
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        insert regionLocal;
		
        Account cuentaAbuelo=new Account();
        cuentaAbuelo.Name='test';
        cuentaAbuelo.Region__c=regionLocal.id;
        cuentaAbuelo.Strategic_Context__c = 'Test Cuenta Abuelo';
        insert cuentaAbuelo;
                
        Account cuentapapa=new Account();
        cuentapapa.Name='test';
        cuentapapa.Region__c=regionLocal.id;
        cuentapapa.ParentId = cuentaAbuelo.id;
        cuentapapa.Strategic_Context__c = 'Test Cuenta Padre';
        insert cuentapapa;        
        
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.Region__c=regionLocal.id;
        cuenta.ParentId = cuentapapa.id;
        cuenta.Strategic_Context__c = 'Test Cuenta';
        cuenta.Sector__c = 'sector';
        cuenta.Industry = 'industry';
        cuenta.Micro_Industry__c = 'Micro_Industry';
        insert cuenta;		        
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test oppp';
        opp.StageName = 'Open';
        opp.CloseDate = system.today();
        opp.AccountId = cuenta.id;
        insert opp;
        
        Industry_Trend__c it = new Industry_Trend__c();
        it.Trend__c = 'test';
        it.Region__c = regionGlobal.id;
        it.Sector__c = cuenta.Sector__c;
        it.Sub_Sector__c = cuenta.Industry;
        it.Industry__c = cuenta.Micro_Industry__c;
        it.type__c = 'Soluciones';
        insert it;
        driversCount++;
        
        Strategic_Initiative__c si = new Strategic_Initiative__c();
        si.Account__c = cuenta.id;
        insert si;        
		driversCount++;
		
		Strategic_Initiative__c si2 = new Strategic_Initiative__c();
        si2.Account__c = cuentapapa.id;
        insert si2;
        driversCount++;
        
        PastProvenValueNew__c ppv = new PastProvenValueNew__c(account__c = cuenta.id);
        insert ppv;
        driversCount++;       
        
        System.currentPagereference().getParameters().put('id',cuenta.id);        
        accountIndustryTrends p_Test = new accountIndustryTrends();
        
        /*
        Integer trends = 0;
		for (ExtendedRegion region :p_Test.Regions) {
			trends += region.Trends.size();
		}
        */
        
        Integer totalDrivers = p_Test.localStrategicInitiatives.size() + p_Test.globalStrategicInitiatives.size() + p_Test.provenValueWrapperList.size() + p_Test.solutions.size(); 
		
		system.assertEquals(driversCount,totalDrivers);
		
		system.assert(p_Test.opportunities.size()==1);
		
		p_Test.oppid = opp.id;
		
        p_Test.iniciativeid = si.id;
		p_Test.linkIniciative();	
		List<OpportunityStrategicInitiative__c> oppIsResult = [select id from OpportunityStrategicInitiative__c where opportunity__c = :opp.id];
		system.assert(oppIsResult.size()==1);
		p_Test.iniciativeid = oppIsResult.get(0).id;
		p_Test.unLinkIniciative();		
		List<OpportunityStrategicInitiative__c> oppIsResult2 = [select id from OpportunityStrategicInitiative__c where opportunity__c = :opp.id];
		system.assert(oppIsResult2.size()==0);
    }

    static testMethod void myUnitTest4() {
                      
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        insert regionLocal;
		
        Account cuentaAbuelo=new Account();
        cuentaAbuelo.Name='test';
        cuentaAbuelo.Region__c=regionLocal.id;
        cuentaAbuelo.Strategic_Context__c = 'Test Cuenta Abuelo';
        insert cuentaAbuelo;
        
        Account cuentapapa=new Account();
        cuentapapa.Name='test';
        cuentapapa.Region__c=regionLocal.id;
        cuentapapa.ParentId = cuentaAbuelo.id;
        cuentapapa.Strategic_Context__c = 'Test Cuenta Padre';
        insert cuentapapa;
        
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.Region__c=regionLocal.id;
        cuenta.ParentId = cuentapapa.id;
        cuenta.Strategic_Context__c = 'Test Cuenta';
        cuenta.Sector__c = 'sector';
        cuenta.Industry = 'industry';
        insert cuenta;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test oppp';
        opp.StageName = 'Open';
        opp.CloseDate = system.today();
        opp.AccountId = cuenta.id;
        insert opp;
        
        PastProvenValueNew__c ppv = new PastProvenValueNew__c(account__c = cuenta.id);
        insert ppv;
        
        System.currentPagereference().getParameters().put('id',cuenta.id);        
        accountIndustryTrends p_Test = new accountIndustryTrends();
		
		p_Test.oppid = opp.id;
   
    	p_Test.pastProventValueid = ppv.id;
		p_Test.linkPastProventValue();		
		List<OpportunityPastProvenValueNew__c> oppPpvResult = [select id from OpportunityPastProvenValueNew__c where opportunity__c = :opp.id];
		system.assert(oppPpvResult.size()==1);
		p_Test.pastProventValueid = oppPpvResult.get(0).id;
		p_Test.unLinkPastProventValue();		
		List<OpportunityPastProvenValueNew__c> oppPpvResult2 = [select id from OpportunityPastProvenValueNew__c where opportunity__c = :opp.id];
		system.assert(oppPpvResult2.size()==0);
        
        List<SelectOption> options = p_Test.getOperators('Name');
        system.assertEquals(7, options.size());
        
        options = p_Test.getOperators('Amount');
        system.assertEquals(5, options.size());
    }

    static testMethod void myUnitTest5() {
                      
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionLocal = new Region__c(name='Local',Parent__c=regionGlobal.id);
        insert regionLocal;
		
        Account cuentaAbuelo=new Account();
        cuentaAbuelo.Name='test';
        cuentaAbuelo.Region__c=regionLocal.id;
        cuentaAbuelo.Strategic_Context__c = 'Test Cuenta Abuelo';
        insert cuentaAbuelo;
        
        Account cuentapapa=new Account();
        cuentapapa.Name='test';
        cuentapapa.Region__c=regionLocal.id;
        cuentapapa.ParentId = cuentaAbuelo.id;
        cuentapapa.Strategic_Context__c = 'Test Cuenta Padre';
        insert cuentapapa;
        
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.Region__c=regionLocal.id;
        cuenta.ParentId = cuentapapa.id;
        cuenta.Strategic_Context__c = 'Test Cuenta';
        cuenta.Sector__c = 'sector';
        cuenta.Industry = 'industry';
        insert cuenta;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test oppp';
        opp.StageName = 'Open';
        opp.CloseDate = system.today();
        opp.AccountId = cuenta.id;
        insert opp;
        
        PastProvenValueNew__c ppv = new PastProvenValueNew__c(account__c = cuenta.id);
        insert ppv;
        
        System.currentPagereference().getParameters().put('id',cuenta.id);        
        accountIndustryTrends p_Test = new accountIndustryTrends();
		
		p_Test.oppid = opp.id;
		
		p_Test.getFields();
		p_Test.getOperators();
		p_Test.getOperators1();
		p_Test.getOperators2();
		p_Test.getOperators3();
		p_Test.getOperators4();
		p_Test.getFieldName();
		p_Test.getFieldName1();
		p_Test.getFieldName2();
		p_Test.getFieldName3();
		p_Test.getFieldName4();
		p_Test.getStages();
		
		p_Test.filterLogic = '';
		
		p_Test.field = 'Name';
		p_Test.operator = 'val%';
		p_Test.value = 'T';
		
		p_Test.field1 = 'Name';
		p_Test.operator1 = '%val';
		p_Test.value1 = 'T';
		
		p_Test.field2 = 'Name';
		p_Test.operator2 = '%val%';
		p_Test.value2 = 'T';
		
		p_Test.field3 = 'Name';
		p_Test.operator3 = 'not %val%';
		p_Test.value3 = 'T';
		
		p_Test.field4 = 'Name';
		p_Test.operator4 = '=';
		p_Test.value4 = 'T';
		
		p_Test.setFilter();
		
		p_Test.filterLogic = '1 or 2';
		
		p_Test.field = 'Amount';
		p_Test.operator = '>';
		p_Test.value = '10';
		
		p_Test.field1 = 'CloseDate';
		p_Test.operator1 = '>';
		p_Test.oppDummy1.CloseDate = System.today();
		
		p_Test.setFilter();
		
		p_Test.ExportToExcelTrendWindows();
		p_Test.getExcelNameTrendWindows();
		
		List<ExtendedRegion> ret  = new List<ExtendedRegion>();
		ret.add(new ExtendedRegion(new Region__c(), new List<Industry_Trend__c>()));
		ret.add(new ExtendedRegion(new Region__c(), new List<Industry_Trend__c>()));		
		p_Test.reverseList(ret);
		
    }
}