public class accountKPIWindow {

    public Account account { get; set; }
    
    public List<KPI__C> KPIs { get; set; }
    
    public List <AccountKPI__c> KPIData {get;set;}
    
    public List <ExtendedKPI> Data {get;set;}
    
    public List <ExtendedKPI> parentData {get;set;}

    public List <ExtendedKPI> localData {get;set;}
        
    public Integer year {get;set;}
    
    public Boolean canEdit {get;set;}
    
    public String delid {get;set;}
    
    private Region__c region {get;set;}
    
    public KPI__c newKPI {get;set;}
    
    public accountKPIWindow(){
        if (Util.globalAccount==null) {
        	this.account = [SELECT name, id, parentId, parent.Name, Industry, Region__c, Micro_Industry__c FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
    	} else {
    		this.account = Util.globalAccount; 
    	}
    	
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);

        init();    
    }
    
    private void init() {
    
        this.KPIs = new List<KPI__C>();

        region = Util.getRegionFromAccount(account.Id, account.region__c);
		initNewKpi();
        /*
        List<Region__c> regionsList = [SELECT Id,Name, parent__c FROM Region__c WHERE id = :this.account.region__c];
        region = null;
        if (regionsList.size()>0) {
            region = regionsList.get(0);
        } else {
            region = [SELECT Id,Name, parent__c FROM Region__c WHERE name = 'Global'];
        }
        */
        
        this.loadKPIs(region,this.account.Industry);
        
        this.KPIData = [SELECT KPI__c, Value__c, Year__c, KPI__R.Id FROM AccountKPI__c WHERE Account__c = :this.account.id];
        
        this.Data = new List<ExtendedKPI>();
        
        this.parentData = new List<ExtendedKPI>();
        
        this.localData = new List<ExtendedKPI>();
        
        Date today = Date.today();
        
        this.year = today.year();
        
        for(KPI__C k : KPIs){
            this.Data.add( new ExtendedKPI(k,this.KPIData,year,this.account.id, getRegionKPIName(k)));
        }
        
        for(KPI__C k : [SELECT Name__c,Unit__c FROM KPI__c WHERE account__c = :account.id]) {
            this.localData.add( new ExtendedKPI(k,this.KPIData,year,this.account.id, getLocalKPIName()));
        }       
        
        if (account.ParentId != null) {
            for(KPI__C k : [SELECT Name__c,Unit__c FROM KPI__c WHERE account__c = :account.ParentId]) {
                this.parentData.add( new ExtendedKPI(k,this.KPIData,year,this.account.id, getParentKPIName()));
            }
        }
        
    }
    
    private void initNewKpi() {
    	if (account.region__c == null) {
        	newKPI = new KPI__c(region__c = region.id, account__c = account.id);
        } else {
        	newKPI = new KPI__c(region__c = account.region__c, account__c = account.id);
        }
    }
    
    public void loadKPIs(Region__c region, String industry){
    
        KPIs.addAll([SELECT Name__c,Id,Name,Unit__c, region__r.Name, sub_sector__c, Industry__c FROM KPI__C WHERE Region__C = : region.Id AND sub_sector__c != null and (sub_sector__c = :account.Industry or sub_sector__c = 'All' or sub_sector__c = 'Todos') And (Industry__c = :account.Micro_Industry__c or Industry__c = 'All' or Industry__c = 'Todos')]);
        
        if(region.parent__c != null){
            Region__c parent = [SELECT Id,Name, parent__c FROM Region__c WHERE id = :region.parent__c];
            loadKPIs(parent,industry);
        }
        
    }
    
    public PageReference SaveChanges() {
        update account;

        List<AccountKPI__c> accountKPIToUpsert = new List<AccountKPI__c>();
        List<KPI__c> kpiToUpdate = new List<KPI__c>(); 
        
        for(ExtendedKPI ekpi : Data){
            accountKPIToUpsert.add(ekpi.thisyear);
            accountKPIToUpsert.add(ekpi.lastyear);
            accountKPIToUpsert.add(ekpi.last2year);        
        }
        
        for(ExtendedKPI ekpi : parentData){
            accountKPIToUpsert.add(ekpi.thisyear);
            accountKPIToUpsert.add(ekpi.lastyear);
            accountKPIToUpsert.add(ekpi.last2year);
        }
        
        for(ExtendedKPI ekpi : localData){
            accountKPIToUpsert.add(ekpi.thisyear);
            accountKPIToUpsert.add(ekpi.lastyear);
            accountKPIToUpsert.add(ekpi.last2year);
            kpiToUpdate.add(ekpi.kpi);
        }       
        
        upsert accountKPIToUpsert;
        upsert kpiToUpdate;
        
        return null;
    }
    
    public PageReference addKPI() {
        /*
        KPI__c k;
        if (account.region__c == null) {
        	k = new KPI__c(region__c = region.id, account__c = account.id, Name__c = Label.new_kpi);
        } else {
        	k = new KPI__c(region__c = account.region__c, account__c = account.id, Name__c = Label.new_kpi);
        }
        insert k;
        */
        
        insert newKPI;        
                
        AccountKPI__c a1 = new AccountKPI__c(account__c = account.id);
        AccountKPI__c a2 = new AccountKPI__c(account__c = account.id);
        AccountKPI__c a3 = new AccountKPI__c(account__c = account.id);     
        List<AccountKPI__c> accountKPIs = new List<AccountKPI__c>(); 
        
        localData.add(new ExtendedKPI(newKPI,accountKPIs,year,this.account.id, getLocalKPIName()));
        
        initNewKpi();        
        return null;
    }
    
    public PageReference deleteKPI() {

        KPI__c k = new KPI__c(id=delid);
        delete k;
        
        init();
        
        return null;
    }
    
    public String getIndustry(){
        if(account.industry != null && account.Micro_Industry__c != null)
            return account.Micro_Industry__c.replaceAll('[^a-zA-Z]', '');
        else
            return '';
    }
    
    private String getLocalKPIName() {
        return account.Name + ' (Local)';
    }
    
    private String getParentKPIName() {
        return account.Parent.Name + ' (Parent)';
    }
    
    private String getRegionKPIName(KPI__c k) {
        return 'Sector: ' + k.sub_sector__c + ' - ' + k.industry__c + ' (' + k.region__r.Name + ')';
    }
    
    public PageReference ExportToExcel() {
        return Page.accountKPIWindowExcel;
    }
    
    public String getExcelName() {
        String name = account.Name + '-' + Label.KPI + '.xls';
        return name.replaceAll(' ', '_').replaceAll(',','');
    }   
}