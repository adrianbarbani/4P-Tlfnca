public class accountIndustryTrends {

    public List<Strategic_Initiative__c>  localStrategicInitiatives { get; set; }
    public List<Strategic_Initiative__c>  globalStrategicInitiatives { get; set; }
    public List<Industry_Trend__c>  solutions { get; set; }

    public List<ExtendedRegion> Regions {get;set;}
    	    
    public Account account { get; set; }
    public List<Opportunity> opportunities {get;set;}
    public List<OpportunityWrapper> opportunityWrappers {get;set;}
    

    public List<AccountPastProvenValueNewController.ProvenValueWrapper> provenValueWrapperList {get;set;}
    
    public String field {get;set;}
    public String operator {get;set;}
    public String value {get;set;}
    public Opportunity oppDummy {get;set;}
    
    public String field1 {get;set;}
    public String operator1 {get;set;}
    public String value1 {get;set;}
    public Opportunity oppDummy1 {get;set;}
    
    public String field2 {get;set;}
    public String operator2 {get;set;}
    public String value2 {get;set;}
    public Opportunity oppDummy2 {get;set;}
    
    public String field3 {get;set;}
    public String operator3 {get;set;}
    public String value3 {get;set;}
    public Opportunity oppDummy3 {get;set;}
    
    public String field4 {get;set;}
    public String operator4 {get;set;}
    public String value4 {get;set;}
    public Opportunity oppDummy4 {get;set;}
    
    public String filterLogic {get;set;}
    
    private String finalFilter;
    private Boolean hasErrors;
    
    public String oppid {get; set;}
    public String trendid {get; set;}

    public String iniciativeId {get; set;}
    
    public String pastProventValueid {get; set;}   
    
    public String strategicContextId {get; set;}
    
    public Boolean canEdit {get;set;}
    
    public List <NecesidadWrapper> necesidadesWpp {get; set;}
    
    Map<Id, OportunidadWrapper> WrappersDeOportunidadPorId {get; set;}
    Map<Id, NecesidadWrapper> WrappersDeNecesidadPorId {get;set;}
    
    public accountIndustryTrends(){
        WrappersDeOportunidadPorId = new Map<Id, OportunidadWrapper>();
        WrappersDeNecesidadPorId = new Map<Id, NecesidadWrapper> ();
        
        
        loadData();
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);
    } 
    
    public void loadData(){
    	
    	oppDummy = new Opportunity();
    	oppDummy1 = new Opportunity();
    	oppDummy2 = new Opportunity();
    	oppDummy3 = new Opportunity();
    	oppDummy4 = new Opportunity();
    	
    	if (Util.globalAccount==null) {
        	this.account = [SELECT name, id, parentId, Industry, Region__c, Sector__C, Micro_Industry__c, Strategic_Context__c, Strategic_Context_Last_Update__c FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
    	} else {
    		this.account = Util.globalAccount; 
    	}
        
        
        if (finalFilter == null || finalFilter == '') {
        	this.opportunities = [SELECT id, Account.Name, Name, Amount, Probability, CloseDate, StageName, (SELECT Industry_Trend__c, Industry_Trend__r.name, Industry_Trend__r.Trend__c FROM IndustryTrends__r ORDER BY Industry_Trend__r.name DESC), (SELECT Strategic_Initiative__c, Strategic_Initiative__r.name, Strategic_Initiative__r.Strategic_Initiative__c FROM StrategicInitiatives__r ORDER BY Strategic_Initiative__r.name DESC), (select id from ContactsAssessments__r), (select id, name, PastProvenValueNew__r.Name, PastProvenValueNew__r.Unique_Value__c from OpportunityPastProvenValueNew__r) FROM Opportunity WHERE Account.Id = :account.Id and StageName != 'Cancelled' and StageName != 'Closed Won' and StageName != 'Closed Lost' limit 1000];
        } else {
        	String query = 'SELECT id, Account.Name, Name, Amount, Probability, CloseDate, StageName, (SELECT Industry_Trend__c, Industry_Trend__r.name, Industry_Trend__r.Trend__c FROM IndustryTrends__r ORDER BY Industry_Trend__r.name DESC), (SELECT Strategic_Initiative__c, Strategic_Initiative__r.name, Strategic_Initiative__r.Strategic_Initiative__c FROM StrategicInitiatives__r ORDER BY Strategic_Initiative__r.name DESC), (select id from ContactsAssessments__r), (select id, name, PastProvenValueNew__r.Name, PastProvenValueNew__r.Unique_Value__c from OpportunityPastProvenValueNew__r) FROM Opportunity WHERE Account.Id = \'' + account.Id + '\' and StageName != \'Cancelled\' and StageName != \'Closed Won\' and StageName != \'Closed Lost\' and (' + finalFilter + ') limit 1000'; 
        	try {
        		Opportunities = Database.query(query);
        	} catch(Exception e){
        		this.opportunities = [SELECT id, Account.Name, Name, Amount, Probability, CloseDate, StageName, (SELECT Industry_Trend__c, Industry_Trend__r.name, Industry_Trend__r.Trend__c FROM IndustryTrends__r ORDER BY Industry_Trend__r.name DESC), (SELECT Strategic_Initiative__c, Strategic_Initiative__r.name, Strategic_Initiative__r.Strategic_Initiative__c FROM StrategicInitiatives__r ORDER BY Strategic_Initiative__r.name DESC), (select id from ContactsAssessments__r), (select id, name, PastProvenValueNew__r.Name, PastProvenValueNew__r.Unique_Value__c from OpportunityPastProvenValueNew__r) FROM Opportunity WHERE Account.Id = :account.Id and StageName != 'Cancelled' and StageName != 'Closed Won' and StageName != 'Closed Lost' limit 1000];
        		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error 801: ' +Label.badFilter + ' - Query: ' + query + ' Error: ' + e.getMessage()));
        	}
        }
        
        opportunityWrappers = new List<OpportunityWrapper>();
        For (Opportunity o :opportunities) {
            opportunityWrappers.add(new OpportunityWrapper(o));        
        }


        Region__c region = Util.getRegionFromAccount(account.Id, account.region__c);
              
        Regions = new List<ExtendedRegion>();
        
        getAllProvenValueWrapperList();
        loadData(region);
        //Regions = reverseList(Regions);
        
        globalStrategicInitiatives = new List<Strategic_Initiative__c>();
        localStrategicInitiatives = [SELECT name,Strategic_Initiative__c, LastModifiedDate, title__c, (SELECT name, Opportunity__c, Opportunity__r.Name FROM Opportunities__r WHERE Opportunity__r.Account.id = :this.account.id), (SELECT id FROM Potential_New_Business_Strategic_Ini__r) FROM Strategic_Initiative__c WHERE Account__C = :this.account.id];
        
        if(account.parentId != null) {
            getDataFromParents([SELECT name, id, parentId, Industry,Region__c, Strategic_Context__c, Strategic_Context_Last_Update__c FROM Account WHERE Id = :this.account.parentId]);
        }
        
        Map<String,Decimal> mapa_monedas = Util.getCurrencyMap();                  

        List<Id> regionsIds = Util.getParentsRegions(region);
        solutions = [select Region__c,(SELECT Current_state__c FROM Accounts_Industry_Trends__r WHERE Account__c =:account.id), LastModifiedDate, 
                     Name, Trend__c, URL_Attachment__c, title__c, relatedTo__c, relatedTo__r.title__c, relatedTo__r.trend__c, relatedTo__r.relatedTo__C, 
                     relatedTo__r.relatedTo__r.trend__c, relatedTo__r.relatedTo__r.title__c, 
                     (SELECT name, Opportunity__c, Opportunity__r.name FROM Opportunities__R  WHERE Opportunity__r.Account.id = :account.id and Opportunity__r.stagename != 'Closed Won' and Opportunity__r.stagename != 'Closed Lost'), (SELECT id FROM Potential_New_Business_Trend__r) from Industry_Trend__c WHERE Region__c in :regionsIds AND (Sub_Sector__c = :account.Industry or Sub_Sector__c = 'Todos' or Sub_Sector__c = 'All') AND (Industry__c = :account.Micro_Industry__c or Industry__c = 'Todos' or Industry__c = 'All') and type__c = 'Soluciones' ORDER BY Name ASC];
    
        //Agregado para nueva tabla.
        
		system.debug(solutions.size());
        necesidadesWpp = new List<NecesidadWrapper>();
        WrappersDeOportunidadPorId = new Map<Id, OportunidadWrapper>();
        WrappersDeNecesidadPorId = new Map<Id, NecesidadWrapper> ();
            for(Industry_trend__c solution: solutions){
                
                SolutionWrapper sw = new SolutionWrapper();
                sw.Trend = solution;
                if(solution.Accounts_Industry_Trends__r.size() > 0){
                    sw.Status = solution.Accounts_Industry_Trends__r[0];
                }
                
                OportunidadWrapper wppOpp = WrappersDeOportunidadPorId.get(solution.RelatedTo__r.id);
                if(wppOpp == null){
                    wppOpp = new OportunidadWrapper(solution.RelatedTo__r.title__c, solution.RelatedTo__r.id);
                    WrappersDeOportunidadPorId.put(solution.RelatedTo__r.id, wppOpp);
                }
                wppOpp.soluciones.add(sw);
                sw.oportunidadIdPadre = wppOpp.oportunidadId;
                
                NecesidadWrapper wppNec = WrappersDeNecesidadPorId.get(solution.RelatedTo__r.RelatedTo__r.id);
                if(wppNec == null){
                    wppNec = new NecesidadWrapper(solution.RelatedTo__r.RelatedTo__r.title__c, solution.RelatedTo__r.RelatedTo__r.id);
                    WrappersDeNecesidadPorId.put(solution.RelatedTo__r.RelatedTo__r.id, wppNec);
                    necesidadesWpp.add(wppNec);
                }
                wppNec.agregarOportunidad(wppOpp);
                wppOpp.necesidadIdPadre = wppNec.necesidadId;
            }

        
        system.debug(necesidadesWpp.size());
    }
		
	public List<SelectOption> getFields(){
        List<SelectOption> options = new List<SelectOption>();

		options.add(new SelectOption('', '--None--'));
		options.add(new SelectOption('Name', Opportunity.Name.getDescribe().getLabel()));
		options.add(new SelectOption('Amount', Opportunity.Amount.getDescribe().getLabel()));
		options.add(new SelectOption('Probability', Opportunity.Probability.getDescribe().getLabel()));
		options.add(new SelectOption('StageName', Opportunity.StageName.getDescribe().getLabel()));
		options.add(new SelectOption('CloseDate', Opportunity.CloseDate.getDescribe().getLabel()));
       	
       	return options;        
    }
    
    public List<SelectOption> getOperators(){
    	return getOperators(field);	
    }
    
    public List<SelectOption> getOperators1(){
    	return getOperators(field1);	
    }
    
    public List<SelectOption> getOperators2(){
    	return getOperators(field2);	
    }
    
    public List<SelectOption> getOperators3(){
    	return getOperators(field3);	
    }
    
    public List<SelectOption> getOperators4(){
    	return getOperators(field4);	
    }
    
    public List<SelectOption> getOperators(String field){
        List<SelectOption> options = new List<SelectOption>();
		
		options.add(new SelectOption('', '--None--'));
		if (field == 'Name' || field == 'StageName') {			
			options.add(new SelectOption('val%',Label.start_with));
			options.add(new SelectOption('%val',Label.end_with));
			options.add(new SelectOption('%val%',Label.contain));
			options.add(new SelectOption('not %val%',Label.not_contain));
			options.add(new SelectOption('=',Label.equals));
			options.add(new SelectOption('!=',Label.not_equal_to));
		} else if (field == 'Amount' || field == 'Probability' || field == 'CloseDate') {
			options.add(new SelectOption('>',Label.Greater_than));
			options.add(new SelectOption('<',Label.Less_than));
			options.add(new SelectOption('=',Label.equals));
			options.add(new SelectOption('!=',Label.not_equal_to));
		}
       	
       	return options;        
    }
    
    public String getFieldName() {
    	return getFieldName(field, operator);
    }
    
    public String getFieldName1() {
    	return getFieldName(field1, operator1);
    }
    
    public String getFieldName2() {
    	return getFieldName(field2, operator2);
    }
    
    public String getFieldName3() {
    	return getFieldName(field3, operator3);
    }
    
    public String getFieldName4() {
    	return getFieldName(field4, operator4);
    }
    
	public List<SelectOption> getStages() {
		List<SelectOption> options = new List<SelectOption>();
            
       	Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();
       	List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       	for( Schema.PicklistEntry f : ple) {
          	options.add(new SelectOption(f.getValue(),f.getLabel()));
       	}       
       	return options;
	}
    
    private String getFieldName(String field,String operator) {
    	if (field == 'StageName' && (operator == '=' || operator == '!=')) {
    		return 'Stage';
    	} else if (field == 'CloseDate') {
    		return 'Date';
    	}
    	return '';
    }
    
    private String setValueDate(String field, String value, Date dat) {
    	if (field == 'CloseDate') {
    		String y = dat.year()+'';
    		String m = dat.month()+'';
    		if (m.length()<2) {
    			m = '0'+m;
    		}    		
    		String d = dat.day()+'';
    		if (d.length()<2) {
    			d = '0'+d;
    		}
    		return y + '-' + m + '-' + d;		
    	}    	
    	return value; 
    }
    
    public PageReference setFilter() {
    	hasErrors = false;
    	
    	value = setValueDate(field,value,oppDummy.CloseDate);
    	value1 = setValueDate(field1,value1,oppDummy1.CloseDate);
    	value2 = setValueDate(field2,value2,oppDummy2.CloseDate);
    	value3 = setValueDate(field3,value3,oppDummy3.CloseDate);
    	value4 = setValueDate(field4,value4,oppDummy4.CloseDate);
    	
    	String condition1 = setFilters(field,operator,value);
    	String condition2 = setFilters(field1,operator1,value1);
    	String condition3 = setFilters(field2,operator2,value2);
    	String condition4 = setFilters(field3,operator3,value3);
    	String condition5 = setFilters(field4,operator4,value4);
 		
 		if (filterLogic == '') {
 			if (condition1 != '') {
 				filterLogic += '1';
 			}
 			if (condition2 != '') {
 				if (filterLogic != '') {
 					filterLogic += ' and ';
 				}
 				filterLogic += '2';
 			}
 			if (condition3 != '') {
 				if (filterLogic != '') {
 					filterLogic += ' and ';
 				}
 				filterLogic += '3';
 			}
 			if (condition4 != '') {
 				if (filterLogic != '') {
 					filterLogic += ' and ';
 				}
 				filterLogic += '4';
 			}
 			if (condition5 != '') {
 				if (filterLogic != '') {
 					filterLogic += ' and ';
 				}
 				filterLogic += '5';
 			}
 		}
 		 		
    	filterLogic = filterLogic.toUpperCase();
    	if (filterLogic.containsOnly('()12345ANDOR ')) {
	    	String fLogic = String.escapeSingleQuotes(filterLogic);    	
	    	fLogic = fLogic.replace('1','$1').replace('2','$2').replace('3','$3').replace('4','$4').replace('5','$5').replace('OR',' OR ').replace('AND',' AND ');
					
			finalFilter = fLogic.replace('$1',condition1).replace('$2',condition2).replace('$3',condition3).replace('$4',condition4).replace('$5',condition5);       	
    	} else {
    		hasErrors = true;
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error 804: ' +Label.badFilter));
    	}
    	
    	if (!hasErrors) {
    		loadData();
    	}
    	return null;
    }
    
    private String setFilters(String field, String operator, String value) {
    	String filter = '';
    	if (field != null && field != '' && operator != null && operator != '' && value != null && value != '' ) {
    		if (field == 'Name' || field == 'StageName') {
    			if (operator == 'val%' || operator == '%val' || operator == '%val%' || operator == 'not %val%') {
    				if (operator == 'val%') { 
    					filter += String.escapeSingleQuotes(field) + ' like \'' + String.escapeSingleQuotes(value) + '%\' ';
    				} else if (operator == '%val') { 
    					filter += String.escapeSingleQuotes(field) + ' like \'%' + String.escapeSingleQuotes(value) + '\' ';
    				}  else if (operator == '%val%') { 
    					filter += String.escapeSingleQuotes(field) + ' like \'%' + String.escapeSingleQuotes(value) + '%\' ';
    				} else if (operator == 'not %val%') {
    					filter += '(not ' + String.escapeSingleQuotes(field) + ' like \'%' + String.escapeSingleQuotes(value) + '%\') ';
    				}
    			} else if (operator == '=' || operator == '!=') {
    				filter += String.escapeSingleQuotes(field) + ' ' + String.escapeSingleQuotes(operator) + ' \'' + String.escapeSingleQuotes(value) + '\'';    				
    			} else {
    				hasErrors = true;
    				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error 802: ' +Label.badFilter));
    			}
    		} else if (field == 'Amount' || field == 'Probability') {
    			if (operator == '>' || operator == '<' || operator == '='  || operator == '!=') {
    				filter += String.escapeSingleQuotes(field) + ' ' + String.escapeSingleQuotes(operator) + ' ' + String.escapeSingleQuotes(value);
    			} else {
    				hasErrors = true;
    				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error 803: ' +Label.badFilter));
    			}
    		} else if (field == 'CloseDate') {
    			filter += String.escapeSingleQuotes(field) + ' ' + String.escapeSingleQuotes(operator) + ' ' + String.escapeSingleQuotes(value);
    		}  		
    	}
    	return filter;
    }
	
	private void getAllProvenValueWrapperList() {
		//provenValueWrapperList = new AccountPastProvenValueNewController().provenValueWrapperList;
		provenValueWrapperList = new List<AccountPastProvenValueNewController.ProvenValueWrapper>();
		if (account.parentId != null) {
			List<Id> accountIdList = new List<Id>();
			
			for (Account acc :[select id from account where (id = :account.parentId or parentId = :account.parentId) and id != :account.id]) {
				accountIdList.add(acc.id);				
			}
			
			for (PastProvenValueNew__c p :[select id, name, account__c, Unique_Value__c, type__c, region__c, account__r.Name, LastModifiedDate, (SELECT name, Opportunity__c, Opportunity__r.Name FROM OpportunityPastProvenValueNew__r WHERE Opportunity__r.Account.id = :this.account.id), (SELECT name, Potential_New_Business__c, Potential_New_Business__r.Name  FROM Potential_New_Business_Past_Provent__r) from PastProvenValueNew__c where account__c in :accountIdList]) {
				provenValueWrapperList.add(new AccountPastProvenValueNewController.ProvenValueWrapper(p,p.account__r.Name,false));
			}	
		}
						
		for (PastProvenValueNew__c p :[select id, name, account__c, Unique_Value__c, type__c, region__c, LastModifiedDate, (SELECT name, Opportunity__c, Opportunity__r.Name FROM OpportunityPastProvenValueNew__r WHERE Opportunity__r.Account.id = :this.account.id), (SELECT name, Potential_New_Business__c, Potential_New_Business__r.Name  FROM Potential_New_Business_Past_Provent__r) from PastProvenValueNew__c where account__c = :account.id]) {
			provenValueWrapperList.add(new AccountPastProvenValueNewController.ProvenValueWrapper(p,account.Name,true));
		}
	}	
	    
    public void getDataFromParents(Account a){
    
        if(a.parentId != null){
            getDataFromParents([SELECT name, id, parentId, Industry,Region__c, Strategic_Context__c, Strategic_Context_Last_Update__c FROM Account WHERE Id = :a.parentId]);
        }
            
        List<Strategic_Initiative__c> temp = [SELECT name,Strategic_Initiative__c, LastModifiedDate, title__c,
                                            	(SELECT name, Opportunity__c, Opportunity__r.name FROM Opportunities__r  WHERE Opportunity__r.Account.Id = :this.account.id), 
                                            	(SELECT id FROM Potential_New_Business_Strategic_Ini__r) 
                                              FROM Strategic_Initiative__c 
                                              WHERE Account__C = :a.id];
        
        if(temp != null) {
            globalStrategicInitiatives.addAll(temp);
        }
    
    }
    
    //private List<Id> regionsIds;
    private Map<Id,Region__c> regionsMaps;
    
    public void loadData(Region__c region){
    	/*
        if (regionsIds == null) {
        	regionsIds = new List<Id>();
        	regionsIds.add(region.id);
        	regionsMaps = new Map<Id,Region__c>();        	
        }
        regionsMaps.put(region.id,region);
        if(region.parent__c != null){
            regionsIds.add(region.parent__c);
            Region__c parent = [SELECT Id,Name, parent__c FROM Region__c WHERE id = :region.parent__c];            
            loadData(parent);
        } else {
        	
            List< Industry_Trend__c > Trends = [select Region__c, LastModifiedDate, Name, Trend__c, URL_Attachment__c, title__c, (SELECT name, Opportunity__c, Opportunity__r.name FROM Opportunities__R  WHERE Opportunity__r.Account.id = :account.id and Opportunity__r.stagename != 'Closed Won' and Opportunity__r.stagename != 'Closed Lost') from Industry_Trend__c WHERE Region__c in :regionsIds AND (Sub_Sector__c = :account.Industry or Sub_Sector__c = 'Todos' or Sub_Sector__c = 'All') AND (Industry__c = :account.Micro_Industry__c or Industry__c = 'Todos' or Industry__c = 'All') and type__c != 'Soluciones' ORDER BY Name ASC];
        	Map<Id, List<Industry_Trend__c >> regionTrendsMap = new Map<Id, List<Industry_Trend__c >>();
        	for (Industry_Trend__c trend :Trends) {
        		if (regionTrendsMap.get(trend.region__c)==null) {
        			regionTrendsMap.put(trend.region__c, new List<Industry_Trend__c>());
        		}
        		regionTrendsMap.get(trend.region__c).add(trend);
        	}
        	For (Id regionId :regionTrendsMap.KeySet()) { 
        		Regions.add(new ExtendedRegion(regionsMaps.get(regionId),regionTrendsMap.get(regionId)));
        	}
            
        	For (PastProvenValueNew__c p :[select id, name, account__c, Unique_Value__c, type__c, region__c, LastModifiedDate, (SELECT name, Opportunity__c, Opportunity__r.Name FROM OpportunityPastProvenValueNew__r WHERE Opportunity__r.Account.id = :this.account.id), (SELECT name, Potential_New_Business__c, Potential_New_Business__r.Name  FROM Potential_New_Business_Past_Provent__r) from PastProvenValueNew__c where (industry__c = :account.industry or industry__c = 'All' or industry__c = 'Todos') and (micro_industry__c = :account.micro_industry__c or micro_industry__c = 'All' or micro_industry__c = 'Todos') and region__c in :regionsIds]) {
				provenValueWrapperList.add(new AccountPastProvenValueNewController.ProvenValueWrapper(p,regionsMaps.get(p.region__c).Name,false));
			}

        }
		*/
    }
    
    public List<ExtendedRegion> reverseList(List<ExtendedRegion> L){
    
        List<ExtendedRegion> ret  = new List<ExtendedRegion>();
        Integer i = L.size()-1;
        for(;i>=0;i--){
            ret.add(L[i]);
        }

        return ret;
    }
    

    public PageReference linkTrend() {
        insert new OportunityIndustryTrend__c(Industry_Trend__c = trendid, Opportunity__c = oppid);
        loadData();
        return null;
    }

    public PageReference linkIniciative() {
        insert new OpportunityStrategicInitiative__c(Strategic_Initiative__c = iniciativeid, Opportunity__c = oppid);
        loadData();
        return null;
    }
	
	public PageReference linkPastProventValue() {
        insert new OpportunityPastProvenValueNew__c(PastProvenValueNew__c = pastProventValueid, Opportunity__c = oppid);
        loadData();
        return null;
    }
	/*
	public PageReference linkStrategicContext() {
        insert new OpportunityStrategicContext__c(account__c = strategicContextId, Opportunity__c = oppid);
        loadData();
        return null;
    }
	*/
    public PageReference unlinkTrend() {
        delete [SELECT id FROM OportunityIndustryTrend__c WHERE id = :trendid];
        loadData();
        return null;
    }

    public PageReference unlinkIniciative() {
        delete [SELECT id FROM OpportunityStrategicInitiative__c WHERE id = :iniciativeid];
        loadData();
        return null;
    }
    
    public PageReference unlinkPastProventValue() {
        delete [SELECT id FROM OpportunityPastProvenValueNew__c WHERE id = :pastProventValueid];
        loadData();
        return null;
    }
    /*
    public PageReference unlinkStrategicContext() {
        delete [SELECT id FROM OpportunityStrategicContext__c WHERE id = :strategicContextId];
        loadData();
        return null;
    }
    */
    public String getIndustry(){
        if(account.Micro_Industry__c != null)
            return account.Micro_Industry__c.replaceAll('[^a-zA-Z]', '');
        else
            return '';
    }

	public PageReference ExportToExcel() {
    	return Page.accountIndustryTrendsExcel;
    	return null;
    }
 	
 	public String getExcelName() {
    	String name = account.Name + '-' + Label.Trend + '.xls';
    	return name.replaceAll(' ', '_').replaceAll(',','');
    }
    
    public PageReference ExportToExcelTrendWindows() {
    	return Page.accountIndustryTrendsWindowNewExcel;
    	return null;
    }
 	
 	public String getExcelNameTrendWindows() {
    	String name = account.Name + '-' + Label.Opportunities_Value_Proposition + '.xls';
    	return name.replaceAll(' ', '_').replaceAll(',','');
    } 


    class OpportunityWrapper {

        public Opportunity opp {get;set;}
        public Potential_New_Business__c pnb {get;set;}

        public OpportunityWrapper(Opportunity o) {
            Opp = o;
            pnb = new Potential_New_Business__c();
            if (opp.amount != null) {
                pnb.Estimated_FCV__c = o.amount;
                if (Util.checkMultiCurrencyEnabled()) {
                    pnb.put('currencyIsoCode',opp.get('currencyIsoCode'));
                }        
            }
        }

    }
    
    //wrappers 

    class SolutionWrapper {
        public String oportunidadIdPadre {get; set;}
        public Industry_Trend__c Trend {get; set;}
        public Account_Industry_Trend__c Status {get; set;}
    }
    
    class NecesidadWrapper {
        public String necesidad {get; set;}
        public String necesidadId {get; set;}
        public List<OportunidadWrapper> oportunidades {get; set;}
        
        public NecesidadWrapper (String unaNecesidad, String idPropio){
            necesidad = unaNecesidad;
            necesidadId = idPropio;
            
            oportunidades = new List<OportunidadWrapper>();
        }
        
        public void agregarOportunidad(OportunidadWrapper wppOpp){
            
            boolean contains = false;
            for (Integer i = oportunidades.size() - 1; i >= 0;-- i) {
                if (oportunidades.get(i) == wppOpp) {
                    contains = true;
                }
            }
            
            if(!contains){
                oportunidades.add(wppOpp);    
            }
            
        }
        
    }
    
    class OportunidadWrapper {
        
        public String Oportunidad {get; set;}
        public String necesidadIdPadre {get; set;}
        public String oportunidadId {get; set;}
        
        public List<SolutionWrapper> soluciones {get; set;}
        
        public OportunidadWrapper (String unaOportunidad, String idPropio){
            Oportunidad = unaOportunidad;
            oportunidadId = idPropio;
            
            soluciones = new List<SolutionWrapper>();
        }
        
        public Decimal getCantidadDeRenglones(){ 
         
            Decimal renglones = 0;
            system.debug('getCantidadDeRenglones');
            
            for(SolutionWrapper sol: soluciones){
                system.debug('renglones');
            	List <SObject> solOpportunitys = sol.Trend.Opportunities__r;
                
                system.debug(solOpportunitys.size());
                
                Decimal cantidadDeOpp = solOpportunitys.size();
                Decimal divisor = 2;
                Decimal renglonesDeLaSolucion = cantidadDeOpp / divisor;
                
                system.debug(renglonesDeLaSolucion);
                
                if( (math.mod(solOpportunitys.size(), 2) ) == 1 ){
                	renglonesDeLaSolucion = renglonesDeLaSolucion + 0.5;    
                }
                
                system.debug(renglonesDeLaSolucion);
                
                if(renglonesDeLaSolucion == 0){renglonesDeLaSolucion = 1;}
                
                system.debug(renglonesDeLaSolucion);
                    
                renglones = renglones + renglonesDeLaSolucion;
                
                system.debug(renglonesDeLaSolucion);
            }
            
            return renglones;
        }
    }
    
}