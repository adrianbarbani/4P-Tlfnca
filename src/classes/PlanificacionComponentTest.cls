@isTest
public class PlanificacionComponentTest {

    static testMethod void myUnitTest() {
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.Planificacion; 
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        PlanificacionComponentController a = new PlanificacionComponentController();
        a.idCuenta = cuenta.id;
        a.sumar(1,2);
        
    }
}