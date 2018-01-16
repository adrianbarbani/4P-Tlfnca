@isTest
private class Test_InformeSectorizacionController {

    static testMethod void obtengoTodasLasSolucionesYCuentas(){
        
        Account myAccount = new Account(Name = 'Test');
        insert myAccount;

        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Industry_Trend__c solution = new Industry_Trend__c(Region__c = regionGlobal.id, Type__c= 'Soluciones');
        insert solution;
        
        Account_Industry_trend__c myAccountTrend = new Account_Industry_trend__c(Account__c = myAccount.id, 
                                                                                                       Current_state__c = 'No lo poseo y no lo tengo en perspectiva',
                                                                                                       Industry_Trend__c = solution.id);
        insert myAccountTrend;
        
		InformeSectorizacionController controller = new InformeSectorizacionController();
        controller.doFilter();
        
        system.assert(controller.todasLasSoluciones.size() > 0);
        system.assert(controller.accountWrapper.size() > 0);
        system.assert(controller.accountsfiltered.size()>0);
            
    }
    
    static testMethod void forEachAccountIGetAWrapper(){
        
        Account myAccount = new Account(Name = 'Test');
        insert myAccount;

        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Industry_Trend__c solution = new Industry_Trend__c(Region__c = regionGlobal.id, Type__c= 'Soluciones');
        insert solution;
        
        Account_Industry_trend__c myAccountTrend = new Account_Industry_trend__c(Account__c = myAccount.id, 
                                                                                                       Current_state__c = 'Vendido en el pasado',
                                                                                                       Industry_Trend__c = solution.id);
        insert myAccountTrend;
                
        InformeSectorizacionController controller = new InformeSectorizacionController();
        controller.doFilter();
        
        InformeSectorizacionController.AccountStateWrapper wrapper = controller.wrapperAccounts.get(myAccount.id);
        system.assertEquals(myAccount.id, wrapper.account.id);
        
        String state = wrapper.states.get(solution.id);
        system.assertEquals('Vendido en el pasado' , state);
        
    }
    
    static testMethod void theWrapperHaveOneStatePerSolution(){
        
        Account myAccount = new Account(Name = 'Test');
        insert myAccount;

        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Industry_Trend__c solution = new Industry_Trend__c(Region__c = regionGlobal.id, Type__c= 'Soluciones');
        insert solution;
        
        Industry_Trend__c otherSolution = new Industry_Trend__c(Region__c = regionGlobal.id, Type__c= 'Soluciones');
        insert otherSolution;
        
        Account_Industry_trend__c myAccountTrend = new Account_Industry_trend__c(Account__c = myAccount.id, 
                                                                                                       Current_state__c = 'Lo poseo en el funnel',
                                                                                                       Industry_Trend__c = solution.id);
        insert myAccountTrend;
                
        InformeSectorizacionController controller = new InformeSectorizacionController();
        controller.doFilter();
        
        List <Industry_Trend__c> allSolution = [SELECT Id from Industry_Trend__c];
        
        InformeSectorizacionController.AccountStateWrapper wrapper = controller.wrapperAccounts.get(myAccount.id);
        system.assertEquals(allSolution.size(), wrapper.colorList.size());
        
    }
    
    static testMethod void theListOfStatesIsOrderedInRelationToTheListOfSolutions(){
        Account myAccount = new Account(Name = 'Test');
        insert myAccount;

        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Industry_Trend__c solution = new Industry_Trend__c(Region__c = regionGlobal.id, Type__c= 'Soluciones');
        insert solution;
        
        Industry_Trend__c otherSolution = new Industry_Trend__c(Region__c = regionGlobal.id, Type__c= 'Soluciones');
        insert otherSolution;
        
        Account_Industry_trend__c myAccountTrend = new Account_Industry_trend__c(Account__c = myAccount.id, 
                                                                                                       Current_state__c = 'No aplica',
                                                                                                       Industry_Trend__c = solution.id);
        insert myAccountTrend;
                
        InformeSectorizacionController controller = new InformeSectorizacionController();
        controller.doFilter();
        
        InformeSectorizacionController.AccountStateWrapper wrapper = controller.wrapperAccounts.get(myAccount.id);
        system.assertEquals(2, wrapper.colorList.size());
        system.assertEquals('black', wrapper.colorList[1]);
    }
    
    static testMethod void createAllTheWrapperAndThenFilter(){
        Account myAccount = new Account(Name = 'Test');
        insert myAccount;

        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
		
        // need
        Industry_Trend__c need = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                 Type__c= 'Principales necesidades');
        insert need;

        //Opportunities
       	Industry_Trend__c myOpportunity = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                      Type__c = 'Oportunidad Sectorial',
                                                                                      RelatedTo__c = need.id);
        insert myOpportunity;
        
        Industry_Trend__c myOpportunity2 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                       Type__c= 'Oportunidad Sectorial',
                                                                                       RelatedTo__c = need.id);
        insert myOpportunity2;
        
        Industry_Trend__c myOpportunity3 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                       Type__c= 'Oportunidad Sectorial'
                                                                                       );
        insert myOpportunity3;
        
		//solutions for myOpportunity
		Industry_Trend__c solution = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                 Type__c= 'Soluciones',
                                                                                 RelatedTo__c = myOpportunity.id);
        insert solution;
        
        Industry_Trend__c otherSolution = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                      Type__c= 'Soluciones',
                                                                                      RelatedTo__c = myOpportunity.id);
        insert otherSolution;
		
        //solutions for myOpportunity2
		Industry_Trend__c SolutionOpp2 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                     Type__c= 'Soluciones',
                                                                                     RelatedTo__c = myOpportunity2.id);
        insert SolutionOpp2;
        
        Industry_Trend__c otherSolutionOpp2 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                          Type__c= 'Soluciones',
                                                                                          RelatedTo__c = myOpportunity2.id);
        insert otherSolutionOpp2;
        
        //solutions for myOpportunity3
		Industry_Trend__c SolutionOpp3 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                     Type__c= 'Soluciones',
                                                                                     RelatedTo__c = myOpportunity3.id);
        insert SolutionOpp3;

		//================================================================================        
        
		InformeSectorizacionController controller = new InformeSectorizacionController();
        system.assertEquals(1,controller.wrapperNeeds.size() );
        system.assertEquals(5,controller.wrapperSolution.size() );
        controller.wrapperSolution[0].checkBox = true;
        
        controller.doFilter();
        system.assertEquals(1, controller.todasLasSoluciones.size());
        system.assertEquals(1,controller.accountWrapper.size());
        
        controller.wrapperNeeds[0].checkBox = false;
        controller.wrapperSolution[0].checkBox = true;
        controller.doFilter();
        
        system.assertEquals(1, controller.todasLasSoluciones.size());
        system.assertEquals(1, controller.accountWrapper.size() );
        system.assertEquals(1, controller.accountWrapper[0].colorList.size());
		        
    }
    
    static testMethod void iCanFilterByRegionSectorAndSubsector(){
        
        Region__c regionGlobal = new Region__C(name='Global');
        insert regionGlobal;
        
        Region__c regionSeccional = new Region__C(name = 'Venezuela', Parent__c = regionGlobal.id );
        insert regionSeccional;
        
        Account myAccount = new Account(Name = 'Test', Region__c = regionGlobal.id, Industry = 'Transporte', Micro_Industry__c = 'Almacenamiento');
        insert myAccount;
        
        Account accountInOtherRegion = new Account(Name = 'Other region', Region__c = regionSeccional.id, Industry = 'Comercio', Micro_Industry__c = 'Centros Comerciales');
        insert accountInOtherRegion;
        
        // need
        Industry_Trend__c need = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                             Type__c= 'Principales necesidades');
        insert need;
        
        //Opportunities
        Industry_Trend__c myOpportunity = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                      Type__c = 'Oportunidad Sectorial',
                                                                                      RelatedTo__c = need.id);
        insert myOpportunity;
        
        Industry_Trend__c myOpportunity2 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                       Type__c= 'Oportunidad Sectorial',
                                                                                       RelatedTo__c = need.id);
        insert myOpportunity2;
        
        Industry_Trend__c myOpportunity3 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                       Type__c= 'Oportunidad Sectorial'
                                                                                      );
        insert myOpportunity3;
        
        //solutions for myOpportunity
        Industry_Trend__c solution = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                 Type__c= 'Soluciones',
                                                                                 RelatedTo__c = myOpportunity.id);
        insert solution;
        
        Industry_Trend__c otherSolution = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                      Type__c= 'Soluciones',
                                                                                      RelatedTo__c = myOpportunity.id);
        insert otherSolution;
        
        //solutions for myOpportunity2
        Industry_Trend__c SolutionOpp2 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                     Type__c= 'Soluciones',
                                                                                     RelatedTo__c = myOpportunity2.id);
        insert SolutionOpp2;
        
        Industry_Trend__c otherSolutionOpp2 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                          Type__c= 'Soluciones',
                                                                                          RelatedTo__c = myOpportunity2.id);
        insert otherSolutionOpp2;
        
        //solutions for myOpportunity3
        Industry_Trend__c SolutionOpp3 = new Industry_Trend__c(Region__c = regionGlobal.id, 
                                                                                     Type__c= 'Soluciones',
                                                                                     RelatedTo__c = myOpportunity3.id);
        insert SolutionOpp3;
        
        Industry_Trend__c SolutionRegional = new Industry_Trend__c(Region__c = regionSeccional.id, 
                                                                                     Type__c= 'Soluciones',
                                                                                     RelatedTo__c = myOpportunity3.id);
        insert SolutionRegional;
        
       	InformeSectorizacionController controller = new InformeSectorizacionController();
        
        /*
         * 
        controller.regionId = regionGlobal.id;
        controller.criterialAccountFilter.Industry = 'Transporte';
        controller.criterialAccountFilter.Micro_Industry__c = 'Almacenamiento';
        controller.doPanelFilter();
		

        system.assertEquals(1,controller.accountWrapper.size());*/
        
        //system.assertEquals(5, controller.todasLasSoluciones.size());
        
                /*
        controller.regionId = regionSeccional.id; // crear otra region.
        controller.criterialAccountFilter.Industry = 'Transporte';
        controller.criterialAccountFilter.Micro_Industry__c = 'Almacenamiento';
        controller.doPanelFilter();
        
        system.assertEquals(0,controller.accountWrapper.size());
        system.assertEquals(0,controller.todasLasSoluciones.size());
        system.assertEquals(1,controller.errors.size());*/
        
        /*
        controller.regionId = regionSeccional.id;
        controller.criterialAccountFilter.Industry = 'Transporte';
        controller.criterialAccountFilter.Micro_Industry__c = 'Almacenamiento';
        controller.doPanelFilter();
        
        system.assertEquals(0,controller.accountWrapper.size());
        system.assertEquals(0,controller.todasLasSoluciones.size());
        system.assertEquals(1,controller.errors.size());*/
        
        
        //solo sol globales no trae soluciones local(ej: venezuela.)
        controller.regionId = regionGlobal.id;
        controller.criterialAccountFilter.Industry = 'Todos';
        controller.criterialAccountFilter.Micro_Industry__c = 'Todos';
        controller.doPanelFilter();
        
        system.assertEquals(1,controller.accountWrapper.size());
        system.assertEquals(5,controller.todasLasSoluciones.size()); // me trae todas.
        system.assertEquals(0,controller.errors.size());
        
        
        //las soluciones tienen que ser las regionales y globales.
        List <SelectOption> regiones = controller.getRegions();
        controller.regionId = regionSeccional.id;
        controller.criterialAccountFilter.Industry = 'Todos';
        controller.criterialAccountFilter.Micro_Industry__c = 'Todos';
        controller.doPanelFilter();
        
        system.assertEquals(1,controller.accountWrapper.size());
        system.assertEquals(6,controller.todasLasSoluciones.size());
        system.assertEquals(0,controller.errors.size());
    }
    
    
}