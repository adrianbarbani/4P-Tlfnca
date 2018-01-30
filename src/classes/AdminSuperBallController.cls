public class AdminSuperBallController {
	
    Public List<Super_Ball_Arbol__c> arboles {get;set;}
    Public Super_Ball_Arbol__c arbolAInsertar {get;set;}
    public String idArbolABorrar {get; set;}
    
    public List<String> mensajesDeError {get; set;}
    
    public AdminSuperBallController(){
        mensajesDeError = new List<String>();
        arbolAInsertar = new Super_Ball_Arbol__c();
        obtenerArboles();
    }
    
    public void obtenerArboles(){
        arboles = [select id, name, pais__c, sector__c, Link__c from Super_Ball_Arbol__c];
    }
    
    public void insertarArbol(){

        if(arbolAInsertar.sector__c == null || arbolAInsertar.pais__c == null){
			mensajesDeError = new List<String>();
			mensajesDeError.add('Debe completar los campos sector y pais.');
        }else{
            if([select id from Super_Ball_Arbol__c where pais__c =: arbolAInsertar.pais__c AND sector__c =:arbolAInsertar.sector__c].size()>0){
                mensajesDeError = new List<String>();
                mensajesDeError.add('Ya existe un arbol para este pais y region. Edite el existente o borrelo para poder crear uno nuevo.');
            }else{
                Insert arbolAInsertar;
                obtenerArboles();
                arbolAInsertar = new Super_Ball_Arbol__c();
                cleanErrors();
            }
        }
    }
    
    public void borrarArbol(){
        if(idArbolABorrar != null || idArbolABorrar != ''){
            List<Super_Ball_Arbol__c>arbolABorrar = [select id from Super_Ball_Arbol__c where id =: idArbolABorrar];
            if(arbolABorrar.size()>0){
                delete arbolABorrar;
                obtenerArboles();
            }
        }
    }
    
    public void cleanErrors(){
        mensajesDeError = new List<String>();
    }
    
    public void guardar(){
        update arboles;
    }
}