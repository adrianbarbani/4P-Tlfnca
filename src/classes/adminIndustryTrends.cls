public class adminIndustryTrends {
    public String title { get; set; }

    public String regionId { get; set;}

    public String industry { get; set; }

    public String sector { get; set; }
    
    public Region__c region { get; set;} 
    
    public List<Industry_Trend__c> trends;
    
    public Industry_Trend__c newTrend { get; set; }
    
    public String IdtoDel {get; set;}

    public Boolean canEdit {get;set;}
    
    public Account tempAccount{get;set;}
    
    public List<String> erroresDeCarga {get; set;}
    
    public List<String> updateErrors {get; set;}
    
    
    public adminIndustryTrends(){
    	
        updateErrors = new List<String>();
        erroresDeCarga = new List<String>();
        trends = new List<Industry_Trend__c>();
        title = 'Choose a Region and Industry to start';
        tempAccount = new Account();
    }

    public List<Industry_Trend__c> getTrends(){
        return trends;
    }
    
    public List<SelectOption> getRegions(){
        List<SelectOption> options = new List<SelectOption>();
        
        
        List<Region__c> temp =  [SELECT Name,Id From Region__c ORDER BY id ASC];
        
        for( Region__c c : temp)
        {
            options.add(new SelectOption(c.Id,c.Name));
        }  
        return options;
        
    }
    
    public List<SelectOption> getSectors(){
        List<SelectOption> options = new List<SelectOption>();

            
       Schema.DescribeFieldResult fieldResult = Account.Sector__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
        
    }
    
    public List<SelectOption> getIndustries(){
      List<SelectOption> options = new List<SelectOption>();
            
       Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          options.add(new SelectOption(f.getLabel(), f.getValue()));
       }       
       return options;
    }
    
    public PageReference save(){ 	
        
        updateErrors = new List<String>();
        
        system.debug(trends);
		
        List<id> idsReletedTrend = new List<id>();
        for(Industry_Trend__c atrend:trends){
            idsReletedTrend.add(atrend.RelatedTo__c);
        }
        
 		List<Industry_Trend__c> relatedToTrends = [SELECT ID, Type__c FROM Industry_Trend__c WHERE ID IN:  idsReletedTrend ];
        
        Map <id,Industry_Trend__c> reletedTo = new Map<id,Industry_Trend__c>();
        for(Industry_Trend__c trend:relatedToTrends){
            reletedTo.put(trend.id,trend);
        }
            
        for(Industry_Trend__c newTrend :trends){
            
            //validacion Relacionado con
            
            if( (newTrend.Type__c == 'Soluciones') || (newTrend.Type__c == 'Oportunidad Sectorial') ){
                
                system.debug(newTrend);
                if(newTrend.RelatedTo__c == null){
                    updateErrors.add('ID '+newTrend.name+': '+Label.Error_adminIndustryTrends_relacion);}
                else{
                    
                    if(newTrend.Type__c == 'Soluciones' ){
                        if(reletedTo.get(newTrend.RelatedTo__c).Type__c != 'Oportunidad Sectorial'){
                            updateErrors.add('ID '+newTrend.name+': '+Label.Error_adminIndustryTrends_solucionConOportunidad);                    
                        }
                    }
                    
                    if(newTrend.Type__c == 'Oportunidad Sectorial' ){
                        if(reletedTo.get(newTrend.RelatedTo__c).Type__c != 'Principales necesidades'){
                            updateErrors.add('ID '+newTrend.name+': '+Label.Error_adminIndustryTrends_OportunidadConNecesidad);                    
                        }
                    }
                }
            }
            
            //validacion tipo
            if(newTrend.Type__c == null){
                updateErrors.add('ID '+newTrend.name+': '+Label.Error_adminIndustryTrends_tipoValorObligatorio);  
            }
            
        }
        
        if(updateErrors.size() == 0){
            Update trends;
        }
        
        system.debug(updateErrors);
        return null;
    }
    
    public void doUpdate(){
    
        region = [SELECT Id, Name, OwnerId FROM Region__c WHERE Id = :regionId];
        
        List<Region__Share> tempedit = [select Id from Region__Share WHERE AccessLevel = 'Edit' AND ParentId =:regionId AND UserOrGroupId =:UserInfo.getUserId()];
        
        if(tempedit.size() > 0 || region.OwnerId == UserInfo.getUserId())
            canEdit = true;
        else
            canEdit = false;
            
       
       	if (tempAccount.Industry == 'Todos') {
        	tempAccount.Micro_Industry__c = 'Todos';
        } else if ( tempAccount.Industry == 'All') {
        	tempAccount.Micro_Industry__c = 'All';
        }
       	
       
        trends = [SELECT RelatedTo__r.Type__c, Trend__c,Name, URL_Attachment__c, title__c, type__c, relatedTo__c FROM Industry_Trend__c WHERE Region__c = :regionId AND Industry__c = :tempAccount.Micro_Industry__c AND /*Sector__C = :tempAccount.Sector__c AND*/ Sub_Sector__c = :tempAccount.Industry ORDER BY Name ASC];
        //trends = [SELECT Trend__c,Name, URL_Attachment__c FROM Industry_Trend__c WHERE Region__c = :regionId AND Sector__C = :tempAccount.Sector__c AND Sub_Sector__c = :tempAccount.Industry ORDER BY Name ASC];
        
        newTrend = new Industry_Trend__c();
        newTrend.Region__c = regionId;
        newTrend.Industry__c = tempAccount.Micro_Industry__c;
        newTrend.Sub_Sector__c = tempAccount.Industry;
        /*newTrend.Sector__C = tempAccount.Sector__c;*/
        title = region.Name + ' > '+tempAccount.Industry+' > '  + tempAccount.Micro_Industry__c;
                
        if(tempAccount.Micro_Industry__c == '' || tempAccount.Industry == '' || 
           tempAccount.Micro_Industry__c == '--None--' || tempAccount.Industry == '--None--' || 
           tempAccount.Micro_Industry__c == null || tempAccount.Industry == null){
            tempAccount.Industry=null;
            canEdit = false;
            title = 'Debe seleccionar un Sector y un Subsector';
        }
    
    }

    public PageReference InsertNewTrend() {
        
        erroresDeCarga = new List<String>();
                
        if(newTrend != null){
            system.debug(newTrend);
            //validacion Relacionado con
            if( (newTrend.Type__c == 'Soluciones') || (newTrend.Type__c == 'Oportunidad Sectorial') ){
                
                
                if(newTrend.RelatedTo__c == null){
                    erroresDeCarga.add(Label.Error_adminIndustryTrends_relacion);}
                else{
                    
                    Industry_Trend__c relatedTrend = [SELECT id, Type__c FROM Industry_Trend__c WHERE ID =:newTrend.RelatedTo__c];
                    
                    if(newTrend.Type__c == 'Soluciones' ){
                        if(relatedTrend.Type__c != 'Oportunidad Sectorial'){
                            erroresDeCarga.add(Label.Error_adminIndustryTrends_solucionConOportunidad);                    
                        }
                    }
                    
                    if(newTrend.Type__c == 'Oportunidad Sectorial' ){
                        if(relatedTrend.Type__c != 'Principales necesidades'){
                            erroresDeCarga.add(Label.Error_adminIndustryTrends_OportunidadConNecesidad);                    
                        }
                    }
                }
            }
                        
            //validacion tipo
            if(newTrend.Type__c == null){
              erroresDeCarga.add(Label.Error_adminIndustryTrends_tipoValorObligatorio);  
            }
            
            // si no hay errores creo la nueva trend.
            if(erroresDeCarga.size() == 0){
                insert newTrend;
                this.doUpdate();
            }
               

        }
        
        system.debug(erroresDeCarga);
        return null;
    }

    public PageReference del(){
    

        this.IdtoDel = Apexpages.currentPage().getParameters().get('IdtoDelete');  
    
        Industry_Trend__c toDel= [ SELECT id FROM Industry_Trend__c WHERE Id = :this.IdtoDel];
        
        delete toDel;
        
        doUpdate();
        
        return null;       
    }

    public String getHashIndustry(){
        if(tempAccount.Micro_Industry__c !=null)
            return tempAccount.Micro_Industry__c.replaceAll('[^a-zA-Z]', '');
        else
            return '*';
    }

    public Boolean getHayErroresDeCarga(){
		
        boolean flag;
        
        if(erroresDeCarga.size()>0 ){flag = true;}else{flag = false;}
                            
        return flag; 
    }

    public PageReference cleanErrors(){
        erroresDeCarga = new List<String>();
        return null;
    }    


}