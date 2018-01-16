public class externalPDFController {
		
    public Solicitud_Capex__c solicitud{get; set;}
    
    public externalPDFController(){
        Id idSol = ApexPages.currentPage().getParameters().get('id');
        solicitud = [select Operator_or_country__c, applicant_name__c 
                     from Solicitud_Capex__c where id =: idSol ];
    }
    

    
}