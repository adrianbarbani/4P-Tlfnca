@isTest
public class EjesDeTrabajoTest {

    static testMethod void seCarganLosRetos(){
        

        
        Account cuenta = new Account(name = 'Nombre Cuenta');
        insert cuenta;
		
        FourPlanning__c fourPlanning = new FourPlanning__c();
        fourPlanning.Cuenta__c = cuenta.id;
        
        insert fourPlanning; 
        
        FourPlanning_Area__c area3 = new FourPlanning_Area__c();
        area3.FourPlanning__c = fourPlanning.id;
        area3.Titulo_Area__c = 'TituloA3';
        FourPlanning_Area__c area1 = new FourPlanning_Area__c();
        area1.FourPlanning__c = fourPlanning.id;
        area1.Titulo_Area__c = 'TituloA1';
        FourPlanning_Area__c area2 = new FourPlanning_Area__c();
        area2.FourPlanning__c = fourPlanning.id;
        area2.Titulo_Area__c = 'TituloA2';
        FourPlanning_Area__c area4 = new FourPlanning_Area__c();
        area4.FourPlanning__c = fourPlanning.id;
        area4.Titulo_Area__c = 'TituloA4';
        FourPlanning_Area__c area5 = new FourPlanning_Area__c();
        area5.FourPlanning__c = fourPlanning.id;
		area5.Titulo_Area__c = 'TituloA5';
        
        List<FourPlanning_Area__c> areas = new List<FourPlanning_Area__c> {area1, area2, area3, area4, area5};
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
        
        FourPlanning_Contacto__c contacto = new FourPlanning_Contacto__c();
        contacto.name = 'asd';
        contacto.reto__c = reto1.id;
        contacto.Nivel_de_Relaci_n__c = 'Fluida y Constante';
        insert contacto;
        
        FourPlanning_Contacto__c contacto2 = new FourPlanning_Contacto__c();
        contacto2.name = 's';
        contacto2.reto__c = reto1.id;
        contacto2.Nivel_de_Relaci_n__c = 'Intensa y Difícil' ;
        insert contacto2;
        
        FourPlanning_Contacto__c contacto3 = new FourPlanning_Contacto__c();
        contacto3.name = 'd';
        contacto3.reto__c = reto1.id;
        contacto3.Nivel_de_Relaci_n__c = 'No lo conozco';
        insert contacto3;
	
		FourPlanning_Solucion__c solucion1 = new FourPlanning_Solucion__c();
        solucion1.name = 'asd';
        solucion1.Nivel_de_Desarrollo__c = 'Disponible';
        solucion1.reto__c = reto1.id;
        insert solucion1;
		
        FourPlanning_Solucion__c solucion2 = new FourPlanning_Solucion__c();
        solucion2.name = 'as';
        solucion2.Nivel_de_Desarrollo__c = 'En Desarrollo';
        solucion2.reto__c = reto1.id;
        insert solucion2;
        
        FourPlanning_Solucion__c solucion3 = new FourPlanning_Solucion__c();
        solucion3.name = 'd';
        solucion3.Nivel_de_Desarrollo__c = 'No Disponible';
        solucion3.reto__c = reto1.id;
        insert solucion3;
        
        PageReference ejesDeTrabajo = Page.EjesDeTrabajo;
        Test.setCurrentPage(ejesDeTrabajo);
        ejesDeTrabajo.getParameters().put('Id', cuenta.id);
        
        EjesDeTrabajoController controller = new EjesDeTrabajoController();
        controller.irAPlanDeAccion();
        controller.irADesarrolloCuenta();
        controller.irACuestionario();
        controller.irAInicio();
        controller.irAForYou();
        
		system.assertEquals(5, controller.areas.size());
        system.assertEquals(1, controller.areas[0].retos.size());
        
    }
}