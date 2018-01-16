public class VencimientosGlobalesController {
    
    public FourPlanning__c fourPlanning {get;set;}
    public String idCuenta {get;set;}
    public Account cuenta {get;set;}
    
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

    
    public VencimientosGlobalesController(){
        
        wrapersOportunidadesVencimientos = new List<OportunidadAMostrarWpp>();
        
        conseguirOportunidadesParaGraficoDeVencimientos();
        generarMesesDeAcaADosAnios();
    }
        

    
    //Vencimientos.
    public void conseguirOportunidadesParaGraficoDeVencimientos(){
        
         Id miId = UserInfo.getUserId();
        
        User miUsuario = [select id, name, Email, UserRoleId from user where id =: miId];
        
        Set<Id> usuariosDebajoDeLaJerarquia = new Set<Id>();
        if(miUsuario.userRoleId != null){
            usuariosDebajoDeLaJerarquia.addAll(Util.getRoleSubordinateUsers(miUsuario.UserRoleId));
        }
        
        system.debug(usuariosDebajoDeLaJerarquia);
        
         //Si no hay usuarios debajo, el set vuelve vacio.
        usuariosDebajoDeLaJerarquia.add(miId);
        
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

               List<Opportunity> oportunidadesTelefonica = database.query('select id, name, bi_opportunity_type__c, bi_fecha_de_fin_de_contrato__c, bi_full_contract_value_neto_fcv__c, account.name from opportunity where ownerId =: usuariosDebajoDeLaJerarquia and bi_fecha_de_fin_de_contrato__c>: hoyMenosUnAnio and bi_fecha_de_fin_de_contrato__c<: hoy and isclosed = true and isWon = true and bi_full_contract_value_neto_fcv__c > 0 order by bi_fecha_de_fin_de_contrato__c limit 200');

               for(Opportunity opp: oportunidadesTelefonica){
                   
                   OportunidadAMostrarWpp oppWpp = new OportunidadAMostrarWpp((Double) opp.get('bi_full_contract_value_neto_fcv__c'), opp);
                   oppWpp.oportunidad = opp;
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
               
               List<Opportunity> oportunidadesTelefonica = database.query('select id, name, account.name, certa_scp__linea_de_negocio__c, closeDate, certa_scp__full_contract_value__c from opportunity where ownerId =: usuariosDebajoDeLaJerarquia and closeDate>: hoyMenosUnAnio and closeDate<: hoy and isclosed = true and isWon = true and certa_scp__full_contract_value__c > 0 order by closeDate limit 200');
                              
               for(Opportunity opp: oportunidadesTelefonica){
                   
                   OportunidadAMostrarWpp oppWpp = new OportunidadAMostrarWpp((Double) opp.get('certa_scp__full_contract_value__c'), opp);
                   oppWpp.oportunidad = opp;
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
    
     Public PageReference irAlTab(){
        String url = Page.Tab4Planning.getURL();
        return new PageReference (url);   
    }
    
    public class OportunidadAMostrarWpp{
        public String id{get;set;}
        public Opportunity oportunidad{get;set;}
        public String name{get;set;}
        public String lineaDeNegocio{get;set;}
        public Date fecha{get;set;}
        public Decimal fcv {get;set;}
        public String claveOrdenar {get;set;}
        public Big_Deal__c opp {get;set;}
        
        public OportunidadAMostrarWpp(Double unFcv, Opportunity oportunidad){
            opp = new Big_Deal__c();
            opp.currency2__c = unFcv;
            //CurrencyIsoCode
            if(Util.checkMultiCurrencyEnabled()){
                opp.put('CurrencyIsoCode',(String) oportunidad.get('CurrencyIsoCode'));
            }
        }
    }
    
}