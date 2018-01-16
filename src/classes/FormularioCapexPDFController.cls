public class FormularioCapexPDFController {
    
    public Solicitud_Capex__c solicitud{get; set;}
    public String fechaLicitacion {get; set;}
    
    public FormularioCapexPDFController(){
        Id idSol = ApexPages.currentPage().getParameters().get('id');
        
        solicitud = [select ID, Operator_or_country__c, applicant_name__c, Applicant_Position__c, Application_Date__c, 
                     Proyect_Name__c, Salesforce_code__c, Proyect_description__c, Client_Name__c, Fecha_de_Licitacion__c,
                     FCV__c, NAV__c, Total_Capex__c, Requested_Capex__c, Multiyear_Disposition__c, Capex_Import_for_this_year__c,
                     Solicitation_Concept__c, Capex_Investor_current_year__c, Capex_Investor_commited__c, Attach_Business_case__c,
                     Reviewed_by_management_control__c, approved_by_management_control__c, Description_Not_Approved__c, Aditional_information__c, OIBDA__c, TIR__C 
                     from Solicitud_Capex__c where id =: idSol ];
        
        fechaLicitacion = '';
        if(solicitud.Fecha_de_Licitacion__c != null){
           fechaLicitacion =  solicitud.Fecha_de_Licitacion__c.day() + '/' + solicitud.Fecha_de_Licitacion__c.month() + '/' + solicitud.Fecha_de_Licitacion__c.year();
        }
    }
}