global class PostInstallClass implements InstallHandler {
    
    global void onInstall(InstallContext context) {
        
        if(context.isUpgrade()){   
            List <Resource__c> recursos = [select id, puede_acceder_a_una_solicitud_capex__c, name from Resource__c
                                                      where name = 'Proceso de Aprovación de CAPEX' limit 1];
            
            if(recursos.size() > 0){
                recursos[0].puede_acceder_a_una_solicitud_capex__c = true;
                recursos[0].name = 'Proceso de Solicitud de CAPEX';
                update recursos;
            }else{
               Resource__c nuevoRecurso = new Resource__c(name = 'Proceso de Solicitud de CAPEX', puede_acceder_a_una_solicitud_capex__c = true);
                insert nuevoRecurso;
            }
        }
    }
    
}