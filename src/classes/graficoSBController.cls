public class graficoSBController {

    Public String idCuenta {get;set;}
    Public String idNodoPadre {get;set;}
    Public Account cuenta {get;set;}
    
    Public Super_Ball_Arbol__c arbol {get;set;}
    Public List<Super_Ball_Nodo__c> nodosHijos {get;set;}
    
    Public List<nodo> todosLosNodos {get;set;}
    Public List<edge> todosLosEdjes {get;set;}
    
    Public String nodosJson {get;set;}
    Public String edgesJson {get;set;}
    
    public graficoSBController(){
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
		idNodoPadre = ApexPages.currentPage().getParameters().get('IdNodo');
        
        nodosHijos = new List<Super_Ball_Nodo__c>();
        todosLosNodos = new List<nodo>();
        todosLosEdjes = new List<edge>();
            
        if(idCuenta!= null){
            cuenta = [select id, name, Industry, Micro_Industry__c, Region__r.name from account where id =: idCuenta];
            traerArbol();
        }
        
    }
    
    public void traerArbol(){
		
        List<Super_Ball_Arbol__c> arboles = new List<Super_Ball_Arbol__c>();
        Set<String> objectFields = Schema.SObjectType.Account.fields.getMap().keySet();        
        if( objectFields.contains('bi_country__c') ) {
            
            list<Account> cuentasTelefonica = database.query('select id, bi_country__c, bi_sector_global__c from account where id=:idCuenta');
            String pais = '';
            String sector = '';
            
            if(cuentasTelefonica.size()>0){
                pais = (String)cuentasTelefonica[0].get('bi_country__c');
                sector = (String)cuentasTelefonica[0].get('bi_sector_global__c');
            }
            
            arboles = [select id, name, descripcion__c, Sector__c, (select id, Descripci_n__c, name from Super_Ball_Nodos__r where nodo_padre__c = null)
                       from Super_Ball_Arbol__c 
                       where Pais__c =: pais and Sector__c =: sector];
        }else{
            
            arboles = [select id, name, descripcion__c, Sector__c, (select id, Descripci_n__c, name from Super_Ball_Nodos__r where nodo_padre__c = null) 
                       from Super_Ball_Arbol__c 
                       where Pais__c =: cuenta.region__r.name and Sector__c =: cuenta.Micro_Industry__c];
        }
        
        if(arboles.size()>0){
            arbol = arboles[0];
        }else{
            arbol = new Super_Ball_Arbol__c();
        }
        
        NodosHijos = [select id, name, nodo_padre__c, (select id, name, Super_Ball_Nodo__c, estado__c, Super_Ball_Solucion__c from SB_Cuenta_Soluciones__r)
                      from Super_Ball_Nodo__c where nodo_padre__c In: arbol.Super_Ball_Nodos__r];
        
        crearNodos();
    }
    
    public void crearNodos(){
        
      crearNodosCentrales();
	  crearSubNodosYEdjes();
      crearEdjesCentrales();
      crearJson();
    }
    
    public void crearNodosCentrales(){
        
        NodoColor colorNodoCentral = new NodoColor();
        colorNodoCentral.background ='#004250';
        colorNodoCentral.border = 'grey';
        
        NodoWidth widthNodoCentral = new NodoWidth();
        widthNodoCentral.maximum = 90;
        widthNodoCentral.minimum = 90;
        
        for(Super_Ball_Nodo__c nodoCentral: arbol.Super_Ball_Nodos__r){
            Nodo nodojs = new Nodo();
            nodojs.id = nodoCentral.id;
            nodojs.label = nodoCentral.name;
            nodojs.color = colorNodoCentral;
            nodojs.shape = 'circle';
            nodojs.widthConstraint = widthNodoCentral;
            nodojs.font = '12px arial white';
            
            todosLosNodos.add(nodojs);
        }
    }
    
    public void crearSubNodosYEdjes(){
        
        system.debug(nodosHijos.size());
        for(Super_Ball_Nodo__c nodoHijo: nodosHijos){
            
            //Creo Edjes
            
            Edge edjeNodo = new Edge();
            edjeNodo.from_x = nodoHijo.nodo_padre__c;
            edjeNodo.to = nodoHijo.id;
            edjeNodo.length = 100;
            
            todosLosEdjes.add(edjeNodo);
            
            //Creo Nodos
            NodoColor color = new NodoColor();
            color.background ='#1696bf';
            color.border = 'grey';
			
            NodoWidth width = new NodoWidth();
            width.maximum = 90;
            width.minimum = 90;
			            
            Nodo nodojs = new Nodo();
            nodojs.id = nodoHijo.id;
            nodojs.label = nodoHijo.name;
            nodojs.color = color;
            nodojs.shape = 'circle';
            nodojs.widthConstraint = width;
            nodojs.font = '10px arial white';
            
            system.debug(nodojs);
            
            todosLosNodos.add(nodojs);
            
            for(SB_Cuenta_Solucion__c solucion: nodoHijo.SB_Cuenta_Soluciones__r){
                NodoColor colorSolucion = new NodoColor();
                colorSolucion.background ='black';
                colorSolucion.border = 'black';
                
                if(solucion.estado__c == 'Oportunidades Ganadas'){colorSolucion.background = '#337ab7';}
                if(solucion.estado__c == 'Oportunidades en Funnel'){colorSolucion.background = 'green';}
                if(solucion.estado__c == 'Lineas de trabajo Priorizadas'){colorSolucion.background = '#ddd301';}
                if(solucion.estado__c == 'Lineas a Explorar'){colorSolucion.background = 'orange';}
                if(solucion.estado__c == 'Lineas que no Aplican en el Cliente'){colorSolucion.background = 'grey';}
                

                Nodo nodoSolucionjs = new Nodo();
                nodoSolucionjs.id = solucion.id;
                nodoSolucionjs.label = solucion.name;
                nodoSolucionjs.color = colorSolucion;
                nodoSolucionjs.shape = 'box';
                nodoSolucionjs.widthConstraint = width;
                nodoSolucionjs.font = '10px arial white';
                
                todosLosNodos.add(nodoSolucionjs);
                
                //creo edjes
                
                Edge edjeSolucion = new Edge();
                edjeSolucion.from_x = solucion.Super_Ball_Nodo__c;
                edjeSolucion.to = solucion.id;
                edjeSolucion.length = 90;
                
                todosLosEdjes.add(edjeSolucion);
                
            }
        }
    }
    
    public void crearEdjesCentrales(){

        
        String nombreRecurso = arbol.Sector__c.replace(' ','');
        
        List<StaticResource> resourceList = [
            SELECT Name, NamespacePrefix, SystemModStamp 
            FROM StaticResource 
            WHERE Name =:nombreRecurso 
        ];
        
        String LinkImagen = '';
        if(resourceList.size()>0){
            LinkImagen = '/resource/'+resourceList[0].SystemModStamp.getTime()+'/certa_scp__'+nombreRecurso;
        }
        
        NodoColor colorNodoOrigen = new NodoColor();
        //colorNodoOrigen.background ='#004250';
        colorNodoOrigen.border = 'grey';
        
        NodoWidth widthNodoOrigen = new NodoWidth();
        widthNodoOrigen.maximum = 500;
        widthNodoOrigen.minimum = 140;
        
        Nodo origen = new Nodo();
        origen.id = 'origen';
        origen.label = arbol.Sector__c;
        origen.color = colorNodoOrigen;
        origen.shape = 'image';
        origen.widthConstraint = widthNodoOrigen;
        origen.font = '14px arial black';
        origen.image = LinkImagen;
        origen.size = 80;
        
        todosLosNodos.add(origen);
        
        for(Integer i = 0; i<arbol.Super_Ball_Nodos__r.size(); i++){
            
            Edge edjeCentral = new Edge();
            edjeCentral.from_x = 'origen';
            edjeCentral.to = arbol.Super_Ball_Nodos__r[i].id;
            edjeCentral.length = 250;
            
            todosLosEdjes.add(edjeCentral);
        }
    }
	
    public void crearJson(){
        nodosJson = JSON.serialize(todosLosNodos);
        edgesJson = JSON.serialize(todosLosEdjes);
        
        edgesJson = edgesJson.replace('from_x', 'from');
        
        system.debug(JSON.serialize(todosLosNodos));
        system.debug(edgesJson);
    }
    
    public PageReference irACuestionario(){
        
        String url = Page.CuestionarioNodos.getURL();
        return new PageReference (url + '?id=' + idCuenta+'&idNodo='+IdNodoPadre);
    }
    
    public PageReference pantallaCompleta(){
        
        String url = Page.graficoFullScreen.getURL();
        return new PageReference (url + '?id=' + idCuenta+'&idNodo='+IdNodoPadre);
    }
    
    public PageReference volverDePantallaCompleta(){
        
        String url = Page.pruebaVis.getURL();
        return new PageReference (url + '?id=' + idCuenta+'&idNodo='+IdNodoPadre);
    }
//=======================================================
    
    public class nodo{
        
        public String id {get;set;}
        public String label {get;set;}
        public NodoColor color {get;set;}
        public String shape {get;set;}
        public NodoWidth widthConstraint {get; set;}
        public String font {get;set;}
        public String image {get;set;}
        public Integer size {get;set;}
        
    }
    
    public class NodoColor{
        
        public String background {get;set;}
        public String border {get;set;}
    }
    
    public class NodoWidth{
        
        public Integer maximum {get;set;}
        public Integer minimum {get;set;}
    }
    
    public class edge{
        //La variable se llama from en el json, pero es una palabra resevada en apex, por lo tanto despues de realizar el json, 
        //aplico un metodo sobre el string para reemplazar "from_x" por "from"
        public String from_x {get;set;}
        public String to {get;set;}
        public Integer length {get;set;}
    }
}