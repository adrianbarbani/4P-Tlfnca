public class adminRegions {

    public List<ShareWrapper> todos {get;set;}
    public Region__Share newRS {get;set;}
    
    public String seleccionado { get; set; }
    
    public String parent_s { get; set; }
    public String user_s { get; set; }
    public Account dummyAccount { get; set; }
    
    public adminRegions(){
    
        load();
    }
    
    public void load(){
        
        newRS = new Region__Share();
        todos = new List<ShareWrapper>();
        parent_s='0';
        user_s='0';
        dummyAccount = new Account();
        
        List<Region__Share> temp = [select Id, ParentId, Parent.name, UserOrGroupId, AccessLevel, RowCause, LastModifiedDate, LastModifiedById, IsDeleted from Region__Share WHERE AccessLevel = 'Edit'  ORDER BY Parent.name];
        List<User> tempuser = [select Id, Username, LastName, FirstName, Email,  UserRoleId, LocaleSidKey, ProfileId from User];
        
        for(Region__Share t : temp)
            for(User tu : tempuser)
                if(t.UserOrGroupId == tu.id){
                    todos.add(new ShareWrapper(t,tu));
                    break;
                }
    }
    
    public List<SelectOption> getRegions(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('0','Select Region'));
    
        List<Region__c> temp =  [SELECT Name,Id From Region__c ORDER BY Name ASC];
        
       for( Region__c c : temp)
       {
          options.add(new SelectOption(c.Id,c.Name));
       }  
       return options;
        
    }
    /*
    public List<SelectOption> getUsers(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('0','Select User'));
        
        //Lista de usuarios hardcodeada al profile de mkting admin, escribano y administrador de todo... (cambiar si se cambia de entorno)
        //List<User> temp =  [SELECT Name,Id From USER WHERE ProfileId = '00eD0000001PePDIA0' OR ProfileId = '00eD0000001PeOeIAK' OR ProfileId = '00eD0000001n2SHIAY' ORDER BY Name];
        //00eb0000000UX0N
        List<User> temp =  [SELECT Name,Id From USER ORDER BY Name];
        
       for( User c : temp) {
          options.add(new SelectOption(c.Id,c.Name));
       }  
       return options;
        
    }
    */
    public PageReference del(){
    
    system.debug(todos);
    system.debug(Apexpages.currentPage().getParameters().get('IdtoDelete'));
    system.debug(seleccionado);
    
        delete  [ SELECT id FROM Region__Share WHERE Id = :seleccionado];
        load();
        return null;       
    }
    
    public PageReference InsertNew() {
        
        user_s = dummyAccount.ownerId;
        if(user_s!='0' && parent_s!='0'){
            //valido que la region y usuario sean legitimos.
            List<User> tempuser = [select id from User where id = :user_s];
            List<Region__C> tempregion = [select id, OwnerId from Region__C where id = :parent_s];
            
            if(tempuser.size() == 0 || tempregion.size()  == 0)
                return null;
                        
            if (tempregion.get(0).OwnerId != user_s) {
                newRS.AccessLevel = 'Edit';
                newRS.UserOrGroupId=user_s;
                newRS.ParentId=parent_s;            
                insert newRS;                    
                load();
            } else {                                                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,System.Label.share_region_to_owner));
            }                       
        }        
        return null;
    }
    
    public class ShareWrapper{
        public Region__Share share {get;set;}
        public User user {get;set;}
    
        public ShareWrapper(Region__Share rs, User u){
        
            this.share = rs;
            this.user = u;
        }
    
    }
}