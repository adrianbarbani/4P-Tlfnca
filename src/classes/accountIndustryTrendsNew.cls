public with sharing class accountIndustryTrendsNew {
	
	public List<Industry_Trend__c> trends {get;set;}
	public Boolean canEdit {get;set;}
	public Account account {get;set;}
	public List<TrendsWrapper> trendsWrapperList {get;set;}
    public List<SolutionWrapper> Solutions {get; set;}
    public String SolutionsLabel {get; set;}
    
    public List<NecesidadWrapper> necesidadesWpp {get; set;}
    
    Map<Id, OportunidadWrapper> WrappersDeOportunidadPorId {get; set;}
    Map<Id, NecesidadWrapper> WrappersDeNecesidadPorId {get;set;}
    
	public accountIndustryTrendsNew(){
        
        WrappersDeOportunidadPorId = new Map<Id, OportunidadWrapper>();
        WrappersDeNecesidadPorId = new Map<Id, NecesidadWrapper>();
        
        loadData();
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);
    }
    
    public void loadData(){
    	if (Util.globalAccount==null) {
        	account = [SELECT name, id, parentId, Industry, Region__c, Sector__C, Micro_Industry__c, Strategic_Context__c, Strategic_Context_Last_Update__c FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
    	} else {
    		account = Util.globalAccount; 
    	}
    	
        List<Schema.PicklistEntry> Types = Industry_Trend__c.Type__c.getDescribe().getPicklistValues();
    	trendsWrapperList = new List<TrendsWrapper>();
        Map<String, TrendsWrapper> trendsMap = new Map<String, TrendsWrapper>();
        Map<String, String> TypeValToLabel = new Map<String, String>();
        for (Schema.PicklistEntry pe : Types) {
            if(pe.getValue() != 'Soluciones') {
                TrendsWrapper tw = new TrendsWrapper(pe.getLabel());
    			trendsMap.put(pe.getLabel(), tw);
    			trendsWrapperList.add(tw);
            }
            TypeValToLabel.put(pe.getValue(), pe.getLabel());
        }
    	List<Id> regionsIds = Util.getParentsRegions(Util.getRegionFromAccount(account.Id, account.region__c));    	
    	
    	for (Industry_Trend__c trend :[SELECT
                                       		Region__c, Region__r.Name, LastModifiedDate, RelatedTo__c, RelatedTo__r.title__c, RelatedTo__r.Trend__c,
                                       		Name, Trend__c, URL_Attachment__c, title__c, type__c, Comentarios__c
                                       FROM Industry_Trend__c 
                                       WHERE Region__c in :regionsIds AND 
                                       		(Sub_Sector__c = :account.Industry OR Sub_Sector__c = 'Todos' OR Sub_Sector__c = 'All') AND 
                                       		(Industry__c = :account.Micro_Industry__c OR Industry__c = 'Todos' OR Industry__c = 'All') AND
                                       		Type__c != 'Soluciones'
                                       ORDER BY Name ASC]) {
    		
    		trendsMap.get(TypeValToLabel.get(trend.type__c)).trends.add(trend);
    	}
        
        Solutions = new List<SolutionWrapper>();
        necesidadesWpp = new List<NecesidadWrapper>();
        for(Industry_trend__c solution : [SELECT
                                       		Region__c, Region__r.Name, LastModifiedDate, RelatedTo__c, RelatedTo__r.title__c, RelatedTo__r.Trend__c, RelatedTo__r.RelatedTo__r.title__c, RelatedTo__r.RelatedTo__r.Trend__c,
                                       		Name, Trend__c, URL_Attachment__c, title__c, type__c, Comentarios__c,
                                       		(SELECT 
                                             	name, Opportunity__c, Opportunity__r.name 
                                             FROM Opportunities__R  
                                             WHERE Opportunity__r.Account.id = :account.id AND 
                                             	Opportunity__r.stagename != 'Closed Won' AND 
                                             	Opportunity__r.stagename != 'Closed Lost') ,
                                          (SELECT id, potential_New_Business__r.Name, Potential_new_Business__r.Potential_new_Business__c, name, Potential_new_Business__c FROM Potential_New_Business_Trend__r),
                                       		(SELECT
                                             	Name, Current_state__c, Industry_Trend__c
                                             FROM Accounts_Industry_Trends__r
                                             WHERE Account__r.Id = :account.Id)
                                       	FROM Industry_Trend__c 
                                       	WHERE Region__c in :regionsIds AND 
                                       		(Sub_Sector__c = :account.Industry OR Sub_Sector__c = 'Todos' OR Sub_Sector__c = 'All') AND 
                                       		(Industry__c = :account.Micro_Industry__c OR Industry__c = 'Todos' OR Industry__c = 'All') AND
                                       		Type__c = 'Soluciones'
       									ORDER BY Name ASC]) {
            
                                            
                                            SolutionWrapper sw = new SolutionWrapper();
                                            if(solution.Accounts_Industry_Trends__r.size() == 0) {
                                                sw.Status = new Account_Industry_Trend__c(Industry_Trend__c = solution.Id, Account__c = account.Id);
                                            }
                                            else {
                                                sw.Status = solution.Accounts_Industry_Trends__r[0];
                                            }
                                            sw.Trend = solution;
                                            Solutions.add(sw);
                                            
                                            //agregado para victor.
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
        SolutionsLabel = TypeValToLabel.get('Soluciones');
    }
    
    public PageReference save() {
        if(canEdit) {
            List<Account_Industry_Trend__c> acInTrs = new List<Account_Industry_Trend__c>();
            List<Industry_Trend__c> industryTrends = new List<Industry_Trend__c>();
            for(SolutionWrapper sw : Solutions) {
                acInTrs.add(sw.Status);
                industryTrends.add(sw.Trend);
            }
            try {
                upsert acInTrs;
            } catch(DmlException ex){
                ApexPages.addMessages(ex);
            }
            try {
                update industryTrends;
            } catch(DmlException ex){
                ApexPages.addMessages(ex);
            }
        }
        return null;
    }
    
    public PageReference ExportToExcel() {
    	return Page.accountIndustryTrendsExcel;
    	return null;
    }
 	
 	public String getExcelName() {
    	String name = account.Name + '-' + Label.Trend + '.xls';
    	return name.replaceAll(' ', '_').replaceAll(',','');
    }
	
    class SolutionWrapper {
        public String oportunidadIdPadre {get; set;}
        public Industry_Trend__c Trend {get; set;}
        public Account_Industry_Trend__c Status {get; set;}
    }
    
	class TrendsWrapper {
		
		public String type {get;set;}
        public String typeClass {get;set;}
		public List<Industry_Trend__c> trends {get;set;}
		
		public trendsWrapper(String t) {
			type = t;
            if (t == Label.Principales_Players) {
                typeClass = 'Pla';}
            if (t == Label.Contexto_General) {
                typeClass = 'Con';}
            if (t == Label.Metricas_y_Analisis_del_Mercado) {
                typeClass = 'Mét';}
            if (t == Label.Cadena_de_Valor_y_Procesos) {
                typeClass = 'Cad';}
            if (t == Label.Tendencias) {
                typeClass = 'Ten';}
            if (t == Label.Principales_Necesidades) {
                typeClass = 'Pri';}
            if (t == Label.Oportunidad_Sectorial) {
                typeClass = 'Opo';}
             if (t == Label.Soluciones) {
                typeClass = 'Sol';}
            
            //} else {
              //  typeClass = t.substring(0, 3);
            
			trends = new List<Industry_Trend__c>();
		}
		
	}
    
    public class NecesidadWrapper {
        public String necesidad {get; set;}
        public String necesidadId {get; set;}
        public List<OportunidadWrapper> oportunidades {get; set;}
        
        public NecesidadWrapper (String unaNecesidad, String idPropio){
            necesidad = unaNecesidad;
            necesidadId = idPropio;
            
            oportunidades = new List<OportunidadWrapper>();
        }
        
        public void agregarOportunidad(OportunidadWrapper wppOpp){
            
            //se fija si ya existe ese wppOpp en la lista de oportunidades, si esto pasa no lo agrega.
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
    
    public class OportunidadWrapper {
        
        public String Oportunidad {get; set;}
        public String necesidadIdPadre {get; set;}
        public String oportunidadId {get; set;}
            
        public List<SolutionWrapper> soluciones {get; set;}
        
        public OportunidadWrapper (String unaOportunidad, String idPropio){
            Oportunidad = unaOportunidad;
            oportunidadId = idPropio;
 
            soluciones = new List<SolutionWrapper>();
        }
        
    }
    
	
}