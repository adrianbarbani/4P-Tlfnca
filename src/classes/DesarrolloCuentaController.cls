public class DesarrolloCuentaController {
    
    public List<Strategic_Initiative__c> iniciativasEstrategiasPrincipales {get; set;}
    
    public String idCuenta {get; set;}
    public Boolean mostrar {get; set;}
    
    public FourPlanning__c fourPlanning {get; set;}
    
    public List<FourPlanning_Reto__c> retosPrincipales {get; set;} 
    
    public List<String> competidores {get; set;}
    
    public Boolean hayDatos {get; set;}
    
    public map<String, Integer> respuestasYValores {get; set;}
    
    public List<FourPlanning_Reto__c> retos {get; set;}

    
    public Integer conocimientoDeLaCuenta {get; set;}
    
    public Double promedioPais {get; set;}
    
    public Account cuenta {get; set;}
    
    //el tamaño maxima que va a alcanzar una bola.
    public Integer maximoValorEnPixeles {get; set;}
    public static final Double VALOR_QUE_MULTIPLICA_PARA_DEFINIR_LA_ALTURA_DEL_NOMBRE_DE_ZONA_OBJETIVO = 0.9;
    
    public Bola ultimoQ {get; set;}
    public Bola tercerQ {get; set;}
    public Bola segundoQ {get; set;}
    public Bola primerQ {get; set;}
    
    //para presentacion, momentaneos
    public Double diametroPrimerBola {get; set;}
    public Double alturaPromedioPais {get; set;}
    public Double alturaZonaObjetivoMaxima {get; set;}
    public Double alturaZonaObjetivoMinima {get; set;}
    public Double alturaNombre {get; set;}
//    public List<FourPlanning_Esfera__c> datosEsferas {get; set;}
//    public FourPlanning_Esfera__c datosDeLaPrimerEsfera {get; set;}
    public String nombreDiametroQ1 {get; set;}
    public String nombreDiametroQ2 {get; set;}
    public String nombreDiametroQ3 {get; set;}
    public String nombreDiametroQ4 {get; set;}
    
    //datos zona objetivo
    public FourPlanning_zona_objetivo__c zonaObjetivo {get; set;}
    
    
    public string monedaDeLaCuenta {get; set;}
    
    public DesarrolloCuentaController(){
        
        maximoValorEnPixeles = 160;
        
        idCuenta = ApexPages.currentPage().getParameters().get('Id');
        
        fourPlanning = new FourPlanning__c();
        
        List<FourPlanning__c> fourPlannings = new List<FourPlanning__c>();
        
        if(idCuenta != null){
            
            fourPlannings = [SELECT Id, Competidor_Principal_1__c, Competidor_Principal_2__c, Competidor_Principal_3__c,
                             FourPlanning_Area_1__c, FourPlanning_Area_2__c, FourPlanning_Area_3__c, FourPlanning_Area_4__c, FourPlanning_Area_5__c, 
                             Mayor_Nivel_de_Contacto_con_el_Cliente__c, Frecuencia_de_Contacto_con_el_Cliente__c,
                             Agenda_Periodica_Ejecutiva__c, Agenda_Periodica_Operacional__c, Frecuencia_Funcionarios_del_Cliente__c, 
                             Canal_Comercializacion_cliente__c, Canal_Comercializacion_que_mas_crece__c, ISC__c, Area_que_fracasamos_en_el_pasado__c, Mejoraria_Relacion_Con_El_Cliente__c,
                             realcion_empresa_otros_clientes__c, conocimiento_de_la_cuenta__c,
                             (select id from FourPlanning_Areas__r)
                             FROM FourPlanning__c 
                             WHERE Cuenta__c =: idCuenta
                             LIMIT 1];
            
            if(fourPlannings.size() > 0){
                fourPlanning = fourPlannings[0];
                system.debug(fourPlanning);
            }
            
            List<Account> cuentas = [SELECT Id, Region__c from Account WHERE id =: idCuenta LIMIT 1];
            if(cuentas.size()>0){
                cuenta = new Account();
                cuenta = cuentas[0];
            }
        }
        
        competidores = new List<String>();
        if(fourPlanning.Competidor_Principal_1__c != null){
            competidores.add(fourPlanning.Competidor_Principal_1__c);
        }
        if(fourPlanning.Competidor_Principal_2__c != null){
            competidores.add(fourPlanning.Competidor_Principal_2__c);
        }
        if(fourPlanning.Competidor_Principal_3__c != null){
            competidores.add(fourPlanning.Competidor_Principal_3__c);
        }
        
        
        
         monedaDeLaCuenta = '';
        if(Util.checkMultiCurrencyEnabled()){
            
            id CuentaId = idCuenta;
            
            try{
                Account unaCuenta = DataBase.query('SELECT id, CurrencyISOCode FROM Account WHERE id =: CuentaId'); 
                monedaDeLaCuenta = (String)unaCuenta.get('CurrencyISOCode');
            }catch(Exception e){
                System.debug('Error en la asignacion del CurrentISOCode:' + e.getMessage());
            }
            
        }
        
        
        
        
        
        mostrar = false;
        if(idCuenta != null){
            mostrar = true;
        }
        
        iniciativasEstrategiasPrincipales = [SELECT ID, Strategic_Initiative__c FROM Strategic_Initiative__c WHERE Account__c =: idCuenta Limit 3];
        
        conseguirLosTresPrincipalesRetos();
        
        hayDatos = false;
        if( (competidores.size() != 0 || iniciativasEstrategiasPrincipales.size() != 0 || retosPrincipales.size() != 0) && fourPlanning.conocimiento_de_la_cuenta__c != null){
            hayDatos = true;
        }
        
        obtenerPromedioPais();

        //Objeto que determina la creacion del rectangulo "zona objetivo".
        List<FourPlanning_zona_objetivo__c> zonasObjetivos = [SELECT id, altura_zona_objetivo_maxima__c, altura_zona_objetivo_minima__c, 
                                                              Zona_Objetivo_valor_1_eje_x__c, Zona_Objetivo_valor_2_eje_x__c, Cuenta__c 
                                                              FROM FourPlanning_zona_objetivo__c 
                                                              WHERE  Cuenta__c =: idCuenta
                                                              LIMIT 1];
        
        if(zonasObjetivos.size()>0){
            zonaObjetivo = zonasObjetivos[0];
            alturaPromedioPais = zonaObjetivo.altura_zona_objetivo_maxima__c;
            alturaNombre = zonaObjetivo.altura_zona_objetivo_maxima__c*VALOR_QUE_MULTIPLICA_PARA_DEFINIR_LA_ALTURA_DEL_NOMBRE_DE_ZONA_OBJETIVO;
        }else{
            zonaObjetivo = new FourPlanning_zona_objetivo__c();
            zonaObjetivo.cuenta__c = idCuenta;
            zonaObjetivo.Zona_Objetivo_valor_1_eje_x__c = 0;
            zonaObjetivo.altura_zona_objetivo_maxima__c = 0;
            zonaObjetivo.altura_zona_objetivo_minima__c = 0;
            zonaObjetivo.Zona_Objetivo_valor_2_eje_x__c = 0;
            
            alturaPromedioPais = 0;
        }
        
        generarBolasPorTrimestre();
        
        //Unico para presentacion brasil 
        /*
        ultimoQ = new Bola(0,0,0,Date.today());
        tercerQ = new Bola(0,0,0,Date.today());  
        segundoQ = new Bola(0,0,0,Date.today());
        primerQ = new Bola(0,0,0,Date.today());
        
        alturaPromedioPais = 100;
        alturaZonaObjetivoMaxima = 100;
        alturaZonaObjetivoMinima = 50;
        alturaNombre = 80;
        
        datosEsferas = [SELECT ID, Diametro__c, Eje_y__c FROM FourPlanning_Esfera__c WHERE Cuenta__c =: idCuenta LIMIT 1];
        datosDeLaPrimerEsfera = new FourPlanning_Esfera__c();
       
        IF(datosEsferas.size()>0){
            primerQ.ejey = datosEsferas[0].Eje_y__c;
            primerQ.diametro = datosEsferas[0].Diametro__c;
            datosDeLaPrimerEsfera = datosEsferas[0];
        }else{
            datosDeLaPrimerEsfera.Cuenta__c = idCuenta;
           	datosDeLaPrimerEsfera.Diametro__c = primerQ.diametro;
            datosDeLaPrimerEsfera.Eje_y__c = primerQ.ejeY;
        }
        
        if(fourPlanning != null){
            generarValoresParaLasEsferas();
        }
        */
    }
    
    public void obtenerPromedioPais(){
        
        AggregateResult[] sumatoriaDeConocimiento = [SELECT SUM(conocimiento_de_la_cuenta__c)sumaConocimiento, COUNT(Id)cantidad
                                                     FROM FourPlanning__c
                                                     WHERE conocimiento_de_la_cuenta__c != null AND Cuenta__r.Region__c =: cuenta.region__c];
        
        if(sumatoriaDeConocimiento.size()>0){
            if((Double)sumatoriaDeConocimiento[0].get('sumaConocimiento') > 0){
                promedioPais = (Double)sumatoriaDeConocimiento[0].get('sumaConocimiento') / (Double)sumatoriaDeConocimiento[0].get('cantidad');
            }else{
                promedioPais = 0;
            }
        }
    }
    
    public void conseguirLosTresPrincipalesRetos(){

        List<Id> areas = new List<Id>();
        for(FourPlanning_Area__c area: fourPlanning.FourPlanning_Areas__r){
            areas.add(area.id);
        }
        
        retos = [SELECT Id, FourPlanning_Area__c, Fecha_Compromiso__c, Nombre_del_Reto__c, Nota__c FROM FourPlanning_Reto__c WHERE FourPlanning_Area__c IN: areas];
        
        system.debug(retos.size());
        for(FourPlanning_Reto__c r:retos){
            system.debug(r.Nombre_del_Reto__c);
        }
        
        retosPrincipales = new List<FourPlanning_Reto__c>();
        
        Integer i = 0;
        while(retosPrincipales.size()<3 && retos.size() >= (i+1)){
            
            if(retos[i].Nombre_del_Reto__c != null && retos[i].Nombre_del_Reto__c != '' ){
                retosPrincipales.add(retos[i]);
            }
            
            i++;
        }
        

         system.debug(retosPrincipales);
        
    }
    
    public PageReference irACuestionario(){
        
        String url = Page.cuestionarioFourPlanning.getURL();
        return new PageReference (url + '?id=' + idCuenta);
    }
    
    public PageReference irAForYou(){
        
        String url = Page.ForYou.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
    
    public PageReference irAPlanDeAccion() {
        
        String url = Page.PlanDeAccion.getURL();
        return new PageReference (url + '?id=' + idCuenta);
    }
    
    public PageReference irAEjesDeTrabajo(){
        
        String url = Page.EjesDeTrabajo.getURL();
        return new PageReference (url + '?id=' + idCuenta);        
    }
    
    public PageReference irAInicio(){
        String url = Page.Tab4Planning.getURL();
        return new PageReference (url);   
    }
    
    // comentado para la presentacion de brasil
    
    public void generarBolasPorTrimestre(){
        
        //veo en que trimestre del año estoy.
        Date hoy = Date.today();
        Integer mesActual = hoy.month();
        String queryTrimestreActual = '';
        
        //Genero la fecha de inicio del trimestre mas cercano a la fecha de hoy.
        if(mesActual >= 7){
            if(mesActual >= 10){
                //Cuarto trimestre, del 1-10 al 31-12
                obtenerBolasDeLosTrimestresAnterioresYActual(date.newInstance(hoy.year(), 10, 1));        
            }else{
                //Tercer trimestre, del 1-7 al 30-9
                obtenerBolasDeLosTrimestresAnterioresYActual(date.newInstance(hoy.year(), 7, 1));   
            }
        }else{
            if(mesActual >= 4){
                //Segundo trimestre, del 1-4 al 30-6 
                obtenerBolasDeLosTrimestresAnterioresYActual(date.newInstance(hoy.year(), 4, 1));
            }else{
                //Primer trimestre, del 1-1 al 31-3
                obtenerBolasDeLosTrimestresAnterioresYActual(date.newInstance(hoy.year(), 1, 1));
            }
        }   
    }
    
    public void obtenerBolasDeLosTrimestresAnterioresYActual(Date trimestreActual){
        
        Date hoy = Date.today();
        
        Date fechaPrimerQ = trimestreActual.addMonths(-9);
        Date fechaSegundoQ = trimestreActual.addMonths(-6);
        Date fechaTercerQ = trimestreActual.addMonths(-3);
        
        List<Opportunity> oportunidadesUltimoQ = new List<Opportunity>();
        List<Opportunity> oportunidadesTercerQ = new List<Opportunity>();
        List<Opportunity> oportunidadesSegundoQ = new List<Opportunity>();
        List<Opportunity> oportunidadesPrimerQ = new List<Opportunity>();
        
        List<Opportunity> oportunidadesFunnelUltimoQ = new List<Opportunity>();
        
        Boolean existenLosCamposDeTelefonica = false;
        Set<String> objectFields = Schema.SObjectType.Opportunity.fields.getMap().keySet();
        if(objectFields.contains('bi_net_annual_value_nav__c') && objectFields.contains('bi_probabilidad_de_exito__c')) {
            
            
            
            //tengo que traer todas las oportunidades abiertas para esas fechas
            //son las oportunidades que estan abiertas ahora y se crearon despues de la fecha de inicio de ese trimestre 
            //y las oportunidades que estan cerradas despues de que termino el trimestre y se crearon antes de que termine ese trimestre
            oportunidadesPrimerQ = DataBase.query('SELECT id, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId =: idCuenta AND IsWon = true AND closeDate >=: fechaPrimerQ AND closeDate <: fechaSegundoQ AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            
            oportunidadesSegundoQ = DataBase.query('SELECT id, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId =: idCuenta AND IsWon = true AND closeDate >=: fechaSegundoQ AND closeDate <: fechaTercerQ AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            
            if(fechaPrimerQ.year() == fechaSegundoQ.year() && fechaPrimerQ.month() != 1){
                
                oportunidadesSegundoQ.addAll(oportunidadesPrimerQ);
            }
            
            oportunidadesTercerQ = DataBase.query('SELECT id, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId =: idCuenta AND IsWon = true AND closeDate >=: fechaTercerQ AND closeDate <: trimestreActual AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            
            if(fechaSegundoQ.year() == fechaTercerQ.year() && fechaSegundoQ.month() != 1){
                oportunidadesTercerQ.addAll(oportunidadesSegundoQ);
            }
            
            oportunidadesUltimoQ = DataBase.query('SELECT id, bi_net_annual_value_nav__c, bi_probabilidad_de_exito__c FROM Opportunity WHERE accountId =: idCuenta AND IsWon = true AND closeDate >=: trimestreActual AND bi_net_annual_value_nav__c != NULL ORDER BY bi_net_annual_value_nav__c DESC limit 200');
            oportunidadesFunnelUltimoQ = DataBase.query('SELECT id, bi_nav_ponderado__c FROM Opportunity WHERE accountId =: idCuenta AND IsClosed = false AND bi_nav_ponderado__c != NULL ORDER BY bi_nav_ponderado__c DESC limit 200');
            
            if(fechaTercerQ.year() == trimestreActual.year() && fechaTercerQ.month() != 1){
                oportunidadesUltimoQ.addAll(oportunidadesTercerQ);
            }
            
            existenLosCamposDeTelefonica = true;
        }else{
            
            //Si no existen los campos de telefonica (Por que este codigo no se esta ejecutando en su entorno), traigo 2 campos creados que cumplen la misma funcion pero estan dentro del paquete.
           
            //tengo que traer todas las oportunidades abiertas para esas fechas
            //son las oportunidades que estan abiertas ahora y se crearon despues de la fecha de inicio de ese trimestre 
            //y las oportunidades que estan cerradas despues de que termino el trimestre y se crearon antes de que termine ese trimestre
            oportunidadesPrimerQ = DataBase.query('SELECT id, name, certa_scp__nav_certa__c, certa_scp__probabilidad_de_exito_certa__c FROM Opportunity WHERE accountId =: idCuenta AND IsWon = true AND closeDate >=: fechaPrimerQ AND closeDate <: fechaSegundoQ AND certa_scp__nav_certa__c != NULL ORDER BY certa_scp__nav_certa__c DESC limit 200');
            
            oportunidadesSegundoQ = DataBase.query('SELECT id, name,  certa_scp__nav_certa__c, certa_scp__probabilidad_de_exito_certa__c FROM Opportunity WHERE accountId =: idCuenta AND IsWon = true AND closeDate >=: fechaSegundoQ AND closeDate <: fechaTercerQ AND certa_scp__nav_certa__c != NULL ORDER BY certa_scp__nav_certa__c DESC limit 200');
            
            if(fechaPrimerQ.year() == fechaSegundoQ.year() && fechaPrimerQ.month() != 1){
                oportunidadesSegundoQ.addAll(oportunidadesPrimerQ);
            }
            
            oportunidadesTercerQ = DataBase.query('SELECT id, name, certa_scp__nav_certa__c, certa_scp__probabilidad_de_exito_certa__c FROM Opportunity WHERE accountId =: idCuenta AND IsWon = true AND closeDate >=: fechaTercerQ AND closeDate <: trimestreActual AND certa_scp__nav_certa__c != NULL ORDER BY certa_scp__nav_certa__c DESC limit 200');
            
            if(fechaSegundoQ.year() == fechaTercerQ.year() && fechaSegundoQ.month() != 1){
                oportunidadesTercerQ.addAll(oportunidadesSegundoQ);
            }
            
            oportunidadesUltimoQ = DataBase.query('SELECT id, name, certa_scp__nav_certa__c, certa_scp__probabilidad_de_exito_certa__c FROM Opportunity WHERE accountId =: idCuenta AND IsWon = true AND closeDate >=: trimestreActual AND certa_scp__nav_certa__c != NULL ORDER BY certa_scp__nav_certa__c DESC limit 200');
            
            if(fechaTercerQ.year() == trimestreActual.year() && fechaTercerQ.month() != 1){
                system.debug('entre');
                oportunidadesUltimoQ.addAll(oportunidadesTercerQ);
            }
            existenLosCamposDeTelefonica = false;
            system.debug('No lo contengo');
        } 
        
        system.debug(oportunidadesUltimoQ);
        ultimoQ = crearObjetoBolaPara(oportunidadesUltimoQ, existenLosCamposDeTelefonica, Date.today(), oportunidadesFunnelUltimoQ);
        system.debug(ultimoQ);
        
        system.debug(oportunidadesTercerQ);
        tercerQ = crearObjetoBolaPara(oportunidadesTercerQ, existenLosCamposDeTelefonica, trimestreActual, null);
        system.debug(tercerQ);
        
        system.debug(oportunidadesSegundoQ);
        segundoQ = crearObjetoBolaPara(oportunidadesSegundoQ, existenLosCamposDeTelefonica, fechaTercerQ, null);
        system.debug(segundoQ);
        
        system.debug(oportunidadesPrimerQ);
        primerQ = crearObjetoBolaPara(oportunidadesPrimerQ, existenLosCamposDeTelefonica, fechaSegundoQ, null);
        system.debug(primerQ);

		generarValoresEnPixelesDelDiametro();
    }
    
    public Bola crearObjetoBolaPara(List<Opportunity> oportunidadesDelQ, Boolean existenLosCamposDeTelefonica, Date fechaLimite, List<Opportunity> oportunidadesFunnel){
               
        Double Diametro = 0;
        Double navTotal = 0;
        for(Opportunity oportunidad :oportunidadesDelQ){
            
            Double nav = 0;
            String probabilidad = '0';
            if(existenLosCamposDeTelefonica){
                nav = (Double)oportunidad.get('bi_net_annual_value_nav__c');
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
        
        //Tendre que guardar los valores en un objeto aparte.
        
        //consigo el coeDeCuenta para la fecha que se paso.
        List<FourPlanning_CoeCuenta__c> coeficientesCuentas = [SELECT ID, Creacion_del_valor__c, Valor_Coeficiente_De_Cuenta__c
                                                               FROM FourPlanning_CoeCuenta__c 
                                                               WHERE Cuenta__c =: idCuenta AND
                                                               Creacion_del_valor__c <=: fechaLimite
                                                               ORDER BY Creacion_del_valor__c DESC];
        Double coeCuenta = 0;
        system.debug(coeficientesCuentas);
        if(coeficientesCuentas.size() > 0){
            coeCuenta = coeficientesCuentas[0].Valor_Coeficiente_De_Cuenta__c;
        }
		system.debug(coeCuenta);	
	
        system.debug(fechaLimite);
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
        
        alturaZonaObjetivoMaxima = 0;
        for(Bola bola:bolas){
            if(bola.diametro > max){
                max = bola.diametro;
            }
            //hardcodeo de la altura maxima de zona objetivo
            if(bola.ejeY > alturaZonaObjetivoMaxima){
                alturaZonaObjetivoMaxima = bola.ejeY;
                alturaZonaObjetivoMaxima = alturaZonaObjetivoMaxima*1.5;
            }
        }
        
        system.debug(max);
		
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
    
    //Momentaneo para presentacion brasil
   
    /*
    public PageReference generarImagenes(){
		
        if(primerQ.ejey != 0 && primerQ.diametro != 0){
			
            generarValoresParaLasEsferas();

            datosDeLaPrimerEsfera.Eje_y__c = primerQ.ejey;
            datosDeLaPrimerEsfera.Diametro__c = primerQ.diametro;
            upsert datosDeLaPrimerEsfera;

            
            system.debug(primerQ);
        }
        
        return null;
    }
    
    public void generarValoresParaLasEsferas(){
        
        if(fourPlanning.conocimiento_de_la_cuenta__c!=null){
            primerQ.EjeX = fourPlanning.conocimiento_de_la_cuenta__c;
        }
        
        diametroPrimerBola = primerQ.diametro;
        while(diametroPrimerBola > 180){
            diametroPrimerBola = diametroPrimerBola/10;
            diametroPrimerBola = diametroPrimerBola+20;
        }
        //diametroPrimerBola = primerQ.diametro / 1000;
        
        system.debug(primerQ.EjeX);
        segundoQ.ejeX = ((100 - primerQ.EjeX)/2)+primerQ.EjeX ;
        segundoQ.EjeY = primerQ.Ejey *1.2;
        segundoQ.diametro = diametroPrimerBola * 1.25;
        
        tercerQ.ejeX = ((100 - segundoQ.EjeX)/2)+segundoQ.EjeX;
        tercerQ.EjeY = primerQ.Ejey *1.4;
        tercerQ.diametro = diametroPrimerBola * 1.45;
        
        
        //nombrePrimerBola = 'Q1 - '+diametroPrimerBola;
        //nombreSegundaBola = 'Q1 -'+
        
        alturaPromedioPais = primerQ.Ejey *1.4;
        alturaZonaObjetivoMinima = (primerQ.Ejey *1.4) / 2;
        alturaZonaObjetivoMaxima = primerQ.Ejey *1.4;
        alturaNombre = alturaZonaObjetivoMaxima * 0.8;
        
        nombreDiametroQ1 = NormalizarValor(primerQ.diametro);
        nombreDiametroQ2 = NormalizarValor(primerQ.diametro*1.25);
        nombreDiametroQ3 = NormalizarValor(primerQ.diametro*1.45);
    }
    */
    
    public PageReference establecerZonaObjetivo(){
		
        alturaPromedioPais = zonaObjetivo.altura_zona_objetivo_maxima__c;
        alturaNombre = zonaObjetivo.altura_zona_objetivo_maxima__c*VALOR_QUE_MULTIPLICA_PARA_DEFINIR_LA_ALTURA_DEL_NOMBRE_DE_ZONA_OBJETIVO;
        
        //si es null, el grafico en js no recibe ningun numero y rompe.
        if(zonaObjetivo.altura_zona_objetivo_minima__c == null){
            zonaObjetivo.altura_zona_objetivo_minima__c = 0;
        }
        if(zonaObjetivo.altura_zona_objetivo_maxima__c == null){
            zonaObjetivo.altura_zona_objetivo_maxima__c = 0;
        }
        if(zonaObjetivo.Zona_Objetivo_valor_1_eje_x__c == null){
            zonaObjetivo.Zona_Objetivo_valor_1_eje_x__c = 0;
        }
        
        if(zonaObjetivo.Zona_Objetivo_valor_1_eje_x__c != 0){
            zonaObjetivo.Zona_Objetivo_valor_2_eje_x__c = 100;
        }else{
            zonaObjetivo.Zona_Objetivo_valor_2_eje_x__c = 0;
        }
        
        upsert zonaObjetivo;
        
        generarValoresEnPixelesDelDiametro();
        
        return null;
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
  
    public void calcularMaximoValorEnPixeles(List<Bola> bolas, Double max){
        
        Double navMaximo = 0; 
        for(Bola bola: bolas){
            if(bola.ejeY > navMaximo){
                navMaximo = bola.ejeY;
            }
        }
        
        system.debug(navMaximo);
        
        if(navMaximo != 0 ){
            if(navMaximo*3 >= zonaObjetivo.altura_zona_objetivo_maxima__c){
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
    
    //===============================================================================
    public class Bola {
        
        public Double Diametro {get; set;}
        public Double ejeY {get; set;}
        public Double ejeX {get; set;}
        public String nombre {get; set;}
        public Double valorParaGraficarseEnPixeles {get; set;}
        
        public Bola(Double unDiametro, Double nav, Double valorCoeficienteDesarrolloCuenta, Date fechaLimite){
            Diametro = unDiametro;
            ejeY = nav;
            ejeX = valorCoeficienteDesarrolloCuenta;
            
            calcularNombreEnBaseALaFecha(fechaLimite);
        }
        
        public void calcularNombreEnBaseALaFecha(Date fecha){
            
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
}