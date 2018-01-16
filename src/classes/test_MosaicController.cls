@isTest
private class test_MosaicController {

    static testMethod void myUnitTest() {
      
        Account cuenta=new Account();
        cuenta.Name='test';
        cuenta.industry = 'Banking';
        
        insert cuenta;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test';
        opp.StageName = 'Open';
        opp.CloseDate = System.Today();
        opp.accountId = cuenta.id;
        insert opp;
        

        Contact contacto = new Contact();
        contacto.LastName = 'test';
        contacto.AccountId = cuenta.id;
        insert contacto;
        
        Contact contacto2 = new Contact();
        contacto2.LastName = 'test';
        contacto2.AccountId = cuenta.id;
        contacto2.ReportsToId = contacto.id;
        insert contacto2;
        
        Contact_Influence__c ci = new Contact_Influence__c();
        ci.Contact_Influenced__c = contacto.id;
        ci.Contact_Influences__c = contacto2.id;
        insert ci;
        
        
        Contact_Assessment__c ca = new Contact_Assessment__c();
        ca.Contact__c = contacto.id;
        ca.Opportunity__c = opp.id;
        insert ca;
        
        ca = new Contact_Assessment__c();
        ca.Contact__c = contacto2.id;
        ca.Opportunity__c = opp.id;
        ca.Focus__c = 'End User';
        ca.Influence__c = 'Negative';
        ca.Attitudes__c = 'Negative';
        ca.Authority__c = 'Positive';
        ca.Buying_Cycle__c = 'Assessments of Alternatives';
        ca.Our_Relationship__c = 'Positive';
        ca.Competing_Company_Relationship__c = 'Positive';
        insert ca;
        
        System.debug(ca);
    System.currentPagereference().getParameters().put('id',opp.id);
        
      
      MosaicController t = new MosaicController();
      
      
      List<ExtendedEvaluation> lista = t.getEndUserNegativeNegativeInfluencePositiveAuthority();
    System.debug(lista);
    if(lista.size()>0)
      lista[0].getAcciones();


      t.getEndUserNegativeNegativeInfluenceNegativeAuthority();
      
          // getSOQLQuery('End User','Negative','Negative','Negative');
   
      //}
  
  
      t.getEndUserBurningPlatformNegativeInfluencePositiveAuthority();
          // getSOQLQuery('End User','Burning Platform','Negative','Positive');
      //}
  
  
      t.getEndUserBurningPlatformNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('End User','Burning Platform','Negative','Negative');
      //}
  
  
      t.getEndUserNegativePositiveInfluencePositiveAuthority();
          // getSOQLQuery('End User','Negative','Positive','Positive');
      //}
  
  
      t.getEndUserNegativePositiveInfluenceNegativeAuthority();
          // getSOQLQuery('End User','Negative','Positive','Negative');
      //}
  
  
      t.getEndUserBurningPlatformPositiveInfluencePositiveAuthority();
          // getSOQLQuery('End User','Burning Platform','Positive','Positive');
      //}
  
  
      t.getEndUserBurningPlatformPositiveInfluenceNegativeAuthority();
          // getSOQLQuery('End User','Burning Platform','Positive','Negative');
      //}
  
  
      t.getEndUserDeveloperNegativeInfluencePositiveAuthority();
          // getSOQLQuery('End User','Developer','Negative','Positive');
      //}
  
  
      t.getEndUserDeveloperNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('End User','Developer','Negative','Negative');
      //}
  
  
      t.getEndUserStatuQuoNegativeInfluencePositiveAuthority();
          // getSOQLQuery('End User','Statu Quo','Negative','Positive');
      //}
  
  
      t.getEndUserStatuQuoNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('End User','Statu Quo','Negative','Negative');
      //}
  
  
      t.getEndUserDeveloperPositiveInfluencePositiveAuthority();
          // getSOQLQuery('End User','Developer','Positive','Positive');
      //}
  
  
      t.getEndUserDeveloperPositiveInfluenceNegativeAuthority();
          // getSOQLQuery('End User','Developer','Positive','Negative');
      //}
  
  
      t.getEndUserStatuQuoPositiveInfluencePositiveAuthority();
          // getSOQLQuery('End User','Statu Quo','Positive','Positive');
      //}
  
  
      t.getEndUserStatuQuoPositiveInfluenceNegativeAuthority();
          // getSOQLQuery('End User','Statu Quo','Positive','Negative');
      //}
  
   // Technical
   
       t.getTechnicalNegativeNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Technical','Negative','Negative','Positive');
      //}
  
  
      t.getTechnicalNegativeNegativeInfluenceNegativeAuthority();
      
          // getSOQLQuery('Technical','Negative','Negative','Negative');
   
      //}
  
  
      t.getTechnicalBurningPlatformNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Technical','Burning Platform','Negative','Positive');
      //}
  
  
      t.getTechnicalBurningPlatformNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('Technical','Burning Platform','Negative','Negative');
      //}
  
  
      t.getTechnicalNegativePositiveInfluencePositiveAuthority();
          // getSOQLQuery('Technical','Negative','Positive','Positive');
      //}
  
  
      t.getTechnicalNegativePositiveInfluenceNegativeAuthority();
          // getSOQLQuery('Technical','Negative','Positive','Negative');
      //}
  
  
      t.getTechnicalBurningPlatformPositiveInfluencePositiveAuthority();
          // getSOQLQuery('Technical','Burning Platform','Positive','Positive');
      //}
  
  
      t.getTechnicalBurningPlatformPositiveInfluenceNegativeAuthority();
          // getSOQLQuery('Technical','Burning Platform','Positive','Negative');
      //}
  
  
      t.getTechnicalDeveloperNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Technical','Developer','Negative','Positive');
      //}
  
  
      t.getTechnicalDeveloperNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('Technical','Developer','Negative','Negative');
      //}
  
  
      t.getTechnicalStatuQuoNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Technical','Statu Quo','Negative','Positive');
      //}
  
  
      t.getTechnicalStatuQuoNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('Technical','Statu Quo','Negative','Negative');
      //}
  
  
      t.getTechnicalDeveloperPositiveInfluencePositiveAuthority();
          // getSOQLQuery('Technical','Developer','Positive','Positive');
      //}
  
  
      t.getTechnicalDeveloperPositiveInfluenceNegativeAuthority();
          // getSOQLQuery('Technical','Developer','Positive','Negative');
      //}
  
  
      t.getTechnicalStatuQuoPositiveInfluencePositiveAuthority();
          // getSOQLQuery('Technical','Statu Quo','Positive','Positive');
      //}
  
  
      t.getTechnicalStatuQuoPositiveInfluenceNegativeAuthority();
          // getSOQLQuery('Technical','Statu Quo','Positive','Negative');
      //}
  
  
  // Controller
   
       t.getControllerNegativeNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Controller','Negative','Negative','Positive');
      //}
  
  
      t.getControllerNegativeNegativeInfluenceNegativeAuthority();
      
          // getSOQLQuery('Controller','Negative','Negative','Negative');
   
      //}
  
  
      t.getControllerBurningPlatformNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Controller','Burning Platform','Negative','Positive');
      //}
  
  
      t.getControllerBurningPlatformNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('Controller','Burning Platform','Negative','Negative');
      //}
  
  
      t.getControllerNegativePositiveInfluencePositiveAuthority();
          // getSOQLQuery('Controller','Negative','Positive','Positive');
      //}
  
  
      t.getControllerNegativePositiveInfluenceNegativeAuthority();
          // getSOQLQuery('Controller','Negative','Positive','Negative');
      //}
  
  
      t.getControllerBurningPlatformPositiveInfluencePositiveAuthority();
          // getSOQLQuery('Controller','Burning Platform','Positive','Positive');
      //}
  
  
      t.getControllerBurningPlatformPositiveInfluenceNegativeAuthority();
          // getSOQLQuery('Controller','Burning Platform','Positive','Negative');
      //}
  
  
      t.getControllerDeveloperNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Controller','Developer','Negative','Positive');
      //}
  
  
      t.getControllerDeveloperNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('Controller','Developer','Negative','Negative');
      //}
  
  
      t.getControllerStatuQuoNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Controller','Statu Quo','Negative','Positive');
      //}
  
  
      t.getControllerStatuQuoNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('Controller','Statu Quo','Negative','Negative');
      //}
  
  
      t.getControllerDeveloperPositiveInfluencePositiveAuthority();
          // getSOQLQuery('Controller','Developer','Positive','Positive');
      //}
  
  
      t.getControllerDeveloperPositiveInfluenceNegativeAuthority();
          // getSOQLQuery('Controller','Developer','Positive','Negative');
      //}
  
  
      t.getControllerStatuQuoPositiveInfluencePositiveAuthority();
          // getSOQLQuery('Controller','Statu Quo','Positive','Positive');
      //}
  
  
      t.getControllerStatuQuoPositiveInfluenceNegativeAuthority();
          // getSOQLQuery('Controller','Statu Quo','Positive','Negative');
      //}
  
   // Sponsor
   
       t.getSponsorNegativeNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Sponsor','Negative','Negative','Positive');
      //}
  
  
      t.getSponsorNegativeNegativeInfluenceNegativeAuthority();
      
          // getSOQLQuery('Sponsor','Negative','Negative','Negative');
   
      //}
  
  
      t.getSponsorBurningPlatformNegativeInfluencePositiveAuthority();
          // getSOQLQuery('Sponsor','Burning Platform','Negative','Positive');
      //}
  
  
      t.getSponsorBurningPlatformNegativeInfluenceNegativeAuthority();
          // getSOQLQuery('Sponsor','Burning Platform','Negative','Negative');
      //}
  
  
      t.getSponsorNegativePositiveInfluencePositiveAuthority();
          // getSOQLQuery('Sponsor','Negative','Positive','Positive');
      //}
  
  
      t.getSponsorNegativePositiveInfluenceNegativeAuthority();
          // getSOQLQuery('Sponsor','Negative','Positive','Negative');
      //}
  
  
      t.getSponsorBurningPlatformPositiveInfluencePositiveAuthority();
      t.getSponsorBurningPlatformPositiveInfluenceNegativeAuthority();
      t.getSponsorDeveloperNegativeInfluencePositiveAuthority();
      t.getSponsorDeveloperNegativeInfluenceNegativeAuthority();
      t.getSponsorStatuQuoNegativeInfluencePositiveAuthority();
      t.getSponsorStatuQuoNegativeInfluenceNegativeAuthority();
      t.getSponsorDeveloperPositiveInfluencePositiveAuthority();
      t.getSponsorDeveloperPositiveInfluenceNegativeAuthority();
      t.getSponsorStatuQuoPositiveInfluencePositiveAuthority();
      t.getSponsorStatuQuoPositiveInfluenceNegativeAuthority();
    }
}