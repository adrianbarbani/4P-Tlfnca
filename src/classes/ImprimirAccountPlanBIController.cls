public class ImprimirAccountPlanBIController {
	
    public String idCuenta {get;set;}
    public String url {get;set;}
    
    public ImprimirAccountPlanBIController(){
        
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
        String pais = 'Argentina';
        Set<String> objectFields = Schema.SObjectType.Account.fields.getMap().keySet();
        
        if( objectFields.contains('bi_country__c') ) {
            list<Account> cuentasTelefonica = database.query('select id, bi_country__c from account where id=:idCuenta');
            pais = '';
            
            if(cuentasTelefonica.size()>0){
                pais = (String)cuentasTelefonica[0].get('bi_country__c');
            }

        }
        
        List<Power_BI_link__c> links = [select id, link__c from Power_BI_link__c where cuenta__c =: idCuenta limit 1];
        if(links.size()>0){
            url = links[0].link__c;
        }else{
            links = [select id, link__c from Power_BI_link__c where pais__c =: pais limit 1];
            if(links.size()>0){
                url = links[0].link__c;
            }
        }
        
    }
}