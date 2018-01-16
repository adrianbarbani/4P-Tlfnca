public class AccountGrowthStrategyController {

    public Account account {get;set;}
    public Boolean canEdit {get;set;}
 
    public Id toDel {get;set;}
    
    public List<Strategic_Initiative__c>  localStrategicInitiatives { get; set; }
    public List<Strategic_Initiative__c>  globalStrategicInitiatives { get; set; }
    public List<ExtendedRegion> Regions {get;set;}

    public List<Industry_Trend__c>  solutions { get; set; }

    public List<AccountPastProvenValueNewController.ProvenValueWrapper> provenValueWrapperList {get;set;}
    
    public List<Potential_New_Business__c> PotentialNewBusinessList {get;set;}
    public Potential_New_Business__c potentialNewBusiness {get;set;}

    public Potential_New_Business__c totalPotentialNewBusiness {get;set;}
    
    public List <NecesidadWrapper> necesidadesWpp {get; set;}
    
    Map<Id, OportunidadWrapper> WrappersDeOportunidadPorId {get; set;}
    Map<Id, NecesidadWrapper> WrappersDeNecesidadPorId {get;set;}
 
    public String pnbid {
        get;
        // *** setter is NOT being called ***
        set {
            pnbid = value;
        }
    }
    public String trendid {
        get;
        // *** setter is NOT being called ***
        set {
            trendid = value;
        }
    }

    public String iniciativeid {
        get;
        // *** setter is NOT being called ***
        set {
            iniciativeid = value;
        }
    }
    
    public String pastProventValueid {
        get;
        // *** setter is NOT being called ***
        set {
            pastProventValueid = value;
        }
    }   
  
    public AccountGrowthStrategyController() {        
        if (Util.globalAccount==null) {
        	account = [SELECT name, id, parentId, Industry, Region__c, /*Sector__C,*/ Micro_Industry__c, Strategic_Context__c, Strategic_Context_Last_Update__c, /*(select id from OpportunityStrategicContext__r),*/ (select name, Potential_New_Business__c, Potential_New_Business__r.Name from Potential_New_Business_Strategic_Cnt__r) FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];    
        } else {
    		this.account = Util.globalAccount; 
    	}
        
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);                
        init();        
    }
    
    private void init() {
 
        toDel = null;
                
        localStrategicInitiatives = [SELECT name,Strategic_Initiative__c, LastModifiedDate, title__c, (select id from Opportunities__r where opportunity__r.accountId = :account.id), (SELECT name, Potential_New_Business__c, Potential_New_Business__r.Name, Potential_New_Business__r.Potential_New_Business__c  FROM Potential_New_Business_Strategic_Ini__r) FROM Strategic_Initiative__c WHERE Account__C = :this.account.id];
        globalStrategicInitiatives = new List<Strategic_Initiative__c>();
 
        provenValueWrapperList = new AccountPastProvenValueNewController().provenValueWrapperList;
        
        Region__c region = Util.getRegionFromAccount(account.Id, account.region__c);
        /*
        List<Region__c> regionsList = [SELECT Id,Name, parent__c FROM Region__c WHERE id = :this.account.region__c];
        Region__c region = null;
        if (regionsList.size()>0) {
            region = regionsList.get(0);
        } else {
            region = [SELECT Id,Name, parent__c FROM Region__c WHERE name = 'Global'];
        }
        */
        
        Regions = new List<ExtendedRegion>();
        loadData(region);
                
        if(account.parentId != null) {
            getDataFromParents([SELECT name, id, parentId, Industry,Region__c, Strategic_Context__c, Strategic_Context_Last_Update__c /*, (select name, Opportunity__c from OpportunityStrategicContext__r)*/ FROM Account WHERE Id = :this.account.parentId]);        
        }
        
        PotentialNewBusinessList = [select id, Name, Comments__c, Contact_to_approach__c, Estimated_FCV__c, Potential_new_Business__c, Status__c, (SELECT Industry_Trend__c, Industry_Trend__r.name, Industry_Trend__r.Trend__c FROM Potential_New_Business_Trend__r), (SELECT Strategic_Initiative__c, Strategic_Initiative__r.name, Strategic_Initiative__r.Strategic_Initiative__c FROM Potential_New_Business_Strategic_Ini__r ORDER BY Strategic_Initiative__r.name DESC), (select Past_Proven_Value__c, Past_Proven_Value__r.Name, Past_Proven_Value__r.Unique_Value__c from Potential_New_Business_Past_Provent__r) from Potential_New_Business__c where account__c = :account.id];
        potentialNewBusiness = new  Potential_New_Business__c(Account__c = account.id); 

        List<Id> regionsIds = Util.getParentsRegions(region);
        solutions = [select Region__c, LastModifiedDate,(SELECT Current_state__c FROM Accounts_Industry_Trends__r WHERE Account__c =:account.id), Name, Trend__c, URL_Attachment__c, title__c, relatedTo__c, relatedTo__r.title__c, relatedTo__r.trend__c, relatedTo__r.relatedTo__C, relatedTo__r.relatedTo__r.trend__c, relatedTo__r.relatedTo__r.title__c, (SELECT name, Opportunity__c, Opportunity__r.name FROM Opportunities__R  WHERE Opportunity__r.Account.id = :account.id and Opportunity__r.stagename != 'Closed Won' and Opportunity__r.stagename != 'Closed Lost'), (SELECT id, Potential_New_Business__r.Name, Potential_new_Business__r.Potential_new_Business__c FROM Potential_New_Business_Trend__r) from Industry_Trend__c WHERE Region__c in :regionsIds AND (Sub_Sector__c = :account.Industry or Sub_Sector__c = 'Todos' or Sub_Sector__c = 'All') AND (Industry__c = :account.Micro_Industry__c or Industry__c = 'Todos' or Industry__c = 'All') and type__c = 'Soluciones' ORDER BY Name ASC];


        totalPotentialNewBusiness = new Potential_New_Business__c(Estimated_FCV__c = 0);
        for (Potential_New_Business__c p :PotentialNewBusinessList) {
            if (p.Estimated_FCV__c != null) {
                totalPotentialNewBusiness.Estimated_FCV__c +=  p.Estimated_FCV__c;
            }
        }
        
                //Agregado para nueva tabla.
        
		system.debug(solutions.size());
        necesidadesWpp = new List<NecesidadWrapper>();
        WrappersDeOportunidadPorId = new Map<Id, OportunidadWrapper>();
        WrappersDeNecesidadPorId = new Map<Id, NecesidadWrapper> ();
            for(Industry_trend__c solution: solutions){
                
                SolutionWrapper sw = new SolutionWrapper();
                sw.Trend = solution;
                
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

    }
    
    public void loadData(Region__c region){
        /*
        List< Industry_Trend__c > Trends = [select LastModifiedDate, Name, Trend__c, URL_Attachment__c, (select id from Opportunities__r where opportunity__r.accountId = :account.id), (SELECT name, Potential_New_Business__c, Potential_New_Business__r.name, Potential_New_Business__r.Potential_New_Business__c FROM Potential_New_Business_Trend__r) from Industry_Trend__c WHERE Region__c = :region.id AND (Sub_Sector__c = :account.Industry or Sub_Sector__c = 'Todos' or Sub_Sector__c = 'All') And (Industry__c = :account.Micro_Industry__c or Industry__c = 'Todos' or Industry__c = 'All') ORDER BY Name ASC];
 
        Regions.add(new ExtendedRegion(region,Trends));
        if(region.parent__c != null){
            Region__c parent = [SELECT Id,Name, parent__c FROM Region__c WHERE id = :region.parent__c];
            loadData(parent);
        } 
        */
    }
    
    public void del() {
        integer i = 0;
        while(i < PotentialNewBusinessList.size() && PotentialNewBusinessList[i].Id != toDel){
            i++;
        }
        if(i < PotentialNewBusinessList.size()) {
            delete PotentialNewBusinessList[i];
            PotentialNewBusinessList.remove(i);
            provenValueWrapperList = new AccountPastProvenValueNewController().provenValueWrapperList;
        }
    }

    public void getDataFromParents(Account a){
    
        if(a.parentId != null){
            getDataFromParents([SELECT name, id, parentId, Industry,Region__c, Strategic_Context__c/*, (select id from OpportunityStrategicContext__r)*/ FROM Account WHERE Id = :a.parentId]);
        }
            
        List<Strategic_Initiative__c> temp = [SELECT name,Strategic_Initiative__c, LastModifiedDate, title__c, (select id from Opportunities__r where opportunity__r.accountId = :account.id), (SELECT name, Potential_New_Business__c, Potential_New_Business__r.Name, Potential_New_Business__r.Potential_New_Business__c  FROM Potential_New_Business_Strategic_Ini__r) FROM Strategic_Initiative__c WHERE Account__C = :a.id];
        
        if(temp != null)
            globalStrategicInitiatives.addAll(temp);
   
    }

    public PageReference save() {
        //upsert growthStrategyList;
        update PotentialNewBusinessList;
        init();
        return null;        
    }
    
    public PageReference add() {
        upsert potentialNewBusiness;
        init();
        return null;        
    }
    
    public PageReference linkTrend() {        
        insert new Potential_New_Business_Trend__c(Industry_Trend__c = trendid, Potential_New_Business__c = pnbid);
        save();
        return null;
    }

    public PageReference linkIniciative() {
        insert new Potential_New_Business_Strategic_Ini__c(Strategic_Initiative__c = iniciativeid, Potential_New_Business__c = pnbid);
        save();        
        return null;
    }
    
    public PageReference linkPastProventValue() {
        insert new Potential_New_Business_Past_Provent__c(Past_Proven_Value__c = pastProventValueid, Potential_New_Business__c = pnbid);
        save();
        return null;
    }
   
    public PageReference unlinkTrend() {
        delete [SELECT id FROM Potential_New_Business_Trend__c WHERE id = :trendid];
        save();
        return null;
    }
    

    public PageReference unlinkIniciative() {
        delete [SELECT id FROM Potential_New_Business_Strategic_Ini__c WHERE id = :iniciativeid];
        save();
        return null;
    }
    
    public PageReference unlinkPastProventValue() {
        delete [SELECT id FROM Potential_New_Business_Past_Provent__c WHERE id = :pastProventValueid];
        save();
        return null;
    }
   
    public PageReference ExportToExcel() {      
        save();
        return Page.accountGrowthStrategyExcel;
    }
    
    public String getExcelName() {
        String name = account.Name + '-' + Label.GAP_Growth_Strategy + '.xls';
        return name.replaceAll(' ', '_').replaceAll(',','');
    }

    //wrappers 

    public class SolutionWrapper {
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
        
        //agregado para victor.
        public Decimal getCantidadDeRenglones(){ 
         
            Decimal renglones = 0;
            system.debug('getCantidadDeRenglones');
            
            for(SolutionWrapper sol: soluciones){
                system.debug('renglones');
            	List <Potential_New_Business_Trend__c> potencialNewBusiness = sol.trend.Potential_New_Business_Trend__r;
                
                system.debug(potencialNewBusiness.size());
                
                Decimal cantidadDePotencialBusiness = potencialNewBusiness.size();
                Decimal divisor = 2;
                Decimal renglonesDeLaSolucion = cantidadDePotencialBusiness / divisor;
                
                system.debug(renglonesDeLaSolucion);
                
                if( (math.mod(potencialNewBusiness.size(), 2) ) == 1 ){
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