public class PlanDeAccionController {
	
    public String miJson {get;set;}
    
    public String idCuenta {get; set;}
    
    public FourPlanning__c fourPlanning {get; set;}
    
    public List<FourPlanning_Reto__c> retos {get; set;}
 
    public List<FourPlanning_Hito__c> Hitos {get; set;}
    
    public List<FourPlanning_Hito_global__c> hitosGlobales {get; set;}
    
    public Boolean mostrar {get; set;}

    public Boolean pedirQueCompleteFourPlanning {get; set;}
    
    public String eventosJson {get; set;}
    
    public Boolean mostrarLineaDeTiempo {get; set;}
    
    public Account cuenta {get; set;}
    
    //Lista de eventos por categoria.
    public List <String> vencimientos {get; set;}
    public List <String> eventoTelefonica {get; set;}
    public List <String> eventosDeTipoReto {get; set;}
    public List <String> vencimientoCompetencia {get; set;}
    public List <String> publicacionRFPComunicacion {get; set;}
    public List <String> publicacionRFPTI {get; set;}
    public List <String> eventoIndustria {get; set;}
    public List <String> previsionTOP3 {get; set;}
    public List <String> otroTipoDeEvento {get; set;}
    
    //filtro linea de tiempo.
    public Boolean filtroVencimiento {get; set;}
    public Boolean filtroEventoTelefonica {get; set;}
    public Boolean filtroEventosDeTipoReto {get; set;}
    public Boolean filtroVencimientoCompetencia {get; set;}
    public Boolean filtroPublicacionRFPComunicacion {get; set;}
    public Boolean filtroPublicacionRFPTI {get; set;}
    public Boolean filtroEventoIndustria {get; set;}
    public Boolean filtroPrevisionTOP3 {get;set;}
    public Boolean filtroOtroTipoDeEvento {get; set;}
    public Boolean todos {get; set;}
    
    public PlanDeAccionController(){
    	
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
		filtroVencimiento = true;
        filtroEventoTelefonica = true;
        filtroEventosDeTipoReto = true;
        filtroVencimientoCompetencia = true;
        filtroPublicacionRFPComunicacion = true;
        filtroPublicacionRFPTI = true;
        filtroEventoIndustria = true;
        filtroPrevisionTOP3 = true;
        filtroOtroTipoDeEvento = true;
        todos = true;
        
        //Consigo el fourPlanning.
        fourPlanning = new FourPlanning__c();
        
        List<FourPlanning__c> fourPlannings = new List<FourPlanning__c>();

        if(idCuenta != null){
            
            fourPlannings = [SELECT Id, Fecha_Evento__c, Evento_telefonica_cliente__c, Vencimiento_Datos_Fijos__c, 
                             Vencimiento_Otros_Servicios__c, Vencimiento_Servicios_Moviles__c, conocimiento_de_la_cuenta__c,
                             (select id from FourPlanning_Areas__r)
                             FROM FourPlanning__c 
                             WHERE Cuenta__c =: idCuenta
                             LIMIT 1];
            
            if(fourPlannings.size() > 0){
                fourPlanning = fourPlannings[0];
                //system.debug(fourPlanning);
            }
            
            cuenta = [select id, name, Region__c, Micro_Industry__c, Industry
                      from account where id =: idCuenta];
        }

        
        mostrarLineaDeTiempo = false;
        if(fourPlannings.size() > 0){
            if(fourPlannings[0].conocimiento_de_la_cuenta__c != null){
                mostrarLineaDeTiempo = true;
            }
        }
        
        //system.debug(mostrarLineaDeTiempo);
        
        mostrar = false;
        if(idCuenta != null){
            mostrar = true;
        }
		
        pedirQueCompleteFourPlanning = false;
        if(fourPlanning == null){
			pedirQueCompleteFourPlanning = true;
        }
        
        //Consigo Las Areas
        List<Id> areas = new List<Id>();
        for(FourPlanning_Area__c area: fourPlanning.FourPlanning_Areas__r){
            areas.add(area.id);
        }
        
        //Consigo los Retos
        system.debug(areas);
        
        retos = [SELECT Id, FourPlanning_Area__c, Fecha_Compromiso__c, Nombre_del_Reto__c, Nota__c FROM FourPlanning_Reto__c WHERE FourPlanning_Area__c IN: areas];
        
        for(FourPlanning_Reto__c reto:retos){
            system.debug(reto.Nombre_del_Reto__c);
        }
        system.debug(retos);
        //Consigo los Hitos
        
        Hitos = [SELECT Id, Fecha__c, Descripcion__c, Categoria__c FROM FourPlanning_Hito__c WHERE FourPlanning__c =: fourPlanning.Id];
        
        //Consigo los hitos globales
        String condicion = 'Where id != null ';
        if(cuenta.Region__c != null){
            
            Region__c unaRegion = [select id, Parent__c from Region__c where id =:cuenta.region__c];
            List<id> regiones = Util.getParentsRegions(unaRegion);
            
            if(regiones.size() == 0){
                condicion += ' AND Region__c = \''+cuenta.region__c+'\' ';
            }else{
                condicion += ' AND Region__c IN: regiones ';
            }
            
        }
        if(cuenta.Industry != null && cuenta.Industry != 'Todos'){
            condicion += ' AND (Sector__c = \''+cuenta.Industry+'\' OR Sector__c = \'Todos\') ';
            
            if(cuenta.Micro_Industry__c != null){
                condicion += ' AND (Sub_sector__c = \''+cuenta.Micro_Industry__c+'\' OR Sub_sector__c = \'Todos\' OR Sub_sector__c = NULL) ';
            }
        }

        
        hitosGlobales = database.query('select id, Fecha__c, Descripcion__c, Categoria__c, createdDate from FourPlanning_Hito_global__c '+condicion+' ORDER BY createdDate');
        //system.debug(hitos);
        //Genero el JSON.
        //eventosJson = generarJson();
        
        eventosJson = generarJson();
        
        //miJson = '{"events":[{"media":{"url":"/resource/1460486002000/certa_scp__Iconos/256/find-icon.png","caption":".","credit":"","thumbnail":"conceptdraw.com/a2331c3/p6/preview/256/pict--flag-travel-and-tourism-pictograms-vector-stencils-library"},"start_date":{"month":"11","day":"9","year":"2016"},"text":{"headline":"Hito 1","text":"Descripcion del hito 1","tag":"Categoria 1"}},{"media":{"url":".png","caption":".","credit":""},"start_date":{"month":"11","day":"9","year":"2016"},"text":{"headline":"Vencimiento","text":"<b>Fecha Vencimiento Contrato telefonica</b><p>asd</p>","tag":"Categoria 1"}},{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"9","day":"10","year":"2016"},"text":{"headline":"Hito 3","text":"Descripcion del hito 3","tag":"Categoria 1"}},{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"2","day":"13","year":"2016"},"text":{"headline":"Hito 2","text":"Descripcion del segundo hito"}}]}';
    
        miJson = generarJson();
        
        //system.debug(mostrarLineaDeTiempo);
        //system.debug(miJson);
        
    }
    
    public String generarJson(){
        
        vencimientos = new List<String>();
        eventoTelefonica = new List<String>();
        eventosDeTipoReto = new List<String>();
        vencimientoCompetencia = new List<String>();
        publicacionRFPComunicacion = new List<String>();
        publicacionRFPTI = new List<String>();
        eventoIndustria = new List<String>();
        previsionTOP3 = new List<String>();
        otroTipoDeEvento = new List<String>();
        
        String retorno = '';
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        
        List<String> eventos = new List<String>();
        
        String datosFourPlanning = generarDatosFourPlanning();
        if(datosFourPlanning != '' && datosFourPlanning != null){
            eventos.add(datosFourPlanning);
        }
        
        //system.debug(eventos.size());
        //system.debug(eventos);
        
        if(retos.size() > 0 ){
            
            String datosRetos = generarDatosRetos();
            if(datosRetos!= ''){
                eventos.add(datosRetos);
            }
        }
        //system.debug(eventos.size());
        //system.debug(eventos);
        
        //system.debug(hitos);
        if(hitos.size() > 0){
            //system.debug('tengo hitos');
            String datosHitos = generarDatosHitos();
            if(datosHitos != ''){
                eventos.add(datosHitos);
            }
        }
        //system.debug(eventos.size());
        //system.debug(eventos);
        
        /*
        String oppMasImportante = generarDatosSobre3OportunidadesMasImportantes();
        if(oppMasImportante != ''){
            eventos.add(oppMasImportante);
        }*/
        
        //system.debug(eventos);
        
        String eventosConcatenados = concatenarDatos(eventos);
        if(eventosConcatenados == '' || eventosConcatenados == null){
            mostrarLineaDeTiempo = false;
        }
        
        retorno = cabecera + concatenarDatos(eventos) + ']}';
        
        system.debug(vencimientos.size());
        return retorno;
    }
    
    
    
    public String generarDatosFourPlanning(){
        
        List<String> eventos = new List<String>();
        
        String serviciosMoviles = '';
        if(fourPlanning.Vencimiento_Servicios_Moviles__c != null){
    
            String titulo = Label.Vencimiento;
            String descripcion = 'Fecha de vencimiento de contrato de servicios móviles';
            
            serviciosMoviles = generarDatosDeFecha(fourPlanning.Vencimiento_Servicios_Moviles__c, titulo , descripcion);
            
            eventos.add(serviciosMoviles);
            vencimientos.add(serviciosMoviles);
        }
        
        String otrosServicios = '';
        if(fourPlanning.Vencimiento_Otros_Servicios__c != null){
            
            String titulo = Label.Vencimiento;
            String descripcion = 'Fecha de vencimiento de contratos de otros servicios';
            
            otrosServicios = generarDatosDeFecha(fourPlanning.Vencimiento_Otros_Servicios__c, titulo, descripcion);
			
			eventos.add(otrosServicios);
			vencimientos.add(otrosServicios);            
        }
        
        String datosFijos = '';
        if(fourPlanning.Vencimiento_Datos_Fijos__c != null){
            
            String titulo = Label.Vencimiento;
            String descripcion = 'Fecha de Vencimiento de contratos de datos fijos';
            
            datosFijos = generarDatosDeFecha(fourPlanning.Vencimiento_Datos_Fijos__c, titulo, descripcion);
            
            //system.debug(datosFijos);
            eventos.add(datosFijos);
            vencimientos.add(datosFijos);
        }
        
        String evento = '';
        if(fourPlanning.Fecha_Evento__c != null){
        
            String titulo = Label.Evento_Telef_nica;
            String descripcion = fourPlanning.Evento_telefonica_cliente__c;
            
            evento = generarDatosDeFecha(fourPlanning.Fecha_Evento__c, titulo, descripcion);
        
        	eventos.add(evento);
            eventoTelefonica.add(evento);
        }
        
        String retorno = concatenarDatos(eventos);
        //system.debug(retorno);
        return retorno;
    }
      
    public String generarDatosRetos(){
        
        List<String> eventos = new List<String>();
        for(FourPlanning_Reto__c reto: retos){
            
            if(reto.Fecha_Compromiso__c != null){
                String titulo = Label.reto;
                String descripcion = '';
                
                if(reto.Nombre_del_Reto__c != null){
                    descripcion = '<b>'+reto.Nombre_del_Reto__c+'</b>';
                }
                if(reto.Nota__c != null){
                    descripcion += '<p>'+reto.Nota__c.escapeJava()+'</p>';
                }
                    
                String dato = generarDatosDeFecha(reto.Fecha_Compromiso__c, titulo, descripcion);
                eventos.add(dato);
                eventosDeTipoReto.add(dato);
            }
        }
        
		String retorno = concatenarDatos(eventos);
		//System.debug(retorno);        
        return retorno;
    }
    
    public String generarDatosHitos(){
        
        List<String> eventos = new List<String>();
        for(FourPlanning_Hito__c hito: Hitos){
            
            if(hito.Fecha__c != null){
                
                String titulo = Label.Otro;
                if(hito.Categoria__c != null){
                    titulo = hito.Categoria__c;
                    
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con Telefónica')){
						titulo = Label.Vencimiento_Contrato_Activo_con_Telef_nica;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Reto')){
						titulo = Label.reto;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con la Competencia')){
						titulo = Label.Vencimiento_Contrato_Activo_con_la_Competencia;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP Comunicaciones')){
						titulo = Label.Publicaci_n_RFP_Comunicaciones;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP TI')){
						titulo = Label.Publicaci_n_RFP_TI;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento para clientes de Telefonica')){
						titulo = Label.Evento_para_clientes_de_Telefonica;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento Relevante de la industria')){
						titulo = Label.Evento_Relevante_de_la_industria;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Previsión Cierre TOP 3 deals')){
						titulo = Label.Previsi_n_Cierre_TOP_3_deals;
                    }
                }
               
                
                String descripcion = '';
                
                if(hito.Descripcion__c != null){
                    descripcion = hito.Descripcion__c.escapeJava();
                }
                
                String dato = generarDatosDeFecha(hito.Fecha__c, titulo, descripcion);
                eventos.add(dato);
                
                Boolean aniadidoAUnaCategoria = false;
                if(hito.categoria__c != null){
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con Telefónica')){
                        vencimientos.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Reto')){
                        eventosDeTipoReto.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con la Competencia')){
                        vencimientoCompetencia.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP Comunicaciones')){
                        publicacionRFPComunicacion.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP TI')){
                        publicacionRFPTI.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento para clientes de Telefonica')){
                        eventoTelefonica.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento Relevante de la industria')){
                        eventoIndustria.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Previsión Cierre TOP 3 deals')){
                        previsionTOP3.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                }
                
                if(!aniadidoAUnaCategoria){
                    otroTipoDeEvento.add(dato);
                }
            }
        }
        
        //Hitos globales
        for(FourPlanning_Hito_global__c hito: hitosGlobales){
            
            if(hito.Fecha__c != null){
                
                String titulo = Label.Otro;
                if(hito.Categoria__c != null){
                    titulo = hito.Categoria__c;
                    
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con Telefónica')){
						titulo = Label.Vencimiento_Contrato_Activo_con_Telef_nica;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Reto')){
						titulo = Label.reto;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con la Competencia')){
						titulo = Label.Vencimiento_Contrato_Activo_con_la_Competencia;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP Comunicaciones')){
						titulo = Label.Publicaci_n_RFP_Comunicaciones;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP TI')){
						titulo = Label.Publicaci_n_RFP_TI;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento para clientes de Telefonica')){
						titulo = Label.Evento_para_clientes_de_Telefonica;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento Relevante de la industria')){
						titulo = Label.Evento_Relevante_de_la_industria;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Previsión Cierre TOP 3 deals')){
						titulo = Label.Previsi_n_Cierre_TOP_3_deals;
                    }
                }
               
                
                String descripcion = '';
                
                if(hito.Descripcion__c != null){
                    descripcion = hito.Descripcion__c.escapeJava();
                }
                
                String dato = generarDatosDeFecha(hito.Fecha__c, titulo, descripcion);
                eventos.add(dato);
                
                Boolean aniadidoAUnaCategoria = false;
                if(hito.categoria__c != null){
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con Telefónica')){
                        vencimientos.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Reto')){
                        eventosDeTipoReto.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con la Competencia')){
                        vencimientoCompetencia.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP Comunicaciones')){
                        publicacionRFPComunicacion.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP TI')){
                        publicacionRFPTI.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento para clientes de Telefonica')){
                        eventoTelefonica.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento Relevante de la industria')){
                        eventoIndustria.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Previsión Cierre TOP 3 deals')){
                        previsionTOP3.add(dato);
                        aniadidoAUnaCategoria = true;
                    }
                }
                
                if(!aniadidoAUnaCategoria){
                    otroTipoDeEvento.add(dato);
                }
            }
        }
        
		String retorno = concatenarDatos(eventos);
		//system.debug(retorno);        
        return retorno;
    }
     
    public String generarDatosDeFecha(Date fecha, String titulo, String descripcion){
        
        String datos = '';
        
        Integer dia = fecha.day();
        Integer mes = fecha.month();
        Integer anio = fecha.year();
        
        datos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"'+titulo+'","text":"'+descripcion+'","tag":"Categoria 1"}}';
        
        return datos;
    }
    
    public String concatenarDatos(List<String> eventos){
        
        String retorno = '';
        for(String evento: eventos){
            retorno = retorno + evento + ',';
        }
        //system.debug(retorno);
        retorno = retorno.removeEnd(',');
        
        return retorno;
    }
    
    /* A Implementar a futuro.
    public String generarDatosSobre3OportunidadesMasImportantes(){
        
        //Obtengo las 3 oportunidades.
        //Metodo no testeable por que estos dos campos que estoy llamando son ajenos al paquete, se encuentran en el entorno de telefonica.
        List <Opportunity> OportunidadesMasImportantes = new List<Opportunity>();
        String retorno = '';
        
        Set<String> objectFields = Schema.SObjectType.Opportunity.fields.getMap().keySet();
        try{
            String idCuentaAux = idCuenta;
            if(objectFields.contains('bi_net_annual_value_nav__c') && objectFields.contains('bi_fecha_de_cierre_real__c')) {
                OportunidadesMasImportantes = DataBase.query('SELECT id, CurrencyIsoCode, bi_net_annual_value_nav__c, bi_fecha_de_cierre_real__c, name FROM Opportunity WHERE AccountId =: idCuentaAux  AND bi_fecha_de_cierre_real__c != NULL ORDER BY bi_net_annual_value_nav__c DESC  Limit 3');
            }else{
                system.debug('No lo contengo');
            }
        }catch(Exception e){
            system.debug('Ocurrio un error obteniendo las 3 oportunidades mas importantes: ' + e.getMessage());
        }
        
		List<String> eventos = new List<String>();
        for(Opportunity oportunidad: OportunidadesMasImportantes){
                            
                String titulo = 'Previsión Cierre TOP 3 deals';
                
                String descripcion = '';
                
                if(oportunidad.name != null && + oportunidad.get('bi_net_annual_value_nav__c') != null){
                    descripcion = '<b>'+(String)oportunidad.get('name')+'</b>'+'<p><b>Net annual value (NAV):</b> '+(String)oportunidad.get('CurrencyIsoCode')+' '
                        +(Double)oportunidad.get('bi_net_annual_value_nav__c')+'</p>';
                }
                
                String dato = generarDatosDeFecha((Date)oportunidad.get('bi_fecha_de_cierre_real__c'), titulo, descripcion);
                eventos.add(dato);
				previsionTOP3.add(dato);
        }
		
        retorno = concatenarDatos(eventos);
        return retorno;
    }
    */
    
    public PageReference filtrarTimeLine(){
        
        List<String> eventos = new List<String>();
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        

        if(filtroVencimiento){
            eventos.addAll(vencimientos);
        }
        system.debug(vencimientos);
        system.debug(vencimientos.size());
        if(filtroEventoTelefonica){
            eventos.addAll(eventoTelefonica);
        }
        if(filtroEventosDeTipoReto){
            eventos.addAll(eventosDeTipoReto);
        }        
        if(filtroVencimientoCompetencia){
            eventos.addAll(vencimientoCompetencia);
        }
        if(filtroPublicacionRFPComunicacion){
            eventos.addAll(publicacionRFPComunicacion);
        }
        if(filtroPublicacionRFPTI){
            eventos.addAll(publicacionRFPTI);
        }
        if(filtroEventoIndustria){
            eventos.addAll(eventoIndustria);
        }
        if(filtroPrevisionTOP3){
            eventos.addAll(previsionTOP3);
        }
        if(filtroOtroTipoDeEvento){
            eventos.addAll(otroTipoDeEvento);
        }

        
        mostrarLineaDeTiempo = false;
        String eventosConcatenados = '';
        
        if(eventos.size() > 0){
            eventosConcatenados = concatenarDatos(eventos);
            if(eventosConcatenados != '' && eventosConcatenados != null){
                mostrarLineaDeTiempo = true;
            }
            
        }
        
        system.debug(eventosConcatenados);
        
        miJson = cabecera + eventosConcatenados + ']}';
        
        system.debug(miJson);
        return null;
    }
    
    //=============================================
    public PageReference irACuestionario(){
        
        String url = Page.cuestionarioFourPlanning.getURL();
        return new PageReference (url + '?id=' + idCuenta);
    }
    
        public PageReference irAForYou(){
        
        String url = Page.ForYou.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
	
    public PageReference irADesarrolloCuenta(){
        
        String url = Page.DesarrolloCuenta.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
    
    public PageReference irAInicio(){
        String url = Page.Tab4Planning.getURL();
        return new PageReference (url);   
    }
    public PageReference irAEjesDeTrabajo(){
        
        String url = Page.EjesDeTrabajo.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
}