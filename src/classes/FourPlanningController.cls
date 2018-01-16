public class FourPlanningController {
    
    public Map<String, wrapperPresupuesto> mapaPresupuestos {get;set;}
    public List<wrapperPresupuesto>listaFinalPresupuestos {get;set;}
    public Boolean donuts {get;set;}
    public Boolean barras {get;set;} 
    public Boolean totalDonuts {get;set;}
    public Boolean totalBarras {get;set;}
    public String listaPresupuestosJson {get;set;}
    
    public FourPlanning_Reto__c retoAInsertar {get; set;}
    public FourPlanning_Reto__c retoAInsertar2 {get; set;}
    
    public FourPlanning_Area__c areaDelRetoABorrar {get;set;}
    public FourPlanning_Reto__c retoABorrar {get;set;}
    
    
    public String contactoEjecutivo1{get;set;}
    public String contactoEjecutivo2{get;set;}
    public String contactoEjecutivo3{get;set;}
    public String contactoEjecutivo4{get;set;}
    
    public String relacionInstitucional1{get;set;}
    public String relacionInstitucional2{get;set;}  
    public String relacionInstitucional3{get;set;}  
    public String relacionInstitucional4{get;set;}  
    public String relacionInstitucional5{get;set;}      
    
    
    public String listaOportunidadesJson {get;set;}
    public String listaOportunidadesJsonAnioAnterior {get;set;}
    public String listaOportunidadesJsonAnioActual {get;set;}
    
    public Double totalNosotros {get;set;}
    public Double totalCompetencia {get;set;}
    public Double totalDisponible {get;set;}
    
    public String auxiliarTituloIniciativa {get;set;}
    
    
    
    public List<String> erroresAMostrar { get; set; }
    
    public List<X4PlanningProPresupuesto__c> presupuestos{get;set;}
    
    public Id presupuestoABorrarId{get;set;}
    
    public Id OportunidadADesvincularId {get;set;}
    
    Public String porQueNoEsUtil {get; set;}
    
    Public String tituloArea1 {get; set;}
    Public String tituloArea2 {get; set;}
    Public String tituloArea3 {get; set;}
    Public String tituloArea4 {get; set;}
    Public String tituloArea5 {get; set;}
    
    public String nombreRetoAyuda {get; set;}
    
    public FourPlanning__c fourPlanning {get; set;}
    
    public String idCuenta {get; set;}
    
    public Boolean mostrar {get; set;}
    
    public List<FourPlanning_Reto__c> retosArea1 {get; set;}
    public List<FourPlanning_Reto__c> retosArea2 {get; set;}
    public List<FourPlanning_Reto__c> retosArea3 {get; set;}
    public List<FourPlanning_Reto__c> retosArea4 {get; set;}
    public List<FourPlanning_Reto__c> retosArea5 {get; set;}
    
    public Account cuenta {get;set;}
    
    public List<Strategic_Initiative__c> iniciativasDelNegocioDelCliente {get; set;}
    
    public Strategic_Initiative__c newInitiative {get;set;}
    
    public String delId {get; set;}
    
    public String hitoABorrarId {get; set;}
    
    public String retoABorrarId {get;set;}
    
    public List<FourPlanning_Hito__c> hitos {get; set;}
    
    public FourPlanning_Hito__c hitoAInsertar {get; set;}
    
    public Double porcentaje {get; set;}
    
    public string monedaDeLaCuenta {get; set;}

    //====================================================
    
    public List<FourPlanning_Reto__c> retosTotales {get; set;}
    public List<WrapperArea> wrappersDeArea {get; set;}
    public List<WrapperReto> listaWrappersRetos {get; set;}
    public List<WrapperOportunidadesAVincular> wppOportunidades {get; set;}
    
    public List<FourPlanning_Reto__c> retosDelArea {get;set;}   
    
    public FourPlanning_Area__c areaAInsertar {get; set;}
    public FourPlanning_Contacto__c contactoAInsertar {get; set;}
    public FourPlanning_Contacto__c contactoAInsertar2 {get; set;}
    
    public String areaABorrarId {get; set;}
    
    public String contactoIdABorrar {get; set;}
    public String solucionIdABorrar {get; set;}
    public String retoDeContactoABorrar {get;set;}
    
    public X4PlanningProPresupuesto__c presupuestoAInsertar{get;set;}
    
    public String idDelRetoDelContacto {get;set;}
    
    public String idDeSolucion{get;set;}
    
    public String idRetoQuePideAyuda {get; set;}
    
    public FourPlanning_Solucion__c solucionAInsertar {get; set;}
    public FourPlanning_Solucion__c solucionAInsertar2 {get; set;}
    
    public List<Evento_BackShop__c> eventosBackShop {get; set;}
    
    public String idDelEvento {get; set;}
    
    public List<WrapperEventosBackShop> wppEventos {get; set;}
    
    public List<WrapperOportunidadGrafico> WrappersOportunidadesParaElGrafico {get;set;}
    
    public List<WrapperOportunidadGrafico> WrappersOportunidadesParaElGraficoAnioAnterior {get;set;}
    
    public List<WrapperOportunidadGrafico> WrappersOportunidadesParaElGraficoAnioActual {get;set;}
    
    
    
    public List<Solucion__c> solucionesTotales {get;set;}
    
    public List<SolucionEnCuenta__c> solucionesEnCuenta {get;set;}
    
    public List<SolucionEnCuenta__c> solucionesAInsertar{get;set;}
    
    public Set <ID> idSoluciones {get;set;}
    
    
    public List<SolucionEnCuenta__c> solucionesAInsertar2{get;set;}
    
    public String solucionADesvincular{get;set;}
    
    public String categoriaCustom{get;set;}
    
    
    public String lineaDeServicioSeleccionado {get;set;}
    public String familiaSeleccionada {get;set;}
    
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
    //====================================================
    
    public FourPlanningController() {
        
        WrappersOportunidadesParaElGrafico = new List<WrapperOportunidadGrafico>();
        WrappersOportunidadesParaElGraficoAnioAnterior = new List<WrapperOportunidadGrafico>();
        WrappersOportunidadesParaElGraficoAnioActual = new List<WrapperOportunidadGrafico>();
        
        wrapersOportunidadesVencimientos = new List<OportunidadAMostrarWpp>();
        
        erroresAMostrar = new List<String>();
        
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
        mostrar = false;
        if(idCuenta!= null){
            mostrar = true; 
        }
        
        
        
        hitos = new List<FourPlanning_Hito__c>();
        
        cuenta = [select id, name, Region__c, Micro_Industry__c, Industry, X4_Planning_Pro__c,
                  (select id, name, FourPlanning_Reto__c, CloseDate from Opportunities where isClosed = false and CloseDate > today limit 900)
                  from account where id =: idCuenta];
        
        crearWppOportunidad();
        
        newInitiative = new Strategic_Initiative__c();
        
        hitoAInsertar = new FourPlanning_Hito__c();
        areaAInsertar = new FourPlanning_Area__c();
        retoAInsertar = new FourPlanning_Reto__c();
        retoAInsertar2 = new FourPlanning_Reto__c();
        contactoAInsertar = new FourPlanning_Contacto__c();
        contactoAInsertar2 = new FourPlanning_Contacto__c();
        solucionAInsertar = new FourPlanning_Solucion__c();
        solucionAInsertar2 = new FourPlanning_Solucion__c();
        presupuestoAInsertar = new X4PlanningProPresupuesto__c();
        
        
        //presupuestoAInsertar.Presupuesto_Nosotros__c = 0;
        //presupuestoAInsertar.Presupuesto_Competencia__c = 0;
        //presupuestoAInsertar.Presupuesto_Total__c = 0;
        
        retosArea1 = new List<FourPlanning_Reto__c>();
        retosArea2 = new List<FourPlanning_Reto__c>();
        retosArea3 = new List<FourPlanning_Reto__c>();
        retosArea4 = new List<FourPlanning_Reto__c>();
        retosArea5 = new List<FourPlanning_Reto__c>();
        
        listaWrappersRetos = new List<WrapperReto>();
        
        List<FourPlanning__c> fourPlannings = [SELECT ID, Facturacion__c, SeleccionMultipleContactoPublico__c, SeleccionMultiple__c, Rango_Sucursales__c, Nivel_Contacto_Publico__c, Otros_Servicios__c, Tiene_Presencia_Internacional__c, No_informa_dato__c, Fecha_Vencimiento_Contratos_Voz_Fija__c, Rango_Edificios__c, Empleados_Crece_Decrece_Matiene__c, Rango_Empleados__c, Cantidad_de_Empleados__c, Cantidad_de_Sedes__c, Parque_Automotor_Propio_o_Gestionado__c, Presencia_Regional__c,
                                               Mayor_Nivel_de_Contacto_con_el_Cliente__c, Frecuencia_de_Contacto_con_el_Cliente__c, Agenda_Periodica_Ejecutiva__c, Agenda_Periodica_Operacional__c,
                                               Frecuencia_Funcionarios_del_Cliente__c, Contacto_con_mayor_afinidad_1__c, Contacto_con_mayor_afinidad_1__r.Title, Contacto_con_mayor_afinidad_2__r.Title, Contacto_con_mayor_afinidad_3__r.Title, Contacto_con_mayor_afinidad_2__c, Contacto_con_mayor_afinidad_3__c,
                                               Desafio_de_la_Empresa_1__c,Desafio_de_la_Empresa_2__c, Desafio_de_la_Empresa_3__c, Competidor_Principal_1__c, Competidor_Principal_2__c, Competidor_Principal_3__c, Canal_Comercializacion_cliente__c,
                                               Canal_Comercializacion_que_mas_crece__c, Titulo_Area_1__c, Titulo_Area_2__c, Titulo_Area_3__c,Titulo_Area_4__c, Titulo_Area_5__c, Areas_que_Seria_Bueno_Trabajar__c, ISC__c, Area_que_fracasamos_en_el_pasado__c,
                                               Mejoraria_Relacion_Con_El_Cliente__c, realcion_empresa_otros_clientes__c, Vencimiento_Datos_Fijos__c, Vencimiento_Servicios_Moviles__c, Vencimiento_Otros_Servicios__c, 
                                               Evento_telefonica_cliente__c, Fecha_Evento__c, Hito_Relevante_1__c, Hito_Relevante_1_fecha__C, Hito_Relevante_2__c, Hito_Relevante_2_fecha__C, Hito_Relevante_3__c, 
                                               Hito_Relevante_3_fecha__c, FourPlanning_Area_1__r.Titulo_Area__c, FourPlanning_Area_1__c, FourPlanning_Area_2__r.Titulo_Area__c, FourPlanning_Area_2__c, 
                                               FourPlanning_Area_3__r.Titulo_Area__c, FourPlanning_Area_3__c, FourPlanning_Area_4__r.Titulo_Area__c, Agenda_de_Trabajo_1__c, Agenda_de_Trabajo_2__c, Agenda_de_Trabajo_3__c,
                                               Agenda_de_Trabajo_4__c, Agenda_de_Trabajo_5__c, Cuenta__r.Micro_Industry__c, cuenta__r.Industry, Nivel_de_conocimiento_area1__c,Nivel_de_conocimiento_area2__c,
                                               Nivel_de_conocimiento_area3__c, Nivel_de_conocimiento_area4__c, Nivel_de_conocimiento_area5__c, FourPlanning_Area_4__c, FourPlanning_Area_5__r.Titulo_Area__c, FourPlanning_Area_5__c,
                                               Tipo_de_Banca__c, Ambito_de_actuacion__c, Numero_de_sucursales__c, Numero_de_Empleados__c, Canal_que_Dispone__c, Importancia_web__c, Importancia_red_de_cajeros__c,
                                               Importancia_crecimiento_oficinas__c, importancia_banca_movil__c, conocimiento_de_la_cuenta__c, Canal_de_comercializaci_n_multiple__c,
                                               Tipo_de_Extraccion__c, Volumen_de_Extraccion__c, Volumen_de_Produccion__c, flota_vehiculos_propios__c, centro_distribucion_propia__c, Cantidad_de_empleados_exacto__c,
                                               Cantidad_de_sedes_exactas__c, Cantidad_de_sucursales__c, Como_se_mantiene_el_numero_de_sucursales__c, Dispone_de_parque_automotor__c, Otro_nivel_de_contacto_con_cliente__c,
                                               comercializacion_que_mas_crece_multiple__c, Top_5_de_proveedores__c, vinculo_direccion_tecnologia__c, prospecta_venta_tecnologia_cliente__c, esta_en_el_futuro_del_cliente__c,
                                               lanes_estrat_gicos_de_tu_cliente__c, facturacion_cliente_garantizada__c, Porcentaje_facturacion_fija__c, Porcentaje_facturacion_variable__c, Qu_presupuesto_anual_maneja_tu_cliente__c,
                                               Le_afectan_los_cambios_politicos__c, Compra_de_caracter_politico_o__c, De_cuantos_veh_culos_dispone_el_parque__c, X4_Planning_Pro__c
                                               FROM FourPlanning__c 
                                               WHERE Cuenta__c =: idCuenta 
                                               LIMIT 1];
        
        
        
        
        if(fourPlannings.size() == 0 ){
            FourPlanning__c nuevoFourPlanning = new FourPlanning__c(Cuenta__c = idCuenta);
            fourPlanning = nuevoFourPlanning;
        }else{
            fourPlanning = fourPlannings[0];
        }
        
        
        donuts = true;
        barras = false;
        totalDonuts = false;
        totalBarras = true;
        
        mapaPresupuestos = new Map<String, wrapperPresupuesto>();
        listaFinalPresupuestos = new List<wrapperPresupuesto>();
        
        obtenerPresupuestos();
        obtenerTotales();
        
        listaPresupuestosJson = JSON.serialize(listaFinalPresupuestos); 
        
        system.debug(presupuestos);
        
        
        contactoEjecutivo1 = fourPlanning.Agenda_de_Trabajo_1__c;
        contactoEjecutivo2 = fourPlanning.Agenda_de_Trabajo_2__c;
        contactoEjecutivo3 = fourPlanning.Agenda_de_Trabajo_3__c;
        contactoEjecutivo4 = fourPlanning.Agenda_de_Trabajo_4__c;
        
        relacionInstitucional1 = fourPlanning.Top_5_de_proveedores__c;
        relacionInstitucional2 = fourPlanning.vinculo_direccion_tecnologia__c; 
        relacionInstitucional3 = fourPlanning.prospecta_venta_tecnologia_cliente__c;
        relacionInstitucional4 = fourPlanning.esta_en_el_futuro_del_cliente__c;
        relacionInstitucional5 = fourPlanning.lanes_estrat_gicos_de_tu_cliente__c;
        
        /*        
if(string.isBlank(fourPlanning.lanes_estrat_gicos_de_tu_cliente__c)){
fourPlanning.lanes_estrat_gicos_de_tu_cliente__c = '1';
}
if(string.isBlank(fourPlanning.esta_en_el_futuro_del_cliente__c)){
fourPlanning.esta_en_el_futuro_del_cliente__c = '1';
}
if(string.isBlank(fourPlanning.prospecta_venta_tecnologia_cliente__c)){
fourPlanning.prospecta_venta_tecnologia_cliente__c = '1';
}
if(string.isBlank(fourPlanning.vinculo_direccion_tecnologia__c)){
fourPlanning.vinculo_direccion_tecnologia__c = '1';
}
if(string.isBlank(fourPlanning.Top_5_de_proveedores__c)){
fourPlanning.Top_5_de_proveedores__c = '1';
}

if(string.isBlank(fourPlanning.Agenda_de_Trabajo_1__c)){
fourPlanning.Agenda_de_Trabajo_1__c = '1';
}
if(string.isBlank(fourPlanning.Agenda_de_Trabajo_2__c)){
fourPlanning.Agenda_de_Trabajo_2__c = '1';
}
if(string.isBlank(fourPlanning.Agenda_de_Trabajo_3__c)){
fourPlanning.Agenda_de_Trabajo_3__c = '1';
}
if(string.isBlank(fourPlanning.Agenda_de_Trabajo_4__c)){
fourPlanning.Agenda_de_Trabajo_4__c = '1';
}

if(fourPlanning.Porcentaje_facturacion_fija__c == null){
fourPlanning.Porcentaje_facturacion_fija__c = 0;
}
if(fourPlanning.Porcentaje_facturacion_variable__c == null){
fourPlanning.Porcentaje_facturacion_variable__c = 0;
}*/
        
        if(fourPlanning.facturacion_cliente_garantizada__c == null){
            fourPlanning.facturacion_cliente_garantizada__c = 0;
        }
        
        
        //Testeo de multiCurrency para entornos sin multicurrency.
        /*
id CuentaPrueba = idCuenta;
Account otraCuenta = DataBase.query('SELECT id, name FROM Account WHERE id =: CuentaPrueba');
String nombre = (String)otraCuenta.get('name');
fourPlanning.put('name', nombre);
*/
        
        //=========================================================
        //BackShop
        
        obtenerEventosBackShops();
        
        //================================================================
        List<FourPlanning_Area__c> todasLasAreas = new List<FourPlanning_Area__c>();
        if(fourPlanning.id != null){
            todasLasAreas = [select id, Titulo_Area__c, Conocimiento_del_Area__c, Tipo_de_Area__c from FourPlanning_Area__c where FourPlanning__c =: fourPlanning.Id];
        }
        
        if(fourPlanning.FourPlanning_Areas__r != null){
            crearWrappersDeAreas(todasLasAreas);
        }
        
        system.debug(wrappersDeArea);
        
        monedaDeLaCuenta = '';
        if(Util.checkMultiCurrencyEnabled()){
            
            id CuentaId = idCuenta;
            
            try{
                Account unaCuenta = DataBase.query('SELECT id, CurrencyISOCode FROM Account WHERE id =: CuentaId'); 
                monedaDeLaCuenta = (String)unaCuenta.get('CurrencyISOCode');
                fourPlanning.put('CurrencyISOCode', monedaDeLaCuenta);
            }catch(Exception e){
                System.debug('Error en la asignacion del CurrentISOCode:' + e.getMessage());
            }
            
        }
        
        generarIniciativas();
        obtenerHitos();
        calcularPorcentajeCuestionarioCompleto();
        generarWrapperDeOportunidadesParaElGraficoDePresupuestos();
        obtenerSolucionesEnCuenta();
        conseguirOportunidadesParaGraficoDeVencimientos();
        generarMesesDeAcaADosAnios();
    }
    
    public void generarMesesDeAcaADosAnios(){
        
        FechasDeAcaADosAnios = new List<String>();
        Date fechaHoy = Date.today().addYears(1);
        
        for(integer i=24; i>0; i--){
            Date fecha = fechaHoy.addMonths(-i);
            FechasDeAcaADosAnios.add(fecha.month()+'/'+fecha.year());
        }
        
        fechasJson = JSON.serialize(FechasDeAcaADosAnios);
        system.debug(FechasDeAcaADosAnios.size());
        system.debug(FechasDeAcaADosAnios);
    }
    
    public List<SelectOption> getRespuestas() {
        
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('1',''));
        options.add(new SelectOption('2',''));
        options.add(new SelectOption('3',''));
        options.add(new SelectOption('4',''));
        options.add(new SelectOption('5',''));
        
        return options;
        
    }
    
    public void pruebaCheckbox(){
        
        if(fourPlanning.Facturacion__c != null){
            fourPlanning.Facturacion__c = null;
        }
        
        if(fourPlanning.Qu_presupuesto_anual_maneja_tu_cliente__c != null){
            fourPlanning.Qu_presupuesto_anual_maneja_tu_cliente__c = null;
        }
        
        update fourplanning;
    }
    
    public void generarWrapperDeOportunidadesParaElGraficoDePresupuestos(){
        
        List<Opportunity> oportunidadesCerradasEnElUltimoAnio = new List<Opportunity>();
        List<Opportunity> oporunidadesCerradasAnioAnterior = new List<Opportunity>();
        List<Opportunity> oportunidadesCerradasAnioActual = new List<Opportunity>();
        
        Date fechaUnAnioAtras = Date.today().addYears(-1);
        Date inicioAnioAnterior = Date.newInstance(Date.today().addYears(-1).year(), 1, 1);
        Date finalAnioAnterior = Date.newInstance(Date.today().addYears(-1).year(), 12, 31);
        
        Map<String,Double> lineaDeNegocioConSuValorNav = new Map<String,Double>();
        Map<String,Double> lineaDeNegocioConSuValorNavAnioAnterior = new Map<String,Double>();
        Map<String,Double> lineaDeNegocioConSuValorNavAnioActual = new Map<String,Double>();
        
        
        Set<String> objectFields = Schema.SObjectType.Opportunity.fields.getMap().keySet();
        if( objectFields.contains('bi_net_annual_value_nav__c') && objectFields.contains('bi_opportunity_type__c') ) {
            oporunidadesCerradasAnioAnterior = DataBase.query('select id, bi_net_annual_value_nav__c, bi_opportunity_type__c from opportunity WHERE accountId =: idCuenta AND IsWon = true AND bi_opportunity_type__c != null AND closeDate >=: inicioAnioAnterior AND closeDate <=: finalAnioAnterior AND bi_net_annual_value_nav__c != NULL AND bi_net_annual_value_nav__c > 0 ORDER BY bi_opportunity_type__c ASC limit 300');
            oportunidadesCerradasAnioActual = DataBase.query('select id, bi_net_annual_value_nav__c, bi_opportunity_type__c from opportunity WHERE accountId =: idCuenta AND IsWon = true AND bi_opportunity_type__c != null AND closeDate >=: finalAnioAnterior AND bi_net_annual_value_nav__c != NULL AND bi_net_annual_value_nav__c > 0 ORDER BY bi_opportunity_type__c ASC limit 300');
            
            
            
            for(Opportunity oportunidad: oporunidadesCerradasAnioAnterior){
                
                String lineaDeNegocio = (String)oportunidad.get('bi_opportunity_type__c');
                
                if(lineaDeNegocioConSuValorNavAnioAnterior.get(lineaDeNegocio) == null){
                    lineaDeNegocioConSuValorNavAnioAnterior.put( lineaDeNegocio, (Double)oportunidad.get('bi_net_annual_value_nav__c') );
                }else{
                    Double valorInicial = lineaDeNegocioConSuValorNavAnioAnterior.get(lineaDeNegocio);
                    lineaDeNegocioConSuValorNavAnioAnterior.put(lineaDeNegocio, valorInicial + (Double)oportunidad.get('bi_net_annual_value_nav__c') );
                }
            }
            
            for(Opportunity oportunidad: oportunidadesCerradasAnioActual){
                
                String lineaDeNegocio = (String)oportunidad.get('bi_opportunity_type__c');
                
                if(lineaDeNegocioConSuValorNavAnioActual.get(lineaDeNegocio) == null){
                    lineaDeNegocioConSuValorNavAnioActual.put( lineaDeNegocio, (Double)oportunidad.get('bi_net_annual_value_nav__c') );
                }else{
                    Double valorInicial = lineaDeNegocioConSuValorNavAnioActual.get(lineaDeNegocio);
                    lineaDeNegocioConSuValorNavAnioActual.put(lineaDeNegocio, valorInicial + (Double)oportunidad.get('bi_net_annual_value_nav__c') );
                }
            }
            
            
            
            for(String lineaDeNegocio: lineaDeNegocioConSuValorNavAnioAnterior.keySet()){
                WrapperOportunidadGrafico wpp = new WrapperOportunidadGrafico(lineaDeNegocio, lineaDeNegocioConSuValorNavAnioAnterior.get(lineaDeNegocio));
                WrappersOportunidadesParaElGraficoAnioAnterior.add(wpp);
            }
            
            for(String lineaDeNegocio: lineaDeNegocioConSuValorNavAnioActual.keySet()){
                WrapperOportunidadGrafico wpp = new WrapperOportunidadGrafico(lineaDeNegocio, lineaDeNegocioConSuValorNavAnioActual.get(lineaDeNegocio));
                WrappersOportunidadesParaElGraficoAnioActual.add(wpp);
            }
            
        }else{
            //Si no tiene esos campos por que son propios de telefonica.
            oporunidadesCerradasAnioAnterior = DataBase.query('select id, certa_scp__nav_certa__c, certa_scp__linea_de_negocio__c from opportunity WHERE accountId =: idCuenta AND IsWon = true AND certa_scp__linea_de_negocio__c != null AND closeDate >=: inicioAnioAnterior AND closeDate <=: finalAnioAnterior  AND certa_scp__nav_certa__c != NULL AND certa_scp__nav_certa__c > 0 ORDER BY certa_scp__linea_de_negocio__c ASC limit 300');
            oportunidadesCerradasAnioActual = DataBase.query('select id, certa_scp__nav_certa__c, certa_scp__linea_de_negocio__c from opportunity WHERE accountId =: idCuenta AND IsWon = true AND certa_scp__linea_de_negocio__c != null AND closeDate >=: finalAnioAnterior  AND certa_scp__nav_certa__c != NULL AND certa_scp__nav_certa__c > 0 ORDER BY certa_scp__linea_de_negocio__c ASC limit 300');
            
            
            
            for(Opportunity oportunidad: oporunidadesCerradasAnioAnterior){
                
                String lineaDeNegocio = (String)oportunidad.get('certa_scp__linea_de_negocio__c');
                
                if(lineaDeNegocioConSuValorNavAnioAnterior.get(lineaDeNegocio) == null){
                    lineaDeNegocioConSuValorNavAnioAnterior.put( lineaDeNegocio, (Double)oportunidad.get('certa_scp__nav_certa__c') );
                }else{
                    Double valorInicial = lineaDeNegocioConSuValorNavAnioAnterior.get(lineaDeNegocio);
                    lineaDeNegocioConSuValorNavAnioAnterior.put(lineaDeNegocio, valorInicial + (Double)oportunidad.get('certa_scp__nav_certa__c') );
                }
            }
            
            for(Opportunity oportunidad: oportunidadesCerradasAnioActual){
                
                String lineaDeNegocio = (String)oportunidad.get('certa_scp__linea_de_negocio__c');
                
                if(lineaDeNegocioConSuValorNavAnioActual.get(lineaDeNegocio) == null){
                    lineaDeNegocioConSuValorNavAnioActual.put( lineaDeNegocio, (Double)oportunidad.get('certa_scp__nav_certa__c') );
                }else{
                    Double valorInicial = lineaDeNegocioConSuValorNavAnioActual.get(lineaDeNegocio);
                    lineaDeNegocioConSuValorNavAnioActual.put(lineaDeNegocio, valorInicial + (Double)oportunidad.get('certa_scp__nav_certa__c') );
                }
            }
            
            
            
            for(String lineaDeNegocio: lineaDeNegocioConSuValorNavAnioAnterior.keySet()){
                WrapperOportunidadGrafico wpp = new WrapperOportunidadGrafico(lineaDeNegocio, lineaDeNegocioConSuValorNavAnioAnterior.get(lineaDeNegocio));
                WrappersOportunidadesParaElGraficoAnioAnterior.add(wpp);
            }
            
            for(String lineaDeNegocio: lineaDeNegocioConSuValorNavAnioActual.keySet()){
                WrapperOportunidadGrafico wpp = new WrapperOportunidadGrafico(lineaDeNegocio, lineaDeNegocioConSuValorNavAnioActual.get(lineaDeNegocio));
                WrappersOportunidadesParaElGraficoAnioActual.add(wpp);
            }
        }
        
        
        
        listaOportunidadesJsonAnioAnterior = JSON.serialize(WrappersOportunidadesParaElGraficoAnioAnterior);
        listaOportunidadesJsonAnioActual = JSON.serialize(WrappersOportunidadesParaElGraficoAnioActual);
        
        system.debug(listaOportunidadesJsonAnioAnterior);
        system.debug(listaOportunidadesJsonAnioActual);
        
        
    }
    
    public void obtenerPresupuestos(){
        presupuestos = [SELECT id, Categoria__c, Anio__c, Presupuesto_Total__c, Presupuesto_Nosotros__c,
                        Presupuesto_Competencia__c, Presupuesto_Disponible__c 
                        from X4PlanningProPresupuesto__c where FourPlanning__c =: fourPlanning.id];
        
        
        
        for (Integer i = 0; i < presupuestos.size(); i++) {
            
            for (Integer j = presupuestos.size() - 1; j > i; j--) {
                if (presupuestos.get(i).Anio__c > presupuestos.get(j).Anio__c) {
                    
                    X4PlanningProPresupuesto__c tmp = presupuestos.get(i);
                    presupuestos.set(i,presupuestos.get(j)) ;
                    presupuestos.set(j,tmp);
                    
                }
                
            }
            
        }
        
        
        
    }
    
    public void obtenerTotales(){
        totalNosotros = 0;
        totalCompetencia = 0;
        totalDisponible = 0;
        
        for(X4PlanningProPresupuesto__c pre : presupuestos){
            totalNosotros = totalNosotros + pre.Presupuesto_Nosotros__c;
            totalCompetencia = totalCompetencia + pre.Presupuesto_Competencia__c;
            totalDisponible = totalDisponible + pre.Presupuesto_Disponible__c;
        }
        
        for(X4PlanningProPresupuesto__c pre : presupuestos){
            
            wrapperPresupuesto wpp = new wrapperPresupuesto(pre.anio__c, pre.Presupuesto_Nosotros__c, pre.Presupuesto_Competencia__c, pre.Presupuesto_Disponible__c); 
            
            wrapperPresupuesto presupuesto = mapaPresupuestos.get(pre.Anio__c);
            
            if(presupuesto == null){
                mapaPresupuestos.put(pre.anio__c, wpp);
            }
            else{
                presupuesto.nosotros= presupuesto.nosotros + pre.Presupuesto_Nosotros__c;
                presupuesto.competencia= presupuesto.competencia + pre.Presupuesto_Competencia__c;
                presupuesto.disponible = presupuesto.disponible + pre.Presupuesto_Disponible__c;
            }
            
        }
        
        listaFinalPresupuestos = mapaPresupuestos.values();
        
        
        /*for (Integer i = 0; i < listaFinalPresupuestos.size(); i++) {

for (Integer j = listaFinalPresupuestos.size() - 1; j > i; j--) {
if (listaFinalPresupuestos.get(i).anio > listaFinalPresupuestos.get(j).anio) {

wrapperPresupuesto tmp = listaFinalPresupuestos.get(i);
listaFinalPresupuestos.set(i,listaFinalPresupuestos.get(j)) ;
listaFinalPresupuestos.set(j,tmp);

}

}

}*/
        
        mapaPresupuestos = new Map<String, wrapperPresupuesto>();
        listaPresupuestosJson = JSON.serialize(listaFinalPresupuestos);
        
    }
    
    //No se utiliza mas    
    public PageReference generarAreas(){
        
        tituloArea1 = fourPlanning.Titulo_Area_1__c;
        tituloArea2 = fourPlanning.Titulo_Area_2__c;
        tituloArea3 = fourPlanning.Titulo_Area_3__c;
        tituloArea4 = fourPlanning.Titulo_Area_4__c;
        tituloArea5 = fourPlanning.Titulo_Area_5__c;    
        
        
        system.debug(tituloArea1);
        system.debug(tituloArea2);
        system.debug(tituloArea3);
        system.debug(tituloArea4);
        system.debug(tituloArea5);
        system.debug(fourPlanning.FourPlanning_Area_1__c);
        
        List<FourPlanning_Area__c> areasAInsertar = new List<FourPlanning_Area__c>();
        
        //Creacion o  Asignacion -- Area 1
        if(tituloArea1 != null && fourPlanning.FourPlanning_Area_1__c == null){
            FourPlanning_Area__c area1 = new FourPlanning_Area__c();
            area1.Numero_de_Area__c = 1;
            area1.Titulo_Area__c = tituloArea1;
            area1.name = 'Area 1';
            
            //crear Los 3 Retos para esa area
            areasAInsertar.add(area1);
            
            //voy a tener que updatear el fourPlanning con estos datos(lo hago cuando guarda).
        }else{
            if(tituloArea1 != null && fourPlanning.FourPlanning_Area_1__c != null){
                //system.debug(tituloArea1);
                //system.debug(fourPlanning.FourPlanning_Area_1__c);
                //system.debug(fourPlanning.FourPlanning_Area_1__r.Titulo_Area__c);
                retosArea1 = conseguirRetos(fourPlanning.FourPlanning_Area_1__c);
            }
        }
        
        system.debug(tituloArea2);
        system.debug(fourPlanning.FourPlanning_Area_2__c);
        
        //Creacion o  Asignacion -- Area 2
        if(tituloArea2 != null && fourPlanning.FourPlanning_Area_2__c == null){
            FourPlanning_Area__c area2 = new FourPlanning_Area__c();
            area2.Numero_de_Area__c = 2;
            area2.Titulo_Area__c = tituloArea2;
            area2.name = 'Area 2';
            
            areasAInsertar.add(area2);
        }else{
            if(tituloArea2 != null && fourPlanning.FourPlanning_Area_2__c != null){
                //system.debug(tituloArea2);
                //system.debug(fourPlanning.FourPlanning_Area_2__r.Titulo_Area__c);
                
                retosArea2 = conseguirRetos(fourPlanning.FourPlanning_Area_2__c);
            }
        }
        
        system.debug(tituloArea3);
        system.debug(fourPlanning.FourPlanning_Area_3__c);
        
        //Creacion o  Asignacion -- Area 3
        if(tituloArea3 != null && fourPlanning.FourPlanning_Area_3__c == null){
            FourPlanning_Area__c area3 = new FourPlanning_Area__c();
            area3.Numero_de_Area__c = 3;
            area3.Titulo_Area__c = tituloArea3;
            area3.name = 'Area 3';
            
            areasAInsertar.add(area3);
        }else{
            if(tituloArea3 != null && fourPlanning.FourPlanning_Area_3__c != null){
                system.debug(tituloArea3);
                system.debug(fourPlanning.FourPlanning_Area_3__r.Titulo_Area__c);
                
                retosArea3 = conseguirRetos(fourPlanning.FourPlanning_Area_3__c);
            }
        }
        
        //Creacion o  Asignacion -- Area 4
        if(tituloArea4 != null && fourPlanning.FourPlanning_Area_4__c == null){
            FourPlanning_Area__c area4 = new FourPlanning_Area__c();
            area4.Numero_de_Area__c = 4;
            area4.Titulo_Area__c = tituloArea4;
            area4.name = 'Area 4';
            
            areasAInsertar.add(area4);
        }else{
            if(tituloArea4 != null && fourPlanning.FourPlanning_Area_4__c != null){
                system.debug(tituloArea4);
                system.debug(fourPlanning.FourPlanning_Area_4__r.Titulo_Area__c);
                
                retosArea4 = conseguirRetos(fourPlanning.FourPlanning_Area_4__c);
            }
        }
        
        //Creacion o  Asignacion -- Area 5
        if(tituloArea5 != null && fourPlanning.FourPlanning_Area_5__c == null){
            FourPlanning_Area__c area5 = new FourPlanning_Area__c();
            area5.Numero_de_Area__c = 5;
            area5.Titulo_Area__c = tituloArea5;
            area5.name = 'Area 5';
            
            areasAInsertar.add(area5);
        }else{
            if(tituloArea5 != null && fourPlanning.FourPlanning_Area_5__c != null){
                system.debug(tituloArea5);
                system.debug(fourPlanning.FourPlanning_Area_5__r.Titulo_Area__c);
                
                retosArea5 = conseguirRetos(fourPlanning.FourPlanning_Area_5__c);
            }
        }
        
        insertarAreas(areasAInsertar);
        
        for(FourPlanning_Area__c area :areasAInsertar){
            if(fourPlanning.FourPlanning_Area_1__c == null){
                fourPlanning.FourPlanning_Area_1__c = area.id;
            }else{
                if(fourPlanning.FourPlanning_Area_2__c == null){
                    fourPlanning.FourPlanning_Area_2__c = area.id;
                }else{
                    if(fourPlanning.FourPlanning_Area_3__c == null){
                        fourPlanning.FourPlanning_Area_3__c = area.id;
                    }else{
                        if(fourPlanning.FourPlanning_Area_4__c == null){
                            fourPlanning.FourPlanning_Area_4__c = area.id;
                        }else{
                            if(fourPlanning.FourPlanning_Area_5__c == null){
                                fourPlanning.FourPlanning_Area_5__c = area.id;
                            }else{
                                system.debug('aca no');
                            }
                        }   
                    }
                }
            }
        }
        
        //system.debug(fourPlanning.FourPlanning_Area_2__c);
        //system.debug(fourPlanning.FourPlanning_Area_3__c);
        
        guardarFourPlanning();
        //system.debug(retosArea2);
        return null;
    }
    
    public void obtenerEventosBackShops(){
        
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
        
        //Ingresos anuales del cliente.
        if(fourPlanning.Facturacion__c != null){
            condicion += ' AND ( (Ingresos_anuales_del_cliente__c = '+fourPlanning.Facturacion__c+' AND Ingresos_anuales_del_cliente_condicion__c = NULL) OR (Ingresos_anuales_del_cliente__c = NULL AND Ingresos_anuales_del_cliente_condicion__c = NULL) OR (Ingresos_anuales_del_cliente__c > '+fourPlanning.Facturacion__c+' AND Ingresos_anuales_del_cliente_condicion__c = \'<\' ) OR (Ingresos_anuales_del_cliente__c < '+fourPlanning.Facturacion__c+' AND Ingresos_anuales_del_cliente_condicion__c = \'>\' ) ) ';
        }
        
        //Cantidad de sucursales.
        if(fourPlanning.Cantidad_de_sucursales__c != null){
            condicion += ' AND ( (Indica_la_cantidad_de_sucursales__c = '+fourPlanning.Cantidad_de_sucursales__c+' AND Indica_la_cantidad_de_sucursales_cond__c = NULL) OR (Indica_la_cantidad_de_sucursales__c = NULL AND Indica_la_cantidad_de_sucursales_cond__c = NULL) OR (Indica_la_cantidad_de_sucursales__c > '+fourPlanning.Cantidad_de_sucursales__c+' AND Indica_la_cantidad_de_sucursales_cond__c = \'<\' ) OR (Indica_la_cantidad_de_sucursales__c < '+fourPlanning.Cantidad_de_sucursales__c+' AND Indica_la_cantidad_de_sucursales_cond__c = \'>\' ) ) ';
        }
        
        //Cantidad de empleados.
        if(fourPlanning.Cantidad_de_empleados_exacto__c != null){
            condicion += ' AND ( (cantidad_de_empleados__c = '+fourPlanning.Cantidad_de_empleados_exacto__c+' AND cantidad_de_empleados_condicion__c = NULL) OR (cantidad_de_empleados__c = NULL AND cantidad_de_empleados_condicion__c = NULL) OR (cantidad_de_empleados__c > '+fourPlanning.Cantidad_de_empleados_exacto__c+' AND cantidad_de_empleados_condicion__c = \'<\' ) OR (cantidad_de_empleados__c < '+fourPlanning.Cantidad_de_empleados_exacto__c+' AND cantidad_de_empleados_condicion__c = \'>\' ) ) ';
        }
        
        //Cantidad de edificios.
        if(fourPlanning.Cantidad_de_sedes_exactas__c != null){
            condicion += ' AND ( (Cantidad_de_edificios__c = '+fourPlanning.Cantidad_de_sedes_exactas__c+' AND Cantidad_de_edificios_condicion__c = NULL) OR (Cantidad_de_edificios__c = NULL AND Cantidad_de_edificios_condicion__c = NULL) OR (Cantidad_de_edificios__c > '+fourPlanning.Cantidad_de_sedes_exactas__c+' AND Cantidad_de_edificios_condicion__c = \'<\' ) OR (Cantidad_de_edificios__c < '+fourPlanning.Cantidad_de_sedes_exactas__c+' AND Cantidad_de_edificios_condicion__c = \'>\' ) ) ';
        }
        
        //Dispone de parque automotor
        if(fourPlanning.Dispone_de_parque_automotor__c != null){
            condicion += ' AND ( ispone_de_parque_automotor__c = \''+fourPlanning.Dispone_de_parque_automotor__c+'\' OR ispone_de_parque_automotor__c = NULL ) ';
        }
        
        //De cuantos vehículos dispone el parque
        //condicion += ' AND ( (cuantos_veh_culos_dispone_el_parque__c = '+fourPlanning.De_cuantos_veh_culos_dispone_el_parque__c+' AND cuantos_veh_culos_dispone_el_parque_cond__c = NULL) OR (cuantos_veh_culos_dispone_el_parque__c = NULL AND cuantos_veh_culos_dispone_el_parque_cond__c = NULL) OR (cuantos_veh_culos_dispone_el_parque__c > '+fourPlanning.De_cuantos_veh_culos_dispone_el_parque__c+' AND cuantos_veh_culos_dispone_el_parque_cond__c = \'<\' ) OR (cuantos_veh_culos_dispone_el_parque__c < '+fourPlanning.De_cuantos_veh_culos_dispone_el_parque__c+' AND cuantos_veh_culos_dispone_el_parque_cond__c = \'>\' ) ) ';
        
        system.debug(condicion);
        eventosBackShop = database.query('select id, name, Descripcion__c, Link__c, createdDate from Evento_BackShop__c '+condicion+' ORDER BY createdDate DESC Limit 7');
        
        if(eventosBackShop == null){
            eventosBackShop = new List<Evento_BackShop__c>();
        }
        
        List<id> idEventos = new List<Id>();
        for(Evento_BackShop__c evento: eventosBackShop){
            idEventos.add(evento.id);
        }
        
        
        List<Evento_BackShop__c> listaTemporal = new List <Evento_BackShop__c>();
        listaTemporal = [Select id, name, Descripcion__c, Link__c, FiltroCuenta__c, createdDate from Evento_BackShop__c where FiltroCuenta__c =: idCuenta];
        eventosBackShop.addAll(listaTemporal);
        system.debug(listaTemporal);
        
        for(Evento_BackShop__c event: listaTemporal){
            idEventos.add(event.id);
        }
        
        
        List<Historial_evento_backShop__c> historialEventos = [select id, Evento_BackShop__c, cuenta__c, Es_de_utilidad__c, Identificar_Negocio__c, NoSeUtilizo__c, Por_que_no_util__c, Por_que_no_negocio__c
                                                               from Historial_evento_backShop__c 
                                                               where cuenta__c =: idCuenta AND Evento_BackShop__c IN: idEventos];
        
        Map< Id, Historial_evento_backShop__c> historialesPorBackShop = new Map<Id,Historial_evento_backShop__c>();
        for(Historial_evento_backShop__c historial: historialEventos){
            historialesPorBackShop.put(historial.Evento_BackShop__c, historial);
        }
        
        wppEventos = new List<WrapperEventosBackShop>();
        for(Evento_BackShop__c evento: eventosBackShop){
            WrapperEventosBackShop wpp = new WrapperEventosBackShop(evento);
            
            if(historialesPorBackShop.get(evento.id) != null){
                wpp.historial = historialesPorBackShop.get(evento.id);
            }
            
            wppEventos.add(wpp);
        }
        
        
    }
    
    public void insertar4Planning(){
        if(FourPlanning.id == null){
            insert fourPlanning;
        } 
    }
    
    public void obtenerHitos(){
        
        if(fourPlanning.id != null){
            hitos = [SELECT ID, Descripcion__c, Fecha__c, FourPlanning__c, Categoria__c 
                     FROM FourPlanning_Hito__c
                     WHERE FourPlanning__c =: fourPlanning.id];    
        }
    }
    
    public List<FourPlanning_Reto__c> conseguirRetos(Id idArea){
        
        List<FourPlanning_Reto__c> retosAConseguir = new List<FourPlanning_Reto__c>();
        
        retosAConseguir = [SELECT ID, Competidor__c, Contactos_del_Cliente__c, Etapa_del_Reto__c, Fecha_Compromiso__c, FourPlanning_Area__c,
                           Nombre_del_Reto__c, Nota__c, Otro_Contacto__c, Productos_a_Desarrollar_Vender__c, Estado_de_la_solucion__c, Otros_contactos_del_cliente__c,
                           Nivel_de_relaci_n_contacto__c, Observacion_solucion_elejida__c, Pidio_ayuda_a_ventas__c,
                           (select id, CloseDate, name from Oportunidades__r)
                           FROM FourPlanning_Reto__c 
                           WHERE FourPlanning_Area__c =: idArea];
        
        return retosAConseguir;
    }
    
    public PageReference guardoPro(){
        
        if(fourplanning.X4_Planning_Pro__c == true){
            fourplanning.X4_Planning_Pro__c = false;
        }
        else{
            fourplanning.X4_Planning_Pro__c=true;
        }
        
        
        return null;
    }
    
    public PageReference guardarFourPlanningCompleto(){
        
        fourPlanning.Agenda_de_Trabajo_1__c = contactoEjecutivo1;
        fourPlanning.Agenda_de_Trabajo_2__c = contactoEjecutivo2;
        fourPlanning.Agenda_de_Trabajo_3__c = contactoEjecutivo3;
        fourPlanning.Agenda_de_Trabajo_4__c = contactoEjecutivo4;
        
        fourPlanning.Top_5_de_proveedores__c = relacionInstitucional1;
        fourPlanning.vinculo_direccion_tecnologia__c = relacionInstitucional2;
        fourPlanning.prospecta_venta_tecnologia_cliente__c = relacionInstitucional3;
        fourPlanning.esta_en_el_futuro_del_cliente__c = relacionInstitucional4;
        fourPlanning.lanes_estrat_gicos_de_tu_cliente__c = relacionInstitucional5;
        
        //aca tiene que guardar tambien las agenda de trabajo.  
        /////////VENCIMIENTOS///////////
        
        update solucionesEnCuenta;

        if(fourPlanning.id == null){
            insert fourPlanning;
        }
                
        for(X4PlanningProPresupuesto__c pr :presupuestos){
            calcularPresupuestoDisponible(pr);
        }
        
        CalculadorDelConocimientoDeLaCuenta calculador = new CalculadorDelConocimientoDeLaCuenta(fourPlanning);
        calculador.obtenerCalculoDeCoeficienteDelDesarrolloDelCliente();
        
        //guardo el conocimientoDeLaCuenta en un objeto, si cambio
        
        Double valorDeConocimientoAnterior = fourPlanning.conocimiento_de_la_cuenta__c;
        fourPlanning.conocimiento_de_la_cuenta__c = calculador.conocimientoDeLaCuenta;
        
        
        erroresAMostrar = new List<String>();
        
        //rangoedificios
        if (fourPlanning.Cantidad_de_sedes_exactas__c == null) {
            erroresAMostrar.add(Label.Pregunta_Obligatoria_DescripcionCliente + ' ' + Label.Cantidad_de_edificios_centrales_y_o_administrativos );
            
        }
        
        if (fourPlanning.Cantidad_de_sucursales__c == null) {
            
            if(this.getEsSectorPublico()){
                erroresAMostrar.add(Label.Pregunta_Obligatoria_DescripcionCliente + ' ' + Label.Numero_Centros_Institucion );}
            else{
                erroresAMostrar.add(Label.Pregunta_Obligatoria_DescripcionCliente + ' ' + Label.Indica_la_cantidad_de_sucursales );
            }
            
        }
        
        if (fourPlanning.Cantidad_de_empleados_exacto__c == null) {
            
            if(this.getEsSectorPublico()){
                erroresAMostrar.add(Label.Pregunta_Obligatoria_DescripcionCliente + ' ' + Label.Numero_empleados_organismo );}
            else{
                erroresAMostrar.add(Label.Pregunta_Obligatoria_DescripcionCliente + ' ' + Label.Cantidad_empleados );
            }
            
        }
        
        if (fourPlanning.Dispone_de_parque_automotor__c == null) {
            if(this.getEsSectorPublico()){
                erroresAMostrar.add(Label.Pregunta_Obligatoria_DescripcionCliente + ' ' + Label.Organismo_Parque_Automotor );}
            else{
                erroresAMostrar.add(Label.Pregunta_Obligatoria_DescripcionCliente + ' ' + Label.El_cliente_dispone_de_parque_automotor);
            }   
        }  
        
        if (fourPlanning.Frecuencia_de_Contacto_con_el_Cliente__c == null) {
            erroresAMostrar.add(Label.Pregunta_Obligatoria_ContactoEjecutivo + ' ' + Label.Con_qu_frecuencia_nos_reunimos_con_el_cliente);
        } 
        
        if (fourPlanning.Agenda_Periodica_Operacional__c == null) {
            erroresAMostrar.add(Label.Pregunta_Obligatoria_ContactoEjecutivo + ' ' + Label.Tenemos_agenda_peri_dica_operacional_sobre_la_calidad_de_los_servicios_prestado);   
        } 
        
        
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

        
        for (String errorAMostrar : erroresAMostrar) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, errorAMostrar);
            ApexPages.addMessage(myMsg);
        }
        
        
        if(erroresAMostrar.size() == 0 
           && fourPlanning.Cantidad_de_sedes_exactas__c != null 
           && fourPlanning.Cantidad_de_sucursales__c != null 
           && fourPlanning.Dispone_de_parque_automotor__c != null 
           && fourPlanning.Frecuencia_de_Contacto_con_el_Cliente__c != null 
           && fourPlanning.Agenda_Periodica_Operacional__c != null){
               
               calcularPorcentajeCuestionarioCompleto();
               update fourPlanning; 
               
               try{
                   update cuenta;
               }catch(Exception e){
                   
               }
               
           }
        
        if(valorDeConocimientoAnterior != calculador.conocimientoDeLaCuenta){
            
            //consigo los conocimientosYaCreados
            List<FourPlanning_CoeCuenta__c> coeficientesCuentas = [SELECT ID, Creacion_del_valor__c
                                                                   FROM FourPlanning_CoeCuenta__c 
                                                                   WHERE Cuenta__c =: idCuenta 
                                                                   ORDER BY Creacion_del_valor__c ASC];
            
            //conseguir el CoeCuenta del TrimestreActual, si es que existe.
            
            Date hoy = date.today();
            
            Integer mesActual = hoy.month();
            Integer anio = hoy.year();
            
            Date fechaMinima;
            Date fechaMaxima;
            
            if(mesActual >= 7){
                if(mesActual >= 10){
                    //Cuarto trimestre, del 1-10 al 31-12
                    fechaMinima = Date.newInstance(hoy.year(), 10, 1);
                    fechaMaxima = Date.newInstance(hoy.year(), 12, 31);
                }else{
                    //Tercer trimestre, del 1-7 al 30-9
                    fechaMinima = Date.newInstance(hoy.year(), 7, 1);
                    fechaMaxima = Date.newInstance(hoy.year(), 9, 30);
                }
            }else{
                if(mesActual >= 4){
                    //Segundo trimestre, del 1-4 al 30-6 
                    fechaMinima = Date.newInstance(hoy.year(), 4, 1);
                    fechaMaxima = Date.newInstance(hoy.year(), 6, 30);
                }else{
                    //Primer trimestre, del 1-1 al 31-3
                    fechaMinima = Date.newInstance(hoy.year(), 1, 1);
                    fechaMaxima = Date.newInstance(hoy.year(), 3, 31);
                }
            } 
            
            FourPlanning_CoeCuenta__c coeCuenta = new FourPlanning_CoeCuenta__c();
            for(FourPlanning_CoeCuenta__c coe:coeficientesCuentas){
                if(coe.Creacion_del_valor__c <= fechaMaxima && coe.Creacion_del_valor__c >= fechaMinima){
                    coeCuenta = coe;
                }
            }
            
            //si hay 4, borro el mas viejo
            system.debug(coeficientesCuentas);
            if(coeficientesCuentas.size() > 3){
                delete coeficientesCuentas[0];
            }
            
            //guardo el coeficiente
            coeCuenta.Creacion_del_valor__c = Date.today();
            coeCuenta.Valor_Coeficiente_De_Cuenta__c = calculador.conocimientoDeLaCuenta;
            coeCuenta.Cuenta__c = idCuenta;
            system.debug(coeCuenta);
            
            upsert coeCuenta;
        }
        
        update iniciativasDelNegocioDelCliente;
        
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
        
        List<Historial_evento_backShop__c> historialesAUpdatear = new List<Historial_evento_backShop__c>();
        
        for(WrapperEventosBackShop wrapper : wppEventos){
            if(wrapper.historial != null){
                historialesAUpdatear.add(wrapper.historial);}
        }
        system.debug(historialesAUpdatear);
        
        update historialesAUpdatear;
        
        
        listaWrappersRetos = new List<WrapperReto>();
        obtenerAreas();
        
        return null;   
    }
    
    public void cambioContacto(){
        
        
        update fourPlanning;
        
        List<FourPlanning__c> fourPlannings = [SELECT ID, Facturacion__c, SeleccionMultipleContactoPublico__c, SeleccionMultiple__c, Rango_Sucursales__c, Nivel_Contacto_Publico__c, Otros_Servicios__c, Tiene_Presencia_Internacional__c, No_informa_dato__c, Fecha_Vencimiento_Contratos_Voz_Fija__c, Rango_Edificios__c, Empleados_Crece_Decrece_Matiene__c, Rango_Empleados__c, Cantidad_de_Empleados__c, Cantidad_de_Sedes__c, Parque_Automotor_Propio_o_Gestionado__c, Presencia_Regional__c,
                                               Mayor_Nivel_de_Contacto_con_el_Cliente__c, Frecuencia_de_Contacto_con_el_Cliente__c, Agenda_Periodica_Ejecutiva__c, Agenda_Periodica_Operacional__c,
                                               Frecuencia_Funcionarios_del_Cliente__c, Contacto_con_mayor_afinidad_1__c, Contacto_con_mayor_afinidad_1__r.Title, Contacto_con_mayor_afinidad_2__r.Title, Contacto_con_mayor_afinidad_3__r.Title, Contacto_con_mayor_afinidad_2__c, Contacto_con_mayor_afinidad_3__c,
                                               Desafio_de_la_Empresa_1__c,Desafio_de_la_Empresa_2__c, Desafio_de_la_Empresa_3__c, Competidor_Principal_1__c, Competidor_Principal_2__c, Competidor_Principal_3__c, Canal_Comercializacion_cliente__c,
                                               Canal_Comercializacion_que_mas_crece__c, Titulo_Area_1__c, Titulo_Area_2__c, Titulo_Area_3__c,Titulo_Area_4__c, Titulo_Area_5__c, Areas_que_Seria_Bueno_Trabajar__c, ISC__c, Area_que_fracasamos_en_el_pasado__c,
                                               Mejoraria_Relacion_Con_El_Cliente__c, realcion_empresa_otros_clientes__c, Vencimiento_Datos_Fijos__c, Vencimiento_Servicios_Moviles__c, Vencimiento_Otros_Servicios__c, 
                                               Evento_telefonica_cliente__c, Fecha_Evento__c, Hito_Relevante_1__c, Hito_Relevante_1_fecha__C, Hito_Relevante_2__c, Hito_Relevante_2_fecha__C, Hito_Relevante_3__c, 
                                               Hito_Relevante_3_fecha__c, FourPlanning_Area_1__r.Titulo_Area__c, FourPlanning_Area_1__c, FourPlanning_Area_2__r.Titulo_Area__c, FourPlanning_Area_2__c, 
                                               FourPlanning_Area_3__r.Titulo_Area__c, FourPlanning_Area_3__c, FourPlanning_Area_4__r.Titulo_Area__c, Agenda_de_Trabajo_1__c, Agenda_de_Trabajo_2__c, Agenda_de_Trabajo_3__c,
                                               Agenda_de_Trabajo_4__c, Agenda_de_Trabajo_5__c, Cuenta__r.Micro_Industry__c, cuenta__r.Industry, Nivel_de_conocimiento_area1__c,Nivel_de_conocimiento_area2__c,
                                               Nivel_de_conocimiento_area3__c, Nivel_de_conocimiento_area4__c, Nivel_de_conocimiento_area5__c, FourPlanning_Area_4__c, FourPlanning_Area_5__r.Titulo_Area__c, FourPlanning_Area_5__c,
                                               Tipo_de_Banca__c, Ambito_de_actuacion__c, Numero_de_sucursales__c, Numero_de_Empleados__c, Canal_que_Dispone__c, Importancia_web__c, Importancia_red_de_cajeros__c,
                                               Importancia_crecimiento_oficinas__c, importancia_banca_movil__c, conocimiento_de_la_cuenta__c, Canal_de_comercializaci_n_multiple__c,
                                               Tipo_de_Extraccion__c, Volumen_de_Extraccion__c, Volumen_de_Produccion__c, flota_vehiculos_propios__c, centro_distribucion_propia__c, Cantidad_de_empleados_exacto__c,
                                               Cantidad_de_sedes_exactas__c, Cantidad_de_sucursales__c, Como_se_mantiene_el_numero_de_sucursales__c, Dispone_de_parque_automotor__c, Otro_nivel_de_contacto_con_cliente__c,
                                               comercializacion_que_mas_crece_multiple__c, Top_5_de_proveedores__c, vinculo_direccion_tecnologia__c, prospecta_venta_tecnologia_cliente__c, esta_en_el_futuro_del_cliente__c,
                                               lanes_estrat_gicos_de_tu_cliente__c, facturacion_cliente_garantizada__c, Porcentaje_facturacion_fija__c, Porcentaje_facturacion_variable__c, Qu_presupuesto_anual_maneja_tu_cliente__c,
                                               Le_afectan_los_cambios_politicos__c, Compra_de_caracter_politico_o__c, De_cuantos_veh_culos_dispone_el_parque__c, X4_Planning_Pro__c
                                               FROM FourPlanning__c 
                                               WHERE Cuenta__c =: idCuenta 
                                               LIMIT 1];
        
        
        
        
        if(fourPlannings.size() == 0 ){
            FourPlanning__c nuevoFourPlanning = new FourPlanning__c(Cuenta__c = idCuenta);
            fourPlanning = nuevoFourPlanning;
        }else{
            fourPlanning = fourPlannings[0];
        }
        
    }
    
    public void guardarFourPlanning(){
        update fourPlanning;
    }
    
    public void insertVencimiento(){
        
        system.debug('insertVencimiento');
        system.debug(familiaSeleccionada);
        if(familiaSeleccionada != null){
            SolucionEnCuenta__c sol = new SolucionEnCuenta__c();
            
            sol.Name= 'solucion';
            sol.Cuenta__c = idCuenta;
            sol.TipoSolucion__c = familiaSeleccionada; 
            
            insert sol;
            
            familiaSeleccionada = null;
            obtenerSolucionesEnCuenta();
        }
    }	
    
    public List<SelectOption> getRamas() {
        
        String pais = '';
        Set<String> objectFields = Schema.SObjectType.Account.fields.getMap().keySet();        
        if( objectFields.contains('bi_country__c') ) {
            list<Account> cuentasTelefonica = database.query('select id, bi_country__c from account where id=:idCuenta');
            
            if(cuentasTelefonica.size()>0){
                pais = (String)cuentasTelefonica[0].get('bi_country__c');
            }
            
        }else{
            pais = 'Argentina';
        }
        
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('--Ninguno--','--Ninguno--'));
        for(Linea_de_Servicio__c lineaDeServicio : [select id, name from Linea_de_Servicio__c where Catalogo__r.pais__c =: pais]){
            options.add(new SelectOption(lineaDeServicio.id,lineaDeServicio.name));
        }
        
        return options;
    }
    
    public List<SelectOption> getFamilias() {
        
        List<Solucion__c> familiasSeleccionadas = new List<Solucion__c>();
        
        familiasSeleccionadas = [select id, name from Solucion__c where Linea_de_Servicio__r.id =: lineaDeServicioSeleccionado];
        
        List<SelectOption> options = new List<SelectOption>();
        
        for(Solucion__c solucion : familiasSeleccionadas){
            options.add(new SelectOption(solucion.id,solucion.name));
        }
        
        return options;
    }
    
    public void borrarSolucionEnCuenta(){
        delete [select id from solucionEnCuenta__c where id=: delid];
        delid = '';
        
        obtenerSolucionesEnCuenta();
    }

    
    public void insertarAreas(List<FourPlanning_Area__c>areasAInsertar){
        
        insert areasAInsertar;
        
        List<FourPlanning_Reto__c> retosAInsertar = new List<FourPlanning_Reto__c>();
        List<FourPlanning_Reto__c> retosPorArea = new List<FourPlanning_Reto__c>();
        Map<Integer, List<FourPlanning_Reto__c> > mapaRetosPorNumeroDeArea = new Map<Integer, List<FourPlanning_Reto__c> >(); 

        
    }
    
    public void generarIniciativas(){
        
        iniciativasDelNegocioDelCliente = [SELECT Name, Strategic_Initiative__c, Titulo_Iniciativa__c, Strategic_Initiative_URL__c, LastModifiedDate, account__r.name, Title__c, 
                                           (SELECT name, Opportunity__c, Opportunity__r.Name FROM Opportunities__r WHERE Opportunity__r.Account.id = :idCuenta) 
                                           FROM Strategic_Initiative__c 
                                           WHERE Account__C = :idCuenta order by name];
        
    }
    
    public PageReference DeleteStrategicInitiatives() {
        
        Integer i = 0;
        
        for(Strategic_Initiative__c si : iniciativasDelNegocioDelCliente){
            
            if(si.id == this.delid){
                break;
            }
            else{
                i++;
            }   
        }
        
        if(iniciativasDelNegocioDelCliente[i].id != null){
            List<OpportunityStrategicInitiative__c> osi=[select Id from OpportunityStrategicInitiative__c where Strategic_Initiative__c = :iniciativasDelNegocioDelCliente[i].id];
            delete osi;
            delete iniciativasDelNegocioDelCliente[i];    
        }
        
        iniciativasDelNegocioDelCliente.remove(i);
        return null;
    }
    
    public Boolean getRenderBanca(){
        system.debug(fourPlanning.cuenta__r.Micro_Industry__c);
        return (fourPlanning.cuenta__r.Micro_Industry__c == 'Banca');
    }
    
    public Boolean getRenderMineria(){
        return (fourPlanning.cuenta__r.Micro_Industry__c == 'Mineria');
    }
    
    public Boolean getEsSectorPublico(){
        return (cuenta.Industry == 'Servicios Públicos' || cuenta.Industry == 'Sector Público');
    }
    
    public PageReference BorrarReto(){
        Integer i = 0;
        
        //areaDelRetoABorrar = new FourPlanning_Area__c();
        //retoABorrar = new FourPlanning_Reto__c();
        
        
        retoABorrar = [SELECT ID, FourPlanning_Area__c FROM FourPlanning_Reto__c WHERE ID =: retoABorrarId];
        
        areaDelRetoABorrar = [select id, Titulo_Area__c, Conocimiento_del_Area__c, Tipo_de_Area__c from FourPlanning_Area__c where id =: retoABorrar.FourPlanning_Area__c];
        
        retosDelArea = [Select id, Nombre_del_Reto__c, Etapa_del_Reto__c from FourPlanning_Reto__c where FourPlanning_Area__C =: areaDelRetoABorrar.id AND Nombre_del_Reto__c != NULL AND Etapa_del_Reto__c != NULL limit 2];
        
        if(retosDelArea.size() > 1){
            for(FourPlanning_Reto__c reto : retosTotales){
                
                if(reto.id == this.retoABorrarId){
                    break;
                }
                else{
                    i++;
                }   
            }
            
            //system.debug(retosTotales[i]);
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
    
    public PageReference BorrarPresupuesto(){
        
        system.debug(presupuestoABorrarId);
        
        Integer i = 0;
        
        for(X4PlanningProPresupuesto__c presupuesto : presupuestos){
            
            if(presupuesto.id == this.presupuestoABorrarId){
                break;
            }
            else{
                i++;
            }   
        }
        
        system.debug(i);
        system.debug(presupuestos[i]);
        
        
        
        
        system.debug(presupuestos);
        
        if(presupuestos[i].id != null){
            delete presupuestos[i];    
        }
        
        presupuestos.remove(i);
        obtenerPresupuestos();
        obtenerTotales();
        return null;    	
        
    }
    
    public void InsertIniciative() {
        
        newInitiative.account__c = idCuenta;
        
        if(newInitiative.Titulo_Iniciativa__c == 'Otro' && newInitiative.Title__c != null ){
            newInitiative.Titulo_Iniciativa__c = newInitiative.Title__c;}
        
        
        insert newInitiative;
        newInitiative = new Strategic_Initiative__c();
        generarIniciativas();
    }
    
    public void insertHito(){
        
        if(fourPlanning.id == null){
            guardarFourPlanning();
        }
        
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
        //select subject, Description, ActivityDate, Status,Priority,End_date__c, OwnerId, CreatedDate, Owner.Name, URL__C FROM Task WHERE WhatId = :account.id
        obtenerHitos();
    }
    
    public void insertarArea(){
        
        if(fourPlanning.id == null){
            guardarFourPlanning();
        }
        
        if(areaAInsertar.Titulo_Area__c != null){
            areaAInsertar.FourPlanning__c = fourPlanning.id;
            
            insert areaAInsertar;
            
            
            
            /* FourPlanning_Reto__c reto1 = new FourPlanning_Reto__c();
reto1.FourPlanning_Area__c = areaAInsertar.id;
FourPlanning_Reto__c reto2 = new FourPlanning_Reto__c();
reto2.FourPlanning_Area__c = areaAInsertar.id;
FourPlanning_Reto__c reto3 = new FourPlanning_Reto__c();
reto3.FourPlanning_Area__c = areaAInsertar.id;

insert reto1;
insert reto2;
insert reto3;*/
        }
        
        //areaAInsertar = new FourPlanning_Area__c();
        //select subject, Description, ActivityDate, Status,Priority,End_date__c, OwnerId, CreatedDate, Owner.Name, URL__C FROM Task WHERE WhatId = :account.id
        
        obtenerAreas();
    }
    
    public void cambioTodosADonuts(){
        donuts = true;
        barras = false;
    }
    
    public void cambioTodosABarras(){
        barras=true;
        donuts=false;
    }
    
    public void cambioTotalesADonuts(){
        totalDonuts = true;
        totalBarras = false;
    }
    
    public void cambioTotalesABarras(){
        totalBarras =true;
        totalDonuts = false;
    }
    
    public void insertarPresupuesto(){
        
        presupuestoAInsertar.FourPlanning__c = fourPlanning.id;
        
        calcularPresupuestoDisponible(presupuestoAInsertar);
        
        insert presupuestoAInsertar;
        
        presupuestoAInsertar = new X4PlanningProPresupuesto__c();
        
        obtenerPresupuestos();
        obtenerTotales();
        
    }
    
    public void obtenerSolucionesEnCuenta(){
        
        solucionesEnCuenta = [select id, name, Cuenta__c, Estado__c, Comentarios__c, TipoSolucion__c, TipoSolucion__r.Linea_de_Servicio__r.Name, TipoSolucion__r.Name,
                              FCV__c, Fecha_Fin_Contrato__c, Fecha_Inicio_Contrato__c, Proveedor__c, Reto__r.Nombre_del_Reto__c, Reto__c
                              from SolucionEnCuenta__c WHERE Cuenta__c =: idCuenta ORDER BY TipoSolucion__r.Linea_de_Servicio__r.Name ASC];  
        
    }
    
    public void calcularPresupuestoDisponible(X4PlanningProPresupuesto__c presupuestoAInsert){
        system.debug(presupuestoAInsert.Presupuesto_Total__c);
        system.debug(presupuestoAInsert.Presupuesto_Competencia__c);
        system.debug(presupuestoAInsert.Presupuesto_Nosotros__c);
        presupuestoAInsert.Presupuesto_Disponible__c =  presupuestoAInsert.Presupuesto_Total__c -  presupuestoAInsert.Presupuesto_Nosotros__c -  presupuestoAInsert.Presupuesto_Competencia__c;
        
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
    
    public void vincularRetoASolucion(){
        
        
        SolucionEnCuenta__c solucion = [select id, Reto__c from SolucionEnCuenta__c where id =: idDeSolucion];
        
        
        for(Integer i=0; i< listaWrappersRetos.size(); i++){
            if(listaWrappersRetos[i].vincular){
                solucion.Reto__c = listaWrappersRetos[i].reto.id;
                listaWrappersRetos[i].vincular = false;
            }
        }
        
        update solucion;
        
        obtenerSolucionesEnCuenta();
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
    
    public void insertarReto(){
        
        erroresAMostrar = new List<String>();
        
        //areaAInsertar.Titulo_Area__c = 'nombrePrueba';
        
        
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
        
        system.debug(solucionAInsertar2);
        crearWppOportunidad();
        
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
    
    public void obtenerAreas(){
        //tengo que obtener las areas, ahora las estoy obteniiedno de una subquery del 4Planning, ver si me traigo todo el 4Planning completo o solo las areas.
        
        List<FourPlanning_Area__c> todasLasAreas = [select id, Titulo_Area__c, Conocimiento_del_Area__c, Tipo_de_Area__c from FourPlanning_Area__c where FourPlanning__c =: fourPlanning.Id];
        
        crearWrappersDeAreas(todasLasAreas);
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
    
    public PageReference pruebita(){
        PageReference p = ApexPages.currentPage();
        
        
        p.setRedirect(true);    
        
        return p;
    }	
    
    public void renderizarPagina(){
        //lo utilizo para renderizar la pagina al comienzo para que no se genere el #text entre el titulo y el contenido del pageblock section. twisty    
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
    
    public PageReference irAPlanDeAccion() {
        
        String url = Page.PlanDeAccion.getURL();
        return new PageReference (url + '?id=' + idCuenta);
    }
    
    public PageReference irADesarrolloCuenta(){
        
        String url = Page.DesarrolloCuenta.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
    
    public PageReference irAEjesDeTrabajo(){
        
        String url = Page.EjesDeTrabajo.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
    
    public PageReference irAForYou(){
        
        String url = Page.ForYou.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
    
    public PageReference irACuestionario(){
        
        String url = Page.cuestionarioFourPlanning.getURL();
        return new PageReference (url + '?id=' + idCuenta);
    }
    
    public PageReference irAInicio(){
        String url = Page.Tab4Planning.getURL();
        return new PageReference (url);   
    }
    
    public PageReference borrarContacto(){
        
        WrapperReto retoDuenioDelContacto;
        for(WrapperReto reto:listaWrappersRetos){
            
            if(reto.reto.id == retoDeContactoABorrar){
                retoDuenioDelContacto = reto; 
            }
            
        }
        
        if(retoDuenioDelContacto != null){
            
            Integer i = 0;
            
            for(FourPlanning_Contacto__c contacto : retoDuenioDelContacto.contactos){
                
                if(contacto.id == contactoIdABorrar){
                    break;
                }
                else{
                    i++;
                }   
            }
            
            if(retoDuenioDelContacto.contactos[i].id != null){
                
                delete retoDuenioDelContacto.contactos[i];    
            }
            
            
            retoDuenioDelContacto.contactos.remove(i);        
            
            
        }
        
        return null;
    }
    
    public PageReference borrarSolucion(){
        
        WrapperReto retoDuenioDelContacto;
        for(WrapperReto reto:listaWrappersRetos){
            
            if(reto.reto.id == retoDeContactoABorrar){
                retoDuenioDelContacto = reto; 
            }
            
        }
        
        if(retoDuenioDelContacto != null){
            
            Integer i = 0;
            
            for(FourPlanning_Solucion__c solucion : retoDuenioDelContacto.soluciones){
                
                if(solucion.id == solucionIdABorrar){
                    break;
                }
                else{
                    i++;
                }   
            }
            
            if(retoDuenioDelContacto.soluciones[i].id != null){
                
                delete retoDuenioDelContacto.soluciones[i];    
            }
            
            
            retoDuenioDelContacto.soluciones.remove(i);        
            
            
        }
        
        return null;
    } 
    
    public void desvincularReto(){
        
        SolucionEnCuenta__c sol = [select id from SolucionEnCuenta__c where id =: solucionADesvincular];
        
        sol.Reto__c = null;
        
        update sol;
        
        obtenerSolucionesEnCuenta();        
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
    
    public void desvincularOportunidad(){
        
        Opportunity oportunidad = [select id from Opportunity where id =: OportunidadADesvincularId];
        oportunidad.FourPlanning_Reto__c = null;
        update oportunidad;
        
        cuenta = [select id, name, Region__c, Micro_Industry__c, Industry, X4_Planning_Pro__c,
                  (select id, name, FourPlanning_Reto__c, CloseDate from Opportunities where isClosed = false and CloseDate > today limit 900)
                  from account where id =: idCuenta];
        
        
        
        crearWppOportunidad();
        setearOportunidadesAContacto();
        listaWrappersRetos = new List<WrapperReto>();
        obtenerAreas();
        
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
    
    public PageReference calcularPorcentajeCuestionarioCompleto() {
        
        //Consigo todos los campos del objeto que cuentan para saber si esta completa o no
        //Si hay nuevos campos en el cuestionario que cuentan, alcanza solamente con agregarlo a esta lista y nada mas.
        List<String> camposQueCuentanParaElPromedio = new List<String>();
        
        //Descripcion del cliente
        camposQueCuentanParaElPromedio.add('facturacion__c');
        camposQueCuentanParaElPromedio.add('cantidad_de_empleados_exacto__c');
        //camposQueCuentanParaElPromedio.add('rango_empleados__c');
        camposQueCuentanParaElPromedio.add('cantidad_de_sedes_exactas__c');
        camposQueCuentanParaElPromedio.add('cantidad_de_sucursales__c');
        //camposQueCuentanParaElPromedio.add('rango_sucursales__c');
        camposQueCuentanParaElPromedio.add('como_se_mantiene_el_numero_de_sucursales__c');
        camposQueCuentanParaElPromedio.add('dispone_de_parque_automotor__c');
        camposQueCuentanParaElPromedio.add('presencia_regional__c');
        
        
        //Contacto Ejecutivo
        camposQueCuentanParaElPromedio.add('frecuencia_de_contacto_con_el_cliente__c');
        camposQueCuentanParaElPromedio.add('mayor_nivel_de_contacto_con_el_cliente__c');
        camposQueCuentanParaElPromedio.add('agenda_periodica_ejecutiva__c');
        camposQueCuentanParaElPromedio.add('agenda_periodica_operacional__c');
        camposQueCuentanParaElPromedio.add('contacto_con_mayor_afinidad_1__c');
        camposQueCuentanParaElPromedio.add('contacto_con_mayor_afinidad_2__c');
        camposQueCuentanParaElPromedio.add('contacto_con_mayor_afinidad_3__c');
        camposQueCuentanParaElPromedio.add('realcion_empresa_otros_clientes__c');
        // ver como los select radio.
        
        //Conocimiento negocio del cliente.
        camposQueCuentanParaElPromedio.add('competidor_principal_1__c');
        camposQueCuentanParaElPromedio.add('competidor_principal_2__c');
        camposQueCuentanParaElPromedio.add('competidor_principal_3__c');
        camposQueCuentanParaElPromedio.add('canal_de_comercializaci_n_multiple__c');        
        camposQueCuentanParaElPromedio.add('comercializacion_que_mas_crece_multiple__c');
        //camposQueCuentanParaElPromedio.add('facturacion_cliente_garantizada__c');
        
        
        //ver areas de trabajo.
        
        //Relacion Institucional
        camposQueCuentanParaElPromedio.add('top_5_de_proveedores__c');
        camposQueCuentanParaElPromedio.add('vinculo_direccion_tecnologia__c');
        camposQueCuentanParaElPromedio.add('prospecta_venta_tecnologia_cliente__c');
        camposQueCuentanParaElPromedio.add('esta_en_el_futuro_del_cliente__c');
        camposQueCuentanParaElPromedio.add('lanes_estrat_gicos_de_tu_cliente__c');
        
        //Hitos Relevantes
        camposQueCuentanParaElPromedio.add('vencimiento_datos_fijos__c');
        camposQueCuentanParaElPromedio.add('vencimiento_servicios_moviles__c');
        camposQueCuentanParaElPromedio.add('vencimiento_otros_servicios__c');
        camposQueCuentanParaElPromedio.add('evento_telefonica_cliente__c');
        camposQueCuentanParaElPromedio.add('fecha_evento__c');
        
        
        Integer completo = 0;
        
        //sumo cuantos campos de los que cuentan para el promedio fueron completados.
        for (String fieldName: camposQueCuentanParaElPromedio) {
            
            //system.debug(fieldName+' -- '+fourPlanning.get(fieldName));
            if(fourPlanning.get(fieldName) != null && fourPlanning.get(fieldName) != '' ){
                completo = completo + 1;
            }
            
        }
        
        //system.debug(completo);
        
        //obtengo el porcentaje de las 5 primeras secciones
        porcentaje = (completo * 70) / camposQueCuentanParaElPromedio.size(); 
        
        
        
        //calculo el 30% restante a partir de retos
        for (FourPlanning_Reto__c reto : retosTotales){
            
            if(reto.Nombre_del_Reto__c != null){
                porcentaje = porcentaje + 3.75;
            }
            
        }
        
        
        if (porcentaje > 100){
            porcentaje = 100;
        }
        
        
        fourPlanning.porcentaje_de_completitud_De_La_Cuenta__c = porcentaje;
        return null;
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
        
        //for(Integer indice: opportunidadesASacar){
        //  if(wppOportunidades[indice] == null){
        //wppOportunidades.remove(indice-1);}
        
        //}
        
        try{
            update oportunidadesAActualizarConIdDelReto; 
        }catch(Exception e){
            system.debug(e);
            
            
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage());
            ApexPages.addMessage(myMsg);
            
            
            
            obtenerAreas();
            
            
        }
        
        
        cuenta = [select id, name, Region__c, Micro_Industry__c, Industry, X4_Planning_Pro__c,
                  (select id, name, FourPlanning_Reto__c, CloseDate from Opportunities where isClosed = false and CloseDate > today limit 900)
                  from account where id =: idCuenta];
        
        obtenerAreas();
        crearWppOportunidad();
        
        system.debug(wppOportunidades);
        return null;
    }
    
    //la forma de asignarlos es el primer reto de cada area, hasta tener 3, si no llego a 3 consigo los 2dos retos de cada area y asi hasta completar 3.
    public void asignarRetos(Map<Integer, List<FourPlanning_Reto__c> > mapaRetosPorNumeroDeArea){
        
        system.debug(retosArea1);
        system.debug(retosArea2);
        system.debug(retosArea3);
        
        for(Integer i=0 ; i < mapaRetosPorNumeroDeArea.keySet().size() ; i++){
            
            if(retosArea1.size() == 0){
                retosArea1 = mapaRetosPorNumeroDeArea.get(i);
            }else{
                if(retosArea2.size() == 0){
                    retosArea2 = mapaRetosPorNumeroDeArea.get(i);
                }else{
                    if(retosArea3.size() == 0){
                        retosArea3 = mapaRetosPorNumeroDeArea.get(i);
                    }else{
                        if(retosArea4.size() == 0){
                            retosArea4 = mapaRetosPorNumeroDeArea.get(i); 
                        }else{
                            if(retosArea5.size() == 0){
                                retosArea5 = mapaRetosPorNumeroDeArea.get(i);
                            }else{
                                system.debug('aca no');
                            }
                        }  
                    }
                }
            }
        }
        
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
    
    public PageReference crearEventoUtil(){
        
        system.debug('entre');
        Historial_evento_backShop__c eventoHistorial = new Historial_evento_backShop__c();
        
        eventoHistorial.Cuenta__c = idCuenta;
        eventoHistorial.Evento_BackShop__c = idDelEvento;
        eventoHistorial.Es_de_utilidad__c = true;
        
        insert eventoHistorial;
        
        system.debug(wppEventos);
        
        obtenerEventosBackShops();
        
        system.debug(wppEventos);
        return null;
    }
    
    public PageReference actualizarEventoUtil(){
        
        
        List<Historial_evento_backShop__c> eventoHistorial = new List<Historial_evento_backShop__c>();
        eventoHistorial = [SELECT id, Cuenta__c, Evento_BackShop__c, Es_de_utilidad__c, NoSeUtilizo__c FROM Historial_evento_backshop__c WHERE Cuenta__c =: idCuenta AND Evento_BackShop__c =: idDelEvento AND Es_de_utilidad__C =: true];        
        
        if(eventoHistorial.size() >0){
            
            eventoHistorial[0].Es_de_utilidad__c = false;
            system.debug(eventoHistorial[0]);
            update eventoHistorial;}
        obtenerEventosBackShops();
        
        return null;
    }
    
    public PageReference crearEventoInutil(){
        
        Historial_evento_backShop__c eventoHistorial = new Historial_evento_backShop__c();
        eventoHistorial.Cuenta__c = idCuenta;
        eventoHistorial.Evento_BackShop__c = idDelEvento;
        eventoHistorial.Es_de_utilidad__c = false;
        
        insert eventoHistorial;
        
        obtenerEventosBackShops();
        
        return null;
    }
    
    public PageReference actualizarEventoInutil(){
        
        List<Historial_evento_backShop__c> eventoHistorial = new List<Historial_evento_backShop__c>();
        eventoHistorial = [SELECT id, Evento_BackShop__c, Es_de_utilidad__c, NoSeUtilizo__c FROM Historial_evento_backshop__c WHERE Cuenta__c =: idCuenta AND Evento_BackShop__c =: idDelEvento AND Es_de_utilidad__C =: false];        
        
        eventoHistorial[0].Es_de_utilidad__c = true;
        update eventoHistorial;
        obtenerEventosBackShops();
        
        return null;
    }
    
    public PageReference IdentificaNegocio(){
        List<Historial_evento_backShop__c> eventoHistorial = new List<Historial_evento_backShop__c>();
        eventoHistorial = [SELECT id, Evento_BackShop__c, Es_de_utilidad__c, NoSeUtilizo__c FROM Historial_evento_backshop__c WHERE Cuenta__c =: idCuenta AND Evento_BackShop__c =: idDelEvento AND Es_de_utilidad__C =: true];        
        
        eventoHistorial[0].Identificar_Negocio__c= true;
        eventoHistorial[0].NoSeUtilizo__c = true;
        update eventoHistorial;
        
        
        obtenerEventosBackShops();
        return null;
    }
    
    public PageReference NoIdentificaNegocio(){
        List<Historial_evento_backShop__c> eventoHistorial = new List<Historial_evento_backShop__c>();
        eventoHistorial = [SELECT id, Evento_BackShop__c, Es_de_utilidad__c, NoSeUtilizo__c FROM Historial_evento_backshop__c WHERE Cuenta__c =: idCuenta AND Evento_BackShop__c =: idDelEvento AND Es_de_utilidad__C =: true];        
        
        eventoHistorial[0].Identificar_Negocio__c= false;
        eventoHistorial[0].NoSeUtilizo__c = true;
        update eventoHistorial;
        
        
        obtenerEventosBackShops();
        return null;
    }
    
    public PageReference goToOrg() {		
        //save();
        return new PageReference(Page.accountOrganizationChart.getUrl()  + '?id='+idCuenta);
    }
    
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

               List<Opportunity> oportunidadesTelefonica = database.query('select id, name, bi_opportunity_type__c, bi_fecha_de_fin_de_contrato__c, bi_full_contract_value_neto_fcv__c from opportunity where AccountId=:idCuenta and bi_fecha_de_fin_de_contrato__c>: hoyMenosUnAnio and bi_fecha_de_fin_de_contrato__c<: hoy and isclosed = true and isWon = true and bi_full_contract_value_neto_fcv__c > 0 order by bi_fecha_de_fin_de_contrato__c limit 200');

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
               
               List<Opportunity> oportunidadesTelefonica = database.query('select id, name, certa_scp__linea_de_negocio__c, closeDate, certa_scp__full_contract_value__c from opportunity where AccountId=:idCuenta and closeDate>: hoyMenosUnAnio and closeDate<: hoy and isclosed = true and isWon = true and certa_scp__full_contract_value__c > 0 order by closeDate limit 200');
                              
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
    
    public Double sumar(Double numero1, Double numero2){
        
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
    
    //Wrappers
    //=====================================================================
    
    public class OportunidadAMostrarWpp{
        public String id{get;set;}
        public String name{get;set;}
        public String lineaDeNegocio{get;set;}
        public Date fecha{get;set;}
        public Double fcv {get;set;}
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
    
    public class WrapperEventosBackShop{
        
        public Evento_BackShop__c evento {get; set;}
        public Historial_evento_backShop__c historial {get; set;}
        
        
        public WrapperEventosBackShop(Evento_BackShop__c unEvento){
            
            evento = unEvento;
        }
    }
    
    // Wrapper presupuestosAño
    public class wrapperPresupuesto {
        
        public String anio { get; set; }
        public Decimal nosotros { get; set; }
        public Decimal competencia { get; set; }
        public Decimal disponible { get; set; }
        
        public wrapperPresupuesto(String anio, Decimal nosotros, Decimal competencia, Decimal disponible) {
            this.anio = anio;
            this.nosotros = nosotros;
            this.competencia = competencia;
            this.disponible = disponible;
        }
    }
    
    public class WrapperOportunidadGrafico{
        
        public String lineaDeNegocio {get;set;}
        public Double Nav {get;set;}
        
        public WrapperOportunidadGrafico(String unaLineaDeNegocio, Double unNav){
            lineaDeNegocio = unaLineaDeNegocio;
            Nav = unNav;
            
            if(Nav == null){
                Nav = 0;
            }
        }
    }
    
    public class WrapperOportunidadesVencimientos{
        
        public String mes{get;set;}
        public Double fcv{get;set;}
        public String claveOrdenar {get;set;}
    }
    
}