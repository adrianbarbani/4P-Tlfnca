public class InformeSectorizacionController {
    
    public List <Industry_Trend__c> todasLasSoluciones {get; set;}
    public List <Industry_Trend__c> initialSolutions {get; set;}
    //cambios nuevos filtros.
    public List <String> errors {get;set;}
    public String regionId { get; set;}
    public Region__c region { get; set;}
    public Account criterialAccountFilter {get; set;}
    public List<Account> accountQuery {get; set;}
    
    List<Industry_Trend__c> solutionQuery {get; set;}
    List<Id> opportunitiesIds {get; set;} 
    List<Id> needsIds {get; set;}
    //====================
    
    public List <AccountStateWrapper> accountWrapper {get; set;}
    public Map <String, AccountStateWrapper> wrapperAccounts {get; set;}
    public List<Account> accountsFiltered {get; set;}
    
    public List<Industry_Trend__c> allIndustryTrendSolutions {get; set;}
    public List<Industry_Trend__c> allIndustryTrendSolutionsOpportunities {get; set;}
    public List<Industry_Trend__c> allIndustryTrendSolutionsNeeds {get; set;}
    
    public List<IndustryTrendWrapper> wrapperSolution{get; set;}
    public List<IndustryTrendWrapper> wrapperOpportunitys{get; set;}
    public List<IndustryTrendWrapper> wrapperNeeds{get; set;}
    
    
    
    public InformeSectorizacionController (){
        
        initialSolutions = new List<Industry_Trend__c>();
        errors = new List<String>();
        todasLasSoluciones = new List<Industry_Trend__c>();
        accountWrapper = new List <AccountStateWrapper>();
        accountQuery = new List<Account>();
        criterialAccountFilter = new Account();
        accountsFiltered = new List<Account>();
        wrapperAccounts = new Map<String, AccountStateWrapper>();
        wrapperSolution = new List<IndustryTrendWrapper>();
        wrapperOpportunitys = new List<IndustryTrendWrapper>(); 
        wrapperNeeds = new List<IndustryTrendWrapper>(); 
        
        //este metodo por ahora va aca pero va a depender del primer filtro.
        solutionQuery = new List<Industry_Trend__c>();
        opportunitiesIds = new List<id>();
        needsIds = new List<Id>();
        createListOfNeedsOpportunityAndSolution();        
    }

//=================== nuevos filtros ======================    
    //get regions for the pickList.
    public List<SelectOption> getRegions(){
        List<SelectOption> options = new List<SelectOption>();
        
        
        List<Region__c> temp =  [SELECT Name,Id From Region__c ORDER BY id ASC];
        
        for( Region__c c : temp){
            options.add(new SelectOption(c.Id,c.Name));
        }
        
        return options;
    }
    
    public PageReference doPanelFilter(){
        
        system.debug(criterialAccountFilter);
        system.debug(regionId);
        
        initialSolutions = new List<Industry_Trend__c>();
        todasLasSoluciones = new List<Industry_Trend__c>();
        accountWrapper = new List <AccountStateWrapper>();
        wrapperAccounts = new Map <String, AccountStateWrapper>();
        
        errors = new List<String>();
        String industry = criterialAccountFilter.Industry;
        String microIndustry = criterialAccountFilter.Micro_Industry__c;
        
        if(criterialAccountFilter.Industry == 'Todos'){industry = '';
                                                       microIndustry = '';}
        if(criterialAccountFilter.Micro_Industry__c == 'Todos'){microIndustry ='';}
        
        if(regionId != null){
            region = [SELECT Id, Name, Parent__c, OwnerId FROM Region__c WHERE Id = :regionId];
        }


		//Ver que pasa cuando alguno de estos datos esta vacio.        
        String stringQuery = 'SELECT ID FROM account ';
		String auxWhere = 'WHERE ';
        String auxAnd = 'AND ';
        
        List<String> conditionList = new List<String>();    
        
        
        if(industry != ''){
           system.debug(industry);
           String strIndustry = 'Industry =: industry ';
           conditionList.add(strIndustry); 
        }
        

        if(microIndustry != ''){
            String strMicro = 'Certa_SCP__Micro_Industry__c =: microIndustry ';
            if(microIndustry == 'Todos')
            conditionList.add(strMicro);
        }
        

        if(region.id != null){
            ID aux = region.id;
            system.debug(aux);
            String strRegion = 'Certa_SCP__Region__c =: aux';
            conditionList.add(strRegion);
        }
        
        if(conditionList.size() > 0){
            
            if(conditionList.size() == 1){
                stringQuery += auxWhere;
                stringQuery += conditionList[0];
            }else{
                stringQuery += auxWhere;
                for(String condition :conditionList){
                    stringQuery += condition;
                    stringQuery += auxAnd;
                }
                
                stringQuery = stringQuery.removeEnd('AND ');
            }
            
        }
        
        system.debug(microIndustry);
        system.debug(Industry);
        system.debug(stringQuery);
        
        
        accountQuery = Database.query(stringQuery);
        system.debug(accountQuery);
        //=============================
      	//create the solution query.
        
        List<Id> regionsIds = Util.getParentsRegions(region);
        
        system.debug(region);
        system.debug(regionsIds);
        //soluciones posibles.
        String myQuery = 'SELECT Id, Certa_SCP__Region__c, Certa_SCP__RelatedTo__c, '+
            'Certa_SCP__RelatedTo__r.Certa_SCP__RelatedTo__c '+
            'FROM Certa_SCP__Industry_Trend__c '+
            'WHERE Certa_SCP__Type__c = \'Soluciones\' ';
        

        if(regionsIds.size() > 0){ myQuery += 'AND Certa_SCP__Region__c IN : regionsIds ';}
        if(industry != ''){ myQuery += 'AND Certa_SCP__Sub_Sector__c = : industry '; }
        if(microIndustry != ''){ myQuery += 'AND Certa_SCP__Industry__c = : microIndustry '; }
        
        system.debug('query');
		system.debug(myQuery);
        solutionQuery = Database.query(myQuery);
        system.debug(solutionQuery);
        system.debug(solutionQuery.size());
        
        needsIds = new List<Id>();
        opportunitiesIds = new List<Id>();
        for(Industry_Trend__c solution:solutionQuery){
            opportunitiesIds.add(solution.RelatedTo__c);
            needsIds.add(solution.RelatedTo__r.RelatedTo__c);
        }
        
        
        if(solutionQuery.size() == 0 || accountQuery.size() == 0){
            
            errors.add('No hay cuentas o soluciones que cumplan con estos criterios de busqueda.');
            for(string error:errors){
            	system.debug(error);    
            }
            
        }else{
            initialSolutions = solutionQuery;
            createListOfNeedsOpportunityAndSolution();
            makeTheFirstFilter();
        }
        
        system.debug(needsIds);
        system.debug(todasLasSoluciones);

        return null;
    }

//====================================    
    public void createListOfNeedsOpportunityAndSolution (){
        	
        	wrapperSolution = new List<IndustryTrendWrapper>();
            wrapperOpportunitys = new List<IndustryTrendWrapper>();
            wrapperNeeds = new List<IndustryTrendWrapper>();
            
        //needs query
        String needsQuery = 'SELECT ID, Certa_SCP__Title__c, Certa_SCP__Type__c, Certa_SCP__RelatedTo__c FROM Certa_SCP__Industry_Trend__c '+
            'WHERE Certa_SCP__Type__c = \'Principales necesidades\' ';
        
        if(needsIds.size() >0){ needsQuery += 'AND ID IN : needsIds ';}
        needsQuery += 'ORDER BY Certa_SCP__Title__c';
        
        system.debug(needsQuery);
        allIndustryTrendSolutionsNeeds = Database.query(needsQuery);  
        
        //opp query
        String oppQuery = 'SELECT ID, Certa_SCP__Title__c, Certa_SCP__Type__c, Certa_SCP__RelatedTo__c FROM Certa_SCP__Industry_Trend__c '+
            'WHERE Certa_SCP__Type__c = \'Oportunidad Sectorial\' ';
        
        if(opportunitiesIds.size() > 0){oppQuery += 'AND ID IN :opportunitiesIds ';}
        oppQuery += 'ORDER BY Certa_SCP__RelatedTo__r.Certa_SCP__Title__c, Certa_SCP__Title__c';
        
        allIndustryTrendSolutionsOpportunities = Database.query(oppQuery);
        
        //solution query
        String solQuery = 'SELECT ID, Certa_SCP__Title__c, Certa_SCP__Type__c, Certa_SCP__RelatedTo__c FROM Certa_SCP__Industry_Trend__c '+
            'WHERE Certa_SCP__Type__c = \'Soluciones\' ';
        
        if(solutionQuery.size() > 0){solQuery +='AND ID IN :solutionQuery ';}
        solQuery += 'ORDER BY Certa_SCP__RelatedTo__r.Certa_SCP__RelatedTo__r.Certa_SCP__Title__c, Certa_SCP__RelatedTo__r.Certa_SCP__Title__c ,Certa_SCP__Title__c';
        
        allIndustryTrendSolutions = Database.query(solQuery);
        
        system.debug(allIndustryTrendSolutionsNeeds);
        system.debug(allIndustryTrendSolutionsOpportunities);
        system.debug(allIndustryTrendSolutions);
        //I create a wrapper per industry trend.
        for(Certa_SCP__Industry_Trend__c trend :allIndustryTrendSolutions){
            IndustryTrendWrapper trendWrpp = new IndustryTrendWrapper(trend);
            wrapperSolution.add(trendWrpp);
        }
        
        for(Industry_Trend__c trend :allIndustryTrendSolutionsOpportunities){
            IndustryTrendWrapper trendWrpp = new IndustryTrendWrapper(trend);
            wrapperOpportunitys.add(trendWrpp);
        }
        
        for(Industry_Trend__c trend :allIndustryTrendSolutionsNeeds){
            IndustryTrendWrapper trendWrpp = new IndustryTrendWrapper(trend);
            wrapperNeeds.add(trendWrpp);
        }
        
        system.debug(wrapperSolution.size());
    }
    
    private void makeTheFirstFilter(){

        accountWrapper = new List <AccountStateWrapper>();
        wrapperAccounts = new Map <String, AccountStateWrapper>();
        
        Set<id> solutionsToFilter = new set<id>();
        
        for(IndustryTrendWrapper wppSolution :wrapperSolution){
              solutionsToFilter.add(wppSolution.trend.id);
        }
        
        //build the queryFilter
        loadData(solutionsToFilter);
        system.debug(solutionsToFilter);
           
    }
    
    public PageReference doFilter(){
        
        accountWrapper = new List <AccountStateWrapper>();
        wrapperAccounts = new Map <String, AccountStateWrapper>();
        
        Set<id> solutionsToFilter = new set<id>();
        
        for(IndustryTrendWrapper wppSolution :wrapperSolution){
            
            if(wppSolution.checkBox){
                solutionsToFilter.add(wppSolution.trend.id);
            }
        }
        
        //build the queryFilter
        loadData(solutionsToFilter);
        system.debug(solutionsToFilter);
        return null;
    }
    
    public void loadData(Set<id> solutionfilter){
        //Load solutions
        List<id> queryFilter = new List<id>();
        queryFilter.addAll(solutionfilter);
        
        system.debug(queryFilter);
        system.debug(initialSolutions);
        
        if(queryFilter.size() > 0){
            todasLasSoluciones = [SELECT ID, Title__c FROM Industry_Trend__c
                                  WHERE Type__c = 'Soluciones' AND ID IN: queryFilter];
            
        }
        else{
            

            todasLasSoluciones = [SELECT ID, Title__c FROM Industry_Trend__c
                                  WHERE Type__c = 'Soluciones'];
            
            if(initialSolutions.size() > 0){
                todasLasSoluciones = [SELECT ID, Title__c FROM Industry_Trend__c
                                  WHERE Type__c = 'Soluciones' AND ID in: initialSolutions];
            }
        }
        
        system.debug(initialSolutions);
        //load Accounts
        //filter of accounts
        
        String myQuery = 'SELECT ID, name FROM Account ';
        if(accountQuery.size() > 0){
            myQuery += 'WHERE ID IN:accountQuery ';
        }
        accountsfiltered = Database.query(myQuery);
        
        createWrapperList();
        accountWrapper = wrapperAccounts.values();
        system.debug(accountWrapper);
        setAllWrapperStates();
    }
    
    public void createWrapperList(){
        
        //i get all de the AccountIndustryTrends filtered.
        List<Account_Industry_trend__c> allAccountIndustryTrend = [select Current_state__c, 
                                                                              Industry_Trend__r.id, Account__r.id,Account__r.name
                                                                              from Account_Industry_trend__c
                                                                              where Industry_Trend__c IN: todasLasSoluciones AND
                                                                              Account__c IN: accountsfiltered];
        
        
        
        for(Account_Industry_trend__c AccIndTrend :allAccountIndustryTrend){
            
            AccountStateWrapper wrapperAcc = wrapperAccounts.get(AccIndTrend.Account__r.id);
            if(wrapperAcc == null){
                AccountStateWrapper wrapper = new AccountStateWrapper(AccIndTrend.Account__r, 
                                                                      AccIndTrend.Current_state__c,
                                                                      AccIndTrend.Industry_Trend__r.id);
                
                wrapperAccounts.put(AccIndTrend.Account__c, wrapper);
            }else{
                
                wrapperAcc.addState(AccIndTrend.Current_state__c, AccIndTrend.Industry_Trend__r.id);                
            }
            
        }
        
        //busco si la cuenta existe ya en el wrapperAcount si no creo uno vacio.
        for(Account acc :accountsfiltered){
            AccountStateWrapper wrapperAcc = wrapperAccounts.get(acc.id);
            if(wrapperAcc == null){
                AccountStateWrapper wrapper = new AccountStateWrapper(acc); 
                wrapperAccounts.put(acc.id, wrapper);  
            }
        }
        
    }
    
    public void setAllWrapperStates(){
        
        //If the account dont have a relation whit a solution i create a new state call 'No existe relacion'
        
        for(AccountStateWrapper wrapper :accountWrapper){
            for(Industry_Trend__c solucion:todasLasSoluciones){
                
                String state = wrapper.states.get(solucion.id);
                if(state == null){
                    //si no existe relacion, se setea un color por default.
                    wrapper.colorList.add('black');
                }else{
                    
                    //switch case casero.
                    boolean colorAsigned = false;
                    
                    if(state == 'Vendido en el pasado'){
                        wrapper.colorList.add('CornflowerBlue');
                        colorAsigned = true;
                    }
                    
                    if(state == 'No aplica'){
                        wrapper.colorList.add('grey');
                        colorAsigned = true;                        
                    }
                    
                    if(state == 'Lo poseo en el funnel'){
                        wrapper.colorList.add('white');
                        colorAsigned = true;                        
                    }
                    
                    if(state == 'No lo poseo y no lo tengo en perspectiva'){
                        wrapper.colorList.add('red');
                        colorAsigned = true;                        
                    }
                    
                    if(!colorAsigned){
                        wrapper.colorList.add('green');
                        colorAsigned = true;                        
                    }
                    
                }
            }
        }
    }
    
    public class AccountStateWrapper {
        
        public Account account {get;set;}
        public List<String> colorList {get;set;}
        public Map <id, string> states{get; set;}
        
        public AccountStateWrapper(Account acc, String state, id solution) {
            account = acc;
            states = new Map<id, string>();
            colorList = new List<String>();
            addState(state, solution);
        }
        
        public AccountStateWrapper(Account acc){
            account = acc;
            states = new Map<id, string>();
            colorList = new List<String>();
        }
        
        public void addState(String state, id solution){
            states.put(solution, state);
        }
        
    }
    
    public class IndustryTrendWrapper {
        
        public Industry_Trend__c trend {get; set;}
        public boolean checkBox {get; set;}
        String trendType {get; set;}
        
        
        public IndustryTrendWrapper (Industry_Trend__c anIndustryTrend){
            trend = anIndustryTrend;
            checkBox = false;
            trendType = anIndustryTrend.Type__c;
            
        }
        
        
    }    
}