public class EditarArbolController {
    
    Public String idArbol {get;set;}
    Public List<WppRamas> ramas {get;set;}
    Public Super_Ball_Nodo__c nodoCentral {get;set;}
    Public Super_Ball_Nodo__c nodoHijo {get;set;}
    Public Boolean render {get;set;}
    
    Public String idNodoPadre {get;set;}
    Public String idNodoABorrar {get;set;}
    Public String idPreguntaABorrar {get;set;}
    Public String idSolucionABorrar {get;set;}
    Public String idContactoABorrar {get;set;}
    Public String idRecursoABorrar {get;set;}
    Public String idPreguntaPadre {get;set;}
    
    Public Super_Ball_Arbol__c arbol {get;set;}
    Public Super_Ball_Pregunta__c preguntaAInsertar {get;set;}
    Public Super_Ball_Pregunta__c preguntaAInsertarSi {get;set;}
    Public Super_Ball_Pregunta__c preguntaAInsertarNo {get;set;}
    Public Super_Ball_Solucion__c solucionAInsertar {get; set;}
    Public Super_Ball_Interlocutor__c contactoAInsertar {get;set;}
    Public Super_Ball_Recurso__c recursoAInsertar {get;set;}	
    
    public EditarArbolController(){
        idArbol = ApexPages.currentPage().getParameters().get('Id');
        
        render = false;
        if(idArbol != null && idArbol != ''){
            render = true;
            arbol = [select id, name, pais__c, sector__c from Super_Ball_Arbol__c where id =: idArbol];
        }
        
        nodoCentral = new Super_Ball_Nodo__c();
        nodoHijo = new Super_Ball_Nodo__c();
        preguntaAInsertar = new Super_Ball_Pregunta__c();
        preguntaAInsertarSi = new Super_Ball_Pregunta__c();
        preguntaAInsertarNo = new Super_Ball_Pregunta__c();
        solucionAInsertar = new Super_Ball_Solucion__c();
        contactoAInsertar = new Super_Ball_Interlocutor__c();
        recursoAInsertar = new Super_Ball_Recurso__c();
        traerRamas();
    }
    
    public void traerRamas(){
        ramas = new List<WppRamas>();
        //Me traigo todos los nodos centrales.
        List<Super_Ball_Nodo__c> nodosCentrales = [select id, name, Descripci_n__c, posicion__c 
                                                   from Super_Ball_Nodo__c 
                                                   where Nodo_Padre__c = null and Super_Ball_Arbol__c =: idArbol order by createdDate asc];
        
        Set<Id> idNodosCentrales = new Set<Id>();
        for(Super_Ball_Nodo__c nodo: nodosCentrales){
            idNodosCentrales.add(nodo.id);
            ramas.add(new WppRamas(nodo));
        }
        
        if(idNodosCentrales.size()>0){
            //Me traigo los hijos y los hijos de los hijos.
            List<Super_Ball_Nodo__c> hijosDeNodos = [select id, Nodo_Padre__c, name, Descripci_n__c, posicion__c,
                                                     (select id, name, Descripci_n__c from Super_Ball_Nodos__r),
                                                     (select id, Tipo_de_pregunta__c, Opciones_picklist__c, Pregunta__c, posicion__c, Dependencia_Si__c, Dependencia_No__c,  Dependencia_Si__r.pregunta__c, Dependencia_No__r.pregunta__c 
                                                      from Super_Ball_Preguntas__r 
                                                      where esHija__c != true order by createdDate asc),
                                                     (select id, name, posicion__c from Super_Ball_Soluciones__r order by createdDate asc),
                                                     (select id, name, contacto__c from Super_Ball_Interlocutores__r order by createdDate asc),
                                                     (select id, name, link__c, posici_n__c from Super_Ball_Recursos__r order by createdDate asc)
                                                     from Super_Ball_Nodo__c 
                                                     where Nodo_Padre__c in: idNodosCentrales
                                                     order by createdDate asc];
            
            for(Super_Ball_Nodo__c nodoHijo: hijosDeNodos){
                for(WppRamas rama: ramas){
                    if(rama.nodo.id == nodoHijo.Nodo_Padre__c){
                        rama.nodosHijos.add(new WppRamas(nodoHijo, nodoHijo.Super_Ball_Nodos__r));
                    }
                }
            }
        }
    }
    
    public void InsertarNodoCentral(){
        nodoCentral.Super_Ball_Arbol__c = idArbol;
        nodoCentral.posicion__c = 0;
        nodoCentral.name=parsearString(nodoCentral.name);
        insert nodoCentral;
        nodoCentral = new Super_Ball_Nodo__c(); 
        traerRamas();
    }
    
    public String parsearString(String name){
        String parseado;
        if (name.contains('-')){
            parseado=name.replace('-', ' - ');
        } else {
            parseado=name;
        }
        if (name.contains('/')){
            parseado=name.replace('/', ' / ');
        } 
        return parseado;
    }
    
    public void InsertarNodoHijo(){
        
        if(idNodoPadre != null && idNodoPadre != ''){
            
            nodoHijo.Nodo_Padre__c = idNodoPadre;
            nodoHijo.posicion__c = 0;
            nodoHijo.Super_Ball_Arbol__c = idArbol;
            nodoHijo.name=parsearString(nodoHijo.name);
            insert nodoHijo;
            
            nodoHijo = new Super_Ball_Nodo__c();
            idNodoPadre = '';
            
            traerRamas();
        }
    }
    
    public void borrarNodo(){
        List<String> nodos = new List<String> ();
        nodos.add(idNodoABorrar);
        
        borrarHijos(nodos);
        
        delete [select id from Super_Ball_Nodo__c where id =: idNodoABorrar];
        idNodoABorrar = '';
        
        traerRamas();
    }
    
    public void borrarHijos(List<String> idNodos){
        List<Super_Ball_Nodo__c> nodos = [select id from Super_Ball_Nodo__c where Nodo_Padre__c In: idNodos];
        
        List<String> idHijosNodos = new List<String>();
        for(Super_Ball_Nodo__c nodo: nodos){
            idHijosNodos.add(nodo.id);    
        }
        
        if(nodos.size()>0){
            borrarHijos(idHijosNodos);
            delete nodos;
        }
    }
    
    public void insertarPregunta(){
        
        if(idNodoPadre != null && idNodoPadre != ''){
            
            preguntaAInsertar.Super_Ball_Nodo__c = idNodoPadre;
            preguntaAInsertar.posicion__c = 0;
            
            insert preguntaAInsertar;
            
            preguntaAInsertar = new Super_Ball_Pregunta__c();
            idNodoPadre = '';
            
            traerRamas();
        }
    }
    
    public void borrarPregunta(){
        delete [select id from Super_Ball_Pregunta__c where id =: idPreguntaABorrar];
        idPreguntaABorrar = '';
        
        traerRamas();
    }
    
    public void insertarSolucion(){
        
        if(idNodoPadre != null && idNodoPadre != ''){
            
            solucionAInsertar.Super_Ball_Nodo__c = idNodoPadre;
            solucionAInsertar.name=parsearString(solucionAInsertar.name);
            solucionAInsertar.posicion__c = 0;
            
            insert solucionAInsertar;
            
            solucionAInsertar = new Super_Ball_Solucion__c();
            idNodoPadre = '';
            
            traerRamas();
        }
    }
    
    public void borrarSolucion(){
        delete [select id from Super_Ball_Solucion__c where id =: idSolucionABorrar];
        idSolucionABorrar = '';
        
        traerRamas();
    }
    
    public void insertarContacto(){
        
        if(idNodoPadre != null && idNodoPadre != ''){
            
            contactoAInsertar.Super_Ball_Nodo__c = idNodoPadre;
            
            insert contactoAInsertar;
            
            contactoAInsertar = new Super_Ball_Interlocutor__c();
            idNodoPadre = '';
            
            traerRamas();
        }
    }
    
    public void borrarContacto(){
        delete [select id from Super_Ball_Interlocutor__c where id =: idContactoABorrar];
        idContactoABorrar = '';
        
        traerRamas();
    }
    
    public void insertarRecurso(){
        
        if(idNodoPadre != null && idNodoPadre != ''){
            
            recursoAInsertar.Super_Ball_Nodo__c = idNodoPadre;
            
            insert recursoAInsertar;
            
            recursoAInsertar = new Super_Ball_Recurso__c();
            idNodoPadre = '';
            
            traerRamas();
        }
    }
    
    public void borrarRecurso(){
        delete [select id from Super_Ball_Recurso__c where id =: idRecursoABorrar];
        idRecursoABorrar = '';
        
        traerRamas();
    }
    
    public void insertarPreguntaSi(){
        
        if(idNodoPadre != null && idNodoPadre != ''){
            
            preguntaAInsertarSi.Super_Ball_Nodo__c = idNodoPadre;
            preguntaAInsertarSi.esHija__c = true;
            insert preguntaAInsertarSi;
            
            system.debug(preguntaAInsertarSi);
            
            Super_Ball_Pregunta__c preguntaPadre = [select id, dependencia_si__c from Super_Ball_Pregunta__c where id=:idPreguntaPadre];
            preguntaPadre.dependencia_si__c = preguntaAInsertarSi.id;
            
            update preguntaPadre;
            
            preguntaAInsertarSi = new Super_Ball_Pregunta__c();
            idNodoPadre = '';
            idPreguntaPadre = '';
            
            traerRamas(); 
        }
        
        
    }
    
    public void insertarPreguntaNo(){
        
        if(idNodoPadre != null && idNodoPadre != ''){
            
            preguntaAInsertarNo.Super_Ball_Nodo__c = idNodoPadre;
            preguntaAInsertarNo.esHija__c = true;
            insert preguntaAInsertarNo;
            
            system.debug(preguntaAInsertarNo);
            
            Super_Ball_Pregunta__c preguntaPadre = [select id, dependencia_no__c from Super_Ball_Pregunta__c where id=:idPreguntaPadre];
            preguntaPadre.dependencia_no__c = preguntaAInsertarNo.id;
            
            update preguntaPadre;
            
            preguntaAInsertarNo = new Super_Ball_Pregunta__c();
            idNodoPadre = '';
            idPreguntaPadre = '';
            
            traerRamas(); 
        }
        
        
    }
    
    public PageReference irAAdminPowerBall() {    
        String url = Page.AdminSuperBall.getURL();
        return new PageReference (url);
    }
    
    public void guardar(){
        List<Super_Ball_Nodo__c> nodosAGuardar = new List<Super_Ball_Nodo__c>();
        List<Super_Ball_Nodo__c> nodosHijosAGuardar = new List<Super_Ball_Nodo__c>();
        
        for(WppRamas rama: ramas){
            nodosAGuardar.add(rama.nodo);
            if(rama.nodosHijos != null ){
                for(WppRamas ramaHija: rama.nodosHijos){
                    nodosHijosAGuardar.add(ramaHija.nodo);
                }
            }
        }
        
        List<Super_Ball_Pregunta__c> preguntasAGuardar = new List<Super_Ball_Pregunta__c>();
        for(Super_Ball_Nodo__c nodoHijo: nodosHijosAGuardar){
            preguntasAGuardar.addAll(nodoHijo.Super_Ball_Preguntas__r);
        }
        List<Super_Ball_Pregunta__c> preguntasSiAGuardar = new List<Super_Ball_Pregunta__c>();
        List<Super_Ball_Pregunta__c> preguntasNoAGuardar = new List<Super_Ball_Pregunta__c>();
        for(Super_Ball_Pregunta__c pregunta: preguntasAGuardar){
            if(pregunta.dependencia_si__c != null){
                Super_Ball_Pregunta__c nuevaPregunta = new Super_Ball_Pregunta__c();
                nuevaPregunta.id = pregunta.dependencia_si__c;
                nuevaPregunta.pregunta__c = pregunta.dependencia_si__r.pregunta__c;
                preguntasSiAGuardar.add(nuevaPregunta);
            }
            if(pregunta.dependencia_no__c != null){
                Super_Ball_Pregunta__c nuevaPregunta = new Super_Ball_Pregunta__c();
                nuevaPregunta.id = pregunta.dependencia_no__c;
                nuevaPregunta.pregunta__c = pregunta.dependencia_no__r.pregunta__c;
                preguntasNoAGuardar.add(nuevaPregunta);
            }
        }
        preguntasAGuardar.addAll(preguntasSiAGuardar);
        preguntasAGuardar.addAll(preguntasNoAGuardar);
        
        List<Super_Ball_Solucion__c> solucionAGuardar = new List<Super_Ball_Solucion__c>();
        for(Super_Ball_Nodo__c nodoHijo: nodosHijosAGuardar){
            solucionAGuardar.addAll(nodoHijo.Super_Ball_Soluciones__r);
        } 
        
        List<Super_Ball_Interlocutor__c> interlocutoresAGuardar = new List<Super_Ball_Interlocutor__c>();
        for(Super_Ball_Nodo__c nodoHijo: nodosHijosAGuardar){
            interlocutoresAGuardar.addAll(nodoHijo.Super_Ball_Interlocutores__r);
        }    
        
        List<Super_Ball_Recurso__c> recursosAGuardar = new List<Super_Ball_Recurso__c>();
        for(Super_Ball_Nodo__c nodoHijo: nodosHijosAGuardar){
            recursosAGuardar.addAll(nodoHijo.Super_Ball_Recursos__r);
        }    
        
        
        update nodosAGuardar;
        update nodosHijosAGuardar;
        update preguntasAGuardar;
        update solucionAGuardar;
        update interlocutoresAGuardar;
        update recursosAGuardar;
    }
    //===========================================================================
    Public Class WppRamas{
        
        public Super_Ball_Nodo__c nodo {get;set;}
        public List<WppRamas> nodosHijos {get;set;}
        
        public WppRamas (Super_Ball_Nodo__c padre){
            nodo = padre;
            nodosHijos = new List<WppRamas>();
        }
        
        public WppRamas (Super_Ball_Nodo__c padre, list<WppRamas> hijos){
            nodo = padre;
            nodosHijos = new List<WppRamas>();
            if(hijos != null){
                nodosHijos = hijos;
            }
        }
        
        public WppRamas (Super_Ball_Nodo__c padre, list<Super_Ball_Nodo__c> hijos){
            nodo = padre;
            nodosHijos = new List<WppRamas>();
            for(Super_Ball_Nodo__c hijo: hijos){
                nodosHijos.add(new WppRamas(hijo));
            }
        }
        
    }
    
}