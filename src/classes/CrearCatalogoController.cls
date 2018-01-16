public class CrearCatalogoController {

    Public List<catalogo__c> catalogos {get;set;}
    Public catalogo__c catalogoAInsertar {get;set;}
    public String idCatalogoABorrar {get; set;}
    
    public List<String> mensajesDeError {get; set;}
    
    public CrearCatalogoController(){
        mensajesDeError = new List<String>();
        catalogoAInsertar = new catalogo__c();
        obtenerCatalogos();
    }
    
    public void obtenerCatalogos(){
        catalogos = [select id, name, pais__c from catalogo__c];
    }
    
    public void insertarCatalogo(){

        if(catalogo__c.pais__c == null){
			mensajesDeError = new List<String>();
			mensajesDeError.add('Debe completar el campos pais.');
        }else{
            if([select id from catalogo__c where pais__c =: catalogoAInsertar.pais__c].size()>0){
                mensajesDeError = new List<String>();
                mensajesDeError.add('Ya existe un catalogo para este pais. Edite el existente o borrelo para poder crear uno nuevo.');
            }else{
                Insert catalogoAInsertar;
                obtenerCatalogos();
                catalogoAInsertar = new catalogo__c();
                cleanErrors();
            }
        }
    }
    
    public void borrarCatalogo(){
        if(idCatalogoABorrar != null || idCatalogoABorrar != ''){
            List<catalogo__c> catalogoABorrar = [select id from catalogo__c where id =: idCatalogoABorrar];
            if(catalogoABorrar.size()>0){
                delete catalogoABorrar;
                obtenerCatalogos();
            }
        }
    }
    
    public void cleanErrors(){
        mensajesDeError = new List<String>();
    }
    
    public void guardar(){
        update catalogos;
    }
}