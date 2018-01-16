@isTest
public class Tab4PlanningTest {
    
    static testMethod void puedoFiltrarLasCuentasPorlasQueTienen4Planning(){
        
        Account cuenta = new Account();
        cuenta.name = 'nombre';
        insert cuenta;
        
        Account cuenta2 = new Account();
        cuenta2.name = 'nombre';
        insert cuenta2;
        
        FourPlanning__c fplanning = new FourPlanning__c();
        fplanning.cuenta__c = cuenta.id;
        fplanning.Porcentaje_de_completitud_de_la_cuenta__c = 13;
        insert fplanning;
        
        Tab4PlanningController controller = new Tab4PlanningController();
        
        controller.filtro1Valor = 'true';
        
        controller.filtrar();
        
        system.assertEquals(1, controller.cuentas.size());
    }
    
    static testMethod void puedoFiltrarLasCuentasPorlasQueNOTienen4Planning(){
        
        Account cuenta = new Account();
        cuenta.name = 'nombre';
        insert cuenta;
        
        FourPlanning__c fplanning = new FourPlanning__c();
        //fplanning.cuenta__c = cuenta.id;
        insert fplanning;
        
        Tab4PlanningController controller = new Tab4PlanningController();
        
        controller.filtro1Valor = 'false';
        
        controller.filtrar();
        
        system.assertEquals(1, controller.cuentas.size());
    }
    
    static testMethod void puedoFiltrarLasCuentasParaQueTraigaTodas(){
        
        Account cuenta = new Account();
        cuenta.name = 'nombre';
        insert cuenta;
        
        Account cuenta2 = new Account();
        cuenta2.name = 'nombre';
        insert cuenta2;
        
        FourPlanning__c fplanning = new FourPlanning__c();
        fplanning.cuenta__c = cuenta.id;
        insert fplanning;
        
        Tab4PlanningController controller = new Tab4PlanningController();
        
        controller.filtro1Valor = 'ninguno';
        
        controller.filtrar();
        
        system.assertEquals(2, controller.cuentas.size());
    }
    
    static testMethod void filtroPorLasCuentasCuyoFourPlanningTengaMasDeUnFiltro(){
        
        Account cuenta = new Account();
        cuenta.name = 'correcto';
        insert cuenta;
        
        Account cuenta2 = new Account();
        cuenta2.name = 'nombre';
        insert cuenta2;
        
        FourPlanning__c fplanning = new FourPlanning__c();
        fplanning.cuenta__c = cuenta.id;
        fplanning.conocimiento_de_la_cuenta__c = 85;
        fplanning.Porcentaje_de_completitud_de_la_cuenta__c = 13; 
        insert fplanning;
        
        FourPlanning__c fplanning2 = new FourPlanning__c();
        fplanning2.cuenta__c = cuenta2.id;
        fplanning2.conocimiento_de_la_cuenta__c = 70;
        fplanning2.Porcentaje_de_completitud_de_la_cuenta__c = 13; 
        insert fplanning2;
        
        Tab4PlanningController controller = new Tab4PlanningController();
        
        controller.filtro1Valor = 'true';
        
        controller.filtro2Parametro = 'conocimiento_de_la_cuenta__c';
        controller.filtro2Operacion = '>';
        controller.filtro2Valor = 80;
        //El conector logico es obligatorio.
        controller.conectorLogico2 = 'AND';
        
        controller.filtrar();
        
        system.assertEquals(1, controller.cuentas.size());
        system.assertEquals('correcto', controller.cuentas[0].name);
    }
    
    static testMethod void filtroPorLasCuentasCuyoFourPlanningTengaMasDeUnFiltroUtilizandoORComoConectorLogico(){
        
        Account cuenta = new Account();
        cuenta.name = 'correcto';
        insert cuenta;
        
        Account cuenta2 = new Account();
        cuenta2.name = 'nombre';
        insert cuenta2;
        
        FourPlanning__c fplanning = new FourPlanning__c();
        fplanning.cuenta__c = cuenta.id;
        fplanning.conocimiento_de_la_cuenta__c = 85;
        fplanning.Porcentaje_de_completitud_de_la_cuenta__c = 13; 
        insert fplanning;
        
        FourPlanning__c fplanning2 = new FourPlanning__c();
        fplanning2.cuenta__c = cuenta2.id;
        fplanning2.conocimiento_de_la_cuenta__c = 70;
        fplanning2.Porcentaje_de_completitud_de_la_cuenta__c = 13; 
        insert fplanning2;
        
        Tab4PlanningController controller = new Tab4PlanningController();
        
        controller.filtro1Valor = 'true';
        
        controller.filtro2Parametro = 'conocimiento_de_la_cuenta__c';
        controller.filtro2Operacion = '>';
        controller.filtro2Valor = 80;
        //El conector logico es obligatorio.
        controller.conectorLogico2 = 'OR';
        
        controller.filtro3Parametro = 'conocimiento_de_la_cuenta__c';
        controller.filtro3Operacion = '<';
        controller.filtro3Valor = 80;
        //El conector logico es obligatorio.
        controller.conectorLogico3 = 'AND';
        
        controller.filtrar();
        
        system.assertEquals(2, controller.cuentas.size());
    }
    
    static testMethod void puedoObtenerLos3Promedios(){
        
        Account cuenta = new Account();
        cuenta.name = 'correcto';
        insert cuenta;
        
        Account cuenta2 = new Account();
        cuenta2.name = 'nombre';
        insert cuenta2;
        
        Account cuenta3 = new Account();
        cuenta3.name = 'nombre';
        insert cuenta3;
        
        Account cuenta4 = new Account();
        cuenta4.name = 'nombre';
        insert cuenta4;
        
        FourPlanning__c fplanning = new FourPlanning__c();
        fplanning.cuenta__c = cuenta.id;
        fplanning.conocimiento_de_la_cuenta__c = 80;
        fplanning.Porcentaje_de_completitud_de_la_cuenta__c = 80;
        insert fplanning;
        
        FourPlanning__c fplanning2 = new FourPlanning__c();
        fplanning2.cuenta__c = cuenta2.id;
        fplanning2.conocimiento_de_la_cuenta__c = 80;
        insert fplanning2;
        
        Tab4PlanningController controller = new Tab4PlanningController();
        
        system.assertEquals(40, controller.promedioCoeDesarrollo);
        system.assertEquals(20, controller.promedioCompletitud);
        system.assertEquals(50, controller.promedioCuentasConFourPlanning);
    }
    
    
    static testMethod void seGeneraCorrectamenteElJsonParaElLineTime(){
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Vencimiento_Datos_Fijos__c = Date.today();
        fourPlanning.Cuenta__c = cuenta.id;
        insert fourPlanning;
        
        FourPlanning_Hito__c hito1 = new FourPlanning_Hito__c();
        hito1.Fecha__c = Date.today();
        hito1.Descripcion__c = 'Hito 1';
        hito1.FourPlanning__c = fourPlanning.id;
        insert hito1;
        
        
        Tab4PlanningController controller = new Tab4PlanningController();
        controller.filtrar();
        
        Date hoy = Date.today();
        Integer mes = hoy.month();
        Integer dia = hoy.day();
        Integer anio = hoy.year();
        
        String tituloDatosFijos = 'Vencimiento';
        String descripcionDatosFijos = '<b>'+cuenta.name+'<b/>'+'<p>Fecha de Vencimiento de contratos de datos fijos</p>';
        
        String vencimientoDatosFijos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"'+tituloDatosFijos+'","text":"'+descripcionDatosFijos+'","tag":"Categoria 1"}}';
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        
        
        String hitos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"Otro","text":"<b>'+cuenta.name+'<b/>'+'<p>'+hito1.descripcion__c+'</p>'+'","tag":"Categoria 1"}}';
        
        
        String JsonEsperado = cabecera + vencimientoDatosFijos +','+ hitos + ']}';
        
    }
    
    static testMethod void luegoDeGenerarElJsonPuedoFiltrarPorUnaCategoria(){
        
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Vencimiento_Datos_Fijos__c = Date.today();
        fourPlanning.Cuenta__c = cuenta.id;
        insert fourPlanning;
        
        FourPlanning_Hito__c hito1 = new FourPlanning_Hito__c();
        hito1.Fecha__c = Date.today();
        hito1.Descripcion__c = 'Hito 1';
        hito1.FourPlanning__c = fourPlanning.id;
        insert hito1;
        
        
        Tab4PlanningController controller = new Tab4PlanningController();
        controller.filtrar();
        
        Date hoy = Date.today();
        Integer mes = hoy.month();
        Integer dia = hoy.day();
        Integer anio = hoy.year();
        
        String tituloDatosFijos = 'Vencimiento';
        String descripcionDatosFijos = '<b>'+cuenta.name+'<b/>'+'<p>Fecha de Vencimiento de contratos de datos fijos</p>';
        
        String vencimientoDatosFijos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"'+tituloDatosFijos+'","text":"'+descripcionDatosFijos+'","tag":"Categoria 1"}}';
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        
        
        String hitos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"Otro","text":"<b>'+cuenta.name+'<b/>'+'<p>'+hito1.descripcion__c+'</p>'+'","tag":"Categoria 1"}}';
        
        //filtro por vencimiento.
        controller.filtroEventoTelefonica = false;
        controller.filtroEventosDeTipoReto = false;
        controller.filtroVencimientoCompetencia = false;
        controller.filtroPublicacionRFPComunicacion = false;
        controller.filtroPublicacionRFPTI = false;
        controller.filtroEventoIndustria = false;
        controller.filtroOtroTipoDeEvento = false;
        
        controller.filtrarTimeLine();
        
        String JsonEsperado = cabecera + vencimientoDatosFijos + ']}';
        
        system.assertEquals(JsonEsperado, controller.miJson);
        
        controller.filtroEventoTelefonica = true;
        controller.filtroEventosDeTipoReto = true;
        controller.filtroVencimientoCompetencia = true;
        controller.filtroPublicacionRFPComunicacion = true;
        controller.filtroPublicacionRFPTI = true;
        controller.filtroEventoIndustria = true;
        controller.filtroOtroTipoDeEvento = true;
        
        controller.filtrarTimeLine();
        
        JsonEsperado = cabecera + vencimientoDatosFijos +','+ hitos + ']}';
        
        
    }
    
    static testMethod void sePuedeAsignarValoresALosFiltros(){
        
        Filtros_principales_4Planning__c filtro = new Filtros_principales_4Planning__c();
        filtro.filtro1Valor__c = 'true';
        
        filtro.filtro2Parametro__c = 'conocimiento_de_la_cuenta__c';
        filtro.filtro2Operacion__c = '>';
        filtro.filtro2Valor__c = 80;
        
        filtro.conectorLogico2__c = 'OR';
        
        filtro.filtro3Parametro__c = 'conocimiento_de_la_cuenta__c';
        filtro.filtro3Operacion__c = '<';
        filtro.filtro3Valor__c = 80;
        
        filtro.conectorLogico3__c = 'AND';
        filtro.OwnerId = UserInfo.getUserId();
        
        insert filtro;
        
        Account cuenta = new Account();
        cuenta.name = 'correcto';
        insert cuenta;
        
        Account cuenta2 = new Account();
        cuenta2.name = 'nombre';
        insert cuenta2;
        
        FourPlanning__c fplanning = new FourPlanning__c();
        fplanning.cuenta__c = cuenta.id;
        fplanning.conocimiento_de_la_cuenta__c = 85;
        fplanning.Porcentaje_de_completitud_de_la_cuenta__c = 13; 
        insert fplanning;
        
        FourPlanning__c fplanning2 = new FourPlanning__c();
        fplanning2.cuenta__c = cuenta2.id;
        fplanning2.conocimiento_de_la_cuenta__c = 70;
        fplanning2.Porcentaje_de_completitud_de_la_cuenta__c = 13; 
        insert fplanning2;
        
        Tab4PlanningController controller = new Tab4PlanningController();
        
        system.assertEquals('OR', controller.filtro.conectorLogico2__c);
        
        controller.asignarValoresALosFiltros();
        controller.filtrarSinGuardar();
        
        system.assertEquals(2, controller.cuentas.size());
    }
    
    static testMethod void seGeneraUnObjetoFiltroCuandoFiltras(){
        
        Account cuenta = new Account();
        cuenta.name = 'correcto';
        insert cuenta;
        
        Account cuenta2 = new Account();
        cuenta2.name = 'nombre';
        insert cuenta2;
        
        FourPlanning__c fplanning = new FourPlanning__c();
        fplanning.cuenta__c = cuenta.id;
        fplanning.conocimiento_de_la_cuenta__c = 85;
        insert fplanning;
        
        FourPlanning__c fplanning2 = new FourPlanning__c();
        fplanning2.cuenta__c = cuenta2.id;
        fplanning2.conocimiento_de_la_cuenta__c = 70;
        insert fplanning2;
        
        Tab4PlanningController controller = new Tab4PlanningController();
        
        controller.filtro1Valor = 'true';
        
        controller.filtro2Parametro = 'conocimiento_de_la_cuenta__c';
        controller.filtro2Operacion = '>';
        controller.filtro2Valor = 80;
        //El conector logico es obligatorio.
        controller.conectorLogico2 = 'OR';
        
        controller.filtro3Parametro = 'conocimiento_de_la_cuenta__c';
        controller.filtro3Operacion = '<';
        controller.filtro3Valor = 80;
        //El conector logico es obligatorio.
        controller.conectorLogico3 = 'AND';
        
        controller.filtrarSinGuardar();
        controller.guardarFiltros();
        
        
        List<Filtros_principales_4Planning__c> filtros = [select id, ownerId, filtro2Parametro__c, filtro3Parametro__c, filtro4Parametro__c, filtro2Operacion__c,
                                                          filtro3Operacion__c, filtro4Operacion__c, filtro1Valor__c, filtro2Valor__c, filtro3Valor__c,
                                                          filtro4Valor__c, conectorLogico1__c, conectorLogico2__c, conectorLogico3__c
                                                          from Filtros_principales_4Planning__c ];
        
        system.assertEquals(1, filtros.size());
        system.assertEquals('conocimiento_de_la_cuenta__c', filtros[0].filtro2Parametro__c);
        system.assertEquals('conocimiento_de_la_cuenta__c', filtros[0].filtro3Parametro__c);
        
    }
}