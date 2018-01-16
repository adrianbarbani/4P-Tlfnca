public class administracionHitosGlobalesController {

    public List<FourPlanning_Hito_global__c> hitosGlobales {get; set;}
    
    public FourPlanning_Hito_global__c hitoGlobalAInsertar {get; set;}
    
    public String idABorrar {get; set;}
    
    public administracionHitosGlobalesController(){
        
        hitoGlobalAInsertar = new FourPlanning_Hito_global__c();
        
        obtenerHitosGlobales();
        
    }
    
    public void obtenerHitosGlobales(){
        hitosGlobales = [select id, Categoria__c, Descripcion__c, Fecha__c, Region__c, Sector__c, Sub_sector__c 
                         from FourPlanning_Hito_global__c];
    }
    
    public PageReference InsertarHitoGlobal(){
        
        if(hitoGlobalAInsertar.descripcion__c != null && hitoGlobalAInsertar.Sector__c != null){
            
            if(hitoGlobalAInsertar.Categoria__c == 'Otro' && hitoGlobalAInsertar.Name != null ){
            hitoGlobalAInsertar.Categoria__c = hitoGlobalAInsertar.Name;}
            
            
            
            insert hitoGlobalAInsertar;
            hitoGlobalAInsertar = new FourPlanning_Hito_global__c();
            obtenerHitosGlobales();
        }
        
        return null;
    }
    
    public void renderizarPagina(){
        //lo utilizo para renderizar la pagina al comienzo para que no se genere el #text entre el titulo y el contenido del pageblock section. twisty    
    }
    
    public PageReference borrarEvento(){
        
        Integer i = 0;
        
        for(FourPlanning_Hito_global__c hito : hitosGlobales){
            
            if(hito.id == idABorrar){
                break;
            }
            else{
                i++;
            }   
        }
        
        if(hitosGlobales[i].id != null){            
            delete hitosGlobales[i];    
        }
        
        hitosGlobales.remove(i);        
        
        return null;
    }
    
    
}