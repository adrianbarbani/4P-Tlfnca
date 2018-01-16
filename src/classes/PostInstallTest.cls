@isTest
public class PostInstallTest {

    static testMethod void testInstallScript() {
        
        Resource__c recurso = new Resource__c (name = 'Proceso de Aprovación de CAPEX' );
        insert recurso;
        
        PostInstallClass postinstall = new PostInstallClass();
        Test.testInstall(postinstall, null);
        Test.testInstall(postinstall, new Version(1,0), true);
		
        List <Resource__c> recursos = [select id, puede_acceder_a_una_solicitud_capex__c, name from Resource__c];
        system.assertEquals(1, recursos.size());
        System.assertEquals('Proceso de Solicitud de CAPEX' , recursos[0].name );
        System.assert(recursos[0].puede_acceder_a_una_solicitud_capex__c);
    }
    
    static testMethod void InstalarEnUnEntornoSinRecursos() {
        
        PostInstallClass postinstall = new PostInstallClass();
        Test.testInstall(postinstall, null);
        Test.testInstall(postinstall, new Version(1,0), true);
        
        List <Resource__c> recursos = [select id, puede_acceder_a_una_solicitud_capex__c, name from Resource__c];
        system.assertEquals(1, recursos.size());
        System.assertEquals('Proceso de Solicitud de CAPEX' , recursos[0].name );
        System.assert(recursos[0].puede_acceder_a_una_solicitud_capex__c);
    }
}