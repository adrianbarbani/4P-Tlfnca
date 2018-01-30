public class PreguntaTipoListaController {
	
    public Boolean initialized = false;
    public list<SelectOption> ValoresPickList {get;set;}
    public list<String> opciones {get;set;}
    public Super_Ball_Pregunta__c pregunta {get;set;}
    public SB_Cuenta_Pregunta__c preguntaCuenta {get;set;}
    
    public String idPregunta{ 
        get;
        set {
            idPregunta = value;
            if (!initialized) {
                Constructor();
                initialized = true;
            }
        }
    }
    
    public void constructor(){
        
        preguntaCuenta = [select id, Respuesta_libre__c, Super_Ball_Pregunta__c from SB_Cuenta_Pregunta__c where id =: idPregunta];
        pregunta = [select id, Pregunta__c, Tipo_de_pregunta__c, Opciones_picklist__c from Super_Ball_Pregunta__c where id =:preguntaCuenta.Super_Ball_Pregunta__c];
        
        
        opciones = new List<String>();
        ValoresPickList = new List<SelectOption>();
        
        if(pregunta.tipo_de_pregunta__c == 'Lista' && pregunta.Opciones_picklist__c != null){
            opciones = pregunta.Opciones_picklist__c.split(';');
        }
        
        ValoresPickList = obtenerValoresPickList();
    }
    
    public List<SelectOption> obtenerValoresPickList() {
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--Ninguno--','--Ninguno--'));
        for(String valor: opciones){
            options.add(new SelectOption(valor,valor));    
        }
        
        return options; 
    }
    
    public void guardar(){
        system.debug(preguntaCuenta.Respuesta_libre__c);
        update preguntaCuenta;
    }
    
}