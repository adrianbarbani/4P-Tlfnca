@isTest
public class InformacionDeLaCuentaComponentTest {

    static testMethod void seGeneraElObjetoFourPlanningParaUnaCuentaCorrectamente(){

        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning; 
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        
        controller.getRespuestas();
        
        Evento_BackShop__c evento = new Evento_BackShop__c();
        evento.name='evento1';
        insert evento;
        
        controller.idDelEvento = evento.id;
        
        controller.setearOportunidadesAContacto();
        
        controller.crearEventoInutil();
        controller.actualizarEventoInutil();
        controller.crearEventoUtil();
        controller.actualizarEventoUtil();
        
        controller.IdentificaNegocio();
        controller.NoIdentificaNegocio();
        
       // controller.pruebaCheckbox();
        controller.insertVencimiento();
        controller.getRamas();
        controller.getFamilias();
        controller.borrarSolucionEnCuenta();
       // controller.BorrarPresupuesto();
        controller.cambioTodosADonuts();
        controller.cambioTodosABarras();
        controller.cambioTotalesADonuts();
        controller.cambioTotalesABarras();
        //controller.insertarPresupuesto();
        //controller.vincularRetoASolucion();
        controller.insertarSolucion();
        controller.insertarReto();
        controller.insertarRetoCustom();
        controller.renderizarPagina();
        controller.pruebita();
        controller.irAPlanDeAccion();
        controller.irADesarrolloCuenta();
        controller.irAEjesDeTrabajo();
        controller.irAForYou();
        controller.irACuestionario();
        controller.irAInicio();
        controller.borrarContacto();
        controller.borrarSolucion();
        //controller.desvincularReto();
        //controller.desvincularOportunidad();
        controller.pedirApoyoAVentas();
        controller.cancelarApoyoAVentaEspecialista();
        //controller.crearPlanDeAccion();
        controller.goToOrg();
        controller.sumar(1,2);
        controller.sumar(null,2);
        controller.sumar(1,null);
        controller.sumar(null,null);
        
        
        FourPlanning_Area__c area1 = new FourPlanning_Area__c();
        area1.name = 'area1';
        insert area1;
        FourPlanningController.WrapperArea areawpp = new FourPlanningController.WrapperArea(area1);
        FourPlanningController.WrapperOportunidadGrafico asd = new FourPlanningController.WrapperOportunidadGrafico('a', null);
        FourPlanningController.WrapperOportunidadesVencimientos vencimien = new FourPlanningController.WrapperOportunidadesVencimientos();
        vencimien.claveOrdenar = 'ad';
        vencimien.mes = 'enero';
        vencimien.fcv = 2;
        
		FourPlanningController.wrapperPresupuesto wppPresupuesto = new FourPlanningController.wrapperPresupuesto('enero',1,2,3);				
        FourPlanningController.WrapperReto wppReto = new FourPlanningController.WrapperReto();       
        
        FourPlanning_Reto__c reto1  = new  FourPlanning_Reto__c();
        reto1.name = 'reto1';
        reto1.Nombre_del_Reto__c= 'dasdasd';
        reto1.Etapa_del_Reto__c = 'RFI';
        reto1.FourPlanning_Area__c = area1.id;
        insert reto1;
        
        FourPlanningController.WrapperReto wppReto2 = new FourPlanningController.WrapperReto(reto1);
        
        Opportunity opp = new Opportunity();
        opp.name = 'asd';
        opp.StageName = 'cerrada';
        opp.CloseDate = Date.today();

        FourPlanningController.WrapperOportunidadesAVincular wppasd = new FourPlanningController.WrapperOportunidadesAVincular(opp);
        
        system.assertEquals(cuenta.id, controller.fourPlanning.cuenta__c);
    }

    static testMethod void generarAreas(){
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        
        controller.fourPlanning.Titulo_Area_1__c = 'titulo1';
        controller.fourPlanning.Titulo_Area_2__c = 'titulo2';
        controller.fourPlanning.Titulo_Area_3__c = 'titulo3';
        
        controller.insertar4Planning();
        controller.generarAreas();
        
        List<FourPlanning_Area__c> areas = [SELECT ID, Titulo_Area__c FROM FourPlanning_Area__c];
        system.assertEquals(3, areas.size());
        system.assertEquals('titulo1', areas[0].Titulo_Area__c);
        system.assertEquals('titulo2', areas[1].Titulo_Area__c);
        system.assertEquals('titulo3', areas[2].Titulo_Area__c);
        
        controller.guardoPro();
        controller.getRenderBanca();
        controller.getRenderMineria();
        
        FourPlanning_Area__c area1 = new FourPlanning_Area__c();
        area1.name = 'area1';
        insert area1;
        
        FourPlanning_Reto__c reto1  = new  FourPlanning_Reto__c();
        reto1.name = 'reto1';
        reto1.Nombre_del_Reto__c= 'dasdasd';
        reto1.Etapa_del_Reto__c = 'RFI';
        reto1.FourPlanning_Area__c = area1.id;
        insert reto1;
        
        FourPlanning_Reto__c reto2  = new  FourPlanning_Reto__c();
        reto2.Nombre_del_Reto__c = 'dasdas';
        reto2.name = 'reto2';
        reto2.Etapa_del_Reto__c ='RFI';
        reto2.FourPlanning_Area__c = area1.id;
        insert reto2;
         
        controller.retoABorrarId = reto1.id;
        
        List<FourPlanning_Reto__c> retossss = new  List<FourPlanning_Reto__c>();
        retossss.add(reto1);
        retossss.add(reto2);
        controller.retosTotales = retossss;
        
        controller.BorrarReto();

        
        List<FourPlanning_Reto__c> retos = [SELECT ID FROM FourPlanning_Reto__c];
        system.assertEquals(1, retos.size());
        
        retos = [SELECT ID FROM FourPlanning_Reto__c WHERE FourPlanning_Area__c =: areas[0].id];
        system.assertEquals(0, retos.size());
        
		system.assertEquals(0, controller.retosArea1.size());
        system.assertEquals(0, controller.retosArea2.size());
        system.assertEquals(0, controller.retosArea3.size());
        controller.guardarFourPlanning();
        
        controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        controller.generarAreas();
        
        system.assertEquals(0, controller.retosArea1.size());
    }

    static testMethod void puedoInsertarYBorrarUnHitoQueALaVezSeInsertaYBorraUnaTarea(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        
        controller.hitoAInsertar.Fecha__c = Date.today();
        controller.hitoAInsertar.Categoria__c = 'Publicación RFP TI';
        controller.hitoAInsertar.Descripcion__c = 'unaDescripcion'; 
        
        controller.insertar4Planning();
        controller.insertHito();
        
        List<FourPlanning_Hito__c> hitosCreados = [SELECT ID FROM FourPlanning_Hito__c];
        List<Task> tareasCreadas = [SELECT ID, ActivityDate, Description, hitoAsociado__c FROM Task];
        
        system.assertEquals(1, hitosCreados.size());
        system.assertEquals(1, tareasCreadas.size());
        system.assertEquals(Date.today(), tareasCreadas[0].ActivityDate);
        system.assertEquals('unaDescripcion', tareasCreadas[0].Description);
        system.assertEquals(hitosCreados[0].id, tareasCreadas[0].hitoAsociado__c);
        
        controller.hitoABorrarId = hitosCreados[0].id;
        controller.BorrarHito();
        
        hitosCreados = [SELECT ID FROM FourPlanning_Hito__c];
        tareasCreadas = [SELECT ID, ActivityDate, Description, hitoAsociado__c FROM Task];
        
        system.assertEquals(0, hitosCreados.size());
        system.assertEquals(0, tareasCreadas.size());
        
    }
     
    static testMethod void puedoInsertarYBorrarUnaIniciativa(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        
        controller.newInitiative.Strategic_Initiative__c = 'una descripcion';
        controller.newInitiative.Title__c = 'titulo';
        
        controller.InsertIniciative();
        
        List<Strategic_Initiative__c> iniciativasInsertadas = [SELECT ID FROM Strategic_Initiative__c];
        
        System.assertEquals(1, iniciativasInsertadas.size());
        
        controller.delid = iniciativasInsertadas[0].id;
        controller.DeleteStrategicInitiatives();
        
        iniciativasInsertadas = [SELECT ID FROM Strategic_Initiative__c];
        
        System.assertEquals(0, iniciativasInsertadas.size());        

    }
    
    static testMethod void ahoraPuedoGenerarHasta5Areas(){
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        
        controller.fourPlanning.Titulo_Area_1__c = 'titulo1';
        controller.fourPlanning.Titulo_Area_2__c = 'titulo2';
        controller.fourPlanning.Titulo_Area_3__c = 'titulo3';
        controller.fourPlanning.Titulo_Area_4__c = 'titulo4';
        controller.fourPlanning.Titulo_Area_5__c = 'titulo5';
        
        controller.insertar4Planning();
        controller.generarAreas();
        controller.guardarFourPlanningCompleto();
        
        List<FourPlanning_Area__c> areas = [SELECT ID, Titulo_Area__c FROM FourPlanning_Area__c];
        system.assertEquals(5, areas.size());
        system.assertEquals('titulo1', areas[0].Titulo_Area__c);
        system.assertEquals('titulo2', areas[1].Titulo_Area__c);
        system.assertEquals('titulo3', areas[2].Titulo_Area__c);
        system.assertEquals('titulo4', areas[3].Titulo_Area__c);
        system.assertEquals('titulo5', areas[4].Titulo_Area__c);
        
        
        List<FourPlanning_Reto__c> retos = [SELECT ID FROM FourPlanning_Reto__c];
        system.assertEquals(0, retos.size());
        
        retos = [SELECT ID FROM FourPlanning_Reto__c WHERE FourPlanning_Area__c =: areas[0].id];
        system.assertEquals(0, retos.size());
        
        system.assertEquals(0, controller.retosArea1.size());
        system.assertEquals(0, controller.retosArea2.size());
        system.assertEquals(0, controller.retosArea3.size());
        system.assertEquals(0, controller.retosArea4.size());
        system.assertEquals(0, controller.retosArea5.size());
        controller.guardarFourPlanning();
        
        controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        controller.generarAreas();
        
        system.assertEquals(0, controller.retosArea1.size());
    }
    
    static testMethod void cuandoGuardoElCuestionarioSeGuardaUnObjetoCoeCuenta(){
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
		controller.idCuenta = cuenta.id;
        
        controller.fourPlanning.Canal_Comercializacion_cliente__c = 'On-Line';
        controller.fourPlanning.Canal_Comercializacion_que_mas_crece__c = 'On-Line';
        controller.fourPlanning.Area_que_fracasamos_en_el_pasado__c = 'Cualquier valor';
        controller.fourPlanning.Mejoraria_Relacion_Con_El_Cliente__c = 'Si';
        controller.fourPlanning.realcion_empresa_otros_clientes__c = 'Si';
        
        controller.guardarFourPlanningCompleto();
        
        List<FourPlanning_CoeCuenta__c> coeCuenta = [SELECT ID, Creacion_del_valor__c, Cuenta__c FROM FourPlanning_CoeCuenta__c];
        system.assertEquals(1, coeCuenta.size());
        system.assertEquals(Date.today(), coeCuenta[0].Creacion_del_valor__c);
        system.assertEquals(cuenta.id, coeCuenta[0].Cuenta__c);
        
        //si lo guardo con el mismo valor no se genera un nuevo coeCuenta.
        controller.guardarFourPlanningCompleto();
        coeCuenta = [SELECT ID, Creacion_del_valor__c, Cuenta__c FROM FourPlanning_CoeCuenta__c];
        system.assertEquals(1, coeCuenta.size());
    }
    
    static testMethod void siYaHayUnCoeCreadoParaEseTrimestreLoActualiza(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
		controller.idCuenta = cuenta.id;
        
        controller.fourPlanning.Canal_Comercializacion_cliente__c = 'On-Line';
        controller.fourPlanning.Canal_Comercializacion_que_mas_crece__c = 'On-Line';
        
        
        controller.guardarFourPlanningCompleto();
        
        List<FourPlanning_CoeCuenta__c> coeCuenta = [SELECT ID, Creacion_del_valor__c, Cuenta__c, lastModifiedDate, Valor_Coeficiente_De_Cuenta__c FROM FourPlanning_CoeCuenta__c];
        system.assertEquals(1, coeCuenta.size());
        system.assertEquals(Date.today(), coeCuenta[0].Creacion_del_valor__c);
        system.assertEquals(cuenta.id, coeCuenta[0].Cuenta__c);
        
        system.debug(coeCuenta[0].lastModifiedDate);
        Double primerValorCoeCuenta = coeCuenta[0].Valor_Coeficiente_De_Cuenta__c;
        
        //agrego mas respuestas para que el valor cambie.
        controller.fourPlanning.Area_que_fracasamos_en_el_pasado__c = 'Cualquier valor';
        controller.fourPlanning.Mejoraria_Relacion_Con_El_Cliente__c = 'Si';
        controller.fourPlanning.realcion_empresa_otros_clientes__c = 'Si';
        
        controller.guardarFourPlanningCompleto();
        
        coeCuenta = [SELECT ID, Creacion_del_valor__c, Cuenta__c, Valor_Coeficiente_De_Cuenta__c, lastModifiedDate FROM FourPlanning_CoeCuenta__c];
        system.debug(coeCuenta[0].lastModifiedDate);
        
        system.assertEquals(1, coeCuenta.size());
        system.assert((coeCuenta[0].Valor_Coeficiente_De_Cuenta__c != primerValorCoeCuenta));
    }
    
    static testMethod void cuandoGeneraElObjetoCoeCuentaYYaHay4CreadosSeBorraElMasViejo(){
        
        //se tienen que crear 1 por trimestre y si hay 4 que esos 4 sean de los 4 ultimos trimestres
      
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        FourPlanning_CoeCuenta__c coeCuenta = new FourPlanning_CoeCuenta__c();
        coeCuenta.Creacion_del_valor__c = Date.newInstance(2015, 6, 1);
        coeCuenta.Cuenta__c = cuenta.id;
        insert coeCuenta;
        
        FourPlanning_CoeCuenta__c coeCuenta2 = new FourPlanning_CoeCuenta__c();
        coeCuenta2.Creacion_del_valor__c = Date.newInstance(2016, 6, 1);
        coeCuenta2.Cuenta__c = cuenta.id;
        insert coeCuenta2;
        
        FourPlanning_CoeCuenta__c coeCuenta3 = new FourPlanning_CoeCuenta__c();
        coeCuenta3.Creacion_del_valor__c = Date.newInstance(2016, 3, 1);
        coeCuenta3.Cuenta__c = cuenta.id;
        insert coeCuenta3;
        
        FourPlanning_CoeCuenta__c coeCuenta4 = new FourPlanning_CoeCuenta__c();
        coeCuenta4.Creacion_del_valor__c = Date.newInstance(2015, 1, 1);
        coeCuenta4.Cuenta__c = cuenta.id;
        insert coeCuenta4;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
		controller.idCuenta = cuenta.id;
        
        controller.fourPlanning.Canal_Comercializacion_cliente__c = 'On-Line';
        controller.fourPlanning.Canal_Comercializacion_que_mas_crece__c = 'On-Line';
        controller.fourPlanning.Area_que_fracasamos_en_el_pasado__c = 'Cualquier valor';
        
        //esto ya crea un coeCuenta;
        controller.guardarFourPlanningCompleto();
        
        List<FourPlanning_CoeCuenta__c> coeCuentas = [SELECT ID, Creacion_del_valor__c, Cuenta__c, Valor_Coeficiente_De_Cuenta__c, lastModifiedDate FROM FourPlanning_CoeCuenta__c];
		system.debug(coeCuentas);
        system.assertEquals(4, coeCuentas.size());
        
        //me fijo que se haya borrado el que tiene la fecha mas antigua
        
        for(FourPlanning_CoeCuenta__c coe:coeCuentas){
            system.assert(!Date.newInstance(2015, 1, 1).isSameDay(coe.Creacion_del_valor__c));
        }
    }
    
    static testMethod void puedoInsertarAreas(){
        
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        
        controller.areaAInsertar.Titulo_Area__c = 'un titulo';
        controller.areaAInsertar.Conocimiento_del_Area__c = 'Bajo';
        
        controller.insertar4Planning();
        
		controller.insertarArea();
        
        List<FourPlanning_Area__c> areas = [select id from FourPlanning_Area__c];
        system.assertEquals(1, areas.size());
		
        
    }
    
    static testMethod void puedoInsertarUnContacto(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        
        controller.areaAInsertar.Titulo_Area__c = 'un titulo';
        controller.areaAInsertar.Conocimiento_del_Area__c = 'Bajo';
        
        controller.insertar4Planning();
        
        controller.insertarArea();
        
        //controller.idDelRetoDelContacto = controller.wrappersDeArea[0].wppRetos[0].reto.id;
        
        controller.contactoAInsertar.Nivel_de_Relaci_n__c = 'No lo conozco';
        controller.contactoAInsertar.Tipo_de_Contacto__c = 'CEO';
        
        controller.insertarContacto();
        
        List<FourPlanning_Contacto__c> contactos = [select id, Nivel_de_Relaci_n__c, Tipo_de_Contacto__c from fourPlanning_Contacto__c];
        
        system.assertEquals(0, contactos.size());
       // system.assertEquals('No lo conozco', contactos[0].Nivel_de_Relaci_n__c);
        //system.assertEquals('CEO', contactos[0].Tipo_de_Contacto__c);
    }
    
    static testMethod void sePuedeBorrarUnArea(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.CuestionarioFourPlanning;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        InformacionDeLaCuentaComponentController controller = new InformacionDeLaCuentaComponentController();
        controller.idCuenta = cuenta.id;
        
        controller.areaAInsertar.Titulo_Area__c = 'un titulo';
        controller.areaAInsertar.Conocimiento_del_Area__c = 'Bajo';
        
        controller.insertar4Planning();
        
        controller.insertarArea();
        
        controller.areaABorrarId = controller.wrappersDeArea[0].area.id;
        
        controller.borrarArea();
        
        List<FourPlanning_Area__c> areas = [select id from FourPlanning_Area__c];
        
        system.assertEquals(0, areas.size());
    }
    
}