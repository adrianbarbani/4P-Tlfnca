public class DCMEvaluateCriteriaController {

    public Opportunity opportunity {get; set;}
    public List<SCP_Criteria_DCM__c> evaluatedDCM {get; set;}
    public Set<String> notEvaluatedDCM;
    public SCP_Criteria_DCM__c newEval { get; set; }
    public Account account {get; set;}
    public Boolean canEdit {get;set;}
    public String criteriaToEvaluate {get;set;}
    public String delid {get;set;}
    public String newCriteria {get;set;}

    public List<SCP_Criteria_DCM__c> ourVK;
    public List<SCP_Criteria_DCM__c> ourVW;
    public List<SCP_Criteria_DCM__c> ourNV;
    public List<SCP_Criteria_DCM__c> ourVS;  

    public List<SCP_Criteria_DCM__c> competitorVK;
    public List<SCP_Criteria_DCM__c> competitorVW;
    public List<SCP_Criteria_DCM__c> competitorNV;
    public List<SCP_Criteria_DCM__c> competitorVS;

    public DCMEvaluateCriteriaController(){        
        this.opportunity = [SELECT name, id, AccountId FROM Opportunity WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        this.evaluatedDCM = [Select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id];        
        this.account = [SELECT name, id, parentId, Industry, Region__c, parent.name FROM Account WHERE Id = :opportunity.accountid];
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);        
    }
    
    public PageReference DeleteEvaluation() {
        system.debug('>>>>> Delete');
        delete [SELECT id FROM SCP_Criteria_DCM__c WHERE id = :this.delid];
        this.evaluatedDCM = [Select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id];       
        resetLists();
        return null;
    }

    public PageReference popCriteriaEvaluation() {              
        this.newEval = new SCP_Criteria_DCM__c();        
        this.newEval.Criteria__c = criteriaToEvaluate;
        this.newEval.SCP_Oportunidad__c = opportunity.id;        
        system.debug('>>>>> popCriteriaEvaluation - newEval: ' + newEval);
        return null;
    }
    
    public PageReference InsertEvaluation() {        
        insert newEval;
        newEval = null;
        criteriaToEvaluate = null;        
        this.evaluatedDCM = [Select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id];        
        resetLists();
        return null;        
    }
    
    public Set<String> getNotEvaluatedDCM() {       
        //this.notEvaluatedDCM = Criteria__c.getAll().keySet();
        this.notEvaluatedDCM = new Set<String>();                
        for (SCP_Criteria_DCM__c dcm :[select Criteria__c, SCP_Oportunidad__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = null or (SCP_Oportunidad__r.accountId = :opportunity.accountId and SCP_Oportunidad__c != :opportunity.id)]) {
        	this.notEvaluatedDCM.add(dcm.Criteria__c);
        }
        for (SCP_Criteria_DCM__c dcm :evaluatedDCM) {
            this.notEvaluatedDCM.remove(dcm.Criteria__c);
        }   
        return this.notEvaluatedDCM;
    }
    
     public PageReference addNewCriteria() {        
        if (newCriteria != null && newCriteria.replace(' ','') != '' && !Criteria__c.getAll().keySet().contains(newCriteria)) {
            Criteria__c criteria = new Criteria__c(Name = newCriteria);
            insert criteria;
        }
        newCriteria = null;                
        return null;
    }
    
    public PageReference saveEvaluatedDCM() {       
        Boolean errors = false;
        
        for (SCP_Criteria_DCM__c c :evaluatedDCM) {
        	if (c.Criteria__c == null) {
        		errors = true;
        		c.Criteria__c.addError('Debe escribir un valor');
        	}else if (c.Customer_Consideration__c == null) {
        		errors = true;
        		c.Customer_Consideration__c.addError('Debe escribir un valor');
        	}else if (c.Our_Competitive_Standing__c == null) {
        		errors = true;
        		c.Our_Competitive_Standing__c.addError('Debe escribir un valor');
        	}else if (c.Competitors_Competitive_Standing__c == null) {
        		errors = true;
        		c.Competitors_Competitive_Standing__c.addError('Debe escribir un valor');
        	}
        }
        
        if (!errors) {
        	update evaluatedDCM;
        	resetLists();
        }
        return null;
    }
    
    public List<SCP_Criteria_DCM__c> getOurVK() {        
        if (ourVK == null) {
            ourVK = new List<SCP_Criteria_DCM__c>();
            for (SCP_Criteria_DCM__c dcm :[select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id and Customer_Consideration__c = 'HIGH' and Our_Competitive_Standing__c = 'LOW']) {
                ourVK.add(dcm);
            }           
        }   
        return ourVK;
    }
    
    public List<SCP_Criteria_DCM__c> getOurVW() {        
        if (ourVW == null) {
            ourVW = new List<SCP_Criteria_DCM__c>();
            for (SCP_Criteria_DCM__c dcm :[select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id and Customer_Consideration__c = 'HIGH' and Our_Competitive_Standing__c = 'HIGH']) {
                ourVW.add(dcm);
            }                       
        }   
        return ourVW;
    }
    
    public List<SCP_Criteria_DCM__c> getOurNV() {        
        if (ourNV == null) {
            ourNV = new List<SCP_Criteria_DCM__c>();
            for (SCP_Criteria_DCM__c dcm :[select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id and Customer_Consideration__c = 'LOW' and Our_Competitive_Standing__c = 'LOW']) {
                ourNV.add(dcm);
            }                       
                        
        }   
        return ourNV;
    }
    
    public List<SCP_Criteria_DCM__c> getOurVS() {        
        if (ourVS == null) {
            ourVS = new List<SCP_Criteria_DCM__c>();
            for (SCP_Criteria_DCM__c dcm :[select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id and Customer_Consideration__c = 'LOW' and Our_Competitive_Standing__c = 'HIGH']) {
                ourVS.add(dcm);
            }           
        }   
        return ourVS;
    }

    public List<SCP_Criteria_DCM__c> getCompetitorVK() {     
        if (competitorVK == null) {
            competitorVK = new List<SCP_Criteria_DCM__c>();
            for (SCP_Criteria_DCM__c dcm :[select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id and Customer_Consideration__c = 'HIGH' and Competitors_Competitive_Standing__c = 'LOW']) {
                competitorVK.add(dcm);
            }           
        }   
        return competitorVK;
    }
    
    public List<SCP_Criteria_DCM__c> getCompetitorVW() {     
        if (competitorVW == null) {
            competitorVW = new List<SCP_Criteria_DCM__c>();
            for (SCP_Criteria_DCM__c dcm :[select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id and Customer_Consideration__c = 'HIGH' and Competitors_Competitive_Standing__c = 'HIGH']) {
                competitorVW.add(dcm);
            }           
        }   
        return competitorVW;
    }
    
    public List<SCP_Criteria_DCM__c> getCompetitorNV() {     
        if (competitorNV == null) {
            competitorNV = new List<SCP_Criteria_DCM__c>();
            for (SCP_Criteria_DCM__c dcm :[select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id and Customer_Consideration__c = 'LOW' and Competitors_Competitive_Standing__c = 'LOW']) {
                competitorNV.add(dcm);
            }           
        }   
        return competitorNV;
    }
    
    public List<SCP_Criteria_DCM__c> getCompetitorVS() {     
        if (competitorVS == null) {
            competitorVS = new List<SCP_Criteria_DCM__c>();
            for (SCP_Criteria_DCM__c dcm :[select SCP_Oportunidad__c, Our_Competitive_Standing__c, Customer_Consideration__c, Criteria__c, Competitors_Competitive_Standing__c, Approach__c, Our_Standing__c, Competitor_Standing__c from SCP_Criteria_DCM__c where SCP_Oportunidad__c = :opportunity.id and Customer_Consideration__c = 'LOW' and Competitors_Competitive_Standing__c = 'HIGH']) {
                competitorVS.add(dcm);
            }           
        }   
        return competitorVS;
    }
    
    private void resetLists() {
        ourVK = null;
        ourVW = null;
        ourNV = null;
        ourVS = null;   
        
        competitorVK = null;
        competitorVW = null;
        competitorNV = null;
        competitorVS = null;
        
    }
    
    public PageReference ExportToExcel() {      
        saveEvaluatedDCM();
        return Page.DCMEvaluateCriteriaExcel;
    }
    
    public String getExcelName() {
        String name = account.Name + '-' + Label.DCM + '.xls';
        return name.replaceAll(' ', '_').replaceAll(',','');
    }
}