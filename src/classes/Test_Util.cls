@isTest
private class Test_Util {

	static testMethod void checkParentRegions() {
		Region__c r1 = new Region__c(Name = 'r1');
		insert r1;

		Region__c r2 = new Region__c(Name = 'r1', Parent__c = r1.id);
		insert r2;

		Region__c r3 = new Region__c(Name = 'r1', Parent__c = r2.id);
		insert r3;

		system.assertEquals(1, Util.getParentsRegions(r1).size());
		system.assertEquals(2, Util.getParentsRegions(r2).size());
		system.assertEquals(3, Util.getParentsRegions(r3).size());

	}

	
	static testmethod void PuedoEliminarUnObjetoDeUnaLista() {

		List<Region__c> regiones = new List<Region__c> ();

		Region__c r1 = new Region__c(Name = 'r1');
		Account a = new Account(name='asd');
		regiones.add(r1);

		Util.removeObjectFromList(regiones, r1);
		System.assertEquals(0, regiones.size());

		try 
		{	        
		Util.removeObjectFromList(regiones, a);
		}
		catch (UtilException e)
		{
			System.assert(null != e.getMessage());
			System.debug(e.getMessage());
		}
	}

}