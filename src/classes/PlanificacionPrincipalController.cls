public class PlanificacionPrincipalController {
    public FourPlanning__c fourPlanning {get;set;}
    public Account cuenta {get;set;}
    
    public String accountReviewABorrarId {get;set;}
    
    
    //Vencimientos
    public List<WrapperOportunidadesVencimientos> vencimientosFijos {get;set;}
    public List<WrapperOportunidadesVencimientos> vencimientosMovil {get;set;}
    public List<WrapperOportunidadesVencimientos> vencimientosServiciosDigitales {get;set;}
    public List<WrapperOportunidadesVencimientos> vencimientosOtros {get;set;}
    
    public String vencimientosFijosJson {get;set;}
    public String vencimientosMovilJson {get;set;}
    public String vencimientosServiciosDigitalesJson {get;set;}
    public String vencimientosOtrosJson {get;set;}
    
    public List<OportunidadAMostrarWpp> wrapersOportunidadesVencimientos {get;set;}
    
    public List<String> FechasDeAcaADosAnios {get;set;}
    public String fechasJson {get;set;}
    
    public List<Account_Review__c> cambios1 {get;set;}
    public List<New_Account_Review__c> cambios {get;set;}
    public string cambioABorrarId {get;set;}
    public New_Account_Review__c cambioAInsertar {get;set;}
    public New_Account_Review__c cambioAInsertarDescription {get;set;}
    public New_Account_review__c cambioAInsertarFecha {get;set;}
    public string newAccountReview {get;set;}
    public Account_Review__c cambioAInsertar1 {get;set;}
    public Account_Review__c newAccountReview1 {get;set;}
    
    
    //Hitos
    public List<FourPlanning_Hito__c> hitos {get;set;} 
    public String hitoABorrarId {get;set;}
    public FourPlanning_Hito__c hitoAInsertar {get;set;}
    public List<FourPlanning_Hito__c> arboles {get;set;}
    public List<FourPlanning_Hito__c> cuentasTelefonica {get;set;}
    
    //Retos
    public FourPlanning_Reto__c retoAInsertar {get; set;}
    public FourPlanning_Reto__c retoAInsertar2 {get; set;}
    public FourPlanning_Solucion__c solucionAInsertar2 {get; set;}
    public FourPlanning_Area__c areaAInsertar {get; set;}
    public FourPlanning_Contacto__c contactoAInsertar2 {get;set;}
    
    public List<String> erroresAMostrar { get; set; }
    public List<WrapperArea> wrappersDeArea {get; set;}
    public List<WrapperReto> listaWrappersRetos {get; set;}
    public List<WrapperOportunidadesAVincular> wppOportunidades {get; set;}
    public List<FourPlanning_Reto__c> retosTotales {get; set;}
    
    public String categoriaCustom{get;set;}
    public String retoABorrarId {get;set;}
    public String areaABorrarID {get;set;}
    public String OportunidadADesvincularId {get;set;}
    public String idDelRetoDelContacto {get;set;}
    public String nombreRetoAyuda {get;set;}
    public String idRetoQuePideAyuda {get;set;}
    public String idDeSolucion {get;set;}
    public FourPlanning_Contacto__c contactoAInsertar {get; set;}
    public FourPlanning_Solucion__c solucionAInsertar {get; set;}
    
    //Tareas
    public Account account { get; set; }
    public String temp {get;set;}
    public List<TaskWrapper> tasks { get; set; }
    public Boolean canEdit {get;set;}
    public String sortExpression {get;set;}
    public String sortDirection {get;set;}
    public String filterExpression {get;set;}
    public String filterText {get;set;}
    
    public Boolean initialized = false;
    
    public String idCuenta { 
        get;
        set {
            idCuenta = value;
            if (!initialized) {
                ConstructorPlanificacionComponentController();
                initialized = true;
            }
        }
    }
    
    public List<String> idsCuentasHijas {get;set;}
    public List<String> idsDeTodasLasCuentas {get;set;}
    
    public PlanificacionPrincipalController(){
        
    }
    
    public void ConstructorPlanificacionComponentController(){
        wrapersOportunidadesVencimientos = new List<OportunidadAMostrarWpp>();
        hitoAInsertar = new FourPlanning_Hito__c();
        retoAInsertar = new FourPlanning_Reto__c();
        retoAInsertar2 = new FourPlanning_Reto__c();
        solucionAInsertar2 = new FourPlanning_Solucion__c();
        areaAInsertar = new FourPlanning_Area__c();
        contactoAInsertar2 = new FourPlanning_Contacto__c();
        erroresAMostrar = new List<String>();
        wrappersDeArea = new List<WrapperArea>();
        listaWrappersRetos = new List<WrapperReto>();
        wppOportunidades = new List<WrapperOportunidadesAVincular>();
        retosTotales = new List<FourPlanning_Reto__c>();
        contactoAInsertar = new FourPlanning_Contacto__c();
        solucionAInsertar = new FourPlanning_Solucion__c();
        cambioAInsertar1 = new Account_Review__c();
        //idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
        obtenerCuenta();
        obtenerCuenta1();
        
        idsCuentasHijas = new List<String>();
        idsDeTodasLasCuentas = new List<String>();
        for(Account chija:cuenta.ChildAccounts){
            idsCuentasHijas.add(chija.id);
        }
        idsDeTodasLasCuentas.addAll(idsCuentasHijas);
        idsDeTodasLasCuentas.add(cuenta.id);
        
        List<FourPlanning__c> fourPlannings = [SELECT ID, Vencimiento_Datos_Fijos__c, Fecha_Vencimiento_Contratos_Voz_Fija__c, Vencimiento_Servicios_Moviles__c,
                                               Vencimiento_Otros_Servicios__c, Otros_Servicios__c, Evento_telefonica_cliente__c, Fecha_Evento__c
                                               FROM FourPlanning__c 
                                               WHERE Cuenta__c =: idCuenta 
                                               LIMIT 1];
        
        if(fourPlannings.size() == 0 ){
            fourPlanning = new FourPlanning__c(Cuenta__c = idCuenta);
        }else{
            fourPlanning = fourPlannings[0];
        }
        
        
        obtenerAreas();
        
        //Vencimientos
        conseguirOportunidadesParaGraficoDeVencimientos();
        generarMesesDeAcaADosAnios();
        
        //Hitos.
        obtenerHitos();
        obtenerHitosDeOtrasCuentas();
        
        //tareas
        if (Util.globalAccount==null) {
            this.account = [SELECT name, id, parentId, Industry, Region__c FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('Id')];
        } else {
            this.account = Util.globalAccount; 
        }
        
        //Funcion que engloba si el el usuario acutal puede o no escribir en esta cuenta
        userActions temp = new userActions();
        
        this.canEdit=true;
        this.sortExpression = 'CreatedDate';
        this.sortDirection = 'ASC';
        this.filterExpression = '';
        this.filterText = ''; 
        this.loadTasks();
    }
    
    public void insertar4Planning(){
        if(FourPlanning.id == null){
            insert fourPlanning;
        } 
    }
    
    public void obtenerCuenta1(){
        
        cambios1 = [select id, Description__c , Date__c, createdby.name from Account_Review__c order by LastModifiedDate DESC];
    }   
    public void obtenerCuenta(){
        cuenta = [select id, name, Region__c, Micro_Industry__c, Industry, X4_Planning_Pro__c,
                  (select id, name, FourPlanning_Reto__c, CloseDate from Opportunities where isClosed = false and CloseDate > today limit 900),
                  (select id, name from ChildAccounts ),
                  (select id, name, Description__c , Date__c from accounts_reviews__r order By LastModifiedDate DESC)
                  from account where id =: idCuenta];
    }    
    
    //Vencimientos.
    public void conseguirOportunidadesParaGraficoDeVencimientos(){
        
        Set<String> objectFields = Schema.SObjectType.Opportunity.fields.getMap().keySet();        
        
        vencimientosFijos = new List<WrapperOportunidadesVencimientos>();
        vencimientosMovil = new List<WrapperOportunidadesVencimientos>();
        vencimientosServiciosDigitales = new List<WrapperOportunidadesVencimientos>();
        vencimientosOtros = new List<WrapperOportunidadesVencimientos>();
        
        //creo 4 mapas mes,wrapper.
        Map<String, WrapperOportunidadesVencimientos> mapaFijos = new map<String,WrapperOportunidadesVencimientos>();
        Map<String, WrapperOportunidadesVencimientos> mapaMovil = new map<String,WrapperOportunidadesVencimientos>();
        Map<String, WrapperOportunidadesVencimientos> mapaServiciosDigitales = new map<String,WrapperOportunidadesVencimientos>();
        Map<String, WrapperOportunidadesVencimientos> mapaOtros = new map<String,WrapperOportunidadesVencimientos>();
        
        Date hoyMenosUnAnio = date.today().addYears(-1);
        Date hoy = date.today().addYears(1);
        
        if( objectFields.contains('bi_opportunity_type__c') && 
           objectFields.contains('bi_fecha_de_fin_de_contrato__c') && 
           objectFields.contains('bi_full_contract_value_neto_fcv__c')) {
               
               List<Opportunity> oportunidadesTelefonica = database.query('select id, name, bi_opportunity_type__c, bi_fecha_de_fin_de_contrato__c, bi_full_contract_value_neto_fcv__c, Account.name from opportunity where AccountId in: idsDeTodasLasCuentas and bi_fecha_de_fin_de_contrato__c>: hoyMenosUnAnio and bi_fecha_de_fin_de_contrato__c<: hoy and isclosed = true and isWon = true and bi_full_contract_value_neto_fcv__c > 0 order by bi_fecha_de_fin_de_contrato__c limit 200');
               
               for(Opportunity opp: oportunidadesTelefonica){
                   
                   OportunidadAMostrarWpp oppWpp = new OportunidadAMostrarWpp((Double) opp.get('bi_full_contract_value_neto_fcv__c'), opp);
                   oppWpp.name = (String) opp.get('name');
                   oppWpp.id = (String) opp.get('id');
                   oppWpp.lineaDeNegocio = (String) opp.get('bi_opportunity_type__c');
                   oppWpp.fecha = (Date) opp.get('bi_fecha_de_fin_de_contrato__c');
                   oppWpp.fcv = (Double) opp.get('bi_full_contract_value_neto_fcv__c');
                   
                   wrapersOportunidadesVencimientos.add(oppWpp);
                   
                   Date fechaFinContrato = (Date) opp.get('bi_fecha_de_fin_de_contrato__c'); 
                   String claveOrdenar = fechaFinContrato.year()+''+fechaFinContrato.month();
                   String clave = fechaFinContrato.month()+'/'+fechaFinContrato.year();
                   
                   
                   String lineaDeNegocio = (String) opp.get('bi_opportunity_type__c');
                   WrapperOportunidadesVencimientos oppVencimiento = new WrapperOportunidadesVencimientos();
                   
                   if(lineaDeNegocio == 'Móvil' || lineaDeNegocio == 'Movil' || lineaDeNegocio == 'Móvil Datos' || lineaDeNegocio == 'Móvil Voz'){
                       
                       oppVencimiento = mapaMovil.get(clave);
                       
                       if(oppVencimiento == null ){
                           oppVencimiento = new WrapperOportunidadesVencimientos();
                           
                           if((Double) opp.get('bi_full_contract_value_neto_fcv__c')!= null){
                               oppVencimiento.fcv = (Double) opp.get('bi_full_contract_value_neto_fcv__c');
                           }else{
                               oppVencimiento.fcv = 0; 
                           }
                           
                           oppVencimiento.mes = clave;
                           oppVencimiento.claveOrdenar = claveOrdenar;
                           mapaMovil.put(clave, oppVencimiento);
                       }else{
                           oppVencimiento.fcv =  sumar(oppVencimiento.fcv,(Double) opp.get('bi_full_contract_value_neto_fcv__c'));
                       }
                   }else{
                       
                       if(lineaDeNegocio == 'Fija' || lineaDeNegocio == 'Fijo'){
                           
                           oppVencimiento = mapaFijos.get(clave);
                           
                           if(oppVencimiento == null ){
                               oppVencimiento = new WrapperOportunidadesVencimientos();
                               
                               if((Double) opp.get('bi_full_contract_value_neto_fcv__c')!= null){
                                   oppVencimiento.fcv = (Double) opp.get('bi_full_contract_value_neto_fcv__c');
                               }else{
                                   oppVencimiento.fcv = 0; 
                               }
                               
                               oppVencimiento.mes = clave;
                               oppVencimiento.claveOrdenar = claveOrdenar;
                               mapaFijos.put(clave, oppVencimiento);
                           }else{
                               oppVencimiento.fcv =  sumar(oppVencimiento.fcv,(Double) opp.get('bi_full_contract_value_neto_fcv__c'));
                           }
                           
                       }else{
                           
                           if(lineaDeNegocio == 'Soluciones digitales' || lineaDeNegocio == 'Digital'){
                               
                               oppVencimiento = mapaServiciosDigitales.get(clave);
                               
                               if(oppVencimiento == null ){
                                   oppVencimiento = new WrapperOportunidadesVencimientos();
                                   
                                   if((Double) opp.get('bi_full_contract_value_neto_fcv__c')!= null){
                                       oppVencimiento.fcv = (Double) opp.get('bi_full_contract_value_neto_fcv__c');
                                   }else{
                                       oppVencimiento.fcv = 0; 
                                   }
                                   
                                   oppVencimiento.mes = clave;
                                   oppVencimiento.claveOrdenar = claveOrdenar;
                                   mapaServiciosDigitales.put(clave, oppVencimiento);
                               }else{
                                   oppVencimiento.fcv =  sumar(oppVencimiento.fcv,(Double) opp.get('bi_full_contract_value_neto_fcv__c'));
                               }
                           }else{
                               
                               oppVencimiento = mapaOtros.get(clave);
                               
                               if(oppVencimiento == null ){
                                   oppVencimiento = new WrapperOportunidadesVencimientos();
                                   
                                   if((Double) opp.get('bi_full_contract_value_neto_fcv__c')!= null){
                                       oppVencimiento.fcv = (Double) opp.get('bi_full_contract_value_neto_fcv__c');
                                   }else{
                                       oppVencimiento.fcv = 0; 
                                   }
                                   
                                   oppVencimiento.mes = clave;
                                   oppVencimiento.claveOrdenar = claveOrdenar;
                                   mapaOtros.put(clave, oppVencimiento);
                               }else{
                                   oppVencimiento.fcv =  sumar(oppVencimiento.fcv,(Double) opp.get('bi_full_contract_value_neto_fcv__c'));
                               }
                               
                           }}}
                   
               }
               
               
           }else{
               
               List<Opportunity> oportunidadesTelefonica = database.query('select id, name, certa_scp__linea_de_negocio__c, closeDate, certa_scp__full_contract_value__c, account.name from opportunity where AccountId in: idsDeTodasLasCuentas and closeDate>: hoyMenosUnAnio and closeDate<: hoy and isclosed = true and isWon = true and certa_scp__full_contract_value__c > 0 order by closeDate limit 200');
               
               for(Opportunity opp: oportunidadesTelefonica){
                   
                   OportunidadAMostrarWpp oppWpp = new OportunidadAMostrarWpp((Double) opp.get('certa_scp__full_contract_value__c'), opp);
                   oppWpp.name = (String) opp.get('name');
                   oppWpp.id = (String) opp.get('id');
                   oppWpp.lineaDeNegocio = (String) opp.get('certa_scp__linea_de_negocio__c');
                   oppWpp.fecha = (Date) opp.get('closeDate');
                   oppWpp.fcv = (Double) opp.get('certa_scp__full_contract_value__c');
                   
                   
                   wrapersOportunidadesVencimientos.add(oppWpp);
                   
                   Date fechaFinContrato = (Date) opp.get('closeDate');
                   String claveOrdenar = fechaFinContrato.year()+''+fechaFinContrato.month();
                   String clave = fechaFinContrato.month()+'/'+fechaFinContrato.year();
                   //String clave = 'enero '+'- '+fechaFinContrato.year();
                   
                   String lineaDeNegocio = (String) opp.get('certa_scp__linea_de_negocio__c');
                   WrapperOportunidadesVencimientos oppVencimiento = new WrapperOportunidadesVencimientos();
                   
                   if(lineaDeNegocio == 'Movil'){
                       
                       oppVencimiento = mapaMovil.get(clave);
                       
                       if(oppVencimiento == null ){
                           oppVencimiento = new WrapperOportunidadesVencimientos();
                           
                           if((Double) opp.get('certa_scp__full_contract_value__c')!= null){
                               oppVencimiento.fcv = (Double) opp.get('certa_scp__full_contract_value__c');
                           }else{
                               oppVencimiento.fcv = 0; 
                           }
                           
                           oppVencimiento.mes = clave;
                           oppVencimiento.claveOrdenar = claveOrdenar;
                           mapaMovil.put(clave, oppVencimiento);
                       }else{
                           oppVencimiento.fcv =  sumar(oppVencimiento.fcv,(Double) opp.get('certa_scp__full_contract_value__c'));
                       }
                   }else{
                       
                       if(lineaDeNegocio == 'Fijo'){
                           
                           oppVencimiento = mapaFijos.get(clave);
                           
                           if(oppVencimiento == null ){
                               oppVencimiento = new WrapperOportunidadesVencimientos();
                               
                               if((Double) opp.get('certa_scp__full_contract_value__c')!= null){
                                   oppVencimiento.fcv = (Double) opp.get('certa_scp__full_contract_value__c');
                               }else{
                                   oppVencimiento.fcv = 0; 
                               }
                               
                               oppVencimiento.mes = clave;
                               oppVencimiento.claveOrdenar = claveOrdenar;
                               mapaFijos.put(clave, oppVencimiento);
                           }else{
                               oppVencimiento.fcv =  sumar(oppVencimiento.fcv,(Double) opp.get('certa_scp__full_contract_value__c'));
                           }
                           
                       }else{
                           
                           if(lineaDeNegocio == 'Digital'){
                               
                               oppVencimiento = mapaServiciosDigitales.get(clave);
                               
                               if(oppVencimiento == null ){
                                   oppVencimiento = new WrapperOportunidadesVencimientos();
                                   
                                   if((Double) opp.get('certa_scp__full_contract_value__c')!= null){
                                       oppVencimiento.fcv = (Double) opp.get('certa_scp__full_contract_value__c');
                                   }else{
                                       oppVencimiento.fcv = 0; 
                                   }
                                   
                                   oppVencimiento.mes = clave;
                                   oppVencimiento.claveOrdenar = claveOrdenar;
                                   mapaServiciosDigitales.put(clave, oppVencimiento);
                               }else{
                                   oppVencimiento.fcv =  sumar(oppVencimiento.fcv,(Double) opp.get('certa_scp__full_contract_value__c'));
                               }
                           }else{
                               
                               oppVencimiento = mapaOtros.get(clave);
                               
                               if(oppVencimiento == null ){
                                   oppVencimiento = new WrapperOportunidadesVencimientos();
                                   
                                   if((Double) opp.get('certa_scp__full_contract_value__c')!= null){
                                       oppVencimiento.fcv = (Double) opp.get('certa_scp__full_contract_value__c');
                                   }else{
                                       oppVencimiento.fcv = 0; 
                                   }
                                   
                                   oppVencimiento.mes = clave;
                                   oppVencimiento.claveOrdenar = claveOrdenar;
                                   mapaOtros.put(clave, oppVencimiento);
                               }else{
                                   oppVencimiento.fcv =  sumar(oppVencimiento.fcv,(Double) opp.get('certa_scp__full_contract_value__c'));
                               }
                               
                           }}}
                   
               }
           }
        
        vencimientosFijos = mapaFijos.values();
        vencimientosMovil = mapaMovil.values();
        vencimientosServiciosDigitales = mapaServiciosDigitales.values();
        vencimientosOtros = mapaOtros.values();
        
        
        vencimientosFijosJson = JSON.serialize(vencimientosFijos);
        vencimientosMovilJson = JSON.serialize(vencimientosMovil);
        vencimientosServiciosDigitalesJson = JSON.serialize(vencimientosServiciosDigitales);
        vencimientosOtrosJson = JSON.serialize(vencimientosOtros);
        
    }
    
    public PageReference nuevoAccountReview(){
        
        
        cambioAInsertar1.Account__c = idCuenta;
        insert cambioAInsertar1;
        
        
        cambioAInsertar1 = new Account_Review__c();
        obtenerCuenta1();
        return null;
        
        
    }
    
    public void borrarAccountReview(){
        
        system.debug(accountReviewABorrarId);
        List<Account_Review__c> aBorrar = [select id from Account_Review__c where id =: accountReviewABorrarId];
        
        if(aBorrar.size()>0){
            delete aBorrar;
            obtenerCuenta1();
        }
        
    }
    
    public Double sumar(Double numero1, Decimal numero2){
        
        if(numero1 != null && numero2 != null){
            return numero1+numero2;
        }
        if(numero1 != null && numero2 == null){
            return numero1;
        }
        if(numero1 == null && numero2 != null){
            return numero2;
        }
        
        // else.
        return 0;
    }
    
    
    
    public void generarMesesDeAcaADosAnios(){
        
        FechasDeAcaADosAnios = new List<String>();
        Date fechaHoy = Date.today().addYears(1);
        
        for(integer i=24; i>0; i--){
            Date fecha = fechaHoy.addMonths(-i);
            FechasDeAcaADosAnios.add(fecha.month()+'/'+fecha.year());
        }
        
        fechasJson = JSON.serialize(FechasDeAcaADosAnios);
    }
    
    
    //Hitos
    public void obtenerHitos(){

        
        if(fourPlanning.id != null){
            
            hitos  = [SELECT ID, Descripcion__c, Fecha__c, FourPlanning__c, Categoria__c, FourPlanning__r.cuenta__r.name, Pais__c
                      FROM FourPlanning_Hito__c
                      WHERE FourPlanning__c =: fourPlanning.id];
            
            Set<String> objectFields = Schema.SObjectType.Account.fields.getMap().keySet();  
            
            if( objectFields.contains('bi_country__c') ) {
                hitos = database.query('SELECT ID, Descripcion__c, Fecha__c, FourPlanning__c, Categoria__c, FourPlanning__r.cuenta__r.name,Pais__c, FourPlanning__r.cuenta__r.bi_country__c FROM FourPlanning_Hito__c WHERE FourPlanning__c =: fourPlanning.id');
                
                if(hitos.size()>0){
                    
                    for (FourPlanning_Hito__c X : hitos){
                        if(X.Pais__c == ''){
                            account unaCuenta = x.certa_scp__fourPlanning__r.certa_scp__cuenta__r;
                        	X.Pais__c = (string) unaCuenta.get('bi_country__c');
                           
                        } 
                    }
                }
                
            }
        }
    }
    
    
    
    public void obtenerHitosDeOtrasCuentas(){

        cuentasTelefonica = new List<FourPlanning_Hito__c>();
        
        if(idsCuentasHijas.size()>0){
            List<FourPlanning__c> fourPlanningsOtrasCuentas = [select id from fourPlanning__c where Cuenta__c in: idsCuentasHijas ];
            
            List<String> idsFourPlanningsOtrasCuentas = new List<String>();
            
            for(FourPlanning__c fp: fourPlanningsOtrasCuentas){
                idsFourPlanningsOtrasCuentas.add(fp.id);
            }
            
            
            hitos.addAll([SELECT ID, Descripcion__c, Fecha__c, FourPlanning__c, Categoria__c, FourPlanning__r.cuenta__r.name, Pais__c
                          FROM FourPlanning_Hito__c
                          WHERE FourPlanning__c in: idsFourPlanningsOtrasCuentas]); 
            Set<String> objectFields = Schema.SObjectType.Account.fields.getMap().keySet();  
            
            if( objectFields.contains('bi_country__c') ) {
                hitos = database.query('SELECT ID, Descripcion__c, Fecha__c, FourPlanning__c, Categoria__c, FourPlanning__r.cuenta__r.name, Pais__c, FourPlanning__r.cuenta__r.bi_country__c FROM FourPlanning_Hito__c WHERE FourPlanning__c =: fourPlanning.id');
                
                if(hitos.size()>0){
                    
                    
                    for (FourPlanning_Hito__c X : hitos){
                        if(X.Pais__c == ''){
                            account unaCuenta = x.certa_scp__fourPlanning__r.certa_scp__cuenta__r;
                        	X.Pais__c = (string) unaCuenta.get('bi_country__c');
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
            
        }
        
    }
    
    
    
    public PageReference BorrarHito(){
        
        Integer i = 0;
        
        for(FourPlanning_Hito__c hito : hitos){
            
            if(hito.id == this.hitoABorrarId){
                break;
            }
            else{
                i++;
            }   
        }
        
        system.debug(hitos[i]);
        if(hitos[i].id != null){
            
            delete [SELECT ID FROM task WHERE hitoAsociado__c =: hitos[i].id];
            delete hitos[i];    
        }
        
        
        hitos.remove(i);
        return null;    	
        
    }
    
    
    public void insertHito(){
        
        if(hitoAInsertar.Categoria__c == 'Otro' && hitoAInsertar.Name != null ){
            hitoAInsertar.Categoria__c = hitoAInsertar.Name;
            hitoAInsertar.Name = null;
        }
        
        hitoAInsertar.FourPlanning__c = fourPlanning.id;
        insert hitoAInsertar;
        
        Task tareaDelHito = new Task();
        tareaDelHito.ActivityDate = hitoAInsertar.Fecha__c;
        tareaDelHito.Subject = hitoAInsertar.Categoria__c;
        tareaDelHito.Description = hitoAInsertar.Descripcion__c;
        tareaDelHito.WhatId = idCuenta;
        tareaDelHito.hitoAsociado__c = hitoAInsertar.id;
        
        insert tareaDelHito;
        
        hitoAInsertar = new FourPlanning_Hito__c();
        obtenerHitos();
    }
    
    //Retos
    public void insertarReto(){
        
        erroresAMostrar = new List<String>();
        
        if (retoAInsertar.Nombre_del_Reto__c != null && retoAinsertar.Etapa_del_Reto__c != null){
            
            if(retoAInsertar.Nombre_del_Reto__c != null && solucionAInsertar2.Lista_de_Soluciones__c != null ){
                
                if(solucionAInsertar2.Lista_de_Soluciones__c != null && areaAInsertar.Tipo_de_Area__c != null && areaAInsertar.Titulo_Area__c != null && solucionAInsertar2.Nivel_de_Desarrollo__c != null ){
                    
                    areaAInsertar.Numero_de_Area__c = 1;
                    areaAInsertar.name = 'Area 1';
                    
                    insertarArea();
                    
                    system.debug(areaAInsertar.id);
                    
                    retoAInsertar.Name = retoAInsertar.Nombre_del_Reto__c;
                    retoAInsertar.FourPlanning_Area__c = areaAInsertar.id;
                    
                    
                    insert retoAInsertar;
                    
                    solucionAInsertar2.Reto__c = retoAInsertar.id;
                    insert solucionAInsertar2;
                    
                    
                    if (contactoAInsertar2.Tipo_de_Contacto__c == 'Otro' && contactoAInsertar2.pruebaTexto__c != null ){
                        contactoAInsertar2.Tipo_de_Contacto__c = contactoAInsertar2.pruebaTexto__c;
                    }
                    
                    
                    contactoAInsertar2.Reto__c = retoAInsertar.id;
                    insert contactoAInsertar2;
                    
                    areaAInsertar = new FourPlanning_Area__c();
                    solucionAInsertar2 = new FourPlanning_Solucion__c();
                    contactoAInsertar2 = new FourPlanning_Contacto__c();
                    retoAInsertar = new FourPlanning_Reto__c();
                    retoAInsertar.Tipo_De_Reto__c = 'Negocio';
                    
                    
                    listaWrappersRetos = new List<WrapperReto>();
                    obtenerAreas();}
                else{
                    erroresAMostrar.add('La solucion del reto debe tener un grado de disponibilidad, un tipo de área y un nombre de área');
                    
                }
            }
            
            else{
                erroresAMostrar.add('El reto a insertar debe tener una solución');
            }
            
        }
        else{
            erroresAMostrar.add('El reto a insertar debe tener un nombre y una etapa');
            
            
        }
        for (String errorAMostrar : erroresAMostrar) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errorAMostrar);
            ApexPages.addMessage(myMsg);
        }
        
        crearWppOportunidad();
        
    }
    
    public void crearWppOportunidad(){
        
        wppOportunidades = new List<WrapperOportunidadesAVincular>();
        
        for(Opportunity opp: cuenta.Opportunities){
            
            if(opp.FourPlanning_Reto__c == null){
                WrapperOportunidadesAVincular unWpp = new WrapperOportunidadesAVincular(opp);
                wppOportunidades.add(unWpp);
            }    
        }
        
    }	
    
    public void insertarArea(){
        
        if(areaAInsertar.Titulo_Area__c != null){
            areaAInsertar.FourPlanning__c = fourPlanning.id;
            insert areaAInsertar;
        }
        
        obtenerAreas();
    }
    
    public void obtenerAreas(){
        //tengo que obtener las areas, ahora las estoy obteniiedno de una subquery del 4Planning, ver si me traigo todo el 4Planning completo o solo las areas.
        
        List<FourPlanning_Area__c> todasLasAreas = [select id, Titulo_Area__c, Conocimiento_del_Area__c, Tipo_de_Area__c 
                                                    from FourPlanning_Area__c where FourPlanning__c =: fourPlanning.Id];
        
        crearWrappersDeAreas(todasLasAreas);
    }
    
    public void crearWrappersDeAreas (List<FourPlanning_Area__c> areas){
        
        wrappersDeArea = new List<WrapperArea>();
        
        //Me traigo los retos de esas areas y armo los wpp de area
        List<Id> IdareasTotales = new List<Id>();
        for(FourPlanning_Area__c areaDelFourPlanning:areas){
            IdareasTotales.add(areaDelFourPlanning.id);
        }
        
        retosTotales = [select id, FourPlanning_Area__c, Nombre_del_Reto__c, Etapa_del_Reto__c, Tipo_De_Reto__c, CategoriaRetoGestion__c, Contactos_del_Cliente__c,
                        Otros_contactos_del_cliente__c, Nivel_de_relaci_n_contacto__c, Productos_a_Desarrollar_Vender__c,
                        Observacion_solucion_elejida__c, Estado_de_la_solucion__c, Competidor__c, Web_Competidor__c, Nota__c, Fecha_Compromiso__c, Fecha_ayuda_ventas__c, Pidio_ayuda_a_ventas__c,
                        (select id, Reto__c, Lista_de_Soluciones__c, SubcategoriaSolucion__c, Competidor__c, Nivel_de_Desarrollo__c, Observaci_n_sobre_el_producto__c, Otra_Solucion__c from FourPlanning_Soluciones__r),
                        (select id, Nivel_de_Relaci_n__c, Reto__c, Otro_contacto_del_cliente__c, Tipo_de_Contacto__c, pruebaTexto__c, ContactoDeReto__c from FourPlanning_Contactos__r),
                        (select id, name, CloseDate from Oportunidades__r)
                        from FourPlanning_Reto__c 
                        where (FourPlanning_Area__c in: IdareasTotales AND Nombre_del_Reto__c != NULL AND Etapa_del_Reto__c != NULL) OR (FourPlanning_Area__c in: IdareasTotales AND Nombre_del_Reto__c != NULL AND Tipo_De_Reto__c != NULL) ];
        system.debug(retosTotales);
        
        wrappersDeArea = new List<WrapperArea>();
        for(FourPlanning_Area__c areaDelFourPlanning: areas){
            
            WrapperArea wppA = new WrapperArea(areaDelFourPlanning);
            
            for(FourPlanning_Reto__c reto:retosTotales){
                if(reto.FourPlanning_Area__c == areaDelFourPlanning.id){
                    
                    wppA.retos.add(reto);
                    WrapperReto wppReto = new WrapperReto(reto);
                    wppA.wppRetos.add(wppReto);
                    listaWrappersRetos.add(wppReto);
                }
            }
            
            wrappersDeArea.add(wppA);
        }
    }
    
    public void insertarRetoCustom(){
        
        erroresAMostrar = new List<String>();
        
        areaAInsertar.Titulo_Area__c = 'Retos de Gestion';
        
        if (retoAInsertar2.Nombre_del_Reto__c != null && areaAInsertar.Titulo_Area__c != null ){
            
            areaAInsertar.Numero_de_Area__c = 1;
            areaAInsertar.name = 'Area 1';
            
            insertarArea();
            
            system.debug(areaAInsertar.id);
            
            retoAInsertar2.Name = retoAInsertar2.Nombre_del_Reto__c;
            retoAInsertar2.FourPlanning_Area__c = areaAInsertar.id;
            retoAInsertar2.Tipo_De_Reto__c = 'Gestión';
            
            if (retoAInsertar2.CategoriaRetoGestion__c == 'Otro' && categoriaCustom !=null){
                retoAInsertar2.CategoriaRetoGestion__c = categoriaCustom;
            }
            
            
            system.debug(retoAInsertar2);
            insert retoAInsertar2;
            
            categoriaCustom='';
            
            areaAInsertar = new FourPlanning_Area__c();
            
            retoAInsertar2 = new FourPlanning_Reto__c();
            
            listaWrappersRetos = new List<WrapperReto>();
            obtenerAreas();
            
            
        }
        else{
            erroresAMostrar.add('El reto a insertar debe tener un nombre');
            
            
        }
        for (String errorAMostrar : erroresAMostrar) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errorAMostrar);
            ApexPages.addMessage(myMsg);
        }
        
        retoAInsertar2.Tipo_De_Reto__c = 'Gestión';
        crearWppOportunidad();
        
    }
    
    public PageReference BorrarReto(){
        Integer i = 0;
        
        FourPlanning_Reto__c retoABorrar = [SELECT ID, FourPlanning_Area__c FROM FourPlanning_Reto__c WHERE ID =: retoABorrarId];
        
        FourPlanning_Area__c areaDelRetoABorrar = [select id, Titulo_Area__c, Conocimiento_del_Area__c, Tipo_de_Area__c from FourPlanning_Area__c where id =: retoABorrar.FourPlanning_Area__c];
        
        List<FourPlanning_Reto__c> retosDelArea = [Select id, Nombre_del_Reto__c, Etapa_del_Reto__c from FourPlanning_Reto__c where FourPlanning_Area__C =: areaDelRetoABorrar.id AND Nombre_del_Reto__c != NULL AND Etapa_del_Reto__c != NULL limit 2];
        
        if(retosDelArea.size() > 1){
            for(FourPlanning_Reto__c reto : retosTotales){
                
                if(reto.id == this.retoABorrarId){
                    break;
                }
                else{
                    i++;
                }   
            }
            
            if(retosTotales[i].id != null){
                
                delete [SELECT ID FROM FourPlanning_Reto__c WHERE ID =: retosTotales[i].id];
                
            }
            
            
            retosTotales.remove(i);
        }
        
        else{
            areaABorrarID = areaDelRetoABorrar.id;
            borrarArea();
        }
        
        listaWrappersRetos = new List<WrapperReto>();
        crearWppOportunidad();
        obtenerAreas();
        
        return null;
    }
    
    public PageReference borrarArea(){
        
        Integer i = 0;
        
        for(WrapperArea wppArea : wrappersDeArea){
            
            if(wppArea.area.id == areaABorrarId){
                break;
            }
            else{
                i++;
            }   
        }
        
        if(wrappersDeArea[i].area.id != null){
            
            delete wrappersDeArea[i].area;    
        }
        
        
        wrappersDeArea.remove(i);        
        listaWrappersRetos = new List<WrapperReto>();
        obtenerAreas();
        return null;
    }
    
    public void desvincularOportunidad(){
        
        Opportunity oportunidad = [select id from Opportunity where id =: OportunidadADesvincularId];
        oportunidad.FourPlanning_Reto__c = null;
        update oportunidad;
        
        cuenta = [select id, name, Region__c, Micro_Industry__c, Industry, X4_Planning_Pro__c,
                  (select id, name, FourPlanning_Reto__c, CloseDate from Opportunities where isClosed = false and CloseDate > today limit 900),
                  (select id, name from accounts_reviews__r order by LastModifiedDate DESC)
                  from account where id =: idCuenta];
        
        
        
        crearWppOportunidad();
        setearOportunidadesAContacto();
        listaWrappersRetos = new List<WrapperReto>();
        obtenerAreas();
        
    }
    
    public PageReference setearOportunidadesAContacto(){
        listaWrappersRetos = new List<WrapperReto>();
        List<Opportunity> oportunidadesAActualizarConIdDelReto = new List<Opportunity>();
        
        //List<Integer> opportunidadesASacar = new List<Integer>();
        for(Integer i=0; i< wppOportunidades.size(); i++){
            if(wppOportunidades[i].vincular){
                wppOportunidades[i].oportunidad.FourPlanning_Reto__c = idDelRetoDelContacto;
                oportunidadesAActualizarConIdDelReto.add(wppOportunidades[i].oportunidad);
                //opportunidadesASacar.add(i);
            }
        }
        
        try{
            update oportunidadesAActualizarConIdDelReto; 
        }catch(Exception e){
            system.debug(e);
            
            
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(myMsg);
            
            
            
            obtenerAreas();
            
            
        }
        
        
        cuenta = [select id, name, Region__c, Micro_Industry__c, Industry, X4_Planning_Pro__c,
                  (select id, name, FourPlanning_Reto__c, CloseDate from Opportunities where isClosed = false and CloseDate > today limit 900),
                  (select id, name from accounts_reviews__r order By LastModifiedDate DESC)
                  from account where id =: idCuenta];
        
        obtenerAreas();
        crearWppOportunidad();
        
        system.debug(wppOportunidades);
        return null;
    }
    
    public PageReference crearPlanDeAccion(){
        
        FourPlanning_Reto__c reto = new FourPlanning_Reto__c();
        
        reto = [select id, Nombre_del_Reto__c from FourPlanning_Reto__c where id =: idDelRetoDelContacto];
        
        Task tarea = new Task();
        tarea.WhatId = idCuenta;
        tarea.subject = 'Reto: ' + reto.Nombre_del_Reto__c;
        
        insert tarea;
        
        String url = Page.accountMasterPlan.getURL();
        return new PageReference (url + '?id=' + idCuenta);
        
    }
    
    public void buscarPlanDeAccion(){
        
        FourPlanning_Reto__c reto = new FourPlanning_Reto__c();
        
        
        reto = [select id, Nombre_del_Reto__c from FourPlanning_Reto__c where id =: idDelRetoDelContacto];
        
        Task tarea = new Task();
        tarea.WhatId = idCuenta;
        tarea.subject = 'Reto: ' + reto.Nombre_del_Reto__c;
        insert tarea;
        loadTasks();
        
        
    }
    
    public PageReference DecisionCriterilMatrixMN(){
        
        
        String url = Page.DecisionCriterilMatrixMN.getURL();
        return new PageReference (url + '?id=' + idCuenta);
    }
    
    public PageReference cancelarApoyoAVentaEspecialista(){
        List<String> auxEmailsList = new List<String>();
        List<apoyo_ventas__c> destinatario = [select id, name, Correo_destinatario__c from apoyo_ventas__c];
        
        User usuario = [select id, name, email from User where id =: UserInfo.getUserId()];
        for(apoyo_ventas__c mail: destinatario){
            auxEmailsList.add(mail.Correo_destinatario__c);
        }
        
        if(auxEmailsList.size() > 0){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setUseSignature(false);
            mail.setSaveAsActivity(false);
            mail.setHtmlBody('<p>El usuario, nombre: <b>'+usuario.name+'</b> email: <b>'+usuario.email+'</b> ha <b>CANCELADO</b> la ayuda a venta especialista para el reto: '+nombreRetoAyuda+' de la cuenta <b>'+cuenta.name+'.</b></p>');
            mail.setSubject('Cancelación de ayuda a venta especialista');
            mail.setToAddresses(auxEmailsList);
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            FourPlanning_reto__c retoAActualizar = new FourPlanning_reto__c();
            retoAActualizar.id = idRetoQuePideAyuda;
            retoAActualizar.Pidio_ayuda_a_ventas__c = false;
            
            WrapperReto retoDuenioDelContacto;
            for(WrapperReto reto:listaWrappersRetos){
                
                if(reto.reto.id == idRetoQuePideAyuda){
                    retoDuenioDelContacto = reto; 
                }
                
            }
            
            retoDuenioDelContacto.reto.Pidio_ayuda_a_ventas__c = false;
            
            if(retoAActualizar.id != null){
                update retoAActualizar;
            }
            
        }
        
        return null;
    }
    
    public PageReference pedirApoyoAVentas(){
        
        List<String> auxEmailsList = new List<String>();
        List<apoyo_ventas__c> destinatario = [select id, name, Correo_destinatario__c from apoyo_ventas__c];
        
        User usuario = [select id, name, email from User where id =: UserInfo.getUserId()];
        for(apoyo_ventas__c mail: destinatario){
            auxEmailsList.add(mail.Correo_destinatario__c);
        }
        
        if(auxEmailsList.size() > 0){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setUseSignature(false);
            mail.setSaveAsActivity(false);
            mail.setHtmlBody('<p>El usuario, nombre: <b>'+usuario.name+'</b> email: <b>'+usuario.email+'</b> ha solicitado apoyo a venta especialista para el reto: '+nombreRetoAyuda+' de la cuenta <b>'+cuenta.name+'.</b></p>');
            mail.setSubject('Apoyo a venta especialista');
            mail.setToAddresses(auxEmailsList);
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            FourPlanning_reto__c retoAActualizar = new FourPlanning_reto__c();
            retoAActualizar.id = idRetoQuePideAyuda;
            retoAActualizar.Pidio_ayuda_a_ventas__c = true;
            retoAActualizar.Fecha_ayuda_ventas__c = Date.today();
            
            WrapperReto retoDuenioDelContacto;
            for(WrapperReto reto:listaWrappersRetos){
                
                if(reto.reto.id == idRetoQuePideAyuda){
                    retoDuenioDelContacto = reto; 
                }
                
            }
            
            retoDuenioDelContacto.reto.Pidio_ayuda_a_ventas__c = true;
            retoDuenioDelContacto.reto.Fecha_ayuda_ventas__c = Date.today();
            
            system.debug(retoDuenioDelContacto.reto.Fecha_ayuda_ventas__c);
            
            if(retoAActualizar.id != null){
                update retoAActualizar;
            }
            
        }
        
        return null;
    }
    
    public void vincularRetoASolucion(){
        
        
        SolucionEnCuenta__c solucion = [select id, Reto__c from SolucionEnCuenta__c where id =: idDeSolucion];
        
        
        for(Integer i=0; i< listaWrappersRetos.size(); i++){
            if(listaWrappersRetos[i].vincular){
                solucion.Reto__c = listaWrappersRetos[i].reto.id;
                listaWrappersRetos[i].vincular = false;
            }
        }
        
        update solucion;
        
    }
    
    public void insertarContacto(){
        
        system.debug('dentro de insertar contacto');
        
        system.debug(idDelRetoDelContacto);
        
        
        if(!String.isBlank(idDelRetoDelContacto)){
            contactoAInsertar.Reto__c = idDelRetoDelContacto;
        }
        
        system.debug(contactoAInsertar);
        
        system.debug(contactoAInsertar.pruebaTexto__c);
        
        if (contactoAInsertar.Tipo_de_Contacto__c == 'Otro' && contactoAInsertar.pruebaTexto__c != null ){
            contactoAInsertar.Tipo_de_Contacto__c = contactoAInsertar.pruebaTexto__c;
            contactoAInsertar.pruebaTexto__c = null;
        }
        
        
        system.debug(contactoAInsertar.Tipo_de_Contacto__c);
        
        if(contactoAInsertar.Nivel_de_Relaci_n__c != null && contactoAInsertar.Tipo_de_Contacto__c != null && contactoAInsertar.Reto__c != null){
            system.debug(contactoAInsertar);
            
            update retosTotales;
            
            insert contactoAInsertar;
            
            contactoAInsertar = new FourPlanning_contacto__c();
            
            listaWrappersRetos = new List<WrapperReto>();
            obtenerAreas();
        }
        
    }
    
    public void guardarHitos(){
        update fourPlanning;
        //update hitos;
    }
    
    public void guardarRetos(){
        for(WrapperArea area : wrappersDeArea){
            
            for(WrapperReto reto : area.wppRetos){
                
                if (reto.reto.Nombre_del_Reto__c != null && reto.reto.Tipo_De_Reto__c == 'Negocio' && reto.reto.Etapa_del_Reto__c == null){
                    erroresAMostrar.add('El reto "' + reto.reto.Nombre_del_Reto__c + '"" debe tener una etapa');
                }
                
                if (reto.reto.Tipo_De_Reto__c == 'Gestión' && reto.reto.Nombre_del_Reto__c == null){
                    erroresAMostrar.add('El reto debe tener una nombre');
                }
                
                if (reto.reto.Nombre_del_Reto__c == null && reto.reto.Tipo_De_Reto__c == 'Negocio' && reto.reto.Etapa_del_Reto__c != null){
                    erroresAMostrar.add('El reto con etapa "' + reto.reto.Etapa_del_Reto__c + '" debe tener un nombre');
                }
                
            }
            
        }
        
        Set<FourPlanning_Area__c> areasInLineTextEdit = new Set<FourPlanning_Area__c>();
        List<FourPlanning_Reto__c> retosInLineTextEdit = new List<FourPlanning_Reto__c>();
        List<FourPlanning_Contacto__c> contactosInLineTextEdit = new List<FourPlanning_Contacto__c>();
        List<FourPlanning_Contacto__c> contactosInLineTextEdit2 = new List<FourPlanning_Contacto__c>();
        List<FourPlanning_Solucion__c> solucionesInLineTextEdit = new List<FourPlanning_Solucion__c>();
        List<FourPlanning_Solucion__c> solucionesInLineTextEdit2 = new List<FourPlanning_Solucion__c>();
        
        for(WrapperReto wppReto: listaWrappersRetos){
            
            contactosInLineTextEdit.addAll(wppReto.contactos);
            solucionesInLineTextEdit.addAll(wppReto.soluciones);
            areasInLineTextEdit.add(wppReto.areaDelReto);
            retosInLineTextEdit.add(wppReto.reto);
        }
        
        for(FourPlanning_Contacto__c contacto : contactosInLineTextEdit){ 
            if(contacto.ContactoDeReto__c == null && contacto.Nivel_de_Relaci_n__c == null && contacto.Otro_contacto_del_cliente__c == null){
                
                delete contacto;
                
            }else{
                contactosInLineTextEdit2.add(contacto);
            }
        } 
        
        for(FourPlanning_Solucion__c solucion : solucionesInLineTextEdit){ 
            if(solucion.Otra_Solucion__c == null && solucion.Nivel_de_Desarrollo__c == null && solucion.Competidor__c == null){
                
                delete solucion;
                
            }else{
                solucionesInLineTextEdit2.add(solucion);
            }
        }
        
        if(areasInLineTextEdit.size()>0){
            
            List<FourPlanning_Area__c> areasList = new List<FourPlanning_Area__c>(areasInLineTextEdit);
            
            update areasList;
        }
        
        if(retosInLineTextEdit.size()>0 && erroresAMostrar.size() == 0){
            update retosInLineTextEdit;
        }
        
        if(contactosInLineTextEdit2.size()>0){
            update contactosInLineTextEdit2;
        }
        
        if(solucionesInLineTextEdit2.size()>0){
            update solucionesInLineTextEdit2;
        }
        
        if(retosTotales.size() > 0 && erroresAMostrar.size() == 0){
            update retosTotales;
        }
        
        listaWrappersRetos = new List<WrapperReto>();
        obtenerAreas();
    }
    
    public void insertarSolucion(){
        
        system.debug('dentro de insertar solucion');
        
        if(!String.isBlank(idDelRetoDelContacto)){
            solucionAInsertar.Reto__c = idDelRetoDelContacto;
            system.debug('entre');
        }
        
        
        if(solucionAInsertar.Nivel_de_Desarrollo__c != null && solucionAInsertar.Lista_de_Soluciones__c != null){
            
            insert solucionAInsertar;
            
            solucionAInsertar = new FourPlanning_Solucion__c();
            listaWrappersRetos = new List<WrapperReto>();
            obtenerAreas();
        }
        
    }
    //======================================================================================================
    
    public class WrapperArea{
        
        public FourPlanning_Area__c area {get; set;}
        public List<FourPlanning_Reto__c> retos {get; set;}
        public List<WrapperReto> wppRetos {get; set;}
        
        public WrapperArea(FourPlanning_Area__c unArea){
            area = unArea;
            retos = new List<FourPlanning_Reto__c>();
            wppRetos = new List<WrapperReto>();
        }
    }
    
    public class WrapperReto{
        
        public FourPlanning_Reto__c reto {get; set;}
        public List<FourPlanning_Contacto__c> contactos {get; set;}
        public List<FourPlanning_Solucion__c> soluciones {get; set;}
        public FourPlanning_Area__c areaDelReto {get;set;}
        public boolean vincular {get;set;}
        
        
        public WrapperReto(){}
        
        public WrapperReto(FourPlanning_Reto__c unReto){
            
            vincular= false;
            
            reto = unReto;
            
            contactos = new List<FourPlanning_Contacto__c>();
            soluciones = new List<FourPlanning_Solucion__c>();
            areaDelReto = new FourPlanning_Area__c();
            Id idArea;
            
            idArea = reto.FourPlanning_Area__c;
            
            if(reto.FourPlanning_Contactos__r != null){
                contactos = reto.FourPlanning_Contactos__r;
            }
            
            if(reto.FourPlanning_Soluciones__r != null){
                soluciones = reto.FourPlanning_Soluciones__r;
            }
            
            areaDelReto = [select id, Titulo_Area__c, Conocimiento_del_Area__c, Tipo_de_Area__c from FourPlanning_Area__c where id =: idArea];
            
        }
    }
    
    public class WrapperOportunidadesAVincular{
        
        public Opportunity oportunidad {get; set;}
        public Boolean vincular {get; set;}
        
        public WrapperOportunidadesAVincular(Opportunity unaOportunidad){
            oportunidad = unaOportunidad;
            vincular = false;
        }
    }
    
    public class WrapperOportunidadesVencimientos{
        
        public String mes{get;set;}
        public Double fcv{get;set;}
        public String claveOrdenar {get;set;}
    }
    
    public class OportunidadAMostrarWpp{
        public String id{get;set;}
        public String name{get;set;}
        public String lineaDeNegocio{get;set;}
        public Date fecha{get;set;}
        public Decimal fcv {get;set;}
        public String claveOrdenar {get;set;}
        public Big_Deal__c opp {get;set;}
        public Opportunity unaOportunidad {get;set;} 
        
        public OportunidadAMostrarWpp(Double unFcv, Opportunity oportunidad){
            opp = new Big_Deal__c();
            opp.currency2__c = unFcv;
            unaOportunidad = oportunidad;
            //CurrencyIsoCode
            if(Util.checkMultiCurrencyEnabled()){
                opp.put('CurrencyIsoCode',(String) oportunidad.get('CurrencyIsoCode'));
            }
        }
    }
    
    //Tareas
    public void loadTasks(){
        
        List<Id> oppIds = new List<Id>();
        For (Opportunity opp :[select id from opportunity where accountId in: idsDeTodasLasCuentas]) {
            oppIds.add(opp.id);
        }                
        
        tasks = new List<TaskWrapper>();
        for(Task t :[select account.name, subject, Description, ActivityDate, Status,Priority,End_date__c, OwnerId, CreatedDate, Owner.Name, URL__C FROM Task WHERE WhatId in: idsDeTodasLasCuentas or WhatId in :oppIds]){
            tasks.add(new TaskWrapper(t));
        }
        
    }
    
    private List<Task> getChangedTask() {
        Map<Id, Task> taskMap = new Map<Id, Task>();      
        for (TaskWrapper t :tasks) {
            taskMap.put(t.task.id,t.task);
        }      
        List<Task> taskList = new List<Task>();
        for (Task oldTask :[select id, Subject, Description, URL__c, ActivityDate, End_Date__c, Status, Priority, OwnerId from task where id in :taskMap.keySet()]) {
            Task newTask = taskMap.get(oldTask.id);
            if (newTask.Subject != oldTask.Subject || newTask.Description != oldTask.Description || newTask.URL__c != oldTask.URL__c
                || newTask.ActivityDate != oldTask.ActivityDate || newTask.End_Date__c != oldTask.End_Date__c || newTask.Status != oldTask.Status
                || newTask.Priority != oldTask.Priority || newTask.OwnerId != oldTask.OwnerId) {
                    
                    taskList.add(newTask);          
                }
        }      
        return taskList;
    }
    
    private Boolean canSave() {
        boolean canSave = true;
        boolean canEdit = (new userActions()).checkWrite(this.account);
        for (Task t :getChangedTask()) {
            if (!canEdit && t.Ownerid != UserInfo.getUserId() ) {
                canSave = false;
                break;
            }
        }      
        return canSave;
    }
    
    public PageReference SaveChanges() {        
        if (canSave()) {        
            Map<Id,Task> taskMap = new Map<Id,Task>();
            for(TaskWrapper tw : tasks){
                taskMap.put(tw.task.Id,tw.task);
                if(tw.task.End_date__c == null && tw.task.Status == 'Completed')
                    tw.task.End_date__c = Date.today();
                else if(tw.task.End_date__c != null && tw.task.Status != 'Completed')
                    tw.task.End_date__c = null;
            }
            List<Task> taskListEmail = new list<Task>();
            List<Task> taskListNotEmail = new list<Task>();
            for (Task t :[select Id, OwnerId from Task where id in :taskMap.keySet()]) {
                if (t.OwnerId != taskMap.get(t.Id).OwnerId) {
                    taskListEmail.add(taskMap.get(t.Id));            
                } else {
                    taskListNotEmail.add(taskMap.get(t.Id));            
                }
            }
            
            Database.DMLOptions dmlo = new Database.DMLOptions();
            dmlo.EmailHeader.triggerUserEmail = true;
            database.update(taskListEmail, dmlo);
            database.update(taskListNotEmail);
            
            update account;
            loadTasks();
        }else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,System.Label.ErrorDeleteTask));
        }
        return null;
        
    }
    
    public PageReference DeleteTasks() {
        List<Task> taskList = new List<Task>();
        boolean canDelete = true; 
        boolean canEdit = new userActions().checkWrite(this.account);
        
        for(TaskWrapper tw : tasks) {
            if(tw.selected) {
                if (!canEdit && tw.task.Ownerid != UserInfo.getUserId()) {
                    canDelete = false;
                    break;
                }
                taskList.add(tw.task);                                
            }            
        }        
        
        if (canDelete) {
            delete taskList;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,System.Label.ErrorDeleteTask));
        }
        loadTasks();
        return null;
    }
    
    public PageReference irACuestionario(){
        
        String url = Page.cuestionarioFourPlanning.getURL();
        return new PageReference (url + '?id=' + account.id);
    }
    
    
    public PageReference MergeTasks() {
        Task newTask = new Task();
        newTask.Subject = '';
        newTask.Description = '';
        newTask.Status = 'Deferred';
        
        List<Task> taskToDelete = new List<Task>();
        boolean canMerge = true; 
        boolean canEdit = new userActions().checkWrite(this.account);
        
        for(TaskWrapper tw : tasks) {
            if(tw.selected){
                if (!canEdit && tw.task.Ownerid != UserInfo.getUserId()) {
                    canMerge = false;
                    break;
                }
                if(newTask.Subject == '' || (newTask.Subject == tw.task.Subject))
                    newTask.Subject = tw.task.Subject;
                else
                    newTask.Subject = newTask.Subject + ' ' + tw.task.Subject;
                
                newTask.Description = newTask.Description + tw.task.Description + ' ';
                if(newTask.ActivityDate >  tw.task.ActivityDate)
                    newTask.ActivityDate = tw.task.ActivityDate;
                
                if(     (newTask.Status == 'Deferred')
                   ||  (newTask.Status == 'Waiting on someone else' && ( tw.task.Status == 'Not Started' || tw.task.Status == 'In Progress' || tw.task.Status == 'Completed') ) 
                   ||  (newTask.Status == 'Completed' && ( tw.task.Status == 'Not Started' || tw.task.Status == 'In Progress' ) )
                   ||  (newTask.Status == 'In Progress' && ( tw.task.Status == 'Not Started') )
                  )
                    newTask.Status = tw.task.Status;
                
                if(     (newTask.Priority == '')
                   ||  (newTask.Priority == 'Low' && ( tw.task.Priority == 'Normal' || tw.task.Priority == 'High') )
                   ||  (newTask.Priority == 'Normal' &&  tw.task.Priority == 'High' )
                  )
                    newTask.Priority = tw.task.Priority;
                
                newTask.OwnerId = tw.task.OwnerId;
                
                taskToDelete.add(tw.task);
            }
        }
        
        if (canMerge) {
            delete taskToDelete;
            
            newTask.WhatId = account.id;
            if(newTask.Description != '') {
                insert newTask;
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,System.Label.ErrorDeleteTask));
        }
        
        loadTasks();
        return null;
    }
    
    public List<String> getTaskStatusList(){
        
        List<String> ret = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = Task.Status.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple) {
            ret.add(f.getLabel());
        }  
        
        return ret;
    }
    
    public List<String> getPriorityList(){
        
        List<String> ret = new List<String>();
        
        Schema.DescribeFieldResult fieldResult = Task.Priority.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        for( Schema.PicklistEntry f : ple) {
            ret.add(f.getLabel());
        }  
        return ret;
    }
    
    public List<String> getAssignedToList(){
        
        List<String> ret = new List<String>();
        
        LIST<AggregateResult> temp = [SELECT Owner.name FROM Task WHERE WhatId = :account.id GROUP BY Owner.name];
        
        for(AggregateResult t : temp){
            Boolean add = true;
            for(String s : ret) {
                if(s == String.valueOf(t.get('name'))){
                    add = false;
                    break;
                }
            }
            if (add) {
                ret.add(String.valueOf(t.get('name')));
            }
        }
        
        return ret;
        
    }
    
    
    public List<SelectOption> getSubjectList(){
        
        List<SelectOption> ret = new List<SelectOption>();
        
        LIST<Task> temp = [SELECT Subject FROM Task WHERE WhatId = :account.id ];
        ret.add(new SelectOption('',''));
        for(Task t : temp){
            Boolean add = true;
            for(SelectOption s : ret) {
                if(s.getValue() == t.Subject){
                    add = false;
                    break;
                }
            }
            if(add && t.Subject != null) {
                ret.add(new SelectOption(t.Subject,t.Subject));
            }
        }
        ret.add(new SelectOption('#$NEWSUBJECT','New Subject'));
        
        return ret;
    }
    
    public PageReference ExportToExcel() {      
        SaveChanges();
        return Page.accountMasterPlanExcel;        
    }
    
    public String getExcelName() {
        String name = account.Name + '-' + Label.Action_Plan_Builder + '.xls';
        return name.replaceAll(' ', '_').replaceAll(',','');
    }
    
    
    public class TaskWrapper{
        
        public Task task {get;set;}
        public Boolean selected {get;set;}
        
        public TaskWrapper(Task task){
            selected = false;
            this.task = task;
        }
        
        public void save(){
            if(task.End_date__c == null && task.Status == 'Completada')
                task.End_date__c = Date.today();
            else if(task.End_date__c != null && task.Status != 'Completada')
                task.End_date__c = null;
            update task;
        }
        
    }
    
}