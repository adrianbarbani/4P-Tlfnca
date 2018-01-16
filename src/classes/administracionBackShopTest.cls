@isTest
public class administracionBackShopTest {

    static testMethod void puedoInsertarUnBackShop(){
        
        administracionBackShopController controller = new administracionBackShopController();
        
        controller.eventoAInsertar.name = 'una descripcion';
        
        controller.InsertarEvento();
        
        List<Evento_BackShop__c> eventosGlobales = [select id from Evento_BackShop__c];
        
        system.assertEquals(1, eventosGlobales.size());
    }
    
    static testMethod void borrarEvento(){
        
        administracionBackShopController controller = new administracionBackShopController();
        
        controller.eventoAInsertar.name = 'una descripcion';
        
        controller.InsertarEvento();
        
        controller.idABorrar = [select id from Evento_BackShop__c][0].id;
        
        controller.renderizarPagina();
        controller.borrarEvento();
        
        List<Evento_BackShop__c> eventosGlobales = [select id from Evento_BackShop__c];
        
        system.assertEquals(0, eventosGlobales.size());

    }
}