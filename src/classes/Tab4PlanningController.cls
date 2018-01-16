public class Tab4PlanningController {
    
    public transient String cuerpoDeMail {get;set;}
    
    public transient String mailUsuario {get;set;}
    public transient String nombreUsuario {get;set;}
    
   
    
    public transient List<Account> cuentas {get; set;}
    
    public transient List<Opportunity> oportunidadesUltimoQ {get; set;}
    public transient List<Opportunity> oportunidadesTercerQ {get; set;}
    public transient List<Opportunity> oportunidadesSegundoQ {get; set;}
    public transient List<Opportunity> oportunidadesPrimerQ {get; set;}
    
    //Filtro
    public Filtros_principales_4Planning__c filtro {get; set;}
    
    public transient String filtro2Parametro {get;set;}
    public transient String filtro3Parametro {get;set;}
    public transient String filtro4Parametro {get; set;}
    
    public transient String filtro2Operacion {get; set;}
    public transient String filtro3Operacion {get; set;}
    public transient String filtro4Operacion {get; set;}
    
    public transient String filtro1Valor {get;set;}
    public transient Double filtro2Valor {get;set;}
    public transient Double filtro3Valor {get;set;}
    public transient Double filtro4Valor {get;set;}
    
    public transient String conectorLogico1 {get; set;}
    public transient String conectorLogico2 {get; set;}
    public transient String conectorLogico3 {get; set;}
    
    public transient String filtroDeNombre {get; set;}
    
    //Promedios
    public Decimal promedioCoeDesarrollo {get; set;}
    public Decimal promedioCompletitud {get; set;}
    public transient Decimal promedioCuentasConFourPlanning {get; set;}
    
    //Linea de tiempo
    public transient String miJson {get; set;}

    public Boolean mostrarLineaDeTiempo {get; set;}
    public Boolean mostrarEsferas {get; set;}
    

    //filtro linea de tiempo
    public transient Boolean filtroVencimiento {get; set;}
    public transient Boolean filtroEventoTelefonica {get; set;}
    public transient Boolean filtroEventosDeTipoReto {get; set;}
    public transient Boolean filtroVencimientoCompetencia {get; set;}
    public transient Boolean filtroPublicacionRFPComunicacion {get; set;}
    public transient Boolean filtroPublicacionRFPTI {get; set;}
    public transient Boolean filtroEventoIndustria {get; set;}
    public transient Boolean filtroOtroTipoDeEvento {get; set;}
    public transient Boolean todos {get; set;}
    
    public Double maximoValorEnPixeles {get;set;}
    public static final Double VALOR_QUE_MULTIPLICA_PARA_DEFINIR_LA_ALTURA_DEL_NOMBRE_DE_ZONA_OBJETIVO = 0.9;
    
    public Bola ultimoQ {get; set;}
    public Bola tercerQ {get; set;}
    public Bola segundoQ {get; set;}
    public Bola primerQ {get; set;}
    
    public transient Double alturaPromedioPais {get; set;}
    public transient Double alturaNombre {get; set;}    
    
    public ApexPages.StandardSetController setCuentas {get; set;}
    
    public transient String nombreDiametroQ1 {get; set;}
    public transient String nombreDiametroQ2 {get; set;}
    public transient String nombreDiametroQ3 {get; set;}
    public transient String nombreDiametroQ4 {get; set;}
    
    public List<usuarioWrapper> usersWpp {get; set;}
    public List<usuarioWrapper> wrapperUsuarios {get; set;}
    
    public Integer numeroDePagina {get;set;}
    public Integer paginasTotales {get;set;}
    public Set<Id> usuariosABuscar{get;set;}
    //===================================================================================================
    public Tab4PlanningController(){
        
        String cuerpoDeMail;
        
        cuentas = new List<Account>();
        
        numeroDePagina = 1;
        paginasTotales = 1;
        
        maximoValorEnPixeles = 160;
        
        nombreDiametroQ1 = '0';
        nombreDiametroQ2 = '0';
        nombreDiametroQ3 = '0';
        nombreDiametroQ4 = '0';
        
        filtroVencimiento = true;
        filtroEventoTelefonica = true;
        filtroEventosDeTipoReto = true;
        filtroVencimientoCompetencia = true;
        filtroPublicacionRFPComunicacion = true;
        filtroPublicacionRFPTI = true;
        filtroEventoIndustria = true;
        filtroOtroTipoDeEvento = true;
        
        mostrarLineaDeTiempo = false;
        mostrarEsferas = true;
        
        Id miId = UserInfo.getUserId();
        
        User miUsuario = [select id, name, Email, UserRoleId from user where id =: miId];
        
        system.debug(miUsuario);
        nombreUsuario = miUsuario.name;
        mailUsuario = miUsuario.Email;
        
        Set<Id> usuariosDebajoDeLaJerarquia = new Set<Id>();
        if(miUsuario.userRoleId != null){
            usuariosDebajoDeLaJerarquia.addAll(Util.getRoleSubordinateUsers(miUsuario.UserRoleId));
        }
        
        system.debug(usuariosDebajoDeLaJerarquia);
        
         //Si no hay usuarios debajo, el set vuelve vacio.
        usuariosDebajoDeLaJerarquia.add(miId);
        
        
       // Set<Id> usuariosDebajoDeUnaSolaJerarquia = new Set<Id>();
        //if(miUsuario.userRoleId != null){
          //  usuariosDebajoDeUnaSolaJerarquia.addAll(Util.getPrimerosRoles(miUsuario.UserRoleId));
        //}
        
        //system.debug(usuariosDebajoDeUnaSolaJerarquia);
        
        List<User> usuariosDebajo = new List<User>();
        
        //usuariosDebajo = [Select id, name from User where id in : usuariosDebajoDeUnaSolaJerarquia limit 955];
		usuariosDebajo = [Select id, name from User where ManagerId = : miUsuario.id limit 955];
        
        system.debug(usuariosDebajo);
        
        usersWpp = new List<UsuarioWrapper>(); 
        wrapperUsuarios = new List<UsuarioWrapper>();
        
        for(User usr : usuariosDebajo){
            usuarioWrapper usuario = new usuarioWrapper(usr);
            wrapperUsuarios.add(usuario);
        }    
        
        system.debug(wrapperUsuarios);
       
        
        usuariosABuscar = new Set<Id>(); 
        if(usuariosDebajoDeLaJerarquia.size()<2500){
            usuariosABuscar = usuariosDebajoDeLaJerarquia;
        } 

        
        Set<String> objectFields = Schema.SObjectType.Account.fields.getMap().keySet();
        List<Account> cuentasTotales = new List<Account>();
        List<Account> cuentasPaginaActual = new List<Account>();
        
        if( objectFields.contains('bi_segment__c') ) {
            
            cuentasTotales = database.query('SELECT name, bi_estado__c, OwnerId, Owner.name,  Ir_a_4Planning__c,(select id, conocimiento_de_la_cuenta__c, Vencimiento_Servicios_Moviles__c, Vencimiento_Otros_Servicios__c, Porcentaje_de_completitud_de_la_cuenta__c, Vencimiento_Datos_Fijos__c, Fecha_Evento__c, Evento_telefonica_cliente__c from FourPlannings__r limit 1) FROM Account where OwnerId IN: usuariosDebajoDeLaJerarquia AND bi_segment__c = \'Empresas\' ORDER BY Name ASC LIMIT 2000');
            cuentasPaginaActual = database.query('SELECT name, bi_estado__c, OwnerId, Owner.name, Ir_a_4Planning__c,(select id, conocimiento_de_la_cuenta__c, Vencimiento_Servicios_Moviles__c, Vencimiento_Otros_Servicios__c, Porcentaje_de_completitud_de_la_cuenta__c, Vencimiento_Datos_Fijos__c, Fecha_Evento__c, Evento_telefonica_cliente__c from FourPlannings__r limit 1) FROM Account where OwnerId IN: usuariosDebajoDeLaJerarquia AND bi_segment__c = \'Empresas\' ORDER BY Name ASC LIMIT 10');
        }else{
            
            cuentasTotales = [SELECT name, Ir_a_4Planning__c,  OwnerId, Owner.name,
                              (select id, conocimiento_de_la_cuenta__c, Vencimiento_Servicios_Moviles__c, Vencimiento_Otros_Servicios__c, Porcentaje_de_completitud_de_la_cuenta__c,
                               Vencimiento_Datos_Fijos__c, Fecha_Evento__c, Evento_telefonica_cliente__c
                               from FourPlannings__r limit 1) 
                              FROM Account where OwnerId IN: usuariosDebajoDeLaJerarquia 
                              ORDER BY Name ASC
                              LIMIT 2000 ];
            
            cuentasPaginaActual = [SELECT name, Ir_a_4Planning__c,  OwnerId, Owner.name,
                                   (select id, conocimiento_de_la_cuenta__c, Vencimiento_Servicios_Moviles__c, Vencimiento_Otros_Servicios__c, Porcentaje_de_completitud_de_la_cuenta__c,
                                    Vencimiento_Datos_Fijos__c, Fecha_Evento__c, Evento_telefonica_cliente__c
                                    from FourPlannings__r limit 1) 
                                   FROM Account where OwnerId IN: usuariosDebajoDeLaJerarquia 
                                   ORDER BY Name ASC
                                   LIMIT 10 ];
        }
        
               
        
        /*List<Account> cuentasParaElStrandarController = [select name, Ir_a_4Planning__c,  OwnerId FROM Account where OwnerId IN: usuariosDebajoDeLaJerarquia 
                                                         ORDER BY LastModifiedDate DESC
                                                         LIMIT 2000];*/
            
        setCuentas = new ApexPages.StandardSetController(cuentasPaginaActual);
        setCuentas.setPageSize(10);

        promedioCoeDesarrollo = 0;
        promedioCompletitud = 0;
        promedioCuentasConFourPlanning = 0;
        obtenerPromedios(cuentasTotales);
        
        miJson = '';
        
        List<Filtros_principales_4Planning__c> filtros = [select id, filtro2Parametro__c, filtro3Parametro__c, filtro4Parametro__c, filtro2Operacion__c,
                                                          filtro3Operacion__c, filtro4Operacion__c, filtro1Valor__c, filtro2Valor__c, filtro3Valor__c,
                                                          filtro4Valor__c, conectorLogico1__c, conectorLogico2__c, conectorLogico3__c, altura_zona_objetivo_maxima__c,
                                                          altura_zona_objetivo_minima__c, Zona_Objetivo_valor_1_eje_x__c, Zona_Objetivo_valor_2_eje_x__c, Moneda_Grafico_Esferas__c,
                                                          Sector__c, Sub_sector__c, UsuarioFiltro__c 
                                                          from Filtros_principales_4Planning__c 
                                                          where OwnerId =: miId
                                                          Limit 1];
        
        if(filtros.size()>0){
            filtro = filtros[0];
            asignarValoresALosFiltros();
            filtrarSinGuardar();
        }else{
            filtro = new Filtros_principales_4Planning__c();
            generarBolasPorTrimestre(cuentasTotales);
        }
		
        alturaNombre = 0;
        if(filtro.altura_zona_objetivo_maxima__c == null){
            filtro.altura_zona_objetivo_maxima__c = 0;
        }else{
            alturaNombre = filtro.altura_zona_objetivo_maxima__c*VALOR_QUE_MULTIPLICA_PARA_DEFINIR_LA_ALTURA_DEL_NOMBRE_DE_ZONA_OBJETIVO;
        }
        
        if(filtro.altura_zona_objetivo_minima__c == null){
            filtro.altura_zona_objetivo_minima__c = 0;
        }
        if(filtro.Zona_Objetivo_valor_1_eje_x__c == null){
            filtro.Zona_Objetivo_valor_1_eje_x__c = 0;
        }
        if(filtro.Zona_Objetivo_valor_2_eje_x__c == null){
            filtro.Zona_Objetivo_valor_2_eje_x__c = 0;
        }
		
    }
    
    public PageReference filtrar(){
        numeroDePagina = 1;
        filtrarSinGuardar();
        guardarFiltros();
        return null;
    }
    
    public void asignarValoresALosFiltros(){
        
        if(filtro.filtro2Parametro__c == null){
            filtro2Parametro = 'ninguno';
        }else{
            filtro2Parametro = filtro.filtro2Parametro__c;
        }
        
        if(filtro.filtro3Parametro__c == null){
            filtro3Parametro = 'ninguno';
        }else{
            filtro3Parametro = filtro.filtro3Parametro__c;
        }
        
        if(filtro.filtro4Parametro__c == null){
            filtro4Parametro = 'ninguno';
        }else{
            filtro4Parametro = filtro.filtro4Parametro__c;
        }
        
        if(filtro.filtro2Operacion__c == null){
            filtro2Operacion = 'ninguno';
        }else{
            filtro2Operacion = filtro.filtro2Operacion__c;
        }
        
        if(filtro.filtro3Operacion__c == null){
            filtro3Operacion = 'ninguno';
        }else{
            filtro3Operacion = filtro.filtro3Operacion__c;
        }
        
        if(filtro.filtro4Operacion__c == null){
            filtro4Operacion = 'ninguno';
        }else{
            filtro4Operacion = filtro.filtro4Operacion__c;
        }

        if(filtro.filtro1Valor__c != null){
            filtro1Valor = filtro.filtro1Valor__c;
        }else{
            filtro1Valor = 'ninguno';
        }
        
        if(filtro.filtro2Valor__c != null){
            filtro2Valor = filtro.filtro2Valor__c;
        }
        
        if(filtro.filtro3Valor__c != null){
            filtro3Valor = filtro.filtro3Valor__c;
        }
        
        if(filtro.filtro4Valor__c != null){
            filtro4Valor = filtro.filtro4Valor__c;
        }
        
        if(filtro.conectorLogico1__c == null){
            conectorLogico1 = 'AND';
        }else{
            conectorLogico1 = filtro.conectorLogico1__c;
        }
        
        if(filtro.conectorLogico2__c == null){
            conectorLogico2 = 'AND';
        }else{
            conectorLogico2 = filtro.conectorLogico2__c;
        }
        
        if(filtro.conectorLogico3__c == null){
            conectorLogico3 = 'AND';
        }else{
            conectorLogico3 = filtro.conectorLogico3__c;
        } 
    }

    public void guardarFiltros(){
        
        filtro.filtro2Parametro__c = filtro2Parametro;
        filtro.filtro3Parametro__c = filtro3Parametro;
        filtro.filtro4Parametro__c = filtro4Parametro;
        
        filtro.filtro2Operacion__c = filtro2Operacion;
        filtro.filtro3Operacion__c = filtro3Operacion;
        filtro.filtro4Operacion__c = filtro4Operacion;
        
        filtro.filtro1Valor__c = filtro1Valor;
        filtro.filtro2Valor__c = filtro2Valor;
        filtro.filtro3Valor__c = filtro3Valor;
        filtro.filtro4Valor__c = filtro4Valor;
        
        filtro.conectorLogico1__c = conectorLogico1;
        filtro.conectorLogico2__c = conectorLogico2;
        filtro.conectorLogico3__c = conectorLogico3;
            
        upsert filtro;
    }   
    
    public List<Account> filtrarUnicamenteLasCuentasYEventosDelTimeLine(){
        cuentas = new List<Account>();
        String filtroQuery = ' Where Id != null';
        String filtroSubQuery = ' Id != null AND';
        
        //String query = 'SELECT name, Ir_a_4Planning__c, (select id, conocimiento_de_la_cuenta__c, Porcentaje_de_completitud_de_la_cuenta__c from FourPlannings__r) FROM Account WHERE Id != null';
        
        //filtro 1 -- posee 4planning.
        if(filtro1Valor == 'true'){
            filtroQuery += ' AND ID IN (select cuenta__c from FourPlanning__c where id != null AND Porcentaje_de_completitud_de_la_cuenta__c != null AND Porcentaje_de_completitud_de_la_cuenta__c > 0';
        }
        
        //filtro 2
        boolean anteriorConectorEsOr = false;
        if(filtro2Parametro != 'ninguno' && filtro2Operacion != 'ninguno' && filtro2Valor != null){
            if(conectorLogico2 == 'OR'){
                if(filtro2Operacion == '<' || filtro2Operacion == '<='){
                    filtroSubQuery += ' ( ('+filtro2Parametro+' '+filtro2Operacion+' '+filtro2Valor+' '+' OR '+ filtro2Parametro +' = null'+')'+conectorLogico2;
                }else{
                    filtroSubQuery += ' ('+filtro2Parametro+' '+filtro2Operacion+' '+filtro2Valor+' '+conectorLogico2;
                }
                anteriorConectorEsOr = true;
            }else{
                if(filtro2Operacion == '<' || filtro2Operacion == '<='){
                    filtroSubQuery += ' ('+filtro2Parametro+' '+filtro2Operacion+' '+filtro2Valor+'  OR '+filtro2Parametro+' = null)'+conectorLogico2;
                }else{
                    filtroSubQuery += ' '+filtro2Parametro+' '+filtro2Operacion+' '+filtro2Valor+' '+conectorLogico2;
                }
            }
        }
        
        //filtro 3
        if(filtro3Parametro != 'ninguno' && filtro3Operacion != 'ninguno' && filtro3Valor != null){
            if(conectorLogico3 == 'OR'){
                if(anteriorConectorEsOr){
                    if(filtro2Operacion == '<' || filtro2Operacion == '<='){
                        filtroSubQuery += '('+filtro3Parametro+' '+filtro3Operacion+' '+filtro3Valor+' OR '+filtro3Parametro+' = NULL) '+conectorLogico3;
                    }else{
                        filtroSubQuery += ' '+filtro3Parametro+' '+filtro3Operacion+' '+filtro3Valor+' '+conectorLogico3;
                    }
                }else{
                    if(filtro2Operacion == '<' || filtro2Operacion == '<='){
                        filtroSubQuery += ' ( ('+filtro3Parametro+' '+filtro3Operacion+' '+filtro3Valor+' OR '+filtro3Parametro+' = NULL) '+conectorLogico3;
                    }else{
                        filtroSubQuery += ' ('+filtro3Parametro+' '+filtro3Operacion+' '+filtro3Valor+' '+conectorLogico3;
                    }
                    anteriorConectorEsOr = true;
                }
            }else{
                if(anteriorConectorEsOr){
                    if(filtro2Operacion == '<' || filtro2Operacion == '<='){
                        filtroSubQuery += ' ('+filtro3Parametro+' '+filtro3Operacion+' '+filtro3Valor+' OR '+filtro3Parametro+' = NULL) ) '+conectorLogico3;
                    }else{
                        filtroSubQuery += ' '+filtro3Parametro+' '+filtro3Operacion+' '+filtro3Valor+') '+conectorLogico3;
                    }
                    anteriorConectorEsOr = false;
                }else{
                    if(filtro2Operacion == '<' || filtro2Operacion == '<='){
                        filtroSubQuery += ' ('+filtro3Parametro+' '+filtro3Operacion+' '+filtro3Valor+' OR '+filtro3Parametro+' = NULL) '+conectorLogico3;
                    }else{
                        filtroSubQuery += ' '+filtro3Parametro+' '+filtro3Operacion+' '+filtro3Valor+' '+conectorLogico3;
                    }
                }  
            }
        }
        
        //filtro 4
        if(filtro4Parametro != 'ninguno' && filtro4Operacion != 'ninguno' && filtro4Valor != null){
            
            if(anteriorConectorEsOr){
                if(filtro2Operacion == '<' || filtro2Operacion == '<='){
                    filtroSubQuery += ' ('+filtro4Parametro+' '+filtro4Operacion+' '+filtro4Valor+' OR '+filtro4Parametro+' = NULL) )';
                }else{
                    filtroSubQuery += ' '+filtro4Parametro+' '+filtro4Operacion+' '+filtro4Valor+') ';
                }
            }else{
                if(filtro2Operacion == '<' || filtro2Operacion == '<='){
                    filtroSubQuery += ' ('+filtro4Parametro+' '+filtro4Operacion+' '+filtro4Valor+' OR '+filtro4Parametro+' = NULL) ';
                }else{
                    filtroSubQuery += ' '+filtro4Parametro+' '+filtro4Operacion+' '+filtro4Valor;
                }
            }
            
        }
        
        
        //si el filtro de la subquery termina con un and o con un or se lo saco.
        system.debug(filtroSubQuery);
        if(filtroSubQuery.endsWithIgnoreCase('AND')){
            filtroSubQuery = filtroSubQuery.removeEndIgnoreCase('AND');
        }else{
            if(filtroSubQuery.endsWithIgnoreCase('OR')){
                filtroSubQuery = filtroSubQuery.removeEndIgnoreCase('OR');
                filtroSubQuery += ') ';
            }
        }
        
        
        //armo la query
        String InicioQuery = 'SELECT name, Ir_a_4Planning__c, Owner.name, (select id, FourPlanning_Area_1__c, FourPlanning_Area_2__c, FourPlanning_Area_3__c, FourPlanning_Area_4__c, FourPlanning_Area_5__c, conocimiento_de_la_cuenta__c, Porcentaje_de_completitud_de_la_cuenta__c, Vencimiento_Servicios_Moviles__c, Vencimiento_Otros_Servicios__c,Vencimiento_Datos_Fijos__c, Fecha_Evento__c, Evento_telefonica_cliente__c from FourPlannings__r limit 1) FROM Account';
        String query = '';
        system.debug(filtro1Valor);
        system.debug(filtroQuery);
        system.debug(filtroSubQuery);
        
        Set <Id> idDeUsuarios = new Set<Id>();
        
        For(UsuarioWrapper usr:wrapperUsuarios){
            if(usr.seleccionado){
            idDeUsuarios.add(usr.usuario);
            }

        }
        
        system.debug(idDeUsuarios);
        system.debug(usuariosABuscar);
        
        if(idDeUsuarios.size() == 0 && usuariosABuscar.size() > 0){
            idDeUsuarios = usuariosABuscar;
        }
        //Aca el primer valor es true si eligio con fourplanning
        
        if(filtro1Valor == 'true'){
            query += filtroQuery+' AND'+filtroSubQuery+') ';
        }else{
            //si eligio sin fourPlanning, no hay where. 
            if(filtro1Valor == 'false'){
                query +=  ' WHERE ID NOT IN (select cuenta__c from FourPlanning__c) ';   
            }else{
                query += ' WHERE id != null ';
            }
        } 
        
        if(idDeUsuarios.size()>0){
            query += 'AND OwnerId =: idDeUsuarios '; 
        }
        
        if(!String.isBlank(filtroDeNombre)){
            query += ' AND name LIKE \''+'%'+filtroDeNombre+'%\' ';     
        }
        
        Set<String> objectFields = Schema.SObjectType.Account.fields.getMap().keySet();
        if( objectFields.contains('bi_segment__c') ) {
            query += ' AND bi_segment__c = \'Empresas\' ';
        }
        
        //Filtrar por sector y sub sector.
        if(filtro.Sector__c != null && filtro.Sector__c != 'Todos'){
            query += ' AND Industry = \''+filtro.Sector__c+'\' ';
            if(filtro.Sub_sector__c != null && filtro.Sub_sector__c != 'Todos'){
                query += ' AND Micro_Industry__c = \''+filtro.Sub_sector__c+'\' ';
            }
        } 
        
        query += 'ORDER BY Name ASC ';
        String queryLimite ='LIMIT 2000 ';
        
        system.debug(InicioQuery);
        system.debug(query);
        system.debug(queryLimite);
        
        
        cuentas = Database.query(InicioQuery+query+queryLimite);
        
        if(cuentas.size()>0){
            obtenerSoloLosPrimerosDosPromedios(cuentas);
        }
        
        
        String queryLimitePaginaActual = 'LIMIT 10 OFFSET '+(numeroDePagina*10-10);
        List<Account> cuentasPaginaActual = Database.query(InicioQuery+query+queryLimitePaginaActual);
        setCuentas = new ApexPages.StandardSetController(cuentasPaginaActual);
        setCuentas.setPageSize(10);
        
        
        if(cuentas.size()>0){
            generarJsonLineaDeTiempo(setCuentas.getRecords());
            
            paginasTotales = cuentas.size()/10;
            
            if(math.mod(cuentas.size(), 10)>0){
                paginasTotales += 1;
            }
            
        }else{
            mostrarLineaDeTiempo = false;

        }
        
        system.debug(miJson);
        system.debug(query);
        system.debug(setCuentas.getRecords());
        
        return cuentas;
    }
    
    public void filtrarSinGuardar(){
        
        List<Account> cuentas = filtrarUnicamenteLasCuentasYEventosDelTimeLine();
        
        if(cuentas.size()>0){
            generarBolasPorTrimestre(cuentas);
        }else{
            mostrarEsferas = false;
        }
        
    }
    
    public void establecerValoresDeLaLineaDeTiempo(){
        filtrarUnicamenteLasCuentasYEventosDelTimeLine();
        //generarJsonLineaDeTiempo(setCuentas.getRecords());
        
        system.debug(miJson);
    }
    
    public PageReference irAGuiaDeUso() {
        
        String url = Page.guiaDeUso.getURL();
        return new PageReference (url);
    }
    
    public PageReference irACobertura(){
        String url = Page.graficosCartera.getURL();
        return new PageReference (url);
    }
    
    public PageReference irAVencimientos(){
        String url = Page.vencimientosGlobales.getURL();
        return new PageReference (url);
    }
    
    public void obtenerPrimerPagina(){
        numeroDePagina = 1; 
    }
    
    public void obtenerUltimaPagina(){
        numeroDePagina = paginasTotales;
    }
    
    public void obtenerSiguiente(){
        
        numeroDePagina += 1; 
       
    }
    
    public void obtenerAnterior(){
        if(numeroDePagina>1){
			numeroDePagina = numeroDePagina-1;
        }
    }
    
    public List<Account> getCuentasSetController(){
          return (List<Account>) setCuentas.getRecords();  
    }

    public void generarJsonLineaDeTiempo(List<Account> Setcuentas){
        
        miJson = '';
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        List<String> eventos = new List<String>();
        
        List<Id> idsCuentas = new List<Id>();
        List<Id> idsFourPlanning = new List<Id>();
        for(Account cuenta: Setcuentas){
            idsCuentas.add(cuenta.id);
            
            if(cuenta.FourPlannings__r.size()>0){
                idsFourPlanning.add(cuenta.FourPlannings__r[0].id);
            }
        }
        
        for(FourPlanning__c fPlanning: [select id, cuenta__r.name, (select Id, Fecha__c, Descripcion__c, Categoria__c FROM FourPlanning_Hitos__r) from FourPlanning__c where cuenta__c In: idsCuentas]){
            
            List<FourPlanning_Hito__c> hitos = fPlanning.FourPlanning_Hitos__r;
            if(hitos == null){
                hitos = new List<FourPlanning_Hito__c>();
            }

            if(hitos.size() > 0){
                
                String datosHitos = generarDatosHitos(hitos, fPlanning.cuenta__r.name);
                if(datosHitos != ''){
                    eventos.add(datosHitos);
                }
            }            
        }
        
		List<FourPlanning_Area__c> areasDeLosIdsFourPlannings = [select id from FourPlanning_Area__c where fourPlanning__c In: idsFourPlanning];
        List<Id> idsAreas = new List<Id>();
        
        for(FourPlanning_Area__c area: areasDeLosIdsFourPlannings){
            idsAreas.add(area.id);
        }
        
        //me traigo todo los retos.
        List<FourPlanning_Reto__c> retos = [select Id, FourPlanning_Area__r.fourPlanning__r.cuenta__r.name, Fecha_Compromiso__c, Nombre_del_Reto__c, Nota__c 
                                            from FourPlanning_Reto__c 
                                            where FourPlanning_Area__c in: idsAreas ];
        
        if(retos.size() > 0 ){
            
            String datosRetos = generarDatosRetos(retos);
            if(datosRetos!= ''){
                eventos.add(datosRetos);
            }
        }
        
        for(Account cuenta: Setcuentas){
            if(cuenta.fourPlannings__r.size() > 0){

                String datosFourPlanning = generarDatosFourPlanning(Cuenta);
                if(datosFourPlanning != '' && datosFourPlanning != null){
                    eventos.add(datosFourPlanning);
                }
                
            }
        }
        
        
        
        String eventosConcatenados = concatenarDatos(eventos);
        mostrarLineaDeTiempo = true;
        
        /*
        if(eventosConcatenados != '' && eventosConcatenados != null){
            mostrarLineaDeTiempo = true;
            
            filtroVencimiento = true;
            filtroEventoTelefonica = true;
            filtroEventosDeTipoReto = true;
            filtroVencimientoCompetencia = true;
            filtroPublicacionRFPComunicacion = true;
            filtroPublicacionRFPTI = true;
            filtroEventoIndustria = true;
            filtroOtroTipoDeEvento = true;
            
            todos = true;
        }*/
        
        miJson = cabecera + concatenarDatos(eventos) + ']}';
    }
    
    public String generarDatosFourPlanning(Account cuenta){
        
        List<String> eventos = new List<String>();
        
        String serviciosMoviles = '';
        if(cuenta.fourPlannings__r[0].Vencimiento_Servicios_Moviles__c != null){
            
            String titulo = Label.Vencimiento;
            
            String descripcion = '';
            if(cuenta.name != null){
                descripcion = '<b>'+cuenta.name+'<b/>';
            }
            
            descripcion += '<p>Fecha de vencimiento de contrato de servicios móviles</p>';
            
            serviciosMoviles = generarDatosDeFecha(cuenta.fourPlannings__r[0].Vencimiento_Servicios_Moviles__c, titulo , descripcion);
            
            if(filtroVencimiento){
                eventos.add(serviciosMoviles);
            }

        }
        
        String otrosServicios = '';
        if(cuenta.fourPlannings__r[0].Vencimiento_Otros_Servicios__c != null){
            
            String titulo = Label.Vencimiento;
            
            String descripcion = '';
            if(cuenta.name != null){
                descripcion = '<b>'+cuenta.name+'<b/>';
            }
            
            descripcion += '<p>Fecha de vencimiento de contratos de otros servicios</p>';
            
            otrosServicios = generarDatosDeFecha(cuenta.fourPlannings__r[0].Vencimiento_Otros_Servicios__c, titulo, descripcion);
            
            if(filtroVencimiento){
                eventos.add(otrosServicios);
            }
        }
        
        String datosFijos = '';
        if(cuenta.fourPlannings__r[0].Vencimiento_Datos_Fijos__c != null){
            
            String titulo = Label.Vencimiento;
            
            String descripcion = '';
            if(cuenta.name != null){
                descripcion = '<b>'+cuenta.name+'<b/>';
            }
            
            descripcion += '<p>Fecha de Vencimiento de contratos de datos fijos</p>';
            
            datosFijos = generarDatosDeFecha(cuenta.fourPlannings__r[0].Vencimiento_Datos_Fijos__c, titulo, descripcion);
            
            if(filtroVencimiento){
                eventos.add(datosFijos);
            }
        }
        
        String evento = '';
        if(cuenta.fourPlannings__r[0].Fecha_Evento__c != null){
            
            String titulo = Label.Evento_Telef_nica;
            
            String descripcion = '';
            if(cuenta.name != null){
                descripcion = '<b>'+cuenta.name+'<b/>';
            }
            
            if(cuenta.fourPlannings__r[0].Evento_telefonica_cliente__c != null){
                descripcion += '<p>'+cuenta.fourPlannings__r[0].Evento_telefonica_cliente__c+'</p>';
            }
            
            evento = generarDatosDeFecha(cuenta.fourPlannings__r[0].Fecha_Evento__c, titulo, descripcion);
            
            if(filtroEventoTelefonica){
                eventos.add(evento);
            }

        }
        
        String retorno = concatenarDatos(eventos);
        //system.debug(retorno);
        return retorno;
    }
    
    public String generarDatosRetos(List<FourPlanning_Reto__c> retos){
        
        List<String> eventos = new List<String>();
        for(FourPlanning_Reto__c reto: retos){
            
            if(reto.Fecha_Compromiso__c != null){
                String titulo = Label.reto;
                String descripcion = '';
                
                if(reto.FourPlanning_Area__r.fourPlanning__r.cuenta__r.name != null){
                    descripcion += '<b>'+reto.FourPlanning_Area__r.fourPlanning__r.cuenta__r.name+'<b/>';
                }
                if(reto.Nombre_del_Reto__c != null){
                    descripcion += '<p><b>'+reto.Nombre_del_Reto__c+'</b></p>';
                }
                if(reto.Nota__c != null){
                    descripcion += '<p>'+reto.Nota__c.escapeJava()+'</p>';
                }
                
                String dato = generarDatosDeFecha(reto.Fecha_Compromiso__c, titulo, descripcion);
                
                if(filtroEventosDeTipoReto){
                    eventos.add(dato);
                }

            }
        }
        
        String retorno = concatenarDatos(eventos);
        //System.debug(retorno);        
        return retorno;
    }
    
    public String generarDatosHitos(List<FourPlanning_Hito__c> hitos, String cuenta){
        
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
                
                if(cuenta != null){
                    descripcion = '<b>'+cuenta+'<b/>';
                }
                if(hito.Descripcion__c != null){
                    descripcion += '<p>'+hito.Descripcion__c.escapeJava()+'</p>';
                }
                
                
                String dato = generarDatosDeFecha(hito.Fecha__c, titulo, descripcion);
                
                
                Boolean aniadidoAUnaCategoria = false;
                if(hito.categoria__c != null){
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con Telefónica')){
						
                        if(filtroVencimiento){
                            eventos.add(dato);
                        }
 
                        aniadidoAUnaCategoria = true;
                        
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Reto')){
						if(filtroEventosDeTipoReto){
                            eventos.add(dato);
                        }
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Vencimiento Contrato Activo con la Competencia')){
						
                        if(filtroVencimientoCompetencia){
                            eventos.add(dato);
                        }
                        
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP Comunicaciones')){
						
                        if(filtroPublicacionRFPComunicacion){
                            eventos.add(dato);
                        }
                        
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Publicación RFP TI')){
						
                        if(filtroPublicacionRFPTI){
                            eventos.add(dato);
                        }
                        
                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento para clientes de Telefonica')){
                        
                        if(filtroEventoTelefonica){
                            eventos.add(dato);
                        }

                        aniadidoAUnaCategoria = true;
                    }
                    if(hito.categoria__c.equalsIgnoreCase('Evento Relevante de la industria')){
						
                        if(filtroEventoIndustria){
                            eventos.add(dato);
                        }
                        
                        aniadidoAUnaCategoria = true;
                    }
                }
                
                if(!aniadidoAUnaCategoria){
                    
                    if(filtroOtroTipoDeEvento){
                        eventos.add(dato);
                    }

                }
                
            }
        }
        
        String retorno = concatenarDatos(eventos);
        //system.debug(retorno);        
        return retorno;
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
    
    public String generarDatosDeFecha(Date fecha, String titulo, String descripcion){
        
        String datos = '';
        
        Integer dia = fecha.day();
        Integer mes = fecha.month();
        Integer anio = fecha.year();
        
        datos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"'+titulo+'","text":"'+descripcion+'","tag":"Categoria 1"}}';
        
        return datos;
    }
    
    public PageReference filtrarTimeLine(){

        List<String> eventos = new List<String>();
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        
        if(setCuentas.getRecords().size()>0){ 
			generarJsonLineaDeTiempo(setCuentas.getRecords());
        }
        
        mostrarLineaDeTiempo = false;
        if(miJson != cabecera){
            mostrarLineaDeTiempo = true;
        }
        
        return null;
    }
    
    public void obtenerPromedios(List<Account> cuentasTotales){
        
        Double sumatoriaConocimientoDeLaCuenta = 0;
        Double sumatoriaCompletitud = 0;
        Integer cuentaConFourPlanning = 0;
        promedioCoeDesarrollo = 0;
		promedioCompletitud = 0;
        
        for(Account cuenta:cuentasTotales){
            
            if(cuenta.FourPlannings__r.size() > 0){
                        system.debug(cuenta);
                system.debug(cuenta.fourPlannings__r);
                
                if(cuenta.FourPlannings__r[0].conocimiento_de_la_cuenta__c != null){
                    sumatoriaConocimientoDeLaCuenta = sumatoriaConocimientoDeLaCuenta + cuenta.FourPlannings__r[0].conocimiento_de_la_cuenta__c;
                }
                
                if(cuenta.FourPlannings__r[0].Porcentaje_de_completitud_de_la_cuenta__c != null){
                    sumatoriaCompletitud = sumatoriaCompletitud + cuenta.FourPlannings__r[0].Porcentaje_de_completitud_de_la_cuenta__c;
                }
                
				cuentaConFourPlanning = cuentaConFourPlanning +1;
            
            }
         }
        
        if(sumatoriaConocimientoDeLaCuenta != 0 ){
            promedioCoeDesarrollo = (sumatoriaConocimientoDeLaCuenta/cuentasTotales.size());
            promedioCoeDesarrollo = promedioCoeDesarrollo.setscale(2);
        }
        system.debug(cuentasTotales.size());
        system.debug(promedioCoeDesarrollo);
        
        if(sumatoriaCompletitud != 0 ){
            promedioCompletitud = sumatoriaCompletitud/cuentasTotales.size();
            promedioCompletitud = promedioCompletitud.setscale(2);
        }

        system.debug(cuentaConFourPlanning);
        if(cuentaConFourPlanning > 0){
            
            promedioCuentasConFourPlanning = (cuentaConFourPlanning*100)/cuentasTotales.size();
            promedioCuentasConFourPlanning = promedioCuentasConFourPlanning.setscale(2);
        }
    }
    
    public void obtenerSoloLosPrimerosDosPromedios(List<Account> cuentasTotales){

        Double sumatoriaConocimientoDeLaCuenta = 0;
        Double sumatoriaCompletitud = 0;
        Integer cuentaConFourPlanning = 0;
        promedioCoeDesarrollo = 0;
        promedioCompletitud = 0;
        
        for(Account cuenta:cuentasTotales){
            
            if(cuenta.FourPlannings__r.size() > 0){
                system.debug(cuenta);
                system.debug(cuenta.fourPlannings__r);
                
                if(cuenta.FourPlannings__r[0].conocimiento_de_la_cuenta__c != null){
                    sumatoriaConocimientoDeLaCuenta = sumatoriaConocimientoDeLaCuenta + cuenta.FourPlannings__r[0].conocimiento_de_la_cuenta__c;
                }
                
                if(cuenta.FourPlannings__r[0].Porcentaje_de_completitud_de_la_cuenta__c != null){
                    sumatoriaCompletitud = sumatoriaCompletitud + cuenta.FourPlannings__r[0].Porcentaje_de_completitud_de_la_cuenta__c;
                }
                
                cuentaConFourPlanning = cuentaConFourPlanning +1;
            }
        }
        
        if(sumatoriaConocimientoDeLaCuenta != 0 ){
            promedioCoeDesarrollo = (sumatoriaConocimientoDeLaCuenta/cuentasTotales.size());
            promedioCoeDesarrollo = promedioCoeDesarrollo.setscale(2);
        }
        system.debug(cuentasTotales.size());
        system.debug(promedioCoeDesarrollo);
        
        if(sumatoriaCompletitud != 0 ){
            promedioCompletitud = sumatoriaCompletitud/cuentasTotales.size();
            promedioCompletitud = promedioCompletitud.setscale(2);
        }
        system.debug(promedioCompletitud);
    }
    // Desarrollo Cuenta ========================================
    
    public void generarBolasPorTrimestre(List<Account> cuentasTotales){
        
        //veo en que trimestre del año estoy.
        Date hoy = Date.today();
        Integer mesActual = hoy.month();
        String queryTrimestreActual = '';
        
        //Genero la fecha de inicio del trimestre mas cercano a la fecha de hoy.
        if(mesActual >= 7){
            if(mesActual >= 10){
                //Cuarto trimestre, del 1-10 al 31-12
                obtenerBolasDeLosTrimestresAnterioresYActual(date.newInstance(hoy.year(), 10, 1), cuentasTotales);        
            }else{
                //Tercer trimestre, del 1-7 al 30-9
                obtenerBolasDeLosTrimestresAnterioresYActual(date.newInstance(hoy.year(), 7, 1), cuentasTotales);   
            }
        }else{
            if(mesActual >= 4){
                //Segundo trimestre, del 1-4 al 30-6 
                obtenerBolasDeLosTrimestresAnterioresYActual(date.newInstance(hoy.year(), 4, 1), cuentasTotales);
            }else{
                //Primer trimestre, del 1-1 al 31-3
                obtenerBolasDeLosTrimestresAnterioresYActual(date.newInstance(hoy.year(), 1, 1), cuentasTotales);
            }
        }   
    }
    
    
    public void enviarMail(){
        
        
        // Define the email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
        
        String subject = 'Reporte de Incidencia 4Planning';
        String body = cuerpoDeMail;
        List<String> direcciones = new List<String>();
        
        direcciones.add('dinamizacion.comercial.businesssolutions@telefonica.com');     
        
        
        String reply = mailUsuario;
        String senderDisplay = nombreUsuario;
        
        // Sets the paramaters of the email
        email.setSubject( subject );
        email.setToAddresses( direcciones );
        email.setPlainTextBody( body );
        email.setReplyTo(reply);
        email.setSenderDisplayName(senderDisplay);
        
        system.debug(email);
        
        // Sends the email
        if(direcciones.size() >0){
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
            system.debug(r);
        }
        
        
        String cuerpoDeMail;
        
    }
    
    
    
    
    public void obtenerBolasDeLosTrimestresAnterioresYActual(Date trimestreActual, List<Account> cuentasABuscar){
        
        
        String entre1 = '';
        String entre2 = '';
        String entre3 = '';
        
        Date hoy = Date.today();
        
        String queryTrimestreActual = 'IsClosed = false limit 200';
        
        system.debug(trimestreActual);
        
        Date fechaPrimerQ = trimestreActual.addMonths(-9);
        system.debug(fechaPrimerQ);
        Date fechaSegundoQ = trimestreActual.addMonths(-6);
        Date fechaTercerQ = trimestreActual.addMonths(-3);
        
        oportunidadesUltimoQ = new List<Opportunity>();
        oportunidadesTercerQ = new List<Opportunity>();
        oportunidadesSegundoQ = new List<Opportunity>();
        oportunidadesPrimerQ = new List<Opportunity>();
        
        List<Opportunity> oportunidadesFunnelUltimoQ = new List<Opportunity>();


		List<Id> idsABuscar = new List<Id>();
            
        for(Account cuenta: cuentasABuscar){
            idsABuscar.add(cuenta.id);
        }
        
        system.debug(idsABuscar.size());
        
        Boolean existenLosCamposDeTelefonica = false;
        Set<String> objectFields = Schema.SObjectType.Opportunity.fields.getMap().keySet();
        if(objectFields.contains('bi_net_annual_value_nav__c') && objectFields.contains('bi_probabilidad_de_exito__c')) {

            //tengo que traer todas las oportunidades abiertas para esas fechas
            //son las oportunidades que estan abiertas ahora y se crearon despues de la fecha de inicio de ese trimestre 
            //y las oportunidades que estan cerradas despues de que termino el trimestre y se crearon antes de que termine ese trimestre
            
            //Actualizacion 04/01/2017.
            //Se toman unicamente las oportunidades cerradas ganadas, con fecha de cierre dentro del 1re dia del trimestre hasta el ultimo dia del trimestre.
            
            //oportunidadesPrimerQ = DataBase.query('SELECT id, name, currencyisocode, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId IN: idsABuscar AND ((IsClosed = true AND closeDate >=: fechaSegundoQ AND createdDate <=: fechaSegundoQ) OR (IsClosed = false AND createdDate <=: fechaPrimerQ)) AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            oportunidadesPrimerQ = DataBase.query('SELECT id, name, currencyisocode, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsWon = true AND closeDate >=: fechaPrimerQ AND closeDate <: fechaSegundoQ AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            
            //oportunidadesSegundoQ = DataBase.query('SELECT id, name, currencyisocode, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId IN: idsABuscar AND ((IsClosed = true AND closeDate >=: fechaTercerQ AND createdDate <=: fechaTercerQ) OR (IsClosed = false AND createdDate <=: fechaSegundoQ)) AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            oportunidadesSegundoQ = DataBase.query('SELECT id, name, currencyisocode, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsWon = true AND closeDate >=: fechaSegundoQ AND closeDate <: fechaTercerQ AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            
            //Si son del mismo año natural se suman, si no no. Las fechas son las que terminan los trimestres, el ultimo trimestre de un año x va a ser el 1/1/(x+1). ejemplo ultima de 2016 = 1/1/2017 por eso tiene que ser el mes distinto de 1.
            if(  fechaPrimerQ.year() == fechaSegundoQ.year()  ){
                system.debug('aca voy a entrar');
                oportunidadesSegundoQ.addAll(oportunidadesPrimerQ);
            }
            
            //oportunidadesTercerQ = DataBase.query('SELECT id, name, currencyisocode, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId IN: idsABuscar AND ((IsClosed = true AND closeDate >=: trimestreActual AND createdDate <=: trimestreActual) OR (IsClosed = false AND createdDate <=: fechaTercerQ)) AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            oportunidadesTercerQ = DataBase.query('SELECT id, name, currencyisocode, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsWon = true AND closeDate >=: fechaTercerQ AND closeDate <: trimestreActual AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            
            if( fechaSegundoQ.year() == fechaTercerQ.year()  ){
                system.debug('no tenes que entrar aca hoy que es 24/04');
                oportunidadesTercerQ.addAll(oportunidadesSegundoQ);
            }
            
            //oportunidadesUltimoQ = DataBase.query('SELECT id, name, currencyisocode, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsClosed = false AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            oportunidadesUltimoQ = DataBase.query('SELECT id, name, currencyisocode, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsWon = true AND closeDate >=: trimestreActual AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            oportunidadesFunnelUltimoQ = DataBase.query('SELECT id, bi_nav_ponderado__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsClosed = false AND bi_nav_ponderado__c != NULL ORDER BY bi_nav_ponderado__c DESC limit 200');
            
            if( fechaTercerQ.year() == hoy.year()  ){
                system.debug('aca voy a entrar'); 
                oportunidadesUltimoQ.addAll(oportunidadesTercerQ);
            }
            
            existenLosCamposDeTelefonica = true;
        }else{
            
            //Si no existen los campos de telefonica (Por que este codigo no se esta ejecutando en su entorno), traigo 2 campos creados que cumplen la misma funcion pero estan dentro del paquete.
            
            
            system.debug(queryTrimestreActual);
            //tengo que traer todas las oportunidades abiertas para esas fechas
            //son las oportunidades que estan abiertas ahora y se crearon despues de la fecha de inicio de ese trimestre 
            //y las oportunidades que estan cerradas despues de que termino el trimestre y se crearon antes de que termine ese trimestre
            
            oportunidadesPrimerQ = DataBase.query('SELECT id, name, certa_scp__nav_certa__c, certa_scp__probabilidad_de_exito_certa__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsWon = true AND closeDate >=: fechaPrimerQ AND closeDate <: fechaSegundoQ AND certa_scp__nav_certa__c != NULL ORDER BY certa_scp__nav_certa__c DESC limit 200');
            
            oportunidadesSegundoQ = DataBase.query('SELECT id, name,  certa_scp__nav_certa__c, certa_scp__probabilidad_de_exito_certa__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsWon = true AND closeDate >=: fechaSegundoQ AND closeDate <: fechaTercerQ AND certa_scp__nav_certa__c != NULL ORDER BY certa_scp__nav_certa__c DESC limit 200');
            
            if(  fechaPrimerQ.year() == fechaSegundoQ.year()  ){
                entre1 = 'entro 1';
                oportunidadesSegundoQ.addAll(oportunidadesPrimerQ);
            }
            
            oportunidadesTercerQ = DataBase.query('SELECT id, name, certa_scp__nav_certa__c, certa_scp__probabilidad_de_exito_certa__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsWon = true AND closeDate >=: fechaTercerQ AND closeDate <: trimestreActual AND certa_scp__nav_certa__c != NULL ORDER BY certa_scp__nav_certa__c DESC limit 200');
            
            if( fechaSegundoQ.year() == fechaTercerQ.year()  ){
                entre2 = 'entro 2';
                oportunidadesTercerQ.addAll(oportunidadesSegundoQ);
            }
            
            oportunidadesUltimoQ = DataBase.query('SELECT id, name, certa_scp__nav_certa__c, certa_scp__probabilidad_de_exito_certa__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsWon = true AND closeDate >=: trimestreActual AND certa_scp__nav_certa__c != NULL ORDER BY certa_scp__nav_certa__c DESC limit 200');
            oportunidadesFunnelUltimoQ = DataBase.query('SELECT id, name, certa_scp__nav_certa__c, certa_scp__probabilidad_de_exito_certa__c FROM Opportunity WHERE accountId IN: idsABuscar AND IsClosed = false AND certa_scp__nav_certa__c != NULL ORDER BY certa_scp__nav_certa__c DESC limit 200');
            
            if( fechaTercerQ.year() == hoy.year()  ){
                entre3 = 'entro 3';
                oportunidadesUltimoQ.addAll(oportunidadesTercerQ);
            }
            /*
            List<AggregateResult> groupedResults = [SELECT SUM(certa_scp__nav_certa__c) nav
                                                    FROM opportunity
                                                    WHERE accountId IN: idsABuscar AND IsWon = true AND closeDate >=: trimestreActual AND certa_scp__nav_certa__c != NULL];    
                 
            system.debug(groupedResults);
            */
            
            existenLosCamposDeTelefonica = false;
            system.debug('No lo contengo');
        }
        
        system.debug(oportunidadesUltimoQ);
        ultimoQ = crearObjetoBolaPara(oportunidadesUltimoQ, existenLosCamposDeTelefonica, Date.today(), oportunidadesFunnelUltimoQ); 
        system.debug(ultimoQ);
        system.debug(trimestreActual);
        
        system.debug(oportunidadesTercerQ);
        tercerQ = crearObjetoBolaPara(oportunidadesTercerQ, existenLosCamposDeTelefonica, trimestreActual, null); 
        system.debug(tercerQ);
        system.debug(fechaTercerQ);
        
        system.debug(oportunidadesSegundoQ);
        segundoQ = crearObjetoBolaPara(oportunidadesSegundoQ, existenLosCamposDeTelefonica, fechaTercerQ, null);
        system.debug(segundoQ);
        system.debug(fechaSegundoQ);
        
        system.debug(oportunidadesPrimerQ);
        primerQ = crearObjetoBolaPara(oportunidadesPrimerQ, existenLosCamposDeTelefonica, fechaSegundoQ, null);
        system.debug(primerQ);
		system.debug(fechaPrimerQ);
        system.debug(entre1);
        system.debug(entre2);
        system.debug(entre3);
        
        
		generarValoresEnPixelesDelDiametro();
		
		//Sumatoria de valores NAV, solo si pertenecen al mismo año.
		
		system.debug(primerQ.fecha);
		system.debug(segundoQ.fecha);
		system.debug(tercerQ.fecha);
		system.debug(ultimoQ.fecha);
		
	    if( (primerQ.fecha.year() == segundoQ.fecha.year() && primerQ.fecha.month() != 1) || (primerQ.fecha.year() != segundoQ.fecha.year() && segundoQ.fecha.month() == 1) ){
		    segundoQ.ejeY += primerQ.ejeY;
		}
		
		if( (segundoQ.fecha.year() == tercerQ.fecha.year() && segundoQ.fecha.month() != 1) || (segundoQ.fecha.year() != tercerQ.fecha.year() && tercerQ.fecha.month() == 1)){
		    tercerQ.ejeY += segundoQ.ejeY;
		}
		
		if( (tercerQ.fecha.year() == ultimoQ.fecha.year() && tercerQ.fecha.month() != 1) || (tercerQ.fecha.year() != ultimoQ.fecha.year() && ultimoQ.fecha.month() == 1)){
		    ultimoQ.ejeY += tercerQ.ejeY;
		}
    }
    
    public Bola crearObjetoBolaPara(List<Opportunity> oportunidadesDelQ, Boolean existenLosCamposDeTelefonica, Date fechaLimite, List<Opportunity> oportunidadesFunnel){
        
        Double Diametro = 0;
        Double navTotal = 0;
        
        Map<String, decimal> mapaDeValoreCurrency = Util.getCurrencyMap();
        
        for(Opportunity oportunidad :oportunidadesDelQ){
            
            Double nav = 0;
            String probabilidad = '0';
            if(existenLosCamposDeTelefonica){
                
                Decimal valorCurrency = mapaDeValoreCurrency.get((String)oportunidad.get('currencyisocode')); 
                
                Decimal valorCurrencySeleccionado = 1;
                IF(filtro.Moneda_Grafico_Esferas__c != null){
                    valorCurrencySeleccionado = mapaDeValoreCurrency.get(filtro.Moneda_Grafico_Esferas__c);
                    if(valorCurrencySeleccionado == null){
                        valorCurrencySeleccionado = 1;
                    }
                }
                
                if(valorCurrency != 0 && valorCurrency != null){
                    nav = ( (Double)oportunidad.get('bi_net_annual_value_nav__c')/valorCurrency )*valorCurrencySeleccionado;
                }else{
                    nav = (Double)oportunidad.get('bi_net_annual_value_nav__c');
                }
                
                probabilidad = (String)oportunidad.get('bi_probabilidad_de_exito__c');
            }else{
                nav = (Double)oportunidad.get('certa_scp__nav_certa__c');
                system.debug(nav);
                probabilidad = (String)oportunidad.get('certa_scp__probabilidad_de_exito_certa__c');                
            }
            
            if(nav == null){
                nav = 0;    
            }
            
            Double probabilidadNumerica = 0;
            if(probabilidad != null){
                probabilidadNumerica = decimal.valueOf(probabilidad);
            }
            
            Double valorDeLaOportunidad = nav * probabilidadNumerica;
            Diametro = Diametro + valorDeLaOportunidad;
            navTotal = navTotal + nav;
        }
        
        
        if(existenLosCamposDeTelefonica){
            if(oportunidadesFunnel != null){
                Diametro = 0;
                for(Opportunity oportunidad: oportunidadesFunnel){
                        Diametro = diametro + (Double)oportunidad.get('bi_nav_ponderado__c');
                }
            }
        }
         
        
        List<Account> cuentasABuscar = setCuentas.getRecords();
        List<Id> idsABuscar = new List<Id>();
        
        for(Account cuenta: cuentasABuscar){
            idsABuscar.add(cuenta.id);
        }
        //consigo el coeDeCuenta para la fecha que se paso.

        List<FourPlanning_CoeCuenta__c> coeficientesCuentas = [SELECT ID, Creacion_del_valor__c, Valor_Coeficiente_De_Cuenta__c
                                                               FROM FourPlanning_CoeCuenta__c 
                                                               WHERE Cuenta__c IN: idsABuscar AND
                                                               Creacion_del_valor__c <=: fechaLimite
                                                               ORDER BY Creacion_del_valor__c DESC];

        Double coeCuenta = 0;
        if(coeficientesCuentas.size() > 0){
            
            Integer CuentanEnElPromedio = 0;
            for(FourPlanning_CoeCuenta__c coe: coeficientesCuentas){
                if(coe.Valor_Coeficiente_De_Cuenta__c != 0){
					coeCuenta = coeCuenta + coe.Valor_Coeficiente_De_Cuenta__c;
                    cuentanEnElPromedio ++;
                }
            }
            
            if(cuentanEnElPromedio > 0){
                coeCuenta = coeCuenta/cuentanEnElPromedio;
            }
        }

        return new Bola(Diametro, navTotal , coeCuenta, fechaLimite);    
    }
    
    public void generarValoresEnPixelesDelDiametro(){
        Double max = 0;
        
        // se supone que todas las bolas ninguna va a ser null
        List<Bola> bolas = new List<Bola>();
        bolas.add(ultimoQ);
        bolas.add(tercerQ);
        bolas.add(segundoQ);
        bolas.add(primerQ);
        
        for(Bola bola:bolas){
            if(bola.diametro > max){
                max = bola.diametro;
            }
        }
        
		calcularMaximoValorEnPixeles(bolas, max);
        
        //generar la altura maxima objetivo(momentanea hasta definir como se va a obtener).
        
        /*
alturaZonaObjetivoMinima = alturaZonaObjetivoMaxima/2;
alturaPromedioPais = alturaZonaObjetivoMaxima;
alturaNombre = alturaZonaObjetivoMaxima*0.8;
*/
 
        nombreDiametroQ1 = NormalizarValor(primerQ.diametro);
        nombreDiametroQ2 = NormalizarValor(segundoQ.diametro);
        nombreDiametroQ3 = NormalizarValor(tercerQ.diametro);
        nombreDiametroQ4 = NormalizarValor(ultimoQ.diametro);
    }
    
    public PageReference establecerZonaObjetivo(){
        
        //si es null, el grafico en js no recibe ningun numero y rompe.
        if(filtro.altura_zona_objetivo_minima__c == null){
            filtro.altura_zona_objetivo_minima__c = 0;
        }
        if(filtro.altura_zona_objetivo_maxima__c == null){
            filtro.altura_zona_objetivo_maxima__c = 0;
        }else{
            alturaNombre = filtro.altura_zona_objetivo_maxima__c*VALOR_QUE_MULTIPLICA_PARA_DEFINIR_LA_ALTURA_DEL_NOMBRE_DE_ZONA_OBJETIVO;
        }
        if(filtro.Zona_Objetivo_valor_1_eje_x__c == null){
            filtro.Zona_Objetivo_valor_1_eje_x__c = 0;
        }
        
        if(filtro.Zona_Objetivo_valor_1_eje_x__c != 0){
            filtro.Zona_Objetivo_valor_2_eje_x__c = 100;
        }else{
            filtro.Zona_Objetivo_valor_2_eje_x__c = 0;
        }
        
        update filtro;
        
        generarValoresEnPixelesDelDiametro();
        return null;
    }
    
    public void calcularMaximoValorEnPixeles(List<Bola> bolas, Double max){
        
        Double navMaximo = 0; 
        for(Bola bola: bolas){
            if(bola.ejeY > navMaximo){
                navMaximo = bola.ejeY;
            }
        }
        
        system.debug(navMaximo);
        
        if(navMaximo != 0 ){
            if(navMaximo*3 >= filtro.altura_zona_objetivo_maxima__c){
                maximoValorEnPixeles = 160;
            }else{
                maximoValorEnPixeles = 60; 
            }
        }
        
        for(Bola bola: bolas){
            if(max != 0){
                bola.valorParaGraficarseEnPixeles = (bola.diametro * maximoValorEnPixeles)/max;
                
                //Por default lo mas chico va a ser 15px.
                if(bola.valorParaGraficarseEnPixeles<15 && bola.valorParaGraficarseEnPixeles>0 ){
                    bola.valorParaGraficarseEnPixeles = 15;
                }
            }else{
                bola.valorParaGraficarseEnPixeles = 0; 
            }
            
        }
    }
    
    public String normalizarValor(Decimal valor){
        
        String retorno;
        
        if(Valor >= 1000 && valor < 1000000){
            retorno = (valor/1000).setScale(2) + ' K';
        }else{
            if(Valor < 1000){
                retorno = valor.setScale(2) + ' ';    
            }else{
                retorno = (valor/1000000).setScale(2) + ' M';    
            }
            
        }
        
        return retorno;
    }
    
    // Bola =====================================================
    public class Bola {
        
        public Double Diametro {get; set;}
        public Double ejeY {get; set;}
        public Double ejeX {get; set;}
        public String nombre {get; set;}
        public Double valorParaGraficarseEnPixeles {get; set;}
        public Date fecha {get;set;}
        
        public Bola(Double unDiametro, Double nav, Double valorCoeficienteDesarrolloCuenta, Date fechaLimite){
            Diametro = unDiametro;
            ejeY = nav;
            ejeX = valorCoeficienteDesarrolloCuenta;
            fecha = fechaLimite;
            
            
            calcularNombreEnBaseALaFecha(fechaLimite);
        }
        
        public void calcularNombreEnBaseALaFecha(Date fecha){
            
            system.debug(fecha);
            
            Integer mesActual = fecha.month();
            Integer dia = fecha.day();
            Integer anio = fecha.year();
            
            if( (mesActual == 7 && dia > 1) || mesActual >= 8 ){
                if( (mesActual == 10 && dia > 1) || mesActual >= 11){
                    //Cuarto trimestre, del 1-10 al 31-12
                    nombre = 'Q4 - ';
                }else{
                    //Tercer trimestre, del 1-7 al 30-9
                    nombre = 'Q3 - ';
                }
            }else{
                if( (mesActual == 4 && dia > 1) || mesActual >= 5){
                    //Segundo trimestre, del 1-4 al 30-6 
                    nombre = 'Q2 - ';
                }else{
                    //Primer trimestre, del 1-1 al 31-3
                    nombre = 'Q1 - ';
                }
            }   
            
            nombre += anio;
            if(mesActual == 1 && dia == 1){
                nombre = 'Q4 - '+(anio-1);
            }
            
        }
    }
    
    public class usuarioWrapper{
        
        public Boolean seleccionado {get; set;}
        public Id usuario {get; set;}
        public String nombre {get; set;}
        
        public usuarioWrapper(User unUsuario){
            //seleccionado = true;
            seleccionado = false;
            usuario = unUsuario.id;
            nombre = unUsuario.name;
        }
    }
    
    //Nuevo Usr =================================================
	
    public void agrego(){
        
        if(filtro.UsuarioFiltro__c != null){
            User usuarioX = new User();
            
            usuarioX = [SELECT id, name FROM User WHERE id =: filtro.UsuarioFiltro__c];
            
            UsuarioWrapper userWpp = new UsuarioWrapper(usuarioX);
            usersWpp.add(userWpp);
            
            filtro.UsuarioFiltro__c = null;
            system.debug(filtro.UsuarioFiltro__c);}
    }
    
    public void borrar(){
        
        List<UsuarioWrapper> listaNueva = new List<UsuarioWrapper>();
        
        for(UsuarioWrapper usr: usersWpp){
            
            if(usr.seleccionado == false){
                listaNueva.add(usr);
            }
            
        }
        
        usersWpp = listaNueva;
        
    }
    
    public void seleccionarTodos(){
        for (UsuarioWrapper usr: wrapperUsuarios){
            usr.seleccionado = true;
        }
    }
    
    public void borrarTodos(){
        for (UsuarioWrapper usr: wrapperUsuarios){
            usr.seleccionado = false;
        }
    }

}