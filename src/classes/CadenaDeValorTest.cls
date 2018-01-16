@isTest
public class CadenaDeValorTest {

    static testMethod void seSetean4ValoresPorDefaultSiNoExisteNinguno(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cadenaDeValor = Page.CadenaDeValor;
        Test.setCurrentPage(cadenaDeValor);
        cadenaDeValor.getParameters().put('id', cuenta.id);
        
        CadenaDeValorController controller = new CadenaDeValorController(new ApexPages.StandardController(cuenta));
        
        controller.setear4ValoresPorDefaultSiNoExisteNinguno();
        
        List<Area_cadena_de_valor__c> areas = [select id from Area_cadena_de_valor__c];
        
        system.assertEquals(4, areas.size());
    }
    
    static testMethod void sePuedeCrearUnaNuevaArea(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cadenaDeValor = Page.CadenaDeValor;
        Test.setCurrentPage(cadenaDeValor);
        cadenaDeValor.getParameters().put('id', cuenta.id);
        
        CadenaDeValorController controller = new CadenaDeValorController(new ApexPages.StandardController(cuenta));
        
        controller.nuevaArea.area__c = 'una area';
        controller.nuevaArea();
        controller.saveChanges();
        
        List<Area_cadena_de_valor__c> areas = [select id from Area_cadena_de_valor__c];
        
        system.assertEquals(1, areas.size());
    }
    
    static testMethod void sePuedeBorrarUnaArea(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cadenaDeValor = Page.CadenaDeValor;
        Test.setCurrentPage(cadenaDeValor);
        cadenaDeValor.getParameters().put('id', cuenta.id);
        
        CadenaDeValorController controller = new CadenaDeValorController(new ApexPages.StandardController(cuenta));
        
        controller.nuevaArea.area__c = 'una area';
        controller.nuevaArea();
        
        controller.areaABorarId = [select id from Area_cadena_de_valor__c][0].id;
        
        controller.borrarArea();
        
        List<Area_cadena_de_valor__c> areas = [select id from Area_cadena_de_valor__c];
        
        system.assertEquals(0, areas.size());
        
    }
}