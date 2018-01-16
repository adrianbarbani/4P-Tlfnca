@isTest
public class AccountBusinessLandscapeTest {

    static testMethod void myUnitTest() {
    
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference bussines = Page.AccountBusinessLandscape;
        Test.setCurrentPage(bussines);
        bussines.getParameters().put('id', cuenta.id);
        
        AccountBusinessLandscapeController controller = new AccountBusinessLandscapeController();
        
        controller.siNoHayCreadoUnRegistroEnParqueDeServiciosGeneroUnoDeCadaUno();
        
        controller = new AccountBusinessLandscapeController();
        
        controller.save();
        controller.add();
        controller.del();
        controller.ExportToExcel();
        controller.getExcelName();
    }
}