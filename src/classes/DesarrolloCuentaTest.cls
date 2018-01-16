@isTest
public class DesarrolloCuentaTest {

    static testMethod void poniendoUnIdDeCuentaPuedoVerLaPagina(){
        
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuenta.id;
        insert fourPlanning;
        
        PageReference desarrolloCuenta = Page.DesarrolloCuenta;
        Test.setCurrentPage(desarrolloCuenta);
        desarrolloCuenta.getParameters().put('Id', cuenta.id);
        
        DesarrolloCuentaController controller = new DesarrolloCuentaController();
        
        controller.irACuestionario();
        controller.irAForYou();
        controller.irAPlanDeAccion();
        controller.irAEjesDeTrabajo();
        controller.irAInicio();
        controller.establecerZonaObjetivo();
        system.assert(controller.mostrar);
    }
    
    static testMethod void consigoLosTresPrincipalesRetos(){

        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuenta.id;
        insert fourPlanning;
        
        FourPlanning_Area__c area1 = new FourPlanning_Area__c();
        area1.FourPlanning__c = fourPlanning.id;
        FourPlanning_Area__c area2 = new FourPlanning_Area__c();
        area2.FourPlanning__c = fourPlanning.id;
        
        insert area1;
        insert area2;
        
        FourPlanning_Reto__c reto1area1 = new FourPlanning_Reto__c();
        reto1area1.Nombre_del_Reto__c = 'reto1area1'; 
        reto1area1.FourPlanning_Area__c = area1.id;
        FourPlanning_Reto__c reto2area1 = new FourPlanning_Reto__c();
        reto2area1.Nombre_del_Reto__c='reto2area1';
    	reto2area1.FourPlanning_Area__c = area1.id;
        
        FourPlanning_Reto__c reto1area2 = new FourPlanning_Reto__c();
        reto1area2.Nombre_del_Reto__c = 'reto1area2';
        reto1area2.FourPlanning_Area__c = area2.id;
        
        List<FourPlanning_Reto__c> retos = new List<FourPlanning_Reto__c> {reto1area1, reto1area2, reto2area1};
        insert retos;

        
        PageReference desarrolloCuenta = Page.DesarrolloCuenta;
        Test.setCurrentPage(desarrolloCuenta);
        desarrolloCuenta.getParameters().put('Id', cuenta.id);
        
        DesarrolloCuentaController controller = new DesarrolloCuentaController();

        
		system.assertEquals(3, controller.retosPrincipales.size());        
    }
    
    static testMethod void siSoloTengoDosRetosEnTotalEsosSonLosQueAparecen(){
                
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuenta.id;
        insert fourPlanning;
        
        FourPlanning_Area__c area3 = new FourPlanning_Area__c();
		area3.FourPlanning__c = fourPlanning.id;
        insert area3;
        
        FourPlanning_Reto__c reto1 = new FourPlanning_Reto__c();
        reto1.Nombre_del_Reto__c = 'Reto1';
        reto1.FourPlanning_Area__c = area3.id;
        FourPlanning_Reto__c reto2  = new FourPlanning_Reto__c();
        reto2.Nombre_del_Reto__c = 'Reto2';
    	reto2.FourPlanning_Area__c = area3.id;
        
        List<FourPlanning_Reto__c> retos = new List<FourPlanning_Reto__c> {reto1, reto2};
        insert retos;

        PageReference desarrolloCuenta = Page.DesarrolloCuenta;
        Test.setCurrentPage(desarrolloCuenta);
        desarrolloCuenta.getParameters().put('Id', cuenta.id);
        
        DesarrolloCuentaController controller = new DesarrolloCuentaController();

		system.assertEquals(2, controller.retosPrincipales.size());
		        
    }

    static testMethod void obtengoElPromedioDeConocimientoDeLaCuentaPorPaisCorrectamente(){
        
        
        Region__c regionArgentina = new Region__c();
        insert regionArgentina;
        
        Region__c regionBrasil = new Region__c();
        insert regionBrasil;
        
        Account cuentaArgentina = new Account(name = 'Nombre Cuenta');
        cuentaArgentina.Region__c = regionArgentina.id;
        insert cuentaArgentina;
        
        Account cuentaBrasil = new Account(name = 'Nombre Cuenta');
        cuentaBrasil.Region__c = regionBrasil.id;
        insert cuentaBrasil;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuentaArgentina.id;
        fourPlanning.conocimiento_de_la_cuenta__c = 80;
        insert fourPlanning;
        
        FourPlanning__c fourPlanning2 = new FourPlanning__c();
        fourPlanning2.conocimiento_de_la_cuenta__c = 60;
        fourPlanning2.Cuenta__c = cuentaArgentina.id;
        
        insert fourPlanning2;
        
        FourPlanning__c fourPlanningQueNoSuma = new FourPlanning__c();
        fourPlanningQueNoSuma.conocimiento_de_la_cuenta__c = 80;
        fourPlanningQueNoSuma.Cuenta__c = cuentaBrasil.id;
        insert fourPlanningQueNoSuma;
        
        PageReference desarrolloCuenta = Page.DesarrolloCuenta;
        Test.setCurrentPage(desarrolloCuenta);
        desarrolloCuenta.getParameters().put('Id', cuentaArgentina.id);
        
        DesarrolloCuentaController controller = new DesarrolloCuentaController();
        
        system.assertEquals(70, controller.promedioPais);
    }
    
    static testMethod void consigoLosTresPrincipalesRetosSiEnLasPrimeras2AreasNoTengoRetos(){
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
        
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuenta.id;
        insert fourPlanning;
        
        FourPlanning_Area__c area3 = new FourPlanning_Area__c();
        area3.FourPlanning__c = fourPlanning.id;
        FourPlanning_Area__c area4 = new FourPlanning_Area__c();
        area4.FourPlanning__c = fourPlanning.id;
        FourPlanning_Area__c area5 = new FourPlanning_Area__c();
        area5.FourPlanning__c = fourPlanning.id;
        
        insert area3;
        insert area4;
        insert area5;
        
        FourPlanning_Reto__c reto1area3 = new FourPlanning_Reto__c();
        reto1area3.Nombre_del_Reto__c = 'reto1area3'; 
        reto1area3.FourPlanning_Area__c = area3.id;
        
        FourPlanning_Reto__c reto1area4 = new FourPlanning_Reto__c();
        reto1area4.Nombre_del_Reto__c ='reto1area4';
        reto1area4.FourPlanning_Area__c = area4.id;
        
        FourPlanning_Reto__c reto1area5 = new FourPlanning_Reto__c();
        reto1area5.Nombre_del_Reto__c = 'reto1area5';
        reto1area5.FourPlanning_Area__c = area5.id;
        
        List<FourPlanning_Reto__c> retos = new List<FourPlanning_Reto__c> {reto1area3, reto1area4, reto1area5};
            insert retos;
        
        
        PageReference desarrolloCuenta = Page.DesarrolloCuenta;
        Test.setCurrentPage(desarrolloCuenta);
        desarrolloCuenta.getParameters().put('Id', cuenta.id);
        
        DesarrolloCuentaController controller = new DesarrolloCuentaController();
        
        
        system.assertEquals(3, controller.retosPrincipales.size()); 
    }


    static testMethod void seGeneranLos4ObjetosQueDanValorALasEsferasDelGrafico(){
        
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
		
        //Crear los coe de cuenta.
        FourPlanning_CoeCuenta__c coeCuenta = new FourPlanning_CoeCuenta__c();
        coeCuenta.Creacion_del_valor__c = Date.today();
        coeCuenta.Cuenta__c = cuenta.id;
        coeCuenta.Valor_Coeficiente_De_Cuenta__c = 10;
        insert coeCuenta;
        
        FourPlanning_CoeCuenta__c coeCuenta2 = new FourPlanning_CoeCuenta__c();
        coeCuenta2.Creacion_del_valor__c = Date.today().addMonths(-3);
        coeCuenta2.Cuenta__c = cuenta.id;
        coeCuenta2.Valor_Coeficiente_De_Cuenta__c = 20;
        insert coeCuenta2;
        
        FourPlanning_CoeCuenta__c coeCuenta3 = new FourPlanning_CoeCuenta__c();
        coeCuenta3.Creacion_del_valor__c = Date.today().addMonths(-6);
        coeCuenta3.Cuenta__c = cuenta.id;
        coeCuenta3.Valor_Coeficiente_De_Cuenta__c = 30;
        insert coeCuenta3;
        
        FourPlanning_CoeCuenta__c coeCuenta4 = new FourPlanning_CoeCuenta__c();
        coeCuenta4.Creacion_del_valor__c = Date.today().addMonths(-9);
        coeCuenta4.Cuenta__c = cuenta.id;
        coeCuenta4.Valor_Coeficiente_De_Cuenta__c = 40;
        insert coeCuenta4;
        
        
        Opportunity oppTrimestreActual = new Opportunity();
        oppTrimestreActual.AccountId = cuenta.id;
        oppTrimestreActual.Name = 'opp';
        oppTrimestreActual.nav_certa__c = 10;
        oppTrimestreActual.probabilidad_de_exito_certa__c = '25';
        oppTrimestreActual.StageName = 'Value Proposition';
        oppTrimestreActual.CloseDate = Date.today();
        insert oppTrimestreActual;

        Opportunity oppUnTrimestreAnterior = new Opportunity();
        oppUnTrimestreAnterior.AccountId = cuenta.id;
        oppUnTrimestreAnterior.Name = 'opp';
        oppUnTrimestreAnterior.nav_certa__c = 20;
        oppUnTrimestreAnterior.probabilidad_de_exito_certa__c = '25';
        oppUnTrimestreAnterior.StageName = 'F1 - Ganada';
        oppUnTrimestreAnterior.CloseDate = Date.today();
        insert oppUnTrimestreAnterior;
        
        Opportunity oppDosTrimestresAnteriores = new Opportunity();
        oppDosTrimestresAnteriores.AccountId = cuenta.id;
        oppDosTrimestresAnteriores.Name = 'opp';
        oppDosTrimestresAnteriores.nav_certa__c = 30;
        oppDosTrimestresAnteriores.probabilidad_de_exito_certa__c = '25';
        oppDosTrimestresAnteriores.StageName = 'F1 - Ganada';
        oppDosTrimestresAnteriores.CloseDate = Date.today().addMonths(-3);
        insert oppDosTrimestresAnteriores;
        
        Opportunity oppTresTrimestresAnteriores = new Opportunity();
        oppTresTrimestresAnteriores.AccountId = cuenta.id;
        oppTresTrimestresAnteriores.Name = 'opp';
        oppTresTrimestresAnteriores.nav_certa__c = 40;
        oppTresTrimestresAnteriores.probabilidad_de_exito_certa__c = '25';
        oppTresTrimestresAnteriores.StageName = 'F1 - Ganada';
        oppTresTrimestresAnteriores.CloseDate = Date.today().addMonths(-3);
        insert oppTresTrimestresAnteriores;
        
        
        Test.setCreatedDate(oppUnTrimestreAnterior.Id, Date.today().addMonths(-3));
        Test.setCreatedDate(oppDosTrimestresAnteriores.Id, Date.today().addMonths(-6));
        Test.setCreatedDate(oppTresTrimestresAnteriores.Id, Date.today().addMonths(-9));
        Test.startTest();
        
        PageReference desarrolloCuenta = Page.DesarrolloCuenta;
        Test.setCurrentPage(desarrolloCuenta);
        desarrolloCuenta.getParameters().put('Id', cuenta.id);
        
        DesarrolloCuentaController controller = new DesarrolloCuentaController();
        
        Opportunity oppDebug = [select id, createdDate, isClosed from opportunity where id =: oppTresTrimestresAnteriores.id];
        system.debug(oppDebug);
        
        test.stopTest();
    }

}