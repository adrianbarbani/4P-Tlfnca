@isTest
public class PantallaPrincipalPowerBallsTest {
    
    static testMethod void traigoElArbolCorrespondiente(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.PantallaPrincipalPowerBalls;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        PantallaPrincipalPowerBallsController controller = new PantallaPrincipalPowerBallsController();
    }
    
 
}