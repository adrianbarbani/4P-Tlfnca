public class pruebaController {

    public String idCuenta {get; set;}

    public FourPlanning__c fourPlanning {get; set;}
    
    public List<FourPlanning_Reto__c> retosAreas {get; set;}
    
    public Boolean mostrar {get; set;}
    public Boolean hayDatos {get; set;}
    
    public map<Id, List<FourPlanning_Reto__c>> areasYSusRetos {get; set;}
    
    public pruebaController(){
        
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
		areasYSusRetos = new Map<Id, List<FourPlanning_Reto__c>>();        
        fourPlanning = new FourPlanning__c();
        
        List<FourPlanning__c> fourPlannings = new List<FourPlanning__c>();
        
        if(idCuenta != null){
            
            fourPlannings = [SELECT Id,
                             (select id, Conocimiento_del_Area__c, Numero_de_Area__c, Titulo_Area__c from FourPlanning_Areas__r)
                             FROM FourPlanning__c 
                             WHERE Cuenta__c =: idCuenta
                             LIMIT 1];
            
            if(fourPlannings.size() > 0){
                fourPlanning = fourPlannings[0];
                system.debug(fourPlanning);
            }
            
        }
        
        mostrar = false;
        if(idCuenta != null){
            mostrar = true;
        }
        
        
        retosAreas = new List<FourPlanning_Reto__c>();
        
        List<Id> areasId = new List<Id>();
        for(FourPlanning_Area__c area: fourPlanning.FourPlanning_Areas__r){
            areasId.add(area.id);
        }
        
        retosAreas = [SELECT ID, Nombre_del_Reto__c, Etapa_del_Reto__c, FourPlanning_Area__c,
                      (select id, Reto__c, Lista_de_Soluciones__c, Nivel_de_Desarrollo__c, Observaci_n_sobre_el_producto__c, Otra_Solucion__c from FourPlanning_Soluciones__r),
                      (select id, Nivel_de_Relaci_n__c, Reto__c, Otro_contacto_del_cliente__c, Tipo_de_Contacto__c from FourPlanning_Contactos__r)
                      FROM FourPlanning_Reto__c 
                      WHERE FourPlanning_Area__c IN: areasId];
        

        hayDatos = false;
        if(retosAreas.size()>0){
            hayDatos = true;
        }
        
        for(FourPlanning_Reto__c reto: retosAreas){
            
        }
       
    }

}