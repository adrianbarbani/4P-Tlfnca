public class accountOpportunities {

    private ApexPages.StandardController controller;
    private final Account acct;
    public List<Opportunity> opportunities {get;set;}
    public List<OpportunityWrapper> oppWrappers {get;set;}
    public Boolean canEdit {get;set;}
    public String isoCode {get;set;}
    
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
        
    public accountOpportunities(ApexPages.StandardController controller) {
        
        this.controller = controller;
        this.acct = (Account)controller.getRecord();

        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.acct);

        loadOpps();
    }
    
    public void loadOpps(){
    	oppWrappers = new List<OpportunityWrapper>();
    	oppDummy = new Opportunity();
    	oppDummy1 = new Opportunity();
    	oppDummy2 = new Opportunity();
    	oppDummy3 = new Opportunity();
    	oppDummy4 = new Opportunity();    	
    	
    	String query;
    	
    	try { 
	    	if (Util.checkMultiCurrencyEnabled()) {
	    		isoCode = UserInfo.getDefaultCurrency()+' ';
		    	
		    	if (finalFilter == null || finalFilter == '') {
		    		Opportunities = [SELECT id, Name, Probability, StageName, convertCurrency(Amount), (select id from ContactsAssessments__r) 
	    					  		FROM Opportunity
	                          		WHERE accountId = :acct.Id and StageName != 'Cancelled' and StageName != 'Closed Won' and StageName != 'Closed Lost'
	                          		order by amount desc];	
		    	} else {
		    		query = 'SELECT id, Name, Probability, StageName, convertCurrency(Amount), (select id from ContactsAssessments__r)' + 
	    					  		' FROM Opportunity' +
	                          		' WHERE accountId = \'' + acct.Id + '\' and StageName != \'Cancelled\' and StageName != \'Closed Won\' and StageName != \'Closed Lost\'' + 
	                          		' and (' + finalFilter + ')' + 
	                          		' order by amount desc';
		    		Opportunities = Database.query(query);
		    	}
		    	
	    	} else {
	    		isoCode = '$';
		    	if (finalFilter == null || finalFilter == '') {
			    	Opportunities = [SELECT id, Name, Probability, StageName, Amount, (select id from ContactsAssessments__r) 
		    					  FROM Opportunity
		                          WHERE accountId = :acct.Id and StageName != 'Cancelled' and StageName != 'Closed Won' and StageName != 'Closed Lost' 
		                          order by amount desc];	
		    	} else {
		    		query = 'SELECT id, Name, Probability, StageName, Amount, (select id from ContactsAssessments__r)' + 
	    					  		' FROM Opportunity' +
	                          		' WHERE accountId = \'' + acct.Id + '\' and StageName != \'Cancelled\' and StageName != \'Closed Won\' and StageName != \'Closed Lost\'' + 
	                          		' and (' + finalFilter + ')' + 
	                          		' order by amount desc';
	                system.debug(query);
		    		Opportunities = Database.query(query);
		    	}
	    	}
    	} catch(Exception e){
    		if (Util.checkMultiCurrencyEnabled()) {
	    		isoCode = UserInfo.getDefaultCurrency()+' ';
	    		Opportunities = [SELECT id, Name, Probability, StageName, convertCurrency(Amount), (select id from ContactsAssessments__r) 
	    					  		FROM Opportunity
	                          		WHERE accountId = :acct.Id and StageName != 'Cancelled' and StageName != 'Closed Won' and StageName != 'Closed Lost'
	                          		order by amount desc];
    		} else {
	    		isoCode = '$';
	    		Opportunities = [SELECT id, Name, Probability, StageName, Amount, (select id from ContactsAssessments__r) 
		    					  FROM Opportunity
		                          WHERE accountId = :acct.Id and StageName != 'Cancelled' and StageName != 'Closed Won' and StageName != 'Closed Lost' 
		                          order by amount desc];
    		}
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error 801: ' +Label.badFilter));
    	} 
    	Integer i = 0;    	    	 
    	for (Opportunity opp :Opportunities) {
    		oppWrappers.add(new OpportunityWrapper(opp, opp.amount, i));
    		i++;
    	}
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
    
    private List<SelectOption> getOperators(String field){
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
    		loadOpps();
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
    
    public class OpportunityWrapper {
    	
    	public Opportunity opp {get;set;}
    	public Decimal amount {get;set;}
    	public Integer position {get;set;}
    	
    	public OpportunityWrapper(Opportunity op, Decimal am, Integer i) {
    		opp = op;
    		position = i;    		
    		if (am != null) {
    			amount = am;    		
    		} else {
    			amount = 0;
    		}
    	}
    	
    }
}