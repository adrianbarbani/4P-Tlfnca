@isTest
public class FourPlanningResumenTest {

    static testMethod void traigoElFourPlanningDeLaCuentaJuntoConSusRetos(){
        
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
		
        FourPlanning_Area__c area3 = new FourPlanning_Area__c();
        FourPlanning_Area__c area1 = new FourPlanning_Area__c();
        FourPlanning_Area__c area2 = new FourPlanning_Area__c();
        
        List<FourPlanning_Area__c> areas = new List<FourPlanning_Area__c> {area1, area2, area3};
        insert areas;
        
        FourPlanning_Reto__c reto1 = new FourPlanning_Reto__c();
        reto1.FourPlanning_Area__c = area3.id;
        reto1.Nombre_del_Reto__c = 'a';
        reto1.Contactos_del_Cliente__c = 'a';
        reto1.Productos_a_Desarrollar_Vender__c = 'Diseño';
        
        FourPlanning_Reto__c reto2  = new FourPlanning_Reto__c();
        reto2.FourPlanning_Area__c = area2.id;
        reto2.Nombre_del_Reto__c = 'a';
        reto2.Contactos_del_Cliente__c = 'a';
        reto2.Productos_a_Desarrollar_Vender__c = 'Diseño';
        
        FourPlanning_Reto__c reto3  = new FourPlanning_Reto__c();
        reto3.FourPlanning_Area__c = area1.id;
        reto3.Nombre_del_Reto__c = 'a';
        reto3.Contactos_del_Cliente__c = 'a;b';
        reto3.Productos_a_Desarrollar_Vender__c = 'Diseño';
        
        List<FourPlanning_Reto__c> retos = new List<FourPlanning_Reto__c> {reto1, reto2, reto3};
        insert retos;
        
		FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuenta.id;
        fourPlanning.FourPlanning_Area_3__c = area3.id;
        fourPlanning.FourPlanning_Area_2__c = area2.id;
        fourPlanning.FourPlanning_Area_1__c = area1.id;
        fourPlanning.Titulo_Area_1__c = 'TituloA1';
        fourPlanning.Titulo_Area_2__c = 'TituloA2';
        fourPlanning.Titulo_Area_3__c = 'TituloA3';

        insert fourPlanning;
		
        PageReference fourPlanningResumen = Page.accountCustomReport;
        Test.setCurrentPage(fourPlanningResumen);
        fourPlanningResumen.getParameters().put('Id', cuenta.id);
        
        FourPlanningResumenController controller = new FourPlanningResumenController();
        
        system.assertEquals(1, controller.retosArea1.size());
        system.assertEquals(reto3.id, controller.retosArea1[0].id);

    }
}