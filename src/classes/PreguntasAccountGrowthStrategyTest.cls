@isTest
public class PreguntasAccountGrowthStrategyTest {

    static testMethod void puedoInsertarLasRespuestas(){
        
        Account cuenta = new Account(name = 'nombre cuenta');
        insert cuenta;
        
        PageReference cuestionario = Page.PreguntasAccountGrowthStrategy;
        Test.setCurrentPage(cuestionario);
        cuestionario.getParameters().put('id', cuenta.id);
        
        PreguntasAccountGrowthStrategyController controller = new PreguntasAccountGrowthStrategyController();
        
        controller.insertarSetDePreguntas();
        
        List<Pregunta_AccountGrowthStrategy__c> respuestas = [select id, Cuenta__c, For_these_TOP_opps_you_just_mentioned_p__c, Include_more_relevant_opportunities_you__c,
                                                              What_are_your_plans_to_develop_and_grow__c, What_are_your_Top_opportunities_that_wil__c from Pregunta_AccountGrowthStrategy__c
                                                              where Cuenta__c =: cuenta.id limit 1];
        
        system.assertEquals(1, respuestas.size());
        
        controller.setDeRespuestas.For_these_TOP_opps_you_just_mentioned_p__c = 'hola';
        
        controller.saveChanges();
        
        respuestas = [select id, Cuenta__c, For_these_TOP_opps_you_just_mentioned_p__c, Include_more_relevant_opportunities_you__c,
                      What_are_your_plans_to_develop_and_grow__c, What_are_your_Top_opportunities_that_wil__c from Pregunta_AccountGrowthStrategy__c
                      where Cuenta__c =: cuenta.id limit 1];
        
        system.assertEquals('hola', respuestas[0].For_these_TOP_opps_you_just_mentioned_p__c);
    }
}