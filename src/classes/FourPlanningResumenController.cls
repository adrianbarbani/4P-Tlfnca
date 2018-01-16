public class FourPlanningResumenController {

    public String idCuenta {get; set;}
    public FourPlanning__C fourPlanning {get; set;}
    
    public List<FourPlanning_Reto__c> retosArea1 {get; set;}
    public List<FourPlanning_Reto__c> retosArea2 {get; set;}
    public List<FourPlanning_Reto__c> retosArea3 {get; set;}
    
    public Boolean hayDatos {get; set;}
    public String activo {get; set;}
    
    public FourPlanningResumenController(){
    	fourPlanning = new FourPlanning__c();
        
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
        Activo = 'No';
		List<FourPlanning__c> fourPlannings = new List<FourPlanning__c>();        
        if(idCuenta != null){
            
            fourPlannings = [SELECT Id, FourPlanning_Area_1__c, FourPlanning_Area_2__c, FourPlanning_Area_3__c,
                             Titulo_Area_1__c, Titulo_Area_2__c, Titulo_Area_3__c, Nivel_de_conocimiento_area1__c, Nivel_de_conocimiento_area2__c, Nivel_de_conocimiento_area3__c,
                             conocimiento_de_la_cuenta__c, LastModifiedDate
                             FROM FourPlanning__c 
                             WHERE Cuenta__c =: idCuenta
                             LIMIT 1];
            
            if(fourPlannings.size() > 0){
                fourPlanning = fourPlannings[0];
                Activo = 'Si';
                system.debug(fourPlanning);
            }
        }
        
        retosArea1 = new List<FourPlanning_Reto__c>();
        retosArea2 = new List<FourPlanning_Reto__c>();
        retosArea3 = new List<FourPlanning_Reto__c>();
        
        if(FourPlanning.FourPlanning_Area_1__c != null){
            retosArea1 = [SELECT ID, Nombre_del_Reto__c, Contactos_del_Cliente__c, Productos_a_Desarrollar_Vender__c, Estado_de_la_solucion__c, Nivel_de_relaci_n_contacto__c, Etapa_del_Reto__c,
                          Fecha_Compromiso__c
                          FROM FourPlanning_Reto__c 
                          WHERE FourPlanning_Area__c =: FourPlanning.FourPlanning_Area_1__c];
        }
        
        system.debug(retosArea1);
        
        if(FourPlanning.FourPlanning_Area_2__c != null){
            retosArea2 = [SELECT ID, Nombre_del_Reto__c, Contactos_del_Cliente__c, Productos_a_Desarrollar_Vender__c, Estado_de_la_solucion__c, Nivel_de_relaci_n_contacto__c, Etapa_del_Reto__c,
                          Fecha_Compromiso__c
                          FROM FourPlanning_Reto__c 
                          WHERE FourPlanning_Area__c =: FourPlanning.FourPlanning_Area_2__c];
        }
        
        if(FourPlanning.FourPlanning_Area_3__c != null){    
            retosArea3 = [SELECT ID, Nombre_del_Reto__c, Contactos_del_Cliente__c, Productos_a_Desarrollar_Vender__c, Estado_de_la_solucion__c, Nivel_de_relaci_n_contacto__c, Etapa_del_Reto__c,
                          Fecha_Compromiso__c
                          FROM FourPlanning_Reto__c 
                          WHERE FourPlanning_Area__c =: FourPlanning.FourPlanning_Area_3__c];
        }
        
        hayDatos = false; 
        if(fourPlanning != null){
        	hayDatos = true;	    
        }
        
    }
}