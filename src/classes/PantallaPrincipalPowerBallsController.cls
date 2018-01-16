public class PantallaPrincipalPowerBallsController {
	
    Public Boolean mostrar {get;set;}
    Public String idCuenta {get;set;}
    Public Account cuenta {get;set;}
    
    Public Super_Ball_Arbol__c arbol {get;set;}
    
    public Boolean hayError{get;set;}
    
    public List<Super_Ball_Nodo__c> nodos {get;set;}
    
    public PantallaPrincipalPowerBallsController(){
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
        hayError = false;
        nodos = new List<Super_Ball_Nodo__c>();
        
        mostrar = false;
        if(idCuenta!= null){
            mostrar = true;
            cuenta = [select id, name, Industry, Micro_Industry__c, Region__r.name from account where id =: idCuenta];
            system.debug(cuenta);
            traerArbol();
        }
        
    }
    
    public void traerArbol(){
        List<Super_Ball_Arbol__c> arboles = [select id, name, descripcion__c
                                             from Super_Ball_Arbol__c 
                                             where Pais__c =: cuenta.region__r.name and Sector__c =: cuenta.Micro_Industry__c];
        
        Set<String> objectFields = Schema.SObjectType.Account.fields.getMap().keySet();        
        if( objectFields.contains('bi_country__c') ) {
            list<Account> cuentasTelefonica = database.query('select id, bi_country__c, bi_sector_global__c from account where id=:idCuenta');
            String pais = '';
            String sector = '';
            
            if(cuentasTelefonica.size()>0){
                pais = (String)cuentasTelefonica[0].get('bi_country__c');
                sector = (String)cuentasTelefonica[0].get('bi_sector_global__c');
            }
            
            arboles = [select id, name, descripcion__c
                       from Super_Ball_Arbol__c 
                       where Pais__c =: pais and Sector__c =: sector];
        }
		
        if(arboles.size()>0){
            arbol = arboles[0];
        }else{
            arbol = new Super_Ball_Arbol__c();
            hayError = true;
        }
        

        nodos = [select id, descripci_n__c, name, posicion__c,  
                 (select id, Nodo_Padre__c, name, posicion__c from Super_Ball_Nodos__r order by posicion__c asc) 
                 from Super_Ball_Nodo__c 
                 where nodo_padre__c = null and Super_Ball_Arbol__c =: arbol.id
                 ORDER BY posicion__c asc];
    }
    
}