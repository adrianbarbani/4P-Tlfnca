public class AdminPowerBiController {


    Public List<Power_BI_link__c> links {get;set;}
    Public Power_BI_link__c powerBiAInsertar {get;set;}
    public String idLinkABorrar {get; set;}
    
    public List<String> mensajesDeError {get; set;}
    
    public AdminPowerBiController(){
        mensajesDeError = new List<String>();
        powerBiAInsertar = new Power_BI_link__c();
        obtenerLinks();
    }
    
    public void obtenerLinks(){
        links = [select id, name, Cuenta__c, Link__c, Pais__c from Power_BI_link__c];
    }
    
    public void insertarLinks(){
		
        if(powerBiAInsertar.pais__c != null && powerBiAInsertar.cuenta__c != null ){
            mensajesDeError = new List<String>();
            mensajesDeError.add('Los links deben tener o pais o cuenta unicamente, no pueden tener definidos los dos parametros.');
        }
        
        if([select id from Power_BI_link__c where pais__c =: powerBiAInsertar.pais__c].size()>0){
            mensajesDeError = new List<String>();
            mensajesDeError.add('Ya existe un Link para este pais. Edite el existente o borrelo para poder crear uno nuevo.');
        }else{
            Insert powerBiAInsertar;
            obtenerLinks();
            powerBiAInsertar = new Power_BI_link__c();
            cleanErrors();
        }
        
    }
    
    public void borrarLink(){
        if(idLinkABorrar != null || idLinkABorrar != ''){
            List<Power_BI_link__c> linkABorrar = [select id from Power_BI_link__c where id =: idLinkABorrar];
            if(linkABorrar.size()>0){
                delete linkABorrar;
                obtenerLinks();
            }
        }
    }
    
    public void cleanErrors(){
        mensajesDeError = new List<String>();
    }
    
    public void guardar(){
        update links;
    }

}