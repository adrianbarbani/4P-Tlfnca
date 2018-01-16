public class ExtendedEvaluation {

    public Contact_Assessment__c ContactEval {get;set;}
    public  List<Contact> ContactInfluenced;
    public  List<Contact> ContactInfluences;
    private List<Acciones__c> AllActions;
    
    public ExtendedEvaluation(){
        this.ContactEval = [SELECT  Id, Contact__c, Contact__r.name, Contact__r.Account.name,
                           Contact__r.Closest_Account_Team_Member__r.name, Focus__c , Attitudes__c,
                           Our_Relationship__c, Competing_Company_Relationship__c, Buying_Cycle__c ,
                           Generation__c, Authority__c, Influence__c, Opportunity__c,
                           Opportunity__r.Buying_Cycle__c   FROM Contact_Assessment__c
                           WHERE id = :ApexPages.currentPage().getParameters().get('id')];

        this.AllActions = [SELECT Descripcion__c, Accion__c, Tipo__c  FROM Acciones__c];   
        //List<Contact> AllContcts = [SELECT Id, Name  FROM Contact];

        //load(ContactEval.Contact__c,AllContcts);
        load(ContactEval.Contact__c,null);
                
    }
    
    public ExtendedEvaluation(Contact_Assessment__c CA,List<Acciones__c> AllActions, List<Contact> ContactInfluenced, List<Contact> ContactInfluences){
        this.ContactEval = CA;
        
        this.AllActions = AllActions;

        this.ContactInfluenced = ContactInfluenced;
        
        this.ContactInfluences = ContactInfluences;
        
    }
    
    public ExtendedEvaluation(Contact_Assessment__c CA,List<Contact> AllContcts,List<Acciones__c> AllActions){
        this.ContactEval = CA;
        
        this.AllActions = AllActions;

        load(this.ContactEval.Contact__c,AllContcts);
        
    }     
    
    public Contact_Assessment__c getContactEval() {
        
        return ContactEval;
    }

    private void load(String id,List<Contact> AllContcts){
    
            
        ContactInfluenced = new List<Contact>();
        
        List<Id> contactInfluencedIds = new List<Id>(); 
            
        for( Contact_Influence__c ci: [ SELECT Contact_Influenced__c, Contact_Influences__c FROM Contact_Influence__c 
                                      WHERE Contact_Influences__c = :id]){
           /*                           
           for( Contact c: AllContcts){
           
               if(c.id == ci.Contact_Influenced__c){
                   ContactInfluenced.add(c);
                   break;
               }   
           }                       
           */
                                      
           //ContactInfluenced.add([SELECT Id, Name  FROM Contact WHERE Id = :ci.Contact_Influenced__c]);
           contactInfluencedIds.add(ci.Contact_Influenced__c);                           
        }
        ContactInfluenced.addAll([SELECT Id, Name  FROM Contact WHERE Id in :contactInfluencedIds]);
        
        
        ContactInfluences = new List<Contact>();
        
        List<Id> contactInfluencesIds = new List<Id>();
            
        for( Contact_Influence__c ci: [ SELECT Contact_Influenced__c, Contact_Influences__c FROM Contact_Influence__c 
                                      WHERE Contact_Influenced__c = :id]){
           /*                           
           for( Contact c: AllContcts){
           
               if(c.id == ci.Contact_Influences__c){
                   ContactInfluences.add(c);
                   break;
               }   
           } 
           */   
           //ContactInfluences.add([SELECT Id, Name  FROM Contact WHERE Id = :ci.Contact_Influences__c]);
           contactInfluencesIds.add(ci.Contact_Influences__c);                           
        }
        ContactInfluences.addAll([SELECT Id, Name  FROM Contact WHERE Id in :contactInfluencesIds]);
    }    
    
    public List<String> getAcciones(){
        List<String> temp = new List<String>();
        temp.add('Focus: ' + ContactEval.Focus__c);
        
        //Agrego las acciones que tengo que hacer para este tipo de rol.
        
        this.getActions('Focus',ContactEval.Focus__c,temp);
        
        /*for (Acciones__c a : [SELECT Descripcion__c  FROM Acciones__c
                WHERE Accion__c = 'Focus' AND Tipo__c = :ContactEval.Focus__c ]){ 
             
             temp.add(a.Descripcion__c);       
        }*/ 
        
        temp.add('Attitudes: ' + ContactEval.Attitudes__c);
        
        //Agrego las acciones que tengo que hacer para este tipo de actitud.
        this.getActions('Attitudes',ContactEval.Attitudes__c,temp);
        
        /*for (Acciones__c a : [SELECT Descripcion__c  FROM Acciones__c 
                WHERE Accion__c = 'Attitudes' AND Tipo__c = :ContactEval.Attitudes__c ]){ //this.getActions('Attitudes',ContactEval.Attitudes__c)){  //
             
             temp.add(a.Descripcion__c);       
        }*/ 
        
        temp.add('Influence: ' + ContactEval.Influence__c);
        temp.add('Authority: ' + ContactEval.Authority__c);
        
        String tmpstr;
        
        if(ContactEval.Authority__c == 'High')
            tmpstr = 'A+';
        else
            tmpstr = 'A-';
            
        if(ContactEval.Influence__c == 'High')
            tmpstr += ' I+';
        else
            tmpstr += ' I-';
            
        //Agrego las acciones que tengo que hacer para este tipo de autroidad.
        this.getActions('Authority',tmpstr,temp);    
        
        /*for (Acciones__c a : [SELECT Descripcion__c  FROM Acciones__c
                WHERE Accion__c = 'Autoridad' AND Tipo__c = :tmpstr ]){ //){ 
             
             temp.add(a.Descripcion__c);       
        }*/ 
        temp.add('Our relationship with the contact: ' + ContactEval.Our_Relationship__c);
        temp.add('Our competion\'s relationship with the contact: ' + ContactEval.Competing_Company_Relationship__c);

        
        temp.add('Final Relationship Leverage: ' + this.getRelationship());
            
        //Agrego las acciones que tengo que hacer para este tipo de relacionamiento.
        this.getActions('Relationship Leverage',this.getRelationship(),temp);
        /*for (Acciones__c a :  [SELECT Descripcion__c  FROM Acciones__c 
                WHERE Accion__c = 'Relationship Leverage' AND Tipo__c = :this.getRelationship() ]){//){
                
             temp.add(a.Descripcion__c);       
        }*/ 
        
        
        temp.add('Project buying cycle: ' + ContactEval.Opportunity__r.Buying_Cycle__c);
        temp.add('Contact buying cycle: ' + ContactEval.Buying_Cycle__c);
        
        if(ContactEval.Opportunity__r.Buying_Cycle__c != ContactEval.Buying_Cycle__c)
            
            temp.add('Attention buying cycles of the project and the contact are diferent.');

        
        
        
        return temp;
    }
    
    public String getActionsFocus(){
    
        String ret = '';
        List<String> temp = new List<String>();
        
        this.getActions('Focus',ContactEval.Focus__c,temp);
    
    
        for(String s : temp)
            ret = ret + s + '<br/>';
            
        return ret;
    }
    
    
    public String getActionsAttitudes(){
    
        String ret = '';
        List<String> temp = new List<String>();
        
        this.getActions('Attitudes',ContactEval.Attitudes__c,temp);
    
    
        for(String s : temp)
            ret = ret + s + '<br/>';
            
        return ret;
    }
    
    public String getRelationship(){
    
        //Calculate relationship from relationship matrix. TODO: add more types of positive/negative realtionship depending if ++ + 0 - --
    
        if( 
            ((ContactEval.Our_Relationship__c == 'Positive' ) && ( ContactEval.Competing_Company_Relationship__c == 'Neutral' ||  ContactEval.Competing_Company_Relationship__c == 'Negative')) ||
            ((ContactEval.Our_Relationship__c == 'Neutral'  ) && (ContactEval.Competing_Company_Relationship__c == 'Negative'))
            
          )
            return 'Positive';
        
        if( 
            ((ContactEval.Our_Relationship__c == 'Negative' ) && ( ContactEval.Competing_Company_Relationship__c == 'Neutral' ||  ContactEval.Competing_Company_Relationship__c == 'Positive')) ||
            ((ContactEval.Our_Relationship__c == 'Neutral'  ) && (ContactEval.Competing_Company_Relationship__c == 'Positive'))
            
          )
            return 'Negative';

        
            return 'Neutral';
    
    
    }
    
    public void getActions(String Accion, String Tipo, List<String> l){
        
        
        
         for( Acciones__c a: AllActions){
           
               if((a.Accion__c == Accion) && (a.Tipo__c == Tipo)){
                   l.add(a.Descripcion__c);
               }   
           }           
        
    } 

    public List<Contact> getContactInfluenced(){
        return ContactInfluenced;
    }
    public List<Contact> getContactInfluences(){
        return ContactInfluences;
    }

}