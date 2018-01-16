public with sharing class OpportunitySnapshotController {
	
	public Opportunity opp {get;set;}
	public List<valueArguments> valueArgumentsList {get;set;}
    public List<valueArguments> solutionsList {get;set;}
	public List<Task> taskList {get;set;}
	public String isoCode {get;set;}
	public Decimal fcv {get;set;}
	public Integer chartSum {get;set;}
	public List<PieWedgeData> pieData {get;set;}
	
	/*
	public List<OportunityIndustryTrend__c> trendList {get;set;}
	public List<OpportunityStrategicInitiative__c> strategicList {get;set;}
	public List<OpportunityPastProvenValueNew__c> pastPtovenValueList {get;set;} 
	*/
	
	public OpportunitySnapshotController(ApexPages.StandardController controller) {        
        opp = (Opportunity)controller.getRecord();
        if (Util.checkMultiCurrencyEnabled()) {
        	isoCode = UserInfo.getDefaultCurrency()+' ';
        	fcv = [select convertCurrency(amount) from Opportunity where id = :opp.id limit 1].get(0).amount;
        } else {
        	isoCode = '$';
        	fcv = fcv = [select amount from Opportunity where id = :opp.id limit 1].get(0).amount;
        }   
        init();        
    }
    
    private void init() {		
		/*
		trendList = [select Industry_Trend__c, Industry_Trend__r.Name, Industry_Trend__r.Trend__c from OportunityIndustryTrend__c where Opportunity__c = :opp.id];			
		strategicList = [select Strategic_Initiative__c, Strategic_Initiative__r.Name, Strategic_Initiative__r.Strategic_Initiative__c from OpportunityStrategicInitiative__c where Opportunity__c = :opp.id];  
		pastPtovenValueList = [select PastProvenValueNew__c, PastProvenValueNew__r.Name, PastProvenValueNew__r.Unique_Value__c from OpportunityPastProvenValueNew__c where Opportunity__c = :opp.id]; 	
    	*/
    	valueArgumentsList = new List<valueArguments>();
    	for (OportunityIndustryTrend__c trend :[select Industry_Trend__c, Industry_Trend__r.Name, Industry_Trend__r.Trend__c from OportunityIndustryTrend__c where Opportunity__c = :opp.id  and Industry_Trend__r.type__c != 'Soluciones']) {
    		valueArgumentsList.add(new valueArguments(trend.Industry_Trend__r.Name, trend.Industry_Trend__r.Trend__c, Label.Trend));
    	}
    	for (OpportunityStrategicInitiative__c strategic :[select Strategic_Initiative__c, Strategic_Initiative__r.Name, Strategic_Initiative__r.Strategic_Initiative__c from OpportunityStrategicInitiative__c where Opportunity__c = :opp.id]) {
    		valueArgumentsList.add(new valueArguments(strategic.Strategic_Initiative__r.Name, strategic.Strategic_Initiative__r.Strategic_Initiative__c, Label.Iniciativa));
    	}
    	for (OpportunityPastProvenValueNew__c ppv :[select PastProvenValueNew__c, PastProvenValueNew__r.Name, PastProvenValueNew__r.Unique_Value__c, PastProvenValueNew__r.Type__c from OpportunityPastProvenValueNew__c where Opportunity__c = :opp.id]) {
    		valueArgumentsList.add(new valueArguments(ppv.PastProvenValueNew__r.Name, ppv.PastProvenValueNew__r.Unique_Value__c, ppv.PastProvenValueNew__r.Type__c));
    	}

        solutionsList = new List<valueArguments>();
        for (OportunityIndustryTrend__c trend :[select Industry_Trend__c, Industry_Trend__r.title__c, Industry_Trend__r.type__c, Industry_Trend__r.Name, Industry_Trend__r.Trend__c from OportunityIndustryTrend__c where Opportunity__c = :opp.id and Industry_Trend__r.type__c = 'Soluciones']) {
            solutionsList.add(new valueArguments(trend.Industry_Trend__r.Name, trend.Industry_Trend__r.title__c, trend.Industry_Trend__r.trend__c));
        }
    	/*
    	for (OpportunityStrategicContext__c strategicCont :[select Account__c, Account__r.Id, Account__r.Strategic_Context__c from OpportunityStrategicContext__c where Opportunity__c = :opp.id]) {
    		valueArgumentsList.add(new valueArguments(strategicCont.Account__r.Id, strategicCont.Account__r.Strategic_Context__c, 'Strategic Context'));
    	}
    	*/
    	
    	taskList = [select subject, Description, ActivityDate, Status,Priority,End_date__c, OwnerId, CreatedDate, Owner.Name, URL__C FROM Task WHERE WhatId = :opp.id];
    	generatePieData();
    }
	
	public PageReference save() {
		update opp;
		return null;		
	}
	
	public PageReference saveTask() {
		update taskList;
		return null;		
	}
	
	class valueArguments {
		
		public String id {get;set;}
		public String argument {get;set;}
		public String argType {get;set;}
		
		public valueArguments(String i, String arg, String argT) {
			id = i;
			argument = arg;
			argType = argT;
		}
		
	}
	
	private void generatePieData() {  
        
        pieData = new List<PieWedgeData>();
                
        for(Big_Deal__c bd :[select id, question1__c, question2__c, question3__c, question4__c, question5__c, question6__c, question7__c, question8__c, date1__c, date2__c, currency1__c, currency2__c, number1__c, number2__c, number3__c, number4__c from Big_Deal__c where opportunity__c = :opp.id]) {           
            
            Integer calendar = 0;
            if (bd.date1__c != null) {
            	calendar += 10;
            }
            if (bd.date2__c != null) {
            	calendar += 10;
            }
            
            Integer economic = 0;
            if (bd.currency1__c != null) {
            	economic += 10;
            }
            if (bd.currency2__c != null) {
            	economic += 10;
            }
            
            Integer alc = 0;
            if (bd.number1__c != null) {
            	alc += 10;
            }
            if (bd.number2__c != null) {
            	alc += 10;
            }
            
            Integer prev = 0;
            if (bd.number3__c != null) {
            	prev += 10;
            }
            if (bd.number4__c != null) {
            	prev += 10;
            }
            
            Integer rie = 0;
            if (bd.question1__c != null) {
            	rie += 10;
            }
            if (bd.question2__c != null) {
            	rie += 10;
            }
            
            chartSum = calendar + economic + alc + prev + rie;
            integer chartTotal = 10;
            
            //pieData.add(new PieWedgeData('Empty',chartTotal - chartSum));
            pieData.add(new PieWedgeData('Calendario',calendar));
            pieData.add(new PieWedgeData('Datos Económicos',economic));
            pieData.add(new PieWedgeData('Alcance',alc));
            pieData.add(new PieWedgeData('Preventa y Oferta',prev));
            pieData.add(new PieWedgeData('Riesgos',rie));
        }
    }  
    
    // Wrapper class  
    public class PieWedgeData 
    {  
        public String name { get; set; }  
        public Integer data { get; set; }  
        
        public PieWedgeData(String name, Integer data) {  
              
            if (data != null) {
            	this.data = data;
            } else {
            	this.data = 0;
            } 
            this.name = name;
        }  
    } 
	
}