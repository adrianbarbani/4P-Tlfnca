global class AccountOrganizationChart {

    private ApexPages.StandardController controller;
    private final Account acct;
    public Account account {get;set;}
    private Integer querys = 0;
    private List<Contact> allContacts;
    private List<Contact> inOrgContacts;
    private List<Contact_Influence__c> allContactInfluences;
    
    public AccountOrganizationChart(ApexPages.StandardController controller) {
    
        this.controller = controller;
        //this.acct = (Account)controller.getRecord();
        this.acct = [select id, name from account where id = :((Account)controller.getRecord()).id];
        account = acct;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, ''));
    }   
  
  	public AccountOrganizationChart() {
  		Id objectId = ApexPages.currentPage().getParameters().get('Id');
  		String objectAPIName = objectId.getSObjectType().getDescribe().getName();
  		if (objectAPIName == 'Account') {
  			this.acct = [SELECT  id, name FROM Account WHERE Id = :objectId];
  		} else if (objectAPIName == 'Opportunity') {
  			Opportunity opp = [select accountId from Opportunity where id = :objectId];
  			this.acct = [SELECT id, name FROM Account WHERE Id = :opp.accountId];
  		}  		
  		account = acct;
  		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, ''));
  	}
  
    public List<Contact> getContacts() {
        if (allContacts == null) {
            allContacts = [SELECT id,Name,title, Closest_Account_Team_Member__r.name, Picture__c, ReportsToId, inOrg__c FROM Contact WHERE active__c = true and AccountId = :this.acct.id];
        }
        
        for(Contact cont : allContacts){
            cont.inOrg__c = true;
        }
        
        return allContacts;    
    }
    
    public PageReference saveContacts() {    	
    	update allContacts;
    	return null;
    }
    
    public List<Contact> getInOrgContacts() {    	
        inOrgContacts = new List<Contact>();       	    
        for (Contact c :getContacts()) {
    		if (c.inOrg__c) {
				inOrgContacts.add(c);        			
    		}
    	}
        return inOrgContacts;  
    }
    
    public String getList(){
    
        String ret = '<ul id="org" style="display:none;">';
        ret += '<li><div id="Parent">' + acct.Name + '</div>';
        ret += '<ul style="display:none;">';
        
        getContacts();
        querys++;
        
        List <Id> contactIds = new List<Id>();
        //for (Contact c :allContacts) {
        for (Contact c :getInOrgContacts()) {
            contactIds.add(c.id);
        }
        
        allContactInfluences = [SELECT Contact_Influenced__c, Contact_Influences__c FROM Contact_Influence__c 
                                WHERE Contact_Influenced__c in :contactIds or Contact_Influences__c = :contactIds]; 
        querys++;
        
        List<Contact> seeds = getContacts(null);        
        
        for (Contact a : seeds){
        
            
            String accountTitle = '';
            if(a.title !=null) {
                accountTitle = a.title;
            }
            ret += '<li><div class="leaf '+a.Id+'" id="'+a.Id+'"><Table><tr><td rowspan="2" class="AccountPicture">'+a.Picture__c+'</td><td class="AccountName">'+a.name+'</td></tr><tr><td class="AccountTitle">'+accountTitle+'</td></tr></table></div>';
            
            if(a.Closest_Account_Team_Member__r.name != null) {
                ret += '<div class="closestcontact">Closest team member:<br/>'+a.Closest_Account_Team_Member__r.name +'</div>';
            }
            
            List<Contact_Influence__c> influenceList = getInfluences(a.id);
            
            ret += '<div class="influences"  style="display:none;">';
         
            for (Contact_Influence__c ci :influenceList) {
                if (ci.Contact_Influenced__c == a.Id) {
                    ret += ci.Contact_Influences__c+',';
                }
            }
            
            
            ret += '</div><div class="influenced"  style="display:none;">';

            for (Contact_Influence__c ci :influenceList) {
                if (ci.Contact_Influences__c == a.Id) {
                    ret += ci.Contact_Influenced__c+',';
                }
            }
            
            
            ret += '</div>'+this.getListChilds(a.id)+'</li>';
        
        }
        ret += '</ul>';
        ret += '</li>';
        ret += '</ul>';
        system.debug('>>>>> Cantidad de query: ' + querys);
        return ret;
    }
    
    public String getListChilds(String rid){
    
        String ret = '<ul>';
        List<Contact> seeds = getContacts(rid);
        
        for (Contact a : seeds){
        
            String accountTitle = '';
            if(a.title !=null) {
                accountTitle = a.title;
            }
            ret += '<li><div class="leaf '+a.Id+'" id="'+a.Id+'"><Table><tr><td rowspan="2" class="AccountPicture">'+a.Picture__c+'</td><td class="AccountName">'+a.name+'</td></tr><tr><td class="AccountTitle">'+accountTitle+'</td></tr></table></div>';    
            if(a.Closest_Account_Team_Member__r.name != null) {
                ret += '<div class="closestcontact">Closest team member:<br/>'+a.Closest_Account_Team_Member__r.name +'</div>';
            }
            ret += '<div class="influences"  style="display:none;">';
            
            List<Contact_Influence__c> influenceList = getInfluences(a.id);
  
            for (Contact_Influence__c ci :influenceList) {
                if (ci.Contact_Influenced__c == a.Id) {
                    ret += ci.Contact_Influences__c+',';
                }
            }            
            
            ret += '</div><div class="influenced"  style="display:none;">';                                    
            
            for (Contact_Influence__c ci :influenceList) {
                if (ci.Contact_Influences__c == a.Id) {
                    ret += ci.Contact_Influenced__c+',';
                }
            }
            
            ret += '</div>'+this.getListChilds(a.id)+'</li>';
        
        }
    
        ret += '</ul>';
        
        if(seeds != null)
            return ret;
        else 
            return '';
    }        

    private List<Contact_Influence__c> getInfluences(Id contactId) {
        List<Contact_Influence__c> influencesList = new List<Contact_Influence__c>();
        for (Contact_Influence__c ci :allContactInfluences) {
            if (ci.Contact_Influences__c == contactId || ci.Contact_Influenced__c == contactId) {
                influencesList.add(ci);
            }
        }
        return influencesList;
    }

    private List<Contact> getContacts(Id contactId) {
        List<Contact> contactList = new List<Contact>();
        for (Contact cont :getInOrgContacts()) {
            if (cont.ReportsToId == contactId) {
                contactList.add(cont);
            }
        }   
        return contactList;
    }
    
    @RemoteAction
    global static void changeOrg(Id sourceId, Id targetId) {        
        List<Contact> contactToUpdate = new List<Contact>();
        for (Contact c :[select Id, ReportsToId from Contact where id != :sourceId and id != :targetId and (ReportsToId = :sourceId or ReportsToId = :targetId)]) {
            if (c.ReportsToId == sourceId) {
                c.ReportsToId = targetId;
            } else {
                c.ReportsToId = sourceId;
                
            }
            contactToUpdate.add(c);
        }
        
        Contact source;
        Contact target;     
        for (Contact c :[select Id, ReportsToId from Contact where Id = :sourceId or Id = :targetId]) {
            if (c.Id == sourceId) {
                source = c;
            } else {
                target = c;
            }           
        }
        
        Id aux = source.ReportsToId;
        source.ReportsToId = target.ReportsToId;
        if (target.id != aux) {
            target.ReportsToId = aux;           
        } else {
            target.ReportsToId = source.id;
        }
        contactToUpdate.add(source);
        contactToUpdate.add(target);
        
        update contactToUpdate;
    }
    
    @RemoteAction
    global static void saveOrg(List<JavascriptObject> jsObject) {
        
        Map<Id,String> contactMap = new Map<Id,String>();
        Map<Id,List<Id>> contactInfluenceMap = new Map<Id,List<Id>>();
        for(JavascriptObject o :jsObject) {
            system.debug('>>>> o: ' + o);
            if (o.value != 'Parent') {
                contactMap.put(o.value,o.parent);
                List<Id> ids = new List<Id>(); 
                for (String s :o.influences.split(',')) {
                    if (s != '') {
                        ids.add(s);
                    }
                }
                contactInfluenceMap.put(o.value, ids);
            }
        }
        system.debug('>>>> contactMap: ' + contactMap);        
                
        List<Contact> contatsToUpdate = new List<Contact>();
        for(Contact c :[select id, ReportsToId from Contact where id in :contactMap.keySet()]) {
            if (contactMap.get(c.Id) != 'Parent') {
                c.ReportsToId = contactMap.get(c.Id);
            } else {
                c.ReportsToId = null;
            }
            contatsToUpdate.add(c);
        }       
        
        delete [select id from Contact_Influence__c where Contact_Influences__c in :contactMap.keySet() or Contact_Influenced__c in :contactMap.keySet()];
        
        
        List<Contact_Influence__c> contactInfluenceToInsert = new List<Contact_Influence__c>(); 
        for (ID firstId :contactInfluenceMap.keySet()) {
            for (Id secondId :contactInfluenceMap.get(firstId)) {
                contactInfluenceToInsert.add(new Contact_Influence__c(Contact_Influenced__c = firstId, Contact_Influences__c = secondId));
            }
        }
        
        insert contactInfluenceToInsert;
        update contatsToUpdate;             
    }
    
    public PageReference rerenderPageBlock() {
        return null;
    }

    global class JavascriptObject {
        public String value;
        public String parent;   
        public String influences;       
    }
    
 }