@isTest
public class PlanificacionTest {

    static testMethod void myUnitTest() {
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.Planificacion; 
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        PlanificacionController a = new PlanificacionController();
        a.sumar(1,2);
        
    }
}