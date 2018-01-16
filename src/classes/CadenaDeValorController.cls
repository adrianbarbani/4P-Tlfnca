public class CadenaDeValorController {
	
    public String idCuenta {get; set;}
    public List<Area_cadena_de_valor__c>  areasDeCadenaDeValor {get;set;}
    
    public Area_cadena_de_valor__c nuevaArea {get;set;}
    public String areaABorarId {get; set;}
    
    public CadenaDeValorController(ApexPages.StandardController controller){
        
        nuevaArea = new Area_cadena_de_valor__c();
        
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
        conseguirAreas();

        if(areasDeCadenaDeValor.size() == 0){
            areasDeCadenaDeValor = new List<Area_cadena_de_valor__c>();
        }
        
    }
    
    public void conseguirAreas(){
        areasDeCadenaDeValor = [select id, Area__c, Contacto__c, Reto__c, Solucion__c, Interes__c, Conocimiento__c 
                                from Area_cadena_de_valor__c 
                                where cuenta__c =: idCuenta ];
    }
    
    public pageReference saveChanges(){
        
        update areasDeCadenaDeValor;
        return null;
    }
    
    public void setear4ValoresPorDefaultSiNoExisteNinguno(){
        
        List<Area_cadena_de_valor__c> areasAInsertar = new List<Area_cadena_de_valor__c>();
        
        if(areasDeCadenaDeValor.size() == 0){
            Area_cadena_de_valor__c unArea = new Area_cadena_de_valor__c();
            unArea.Area__c = 'Finance';
            unArea.cuenta__c = idCuenta;
            areasAInsertar.add(unArea);
            
            unArea = new Area_cadena_de_valor__c();
            unArea.Area__c = 'Sales';
            unArea.cuenta__c = idCuenta;
            areasAInsertar.add(unArea);
            
            unArea = new Area_cadena_de_valor__c();
            unArea.Area__c = 'Marketing';
            unArea.cuenta__c = idCuenta;
            areasAInsertar.add(unArea);
            
            
            unArea = new Area_cadena_de_valor__c();
            unArea.Area__c = 'Operations';
            unArea.cuenta__c = idCuenta;
            areasAInsertar.add(unArea);
        }
        
        insert areasAInsertar;
        conseguirAreas();
    }
    
    public PageReference nuevaArea(){
        
        nuevaArea.cuenta__c = idCuenta;
		
        if(nuevaArea.Area__c != null){
            insert nuevaArea;
            nuevaArea = new Area_cadena_de_valor__c();
            conseguirAreas();
        }
            
        return null;
    }
    
    public PageReference borrarArea(){
        
        Integer i = 0;
        
        for(Area_cadena_de_valor__c area : areasDeCadenaDeValor){
            
            if(area.id == areaABorarId){
                break;
            }
            else{
                i++;
            }   
        }
        
        if(areasDeCadenaDeValor[i].id != null){
            
            delete areasDeCadenaDeValor[i];    
        }
        
        
        areasDeCadenaDeValor.remove(i);

        return null;
    }
}