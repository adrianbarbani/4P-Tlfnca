public class accountHistoricalBusinessWindow {

    public Account account { get; set; }
    public PastActivity__c thisyear {get;set;}
    public PastActivity__c lastyear {get;set;}
    public PastActivity__c last2year {get;set;}
    public Integer year {get;set;}
    
    public Boolean canEdit {get;set;}
    public PastActivity__c TempNet {get;set;}
    public Boolean multiCurrencyEnabled {get;set;}
    
    public accountHistoricalBusinessWindow(){
        if (Util.globalAccount==null) {
        	this.account = [SELECT name, id, parentId, Industry, Region__c, Region__r.Currency__c, Region__r.Currency_Name__c FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        } else {
    		this.account = Util.globalAccount; 
    	}
        
        Date today = Date.today();
        
        this.year = today.year();
        
        this.loadData();
        
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);
        multiCurrencyEnabled = Util.checkMultiCurrencyEnabled(); 
    }
    
    public void loadData(){

        List<PastActivity__c> temp = [SELECT year__c, a__c, b__c , cc__c, Share_of_Wallet__c, Net_Activity_With_Client__c, Account__C, initDate__c, endDate__c FROM PastActivity__c WHERE Account__C =:account.id];

          for(PastActivity__c pa : temp){
        
                if(pa.Year__c == year)
                    thisyear = pa;
                else if(pa.Year__c == (year-1))
                    lastyear = pa;
                else if(pa.Year__c == (year-2))
                    last2year = pa;            
        }
        
        if(thisyear==null) {
            thisyear = new PastActivity__c(a__c =0, b__c = 0, cc__c = 0, Account__c = account.id, Year__c = year); 
        }
        if(lastyear==null) {
            lastyear = new PastActivity__c(a__c =0, b__c = 0, cc__c = 0, Account__c = account.id, Year__c = (year-1));
        } 
        if(last2year==null) {
            last2year = new PastActivity__c(a__c =0, b__c = 0, cc__c = 0, Account__c = account.id, Year__c = (year-2));
        }
    }
    

    public PageReference SaveChanges() {

        if(thisyear.id == null)
            insert thisyear;
        else
            update thisyear;    
            
            
        if(lastyear.id == null)
            insert lastyear;
        else
            update lastyear;
        
        /*
        if (Util.checkMultiCurrencyEnabled()) {
            //List<PastActivity__c> pa = [SELECT Id, CurrencyIsoCode FROM PastActivity__c WHERE Id = :lastyear.Id limit 1];   
            //List<Outlok_Plan_Comercial__c> temp = [SELECT Id, Previous_Fiscal_Year_Revenue__c, CurrencyIsoCode FROM Outlok_Plan_Comercial__c WHERE Cuenta__c = :this.account.Id limit 1];   
            List<PastActivity__c> pa = Database.query('SELECT Id, CurrencyIsoCode FROM PastActivity__c WHERE Id = \'' + lastyear.Id + '\' limit 1');
            List<Outlok_Plan_Comercial__c> temp = Database.query('SELECT Id, Previous_Fiscal_Year_Revenue__c, CurrencyIsoCode FROM Outlok_Plan_Comercial__c WHERE Cuenta__c = \'' + this.account.Id + '\' limit 1');
                        
            if(!temp.isEmpty()){
                
                if(temp[0].get('CurrencyIsoCode')==pa[0].get('CurrencyIsoCode')){
                    //temp[0].Previous_Fiscal_Year_Revenue__c=lastyear.b__c;
                    temp[0].Previous_Fiscal_Year_Revenue__c=thisyear.b__c;
                }else{               
                    temp[0].Previous_Fiscal_Year_Revenue__c = Util.getCurrencyConverted(lastyear.b__c,(String) pa[0].get('CurrencyIsoCode'),(String) temp[0].get('CurrencyIsoCode'));
                }
                update temp[0];
            } 
        } else {    
            List<PastActivity__c> pa = Database.query('SELECT Id FROM PastActivity__c WHERE Id = \'' + lastyear.Id + '\' limit 1');
            List<Outlok_Plan_Comercial__c> temp = Database.query('SELECT Id, Previous_Fiscal_Year_Revenue__c FROM Outlok_Plan_Comercial__c WHERE Cuenta__c = \'' + this.account.Id + '\' limit 1');
            if(!temp.isEmpty()){
                temp[0].Previous_Fiscal_Year_Revenue__c=thisyear.b__c;
                update temp[0];
            }
        }
        */     
        if(last2year.id == null)
            insert last2year;
        else
            update last2year;
    
        loadData();
        return null;
    }
    
    public String getUserIsoCode() {
        return Util.getUserIsoCode();
    }
    
    public String getCompanyIsoCode() { 
       return Util.getCompanyIsoCode();
    } 
    
    public PageReference ExportToExcel() {
    	return Page.accountHistoricalBusinessWindowExcel;
    }
 	
 	public String getExcelName() {
    	String name = account.Name + '-' + Label.net_activity + '.xls';
    	return name.replaceAll(' ', '_').replaceAll(',','');
    }    
}