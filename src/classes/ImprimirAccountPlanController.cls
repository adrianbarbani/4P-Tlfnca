public class ImprimirAccountPlanController {
    
    public Account account {get;set;}
    public Boolean canEdit {get;set;}
    public CustomReport__c customReport {get;set;}
    
    public ImprimirAccountPlanController() {        
        account = [SELECT name, id, parentId, Industry, Region__c, Sector__C, Micro_Industry__c, Strategic_Context__c, 
                   Strategic_Context_Last_Update__c, Buying_Criteria__c, parent.Name, Region__r.Currency__c, Region__r.Currency_Name__c, 
                   (select name, Potential_New_Business__c, Potential_New_Business__r.Name from Potential_New_Business_Strategic_Cnt__r) 
                   FROM Account 
                   WHERE Id = :ApexPages.currentPage().getParameters().get('Id')]; 
        
        Util.globalAccount = account;
        userActions temp = new userActions();
        canEdit = temp.checkWrite(this.account);
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, Label.Custom_Report_Msg));                
        init();        
    }
    
    private void init() {
        List<CustomReport__c> customReportList = [select id, account__c,  
                                                  influenceMap__c, Descripcion_Cliente__c, Conocimiento_Negocio__c, Relacion_Institucional__c, Contacto_Ejecutivo__c, Hitos__c from CustomReport__c 
                                                  where account__c = :account.id];   
        if (customReportList.size() > 0) {
            customReport = customReportList.get(0);
        } else {
            customReport = new CustomReport__c(account__c = account.id);
        }
    }
    
    public PageReference save() {
        upsert customReport;
        init();
        return null;        
    }
    
    public PageReference ExportToWord() {      
        save();
        return Page.ImprimirAccountPlanWord;
    }
    
    public String getWordName() {
        String name = account.Name + '-' + 'Account-Plan' + '.doc';
        return name.replaceAll(' ', '_').replaceAll(',','');
    }

}