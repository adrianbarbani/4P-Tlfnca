@isTest
public class administracionHitosGlobalesTest {

    static testMethod void puedoInsertarUnHitoGlobal(){
        
        administracionHitosGlobalesController controller = new administracionHitosGlobalesController();
        
        controller.hitoGlobalAInsertar.descripcion__c = 'una descripcion';
        controller.hitoGlobalAInsertar.Sector__c = 'Todos';
        
        controller.InsertarHitoGlobal();
        
        List<FourPlanning_Hito_global__c> hitoGlobales = [select id from FourPlanning_Hito_global__c];
        
        system.assertEquals(1, hitoGlobales.size());
    }
    
    static testMethod void borrarEvento(){
        
        administracionHitosGlobalesController controller = new administracionHitosGlobalesController();
        
        controller.hitoGlobalAInsertar.descripcion__c = 'una descripcion';
        controller.hitoGlobalAInsertar.Sector__c = 'Todos';
        
        controller.InsertarHitoGlobal();
        
        controller.idABorrar = [select id from FourPlanning_Hito_global__c][0].id;
        
        controller.renderizarPagina();
        controller.borrarEvento();
        
        List<FourPlanning_Hito_global__c> hitoGlobales = [select id from FourPlanning_Hito_global__c];
        
        system.assertEquals(0, hitoGlobales.size());

    }
}