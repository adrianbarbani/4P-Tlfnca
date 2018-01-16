public class SCPMenu {

    public String temp {get; set;}
    
    public String ObjectType {get; set;}
    
    public Boolean isAccount {get; set;}
    
    public Account Acct {get; set;}
    
    public String name_account {get; set;}
    
    public Boolean hasPermission {get; set;}
	public Boolean hasPermissionRegion {get; set;}
	public Boolean hasPermissionPowerBalls {get; set;}
    
	public Boolean isOpp {get; set;}
	
    public String idCuentaPrincipal {get;set;}
    
    public SCPMenu(){
    	
        system.debug(ApexPages.currentPage().getParameters().get('IdPadre'));
        if(ApexPages.currentPage().getParameters().get('IdPadre') != null){
            idCuentaPrincipal = ApexPages.currentPage().getParameters().get('IdPadre');
        }else{
            idCuentaPrincipal = ApexPages.currentPage().getParameters().get('Id');
        }
        
    	List<PermissionSetAssignment> psaList = [SELECT PermissionSetId, PermissionSet.Name FROM PermissionSetAssignment WHERE AssigneeId= :UserInfo.getUserId() AND (PermissionSet.Name = 'Admin_SCP' or PermissionSet.Name = 'Admin_SCP_Region' or PermissionSet.Name = 'Admin_SCP_PowerBalls')];
        
        hasPermission = false;
        hasPermissionRegion = false;
        hasPermissionPowerBalls = false;
        
        if (psaList.size() > 0) {
            for (PermissionSetAssignment psa :psaList) {
        		system.debug(psa.PermissionSet.Name);
                if (psa.PermissionSet.Name == 'Admin_SCP') {
            		hasPermission = true;		
            	}
            	if (psa.PermissionSet.Name == 'Admin_SCP_Region') {
            		hasPermissionRegion = true;		
            	}
                if (psa.PermissionSet.Name == 'Admin_SCP_PowerBalls') {
            		hasPermissionPowerBalls = true;		
            	}
            	if (hasPermission && hasPermissionRegion && hasPermissionPowerBalls) {
            		break;
            	}
            }
        }
    	
        if(ApexPages.currentPage().getParameters().get('Id') != null){
            
            Id objectId = (Id) ApexPages.currentPage().getParameters().get('Id');
    		String objectAPIName = objectId.getSObjectType().getDescribe().getName();
            
            if(objectAPIName != 'certa_SCP__Super_Ball_Arbol__c' && objectAPIName != 'certa_SCP__catalogo__c'){
                isOpp = false;
                if (objectAPIName == 'Opportunity') {
                    isOpp = true;            
                }
                
                isAccount = true;
                
                Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
                Map<String,String> keyPrefixMap = new Map<String,String>{};
                    Set<String> keyPrefixSet = gd.keySet();
                for(String sObj : keyPrefixSet){
                    Schema.DescribeSObjectResult r =  gd.get(sObj).getDescribe();
                    String tempName = r.getName();
                    String tempPrefix = r.getKeyPrefix();
                    //System.debug('Processing Object['+tempName + '] with Prefix ['+ tempPrefix+']');
                    keyPrefixMap.put(tempPrefix,tempName);
                }
                
                
                String tPrefix = ApexPages.currentPage().getParameters().get('Id');
                tPrefix = tPrefix.subString(0,3);
                ObjectType = keyPrefixMap.get(tPrefix);
                
                if(ObjectType=='Contact'){
                    
                    Contact temp = [SELECT AccountId FROM Contact WHERE id = :ApexPages.currentPage().getParameters().get('Id')];
                    
                    Acct = [ SELECT id, name FROM Account WHERE id = :temp.AccountId];
                    
                    
                }else if(ObjectType=='Opportunity'){
                    
                    Opportunity temp = [SELECT AccountId FROM Opportunity WHERE id = :ApexPages.currentPage().getParameters().get('Id')];
                    
                    Acct = [ SELECT id, name FROM Account WHERE id = :temp.AccountId];
                    
                    
                }else if(ObjectType=='Solicitud_Capex__c'){
                    //Solicitud_capex__c temp = [SELECT Opportunity__r.AccountId From Solicitud_capex__c WHERE ID = : objectId];
                    Acct = [SELECT ID, name FROM Account WHERE id = '001G000001EizVQIAZ'];//temp.Opportunity__r.AccountId ];
                }else if(ObjectType=='Account'){
                    
                    Acct = [ SELECT id, name FROM Account WHERE id = :ApexPages.currentPage().getParameters().get('Id')];
                    
                }
                
                name_account=Acct.Name;
                if(name_account.length()>30)
                    name_account=name_account.substring(0,30);
            }else{
                this.isAccount = false;
                
                Acct = null;
                name_account=null; 
            }
        }else{
        
            this.isAccount = false;
        
            Acct = null;
            name_account=null;
    
        }
    }

}