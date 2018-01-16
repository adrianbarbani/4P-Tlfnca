public class EjesDeTrabajoController {

    public String idCuenta {get; set;}
    public FourPlanning__c fourPlanning {get; set;}
    
    public List<FourPlanning_Reto__c> retosAreas {get; set;}
    
    public List<AreaWrapper> areas {get; set;}
    
    public Boolean mostrar {get; set;}
    public Boolean hayDatos {get; set;}
    
    map<Id, List<retoWrapper> > areasConSusRetos {get; set;}
    
    public ObjetoJsonD3 objetoASerializar {get; set;}
    public String js {get; set;}
    
    public List<Opportunity> opp {get;set;}
        
    
    public EjesDeTrabajoController(){
        
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
        fourPlanning = new FourPlanning__c();
        
        areasConSusRetos = new Map<Id, List<retoWrapper> >();
        
        List<FourPlanning__c> fourPlannings = new List<FourPlanning__c>();
        
        if(idCuenta != null){
            
            fourPlannings = [SELECT Id,
                             (select id, Conocimiento_del_Area__c, Numero_de_Area__c, Titulo_Area__c from FourPlanning_Areas__r where Titulo_Area__c != 'Retos de Gestion')
                             FROM FourPlanning__c 
                             WHERE Cuenta__c =: idCuenta
                             LIMIT 1];
            
            if(fourPlannings.size() > 0){
                fourPlanning = fourPlannings[0];
                system.debug(fourPlanning);
            }
            
        }
        
        mostrar = false;
        if(idCuenta != null){
            mostrar = true;
        }
        
        
        retosAreas = new List<FourPlanning_Reto__c>();
        
        List<Id> areasId = new List<Id>();
        for(FourPlanning_Area__c area: fourPlanning.FourPlanning_Areas__r){
            areasId.add(area.id);
        }
        
        retosAreas = [SELECT ID, Nombre_del_Reto__c, Tipo_De_Reto__c, Contactos_del_Cliente__c, Productos_a_Desarrollar_Vender__c, Otros_contactos_del_cliente__c,
                      Estado_de_la_solucion__c, Nivel_de_relaci_n_contacto__c, Etapa_del_Reto__c, FourPlanning_Area__c,
                      (select id from Oportunidades__r limit 1),
                      (select id, Reto__c, Lista_de_Soluciones__c, Nivel_de_Desarrollo__c, Observaci_n_sobre_el_producto__c, Otra_Solucion__c from FourPlanning_Soluciones__r),
                      (select id, Nivel_de_Relaci_n__c, Reto__c, Otro_contacto_del_cliente__c, Tipo_de_Contacto__c from FourPlanning_Contactos__r)
                      FROM FourPlanning_Reto__c 
                      WHERE FourPlanning_Area__c IN: areasId];
		
		
        
        
        hayDatos = false;
        if(retosAreas.size()>0){
            hayDatos = true;
        }
        
        crearRetosWrappers(); 
        
        areas = new List<AreaWrapper>();
        
        for(FourPlanning_Area__c area:fourPlanning.FourPlanning_Areas__r){
            
            List<retoWrapper> retosWrapperDelArea = areasConSusRetos.get(area.id);
            if(retosWrapperDelArea == null){
                retosWrapperDelArea = new List<retoWrapper>();
            }
            
            areas.add(new AreaWrapper(area.Titulo_Area__c, retosWrapperDelArea ,area.Conocimiento_del_Area__c));
        }
		
        crearObjetoD3();

        js = JSON.serialize(objetoASerializar);
		system.debug(js);       
    }
    
    
    public void crearRetosWrappers(){
        
        for(FourPlanning_Area__c area: fourplanning.FourPlanning_Areas__r){
            
            List<FourPlanning_Reto__c> retosArea =  new List<FourPlanning_Reto__c>();
            for(FourPlanning_Reto__c reto: retosAreas){
                if(area.id == reto.FourPlanning_Area__c){
                    retosArea.add(reto);
                }
            }
            
            
            generarWrapperPara(area.id, retosArea);
            
        }

    }
    
    public void generarWrapperPara(Id area, List<FourPlanning_Reto__c> retosArea){
        
        List<retoWrapper> retosWrapperArea = new List<retoWrapper>();
        for(FourPlanning_Reto__c reto: retosArea){    
            RetoWrapper unRetoWrapper = new RetoWrapper(reto);
            retosWrapperArea.add(unRetoWrapper);
        }
        
        areasConSusRetos.put(area, retosWrapperArea);
    }
    
    public PageReference irAPlanDeAccion() {
        
        String url = Page.PlanDeAccion.getURL();
        return new PageReference (url + '?id=' + idCuenta);
    }
    
    public PageReference irADesarrolloCuenta(){

        String url = Page.DesarrolloCuenta.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
    
    public PageReference irACuestionario(){
        
        String url = Page.cuestionarioFourPlanning.getURL();
        return new PageReference (url + '?id=' + idCuenta);
    }
    
    public PageReference irAForYou(){
        
        String url = Page.ForYou.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
    
    public PageReference irAInicio(){
        String url = Page.Tab4Planning.getURL();
        return new PageReference (url);   
    }
    
    public void crearObjetoD3(){
        
        List<ObjetoJsonD3> hijosDeArea = new List<ObjetoJsonD3>();
        
        objetoASerializar = new ObjetoJsonD3();
        objetoASerializar.name = 'Areas';
        objetoASerializar.parent = 'null';
        objetoASerializar.level = 'null';
        objetoASerializar.prueba = 'null';
		objetoASerializar.children = hijosDeArea;	
        
        for(AreaWrapper area: areas){
            
            List<ObjetoJsonD3> hijosDeReto = new List<ObjetoJsonD3>();
            
            ObjetoJsonD3 objArea = new ObjetoJsonD3();
            objArea.name = area.area;
            objArea.parent = 'null';
            
            if(area.conocimientoArea == 'Alto'){
                objArea.level = '#09ce0c';
                objArea.type = '#09ce0c';
            }
            if(area.conocimientoArea == 'Medio'){
                objArea.level = 'yellow';
                objArea.type = 'yellow';
            }
            if(area.conocimientoArea == 'Bajo'){
                objArea.level = 'red';
                objArea.type = 'red';
            }
            
            objArea.children = hijosDeReto;
            hijosDeArea.add(objArea);
            
            
            for(RetoWrapper reto: area.retos){
                List<ObjetoJsonD3> subdiviciones = new List<ObjetoJsonD3>();
                
                ObjetoJsonD3 objReto = new ObjetoJsonD3();
                objReto.name = reto.reto.Nombre_del_Reto__c;
                objReto.parent = 'null';
               	objReto.children = subdiviciones;
                hijosDeReto.add(objReto);
                
                if(reto.reto.Etapa_del_Reto__c == 'Diseño' || reto.reto.Etapa_del_Reto__c == 'Prospección'){
                    objReto.level = '#09ce0c';
                    objReto.type = '#09ce0c';
                }
                if(reto.reto.Etapa_del_Reto__c == 'RFP' || reto.reto.Etapa_del_Reto__c == 'RFI'){
                    objReto.level = 'yellow';
                    objReto.type = 'yellow';
                }
                if(reto.reto.Etapa_del_Reto__c == 'Compras' || reto.reto.Etapa_del_Reto__c == 'Implementación'){
                    objReto.level = 'red';
                    objReto.type = 'red';
                }
                
                if(reto.opp.size() >0){
                    objReto.prueba = 'orange';
                }
                else{
                    objReto.prueba = 'white';
                }
                
                
                
                
                List<ObjetoJsonD3> todasLasTecnologias = new List<ObjetoJsonD3>();
                ObjetoJsonD3 objTecnologia = new ObjetoJsonD3();
                objTecnologia.name = 'Tecnologias';
                //objTecnologia.parent = 'null';
                //objTecnologia.level = 'null';
                objTecnologia.children = todasLasTecnologias;
                subdiviciones.add(objTecnologia);
                
                List<ObjetoJsonD3> todosLosContactos = new List<ObjetoJsonD3>();
                ObjetoJsonD3 objContactoTotal = new ObjetoJsonD3();
                objContactoTotal.name = 'Contactos';
                //objContactoTotal.parent = 'null';
                //objContactoTotal.level = 'null';
                objContactoTotal.children = todosLosContactos;
                subdiviciones.add(objContactoTotal);
                
                for(FourPlanning_Contacto__c contacto: reto.contactosDelCliente){
                    ObjetoJsonD3 objContacto = new ObjetoJsonD3();
                    objContacto.name = contacto.Tipo_de_Contacto__c;
                    //objContacto.parent = 'null';
                    //objContacto.level = 'null';
					
                    if(contacto.Nivel_de_Relaci_n__c == 'Fluida y Constante'){
                        objContacto.level = '#09ce0c';
                        objContacto.type = '#09ce0c';
                    }
                    if(contacto.Nivel_de_Relaci_n__c == 'Intensa y Difícil' || contacto.Nivel_de_Relaci_n__c == 'Ocasional pero Cordial'){
                        objContacto.level = 'yellow';
                        objContacto.type = 'yellow';
                    }
                    if(contacto.Nivel_de_Relaci_n__c == 'Es “Anti-Telefonica”' || contacto.Nivel_de_Relaci_n__c == 'No lo conozco'){
                        objContacto.level = 'red';
                        objContacto.type = 'red';
                    }
                    
                    todosLosContactos.add(objContacto);
                }
                
                for(FourPlanning_Solucion__c solucion: reto.solucionesDelCliente){
                    ObjetoJsonD3 objSolucion = new ObjetoJsonD3();
                    objSolucion.name = solucion.Lista_de_Soluciones__c;
                    //objSolucion.parent = 'null';
                    //objSolucion.level = 'null';
                    
                    if(solucion.Nivel_de_Desarrollo__c == 'Disponible'){
                        objSolucion.level = '#09ce0c';
                        objSolucion.type = '#09ce0c';
                    }
                    if(solucion.Nivel_de_Desarrollo__c == 'En Desarrollo'){
                        objSolucion.level = 'yellow';
                        objSolucion.type = 'yellow';
                    }
                    if(solucion.Nivel_de_Desarrollo__c == 'No Disponible'){
                        objSolucion.level = 'red';
                        objSolucion.type = 'red';
                    }
                    
                    todasLasTecnologias.add(objSolucion);
                }

            }
            
        }
        
    }
    //=========================================================
    class RetoWrapper {
        
        public FourPlanning_Reto__c reto {get; set;}
        public List<FourPlanning_Contacto__c> contactosDelCliente {get; set;}
        public List<FourPlanning_Solucion__c> solucionesDelCliente {get; set;}
        public List<Opportunity> opp {get;set;}
        
        public retoWrapper(FourPlanning_Reto__c unReto){
            reto = unReto;
            
            opp = unReto.Oportunidades__r;
            
            contactosDelCliente = unReto.FourPlanning_Contactos__r;
            
            if(contactosDelCliente == null){
                contactosDelCliente = new List<FourPlanning_Contacto__c>();
            }
			
            solucionesDelCliente = unReto.FourPlanning_Soluciones__r;
            
            if(solucionesDelCliente == null){
                solucionesDelCliente = new List<FourPlanning_Solucion__c>();
            }
            
            /*
            contactosDelCliente = new List<String>();
            if(unReto.Contactos_del_Cliente__c != null){
                contactosDelCliente = unReto.Contactos_del_Cliente__c.split(';');
            }*/
            
            /*
            soluciones = new List<String>();
            if(unReto.Productos_a_Desarrollar_Vender__c != null){
                soluciones = unReto.Productos_a_Desarrollar_Vender__c.split(';');
            }*/
        }
        
    }
    
    public class AreaWrapper {
        
        public String area {get; set;}
        public List<RetoWrapper> retos {get; set;}
        public String conocimientoArea {get; set;}
        
        public AreaWrapper(String titulo, List<RetoWrapper> retosWrapper, String unConocimiento){
            area = titulo;
            
            retos = new List<RetoWrapper>();
            for(RetoWrapper reto : retosWrapper){
                if(reto.reto.Nombre_del_Reto__c != null && reto.reto.Nombre_del_Reto__c != ''){
                    retos.add(reto);
                }
            }
            
            conocimientoArea = '';
            if(unConocimiento != null){
                conocimientoArea = unConocimiento;
            }
        }
    }
    
    
}