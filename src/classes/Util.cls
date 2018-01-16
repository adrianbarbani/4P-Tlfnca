global class Util {

	private static Map<String, Decimal> map_currency { get; set; }
	private static Region__c region;
	private static Id accountId;
	public static Account globalAccount { get; set; }

	public static Region__c getRegionFromAccount(Id accId, Id regionId) {
		if (region == null || accountId != accId) {
			accountId = accId;
			List<Region__c> regionsList = [SELECT Id, Name, parent__c FROM Region__c WHERE id = :regionId];
			if (regionsList.size() > 0) {
				region = regionsList.get(0);
			} else {
				List<Region__c> globalRegion = [SELECT Id, Name, parent__c FROM Region__c WHERE name = 'Global'];
				if (globalRegion.size() > 0) {
					region = globalRegion.get(0);
				} else {
					region = new Region__c();
				}
			}
		}
		return region;

	}

	public static String transforma_miles(Decimal s) {
		return Util.transforma_miles(s + '');
	}

	public static String transforma_miles(String s) {

		//system.debug('TESTEO 0 '+s);
		Boolean negativo = (s.contains('-')) ? true : false;
		if (negativo)
		s = s.split('-') [1];

		Integer dec = 0;
		String parte_entera = '';

		if (s.contains(','))
		parte_entera = s.split(',') [0];
		else
		parte_entera = s;

		Integer i = 3;
		String tmp;
		while (parte_entera.length() > i) {

			//system.debug('TESTEO 1 '+parte_entera.substring(0, parte_entera.length() - i));
			//system.debug('TESTEO 2 '+parte_entera.substring(parte_entera.length() - i));

			tmp = parte_entera.substring(0, parte_entera.length() - i) + '.' + parte_entera.substring(parte_entera.length() - i);
			parte_entera = tmp;
			i += 4;
		}

		String transformado;


		//if(s.contains(','))
		//        transformado=parte_entera+','+s.split(',')[1];
		//else
		transformado = parte_entera;

		if (negativo)
		transformado = '-' + transformado;


		return transformado;

	}

	global static Boolean checkMultiCurrencyEnabled() {
		Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
		Schema.SObjectType mcEnabled = gd.get('DatedConversionRate');
		return(mcEnabled != null) ? true : false;
	}

	public static Map<String, Decimal> getCurrencyMap() {
		if (map_currency == null) {
			map_currency = new Map<String, Decimal> ();
			if (checkMultiCurrencyEnabled()) {
				List<sObject> ratios = Database.query('select IsoCode, ConversionRate from CurrencyType');
				map_currency = new Map<String, Decimal> ();
				for (sObject ct : ratios) {
					map_currency.put((String) ct.get('IsoCode'), (Decimal) ct.get('ConversionRate'));
				}
			} else {
				// TODO allow currency configuration. There's no way of getting the configured currency for the organization: https://success.salesforce.com/ideaView?id=08730000000bEGWAA2
				map_currency.put('EUR', 1);
			}
		}
		return map_currency;
	}

	public static Decimal getCurrencyConverted(Decimal myCurrency, String currencyIni, String currencyEnd) {
		system.debug('>>>>> ' + 'myCurrency: ' + myCurrency + ' currencyIni: ' + currencyIni + ' currencyEnd: ' + currencyEnd);
		system.debug('>>>>> Util.getCurrencyMap(): ' + Util.getCurrencyMap());
		if (Util.getCurrencyMap().get(currencyIni) != null && Util.getCurrencyMap().get(currencyEnd) != null) {
			if (Util.checkMultiCurrencyEnabled() && currencyIni != currencyEnd) {
				return myCurrency / Util.getCurrencyMap().get(currencyIni) * Util.getCurrencyMap().get(currencyEnd);
			} else {
				return myCurrency;
			}
		} else {
			return null;
		}
	}

	public static String getUserIsoCode() {
		return UserInfo.getDefaultCurrency();
	}

	public static String getCompanyIsoCode() {
		Map<String, Decimal> currencyMap = Util.getCurrencyMap();
		String res = 'Fail';
		for (String d : currencyMap.keySet()) {
			if (currencyMap.get(d) == 1) {
				res = d;
				break;
			}
		}
		return res;
	}

	/*
	  public static void setPrincipalProduct(Map<Id, Opportunity__c> oppMap, Map<Id, List<ProductOpportunity__c>> prodOppMap, Map<Id, Id> prodMap, Map<Id,Id> prodOppPrincipalIdMap) {            
	  system.debug('>>>>> oppMap: ' + oppMap + ' prodOppMap: ' + prodOppMap + ' prodMap: ' + prodMap + ' prodOppPrincipalIdMap: ' + prodOppPrincipalIdMap);
	  List<ProductOpportunity__c> prodOppsToInsert = new List<ProductOpportunity__c>();
	  List<ProductOpportunity__c> prodOppsToUpdate = new List<ProductOpportunity__c>();
	  List<Opportunity__c> oppsToUpdate = new List<Opportunity__c>();
	 
	 
	  For (Id oppId :oppMap.keySet()) {            
	 
	  if (prodOppPrincipalIdMap.get(oppId) != null) {
	  //Si son distintos hay que actualizar
	  if ((prodOppPrincipalIdMap.get(oppId) != oppMap.get(oppId).Producto_Principal__c) || (prodOppPrincipalIdMap.get(oppId) !=  prodMap.get(oppId))) {
	  // Si el producto es == al de la Opp actualizo los prodOpp y es distinto actualizo la Opp
	  if (oppMap.get(oppId).Producto_Principal__c == prodMap.get(oppId)) {
	  //Hay que actualizar los prodOpps
	  system.debug('>>>>> Actualizo los ProdOpps (1)');                        
	  if (oppMap.get(oppId).Producto_Principal__c != null) {
	  updateProdOpp(oppId, prodOppMap.get(oppId), prodOppsToUpdate, prodOppsToInsert, prodMap.get(oppId));                     
	  } else {
	  for (ProductOpportunity__c prodOpp :prodOppMap.get(oppId)) {
	  if ((prodOpp.Principal__c) && (prodOpp.Id != prodMap.get(oppId))) {
	  prodOpp.Principal__c = false;
	  prodOppsToUpdate.add(prodOpp);
	  }   
	  }  
	  }
	  } else {
	  //Hay que actualizar la opp
	  system.debug('>>>>> Actualizo la Opp');
	  oppMap.get(oppId).Producto_Principal__c = prodMap.get(oppId);
	  oppsToUpdate.add(oppMap.get(oppId));
	  for (ProductOpportunity__c prodOpp :prodOppMap.get(oppId)) {
	  if ((prodOpp.Principal__c) && (prodOpp.Id != prodMap.get(oppId))) {
	  prodOpp.Principal__c = false;
	  prodOppsToUpdate.add(prodOpp);
	  }   
	  }
	  }
	  }
	  } else {
	  //No existe principal - Hay que actualizar los prodOpps
	  system.debug('>>>>> Actualizo los ProdOpps (2)');
	  if (oppMap.get(oppId).Producto_Principal__c != null) {
	  updateProdOpp(oppId, prodOppMap.get(oppId), prodOppsToUpdate, prodOppsToInsert, prodMap.get(oppId));
	  }
	  }
	 
	  }        
	 
	  insert prodOppsToInsert;
	  update prodOppsToUpdate;        
	  update oppsToUpdate;
	 
	  }
	 
	  private Static void updateProdOpp(Id oppId, List<ProductOpportunity__c> prodOppList, List<ProductOpportunity__c> prodOppsToUpdate, List<ProductOpportunity__c> prodOppsToInsert, Id prodId) {
	  Boolean updated = false; 
	  if (prodOppList != null) {
	  //for (ProductOpportunity__c prodOpp :prodOppMap.get(oppId)) {
	  for (ProductOpportunity__c prodOpp :prodOppList) {
	  //if (prodMap.get(oppId) == prodOpp.SCP_Producto__c) {
	  if (prodId == prodOpp.SCP_Producto__c) {            
	  prodOpp.Principal__c = true;
	  prodOppsToUpdate.add(prodOpp);
	  updated = true;
	  } else {
	  if (prodOpp.Principal__c) {
	  prodOpp.Principal__c = false;
	  prodOppsToUpdate.add(prodOpp);
	  system.debug('>>>>>> Poner false prodOpp: ' + prodOppList);
	  }
	  }
	  }  
	  }
	  if (!updated) {
	  ProductOpportunity__c prodOpp = new ProductOpportunity__c();
	  prodOpp.Principal__c = true;
	  prodOpp.SCP_Producto__c = prodId;
	  prodOpp.SCP_Oportunidad__c = oppId;
	  prodOppsToUpdate.add(prodOpp);
	  prodOppsToInsert.add(prodOpp);
	  }
	  }
	 */
    

	public Static List<Id> getUserHierarchy(Id userId) {
		List<Id> ids = new List<Id> ();
		ids.add(userId);
		ids.addAll(Util.getUserHierarchy(ids));
		return ids;
	}

	private Static List<Id> getUserHierarchy(List<Id> listIds) {

		List<Id> ids = new List<Id> ();
		for (User u :[select id from user where ManagerId in :listIds]) {
			ids.add(u.id);
		}

		if (ids.size() > 0) {
			ids.addAll(getUserHierarchy(ids));
		}
		return ids;
	}

	public Static List<Id> getParentsRegions(Region__c reg) {
		List<Id> regionsIds = new List<Id> ();
		regionsIds.add(reg.id);

		If (reg.parent__c == null) {
			return regionsIds;
		}

		Map<Id, Region__c> regionMap = new Map<Id, Region__c> ([select id, Parent__c from Region__c Limit 1000]);

		Id parent = reg.parent__c;
		while (parent != null) {
			regionsIds.add(parent);
			parent = regionMap.get(parent).parent__c;
		}

		return regionsIds;
	}

	public static String getFieldLabel(String objectName, String fieldName) {

		String stype = objectName;

		Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		Schema.SObjectType leadSchema = schemaMap.get(stype);

		Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
		String mylabel = fieldMap.get(fieldName).getDescribe().getLabel();

		return mylabel;
	}

	public static void removeObjectFromList(List<sObject> lst, sObject obj) {

		if (lst.getsObjectType() != obj.getsObjectType())
		{
			throw new UtilException('No se puede remover un objeto del tipo ' + obj.getsObjectType() + ' En una List<' + lst.getsObjectType() + '>.');
		}

		for (Integer i = lst.size() - 1; i >= 0;-- i) {
			if (lst.get(i) == obj) {
				lst.remove(i);
			}
		}
	}
	
    public static Boolean listContains(List<sObject> lst, sObject obj){
        
        boolean contains = false;
        
        if (lst.getsObjectType() != obj.getsObjectType())
        {
            throw new UtilException('No se puede saber si contiene un objeto del tipo ' + obj.getsObjectType() + ' En una List<' + lst.getsObjectType() + '>.');
        }

        for (Integer i = lst.size() - 1; i >= 0;-- i) {
            if (lst.get(i) == obj) {
                contains = true;
            }
        }
        
        return contains;
    }
    
    public static Set<ID> getRoleSubordinateUsers(Id roleId) {
        
        // get all of the roles underneath the user
        Set<Id> allSubRoleIds = getAllSubRoleIds(new Set<ID>{roleId});
        
        // get all of the ids for the users in those roles
        Map<Id,User> users = new Map<Id, User>([Select Id, Name From User where
                                                UserRoleId IN :allSubRoleIds and isActive = true ]);
        
        // return the ids of the users as a set 
        return users.keySet();
        
    }
    
    private static Set<ID> getAllSubRoleIds(Set<ID> roleIds) {
        
        Set<ID> currentRoleIds = new Set<ID>();
        
        // get all of the roles underneath the passed roles
        for(UserRole userRole :[select Id from UserRole where ParentRoleId
                                IN :roleIds AND ParentRoleID != null]){
                                    currentRoleIds.add(userRole.Id);
                                }
        
        // go fetch some more rolls!
        if(currentRoleIds.size() > 0){
            currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds));
        }
        
        return currentRoleIds;
        
    }
    
    //Agregados por Fede para traer un solo nivel debajo de tu jerarquia
   /* public static Set<ID> getPrimerosRoles(Id roleId) {
        
        // get all of the roles underneath the user
        Set<Id> allSubRoleIds = getPrimerSubRol(new Set<ID>{roleId});
        
        // get all of the ids for the users in those roles
        Map<Id,User> users = new Map<Id, User>([Select Id, Name From User where
                                                UserRoleId IN :allSubRoleIds limit 955]);
        
        // return the ids of the users as a set 
        return users.keySet();
        
    }
    
    private static Set<ID> getPrimerSubRol(Set<ID> roleIds) {
        
        Set<ID> currentRoleIds = new Set<ID>();
        
        // get all of the roles underneath the passed roles
        for(UserRole userRole :[select Id from UserRole where ParentRoleId
                                IN :roleIds AND ParentRoleID != null limit 955]){
                                    currentRoleIds.add(userRole.Id);
                                }
       
       
        return currentRoleIds;
        
    }*/


	//get helpText
	//Schema."Objeto".fields."atributo".getDescribe().getInlineHelpText()
	//Schema.Big_deals_Survey__c.fields.Arquitectura_tecnica__c.getDescribe().getInlineHelpText()
}