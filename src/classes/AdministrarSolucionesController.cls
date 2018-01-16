public class AdministrarSolucionesController {
    
    
    public List<Linea_de_Servicio__c> lineasDeServicios {get; set;}
    
    public List<SolucionEnCuenta__c> soluciones {get; set;}
    
    public Linea_de_Servicio__c lineaDeServicioAInsertar {get; set;}
    
    public Id lineaABorrarId {get; set;}
    
    public Id solucionABorrarId {get; set;}
    
    public Id lineaPadreDeLaSolucionAInsertar {get; set;}
    
    public Solucion__c solucionAInsertar {get;set;}
    public String idCatalogo {get;set;}
    
    
    public AdministrarSolucionesController(){
        
        idCatalogo = ApexPages.currentPage().getParameters().get('Id');
        
        lineasDeServicios = new List<Linea_de_Servicio__c>();
        
        obtenerLineasDeServicio();
        
    }
    
    public void guardar(){
        system.debug('guardar');
        
        if(lineasDeServicios.size()>0){
            update lineasDeServicios;
        }
    }
    
    public void obtenerLineasDeServicio (){
        
        lineaDeServicioAInsertar = new Linea_de_Servicio__c();
        
        solucionAInsertar = new Solucion__c();
        
        
        lineasDeServicios = [select id, name,
                             (select id, name from Soluciones__r)
                             from Linea_de_Servicio__c
                             where catalogo__c =: idCatalogo
                             ORDER BY createdDate DESC LIMIT 900];
        
        
        
    }
    
    
    public void InsertarLineaDeServicio(){
        
        lineaDeServicioAInsertar.catalogo__c = idCatalogo;
        insert lineaDeServicioAInsertar;
        
        
        obtenerLineasDeServicio();
    }
    
    
    public void InsertarSolucion(){
        
        
        solucionAInsertar.Linea_de_Servicio__c = lineaPadreDeLaSolucionAInsertar;
        
        
        insert solucionAInsertar;
        
        
        obtenerLineasDeServicio();
    }
    
    
    public PageReference borrarLineaDeServicio(){
        
        Integer i = 0;
        
        for(Linea_de_Servicio__c lineaDeServicio : lineasDeServicios){
            
            if(lineaDeServicio.id == lineaABorrarId){
                break;
            }
            else{
                i++;
            }   
        }
        
        if(lineasDeServicios[i].id != null){
            
            delete lineasDeServicios[i];
            
        }
        
        
        lineasDeServicios.remove(i);        
        obtenerLineasDeServicio();
        return null;
    }
    
    
    public PageReference borrarSolucion(){
        
        Solucion__c aBorrar = new Solucion__c();
        //soluciones = [select id, tipoSolucion__c from SolucionEnCuenta__c where tipoSolucion__c=:solucionABorrarId];
        aBorrar = [select id, name from Solucion__c
                   where id =: solucionABorrarId];
        
       // delete soluciones;
        
        delete aBorrar;
        
        
        obtenerLineasDeServicio();
        return null;
        
    }
    
    
}