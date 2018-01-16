@isTest
public class PlanDeAccionTest {

    static testMethod void poniendoUnIdDeFourPlanningODeCuentaPuedoVerLaPagina(){
        
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuenta.id;
        insert fourPlanning;
        
        PageReference planAccion = Page.PlanDeAccion;
        Test.setCurrentPage(planAccion);
        planAccion.getParameters().put('Id', cuenta.id);
        
        
        PlanDeAccionController controller = new PlanDeAccionController();
        
        system.assert(controller.mostrar);
		
        controller.irACuestionario();
        controller.irADesarrolloCuenta();
        controller.irAInicio();
        controller.irAEjesDeTrabajo();
        controller.irAForYou();
    }
    
    static testMethod void cuandoTengoUnFourPlanningLoObtengoYGeneraElJson(){
        
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;

		FourPlanning__c fourPlanning = new FourPlanning__c();
		fourPlanning.Vencimiento_Datos_Fijos__c = Date.today();
        /*
        fourPlanning.Vencimiento_Otros_Servicios__c = Date.today();
        fourPlanning.Vencimiento_Servicios_Moviles__c = Date.today();
		*/
        
        fourPlanning.Cuenta__c = cuenta.id;
		insert fourPlanning;

        PageReference planAccion = Page.PlanDeAccion;
        Test.setCurrentPage(planAccion);
        planAccion.getParameters().put('Id', cuenta.id);

        PlanDeAccionController controller = new PlanDeAccionController();
        
        Date hoy = Date.today();
        Integer mes = hoy.month();
        Integer dia = hoy.day();
        Integer anio = hoy.year();
        
        String tituloDatosFijos = 'Vencimiento';
        String descripcionDatosFijos = 'Fecha de Vencimiento de contratos de datos fijos';
        
        String vencimientoDatosFijos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"'+tituloDatosFijos+'","text":"'+descripcionDatosFijos+'","tag":"Categoria 1"}}';
        
        /*

        String tituloOtrosServicios = 'Vencimiento';
        String descripcionOtrosServicios = 'Fecha de vencimiento de contratos de otros servicios';    
        
        String vencimientoOtrosServicios = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"'+tituloOtrosServicios+'","text":"'+descripcionOtrosServicios+'","tag":"Categoria 1"}}';
        
        String tituloServiciosMoviles = 'Vencimiento';
        String descripcionServiciosMoviles = 'Fecha de vencimiento de contrato de servicios móviles';
        
        String vencimientoServiciosMoviles = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"'+tituloServiciosMoviles+'","text":"'+descripcionServiciosMoviles+'","tag":"Categoria 1"}}';
        */
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        
        String JsonEsperado = cabecera + vencimientoDatosFijos + ']}';
        
        system.assertEquals(JsonEsperado, controller.eventosJson);       
    }
    
    static testMethod void agregoHitosYSeGeneraBienElJson(){
        
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
            
        PageReference planAccion = Page.PlanDeAccion;
        Test.setCurrentPage(planAccion);
        planAccion.getParameters().put('Id', cuenta.id);

        PlanDeAccionController controller = new PlanDeAccionController();
        
        Date hoy = Date.today();
        Integer mes = hoy.month();
        Integer dia = hoy.day();
        Integer anio = hoy.year();
        
        String tituloDatosFijos = 'Vencimiento';
        String descripcionDatosFijos = 'Fecha de Vencimiento de contratos de datos fijos';
        
        String vencimientoDatosFijos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"'+tituloDatosFijos+'","text":"'+descripcionDatosFijos+'","tag":"Categoria 1"}}';
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        
        
        String hitos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"Otro","text":"'+hito1.descripcion__c+'","tag":"Categoria 1"}}';
        
        
        String JsonEsperado = cabecera + vencimientoDatosFijos +','+ hitos + ']}';
        
        system.assertEquals(JsonEsperado, controller.eventosJson);         
    }
    
    static testMethod void agregoRetosYElJsonSeGeneraCorrectamente(){

        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Vencimiento_Datos_Fijos__c = Date.today();
        fourPlanning.Cuenta__c = cuenta.id;
        insert fourPlanning;
        
        FourPlanning_Area__c area = new FourPlanning_Area__c();
		area.FourPlanning__c = fourPlanning.id;
        insert area;

        FourPlanning_Hito__c hito1 = new FourPlanning_Hito__c();
        hito1.Fecha__c = Date.today();
        hito1.Descripcion__c = 'Hito 1';
        hito1.FourPlanning__c = fourPlanning.id;
        insert hito1;
        
        FourPlanning_Reto__c reto = new FourPlanning_Reto__c();
        reto.Nota__c = 'Una nota';
        reto.Fecha_Compromiso__c = Date.today();
        reto.Nombre_del_Reto__c = 'reto name';
        reto.FourPlanning_Area__c = area.id;
        insert reto;
        
        PageReference planAccion = Page.PlanDeAccion;
        Test.setCurrentPage(planAccion);
        planAccion.getParameters().put('Id', fourPlanning.cuenta__c);
        
        PlanDeAccionController controller = new PlanDeAccionController();
        
        Date hoy = Date.today();
        Integer mes = hoy.month();
        Integer dia = hoy.day();
        Integer anio = hoy.year();
        
        String tituloDatosFijos = 'Vencimiento';
        String descripcionDatosFijos = 'Fecha de Vencimiento de contratos de datos fijos';
        
        String vencimientoDatosFijos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"'+tituloDatosFijos+'","text":"'+descripcionDatosFijos+'","tag":"Categoria 1"}}';
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        
        
        String hitos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"Otro","text":"'+hito1.descripcion__c+'","tag":"Categoria 1"}}';
        
        String retos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"Reto","text":"<b>'+reto.Nombre_del_Reto__c+'</b><p>'+reto.Nota__c+'</p>","tag":"Categoria 1"}}';
        
        String JsonEsperado = cabecera + vencimientoDatosFijos +','+ retos + ','+ hitos + ']}';
        
        system.assertEquals(JsonEsperado, controller.eventosJson);                 
    }

    static testMethod void agregoSoloHitosYSeGeneraBienElJson(){
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuenta.id;
        insert fourPlanning;
        
        FourPlanning_Hito__c hito1 = new FourPlanning_Hito__c();
        hito1.Fecha__c = Date.today();
        hito1.Descripcion__c = 'Hito 1';
        hito1.Categoria__c = 'Vencimiento Contrato Activo con Telefónica';
        hito1.FourPlanning__c = fourPlanning.id;
        insert hito1;
        
        PageReference planAccion = Page.PlanDeAccion;
        Test.setCurrentPage(planAccion);
        planAccion.getParameters().put('Id', cuenta.id);
        
        PlanDeAccionController controller = new PlanDeAccionController();
        
        Date hoy = Date.today();
        Integer mes = hoy.month();
        Integer dia = hoy.day();
        Integer anio = hoy.year();
        
        String cabecera = '{"title":{"media":{"url":"","caption":"","credit":""},"text":{"headline":"","text":""}},"events":[';
        
        String hitos = '{"media":{"url":"","caption":".","credit":""},"start_date":{"month":"'+mes+'","day":"'+dia+'","year":"'+anio+'"},"text":{"headline":"Vencimiento Contrato Activo con Telefónica","text":"'+hito1.descripcion__c+'","tag":"Categoria 1"}}';
        
        String JsonEsperado = cabecera + hitos + ']}';
        
        system.assertEquals(JsonEsperado, controller.eventosJson);
    }
    
}